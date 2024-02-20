Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F7CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcN4m-0000d7-Re; Tue, 20 Feb 2024 05:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rcN4l-0000c5-ND
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:10:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rcN4h-0004qi-7h
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708423805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WviwbfnYiQKw83K3PlycIGYEYjHbaSnV2B+xO7//bO0=;
 b=fBsZI+mxfzn3TXBdzPqdcGJxRlj7PDuw4Xj5osCAgZ58cIJ7dwyZ+LQ5HvvVP4RMbYYlPT
 RM7eelg91RNsKYTSvJJTiUZD1BEM4bcAk0sCqP1i9s4n1TBF8f1ZBFdFVxV/Zac3duXgMo
 j+sZQuDbH4IgnAoX7GWsMddeepNt4F8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-dPlujTMmMMuSH4jdUZGuZA-1; Tue, 20 Feb 2024 05:10:03 -0500
X-MC-Unique: dPlujTMmMMuSH4jdUZGuZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFCA31065223;
 Tue, 20 Feb 2024 10:10:02 +0000 (UTC)
Received: from [10.39.195.16] (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFD241121306;
 Tue, 20 Feb 2024 10:10:00 +0000 (UTC)
Message-ID: <e0c25486-a369-f8d5-c9ce-5984083d475a@redhat.com>
Date: Tue, 20 Feb 2024 11:09:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/3] hw/isa/lpc_ich9: add broadcast SMI feature
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
References: <20170126014416.11211-1-lersek@redhat.com>
 <20170126014416.11211-3-lersek@redhat.com>
 <50ad98bf-cee9-44f7-bf4d-ada2a02e330b@linaro.org>
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <50ad98bf-cee9-44f7-bf4d-ada2a02e330b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/24 08:58, Philippe Mathieu-Daudé wrote:
> Hi Laszlo, Igor, Gerd,
> 
> (old patch, now commit 5ce45c7a2b)
> 
> On 26/1/17 02:44, Laszlo Ersek wrote:
>> The generic edk2 SMM infrastructure prefers
>> EFI_SMM_CONTROL2_PROTOCOL.Trigger() to inject an SMI on each
>> processor. If
>> Trigger() only brings the current processor into SMM, then edk2
>> handles it
>> in the following ways:
>>
>> (1) If Trigger() is executed by the BSP (which is guaranteed before
>>      ExitBootServices(), but is not necessarily true at runtime), then:
>>
>>      (a) If edk2 has been configured for "traditional" SMM
>> synchronization,
>>          then the BSP sends directed SMIs to the APs with APIC delivery,
>>          bringing them into SMM individually. Then the BSP runs the SMI
>>          handler / dispatcher.
>>
>>      (b) If edk2 has been configured for "relaxed" SMM synchronization,
>>          then the APs that are not already in SMM are not brought in, and
>>          the BSP runs the SMI handler / dispatcher.
>>
>> (2) If Trigger() is executed by an AP (which is possible after
>>      ExitBootServices(), and can be forced e.g. by "taskset -c 1
>>      efibootmgr"), then the AP in question brings in the BSP with a
>>      directed SMI, and the BSP runs the SMI handler / dispatcher.
>>
>> The smaller problem with (1a) and (2) is that the BSP and AP
>> synchronization is slow. For example, the "taskset -c 1 efibootmgr"
>> command from (2) can take more than 3 seconds to complete, because
>> efibootmgr accesses non-volatile UEFI variables intensively.
>>
>> The larger problem is that QEMU's current behavior diverges from the
>> behavior usually seen on physical hardware, and that keeps exposing
>> obscure corner cases, race conditions and other instabilities in edk2,
>> which generally expects / prefers a software SMI to affect all CPUs at
>> once.
>>
>> Therefore introduce the "broadcast SMI" feature that causes QEMU to
>> inject
>> the SMI on all VCPUs.
> 
> I'm trying to remove cpu_interrupt() API from hw/ and found this odd
> case.
> 
> IIUC, the code you added is closer to what real HW is doing:
> 
>   CPU_FOREACH(cs) { cpu_interrupt(cs, CPU_INTERRUPT_SMI); }
> 
> and previous implementation was bogus:
> 
>   cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> 
> but to avoid breaking older VMs ready to deal with bogus impl,
> you have to add a virtual (non-HW) ICH9_LPC_SMI_F_BROADCAST bit
> so new VMs can detect (negotiating) it and use normal expected
> HW behavior.
> 
> If so, and since this change was almost 7 years ago, can we
> expect that most of today's VMs use ICH9_LPC_SMI_F_BROADCAST_BIT,
> and would it be possible to deprecate it, so it become the only
> possibility, allowing us to remove this bogus call?
> 
>   cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);

