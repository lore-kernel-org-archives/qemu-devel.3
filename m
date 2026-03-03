Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88918EC144C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPwW-00023z-18; Tue, 03 Mar 2026 08:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxPwN-000225-Rg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:37:37 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vxPwM-0008H1-CI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:37:35 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-5ff28393b18so2852679137.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772545053; cv=none;
 d=google.com; s=arc-20240605;
 b=GnWIKRwTAQGBXMIWYnakywqB9V3VZvHiaFy5pimHfikUFN1fk1eM6ZU4nETdBBpfx+
 6Cc+Li+yLM3JxuRJX4WHYQACqU/5FsCc4nfAN18ioRgiBltfuBiEyoMqmM5r/RZkkCVo
 txApdYXrTxiEwXtHWQL9Urv6imNdXB3xSolf7V6u5iEb10H1dx6CPmQd3O7XpePrgsrz
 HUW0gLuVB2wu7/r2Mk0llGFTegzD+lzDNfc68LssIvYFbvPy7suFRrf+nE5INHp91W8N
 TDSaYavDdgcBJz5ujSFsUMGVDovaINQREAWXVc+yZU4CK+7/kFeS0RkdMpcq7FguYXqg
 tYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y+pc8Am/83eFSCLtBf7rRrQqXxSzB0tSwGbDa2QwP70=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=eXdWDuQtnAEnwhGM4e3dUBT1I+niZs6Xj/2Vd6FGw1ZPs9kHmX4VbIVAZ2GLTkStgA
 fmnl2eX1mXBRjvrWP/QsmkQ6X1WYVoSpSnds7UfNp4XSZDAj4H64MNy2/qNiG9YN9/uP
 BpUB42irwEJbFtQgE4g/9wr3CQqREtb4M30sugajc/Xc62h++UHC/qqM0Jx7b9/pXHsX
 9GKRuWc/qFH24ugUZ+UaKsKyTZKFLKSYsAHDNtzOyuf22QhKOBkm0vtOsI4vJcSVhEhy
 r3fb4ouqIv9PhwlEzgCCmD5SL7GfsS/nwtqMNqM7MN27HPy7GJQF0pc2n3BEbQp34P7j
 gkWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772545053; x=1773149853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+pc8Am/83eFSCLtBf7rRrQqXxSzB0tSwGbDa2QwP70=;
 b=HbI7XNxJzEM96+WwBiD0c4JUkSLypu2pDASL8gOBUAOam2Z9rAkeo2pXXuMBQBK5u3
 phfoUnPI07rHZwrmMB6hYMIFmZw/YPO4QxtUydlmB6U4JUi8omG07ZkHaiwYYzdsiWg3
 pI2WOAKOjvxqoc9xRywab+EhmSOFlis+Wc+YT8xZ40QxnUWqujB5U0I5PQeNaAgJ9Ues
 mvY/Gx9Bd+28Fp9wJBCalwQVJUzAlR5k2BOB05m+fAgrJ4EEtqmmTR7pihBMFMRFG4/D
 sS/ZG3E4wdcJgnWIBub8RHkx+OiejSy15u3ovQC8ZpQvlIsKjJFem6cVqGjc+dUiUCR8
 tU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772545053; x=1773149853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y+pc8Am/83eFSCLtBf7rRrQqXxSzB0tSwGbDa2QwP70=;
 b=EFF+cvLTm1E/73HCL9I9aw+JM84xkx/jY3R+z1V/bNdb760qRo1R4ERLS8NnTX+JJU
 CO7tewuMwpXR4VI9+71D8/IyadA7cYhRZU/Vbe/OW2b6Kp0Ubnxz4zQX/6UBFbHCVuLR
 UtRx544wJY62HEIxjYTvmFrdnm14WxK19S+o3Fy3JdNlRPQTzet+qsuBFxcASxnJJVZZ
 TwTRaXnijsLkS7EiyYAyNYG2H8o96Jhi5PCXbo/r+r4v9C7A/TXQI2ASaKzdavegZN8F
 Z3n9FFLeQOkoVrKKrCdP7mKQRODnOayMFxODQvbOcXkn8v7QYft5UL+yJxyIUQcZkZ8I
 XjCg==
X-Gm-Message-State: AOJu0YyZmdeIUb0nlQlp7cptwvP3E29eaS/JYUYmF9aBnOYTXaMvLXdg
 zYD5d5673EImPlb2VPtrsdFU3IYHBYb/207TDLw7lc7/8F+JzOfkvLhXm5B6O+fhUDEmZC96d2b
 kSeoW8DLkGiX0EQqLprUv964AOX2k2I+0viW6PbX/KtZoYwg=
X-Gm-Gg: ATEYQzy+Bxr3vAWgay4c07+bls7u5oyouDb7bkBcM2SoOwTpPlBI1t7sEmhOHS81H6p
 hJnXybbNfCGjZ5kxGrFMx3sH6zi/Ya29ggOy+E4kh2Q0Qj0EWUXCwGI555QW98VNr1Dnd2UztFP
 PWHAndk7QLEw7vMR4oKw6h1bA9RRKaCFYO/hxBbs1Qv0wR2m5LcF65y3hKuELl+hzQTUDD98kd+
 jVIv/so8Ok1WO6xSmmLKNeWCh143EmA+I7s/nh34Za5P1TXj61/4SbUxZh9V/ULtiDpKGiSK0Di
 9qvBLU98Mcyh6xoQ0NevqMF1OFTnVaQH5E9g9AQ=
X-Received: by 2002:ac8:548b:0:b0:506:1d0d:c159 with SMTP id
 d75a77b69052e-508cf0d05ddmr15371381cf.2.1772544346246; Tue, 03 Mar 2026
 05:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2026 14:25:34 +0100
X-Gm-Features: AaiRm518LVYufmC_sK6iD4Vb5r9egjn3blXeRkg7rQjrBsPAGu0zEnHhZ3ctrfE
Message-ID: <CAJ+F1CLHR-XsLPWFsmEJbypXRhOG=EEQ1734RU1a_MoKrsEC7g@mail.gmail.com>
Subject: Re: [PATCH 0/3] ui/surface: Avoid including epoxy/gl.h in header files
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Mar 3, 2026 at 2:11=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> include/ui/shader.h and include/ui/surface.h are included by files that
> do not depend on Epoxy so they shouldn't include epoxy/gl.h. Otherwise,
> compilations of these files can fail because the path to the directory
> containing epoxy/gl.h may not be passed to the compiler.
>
> Most variables with OpenGL types are removed. The remaining ones are
> GLuint and replaced with uint32_t, which we already use for texture
> names.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Akihiko Odaki (3):
>       ui/console: Unify pixman-OpenGL format mapping
>       ui/console: Remove DisplaySurface::mem_obj
>       ui/surface: Avoid including epoxy/gl.h in header files
>
>  include/ui/console.h       |  4 +--
>  include/ui/shader.h        |  2 --
>  include/ui/spice-display.h |  1 +
>  include/ui/surface.h       |  6 +---
>  ui/console-gl.c            | 74 ++++++++++++++++++++++------------------=
------
>  ui/shader.c                |  1 +
>  ui/spice-display.c         |  9 +++++-
>  7 files changed, 48 insertions(+), 49 deletions(-)
> ---
> base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
> change-id: 20250510-gl-e6d2c89816cf
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

