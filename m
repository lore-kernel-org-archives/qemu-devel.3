Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F11CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6tV-0000zc-L7; Wed, 29 Oct 2025 10:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE6tT-0000zE-RN; Wed, 29 Oct 2025 10:11:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vE6tH-0006gJ-Pp; Wed, 29 Oct 2025 10:11:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5FF4B164062;
 Wed, 29 Oct 2025 17:10:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC685308661;
 Wed, 29 Oct 2025 17:10:55 +0300 (MSK)
Message-ID: <d224e9ff-4a4d-4c53-8875-eb05b3b51768@tls.msk.ru>
Date: Wed, 29 Oct 2025 17:10:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 33/75] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, peng guo <engguopeng@buaa.edu.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <cover.1759691708.git.mst@redhat.com>
 <d1193481dee63442fc41e47ca6ebc4cd34f1f69c.1759691708.git.mst@redhat.com>
 <26067051-421d-44ed-9c7e-13ed0bdac18b@tls.msk.ru>
 <949000e9-ac59-4bc9-ad00-861c3a9a08c9@tls.msk.ru>
 <20251029110113.000028ca@huawei.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20251029110113.000028ca@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

29.10.2025 14:01, Jonathan Cameron via пишет:
> On Tue, 28 Oct 2025 22:26:12 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
>> On 10/6/25 20:08, Michael Tokarev wrote:
>>> On 10/5/25 22:17, Michael S. Tsirkin wrote:
>>>> From: peng guo <engguopeng@buaa.edu.cn>
>>>>
>>>> When using a CXL Type 3 device together with a virtio 9p device in
>>>> QEMU on a
>>>> physical server, the 9p device fails to initialize properly. The
>>>> kernel reports
>>>> the following error:
>>>>
>>>>       virtio: device uses modern interface but does not have
>>>> VIRTIO_F_VERSION_1
>>>>       9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with
>>>> error -22
>>>>
>>>> Further investigation revealed that the 64-bit BAR space assigned to
>>>> the 9pnet
>>>> device was overlapped by the memory window allocated for the CXL
>>>> devices. As a
>>>> result, the kernel could not correctly access the BAR region, causing the
>>>> virtio device to malfunction.
>>>>
>>>> An excerpt from /proc/iomem shows:
>>>>
>>>>       480010000-cffffffff : CXL Window 0
>>>>         480010000-4bfffffff : PCI Bus 0000:00
>>>>         4c0000000-4c01fffff : PCI Bus 0000:0c
>>>>           4c0000000-4c01fffff : PCI Bus 0000:0d
>>>>         4c0200000-cffffffff : PCI Bus 0000:00
>>>>           4c0200000-4c0203fff : 0000:00:03.0
>>>>             4c0200000-4c0203fff : virtio-pci-modern
>>>>
>>>> To address this issue, this patch adds the reserved memory end
>>>> calculation
>>>> for cxl devices to reserve sufficient address space and ensure that
>>>> CXL memory
>>>> windows are allocated beyond all PCI 64-bit BARs. This prevents
>>>> overlap with
>>>> 64-bit BARs regions such as those used by virtio or other pcie devices,
>>>> resolving the conflict.
>>>>
>>>> QEMU Build Configuration:
>>>>
>>>>       ./configure --prefix=/home/work/qemu_master/build/ \
>>>>                   --target-list=x86_64-softmmu \
>>>>                   --enable-kvm \
>>>>                   --enable-virtfs
>>>>
>>>> QEMU Boot Command:
>>>>
>>>>       sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
>>>>           -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
>>>>           -hda /home/work/gp_qemu/rootfs.img \
>>>>           -virtfs local,path=/home/work/gp_qemu/
>>>> share,mount_tag=host0,security_model=passthrough,id=host0 \
>>>>           -kernel /home/work/linux_output/arch/x86/boot/bzImage \
>>>>           --append "console=ttyS0 crashkernel=256M root=/dev/sda
>>>> rootfstype=ext4 rw loglevel=8" \
>>>>           -object memory-backend-ram,id=vmem0,share=on,size=4096M \
>>>>           -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>>>           -device cxl-
>>>> rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>>>>           -device cxl-type3,bus=root_port13,volatile-
>>>> memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
>>>>           -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
>>>>
>>>> Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a
>>>> machine parameter")
>>>> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Message-ID: <20250805142300.15226-1-engguopeng@buaa.edu.cn>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>    hw/i386/pc.c | 20 +++++++++++---------
>>>>    1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> Hi!
>>>
>>> Is it qemu-stable material (10.0.x & 10.1.x)?
> 
> I think it does make sense for stable.

Aha.  I remember now why I had this question to begin with.

If it should be applied to 10.0.x series too (which is an LTS series),
I need help back-porting it before commit 8b1c560937467d0d9
"hw/i386/pc: Remove PCMachineClass::broken_reserved_end field"
which touches the same code.

If it's worth the effort to begin with.

Meanwhile I picked it up for 10.1.x.

Thank you!

/mjt

