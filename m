Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337CAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 08:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM19i-0003iF-6q; Fri, 13 Dec 2024 03:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1tM19f-0003hh-J9; Fri, 13 Dec 2024 03:36:11 -0500
Received: from smtpnm6-08.21cn.com ([182.42.159.130] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>)
 id 1tM19c-0000B2-2z; Fri, 13 Dec 2024 03:36:11 -0500
HMM_SOURCE_IP: 192.168.138.117:0.1271736696
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.238 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 0D66590416F1;
 Fri, 13 Dec 2024 16:26:43 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([10.133.8.238])
 by gateway-ssl-dep-54575cc94d-f6h42 with ESMTP id
 97795d0a3c8945c78ef14e0d0d684af6 for eblake@redhat.com; 
 Fri, 13 Dec 2024 16:26:47 CST
X-Transaction-ID: 97795d0a3c8945c78ef14e0d0d684af6
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 10.133.8.238
X-MEDUSA-Status: 0
Message-ID: <c2c61c46-6d71-4f1b-b3dd-12e8db40e3be@chinatelecom.cn>
Date: Fri, 13 Dec 2024 16:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] support block encryption/decryption in parallel
To: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
References: <cover.1732789721.git.tugy@chinatelecom.cn>
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <cover.1732789721.git.tugy@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.159.130; envelope-from=tugy@chinatelecom.cn;
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

Hi Kevin and Hanna, could you share your thoughts on this patch?

I’d greatly appreciate your feedback

--
Guoyi

On 2024/11/28 18:51, tugy@chinatelecom.cn wrote:
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
> driver=luks,key-secret=sec,encrypt-in-parallel=on,file.filename=/home/tgy/data.luks
> 
>      real    1m43.101s
>      user    10m30.239s
>      sys     13m13.758s
> 
> Guoyi Tu (2):
>    crpyto: support encryt and decrypt parallelly using thread pool
>    qapi/crypto: support enable encryption/decryption in parallel
> 
>   block/crypto.c       | 111 ++++++++++++++++++++++++++++++++++++++++---
>   block/crypto.h       |   9 ++++
>   qapi/block-core.json |   6 ++-
>   qapi/crypto.json     |   6 ++-
>   4 files changed, 124 insertions(+), 8 deletions(-)
> 


