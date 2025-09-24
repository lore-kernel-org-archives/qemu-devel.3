Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9285CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1U9W-0006pM-Je; Wed, 24 Sep 2025 14:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v1U9E-0006nv-1V
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:23:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v1U90-0004jC-OH
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:23:23 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-631787faf35so140242a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758738184; x=1759342984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhX3cGpugBOUCAOUFnHfVWF9PYilYJFsOAksyFoBrSk=;
 b=AaFrhDyqXimvU65zQSf9Onadfj8OjBl9EgNqPmzDP2GG4ZBHh6Zsi5/xBwA3QjHaVY
 1l/XJImxF/8fIN3tTcpg/RgUwAeLu0K2sE8n+7+DYueFb1w9zzidR3ck49iD046QvMVa
 ft5pIoYoI1NwHWOZRE7toFcdeqP9msjGR2l3BZvFYL1mUXq1BYf/28u9YDdN2JwtbmKN
 6WTlB9+2MRkik3UiPV0h/sNK+hQdIX8GSOdAuLVdZUasRaSP5PJSA5EczXNydaCLwnYL
 GoXZ1ZH/fZiPYThz78bUG51tXYsC1sTCv8qRQUzOwocybEAiFRFrgFBOhm19jadllSbM
 UypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758738184; x=1759342984;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhX3cGpugBOUCAOUFnHfVWF9PYilYJFsOAksyFoBrSk=;
 b=OJEVwILnPis2K7pqQexvKuL0SZq3mAq4iEgjV+U7l1V5ZERyF6q8DQwGHnBwOcs277
 udtKfYBQhcjEPkWm1QFBNsEOCWPUhC/KQI0P27OZP9QgWiJC6pGMuPxNdSo9DextBj/B
 Mu7qNI4wDom/hUY4XKKRpvBZULdoefTa/59S/XzVto+T1iX8tFamdh7TlomD6BWc+fJW
 nZXSzbsRKVSkhbeFlzGQj3A/PyCePI6JQqF6nnBDDyHAPNBxzeQSmrYFCuaZwR/wM2xG
 k2wMeIV8VZflSVb6PZGxn/H6DV1DPzk3TH9ZDAmeVZKrN92kG5yfZSut6QVscp6yqYQV
 Xm2g==
X-Gm-Message-State: AOJu0YypDZS/MMdMlDepxXN/6J+O1mL+vkISDJoDFzxtVPcUbGG6EsvQ
 pXeGPmDfzJo/ZXCHrRYQW+ScCyEGcKBCuJs81xCwyjD8G0PjOfineoFo
X-Gm-Gg: ASbGncsXV46hOgG7QSTr+g8l3zWUCxmCJ11fUsRdL4eTMRJBAIB5g42MNr/AeqCp1CE
 5zKG140QDFxLgwYyIoWkUAr/lBU4OGphY99qlKEFUrlRcBX2puD4lbl/w6s7TJ9+Gkrxev+pdmP
 QuUOU8vl+ZL+JD5b/zNY2ejn7QY22JbAVN53mhkSIb/HEkHnns1r63LQLRJ03LR4nHSZR7RdzZX
 nP66pbnc3SXwnEy+uWNXiCPCqsMsthT2Wo6KHGsxjYtRuJk7rdMaL7UaojGKWLfDS8b/w6A2M5H
 rtgCaipTr/Ejc8nIWfaSqDhFq90ZPkUFa/WYj4TwiEki88yn/m3lB7tInd0nTYIAdACLseUTfMe
 nsDojcNZAH355azqbm7LDLuCQaaWtqkh4ac7Xj3c6NvwaQnIVgRdtEnqIZ9E5hfuryQ==
X-Google-Smtp-Source: AGHT+IHO1mlgZyZ9TKjlKqlWG5u19lYUIZPxFjkaI7EZ8+kMPox+tqZoyHZGlyu4TjNoGkUGN8NZyg==
X-Received: by 2002:aa7:d441:0:b0:62f:68c3:57d0 with SMTP id
 4fb4d7f45d1cf-6349f9cbc18mr301420a12.4.1758738184169; 
 Wed, 24 Sep 2025 11:23:04 -0700 (PDT)
