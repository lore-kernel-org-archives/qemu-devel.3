Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A8CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkRk-0001cn-FT; Thu, 11 Sep 2025 12:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwkRh-0001bz-Lx
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwkRg-0003Y0-1b
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757609210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfLhSbNYEBMsg+7tun6uGQtYpAPcwFglJcubTMzrz7A=;
 b=V+n7/rtdVt1DjSLCJlfPj0ijyv+bho5gmIsFRubIpVgnpeEroDT0khehxfaChXL+M9HADC
 Wyn3TYqlx2hm9L4+5GOZFQeYmNr/f30Ukey2KpB2KRGpoI1wFOQWTFlhraE+u8XZvnlYao
 Z1j2wTs6V+uYgmIrdN0i6l8qUklncr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-FwHctbSaNKGVjAxSvt7GVA-1; Thu, 11 Sep 2025 12:46:47 -0400
X-MC-Unique: FwHctbSaNKGVjAxSvt7GVA-1
X-Mimecast-MFC-AGG-ID: FwHctbSaNKGVjAxSvt7GVA_1757609206
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45dde353979so5949375e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757609206; x=1758214006;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfLhSbNYEBMsg+7tun6uGQtYpAPcwFglJcubTMzrz7A=;
 b=QgtwHrFIZ7XStSf/4Qkg934be9foEHLUP9/fq6VKfThCFtJQwooRzbLpfS/cqKWcdC
 FP+MpQ5/vQmd9YKDD4rs8cD5xEPvwzImDb9M49eyoG1PCSp71EJaURNglPnjljXm7F0p
 UNcoqx7T5uhHOlr+p3eKfZ1wQvDWwhWrkrOxFFX75Dl9JmFok8xeSEgxsxpg1m0fHLMi
 mpVTxU3PLrNaVAl5fk1j0FBlNEmf3ZVlGEWrOR+ktUTkCLUX7SHpiVTJ+ThxEqdULg3/
 0gySSwxtOptjmPaWn+iYOJWKEAUAagYHtzaCG4gApey+qY5IoB0S6E3JkCY+OEleFAvO
 Diqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQTdeUD5+VnS/8QfjylhH/vksWtfVtJvpscYtqhzyLiFeRve+TKVNDkAv+Wwc1NHMpQgG7wGDUdx+z@nongnu.org
X-Gm-Message-State: AOJu0Ywa62iIiF98XCBcAysPgnZal/PwFFhJhR35r0z1f66FeuzMieV2
 NRvIK98CfNyThORuM2re54CScYV01mTQPVR1azK0mw8BH+BGNZuckqTWLL9fPiIsWo4Rml3Kj/G
 LztrnIBJ/O2FWdWsLuq0FGkUThs470/DWpUvAhRPDuDqodJtxOgHKbeWB
X-Gm-Gg: ASbGncuISFRaj+PdDiR0Sh3MoQKLDZCqPJI29aaFkQyfFNlaoPrrz/kl7G+tixyVbtt
 uq0VaN9tJelqAZZLkgI5R3OFi09XKGdGYyl6jWkuz62jUOP7nbCpg8yxTDlmkV0HYQ51tRQHUBx
 OxA6usqMT5+J4m5FdWaR+b1QuoG/gSPTW00dAWMmj0q6t70uH4I8FGexWQ7Swgi2046noPdrUFO
 t0L+7crpB71/ifarcAkEf3pe+L+O6tkYygG+GUtVPHCQ3yCfI74HM1XGwl7Zh5CZh53UtktZzHh
 P4JKdbZDylkFWvuLFd4O1IZTND9T13J8HzKNAI9fzes8xQCQZlpVKlmFFwdIAT8xBKayjfh5TlH
 vuJJptiRRuOsJow==
X-Received: by 2002:a05:600c:83cf:b0:45b:43cc:e558 with SMTP id
 5b1f17b1804b1-45f21207be1mr1499135e9.35.1757609206253; 
 Thu, 11 Sep 2025 09:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzF7xdwiuJNiKLKdPH1FNf4ped6tYssSHKKe16I6IF6tF5/rGaCdBMHdg5t+uJppxMHK84qw==
