Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC83CCD18C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HMm-00039t-EM; Mon, 13 Oct 2025 08:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8HMf-000391-6k
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:09:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8HMV-000335-QT
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:09:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so42555855e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760357347; x=1760962147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hcyu3P/zI1g0pNfp7dST1Q5TJfxxC3JReeWh2qfToM=;
 b=gY7Uwo58eTpTiRPJ3441nAE8VaoKbryZhr0FYaEgR3ebR0xFW4+xVAQ5/K2H7xD5ui
 0PjmMiY9cYiKXGwXPROfK1OQC9yncCiahQ8WZQFWS9y7luV4PgyAC91Tyz0huoPlI2nO
 IuPP3DQovc/QUlJe1gAq91EvahTl5FBDoTsqBPziH/tW2wSRwBQDxdIcfrZKuDw4zgbh
 NAkB4DqtmO8qvrndxtCOIo++hHodHtUyFnSM6ay/xBB2uy1heXaHWil9P0Y7+FI/GM0S
 wEsmSe9WDZ0kSaNXE0YSxCkUyzXnPT5HaL2RMcc6lc58kdSVLdQafOsBw4LrwmCw1TiV
 f4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760357347; x=1760962147;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hcyu3P/zI1g0pNfp7dST1Q5TJfxxC3JReeWh2qfToM=;
 b=jmDInINSDRgSHxFjqx80VYu5AQKXgaNqxOAfzRA1TAAfP4TfYmt7Cj32hxm2ao9mtt
 fA9RcM5ud8zyyeKnaSYTI/FEj/pvMTmZC+BxaVhEKkXelaPm7CY5MaB9/8D+PzPOFQXt
 +wBGiibEO4Czt8RRYFqcxh3GBZ9Be7j5HW6QvcJVylTwBii1V2J98nIJNWA+sTI3peSF
 xwmQ5zexgykLZ8ywbEPJ+11nAh1Z7wnwCh5c0seTlGBUjTkWpM1l4q2aliBhlLOArp0G
 /7LBCgXPcvp3mIUpF9xuSKM+X0ONtDY90VMXcWHSHEkmp2L/w0NOJ8vi38BUlFndJVwE
 drTA==
X-Gm-Message-State: AOJu0YxAhQm/cxa3PJWx+u0ppUCJT7ugrMpfttzQEMcgaaIU+bxfGuFu
 aGsvnMrbl9FSxULb9qPHYxkLvrB0S/oM4jxQyNdVtEqqelzoIQOOZ+y6
X-Gm-Gg: ASbGncuGGp2E+KJaPcQk1HvV7gO8TnJUjZqQigBL72qpnaKsUrK4aDHb5Ol5o7o2/S4
 7bOhhPLWkdy/JQGEz+o7I9HXw4lFZak5Zn4i+mKUM5EZI4gMuZzno9fVKLLHiwt9LObR4L/A35v
 NnuPjVYo1O9lt+Edpfa5zNRJ5G3bBB25XpNMXVGThJCefCBCNmlkB9MgypeYz315pyFHWRnhQnV
 wwADFOEJgtvk/yOGzqN8JwxzBXo3bZXDc7EYOBnIsXZYm5rfOZucq0jwr7+tMLThdK3CeomVDfk
 XiRxiO34M0HsLg1f/CzWWivDmkpwwrcS5Zy75NeVVYWgoVL/lkaJTTRmmBZhjxA4O+nyW7trZpR
 s5A1il+DolCUfmQ1UcvZXgA2wLXhZyNFKzcBGQDITxppLx0SQWKxPbl9TXsiEq0r5zjMW2pcSMO
 sZj8FbHEghyk5yhOFDP3c/9FHuZI7oRDWETYzU+HQ7tHjKfSXW
X-Google-Smtp-Source: AGHT+IFC2i9fb70q/v+3PyeAFM3WVnLVmmYZNIRgxVTvZt2TIjyKigz8Hc1Xn5CLEQIq6KJ9NDsjBA==
X-Received: by 2002:a05:600c:a341:b0:46e:39da:1195 with SMTP id
 5b1f17b1804b1-46fa9a8b3a9mr148744485e9.3.1760357346802; 
 Mon, 13 Oct 2025 05:09:06 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400a0afdc243fcb5392.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:a0af:dc24:3fcb:5392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm17954628f8f.19.2025.10.13.05.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 05:09:06 -0700 (PDT)
Date: Mon, 13 Oct 2025 12:09:04 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <10ba1122-8b36-4843-96e6-30a89c78f0f7@linaro.org>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <aL7xrilR-gyByKEM@redhat.com>
 <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
 <10ba1122-8b36-4843-96e6-30a89c78f0f7@linaro.org>