For OVMF guests: yes, said deprecation should be safe.

Note however that the "current_cpu" case (the original case) had been in
place minimally for SeaBIOS. I don't know how exactly the deprecation /
removal in QEMU would work, but if you build SeaBIOS with
CONFIG_USE_SMM, it might still depend on the "current_cpu" branch.

FWIW, "roms/config.seabios-128k" and "roms/config.seabios-microvm" both
contain CONFIG_USE_SMM=n, so the deprecation likely wouldn't matter for
those SeaBIOS binaries (bundled with QEMU). But it could matter for
SeaBIOS binaries from other sources; plus "roms/config.seabios-256k"
does *not* contain a setting like that (and the SeaBIOS default is "y",
when building for QEMU).

For another data point: as far as I remember, we had disabled
CONFIG_USE_SMM in RHEL; there had been stability issues.

... I can't describe *all* the uses that SeaBIOS has for SMM. *One* use
is from commit 55215cd425d3 ("Implement call32 mechanism using SMIs.",
2014-10-15) -- "this allows SeaBIOS to transition to 32bit mode even
when called in vm86 mode". Because that commit modifies "stacks.c", I
think it must be related to the "cooperative multi-tasking system"
described here: <https://www.seabios.org/Execution_and_code_flow#Threads>.

I'm really rusty on this [*], but here's one potential symptom I can
theorize about: assuming you silently make broadcast SMI the default in
QEMU, and SeaBIOS raises an SMI (expecting it to only affect the BSP),
the SMI could become pending on all the APs (which would all be in RESET
state at that point [**]). And when Linux booted those APs with
INIT-SIPI-SIPI sequences, the pending SMIs could be delivered
immediately, and the APs would launch immediately into SMM. That would
likely not be expected.

[*] Using earlier edk2 commit cbccf995920a ("OvmfPkg/CpuHotplugSmm: fix
CPU hotplug race just after SMI broadcast", 2020-08-27) as cheat-sheet.
IIRC, I consulted the Intel SDM extensively back when I was working on
that patch.

[**] Hm... wait. It seems SeaBIOS does boot all APs in the system. The
APs apparently end up penned in a HLT-loop; see at the end of
"entry_smp" in "romlayout.S". In that case, the problem could be worse I
guess? The broadcast SMI could wake all APs from their halted states.
SeaBIOS doesn't seem to relocate SMBASE for the APs, so if multiple
processors start executing in SMM at the same time, the results are not
going to be stellar.

Laszlo

> 
>> While the original posting of this patch
>> <http://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05658.html>
>> only intended to speed up (2), based on our recent "stress testing" of
>> SMM
>> this patch actually provides functional improvements.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>
>> Notes:
>>      v7:
>>      - no changes, pick up Igor's R-b
>>           v6:
>>      - no changes, pick up Michael's R-b
>>           v5:
>>      - replace the ICH9_LPC_SMI_F_BROADCAST bit value with the
>>        ICH9_LPC_SMI_F_BROADCAST_BIT bit position (necessary for
>>        DEFINE_PROP_BIT() in the next patch)
>>
>>   include/hw/i386/ich9.h |  3 +++
>>   hw/isa/lpc_ich9.c      | 10 +++++++++-
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
>> index da1118727146..18dcca7ebcbf 100644
>> --- a/include/hw/i386/ich9.h
>> +++ b/include/hw/i386/ich9.h
>> @@ -250,4 +250,7 @@ Object *ich9_lpc_find(void);
>>   #define ICH9_SMB_HST_D1                         0x06
>>   #define ICH9_SMB_HOST_BLOCK_DB                  0x07
>>   +/* bit positions used in fw_cfg SMI feature negotiation */
>> +#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>> +
>>   #endif /* HW_ICH9_H */
>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>> index 376b7801a42c..ced6f803a4f2 100644
>> --- a/hw/isa/lpc_ich9.c
>> +++ b/hw/isa/lpc_ich9.c
>> @@ -437,7 +437,15 @@ static void ich9_apm_ctrl_changed(uint32_t val,
>> void *arg)
>>         /* SMI_EN = PMBASE + 30. SMI control and enable register */
>>       if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
>> -        cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>> +        if (lpc->smi_negotiated_features &
>> +            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
>> +            CPUState *cs;
>> +            CPU_FOREACH(cs) {
>> +                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>> +            }
>> +        } else {
>> +            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>> +        }
>>       }
>>   }
>>   
> 


