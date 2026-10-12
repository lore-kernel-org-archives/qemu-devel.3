Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF61CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDP4-0008UE-Q8; Mon, 12 Oct 2026 06:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGDOz-0008Tr-D9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:37:05 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGDOx-0006T3-Lw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:37:05 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3514b90bb89so3302021eec.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791801421; cv=none;
 d=google.com; s=arc-20260327;
 b=U9SH4/AF+iVucNJMPx3zu0TuJ9xtZ4sJBwtxz55Kwh2uPYrt3+zxXDrqO+Jt2poPnG
 4CvpZxCfKSaN8wvkeF6SpYilEpM9w0twAcQg/wzAGIX/mYf/RoJ8H+pZKxma8sdrWzeB
 lMGmllmN5oEMy5CcVmuXnN3RY9wYEtFI5UIoxsfykdJIZBJNTuZMTE49XP6KMbBFc98B
 iW/jfebtuADvmexXDf2B4rorYugfnxpN+YCJBHC/nnwJnZHhMcNrXibpvp5JeO9gTEmg
 xe0i5PnANhtnOR2oeGRRj8yI26M/2EW9VvsXp091TryHofQKkzzSZhOkOGUunHVH0fxm
 gZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zG3e2mRUDgwR/RY10ns2nc31lnhibDYIbUcTE6ZvAyI=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=LOZZNx4/jtr+Jmmd+XhV1s6SLiUedf+umOklCq6PFjlzco/Sfnm3ybaafAbxw7Wp+7
 HNVdalekbMcP8eR4h8Vgq1lSUDA/VYkDJZUGTkO4VEs0vyso97b3GkfMeWXNNZySOB2t
 XUmNOQPr3tLg1abLq1PetKKantefd5xVJgVfLb1KmKPG3VUfXNde99Iv0RcnBBFV/H0s
 ekdE4YdFbpQvVJgaOmbQWZ7HZ16ucoDUNSTD8rv6e/UJE/EtBzhqi1tiS+rCs3HbCXKI
 E3f9YV68xZSErg9CeZwXzKeWxXYeEWJL5SIvjE6NWppFoAgyo3wqUpWbJ+5mQ+e7I48j
 /x3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791801421; x=1792406221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zG3e2mRUDgwR/RY10ns2nc31lnhibDYIbUcTE6ZvAyI=;
 b=WUC0KqvX88TA8nPxJr6h/pYXdL3ae3budEDk5/70g9N4QjVzdZW+M54oyJ9dzhX+cy
 x0S4trEpovXzDBOhenXoIMzIxmGOFuQgiXHc/mM9OdBL1Duw0BHUoRU7DU4+1EFF7WQD
 BA9mhS5j0T7tmPE/rNEcEcpSEt2pqwAvYm5YcEqgjG1mj5nanaz3Vu0rtsGvNOTqcrVR
 NNg/dGtWeAoOaEhxkKUR/XeTdRrzFJX1gES9uyLzB3OkZPm8ALMWBAIR81EjAUXnXng2
 4XyLWZ0V8nHb1+KS0IHwXiBXFaX3XSSyg6RtDu9EVb2kuOOAZgvtRyU8ivhzFZn+9wro
 cyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791801421; x=1792406221;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zG3e2mRUDgwR/RY10ns2nc31lnhibDYIbUcTE6ZvAyI=;
 b=Q5at7e6xxtqTXYM1LdC/eaAwYgM7k9rxUoSdxjCX9ogovPNLoR7mdDrIO1yPro1J+V
 7z/m9hD65BDiNoTbCY61rDvk+z8Bk3aMmbHQ/5PbuLIuq/HfcEWKhJZv8H7ZZR4apSxH
 6r2e5g9H4JDsNmPFfeITX+kPqg2d/9P/rHrUbL/YmsiK2qNFpg/EGm6HoVu1U27GvsQn
 g9IalB+Pt47zZV6Y0h412Q1bIvBS582EW4Xoyy/Y5p1RngTMSHVNF5vBQDK9+xemM94Q
 ozQ4fXI7K5am6fhriJdcP7BzBRERDC0JnqimJlsO+XQqlRaGmKps41i69HM3087ckRhm
 m+4A==
