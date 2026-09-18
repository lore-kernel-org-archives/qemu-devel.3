Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA4C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7TsZ-0007ZM-IC; Fri, 18 Sep 2026 04:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x7TsY-0007Yz-C7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:23:30 -0400
Received: from mail-pj2-x05.google.com ([2607:f8b0:4864:39::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x7TsW-0003tF-DU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:23:30 -0400
Received: by mail-pj2-x05.google.com with SMTP id
 d9443c01a7336-2d6fbdc8772so2522865ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789719806; x=1790324606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sUlMgu8lp9I4VUTAWqavbi7GYxbQken/Zb1Wf28IRYI=;
 b=AFFIUKk8ZVwPUaecct+rkjMt2Wtookb9nzQf7VQszziiidQGSpdDmeCx6WgdO9T5mC
 HKJPr66FLE96oz9H4LdVHXjR6dIUVLDhzY0+QgSFAFqMNkyvF090ipBeyE3ox3Ygp61w
 TFng6lXYVtBmNdF2FV5o31UqWgfjuXspvbweGwvdAlo12IifZtkOWsEWo5jba0Uw9edB
 x9JRGs5Ao70iM/CeqhGO7ocsMeLHEdoUjFELZb6iBxVPwObh/JDzQgJEW5RBtG1QjW7z
 vu539Qsy1vz6m/jARudE/u2SHvl7Ix9tDTC4zDJwtzIKRcHZiQRJnctOuwqq09O2ruA9
 lvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789719806; x=1790324606;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sUlMgu8lp9I4VUTAWqavbi7GYxbQken/Zb1Wf28IRYI=;
 b=SWvLgjs05xyZGKBuFbcHgiApb+xvVH9pSAWR2PSLFdG3YE8peT7phuBoxiSchln1DV
 a3uPgl+E3WYhsZJ6eKGx7ZB6WZv9fpXEcRz2eC1OKdmzxhYRSZimbsfLxBnfinyA2wlh
 0fVJADu2JGNwYf3QDoTddK1f/juykbXMcxGm4RWAu8JRlk9F+oHTSdX3CD7Ty+cEQB/M
 Lk6kbrJuBDYl/Zn+rGsL9Mv11CuaKyuU0NyNGWGrSOKtEbAojVVNtP+FG8GfqHAAscQF
 MqNjg6gPutr2Vl04oWcXZGbKX20mZezMg81p+R4Bh0EyfBiDSpnsrpzpoUTASWkWt1Md
 M1xQ==
X-Gm-Message-State: AFuF++mhGOdwYXhvgj1uFoYlibEAoZjHAwFFm6VeQiE4AggchzHD8jmP
 IBlT4dI+dbWekVaRgDKRoW1welpGT0RItQGmLYFam8P6cedQB26zMhQ=
X-Gm-Gg: AYBFou24FXnwGxkWMdPw15tlNiHJtDfLUResvvbJtFk70in1c4T9+mQ+eHdtjxGo7al
 8mCI8m8299G5Gf07hirvetZfS++zicIdnZLTX6nwop7qtdnqIz/kREGTUIw6daMGf4rjXXNPVl6
 +hL0UPeZ1U+eCi2uN0hjIO3ssvAj1vbCFsqGVoZUpzk4REVFJLtPjhMCn7Eag0r+xvDwpaNfhZg
 UUbs73Eo/tNzUFOJcKA4P3unVHfgkjqzj0YluAh8fXeqsp5xJmujScG0jKHKkC107+cMWYTe/gX
 rwEs76EWbD33gbfXac3e09oJxt5UxuLUqMvi/NRICBX/qhDEid0fpLqYEUlhSGyPP9eEfG9PoY1
 8tUq3C/DyCMSwDHTmMeRvfqID2JlJr0TER6zNiqJSVyBPl/Hnuf6mzTTOBqOWoOsFYYYlCv7gvl
 BTXQgGSGFhUdvRJVHb7aeYNxYScdTHbyNoUiuVzvVSfS67J+x4txMz6FcdyMRqI8IC+XruTPzLm
 iMkRzRl6n9Tp11hwViMG5P91twmHdUl/L5/nAW13G0Kn9joGtbZfRU=
X-Received: by 2002:a17:902:d4c5:b0:2da:ef81:37e7 with SMTP id
 d9443c01a7336-2ddb1b995dbmr36675115ad.21.1789719805973; 
 Fri, 18 Sep 2026 01:23:25 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:308d:821d:80d8:cadb?
 ([2408:820c:8ffa:c0f0:308d:821d:80d8:cadb])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c2876ad4dsm2503804eec.21.2026.09.18.01.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 01:23:25 -0700 (PDT)
Message-ID: <4999b79f-e5e2-4a20-a245-4784913fea1c@gmail.com>
Date: Fri, 18 Sep 2026 16:23:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: "Wang, Yuan1" <yuan1.wang@intel.com>
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com,
 bosheng.xue@intel.com, junjie.cao@intel.com
References: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
 <20260915013037.648161-1-junjie.cao@intel.com>
 <948e2399-1c85-4b51-9964-892750f7ce68@gmail.com>
 <57ff9cf6-412b-4cbb-844e-d9d1b0efbe95@intel.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <57ff9cf6-412b-4cbb-844e-d9d1b0efbe95@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::5;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x05.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2026-09-18 16:00, Wang, Yuan1 wrote:
>=20
> On 9/16/2026 1:33 PM, Tomita Moeko wrote:
>> So on MTL+ BAR2 is mapped to the physical memory at GSMBASE, with firs=
t 8M
>> for GTT. PTE addresses are relative addresses so that accessing indire=
ctly
>> from BAR or directly works. That makes sense.=20
>>
>> Meteor and later IGDs are supposed to access DSM from BAR2 instead of =
directly
>> from DSMBASE, but there is some hardware issues in Meteor Lake and Arr=
ow Lake's
>> BAR2, software workarounds it to by falling back to DSMBASE. i915 won'=
t read
>> DSMBASE register if the WA is not enabled (and it's always disabled wh=
en
>> virtualization enabled), while it's possible for GOP driver (and maybe=
 windows
>> driver) to read it. Is my understanding correct?
>>
> Yes, your understanding is correct. In virtualization, we still go to B=
AR2.
>=20
>>> Agree with the direction, and it is cheaper than that: a read-only BA=
R0
>>> quirk can take pci_get_bar_addr(pdev, 2) at read time, returning BAR2=
 at
>>> 0x108100 and BAR2 + 8M at 0x1080C0.  Then the CPU-side address resolv=
es
>>> to real stolen memory through the aperture instead of guest RAM,
>>> bdsm-size stays 0 as documented, and nothing in config space is
>>> invented.
>> Yes hooking on 0x1080C0 register read is easier and more straightforwa=
rd.
>>
>>>> Possibly an easier way is emulating MTL_PCODE_STOLEN_ACCESS(0x138914=
) to
>>>> disallowed in QEMU, if the GOP driver code checks it, to enforce the=
 access
>>>> via BAR2 in guest.
>>> 0x138914 reads 1 on the host and is not quirked, so a guest sees 1 to=
o.
>>> Returning 0 there is a small addition and covers a GOP that checks it=
;
>>> the DSMBASE quirk covers one that does not.  On the Wa itself: i915
>>> already takes the BAR path in guests (i915_run_as_guest() short-circu=
its
>>> i915_direct_stolen_access()), so that path has upstream precedent; we=

>>> have not measured whether the hang reproduces there.
>>>
>> Quirking 0x138914 prevents driver applying that WA, but we are not sur=
e
>> if driver checks it before WA. While hooking read to 0x1080C0 fakes th=
e
>> DSMBASE to (BAR2 + 8M) in guest address space. Both tries to enforce
>> guest accesses to DSM via BAR2. I personally prefers hooking 0x1080C0
>> as it's driver-independent.
> By some internal sync with Junjie and Bosheng, we plan to quirk 0x13891=
4 as you point
>=20
> before. We have checked the GOP code, it always checks the=C2=A00x13891=
4 first to determine
>=20
> the address it used.=C2=A0 If you think it is ok, we will raise a V3 pa=
tch based on it.

Sure please proceed with that.

>> Btw, this quirk seems only necessary for Meteor and Arrow lake. That W=
A
>> is not applied in Xe driver. I'm not sure if it still presents in GOP =
or
>> windows driver for later generations.
>=20
> The WA is only needed for MTL/ARL. The later ones don't need this WA.
>=20
>>> The firmware still has to program ASLS.  The IgdAssignmentDxe build t=
he
>>> v2 commit message describes aborts on bdsm-size=3D0 before doing so;
>>> VfioIgdPkg has no such check and programs ASLS for MTL+ as is.
>>>
>>> I'll write the quirk.  It can go into Yuan's v3 or on top of it as a
>>> separate patch -- Yuan, your call.  Either way it needs a run with th=
e
>>> stock GOP build on your setup.
>>>
>>> Junjie
>> Yes OpRegion is needed for display to work. In the "hooking 0x1080C0 r=
ead"
>> approach above, allocating DSM in guest is not needed. It sounds bette=
r to
>> make your IgdAssignmentDxe not aborting if bdsm-size=3D0.
>>
>> Best Regards,
>> Moeko
>=20
> Yes,=C2=A0 that's a good idea. If we can make IgdAssignmentDxe not abor=
ting, it looks better.=C2=A0
>=20
> And this function is in the offline patch of OVMF and is maintained in =
ECI's website.
>=20
> We are discussing this with the ECI team to update the offline patch. T=
he gen_id() may not
>=20
> need to be changed now if they accepted. And the V3 patch should only i=
nclude the
>=20
> quirk for 0x138914 for MTL/ARL.
>=20
>=20
> Thanks
>=20
> Yuan


