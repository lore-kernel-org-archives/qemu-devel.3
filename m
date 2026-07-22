Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641AC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmTtX-0006Ce-Ux; Wed, 22 Jul 2026 06:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmTtW-0006Bp-IU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 06:09:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmTtU-0003Qs-TK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 06:09:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so63401255ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 03:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784714979; cv=none;
 d=google.com; s=arc-20260327;
 b=kA07rRFIVft41NMLij+oJWnkUXW2mMScLn+w0sUbxeuf56yxvAQlcU36doIQ1aVIVq
 TLRIQ6QG6AiAxZ7eTl1EKDxepufuBj3pNQX0PE9dKlyj59kyLKP1BCZ9QwIMogaM1uzN
 weI/0rydCxR6I2pyc1OPEwh7sz5uwpDoMnKCvRk4CPU5yFAYD1yv4N+X2oP9s2CUanAw
 1ylm5jn0U4qAT55ItmptSlHPR98hDaik6pKBbnsG3M+jLlB/PWkcdOlv5cJFnbQqjfGl
 2q8YpiNo1PtUp6NYmaadTWnsCyWfDW+S0DIPgo2AH130fxY+t1GFgZaz4YZSz7AvjUNa
 m3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=01RQaxskkkH8K5rkCug4iU4jN8IyzFuOhwdxlO7O0PA=;
 fh=Ld9IPg0IEZvYZc2AWIiyPRyLkvS5jIb/pE87Yqe1Wyc=;
 b=UDKXRyCnTRvatUDFcwmkLJuiVQpryGQxT7iz83qK/Sv4pZo7iidXNVv58gFu/m31bY
 NJW1L3UvLRODGfj4telzzS8vx1otkuFtlYDMWxlYSJOJyx1illqnVqIvVze4fmZO5TK5
 oXSbP7Php9ggDuuSJGXExBH2iAOJb7sd9+hkC3/EOVZvXK3aNyLbH3JQhJmKVeCKHXf6
 IsveQL8GZCCrInM9sOQzkiURTBrd4uobEU/P14xpjn++x5ahZbLEJtPiABSSl0tHuRmd
 b+1uqFMv3jGZR5a2x0IXYEYLkrb8u2RQ5JS51SdEm2jqQsxL0AYPs2mZHxCwJIapXdqN
 010A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784714979; x=1785319779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=01RQaxskkkH8K5rkCug4iU4jN8IyzFuOhwdxlO7O0PA=;
 b=Qit2BnsLDfK488E37qE2WBRrpwEqLhSB31rCWe9Vf6sIHdUp755ayQxDS2dPZm3Zr6
 Ke85EImRPS4NJXZdAfqJUfYi/dgcOjr00oPukk/0K9L+xn4SolvkQxANxGHPulB31BJp
 p/IWx+bluPpJYsnhrkLEqPNbFMfiKE5uWXMeIZLQlGUdk3+BUuO/GYq8JXPBPLBjqDbx
 BDyLooREHSd9+uyGrt63KnlDmYmETm4jK7uyFMBnGfd/1dD5tHFknQVgDdMibiInwdYX
 Z/zZ29hMdIOpSfOAI7HpuAhEvaFHDYmGSEGAOcWPf/Q7PEua8DrrABGtk+9JbCFoHhxS
 6JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784714979; x=1785319779;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=01RQaxskkkH8K5rkCug4iU4jN8IyzFuOhwdxlO7O0PA=;
 b=iXPwBdOnLm7QB7Lxz34x4sOhG+lMpQyOAUFV/uuBC0dyW8yhzhbQmth/zeShyi+Hh/
 x1EkcYjgZnwsvYki0jUHsr9/XZe+ae5S7DPh/Um+Wtckq8+GVW+3OVWJ+/wDV7vXmGQm
 dlREUmewJ7oHPdbK3LkF45VII2BLQT8tuTQ1YR40P8L+0YNnXh99OjziBBVYDuC+etrQ
 qqq6c44xWsyU+poWpvkwbn9yZVD+CwyrhrikAQ7EStw9sYL3DaWz8EOvxxUS4B2yYzmF
 lTj19HaTQ4eYYBM+RDpm5Nmjl2v2ug4cwMHCoacCvJGDFJxoCUAAnGjN2/5LopZFtUpf
 wwcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU4aI2GV3BCJxU8nKotvZCWOgnTFgNpbTKNoeU34wGBHabg29M7X87v0JIT1RzUdYq9FUtnUM8TlhC@nongnu.org