X-Received: by 2002:a05:600c:83cf:b0:45b:43cc:e558 with SMTP id
 5b1f17b1804b1-45f21207be1mr1498835e9.35.1757609205837; 
 Thu, 11 Sep 2025 09:46:45 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e04cf2870sm13652215e9.1.2025.09.11.09.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 09:46:45 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:46:44 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 0/2] arm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA_ui7iyKx36fuhmOqizRWnNppb9B1iPc4nAxU2VnovMOQ@mail.gmail.com>
Message-ID: <6f1eb1b8-29d4-cdcb-f379-9869d806a116@redhat.com>
References: <20250911144923.24259-1-sebott@redhat.com>
 <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
 <8bca09f1-48fe-0868-f82f-cdb0362699e1@redhat.com>
 <CAFEAcA8hUiQkYsyLOHFQqexzY3u4ZZZBXvi+DuueExGdJi_HVQ@mail.gmail.com>
 <3176813f-77c0-4c39-b363-11af3b181217@redhat.com>
 <CAFEAcA_ui7iyKx36fuhmOqizRWnNppb9B1iPc4nAxU2VnovMOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 11 Sep 2025, Peter Maydell wrote:
> On Thu, 11 Sept 2025 at 17:29, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> On Thu, 11 Sep 2025, Peter Maydell wrote:
>>> On Thu, 11 Sept 2025 at 16:59, Sebastian Ott <sebott@redhat.com> wrote:
>>>>
>>>> On Thu, 11 Sep 2025, Peter Maydell wrote:
>>>>> On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
>>>>>>
>>>>>> This series adds a vcpu knob to request a specific PSCI version
>>>>>> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>>>>>>
>>>>>> Note: in order to support PSCI v0.1 we need to drop vcpu
>>>>>> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>>>>> Alternatively we could limit support to versions >=0.2 .
>>>>>>
>>>>>> Sebastian Ott (2):
>>>>>>   target/arm/kvm: add constants for new PSCI versions
>>>>>>   target/arm/kvm: add kvm-psci-version vcpu property
>>>>>
>>>>> Could we have some rationale, please? What's the use case
>>>>> where you might need to specify a particular PSCI version?
>>>>
>>>> The use case is migrating between different host kernel versions.
>>>> Per default the kernel reports the latest PSCI version in the
>>>> KVM_REG_ARM_PSCI_VERSION register (for KVM_CAP_ARM_PSCI_0_2) -
>>>> when that differs between source and target a migration will fail.
>>>>
>>>> This property allows to request a PSCI version that is supported by
>>>> both sides. Specifically I want to support migration between host
>>>> kernels with and without the following Linux commit:
>>>>         8be82d536a9f KVM: arm64: Add support for PSCI v1.2 and v1.3
>>>
>>> So if the destination kernel is post that commit and the
>>> source kernel pre-dates it, do we fail migration?
>>
>> This case works with current qemu without any changes, since on
>> target qemu would write the register value it has stored from
>> the source side (QEMU_PSCI_VERSION_1_1) and thus requests kvm
>> on target to emulate that version.
>>
>>> Or is
>>> this only a migration failure when the destination doesn't
>>> support the PSCI version we defaulted to at the source end?
>>
>> Yes, this doesn't work with current qemu. On target qemu would
>> write QEMU_PSCI_VERSION_1_3 to the KVM_REG_ARM_PSCI_VERSION
>> register but that kernel doesn't know this version and the
>> migration will fail.
>
> I was under the impression that trying to migrate backwards
> from a newer kernel to an older one was likely to fail
> for various reasons (notably "new kernel reports a new
> system register the old one doesn't") ?  Perhaps we should
> think about the problem in a wider scope than just the
> PSCI version...

Yes we already are ;-) See this series from Cornelia:
https://lore.kernel.org/qemu-devel/20250414163849.321857-1-cohuck@redhat.com/

And this from Eric:
https://lore.kernel.org/qemu-devel/20250911134324.3702720-1-eric.auger@redhat.com/

Both will help mitigate register differences for a backwards/downgrade
migration.

Sebastian


