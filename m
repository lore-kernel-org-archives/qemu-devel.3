Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2802D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSs5l-0004Sw-Cx; Tue, 09 Dec 2025 02:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vSs5j-0004SW-8G
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:24:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vSs5e-0005fn-N3
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765265092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=J7yHUsd1wm5rDND9ZUlG4yAVsN0CXmboOkWlE3wKBp8=;
 b=edA+TDcPOpjOetetW5QG0xBmMrvjCuXWc/x+n6dmruyMWCJSHIhNaZDus+FiHQHFqVo+HX
 c2G6+Jtzdd7VkVQXPGBKe+ZIc5wIIr5Iy5s4eV7AUVlXUtx2LA6aE15to09V/j7tI7RbRr
 /EQVUtbJEQDpxTH11d/KhSveYbaqIjE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ZC5z4wElOceEDjoGLL_xdQ-1; Tue, 09 Dec 2025 02:24:51 -0500
X-MC-Unique: ZC5z4wElOceEDjoGLL_xdQ-1
X-Mimecast-MFC-AGG-ID: ZC5z4wElOceEDjoGLL_xdQ_1765265090
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so43729375e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765265090; x=1765869890; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J7yHUsd1wm5rDND9ZUlG4yAVsN0CXmboOkWlE3wKBp8=;
 b=FMigHV1Yar+nolM+UwhdSjuH+q1jD73yDSZi5y1PecMQHwXAgNpdCTk8Y3O5ngbe3k
 AZMDy+k+b5vJI32ZhCaBgQPB84YwD5pYxnQq7A+CS3YwqBWONnyiqI9I220gTol8oy6B
 9i6gGo4IvcTaFB6/atPh7NkdhcDZXyfzBnVuT3BkafmY1cTS8W7aO7A4JVPOLHEu+OaK
 qSQNhzxdp4aVPTX+HnpeFemaAWXnUVR04NlkiJMDlvpWSzsp7EE8rXJGRbfTl6HvXmn5
 F1BCcC5SfUWS2ucKwAlIP/JU29d1pAp031BxFJTZs9oP2Y2n9zYXjjnLQBq3leWxpmxY
 KWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765265090; x=1765869890;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7yHUsd1wm5rDND9ZUlG4yAVsN0CXmboOkWlE3wKBp8=;
 b=r9fPdiDVGp/tvpOO8k2hlQBgh+DkC09j2x8GENqUuoR4c/6Ufe3S+HU82YcHQ+nF76
 cEWaduqSMLb0kb1anra5F7sLVzLN28/+8QE/vvsD9qFt++TCVJZXzrZL685SLrNHpmcH
 IqPgQ3mChXWUMkyhVZunMBURODq4pMaxT4Sp8NsyjGkyvPiZsQQOayydtcuqQ3BIy08s
 aYMjIFRHcnOpPAazSZBuB3OynsB4vqX0KYZlvlH7xdkUgnc62nzvd+FSkl8ZyjfzIjW6
 8SgwHQC3/g7fDMqxd6SexFZFqSqINSmRC6xH8teN3J6u30j5y1rDgpZFu6PW14RdGZ7H
 FGDg==
X-Gm-Message-State: AOJu0Yy60l1T/neOZsZpykCwpcosdokaJJbSv8gjiIHMDr6dQq8LqlaF
 AP7wrdqPaTpIkQ2kblGV16kmXyEImO36EEqTiJf+1f/KeNby9AJZsw90326w3KeyWVttar0f0i1
 V6/rPhtXyRU1NLkk+5E7JPJLWihR8KM9RJbaNlbAoB+TJFUkWSow4xIo6jyiZQeSv6qFPY9j3FE
 6sDQiFJ7LCY6WwXgHMDwd5Pluh7BAKBFYmrQ==
X-Gm-Gg: ASbGncsEHowTMpIPlfoOAFVUjrmXLYF0TKuitDxIZ2qdtLv4Jk0zdZRt7QAIJg76yg9
 CnsYsoXzmsbGCj/0J/h9iVwqbmbjRPNohtkipmGEqPm7Hd/6Rw5UPzuKeD9mZculY8MJPcLK7QB
 LDuISQczWvNCRwOY1UBU3q05IWb/7TShyhqsvBgRxK4Bx/WlAJiAun10NKyxb+JyaW68habtzDF
 x/VmVXg2RWPy+XNuPTG3WTxN1rZGGXtd5dDcDJJKjHBXMCOQuBCjF/ZgmVYt3YFRQFzFlFosX1+
 wdfVnuedzoLAPSJKVagPyOAIv7WIxivso0Hr17BCCNhJdfxqnEs6DDmnJtRvgtkLPwVd2Wlv/S7
 TyQWqDif7Re0tOmoUChzcMrUon9h9Wlrpxw==
X-Received: by 2002:a05:600c:6d0:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-47939e4910emr67947975e9.30.1765265089165; 
 Mon, 08 Dec 2025 23:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPb8GmA3bn7VAIFG3dLMsBYWB5qRU3R3bShZc3vyxgLkA06flOfsJmr016SpFg9NeSZ8Xr1w==
X-Received: by 2002:a05:600c:6d0:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-47939e4910emr67947645e9.30.1765265088299; 
 Mon, 08 Dec 2025 23:24:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d9b5facsm10597735e9.7.2025.12.08.23.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 23:24:46 -0800 (PST)
Date: Tue, 9 Dec 2025 02:24:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Salil Mehta <salil.mehta@opnsrc.net>
Subject: FWD: [ATTENTION] Mails on qemu mailing list are disapapearing making
 communication unreliable
Message-ID: <20251209022028-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, SUBJ_ATTENTION=0.499,
 URI_DOTEDU=1 autolearn=no autolearn_force=no
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

Hi guys,
who has ability to contact the list admins? Can help Salil?

----- Forwarded message from Salil Mehta <salil.mehta@opnsrc.net> -----

From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Tue, 9 Dec 2025 00:44:04 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [ATTENTION] Mails on qemu mailing list are disapapearing making communication unreliable
Message-ID: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>

Hi Michael,

I hope you are doing well.

I’ve noticed that some emails are going missing from the qemu-devel mailing
list. This has now happened multiple times, both with emails I have sent from my
official address and with emails from other contributors.

Over the past three months, I have consistently observed emails disappearing
from the qemu-devel archives, which makes the mailing list communication highly
unreliable.

For example, the attached .eml file is a message from Vishnu (Ampere) which
was sent to the list but later disappeared. This is starting to raise serious
concerns about the reliability of the mailing list, and the broken communication
is creating confusion for everyone involved.

I would be very grateful if you could look into this directly, or advise how
best to proceed and whom to contact to resolve this issue.

