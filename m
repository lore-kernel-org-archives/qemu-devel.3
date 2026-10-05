Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14C9CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfLs-00078Y-KG; Mon, 05 Oct 2026 05:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDfLb-00072v-Nj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:51:04 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDfLY-00077g-G2
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:51:02 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-35120d43ecaso2033176eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 02:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791193859; cv=none;
 d=google.com; s=arc-20260327;
 b=CEYht32tVeSMMuwxJrvtJcFNCstK1yaoZq1FAovIbQIDZCo4LB3ZNFvsXkeWC6pu0K
 qfZZDlZd7st3dsaAB8RvyLNYkhRmAvn3jdEm2pGyadlJvlHjkAGtvRxpR3asfLM5NFzz
 alncikh98nosplUPp1UgpEGi4G7tZqhcdH6sUx1HMPhqOuwKa6s9PCDZkjAzoYtZs0Dt
 wuI+lZwA6T8/pDQMUJAsHuUNOSPqawXSUzdSeGVIZwJmFa4dv3HCN1suIzasaJulXtMC
 4WhXtV0R5TaAOOtrfCJjkhx1vjqUw0xWk848576paWhWTexFfK9IuiHjrex+FidC00yT
 lwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WC0eN5xNl2wscbX4IwNTFrP3/uP+9wHSY2pwZo86tBQ=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=DTwBlmhdk3s6k335eS5orP+cm+6RaDBVp/Z4KnTG8ngbipvEkBKhD6eZalDa0Kn1AR
 1CXCdrgF/vo90BdKvEx3NV8Rpyx2c9ASWC7myE/bgXADPNAB4nnHnBZBHWbYdRYwTzU9
 K1wm9jN+yA7TfYEZMEetSJgXgi0BuIwMoyBTKewAouOcZ0DCGgjZBxvU5Dw41ehK2Gi7
 13jCFTAw2O+26XQ7bIba0YqW/BqoPAcC/hM/i8bc9wyWZXZudO4R9UP2SPWRDmh77rUx
 emqbVOyr4ggq9zZx2zQWOlx+NTrMT7dD3QRRytEauwEoP83NXIUmpS/+lIBKOtCMoD6g
 rVPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791193859; x=1791798659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WC0eN5xNl2wscbX4IwNTFrP3/uP+9wHSY2pwZo86tBQ=;
 b=KkHPMp9isuOYPTEApbC+E2PLqonZu2rmzXPzcgmkIoOKh0oMRuHGy7uc8hxVhXmlnn
 gIjoXl5cdZJWFeV8f8V5k7x1FNC/qdIe7PZg1VrJyxMN+uO+dHa+gzsz4kBSjc2TGaq8
 f0DPwZkL566Smt/H2cor2eXdBh+x0bF1YEvvZY7fUXQVg0+nHqRk6NgY3uraoZzO78cL
 arspMKLdfOMZ2hS9YpQRi+dBzfjkgQN+3HzVeOEqf8zL4So3zpdgNO01tCaRO7cXQhG7
 kNBCIfOE0640J0CmQ/+8QvNnr63jv+72/+q8gxW6G9+KH48b++L8bgJUG0LaLKUklWkA
 4rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791193859; x=1791798659;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WC0eN5xNl2wscbX4IwNTFrP3/uP+9wHSY2pwZo86tBQ=;
 b=HMawMyfaPBDCD+sF11txrNafRq3k0AK7fjJ6VODiMeKUAkCi401a/MOv4MT8SZVLfD
 PbaSv+T6kcEG8NPN/so9jMSedKipEILFBzrFeVqXt3vjtKPw8X+2jNWwZfATPVb5jzjV
 qWu6Zt0pTf/8J6J8mBMulvG+lWtVhB/WMpbvdgiMF42lUGjTIh2qruCaq33XtfxSrwND
 +jsrz1SVW3Heqo7lJ0G3a879sR/4pSc9rLVqe6e9AFJvM1Oikf19GL+xu8uFiXeSYc1x
 YHzwDw6fg2HA0tZwr9vrLNsdG4b9FVeju7/5OLJGRu60wbPvuoCXDefG5qnJpxOQCGje
 6sEQ==
X-Gm-Message-State: AFuF++mmIBV8FVBdWTv9Qbq2Egjqu08EmqSsSXsQYgFjGlfYYNLcrJtY
 jlRb0Lr2ihANQfa6Qwiewv8nQlFqXkAryOTYAUee9nWExTx4xhMGIGqv394syqJGhkiOgsEvGeN
 cqfBp4b2vhCDXjShTaLTPZtMP/RzQB6E=
