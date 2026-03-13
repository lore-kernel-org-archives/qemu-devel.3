Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570C3105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13PG-0002kA-Ft; Fri, 13 Mar 2026 10:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13PD-0002jo-BF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:22:23 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13PB-0001m7-MH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:22:23 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso2433555e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411738; cv=none;
 d=google.com; s=arc-20240605;
 b=ep/rRiKpylJKXGyFHm0FYpZAe6NvyYX47Gh6fYhQFJFnm0VsfoRy8qxkQNH1vm7vGL
 Hp8sy/ka3xQTU72uhFi1pMFTdBpXlYBpWeiYWODbtwFpUbz1h6q29QaMuoqjObVHJWOH
 FhM+7+IXFXvi4se8pjRqPR+Cy0a7Ir0vM52RhsMmksImWnvWJ3+BdMevs4Rma3GXEtzp
 JmKhMm4lPA85cQrdIAeOT75vqWINXedshXAZlnIt7uRI/Co6AzoAy8Z7mY+TUQzisGnz
 U3RKesjHoFwyFmHdVKAm3l2SjCR1/u4UYmwlLtX6Z+pfHXGVCYjW2TEQvXNJsKoa1vML
 L3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eS/Tw4sqprEIn1uj2BhH+2LjMMnmPcd5VTS/K4sDW90=;
 fh=HLSZl4wSHbARFK/QliXDFk7Jcs8wjDiYrsaiKvzt3ao=;
 b=WojvgXBUuXw7TNFL5hgGUNnkc8nwxL0WmeFNzB21ZJENh2x9CPv129u3pMhNgmSoXj
 9uPZc5wz2MESMPQzNj4+wmU6U90TlXLZzW32UHSZxxYmDsRwkcE/9acYnbIUvEtHmDHI
 4EOFnSWFYjPRepySwYWeeXK6xxe4uMhVlmcR0sArsrzCa41U5GwawUN54f7jsaOK38rT
 v1QfA7SOGuuly18dcN/RFdY3E9Ydz8eoNmATuhFkHbuXElrdf0RwfoUsHVfrf9hnRjUk
 tfol33MGhzkhHg9eQeqPR8cIrP4hpaaCbPmoba7M873t2R3derINf164c0HtcqVK/ziY
 ai2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411738; x=1774016538; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS/Tw4sqprEIn1uj2BhH+2LjMMnmPcd5VTS/K4sDW90=;
 b=isUw/UU2K6GceN2SmzaJ9yoIdIgAQ9u42lbY6CO2YshtAgo1eYFBGZUhjKXcaPqLvv
 dYLgNRydrH0xQrEuW/IuFkTfXFEuaR6NV4Po/kGkonSMj90Yn+81C3AdZEFlK8jJK+I3
 natyne7lgcRPYwP90L35rc0kwZCgQuFNihQhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411738; x=1774016538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS/Tw4sqprEIn1uj2BhH+2LjMMnmPcd5VTS/K4sDW90=;
 b=qHXZ3QmMKiHvvUJ3yRtcLaodySSS6+KS/MIgjJtJFgMy1zu2F4ZJanKUTO0Kct3y2f
 UIRWS8w5fMQMJy9opYm64B3w1HanejSOKF2kQKiThjgtc37MTOIPji58FVznB40Yy1nI
 cY7wVKfeTeY03cUVRvxXbvMVM6WBoRwFHv0IjRpzLfCMeXm+bCOazuskLSgYIMl/Lx3H
 Z46kveMo+ceZkfcOImziDTiJqGxlVMDpIKrf0tCYBFKLAosGISq3yo6wkCFMJ486k4Zc
 p5JxG1uv3CqM/Njcf7itqgXoHpksjo5TWBEGyJnsGDl6soINV43T4Z1vaUohuccbspeE
 qePw==
X-Gm-Message-State: AOJu0YwneuagdtyZAZWI42zreFZWaXJ+SPSH3puIaspYyAmZRzauLtV8
 cQ2KJ3+S5Eth4h9mjpKJv2ZpV/Htg39/NCApK2FLmEmoh/isO9vKWX2rvAiPAScWdD8aH7BuwlR
 v1mE2hZAYzlz92q+qhj64sMR9LS1sglAIQtdJ2H2qdg==
X-Gm-Gg: ATEYQzy4vLaon4XF2GLf5sm8jrC0da0LyReDEjRGD7wcu7yD1nMI/6wXsYTmSVoW95S
 Tl7gnWhKd/F3odgUiEvLdJcAdr2+6hHCkvz7pP1VuHllhMnLhOk5ZoNkglFx5FjnKeYk/jBQzbZ
 OL8IOJPEabBHACDBRqaQN6z3Smaer3p2e+WZyUG7ftcpWdxxqIIA0gvsbLX6ybi8NJwRGUmR+UU
 J4ttTl56ujpXWsxd+X4JN2yonrYoS1gzRounAeOQdNDyXX17NxeKcPfPUXOv/U0YIjyHO9USoJ2
 YzDbYSJHx16QVnHPx4QLgdUu1z+F87tntUixEkxwOURS+I9VWw==
X-Received: by 2002:ac2:5968:0:b0:5a1:3ebd:d53c with SMTP id
 2adb3069b0e04-5a1626ffa87mr839572e87.13.1773411738164; Fri, 13 Mar 2026
 07:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150342.395923-1-alexander@mihalicyn.com>
 <20260306150342.395923-2-alexander@mihalicyn.com> <aar4-DgXbartZY4y@x1.local>
 <CAJqdLroT8j77_0OrE+qOoj1rRsmm0rQ4EgnjtWBush9CL1MFog@mail.gmail.com>
 <aasCIdpqEQxmYjXu@x1.local>
In-Reply-To: <aasCIdpqEQxmYjXu@x1.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 13 Mar 2026 15:22:06 +0100
X-Gm-Features: AaiRm51pniv9A50me9yBa6BVsiFiS1pJSeKaswXKW6qnuMczyuHpQaKp1gBgQhA
Message-ID: <CAJqdLrpACkESfBOywQZjbW2nJ7OTseHG2oZdzY65dkS78JKkTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12b.google.com
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

Am Fr., 6. M=C3=A4rz 2026 um 17:34 Uhr schrieb Peter Xu <peterx@redhat.com>=
:
>
> On Fri, Mar 06, 2026 at 04:57:56PM +0100, Alexander Mikhalitsyn wrote:
> > yes, yes, I'll do this in -v4, sorry for this. I was busy adding a
> > test for NVMe migration
> > and decided to send -v3 with this new test.
> >
> > Sorry about confusing you.

Hi Peter,

>
> Ahhh, no worries.  Just to say, if you send a patchset without RFC or any
> mark, it by default says: "please consider merging it".

yeah, sorry about this again.

>
> Good to know we're still on the same page.

yep, I've just sent a version 4 and it is based on your idea with new
VMS_ARRAY_OF_POINTER_ALLOW_NULL flag. Hope that I get everything right.
Also, it includes tests and many new asserts here and there :)

Kind regards,
Alex

>
> --
> Peter Xu
>

