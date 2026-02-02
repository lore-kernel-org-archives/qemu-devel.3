Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FADE73164
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtbz-0000Cx-9B; Mon, 02 Feb 2026 08:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmtbx-0000A0-G7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:05:01 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmtbv-00041V-N0
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:05:01 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-653780e9eb3so5916605a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770037498; x=1770642298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muv298YAIKY8NJLq/ySiFM7aiROkT93W5+Hbce1MpZE=;
 b=drCvrc5frVz/eRqZ0V7YOLDaznA0uYUvkHrlqj91RiQHwMxajuXewPAonIbkm3Asd9
 J/SZ9XgZ3NpodZLiiF0N1q3umW97jepn5PTjI+Av+QjQ0oMdAYE1HtWriDSIdl1sGXvN
 zAofdWrn476V7bf3iG0mbQ5u5VPR3ZpIdLi3R/R+iCGGA+kpBf5MyVnNYdEknUBVnXOa
 jjAYDlDC37DEXQKPGApxmeAQUXBcDPtTuRXyUlT8AbeHacrEKCe4R8JsLNkgxOQ7m/yT
 YHFKwKZ4nq4djASqU0jFYVRUfdY0VaaVdF4jxZeFJtE/UAgVO7igYzSA5+5WX11dHOEE
 BEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770037498; x=1770642298;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muv298YAIKY8NJLq/ySiFM7aiROkT93W5+Hbce1MpZE=;
 b=AlCxcNPrMvCxCq6XlJmHv0ciOmrn68rxFqVRy+/iwpad/o/AoGhdtaeL3O+79l6eXj
 lKMvncNp0r2EU2EfaX2fUiyG+S7XUuiDs+692PEldCnScm0bOW2ccoltkqbvkIW31Ekg
 2R/hJRNJHq0zGGXRZ2xmPAFJi2V3CxmmiwD6dK6NDJqKZKNKkftO4t31t/1ufdlMm8NM
 qUWN89MSM0imP2uVPQxHp2Tpy/p8z4EtrawJ3ntrtdD4BI9Rc/FeIQ6RmzBdVhwLaRZe
 L+zGkbeG7rLB5Ap2KZ2G2L7AVVtZG+ygvViSy1WS5qFpPR3aGNVbp6axloY418ckEPHD
 wXWQ==
X-Gm-Message-State: AOJu0YzOHEEFSf6vfTWBNS76GS6qe+pzutky1FRWzTPY01x34/TkbA4Q
 j7ZQcBgpaLQHGailtOZXLEz1RbtfjNprvvYNKWN4DMrVjYm6b7X6RvVhm7RjKR8KJ9Q=
X-Gm-Gg: AZuq6aIcPgct/+nVzBWAHqtVkYW4mHMjvmTWAjBf3jpXJIMUktTkmDLHp1+B9NcF1zu
 slhlCVZs/RmU5eWY+tVSY+akDu32jQ7E0qgIoz/2YtndY1trN0G4GcFVRXU1l4yQvv5uSewLywT
 GruQthFDTj4XnzS5NJcyuKgVUQX+4+PUPxt9W+dtcoPSVxqmGPHaAV1NSdjGjD78Q5w856mWWLZ
 VmarQ9fWAFTDxeUFv46QJdmGp8jRaGCt4jtazq3VbOBkHXGMAU3IIhoom1HkhyxaS28PamEiN4J
 yiqX5J9QmWYX5qtYh7eWdSwcQ/Zd5vFYLiPjpva0gGHEqILHMbZyTioFyS8YemilwJ6po5Z4oAO
 fD8CFttnmHz9/VfAAWzJUvIvTAcEi3uFDkB5Rzlye4EVFA83dmwjB44fm66E5J1L/veKHqDminx
 gS5xDIVBw0mFQ=
X-Received: by 2002:a17:907:da17:b0:b87:9d1d:ec6b with SMTP id
 a640c23a62f3a-b8dff228764mr684230366b.0.1770037497687; 
 Mon, 02 Feb 2026 05:04:57 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbefc69ebsm877860466b.20.2026.02.02.05.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:04:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB7785F7D8;
 Mon, 02 Feb 2026 13:04:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  jpcottin@google.com,  Markus Armbruster
 <armbru@redhat.com>,  Roman Kiryanov <rkir@google.com>,  Will Hollins
 <whollins@google.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  jansene@google.com,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] bulk: Stop forward-declaring enum typedefs