Message-ID: <3E0A4D78-B235-4BFF-9143-13952FC7DF73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 25=2E September 2025 00:14:34 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>On 8/9/25 17:15, Peter Maydell wrote:
>> On Mon, 8 Sept 2025 at 16:09, Daniel P=2E Berrang=C3=A9 <berrange@redha=
t=2Ecom> wrote:
>>>=20
>>> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>>>> Currently our security policy defines a "virtualization use case"
>>>> where we consider bugs to be security issues, and a
>>>> "non-virtualization use case" where we do not make any security
>>>> guarantees and don't consider bugs to be security issues=2E
>>>>=20
>>>> The rationale for this split is that much code in QEMU is older and
>>>> was not written with malicious guests in mind, and we don't have the
>>>> resources to audit, fix and defend it=2E  So instead we inform users
>>>> about what the can in practice rely on as a security barrier, and
>>>> what they can't=2E
>>>>=20
>>>> We don't currently restrict the "virtualization use case" to any
>>>> particular set of machine types=2E  This means that we have effective=
ly
>>>> barred ourselves from adding KVM support to any machine type that we
>>>> don't want to put into the "bugs are security issues" category, even
>>>> if it would be useful for users to be able to get better performance
>>>> with a trusted guest by enabling KVM=2E This seems an unnecessary
>>>> restriction, and in practice the set of machine types it makes
>>>> sense to use for untrusted-guest virtualization is quite small=2E
>>>>=20
>>>> Specifically, we would like to be able to enable the use of
>>>> KVM with the imx8 development board machine types, but we don't
>>>> want to commit ourselves to having to support those SoC models
>>>> and device models as part of QEMU's security boundary:
>>>> https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-shente=
y@gmail=2Ecom/
>>>>=20
>>>> This patch updates the security policy to explicitly list the
>>>> machine types we consider to be useful for the "virtualization
>>>> use case"=2E
>>>>=20
>>>> This is an RFC partly to see if we have consensus that this change
>>>> makes sense, and partly because I was only able to identify the
>>>> machine types we want to cover for some of our target architectures=
=2E
>>>> If maintainers for the other architectures could clarify which
>>>> machine types work with KVM that would be helpful=2E
>>>=20
>>> The split of "virtualization" vs "non-virtualization" use case
>>> in the docs was always as rather a crude hack=2E
>>>=20
>>> "Virtualization uses cases" was more or less a code phrase to
>>> mean "the subset of QEMU that we traditionally shipped in RHEL"
>>> as that is approximately what we have reasonable confidence
>>> about=2E
>>>=20
>>> Personally I wouldn't assign strict equivalence between "machine
>>> can use KVM" and  "virtualization use case"=2E
>>=20
>> I agree, but this is effectively what our docs are currently doing,
>> and what I'm trying to decouple with this patch=2E=2E=2E
>>=20
>>> Case in point - the "isapc" machine type can use KVM but I would
>>> not consider that to be a virtualization use case, and would likely
>>> reject a security report if it /only/ affected isapc, and not 'pc'
>>> / 'q35'=2E
>>>=20
>>> We didn't want to undertake the work to annotate every QOM/QDev
>>> impl in QEMU with info about whether we considered it in scope
>>> for security fixes or not, which is what we really ought to do
>>> at some point=2E The main challenge is someone having the time
>>> to do the audit & annotation work=2E
>>>=20
>>>> diff --git a/docs/system/security=2Erst b/docs/system/security=2Erst
>>>> index f2092c8768b=2E=2E395c2d7fb88 100644
>>>> --- a/docs/system/security=2Erst
>>>> +++ b/docs/system/security=2Erst
>>>> @@ -35,6 +35,34 @@ malicious:
>>>>   Bugs affecting these entities are evaluated on whether they can cau=
se damage in
>>>>   real-world use cases and treated as security bugs if this is the ca=
se=2E
>>>>=20
>>>> +To be covered by this security support policy you must:
>>>> +
>>>> +- use a virtualization accelerator like KVM or HVF
>
>If the "split-accel" (HW virtualization + SW emulation) effort lands,
>we'll have a case of HVF + TCG=2E Do we want to consider it within our
>security support policy? I doubt it (at least at the beginning)=2E Howeve=
r
>that would match "use a virtualization accelerator like KVM or HVF" (AND
>"use one of the machine types listed below" with the 'virt' machine)=2E
>
>Should we reword? Or explicit "Any SW emulation use case is NOT
>covered"?
>

Good point=2E Is it clear what SW emulation use case means? I'm struggling=
 with this term since most of our device models are emulated in software an=
d since "use case" seems very unclear=2E Should we write "Any [CPU] SW emul=
ation [such as TCG] is NOT covered"=2E Alternatively, we could elaborate th=
is when the feature is about to land=2E

Best regsrds,
Bernhard

>>>> +- use one of the machine types listed below
>>>> +
>>>> +It may be possible to use other machine types with a virtualization
>>>> +accelerator to provide improved performance with a trusted guest
>>>> +workload, but any machine type not listed here should not be
>>>> +considered to be providing guest isolation or security guarantees,
>>>> +and falls under the "non-virtualization use case"=2E
>>>> +
>>>> +Supported machine types for the virtualization use case, by target a=
rchitecture:
>>>> +
>>>> +aarch64
>>>> +  ``virt``
>>>> +i386, x86_64
>>>> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``=
isapc``
>>>> +s390x
>>>> +  ``s390-ccw-virtio``
>>>> +loongarch64:
>>>> +  ``virt``
>>>> +ppc, ppc64:
>>>> +  TODO
>>>> +mips, mips64:
>>>> +  TODO
>>>> +riscv32, riscv64:
>>>> +  TODO
>>>=20
>>> Currently 'virtualization use case' is reasonably vague such that we c=
an
>>> bend its scope as we desire, at the time it is questioned in a possibl=
e
>>> security report=2E
>>>=20
>>> Machine types are only one aspect of this=2E Devices are the other, an=
d
>>> the area where it gets significantly more fuzzy and difficult because
>>> essentially any device can be used with KVM, and where we draw the
>>> line is fairly arbitrary=2E
>>=20
>> I think that being vague like this is a disservice to our users=2E
>> If I'm a user of QEMU, I'd like to know whether I'm inside the
>> line or outside of it before I put my config into production,
>> not later on when it turns out there was an exploitable bug
>> that wasn't classified as a security issue=2E=2E=2E
>>=20
>> Most devices can't in fact be used with KVM, because they're
>> sysbus devices that aren't used in the machines that you can
>> use with KVM=2E Pluggable devices are rarer (and yes, under
>> our current policy random PCI devices are effectively
>> in-scope)=2E
>>=20
>> thanks
>> -- PMM
>

