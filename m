Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C8FD690FC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcIq-0000fU-M1; Thu, 28 Nov 2024 06:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1tGcIg-0000ds-Mx; Thu, 28 Nov 2024 06:03:12 -0500
Received: from smtpnm6-12.21cn.com ([182.42.119.59] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>)
 id 1tGcId-0003At-NW; Thu, 28 Nov 2024 06:03:10 -0500
HMM_SOURCE_IP: 192.168.137.232:0.1841577584
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-139.200.108.9 (unknown [192.168.137.232])
 by chinatelecom.cn (HERMES) with SMTP id 0C3DF110001B0;
 Thu, 28 Nov 2024 18:53:26 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([139.200.108.9])
 by gateway-ssl-dep-6977f57994-b9pvf with ESMTP id
 d068225b5b954a54a82bb5b1a8eb6052 for eblake@redhat.com; 
 Thu, 28 Nov 2024 18:53:30 CST
X-Transaction-ID: d068225b5b954a54a82bb5b1a8eb6052
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 139.200.108.9
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn
Subject: [PATCH 0/2] support block encryption/decryption in parallel
Date: Thu, 28 Nov 2024 18:51:20 +0800
Message-Id: <cover.1732789721.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.119.59; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Guoyi Tu <tugy@chinatelecom.cn>

Currently, disk I/O encryption and decryption operations are performed sequentially
in the main thread or IOthread. When the number of I/O requests increases,
this becomes a performance bottleneck.

To address this issue, this patch use thread pool to perform I/O encryption
and decryption in parallel, improving overall efficiency.

Test results show that enabling the thread pool for encryption and decryption
significantly improve the performance of virtual machine storage devices.


Test Case1: Disk read/write performance using fio in a virtual machine

Virtual Machine： 8c16g, with a disk backing by a LUKS storage device and
                  Ceph as storage backend.
Test Method:
fio -direct=1 -iodepth=32 -rw=xx -ioengine=libaio -bs=4k -size=10G -numjobs=x \
-runtime=1000 -group_reporting -filename=/dev/vdb -name=xxx

Runing the VM on the Intel Xeon 5218 server, The test results are as follows:

|                        |  Serial encryption  | Thread pool encryption|
|                        |  and decryption     | and decryption      |
|        fio             |-----------|---------|-----------|---------|
|                        | BW(MiB/s) | IOPS(K) | BW(MiB/s) | IOPS(K) |
|------------------------|-----------|---------|-----------|---------|
| rw=read numjobs=2      | 499       | 128     | 605       | 155     |
| rw=read numjobs=4      | 529       | 136     | 632       | 162     |
| rw=write numjobs=2     | 493       | 126     | 617       | 158     |
| rw=write numjobs=4     | 534       | 137     | 743       | 190     |


Runing the VM on the HiSilicon Kunpeng-920 server, The test results are as follows:

|                        |  Serial encryption  | Thread pool encryption|
|                        |  and decryption     | and decryption      |
|        fio             |-----------|---------|-----------|---------|
|                        | BW(MiB/s) | IOPS(K) | BW(MiB/s) | IOPS(K) |
|------------------------|-----------|---------|-----------|---------|
| rw=read numjobs=2      | 73.2      | 18.8    | 128       | 39.2    |
| rw=read numjobs=4      | 77.9      | 19.9    | 246       | 62.9    |
| rw=write numjobs=2     | 78        | 19      | 140       | 35.8    |
| rw=write numjobs=4     | 78        | 20.2    | 270       | 69.1    |


Test Case 2：
In addition, performance comparisons were also conducted on the HiSilicon Kunpeng-920
server, testing the conversion of a qcow2 image to a LUKS image using qemu-img convert.
The results show that using thread pool to encryption and decryption all significantly
improve the performance.

Test Method: Create a 40GB qcow2 image and fill it with data, then convert it to a LUKS
             image using qemu-img

* Serial encryption and decryption：
time qemu-img convert -p -m 16 -W --image-opts file.filename=/home/tgy/data.qcow2 \
--object secret,id=sec,data=password -n \
--target-image-opts driver=luks,key-secret=sec,file.filename=/home/tgy/data.luks

    real    7m53.681s
    user    7m52.595s
    sys     0m11.248s


* Thread pool encryption and decryption：
time qemu-img convert -p -m 16 -W --image-opts file.filename=/home/tgy/data.qcow2 \
--object secret,id=sec,data=password -n --target-image-opts \
driver=luks,key-secret=sec,encrypt-in-parallel=on,file.filename=/home/tgy/data.luks

    real    1m43.101s
    user    10m30.239s
    sys     13m13.758s

Guoyi Tu (2):
  crpyto: support encryt and decrypt parallelly using thread pool
  qapi/crypto: support enable encryption/decryption in parallel

 block/crypto.c       | 111 ++++++++++++++++++++++++++++++++++++++++---
 block/crypto.h       |   9 ++++
 qapi/block-core.json |   6 ++-
 qapi/crypto.json     |   6 ++-
 4 files changed, 124 insertions(+), 8 deletions(-)

-- 
2.17.1