Attachment:
[1] [PATCH RFC V6 00_24] Support of Virtual CPU Hotplug-like Feature
for ARMv8+ Arch.eml

Many thanks.

Best regards,
Salil

From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
Date: Mon, 27 Oct 2025 13:58:59 +0530
To: Igor Mammedov <imammedo@redhat.com>, salil.mehta@opnsrc.net
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
Message-ID: <c2462372-f797-47f3-a96e-4872f9cedde5@amperemail.onmicrosoft.com>
In-Reply-To: <20251006160027.20067fe4@fedora>

Hi Salil,

On 06-10-2025 19:30, Igor Mammedov wrote:

    On Wed,  1 Oct 2025 01:01:03 +0000
    salil.mehta@opnsrc.net wrote:


        From: Salil Mehta <salil.mehta@huawei.com>

        [!] Sending again: It looks like mails sent from my official ID are being held
        somewhere. Hence, I am using my other email address. Sorry for any inconvenience
        this may have caused.

        ============
        (I) Prologue
        ============

        This patch series adds support for a virtual CPU hotplug-like feature (in terms
        of usage) to Armv8+ platforms. Administrators are able to dynamically scale the
        compute capacity on demand by adding or removing vCPUs. The interface is similar
        in look-and-feel to the vCPU hotplug feature supported on x86 platforms. While
        this series for Arm platforms shares the end goal with x86, it is implemented
        differently because of inherent differences in the CPU architecture and the
        constraints it imposes.

        In this implementation, the meaning of "CPU hotplug" is as described in the Arm
        Power State Coordination Interface (PSCI) specification (DEN0022F.b, §4.3 "CPU
        hotplug and secondary CPU boot", §5.5, 5.6). This definition has not changed.
        On Arm platforms, the guest kernel itself can request CPU onlining or offlining
        using PSCI calls (via SMC/HVC), since the CPU_ON and CPU_OFF functions are part
        of the standard PSCI interface exposed to the non-secure world.

        This patch series instead adds the infrastructure required to implement
        administrative policy control in QEMU/VMM (as privileged software) along with
        the ability to convey changes via ACPI to the guest kernel. This ensures the
        guest is notified of compute capacity changes that result from per-vCPU
        administrative policy. This is conceptually similar to the traditional CPU
        hotplug mechanism that x86 follows. It allows or denies guest-initiated PSCI
        CPU_ON/OFF requests by enabling or disabling an already ACPI-described and
        present vCPU via HMP/QMP 'device_set' (a new interface), making it (un)available
        to the guest kernel. This provides the look-and-feel of vCPU hotplug through
        ACPI _STA.Enabled toggling, while keeping all vCPUs enumerated in ACPI tables at
        boot.

        Unlike x86, where vCPUs can become not-present after boot and the kernel (maybe
        because architecture allows this?) tolerates some level of dynamic topology
        changes, the Arm CPU Architecture requires that the number of vCPUs and their
        associated redistributors remain fixed once the system has booted. Consequently,
        the Arm host kernel and guest kernel do not tolerate removal or addition of CPU
        objects after boot.

        Offline vCPUs remain described to guest firmware and OSPM, and can be brought
        online later by toggling the ACPI _STA Enabled bit. This model aligns with
        ACPI 6.5 (Table 5.37, GICC CPU Interface Flags), which introduced the "Online
        Capable" bit to signal processors that can be enabled at runtime. It is also
        consistent with the Arm GIC Architecture Specification (IHI0069H, §11.1), which
        defines CPU interface power domain behavior.

        Corresponding kernel changes from James Morse (ARM) have already been accepted
        and are part of the mainline Linux kernel since 6.11 release.

    Series a bit of tangled up, I'd suggest splitting it in 3 separate
    series that would follow up each other, to make it more digestible
    and that should simplify/speedup review and merging processes.

    here is suggested order (1 and 2 could be swapped or done in parallel):

    1: introduce power state infrastructure (hw one as opposed to administrative one)
       and apply it to ARM vcpus.
       (on completion guest should be able to power up/down cores using exiting
        linux interfaces (which I'd guess end up in calling PSCI))

    2. Instead of complicating ‘-smp’ semantics and as consequence trying to deal
        with complications it causes (-deviceset CLI option),
        I’d suggest to make ‘-device arm-cpu’ work, that way
        ‘-smp’ semantics stay the same
        and you don’t have to invent -deviceset CLI option to fixup built in CPUs.

        What I see in this series has a number of problems wrt to above:
        2.1: -smp creates anonymous vcpus that aren’t supposed to be managed by user,
             as opposed to devices created by -device, which must have user assigned  ‘id’
             if they are to be managed by the user.
        2.2. to workaround that, series adds to ‘-deviceset/device-set’ that lets
             pattern match vcpus by some subset of device properties. Thus violating #1 point.

        Above can be solved by using existing ‘-device’ that would allow to set
        initial power state during vcpu creation time and let user assign ‘id’
        if one wishes to manage that vcpu later on.
        That alleviates the need for -deviceset accessing anonymous vcpus.
        And remaining device-set QMP command would have user provided ‘id’ to address
        managed vcpus.
        i.e. UI will be consistent with what we do in x86/s390/spapr cases,
        as well as with any other devices that supports '-device'

    3. As the last would come series to support administrative power state policy
       aka ‘hotplug-like’ feature (incl. device-set QMP command).


This patches are looks good on Ampere platforms and Also VM live migration
works fine on Ampere platforms.

Please feel free to add Tested-by Vishnu Pajjuri.

BTW, do you plan to pursue changes suggested by Igor, and how are you planning
to move this series forward?

Regards,

-Vishnu

    Also:
    Looking at previous reviews, lazy-realize issue still hasn’t been dropped.
    It’s a hack to workaround slowness of VCPU creation code and
    I still maintain the opinion that it doesn't fit this series.
    (it actually gets in the way of the ‘hotplug-like’ feature,
    negatively influencing/complicating this series).

    If faster vcpu creation times are needed, fix relevant code instead of
    covering it up with a hack. (in previous reviews I've even pointed to
    some low hanging fruits that can speed it up).
    Anyways speed up optimizations should be a separate series and
    shouldn't be conflated with this series at all.


        ====================================
        (II) Summary of `Recent` Key Changes
        ====================================

        RFC V5 -> RFC V6

        (*) KeyChange: Introduced new infrastructure to handle administrative PowerState
            transitions (enable-to-disable & vice-versa) as-per Policy.
        (*) Stopped using the existing vCPU Hotplug infrastructure code
        (*) Replaced 'device_add/-device' with new 'device_set/-deviceset' interface
        (*) Introduced '-smp disabledcpus=N' parameter for Qemu CLI
        (*) Dropped 'info hotpluggable'. Added 'info cpus-powerstate' command
        (*) Introduced DeviceState::admin_power_state property={enabled,disabled,removed} states
        (*) Introduced new 'PowerStateHandlder' abstract interface with powerstate hooks.
        (*) Dropped destruction of disabled vCPU objects post cpu init.
        (*) Dropped vCPU Hotplug ACPI support introduced ACPI/GED specifcally for ARM type vCPUs
        (*) Dropped GIC IRQ unwiring support once VM is initialized.
        (*) Dropped vCPU unrealization support. Retained lazy realization of disabled vCPUs(boot time).
        (*) All vCPU objects exist for lifetime of VM.
        (*) Introduced a separate ACPI CPU/OSPM interface to handle device check, eject
            request etc. to intimate gues kernel about change in policy.
        (*) Introduced new concept of *userspace parking* of 'disabled' KVM vCPUs

    ‘Parking’ was KVM concept due to inability to destroy VCPUs on KVM side.
    Please do not use/propagate/expose it to newer code (unless it's KVM related).
    In absence of lazy-realize it's likely not needed, as parking is only
    related to unrealize in KVM context.


        (*) We do not migrate disabled vCPUs

    I’d migrate disabled vcpus as well (at least power state), while it would consume time,
    It would be in line with what we do with other present devices.
    We can always reduce what we migrate later on as a patch on top if necessary.


        (*) Mitigation to pause_all_vcpus() problem. Caching the ICC_CTLR_EL1 in Qemu
        (*) Stopped reconciling (for now) vCPU config at destination VM during Migration

    I guess that concludes my review of this revision.

    PS:
    I don't think that per patch review at this state would make much sense
    as the things patches do are all mixed up and some of that should go away,
    drastically changing next revision.
    But given the series is complete rewrite, it's expected and allows
    to identify how to ammend the following series.



        Dropped Due to change in vCPU handling approach:

        [PATCH RFC V5 03/30] hw/arm/virt: Move setting of common vCPU properties in a function
        [PATCH RFC V5 04/30] arm/virt, target/arm: Machine init time change common to vCPU {cold|hot}-plug
        [PATCH RFC V5 09/30] arm/acpi: Enable ACPI support for vCPU hotplug
        [PATCH RFC V5 12/30] arm/virt: Release objects for *disabled* possible vCPUs after init
        [PATCH RFC V5 14/30] hw/acpi: Make _MAT method optional
        [PATCH RFC V5 16/30] target/arm: Force ARM vCPU *present* status ACPI *persistent*
        [PATCH RFC V5 18/30] arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
        [PATCH RFC V5 22/30] target/arm/cpu: Check if hotplugged ARM vCPU's FEAT match existing
        [PATCH RFC V5 24/30] target/arm: Add support to *unrealize* ARMCPU during vCPU Hot-unplug
        [PATCH RFC V5 25/30] tcg/mttcg: Introduce MTTCG thread unregistration leg
        [PATCH RFC V5 30/30] hw/arm/virt: Expose cold-booted vCPUs as MADT GICC *Enabled*

        Modified or Code reused in other patches:

        [PATCH RFC V5 19/30] hw/arm, gicv3: Changes to notify GICv3 CPU state with vCPU hot-(un)plug event
        [PATCH RFC V5 17/30] arm/virt: Add/update basic hot-(un)plug framework
        [PATCH RFC V5 20/30] hw/arm: Changes required for reset and to support next boot
        [PATCH RFC V5 21/30] arm/virt: Update the guest(via GED) about vCPU hot-(un)plug events

        ---------------------------------
        [!] Expectations From This RFC v6
        ---------------------------------

        Please refer to the DISCLAIMER in Section (XI) for the correct expectations from
        this version of the RFC

        ===============
        (II) Motivation
        ===============

        Adds virtual CPU hot-plug-like support for ARMv8+ Arch in QEMU. Allows vCPUs to
        be brought online or offline after VM boot, similar to x86 arch, while keeping
        all CPU resources provisioned and described at startup. Enables scaling guest VM
        compute capacity on demand, useful in several scenarios:

        1. Vertical Pod Autoscaling [9][10] in the cloud: As part of an orchestration
           framework, resource requests (CPU and memory) for containers in a pod can be
           adjusted dynamically based on usage.

        2. Pay-as-you-grow business model: Infrastructure providers may allocate and
           restrict the total compute resources available to a guest VM according to
           the SLA (Service Level Agreement). VM owners can then request additional
           CPUs to be hot-plugged at extra cost.

        In Kubernetes environments, workloads such as Kata Container VMs often adopt
        a "hot-plug everything" model: start with the minimum resources and add vCPUs
        later as needed. For example, a VM may boot with just one vCPU, then scale up
        once the workload is provisioned. This approach provides:

        1. Faster boot times, and
        2. Lower memory footprint.

        vCPU hot-plug is therefore one of the steps toward realizing the broader
        "hot-plug everything" objective. Other hot-plug mechanisms already exist on ARM,
        such as ACPI-based memory hot-plug and PCIe device hot-plug, and are supported
        in both QEMU and the Linux guest. Extending vCPU hot-plug in this series aligns
        with those efforts and fills the remaining gap.

        ================
        (III) Background
        ================

        The ARM architecture does not support physical CPU hot-plug and lacks a
        specification describing the behavior of per-CPU components (e.g. GIC CPU
        interface, redistributors, PMUs, timers) when such events occur. As a result,
        both host and guest kernels are intolerant to changes in the number of CPUs
        enumerated by firmware and described by ACPI at boot time.

        We need to respect these architectural constraints and the kernel limitations
        they impose, namely the inability to tolerate changes in the number of CPUs
        enumerated by firmware once the system has booted, and create a practical
        solution with workarounds in the VMM/QEMU.

        This patch set implements a non-intrusive solution by provisioning all vCPU
        resources during VM initialization and exposing them via ACPI to the guest
        kernel. The resources remain fixed, while the effect of hot-plug is achieved by
        toggling ACPI CPU status (enabled) bits to bring vCPUs online or offline.

        -----------
        Terminology
        -----------

        (*) Possible CPUs: Total vCPUs that could ever exist in the VM. This includes
                           any 'present' & 'enabled' CPUs plus any CPUs that are
                           'present' but are 'disabled' at boottime.
                           - Qemu parameter (-smp cpus=N1, disabled=N2)
                           - Possible vCPUs = N1 + N2
        (*) Present CPUs:  Possible CPUs that are ACPI 'present'. These might or might
                           not be ACPI 'enabled'.
        (*) Enabled CPUs:  Possible CPUs that are ACPI 'present' and 'enabled' and can
                           now be ‘onlined’ (PSCI) for use by the Guest Kernel. All cold-
                           booted vCPUs are ACPI 'enabled' at boot. Later, using
                           'device_set/-deviceset', more vCPUs can be ACPI 'enabled'.


        Below are further details of the constraints:

        ===============================================
        (IV) Constraints Due to ARMv8+ CPU Architecture
        ===============================================

        A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)

           1. ARMv8 CPU architecture does not support the concept of the physical CPU
              hotplug.
              a. There are many per-CPU components like PMU, SVE, MTE, Arch timers, etc.,
                 whose behavior needs to be clearly defined when the CPU is
                 hot(un)plugged. Current specification does not define this nor are any
                 immediate plans from ARM to extend support for such a feature.
           2. Other ARM components like GIC, etc., have not been designed to realize
              physical CPU hotplug capability as of now. For example,
              a. Every physical CPU has a unique GICC (GIC CPU Interface) by construct.
                 Architecture does not specify what CPU hot(un)plug would mean in
                 context to any of these.
              b. CPUs/GICC are physically connected to unique GICR (GIC Redistributor).
                 GIC Redistributors are always part of the always-on power domain. Hence,
                 they cannot be powered off as per specification.

        B. Limitation in Firmware/ACPI (Architectural Constraint)

           1. Firmware has to expose GICC, GICR, and other per-CPU features like PMU,
              SVE, MTE, Arch Timers, etc., to the OS. Due to the architectural constraint
              stated in section A1(a), all interrupt controller structures of
              MADT describing GIC CPU Interfaces and the GIC Redistributors MUST be
              presented by firmware to the OSPM during boot time.
           2. Architectures that support CPU hotplug can evaluate the ACPI _MAT method
              to get this kind of information from the firmware even after boot, and the
              OSPM has the capability to process these. ARM kernel uses information in
              MADT interrupt controller structures to identify the number of present CPUs
              during boot and hence does not allow to change these after boot. The number
              of present CPUs cannot be changed. It is an architectural constraint!

        C. Limitations in KVM to Support Virtual CPU Hotplug (Architectural Constraint)

           1. KVM VGIC:
              a. Sizing of various VGIC resources like memory regions, etc., related to
                 the redistributor happens only once and is fixed at the VM init time
                 and cannot be changed later after initialization has happened.
                 KVM statically configures these resources based on the number of vCPUs
                 and the number/size of redistributor ranges.
              b. Association between vCPU and its VGIC redistributor is fixed at the
                 VM init time within the KVM, i.e., when redistributor iodevs gets
                 registered. VGIC does not allow to setup/change this association
                 after VM initialization has happened. Physically, every CPU/GICC is
                 uniquely connected with its redistributor, and there is no
                 architectural way to set this up.
           2. KVM vCPUs:
              a. Lack of specification means destruction of KVM vCPUs does not exist as
                 there is no reference to tell what to do with other per-vCPU
                 components like redistributors, arch timer, etc.
              b. In fact, KVM does not implement the destruction of vCPUs for any
                 architecture. This is independent of whether the architecture
                 actually supports CPU Hotplug feature. For example, even for x86 KVM
                 does not implement the destruction of vCPUs.

        D. Considerations in Qemu due to ARM CPU Architecture & related KVM Constraints:

           1. Qemu CPU Objects MUST be created to initialize all the Host KVM vCPUs to
              overcome the KVM constraint. KVM vCPUs are created and initialized when
              Qemu CPU Objects are realized.
           2. The 'GICV3State' and 'GICV3CPUState' objects must be sized for all possible
              vCPUs at VM initialization, when the QOM GICv3 object is realized. This is
              required because the KVM VGIC can only be initialized once, and the number
              of redistributors, their per-vCPU interfaces, and associated data
              structures or I/O device regions are all fixed at VM init time.
           3. How should new QOM CPU objects be connected back to the 'GICV3CPUState'
              objects and disconnected from it in case the CPU is being hot(un)plugged?
           4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented in the
              QOM for which KVM vCPU already exists? For example, whether to keep,
               a. No QOM CPU objects Or
               b. Unrealized CPU Objects
           5. How should vCPU state be exposed via ACPI to the Guest? Especially for
              the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not exist
              within the QOM but the Guest always expects all possible vCPUs to be
              identified as ACPI *present* during boot.
           6. How should Qemu expose GIC CPU interfaces for the unplugged or
              yet-to-be-plugged vCPUs using ACPI MADT Table to the Guest?

        E. How are the above questions addressed in this QEMU implementation?

           1. Respect the limitations imposed by the Arm architecture in KVM, ACPI, and
              the guest kernel. This requires always keeping the vCPU count constant.
           2. Implement a workaround in QEMU by keeping all vCPUs present and toggling
              the ACPI _STA.Enabled bit to realize a vCPU hotplug-like effect.
           3. Never destroy vCPU objects once initialized, since they hold the ARMCPU
              state that is set up once during VM initialization.
           4. Size other per-vCPU components, such as the VGIC CPU interface and
              redistributors, for the maximum number of vCPUs possible during the VM’s
              lifetime.
           5. Exit HVC/SMC KVM hypercalls (triggered by PSCI CPU_ON/OFF) to user space
              for policy checks that allow or deny the guest kernel’s power-on/off
              request.
           6. Disabled vCPUs remain parked in user space and are never migrated.

        ===================
        (V) Summary of Flow
        ===================

        -------------------
        vCPU Initialization
        -------------------
           1. Keep all vCPUs always enumerated and present (enabled/disabled) in the
              guest kernel, host KVM, and QEMU with topology fixed.
           2. Realize hotplug-like functionality by toggling the ACPI _STA.Enabled bit
              for each vCPU.
           3. Never destroy a vCPU. vCPU objects and threads remain alive throughout the
              VM lifetime once created. No un-realization handling code is required.
              Threads may be realized lazily for disabled vCPUs.
           4. At VM init, pre-create all possible vCPUs in KVM, including those not yet
              enabled in QEMU, but keep them in the PSCI powered-off state.
           5. Park disabled vCPU threads in user space to avoid KVM lock contention.
              This means 'CPUState::halted=1'; 'CPUState::stopped=1'; and 'CPUState::parked=1' (new).
        -------------------
        VGIC Initialization
        -------------------
           6. Size 'GICv3State' and 'GICv3CPUState' objects over possible vCPUs at VM
              init time when the QEMU GIC is realized. This also sizes KVM VGIC
              resources such  as redistributor regions. This sizing never changes after
              VM init.
        -------------------
        ACPI Initialization
        -------------------
           7. Build the ACPI MADT table with updates:
              a. Number of GIC CPU interface entries = possible vCPUs.
              b. Boot vCPU as MADT.GICC.Enabled=1 (not hot[un]pluggable).
              c. Hot[un]pluggable vCPUs as MADT.GICC.online-capable=1 and
                 MADT.GICC.Enabled=0 (mutually exclusive). These vCPUs can be enabled
                 and onlined after guest boot (firmware policy).
           8. Expose ACPI _STA status to the guest kernel:
              a. Always _STA.Present=1 (all possible vCPUs).
              b. _STA.Enabled=1 (enabled vCPUs = plugged).
              c. _STA.Enabled=0 (disabled vCPUs = unplugged).
        ---------------------------------------------------------------
        vCPU Administrative *First* Enable [= vCPU Hotplug-like Action]
        ---------------------------------------------------------------
           9. The first administrative enable of a vCPU leads to deferred realization of
              the QEMU vCPU object initialized at VM init:
              a. Realizes the vCPU object and spawns the QEMU vCPU thread.
              b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list).
              c. Reinitializes the KVM vCPU in the host (reset core/sys regs, set
                 defaults).
              d. Runs the KVM vCPU (created with 'start-powered-off'). Thread waits for
                 PSCI.
              e. Marks QEMU 'GICv3CPUState' interface accessible.
              f. Updates ACPI _STA.Enabled=1.
              g. Notifies guest (GED Device-Check). Guest sees Enabled=1 and registers
                 CPU.
              h. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC).
                 - KVM exits to QEMU (policy check).
                 - If allowed, QEMU calls `cpu_reset()` and powers on the vCPU in KVM.
                 - KVM wakes vCPU thread out of sleep and puts vCPUMP state to RUNNABLE
        -----------------------------------------------------------
        vCPU Administrative Disable [= vCPU Hot-unplug-like Action]
        -----------------------------------------------------------
          10. Administrative disable does not un-realize the QOM CPU object or destroy
              the vCPU thread. Instead:
              a. Notifies guest (GED Eject Request). Guest offlines vCPU (CPU_OFF PSCI).
              b. KVM exits to QEMU (policy check).
                 - QEMU powers off vCPU in KVM and
                 - KVM puts vCPUMP state to STOPPED & sleeps on RCUWait
              c. Guest signals eject after quiescing vCPU.
              d. QEMU updates ACPI _STA.Enabled=0.
              e. Marks QEMU 'GICv3CPUState' interface inaccessible.
              f. Parks the vCPU thread in user space (unblocks from KVM to avoid vCPU
                 lock contention):
                 - Unregisters VMSD from migration.
                 - Removes vCPU from present/active lists.
                 - Pauses the vCPU (`cpu_pause`).
                 - Kicks vCPU thread to user space ('CPUState::parked=1').
              g. Guest sees ACPI _STA.Enabled=0 and removes CPU (unregisters from LDM).
        --------------------------------------------------------------------
        vCPU Administrative *Subsequent* Enable [= vCPU Hotplug-like Action]
        --------------------------------------------------------------------
          11. A subsequent administrative enable does not realize objects or spawn a new
              thread. Instead:
              a. Unparks the vCPU thread in user space:
                 - Re-registers VMSD for migration.
                 - Adds back to present/active lists.
                 - Resumes the vCPU (`cpu_resume`).
                 - Clears parked flag ('CPUState::parked=0').
              b. Marks QEMU 'GICv3CPUState' interface accessible again.
              c. Updates ACPI _STA.Enabled=1.
              d. Notifies guest (GED Device-Check). Guest sees Enabled=1 and registers
                 CPU.
              e. Guest onlines vCPU (PSCI CPU_ON over HVC/SMC).
                 - KVM exits to QEMU (policy check).
                 - QEMU sets power-state=PSCI_ON, calls `cpu_reset()`, and powers on
                   vCPU.
                 - KVM changes MP state to RUNNABLE.

        ============================================
        (VI) Work Presented at KVM Forum Conferences
        ============================================

        Details of the above work have been presented at KVMForum2020 and KVMForum2023
        conferences. Slides & video are available at the links below:
        a. KVMForum 2023
           - Challenges Revisited in Supporting Virt CPU Hotplug on architectures that don't Support CPU Hotplug (like ARM64).
             https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
             https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
             https://www.youtube.com/watch?v=hyrw4j2D6I0&t=23970s
             https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
        b. KVMForum 2020
           - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems (like ARM64) - Salil Mehta, Huawei.
             https://kvmforum2020.sched.com/event/eE4m

        ===================
        (VII) Commands Used
        ===================

        A. Qemu launch commands to init the machine (with 6 possible vCPUs):

        $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
        -cpu host -smp cpus=4,disabled=2 \
        -m 300M \
        -kernel Image \
        -initrd rootfs.cpio.gz \
        -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
        -nographic \
        -bios QEMU_EFI.fd \

        B. Administrative '[En,Dis]able' [akin to 'Hot-(un)plug'] related commands:

        # Hot(un)plug a host vCPU (accel=kvm):
        (qemu) device_set host-arm-cpu,id=core4,core-id=4,admin-state=enable
        (qemu) device_set host-arm-cpu,id=core4,core-id=4,admin-state=disable

        # Hot(un)plug a vCPU (accel=tcg):
        (qemu) device_set cortex-a57-arm-cpu,id=core4,core-id=4,admin-state=enable
        (qemu) device_set cortex-a57-arm-cpu,id=core4,core-id=4,admin-state=disable

        Sample output on guest after boot:

            $ cat /sys/devices/system/cpu/possible
            0-5
            $ cat /sys/devices/system/cpu/present
            0-5
            $ cat /sys/devices/system/cpu/enabled
            0-3
            $ cat /sys/devices/system/cpu/online
            0-1
            $ cat /sys/devices/system/cpu/offline
            2-5

        Sample output on guest after 'enabling'[='hotplug'] & 'online' of vCPU=4:

            $ echo 1 > /sys/devices/system/cpu/cpu4/online

            $ cat /sys/devices/system/cpu/possible
            0-5
            $ cat /sys/devices/system/cpu/present
            0-5
            $ cat /sys/devices/system/cpu/enabled
            0-4
            $ cat /sys/devices/system/cpu/online
            0-1,4
            $ cat /sys/devices/system/cpu/offline
            2-3,5

        ===================
        (VIII) Repositories
        ===================

        (*) Latest Qemu RFC V6 (Architecture Specific) patch set:
            https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v6
        (*) Older QEMU changes for vCPU hotplug can be cloned from below site:
            https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-{v1,v2,v3,v4,v5}
        (*) `Accepted` Qemu Architecture Agnostic patch is present here:
            https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.agnostic.v16/
        (*) All Kernel changes are already part of mainline v6.11
        (*) Original Guest Kernel changes (by James Morse, ARM) are available here:
            https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtual_cpu_hotplug/rfc/v2

        ================================
        (IX) KNOWN ISSUES & THINGS TO DO
        ================================

        1. TCG currently faces some hang issues due to unhandled cases. We aim to fix
           these within the next one to two weeks.
        2. Comprehensive testing is ongoing. This is fresh code, and we expect to
           complete testing within two weeks.
        3. QEMU documentation (.rst) still needs to be updated.
        4. Migration has been lightly tested but is working as expected.
        5. Mitigation to avoid `pause_all_vcpus` needs broader community discussion. An
           alternative change has been prepared in KVM, which maintains a shadow of
           `ICC_CTLR_EL1` to reduce lock contention when using KVM device IOCTLs. This
           avoids synchronization issues if the register value changes during VM runtime.
           While not mandatory, this enhancement would provide a more comprehensive fix
           than the current QEMU assumption that the relevant fields are invariant or
           pseudo-static. An RFC for this KVM change will be floated within a week.
        6. Mitigation of parking disabled vCPU threads in user space, to avoid blocking
           them inside KVM, needs review by the wider community to ensure no hidden
           issues are introduced.
        7. A discussion (if needed) on why `device_set` was chosen instead of `qom-set`
           for administrative state control.
        8. CPU_SUSPEND/Standy related handling (if required)
        9. HVF and qtest are not supported or done yet.

        ============================
        (X) ORGANIZATION OF PATCHES
        ============================

         [Patch 1-2, 22-23] New HMP/QMP interface ('device_set') related changes
            (*) New ('DeviceState::admin_power_state') property; Enabled/Disabled States and handling
            (*) New Qemu CLI parameter ('-smp CPUS, disabled=N') handling
            (*) Logic to find the existing object not part of the QOM
         [Patch 3-5, 10] logic required during machine init.
            (*) Some validation checks.
            (*) Introduces core-id,socket-id,cluster-id property and some util functions required later.
            (*) Logic to setup lazy realization of the QOM vCPUs
            (*) Logic to pre-create vCPUs in the KVM host kernel.
         [Patch 6-7, 8-9] logic required to size the GICv3 State
            (*) GIC initialization pre-sized with possible vCPUs.
            (*) Introduction of the GICv3 CPU Interface `accessibility` property & accessors
            (*) Refactoring to make KVM & TCG 'GICv3CPUState' initialization common.
            (*) Changes in GICv3 post/pre-load function for migration
         [Patch 11,14-16,19] logic related to ACPI at machine init time.
            (*) ACPI CPU OSPM interface for ACPI _STA.Enable/Disable handling
            (*) ACPI GED framework to cater to CPU DeviceCheck/Eject Events.
            (*) ACPI DSDT, MADT changes.
         [Patch 12-13, 17] Qdev, Virt Machine, PowerState Handler Changes
            (*) Changes to introduce 'PowerStateHandler' and its abstract interface.
            (*) Qdev changes to handle the administrative enabling/disabling of device
            (*) Virt Machine implementation of 'PowerStateHandler' Hooks
            (*) vCPU thread user-space parking and unparking logic.
         [Patch 18,20-21,24] Misc.
            (*) Handling of SMCC Hypercall Exits by KVM to Qemu for PSCI.
            (*) Mitigation to avoid using 'pause_all_vcpus' during ICC_CTLR_EL1 reset.
            (*) Mitigation when TCG 'TB Code Cache' is found saturated

        ===============
        (XI) DISCLAIMER
        ===============

        This patch-set is the culmination of over four years of ongoing effort to bring
        a vCPU hotplug-like feature to the Arm platform. The work has already led to
        changes in the ACPI specification and the Linux kernel, and this series now
        introduces the missing piece within QEMU.

        The transition from RFC v5 to RFC v6 resulted in a shift of approach, based on
        maintainer feedback, and required substantial code to be re-written. This is
        *not* production-level code and may still contain bugs. Comprehensive testing is
        in progress on HiSilicon Kunpeng920 SoCs, Oracle servers, and Ampere platforms.
        We expect to fix outstanding issues in the coming month and, subject to no major
        concerns from maintainers about the chosen approach, a near-stable, non-RFC
        version will be posted soon.

        This work largely follows the direction of prior community discussions over the
        years [see refs below], including mailing list threads, Linaro Open Discussions,
        and sessions at KVM Forum. This RFC is intended to validate the overall approach
        outlined here and to gather community feedback before moving forward with a
        formal patch series.

        [The concept being presented has been found to work!]

        ================
        (XII) Change Log
        ================

        RFC V4 -> RFC V5:
        -----------------
        1. Dropped "[PATCH RFC V4 19/33] target/arm: Force ARM vCPU *present* status ACPI *persistent*"
           - Seperated the architecture agnostic ACPI changes required to support vCPU Hotplug
             Link: https://lore.kernel.org/qemu-devel/20241014192205.253479-1-salil.mehta@huawei.com/#t
        2. Dropped "[PATCH RFC V4 02/33] cpu-common: Add common CPU utility for possible vCPUs"
           - Dropped qemu{present,enabled}_cpu() APIs. Commented by Gavin (Redhat), Miguel(Oracle), Igor(Redhat)
        3. Added "Reviewed-by: Miguel Luis <miguel.luis@oracle.com>" to [PATCH RFC V4 01/33]
        3. Dropped the `CPUState::disabled` flag and introduced `GICv3State::num_smp_cpus` flag
           - All `GICv3CPUState' between [num_smp_cpus,num_cpus) are marked as 'inaccessible` during gicv3_common_realize()
           - qemu_enabled_cpu() not required - removed!
           - removed usage of `CPUState::disabled` from virt.c and hw/cpu64.c
        4. Removed virt_cpu_properties() and introduced property `mp-affinity` get accessor
        5. Dropped "[PATCH RFC V4 12/33] arm/virt: Create GED device before *disabled* vCPU Objects are destroyed"

        RFC V3 -> RFC V4:
        -----------------
        1. Addressed Nicholas Piggin's (IBM) comments
           - Moved qemu_get_cpu_archid() as a ACPI helper inline acpi/cpu.h
             https://lore.kernel.org/qemu-devel/D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com/
           - Introduced new macro CPU_FOREACH_POSSIBLE() in [PATCH 12/33]
             https://lore.kernel.org/qemu-devel/D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com/
           - Converted CPUState::acpi_persistent into Property. Improved the cover note
             https://lore.kernel.org/qemu-devel/D2H62RK48KT7.2BTQEZUOEGG4L@gmail.com/
           - Fixed teh cover note of the[PATCH ] and clearly mentioned about KVMParking
             https://lore.kernel.org/qemu-devel/D2GFOGQC3HYO.2LKOV306JIU98@gmail.com/
        2. Addressed Gavin Shan's (RedHat) comments:
           - Introduced the ARM Extensions check. [Looks like I missed the PMU check :( ]
             https://lore.kernel.org/qemu-devel/28f3107f-0267-4112-b0ca-da59df2968ae@redhat.com/
           - Moved create_gpio() along with create_ged()
             https://lore.kernel.org/qemu-devel/143ad7d2-8f45-4428-bed3-891203a49029@redhat.com/
           - Improved the logic of the GIC creation and initialization
             https://lore.kernel.org/qemu-devel/9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com/
           - Removed redundant !dev->realized checks in cpu_hotunplug(_request)
             https://lore.kernel.org/qemu-devel/64e9feaa-8df2-4108-9e73-c72517fb074a@redhat.com/
        3. Addresses Alex Bennée's + Gustavo Romero (Linaro) comments
           - Fixed the TCG support and now it works for all the cases including migration.
             https://lore.kernel.org/qemu-devel/87bk1b3azm.fsf@draig.linaro.org/
           - Fixed the cpu_address_space_destroy() compilation failuer in user-mode
             https://lore.kernel.org/qemu-devel/87v800wkb1.fsf@draig.linaro.org/
        4. Fixed crash in .post_gicv3() during migration with asymmetrically *enabled*
             vCPUs at destination VM

        RFC V2 -> RFC V3:
        -----------------
        1. Miscellaneous:
           - Split the RFC V2 into arch-agnostic and arch-specific patch sets.
        2. Addressed Gavin Shan's (RedHat) comments:
           - Made CPU property accessors inline.
             https://lore.kernel.org/qemu-devel/6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com/
           - Collected Reviewed-bys [PATCH RFC V2 4/37, 14/37, 22/37].
           - Dropped the patch as it was not required after init logic was refactored.
             https://lore.kernel.org/qemu-devel/4fb2eef9-6742-1eeb-721a-b3db04b1be97@redhat.com/
           - Fixed the range check for the core during vCPU Plug.
             https://lore.kernel.org/qemu-devel/1c5fa24c-6bf3-750f-4f22-087e4a9311af@redhat.com/
           - Added has_hotpluggable_vcpus check to make build_cpus_aml() conditional.
             https://lore.kernel.org/qemu-devel/832342cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com/
           - Fixed the states initialization in cpu_hotplug_hw_init() to accommodate previous refactoring.
             https://lore.kernel.org/qemu-devel/da5e5609-1883-8650-c7d8-6868c7b74f1c@redhat.com/
           - Fixed typos.
             https://lore.kernel.org/qemu-devel/eb1ac571-7844-55e6-15e7-3dd7df21366b@redhat.com/
           - Removed the unnecessary 'goto fail'.
             https://lore.kernel.org/qemu-devel/4d8980ac-f402-60d4-fe52-787815af8a7d@redhat.com/#t
           - Added check for hotpluggable vCPUs in the _OSC method.
             https://lore.kernel.org/qemu-devel/20231017001326.FUBqQ1PTowF2GxQpnL3kIW0AhmSqbspazwixAHVSi6c@z/
        3. Addressed Shaoqin Huang's (Intel) comments:
           - Fixed the compilation break due to the absence of a call to virt_cpu_properties() missing
             along with its definition.
             https://lore.kernel.org/qemu-devel/3632ee24-47f7-ae68-8790-26eb2cf9950b@redhat.com/
        4. Addressed Jonathan Cameron's (Huawei) comments:
           - Gated the 'disabled vcpu message' for GIC version < 3.
             https://lore.kernel.org/qemu-devel/20240116155911.00004fe1@Huawei.com/

        RFC V1 -> RFC V2:
        -----------------
        1. Addressed James Morse's (ARM) requirement as per Linaro Open Discussion:
           - Exposed all possible vCPUs as always ACPI _STA.present and available during boot time.
           - Added the _OSC handling as required by James's patches.
           - Introduction of 'online-capable' bit handling in the flag of MADT GICC.
           - SMCC Hypercall Exit handling in Qemu.
        2. Addressed Marc Zyngier's comment:
           - Fixed the note about GIC CPU Interface in the cover letter.
        3. Addressed issues raised by Vishnu Pajjuru (Ampere) & Miguel Luis (Oracle) during testing:
           - Live/Pseudo Migration crashes.
        4. Others:
           - Introduced the concept of persistent vCPU at QOM.
           - Introduced wrapper APIs of present, possible, and persistent.
           - Change at ACPI hotplug H/W init leg accommodating initializing is_present and is_enabled states.
           - Check to avoid unplugging cold-booted vCPUs.
           - Disabled hotplugging with TCG/HVF/QTEST.
           - Introduced CPU Topology, {socket, cluster, core, thread}-id property.
           - Extract virt CPU properties as a common virt_vcpu_properties() function.

        =======================
        (XIII) ACKNOWLEDGEMENTS
        =======================

        I would like to thank the following people for various discussions with me over
        different channels during development:

        Marc Zyngier (Google), Catalin Marinas (ARM), James Morse (ARM), Will Deacon (Google),
        Jean-Philippe Brucker (Linaro), Sudeep Holla (ARM), Lorenzo Pieralisi (Linaro),
        Gavin Shan (RedHat), Jonathan Cameron (Huawei), Darren Hart (Ampere),
        Igor Mammedov (RedHat), Ilkka Koskinen (Ampere), Andrew Jones (RedHat),
        Karl Heubaum (Oracle), Keqian Zhu (Huawei), Miguel Luis (Oracle),
        Xiongfeng Wang (Huawei), Vishnu Pajjuri (Ampere), Shameerali Kolothum (Huawei),
        Russell King (Oracle), Xuwei/Joy (Huawei), Peter Maydel (Linaro),
        Zengtao/Prime (Huawei), Nicholas Piggin (IBM), Alex Bennée(Linaro) and all those
        whom I have missed!

        Many thanks to the following people for their current or past contributions:

        1. James Morse (ARM)
           (Current Kernel part of vCPU Hotplug Support on AARCH64)
        2. Jean-Philippe Brucker (Linaro)
           (Prototyped one of the earlier PSCI-based POC [17][18] based on RFC V1)
        3. Keqian Zhu (Huawei)
           (Co-developed Qemu prototype)
        4. Xiongfeng Wang (Huawei)
           (Co-developed an earlier kernel prototype with me)
        5. Vishnu Pajjuri (Ampere)
           (Verification on Ampere ARM64 Platforms + fixes)
        6. Miguel Luis (Oracle)
           (Verification on Oracle ARM64 Platforms + fixes)
        7. Russell King (Oracle) & Jonathan Cameron (Huawei)
           (Helping in upstreaming James Morse's Kernel patches).

        ================
        (XIV) REFERENCES
        ================

        [1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
        [2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@huawei.com/
        [3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
        [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
        [5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.dev/
        [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3706
        [7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
        [8] https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
        [9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
        [10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html
        [11] https://lkml.org/lkml/2019/7/10/235
        [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
        [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
        [14] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
        [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
        [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
        [17] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
        [18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/
        [19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
        [20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gicc-cpu-interface-flags
        [21] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
        [22] https://lore.kernel.org/qemu-devel/20240607115649.214622-1-salil.mehta@huawei.com/T/#md0887eb07976bc76606a8204614ccc7d9a01c1f7
        [23] RFC V3: https://lore.kernel.org/qemu-devel/20240613233639.202896-1-salil.mehta@huawei.com/#t

        Author Salil Mehta (1):
          target/arm/kvm,tcg: Handle SMCCC hypercall exits in VMM during PSCI_CPU_{ON,OFF}

        Jean-Philippe Brucker (1):
          target/arm/kvm: Write vCPU's state back to KVM on cold-reset

        Salil Mehta (22):
          hw/core: Introduce administrative power-state property and its accessors
          hw/core, qemu-options.hx: Introduce 'disabledcpus' SMP parameter
          hw/arm/virt: Clamp 'maxcpus' as-per machine's vCPU deferred online-capability
          arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id property
          arm/virt,kvm: Pre-create KVM vCPUs for 'disabled' QOM vCPUs at machine init
          arm/virt,gicv3: Pre-size GIC with possible vCPUs at machine init
          arm/gicv3: Refactor CPU interface init for shared TCG/KVM use
          arm/virt, gicv3: Guard CPU interface access for admin disabled vCPUs
          hw/intc/arm_gicv3_common: Migrate & check 'GICv3CPUState' accessibility mismatch
          arm/virt: Init PMU at host for all present vCPUs
          hw/arm/acpi: MADT change to size the guest with possible vCPUs
          hw/core: Introduce generic device power-state handler interface
          qdev: make admin power state changes trigger platform transitions via ACPI
          arm/acpi: Introduce dedicated CPU OSPM interface for ARM-like platforms
          acpi/ged: Notify OSPM of CPU administrative state changes via GED
          arm/virt/acpi: Update ACPI DSDT Tbl to include 'Online-Capable' CPUs AML
          hw/arm/virt,acpi/ged: Add PowerStateHandler hooks for runtime CPU state changes
          target/arm/cpu: Add the Accessor hook to fetch ARM CPU arch-id
          hw/intc/arm-gicv3-kvm: Pause all vCPUs & cache ICC_CTLR_EL1 for userspace PSCI CPU_ON
          monitor,qdev: Introduce 'device_set' to change admin state of existing devices
          monitor,qapi: add 'info cpus-powerstate' and QMP query (Admin + Oper states)
          tcg: Defer TB flush for 'lazy realized' vCPUs on first region alloc

         accel/kvm/kvm-all.c                    |   2 +-
         accel/tcg/tcg-accel-ops-mttcg.c        |   2 +-
         accel/tcg/tcg-accel-ops-rr.c           |   2 +-
         cpu-common.c                           |   4 +-
         hmp-commands-info.hx                   |  32 ++
         hmp-commands.hx                        |  30 +
         hw/acpi/Kconfig                        |   3 +
         hw/acpi/acpi-cpu-ospm-interface-stub.c |  41 ++
         hw/acpi/cpu_ospm_interface.c           | 747 +++++++++++++++++++++++++
         hw/acpi/generic_event_device.c         |  91 +++
         hw/acpi/meson.build                    |   2 +
         hw/acpi/trace-events                   |  17 +
         hw/arm/Kconfig                         |   1 +
         hw/arm/virt-acpi-build.c               |  75 ++-
         hw/arm/virt.c                          | 573 +++++++++++++++++--
         hw/core/cpu-common.c                   |  12 +
         hw/core/machine-hmp-cmds.c             |  62 ++
         hw/core/machine-qmp-cmds.c             | 107 ++++
         hw/core/machine-smp.c                  |  24 +-
         hw/core/machine.c                      |  28 +
         hw/core/meson.build                    |   1 +
         hw/core/powerstate.c                   | 100 ++++
         hw/core/qdev.c                         | 197 +++++++
         hw/intc/arm_gicv3.c                    |   1 +
         hw/intc/arm_gicv3_common.c             |  64 ++-
         hw/intc/arm_gicv3_cpuif.c              | 270 ++++-----
         hw/intc/arm_gicv3_cpuif_common.c       |  58 ++
         hw/intc/arm_gicv3_kvm.c                | 123 +++-
         hw/intc/gicv3_internal.h               |   1 +
         include/hw/acpi/acpi_dev_interface.h   |   1 +
         include/hw/acpi/cpu_ospm_interface.h   |  78 +++
         include/hw/acpi/generic_event_device.h |   6 +
         include/hw/arm/virt.h                  |  42 +-
         include/hw/boards.h                    |  37 ++
         include/hw/core/cpu.h                  |  71 +++
         include/hw/intc/arm_gicv3_common.h     |  65 +++
         include/hw/powerstate.h                | 177 ++++++
         include/hw/qdev-core.h                 | 151 +++++
         include/monitor/hmp.h                  |   3 +
         include/monitor/qdev.h                 |  30 +
         include/system/kvm.h                   |   8 +
         include/system/system.h                |   1 +
         include/tcg/startup.h                  |   6 +
         include/tcg/tcg.h                      |   1 +
         qapi/machine.json                      |  90 +++
         qemu-options.hx                        | 129 ++++-
         stubs/meson.build                      |   1 +
         stubs/powerstate-stubs.c               |  47 ++
         system/cpus.c                          |   4 +-
         system/qdev-monitor.c                  | 139 ++++-
         system/vl.c                            |  42 ++
         target/arm/arm-powerctl.c              |  29 +-
         target/arm/cpu.c                       |  14 +
         target/arm/cpu.h                       |   5 +
         target/arm/helper.c                    |   2 +-
         target/arm/internals.h                 |   2 +-
         target/arm/kvm.c                       | 140 ++++-
         target/arm/kvm_arm.h                   |  25 +
         target/arm/meson.build                 |   1 +
         target/arm/{tcg => }/psci.c            |   9 +
         target/arm/tcg/meson.build             |   4 -
         tcg/region.c                           |  16 +
         tcg/tcg.c                              |  19 +-
         63 files changed, 3800 insertions(+), 265 deletions(-)
         create mode 100644 hw/acpi/acpi-cpu-ospm-interface-stub.c
         create mode 100644 hw/acpi/cpu_ospm_interface.c
         create mode 100644 hw/core/powerstate.c
         create mode 100644 include/hw/acpi/cpu_ospm_interface.h
         create mode 100644 include/hw/powerstate.h
         create mode 100644 stubs/powerstate-stubs.c
         rename target/arm/{tcg => }/psci.c (96%)




----- End forwarded message -----