In-Reply-To: <7bfa5966-b7cd-4af4-b979-ea973a30195a@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 2 Feb 2026 13:05:33
 +0100")
References: <20260130211746.46667-1-philmd@linaro.org>
 <20260130211746.46667-2-philmd@linaro.org>
 <87ms1rpdnw.fsf@draig.linaro.org>
 <7bfa5966-b7cd-4af4-b979-ea973a30195a@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 02 Feb 2026 13:04:55 +0000
Message-ID: <87h5rzpa88.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 2/2/26 12:50, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> The C99 standard chapter =C2=A76.7.2.2 point 4 mentions:
>>>
>>>    Each enumerated type shall be compatible with char, a signed
>>>    integer type, or an unsigned integer type. The choice of type
>>>    is implementation-defined, but shall be capable of representing
>>>    the values of all the members of the enumeration.
>>>
>>> Align with that recommendation by defining the typedef
>>> along with the enum.
>>>
>>> For information, building with -Werror=3Dpedantic was reporting:
>>>
>>>    In file included from ../../ui/kbd-state.c:10:
>>>    include/ui/kbd-state.h:12:14: error: ISO C forbids forward reference=
s to 'enum' types [-Werror,-Wpedantic]
>>>       12 | typedef enum QKbdModifier QKbdModifier;
>>>          |              ^
>>>    ...
>>>
>>> Reported-by: Roman Kiryanov <rkir@google.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   hw/riscv/riscv-iommu-bits.h          |  4 ++--
>>>   hw/riscv/riscv-iommu.h               |  2 --
>>>   include/hw/misc/auxbus.h             | 11 ++++-------
>>>   include/hw/pci/pci_device.h          |  5 ++---
>>>   include/hw/ssi/ssi.h                 |  6 ++----
>>>   include/hw/xen/interface/io/xenbus.h |  5 ++---
>>>   include/io/channel.h                 | 11 ++++-------
>>>   include/system/replay.h              | 10 ++++------
>>>   include/ui/clipboard.h               | 15 ++++++---------
>>>   include/ui/kbd-state.h               |  6 ++----
>>>   pc-bios/s390-ccw/virtio.h            |  5 ++---
>>>   tests/qtest/libqos/qgraph_internal.h | 10 ++++------
>>>   hw/core/loader.c                     |  5 ++---
>>>   hw/display/xlnx_dp.c                 | 11 ++++-------
>>>   hw/dma/xlnx_dpdma.c                  | 10 ++++------
>>>   qapi/opts-visitor.c                  |  7 ++-----
>>>   qapi/string-output-visitor.c         |  6 ++----
>>>   tests/unit/check-qom-proplist.c      |  6 ++----
>>>   18 files changed, 50 insertions(+), 85 deletions(-)
>>>
>>> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
>>> index 47fe01bee58..281afa7bc3f 100644
>>> --- a/hw/riscv/riscv-iommu-bits.h
>>> +++ b/hw/riscv/riscv-iommu-bits.h
>>> @@ -96,11 +96,11 @@ struct riscv_iommu_pq_record {
>>>   #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
>>>   #define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
>>>   -enum riscv_iommu_igs_modes {
>>> +typedef enum riscv_iommu_igs_modes {
>>>       RISCV_IOMMU_CAP_IGS_MSI =3D 0,
>>>       RISCV_IOMMU_CAP_IGS_WSI,
>>>       RISCV_IOMMU_CAP_IGS_BOTH
>>> -};
>>> +} riscv_iommu_igs_mode;
>> mode vs modes.
>
> Pre-existing...
>
>> It seems very clumsy to have the type at the front and
>> back of the declaration. The only real reason to have the tag ahead of
>> the struct/enum was if there are references in the structure.
>> IOW this does feel like a lot of churn.
>
> Well I got it clear old-school maintainers are very reluctant
> to open the project to more contributors, even if changes
> required are only cosmetics, and less invasive than Rust ones.

Is this opening up to more contributors? As far as I can tell this seems
to be trying to make life easier for downstream for something we don't
want contributed to the upstream (C++).=20

> I won't put more energy to this now. Maybe in 10 years from
> now if the project still exists, and we get more inclusive.

I'm all for improving inclusively and lowering barriers to entry for
contributors upstream but I'm not sure how this does that.=20

>
> Regards,
>
> Phil.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

