Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB80CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkAf-000576-IF; Thu, 11 Sep 2025 12:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwkAc-00056j-VW
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwkAb-00017F-5v
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757608151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6IfJq0PeXXpJnmQfIgkF/V+uc6bP+zPZYW7h5in2crk=;
 b=L2uiqsWKpWVnqrNIFkXTJqAjtRmX1IpWAmhBjrf6s/61OrVIAgL0XztBvMX6+RE1YmpPuy
 hdpAZ3T4mjfujk/BnX7HQqrluH6/4/EMSkM6SxBYtl558RQtuRIw9VwF6Bc5sO8H+5ugIt
 aB3z0hBvyhMJSEBu9yZw83hgH3Si374=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-OMxYnt4TMK6NhUrPI4Gc_g-1; Thu, 11 Sep 2025 12:29:09 -0400
X-MC-Unique: OMxYnt4TMK6NhUrPI4Gc_g-1
X-Mimecast-MFC-AGG-ID: OMxYnt4TMK6NhUrPI4Gc_g_1757608148
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de18e7eccso5454065e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757608148; x=1758212948;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6IfJq0PeXXpJnmQfIgkF/V+uc6bP+zPZYW7h5in2crk=;
 b=G8zExN7y6tg8hB8Glw1HbrLpgZOBYRYvPxmoJyRJLOGle5Hz7i32Sd2U/sJqwz6pNe
 WVQUV1+GidVvjCKsKFnMLZVgxvtWyjsOVQvktFvFf+5YtJ2uMmlEmiUMPHI/pyTFviE2
 OzttvswaABEV4Szun58psRfvEUD8PK9swbMg4ikNI/LjmA/nTooUpdJITLKSp1BEqYeE
 VjtH1UZqqC05b4MpkJJBf09pstWVA0xM1Dc2keNwmV5YMoEDSZBXYqs1b4XmlQUej2Bc
 lHriraexcHCdCmE48FhImHCxulewudWylI0iSlrvSU4a1zz9+Yclg/QfHc5bDXLtQO2Y
 vFdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB9j36yyDSpTsUl65sX7dVl2LmY0vGiNZDd8AuGkV+Gr4+SOHibLjk+Ed8WA9QFpyvRVjvxOYKPgr8@nongnu.org
X-Gm-Message-State: AOJu0YwjHUKygxv4uA4+M+xzf8hEw2L4uVhh/hoBgGA0RPNjMvV138L/
 8GM+yLcUwJrQDrKXm5mNNaXsZZ9nXao1tT0vyv551DLKYtFD+Ija/U38te1YgPROAme4RYxVpoK
 XyXOL1tjc1lfqvY5I5glMdQc9SUEsDOFSFz37Nc36PY42TaTEt7/tPIof
X-Gm-Gg: ASbGncstE4XBqHyBLtbFvi1vJeiZW5Mwmb+6lDkwArW7xADF8p50I37g5Xmb5WY+OBO
 FaKXayoJAtpl9J0TcuM/9guk8fBJTX0qdrWiygPOJivMqAwcYbNYNmAosudXOoMOyZJMWtd3IUJ
 H36mEYh0PV0xdsYIC+/5HRknsRFzSdXF9Kxzg2uwbty5pihOy6HPPaps2HaT22o0zkVbczJ/76S
 8dWTOojJ/a97UBPYgHxeNu469o1Ku4B8n7nzB3SGzf/y1CnpSqO8bHK4nI4NJ0Kbzl+wZ2xlXzu
 961eU8K7+kRytUp1YmKz90k0ShRu5znT3V5mcaF/7RbdnhhmF1XyQqFkVh2x4rTZ9iEls+s3Uk7
 /Mk54DSnNZdhn6Q==
X-Received: by 2002:a05:600c:5248:b0:45d:d9ab:b85a with SMTP id
 5b1f17b1804b1-45f211e520bmr865655e9.7.1757608148307; 
 Thu, 11 Sep 2025 09:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY6150HoCh3FfRYfRTEKIcW5EuOXujbRibT3SZGb6KEdyz/nOArM0wpiCpufKuF5ucxLYIpw==
X-Received: by 2002:a05:600c:5248:b0:45d:d9ab:b85a with SMTP id
 5b1f17b1804b1-45f211e520bmr865075e9.7.1757608147817; 
 Thu, 11 Sep 2025 09:29:07 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037b9ebbsm31717955e9.11.2025.09.11.09.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 09:29:07 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:29:06 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 0/2] arm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA8hUiQkYsyLOHFQqexzY3u4ZZZBXvi+DuueExGdJi_HVQ@mail.gmail.com>
Message-ID: <3176813f-77c0-4c39-b363-11af3b181217@redhat.com>
References: <20250911144923.24259-1-sebott@redhat.com>
 <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
 <8bca09f1-48fe-0868-f82f-cdb0362699e1@redhat.com>
 <CAFEAcA8hUiQkYsyLOHFQqexzY3u4ZZZBXvi+DuueExGdJi_HVQ@mail.gmail.com>
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

On Thu, 11 Sep 2025, Peter Maydell wrote:
> On Thu, 11 Sept 2025 at 16:59, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> On Thu, 11 Sep 2025, Peter Maydell wrote:
>>> On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
>>>>
>>>> This series adds a vcpu knob to request a specific PSCI version
>>>> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>>>>
>>>> Note: in order to support PSCI v0.1 we need to drop vcpu
>>>> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>>> Alternatively we could limit support to versions >=0.2 .
>>>>
>>>> Sebastian Ott (2):
>>>>   target/arm/kvm: add constants for new PSCI versions
>>>>   target/arm/kvm: add kvm-psci-version vcpu property
>>>
>>> Could we have some rationale, please? What's the use case
>>> where you might need to specify a particular PSCI version?
>>
>> The use case is migrating between different host kernel versions.
>> Per default the kernel reports the latest PSCI version in the
>> KVM_REG_ARM_PSCI_VERSION register (for KVM_CAP_ARM_PSCI_0_2) -
>> when that differs between source and target a migration will fail.
>>
>> This property allows to request a PSCI version that is supported by
>> both sides. Specifically I want to support migration between host
>> kernels with and without the following Linux commit:
>>         8be82d536a9f KVM: arm64: Add support for PSCI v1.2 and v1.3
>
> So if the destination kernel is post that commit and the
> source kernel pre-dates it, do we fail migration?

This case works with current qemu without any changes, since on
target qemu would write the register value it has stored from
the source side (QEMU_PSCI_VERSION_1_1) and thus requests kvm
on target to emulate that version.

> Or is
> this only a migration failure when the destination doesn't
> support the PSCI version we defaulted to at the source end?

Yes, this doesn't work with current qemu. On target qemu would
write QEMU_PSCI_VERSION_1_3 to the KVM_REG_ARM_PSCI_VERSION
register but that kernel doesn't know this version and the
migration will fail.

With this series you could request QEMU_PSCI_VERSION_1_1 on
the source kernel to allow a migration.

(For RHEL we have distro specific machine types that will
use this property to handle that via compats.)

Sebastian