Received: from ehlo.thunderbird.net (ip-109-40-240-217.web.vodafone.de.
 [109.40.240.217]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fb10537d1sm12229963a12.24.2025.09.24.11.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 11:23:03 -0700 (PDT)
Date: Wed, 24 Sep 2025 18:16:51 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <aL7xrilR-gyByKEM@redhat.com>
 <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
Message-ID: <B5215A1D-C8F5-44FD-B19B-70D78B7FD4F5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 8=2E September 2025 15:15:43 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>On Mon, 8 Sept 2025 at 16:09, Daniel P=2E Berrang=C3=A9 <berrange@redhat=
=2Ecom> wrote:
>>
>> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>> > Currently our security policy defines a "virtualization use case"
>> > where we consider bugs to be security issues, and a
>> > "non-virtualization use case" where we do not make any security
>> > guarantees and don't consider bugs to be security issues=2E
>> >
>> > The rationale for this split is that much code in QEMU is older and
>> > was not written with malicious guests in mind, and we don't have the
>> > resources to audit, fix and defend it=2E  So instead we inform users
>> > about what the can in practice rely on as a security barrier, and
>> > what they can't=2E
>> >
>> > We don't currently restrict the "virtualization use case" to any
>> > particular set of machine types=2E  This means that we have effective=
ly
>> > barred ourselves from adding KVM support to any machine type that we
>> > don't want to put into the "bugs are security issues" category, even
>> > if it would be useful for users to be able to get better performance
>> > with a trusted guest by enabling KVM=2E This seems an unnecessary
>> > restriction, and in practice the set of machine types it makes
>> > sense to use for untrusted-guest virtualization is quite small=2E
>> >
>> > Specifically, we would like to be able to enable the use of
>> > KVM with the imx8 development board machine types, but we don't
>> > want to commit ourselves to having to support those SoC models
>> > and device models as part of QEMU's security boundary:
>> > https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-shente=
y@gmail=2Ecom/
>> >
>> > This patch updates the security policy to explicitly list the
>> > machine types we consider to be useful for the "virtualization
>> > use case"=2E
>> >
>> > This is an RFC partly to see if we have consensus that this change
>> > makes sense, and partly because I was only able to identify the
>> > machine types we want to cover for some of our target architectures=
=2E
>> > If maintainers for the other architectures could clarify which
>> > machine types work with KVM that would be helpful=2E
>>
>> The split of "virtualization" vs "non-virtualization" use case
>> in the docs was always as rather a crude hack=2E
>>
>> "Virtualization uses cases" was more or less a code phrase to
>> mean "the subset of QEMU that we traditionally shipped in RHEL"
>> as that is approximately what we have reasonable confidence
>> about=2E
>>
>> Personally I wouldn't assign strict equivalence between "machine
>> can use KVM" and  "virtualization use case"=2E
>
>I agree, but this is effectively what our docs are currently doing,
>and what I'm trying to decouple with this patch=2E=2E=2E

Ping

Anything left to discuss?

>
>> Case in point - the "isapc" machine type can use KVM but I would
>> not consider that to be a virtualization use case, and would likely
>> reject a security report if it /only/ affected isapc, and not 'pc'
>> / 'q35'=2E
>>
>> We didn't want to undertake the work to annotate every QOM/QDev
>> impl in QEMU with info about whether we considered it in scope
>> for security fixes or not, which is what we really ought to do
>> at some point=2E The main challenge is someone having the time
>> to do the audit & annotation work=2E
>>
>> > diff --git a/docs/system/security=2Erst b/docs/system/security=2Erst
>> > index f2092c8768b=2E=2E395c2d7fb88 100644
>> > --- a/docs/system/security=2Erst
>> > +++ b/docs/system/security=2Erst
>> > @@ -35,6 +35,34 @@ malicious:
>> >  Bugs affecting these entities are evaluated on whether they can caus=
e damage in
>> >  real-world use cases and treated as security bugs if this is the cas=
e=2E
>> >
>> > +To be covered by this security support policy you must:
>> > +
>> > +- use a virtualization accelerator like KVM or HVF
>> > +- use one of the machine types listed below
>> > +
>> > +It may be possible to use other machine types with a virtualization
>> > +accelerator to provide improved performance with a trusted guest
>> > +workload, but any machine type not listed here should not be
>> > +considered to be providing guest isolation or security guarantees,
>> > +and falls under the "non-virtualization use case"=2E
>> > +
>> > +Supported machine types for the virtualization use case, by target a=
rchitecture:
>> > +
>> > +aarch64
>> > +  ``virt``
>> > +i386, x86_64
>> > +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``=
isapc``
>> > +s390x
>> > +  ``s390-ccw-virtio``
>> > +loongarch64:
>> > +  ``virt``
>> > +ppc, ppc64:
>> > +  TODO
>> > +mips, mips64:
>> > +  TODO
>> > +riscv32, riscv64:
>> > +  TODO
>>
>> Currently 'virtualization use case' is reasonably vague such that we ca=
n
>> bend its scope as we desire, at the time it is questioned in a possible
>> security report=2E
>>
>> Machine types are only one aspect of this=2E Devices are the other, and
>> the area where it gets significantly more fuzzy and difficult because
>> essentially any device can be used with KVM, and where we draw the
>> line is fairly arbitrary=2E
>
>I think that being vague like this is a disservice to our users=2E
>If I'm a user of QEMU, I'd like to know whether I'm inside the
>line or outside of it before I put my config into production,
>not later on when it turns out there was an exploitable bug
>that wasn't classified as a security issue=2E=2E=2E
>
>Most devices can't in fact be used with KVM, because they're
>sysbus devices that aren't used in the machines that you can
>use with KVM=2E Pluggable devices are rarer (and yes, under
>our current policy random PCI devices are effectively
>in-scope)=2E

From=20the top of my head: Various USB and I=C2=B2C devices can be used as w=
ell=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

