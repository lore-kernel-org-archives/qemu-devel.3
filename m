Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5E1C54F56
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonjW-0000vL-KH; Tue, 28 Jul 2026 15:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wonjU-0000tW-AD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:44:56 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wonjS-0005l4-6r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:44:56 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wonjA-00000001Tds-42i9; Tue, 28 Jul 2026 21:44:36 +0200
Message-ID: <6c472c83-7334-4f50-bc68-627b452d8287@maciej.szmigiero.name>
Date: Tue, 28 Jul 2026 21:44:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/vfio: Fix liveness check in
 vfio_connect_kvm_msi_virq()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Tycho Andersen <tycho@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20260727150038.2684512-1-tycho@kernel.org>
 <093da848-d6f9-4d88-a317-6acfac2724bf@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <093da848-d6f9-4d88-a317-6acfac2724bf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27.07.2026 17:27, Cédric Le Goater wrote:
> + CPR maintainers,
> 
> On 7/27/26 17:00, Tycho Andersen wrote:
>> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
>>
>> While working on savevm/loadvm for a new vfio device, I encountered the
>> crash below. Since vfio_connect_kvm_msi_virq() didn't check the ->use flag
>> for the vector, it would pass an unused vector down to
>> vfio_cpr_load_vector_fd() which would crash.
>>
>> Fix this by checking the ->use flag along with the virq number to detect
>> whether a vector is valid or not.
>>
>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555a891ef in vfio_cpr_load_vector_fd (vdev=vdev@entry=0x0,
>>      name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1) at ../hw/vfio/cpr.c:44
>> 44        g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> (gdb) bt
>> #0  0x0000555555a891ef in vfio_cpr_load_vector_fd
>>      (vdev=vdev@entry=0x0, name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1)
>>      at ../hw/vfio/cpr.c:44
>> #1  0x0000555555ce64a1 in vfio_notifier_init
>>      (vdev=0x0, e=e@entry=0x5555586971b4, name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1, errp=errp@entry=0x0) at ../hw/vfio/pci.c:79
>> #2  0x0000555555ce721e in vfio_connect_kvm_msi_virq (vector=0x5555586971a8, nr=nr@entry=1)
>>      at ../hw/vfio/pci.c:601
>> #3  0x0000555555cea5a5 in vfio_connect_kvm_msi_virq (nr=1, vector=<optimized out>)
>>      at ../hw/vfio/pci.c:597
>> #4  vfio_pci_commit_kvm_msi_virq_batch (vdev=0x55555906de40) at ../hw/vfio/pci.c:822
>> #5  0x0000555555cea9f2 in vfio_msix_enable (vdev=vdev@entry=0x55555906de40) at ../hw/vfio/pci.c:850
>> #6  0x0000555555ceb152 in vfio_pci_load_config (vbasedev=0x55555906e900, f=<optimized out>)
>>      at ../hw/vfio/pci.c:3088
>> #7  0x0000555555a8c765 in vfio_load_device_config_state (f=0x5555574a43d0, opaque=0x55555906e900)
>>      at ../hw/vfio/migration.c:278
>> #8  0x0000555555b3a522 in vmstate_load
>>      (f=f@entry=0x5555574a43d0, se=se@entry=0x5555591edd40, errp=errp@entry=0x7fffffffe130)
>>      at ../migration/savevm.c:971
>> #9  0x0000555555b3ab1a in qemu_loadvm_section_start_full
>>      (f=f@entry=0x5555574a43d0, type=type@entry=4 '\004', errp=errp@entry=0x7fffffffe130)
>>      at ../migration/savevm.c:2654
>> #10 0x0000555555b3e1ee in qemu_loadvm_state_main
>>      (f=f@entry=0x5555574a43d0, mis=mis@entry=0x5555571de5a0, errp=0x7fffffffe130,
>>      errp@entry=0x555557157c10 <error_fatal>) at ../migration/savevm.c:2973
>> #11 0x0000555555b3f7b7 in qemu_loadvm_state
>>      (f=f@entry=0x5555574a43d0, errp=errp@entry=0x555557157c10 <error_fatal>)
>>      at ../migration/savevm.c:3058
>> #12 0x0000555555b40863 in load_snapshot
>>      (name=0x7fffffffecc9 "foo", vmstate=vmstate@entry=0x0, has_devices=has_devices@entry=false, devices=devices@entry=0x0, errp=errp@entry=0x555557157c10 <error_fatal>) at ../migration/savevm.c:3452
>> #13 0x0000555555adc211 in qmp_x_exit_preconfig (errp=0x555557157c10 <error_fatal>) at ../system/vl.c:2817
>> #14 qmp_x_exit_preconfig (errp=0x555557157c10 <error_fatal>) at ../system/vl.c:2802
>> #15 0x0000555555adf8ed in qemu_init (argc=<optimized out>, argv=<optimized out>) at ../system/vl.c:3849
>> #16 0x00005555558903fd in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:71
>>
>> Fixes: 30edcb4d4e7a ("vfio-pci: preserve MSI")
>> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
>> ---
>> An alternative implementation of this would be to set ->virq = -1 after
>> the allocation in vfio_msix_enable(), but since other locations that
>> checks ->virq >= 0 also check ->use, I added it here too. Maybe it would
>> be useful to do both.
>> ---
>>   hw/vfio/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 380dd8c15f..b5280c3d2a 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -589,7 +589,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
>>   {
>>       const char *name = "kvm_interrupt";
>> -    if (vector->virq < 0) {
>> +    if (!vector->use || vector->virq < 0) {
>>           return;
>>       }
>>
>> base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> 
> 
> Looks ok to me.

Looks ok to me from the CPR side too, so:
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR

Thanks,
Maciej


