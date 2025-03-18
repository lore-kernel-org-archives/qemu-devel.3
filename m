Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44818C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuUx1-0001q1-MO; Tue, 18 Mar 2025 07:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1tuUwy-0001or-JL; Tue, 18 Mar 2025 07:17:36 -0400
Received: from smtpnm6-06.21cn.com ([182.42.144.170] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>)
 id 1tuUwt-0000Jc-QW; Tue, 18 Mar 2025 07:17:36 -0400
HMM_SOURCE_IP: 192.168.137.232:0.860077192
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.137.232])
 by chinatelecom.cn (HERMES) with SMTP id 6B4F4E34B1;
 Tue, 18 Mar 2025 19:17:11 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-84dfd8c7d7-bsrdr with ESMTP id
 fb0601d888284e4691184db18ff4ba12 for eblake@redhat.com; 
 Tue, 18 Mar 2025 19:17:15 CST
X-Transaction-ID: fb0601d888284e4691184db18ff4ba12
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <2a3489a1-3955-4fd3-9133-f8dcd0e57416@chinatelecom.cn>
Date: Tue, 18 Mar 2025 19:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] support block encryption/decryption in parallel
To: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, qemu-block@nongnu.org
References: <cover.1737384527.git.tugy@chinatelecom.cn>
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <cover.1737384527.git.tugy@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.144.170; envelope-from=tugy@chinatelecom.cn;
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

Hi there,

Would you have any feedback on this patch? Any suggestions would be 
greatly appreciated.”

--
Guoyi

On 2025/1/20 22:58, tugy@chinatelecom.cn wrote:
> From: Guoyi Tu <tugy@chinatelecom.cn>
> 
> Currently, disk I/O encryption and decryption operations are performed sequentially
> in the main thread or IOthread. When the number of I/O requests increases,
> this becomes a performance bottleneck.
> 
> To address this issue, this patch use thread pool to perform I/O encryption
> and decryption in parallel, improving overall efficiency.
> 
> Test results show that enabling the thread pool for encryption and decryption
> significantly improve the performance of virtual machine storage devices.
> 
> 
> Test Case1: Disk read/write performance using fio in a virtual machine
> 
> Virtual Machine： 8c16g, with a disk backing by a LUKS storage device and
>                    Ceph as storage backend.
> Test Method:
> fio -direct=1 -iodepth=32 -rw=xx -ioengine=libaio -bs=4k -size=10G -numjobs=x \
> -runtime=1000 -group_reporting -filename=/dev/vdb -name=xxx
> 
> Runing the VM on the Intel Xeon 5218 server, The test results are as follows:
> 
> |                        |  Serial encryption  | Thread pool encryption|
> |                        |  and decryption     | and decryption      |
> |        fio             |-----------|---------|-----------|---------|
> |                        | BW(MiB/s) | IOPS(K) | BW(MiB/s) | IOPS(K) |
> |------------------------|-----------|---------|-----------|---------|
> | rw=read numjobs=2      | 499       | 128     | 605       | 155     |
> | rw=read numjobs=4      | 529       | 136     | 632       | 162     |
> | rw=write numjobs=2     | 493       | 126     | 617       | 158     |
> | rw=write numjobs=4     | 534       | 137     | 743       | 190     |
> 
> 
> Runing the VM on the HiSilicon Kunpeng-920 server, The test results are as follows:
> 
> |                        |  Serial encryption  | Thread pool encryption|
> |                        |  and decryption     | and decryption      |
> |        fio             |-----------|---------|-----------|---------|
> |                        | BW(MiB/s) | IOPS(K) | BW(MiB/s) | IOPS(K) |
> |------------------------|-----------|---------|-----------|---------|
> | rw=read numjobs=2      | 73.2      | 18.8    | 128       | 39.2    |
> | rw=read numjobs=4      | 77.9      | 19.9    | 246       | 62.9    |
> | rw=write numjobs=2     | 78        | 19      | 140       | 35.8    |
> | rw=write numjobs=4     | 78        | 20.2    | 270       | 69.1    |
> 
> 
> Test Case 2：
> In addition, performance comparisons were also conducted on the HiSilicon Kunpeng-920
> server, testing the conversion of a qcow2 image to a LUKS image using qemu-img convert.
> The results show that using thread pool to encryption and decryption all significantly
> improve the performance.
> 
> Test Method: Create a 40GB qcow2 image and fill it with data, then convert it to a LUKS
>               image using qemu-img
> 
> * Serial encryption and decryption：
> time qemu-img convert -p -m 16 -W --image-opts file.filename=/home/tgy/data.qcow2 \
> --object secret,id=sec,data=password -n \
> --target-image-opts driver=luks,key-secret=sec,file.filename=/home/tgy/data.luks
> 
>      real    7m53.681s
>      user    7m52.595s
>      sys     0m11.248s
> 
> 
> * Thread pool encryption and decryption：
> time qemu-img convert -p -m 16 -W --image-opts file.filename=/home/tgy/data.qcow2 \
> --object secret,id=sec,data=password -n --target-image-opts \
> driver=luks,key-secret=sec,enable-parallel-crypto=on,file.filename=/home/tgy/data.luks
> 
>      real    1m43.101s
>      user    10m30.239s
>      sys     13m13.758s
> 
> v2: change parameter name from "encrypt-in-parallel" to "enable-parallel-crypto"
> 
> Guoyi Tu (2):
>    crpyto: support encryt and decrypt parallelly using thread pool
>    qapi/crypto: support enable encryption/decryption in parallel
> 
>   block/crypto.c       | 113 ++++++++++++++++++++++++++++++++++++++++---
>   block/crypto.h       |   9 ++++
>   qapi/block-core.json |   6 ++-
>   qapi/crypto.json     |   6 ++-
>   4 files changed, 126 insertions(+), 8 deletions(-)
> 