X-Gm-Message-State: AFq9FYKuBjuoLWeAgWg6iZOM2UxMCIYvFbtnw79Vj3W4sOn55AeuMePF
 Q07cU8diiZoRhSIlV0GsJLjyh+k631NT7CuxcZ/5YGKNLts/dMVtmuVBtCAfSFyyLlhqQ/qCOp9
 ZAUnTKciKpXob/QZPgrM+R6ED+bpL/18=
X-Gm-Gg: AYBFou3u4VozdzMfmy6WS1RQKVvjBeI6FMEHxUuAnJAdRYBvBMUGm1QjbH2q7V3stfi
 epQd/Vr6Tn88XOvAkd0CnzOCC+ZX4OtolAZxvxU9TWoWk5IQiJkUsQXEV1RiEfIRyTdoRJCzzr8
 8hPzgh7K0IeAzv/JNLgYc+jXUUyhxhtwWN7Zv0RVGIJnvwPCLnOzw/6xiP9BTymrWA1SoO9GuXc
 GDpza1/JZErVSWaoWvA4BCr2DhNnsZT1+cCQ8jOxlPEkAEMvLnWDn4yo0Bcd6bg5igJ+irz6DE9
 5VyoSO82uHDd9oXMz9VBEZXgQAPF/Z6VxPv4Gv2ZBzION7dWo69yyvLs41LO95XgSMAAw0nP2bP
 yjjBvh0LcZ0U=
X-Received: by 2002:a05:693c:895c:20b0:351:bb8f:540c with SMTP id
 5a478bee46e88-3537e04f58fmr13984795eec.35.1791801421304; Mon, 12 Oct 2026
 03:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261012101144.58085-1-berrange@redhat.com>
In-Reply-To: <20261012101144.58085-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Oct 2026 14:36:48 +0400
X-Gm-Features: AclHuK81cZNgLYSNN8QbZoDRNU8QZ0TexPXZgDnMuLioANIfkCvTMqtbGKmxZLo
Message-ID: <CAJ+F1CLMi6rXfpd3SvdEYV+GtQ2Z8B_og_K5+SxcCQd+ydi=Ag@mail.gmail.com>
Subject: Re: [PATCH] seccomp: really fix blocking of setns/execveat/unshare
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
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

On Mon, Oct 12, 2026 at 2:13=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The previous fix for setns/execveat/unshare mistakenly copy and
> pasted the clone_args filter, which is inappropriate for these
> syscalls and had the effect of weakening the seccomp filter.
>
> Fixes: f33fb19cab (seccomp: fix blocking of setns/execveat/unshare)
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4671
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  system/qemu-seccomp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
> index 3889d48b4f2..cd2c1b0b747 100644
> --- a/system/qemu-seccomp.c
> +++ b/system/qemu-seccomp.c
> @@ -250,12 +250,12 @@ static const struct QemuSeccompSyscall denylist[] =
=3D {
>  #endif
>  #ifdef __SNR_execveat
>      { SCMP_SYS(execveat),               QEMU_SECCOMP_SET_SPAWN,
> -      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
> +      0, NULL, SCMP_ACT_ERRNO(EPERM) },
>  #endif
>      { SCMP_SYS(setns),                  QEMU_SECCOMP_SET_SPAWN,
> -      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
> +      0, NULL, SCMP_ACT_ERRNO(EPERM) },
>      { SCMP_SYS(unshare),                QEMU_SECCOMP_SET_SPAWN,
> -      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
> +      0, NULL, SCMP_ACT_ERRNO(EPERM) },
>      /* resource control */
>      { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL,
>        0, NULL, SCMP_ACT_ERRNO(EPERM) },
> --
> 2.56.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