X-Gm-Gg: AYBFou2fGpiLqU/BfpKipFpng9TFzNiegrvnXiCxkLeCCWGztWkDcWOzj7fMpi3yZQx
 UxNqcdfAlXZjv9f98B+Keq/W8e2kdr0PTWdtNsFLp/Wd/CviWF+GScw9rdk+UOmGkSxit3X4Fhg
 mtYyy2Duvr02AcESX39AFgtorrxZOdJBf7iy/Z2ycFyyxCV88zvBbnG/oaz5MP8jvC/6Xn5WMmx
 Q6Jv55LecnFAXvaHHjkM2kOHqtbmV3NuNmFBbHqfUfkNPS0amMubTNKZpNe4SGG0aqWh/x1sslD
 wZZ1RtQ37+tgwWs/kQwRgJd49o/w98GwSD0L5wjUKxfFMNn8pK8YLGDTQ8zyALp1C2tIpxTQ+cM
 JqZCi5U2BpoE=
X-Received: by 2002:a05:693c:864e:20b0:351:214a:de43 with SMTP id
 5a478bee46e88-351214adf20mr6897156eec.17.1791193858765; Mon, 05 Oct 2026
 02:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261005090056.32064-1-berrange@redhat.com>
In-Reply-To: <20261005090056.32064-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 Oct 2026 13:50:46 +0400
X-Gm-Features: AclHuK8noDwSEWyPJ4Ulxiy7NA6nq_CIrQtdzmgtGDKr6owjew--6nI8WeOu3DQ
Message-ID: <CAJ+F1C+_6edJJSkKrBqUA6XUwmu0QLCGsvjKWBcKUdeY95bwVg@mail.gmail.com>
Subject: Re: [PATCH] seccomp: fix blocking of setns/execveat/unshare
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
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

On Mon, Oct 5, 2026 at 1:01=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The initializer for these syscalls missed the seccomp action
> field, so it got the default action which was to kill the calling
> thread, instead of returning an errno value, which the other
> equivalent syscalls use.
>
> Since we don't ever intend to use a seccomp filter without a
> defined action, use an assert to validate that action is always
> set to non-zero.
>
> Reported-by: Igor Santos-Grueiro (gitlab:@igorsantosgrueiro)
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4600
> Fixes: 4638057110 (seccomp: block setns, unshare and execveat syscalls)
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  system/qemu-seccomp.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
> index f8e1238b914..3889d48b4f2 100644
> --- a/system/qemu-seccomp.c
> +++ b/system/qemu-seccomp.c
> @@ -249,10 +249,13 @@ static const struct QemuSeccompSyscall denylist[] =
=3D {
>        0, NULL, SCMP_ACT_ERRNO(ENOSYS) },
>  #endif
>  #ifdef __SNR_execveat
> -    { SCMP_SYS(execveat),               QEMU_SECCOMP_SET_SPAWN },
> +    { SCMP_SYS(execveat),               QEMU_SECCOMP_SET_SPAWN,
> +      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
>  #endif
> -    { SCMP_SYS(setns),                  QEMU_SECCOMP_SET_SPAWN },
> -    { SCMP_SYS(unshare),                QEMU_SECCOMP_SET_SPAWN },
> +    { SCMP_SYS(setns),                  QEMU_SECCOMP_SET_SPAWN,
> +      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
> +    { SCMP_SYS(unshare),                QEMU_SECCOMP_SET_SPAWN,
> +      ARRAY_SIZE(clone_arg_none), clone_arg_none, SCMP_ACT_ERRNO(EPERM) =
},
>      /* resource control */
>      { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL,
>        0, NULL, SCMP_ACT_ERRNO(EPERM) },
> @@ -337,6 +340,12 @@ static int seccomp_start(uint32_t seccomp_opts, Erro=
r **errp)
>          if (!(seccomp_opts & denylist[i].set)) {
>              continue;
>          }
> +        /*
> +         * action =3D=3D 0 is SCMP_ACT_KILL_THREAD which is not
> +         * something we ever want to use. Validate it to protect
> +         * against missing struct field initializers
> +         */
> +        assert(denylist[i].action);
>
>          action =3D qemu_seccomp_update_action(denylist[i].action);
>          rc =3D seccomp_rule_add_array(ctx, action, denylist[i].num,
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