X-Gm-Message-State: AOJu0Yx7tGpHhRgI2PG4Ci2lLClDvr0UbZqOKWjmumPyCIRihv3MLRdD
 xz1seh7nh/sbYZVMnyojXq8iM8IICCEQTZp6Y8K+Zcu3I4SJGfH0lhJ1naHzy5mFL2/UaWLDkM3
 EGEGQcAm5AsV0MEk7BXH4gKXhfR9tfxI=
X-Gm-Gg: AR+sD13T642vtJk5nsl/c1BbD7cQqsBzHgh9dki3KRd4rr3Gi/y5rBb7v24imehoAE5
 crWHbkSOFcwyAkf+5aXUrkBk52GNoCNfw7upSAP3iMgiEYf4SJt0PAiJ23K1U8OBnnSAWF4NqoS
 y8o1QMRD2pgzwEvbWvzrbVfyatUwQm7cMrowtM+X7uYARZQ/ti/N6ME6N98crYacKhN/tDRXxKo
 WNbg/5ToDgBaD5q1Xd15wp+l8zFQeFuCGf4EwvDJF9v5JU4ecjS8SBkJBixIErWw/fcJEFHCV6v
 cYQAggenDwTCto8PkTKkKkHBuEDa
X-Received: by 2002:a17:903:4688:b0:2cf:461a:3863 with SMTP id
 d9443c01a7336-2cf8ddb8b0dmr37487925ad.22.1784714979158; Wed, 22 Jul 2026
 03:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
 <05b2e507-0c87-4f9c-9a1a-846a44bd396a@tls.msk.ru>
 <29875880-d0f8-4bb9-9688-c1d0368cc4d9@oss.qualcomm.com>
In-Reply-To: <29875880-d0f8-4bb9-9688-c1d0368cc4d9@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Jul 2026 14:09:26 +0400
X-Gm-Features: AUfX_mwb0Puv2qofrokaganbPp5Z51XgLdQpgHtnnkMZNoTqJldkg7V2HI_0lmY
Message-ID: <CAJ+F1CJ4jeBpC-U4otG6X2+PWKDG9teicsMbNSaOEmrpQRu0Zg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/qxl: validate monitors_config heads[] in
 phys2virt
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Wed, Jul 22, 2026 at 2:01=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 22/7/26 11:38, Michael Tokarev wrote:
> > On 7/15/26 10:27, marcandre.lureau@redhat.com wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> The qxl_phys2virt() call for guest_monitors_config only validates
> >> sizeof(QXLMonitorsConfig), which covers the fixed header (count and
> >> max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requeste=
d
> >> buffer size to qxl_phys2virt()"), but not the flexible array member
> >> heads[]. When count =3D=3D 1, heads[0] is accessed without its memory =
being
> >> validated, allowing a guest to cause an out-of-bounds read.
> >>
> >> Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
> >> the first head entry is validated within the guest memory slot,
> >> preventing
> >> guest-visible memory reading.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
> >> Reported-by: Tristan @TristanInSec
> >> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> >
> > I'm picking this one up for the stable qemu series.
> > Please let me know if I shouldn't.
> >
> > It would be nice if changes which should be picked up,
> > had Cc: qemu-stable@ in the first place, to avoid this
> > extra round-trip.  I'm trying to keep it as simple as
> > possible, only asking to reply if I should not pick it
> > up, but it is more work for everyone still.
>
> Indeed this patch should had a 'Cc: qemu-stable@' tag.

It could. That said, properly testing fixes on older releases takes
additional time and effort, and I prefer not to add Cc: qemu-stable@
unless I've verified the fix against those versions myself. I
appreciate you taking care of the stable evaluation, but I prefer to
keep my focus on master. Imho, we should not rush backports before
they have received a little bit more testing, it could introduce
regressions - the opposite of what I'd expect from -stable...

