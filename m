Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354BDCA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC61T-0000QB-EO; Wed, 30 Sep 2026 21:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xC61Q-0000PA-Oq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 21:55:44 -0400
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xC61O-00087I-R6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 21:55:44 -0400
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acbdf627ccso2901145a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 18:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790819740; cv=none;
 d=google.com; s=arc-20260327;
 b=KOXPSo60fAx7LhUnb/n7T550dGpdzbFsxnKsp0f9HzdFx9Cp9lwdjeSKTux09tZsFh
 fT7F8XN9SgSdPPKI3K+bK8+3MKGMDCj4C7FB8C4rTLmfVhbzVqXqvjXtKlzGoJpTITEi
 pwS7ksWK6ffMUguE2fJkbGkUeZQTzqDrlve4aLeruGKGdw1n+COlSAtZ8QXgSpLB9ftA
 yXBwW9cIj+ZtQr9JWhAsKikjr1CcWCaGRYnWvUSKPOVcHvghSD/SwPo1A4jI/Db3/2N4
 LGDIm9jnEPEiTJ/XHXAKxNp3/Ld3UIAbeahA/hfP1KoDxOOI88O6BAeButNgKOZWRuN+
 HkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=eslYiYXFQvDxr8kUaYGFBywuo88FVeT2naogZDh9VQg=;
 fh=pS42xvTpIuaUSSfWP0KHETKPUIOchqwI7/2RYG7wagY=;
 b=p7QJDdd426NOHGdTczgqCblnZ4waBecfxOqVGD5n6qW6R2wBKY6NrByKpnaIe2ebu+
 Mqhc/8u8a4gv0dXECBHJeXLqlIJwVfnsr10YssCfmk6i2AKe0sOKO/QB62fEdgc0TqyX
 DI58pi0S81e+ijdTaI4LJzEtYOeBTiffLyIK/jXwirotZCEhGI8av7BMO5BAFZNekcWV
 l1AA+yJCTGJUEXark/1lsUoyrbYKqI0QmnC8alrowrqkKRTsEyBL3sL56xpuG6rnZ7bn
 bAKpmbJBSgdwWWsSe193UddlTuaduDy2i/JVkdWjAVA89MixwRqdB/L1JL9xd+Roj2vB
 oNwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790819740; x=1791424540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eslYiYXFQvDxr8kUaYGFBywuo88FVeT2naogZDh9VQg=;
 b=Dl6nfn73G7rZeb6hw+dgXs2YhoJvKtRj3RkDIvLAthbWcAINlsTDsqYfahtt+8WUz6
 FHQp1UhxK+VghcufHjpzy7Vftb1VKKyxXuZZIuFVbLdJMOl7tT+IsjHFg6KZaf+AnnOa
 vWNjn29jEAgB6Nhk6M+e82vUjYutZuLucsq5o4Z0zvvAuPzrovoMpzCQqEPmX4ajpkEl
 xe8ns7TFoFIPlxmTCWpCJLjWMHZOQ0VwlRWKcBthPHMYm4BFPMT0d/sX0hp4t0pEErtd
 dj/GmCWwI07QNJoY/6T1jh8wBAXmA3PTDGgEQxngQx2KWQuSYracWUFfONU006OhFLuN
 rJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790819740; x=1791424540;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eslYiYXFQvDxr8kUaYGFBywuo88FVeT2naogZDh9VQg=;
 b=Ijz3T2NWeyMr2lV9GCCMkAE7lnEenOIBjAdVs9ge6UOC+7YGRYD7OG5F0f1snOgt7j
 yePjIXpGT/pMgju1GhJPOUHyxEzRT7fA7/TQNfjulGTo+HYnd+sMVRX25QaP3FQSZ9lY
 IUTOadTwU9BMwnuslhBQ9M4PEQmg2vYyNk1x4RfdPL/oxEc3B+iSAWwhtf2JvNpIQs+c
 WoWMD1+ZSEI4MUckdjkQO3gsd/WVWsZ2rArn/XKDZVnfLVhmooRQLZ0jchZSAgtbZd+z
 qBfWmYv0+mCboCj9UPiWlaos9N0ErKCWa7iKuN0E0i1ZGc/+z7ty22/XW+Cq2Y9EthNr
 i7Lg==
X-Gm-Message-State: AFq9FYK6e1qu6CKNgvcH60OrvReuJswQVQ7syRCR5itTY13NgEb0jXqs
 Y9snq3pXFlXxmttU1EI2WvzIai3N436av4pXiKo867ZiGP7mKzMxlTW8XlXdfXPhiDBhNP3Yck+
 09dmAkMWmJTYOvEk469alvFpu5ST9Eos=
X-Gm-Gg: AYBFou2wcYJg5ZzcIOtYrxGSVPOQn8ppGtjpcOwGBNH0nW9szxUvxQaLTjrC0winzN4
 /6fjawRnRvZTSjN+giyuLHDYylG9PjkN5UFGo+k7YOuBFjl2YvMLiAp4DiNF+JjuWcRAVyoeUNE
 qGVtVNL+CwzZVWs8IgPRR22VcIXTaXyIlKxLAjNX87A8PtKYle/ZYXQUbBpgn0LYMJ/3wjmRO7V
 sdaS2ydvico5OQZkkl86HoGhPzwPbBQVW6MJ86onMt6qjLP0dSJSGCnWDKQw9/alCwmFIOfzGSa
 4TXRq0E6UTz4odHzMSbrAj8lzCLCMTCVcRsPWYbLAoJ+NMuW3OLGuBk=
X-Received: by 2002:a05:6402:324e:b0:6aa:e3f3:c9df with SMTP id
 4fb4d7f45d1cf-6ae1990a414mr1888551a12.20.1790819739766; Wed, 30 Sep 2026
 18:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
In-Reply-To: <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 1 Oct 2026 09:55:27 +0800
X-Gm-Features: AclHuK8iKySxkV-kuCqxi1orzJ0ulN1pyKyKoz4DyA3W8FBmB8_29BliGBNMTeM
Message-ID: <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Stafford Horne <shorne@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Song Gao <17746591750@163.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 1, 2026 at 2:19=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 9/26/26 1:15 AM, Yonggang Luo wrote:
> > - Add machine_class_set_name() so boards can keep a stable -M name
> >    when the QOM type is uniquified. machine_class_base_init still
> >    defaults the name to the QOM type without -machine.
> > - Document that MachineClass::name is the -M name, not the QOM type.
> > - Sort -M help by MachineClass::name so order matches the printed names
> >    when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   hw/core/machine.c        |  6 ++++++
> >   include/hw/core/boards.h | 12 +++++++++++-
> >   system/vl.c              |  8 +++-----
> >   3 files changed, 20 insertions(+), 6 deletions(-)
> >
>
> First, I'm not opposed to this series, and if anyone wants to pull this,
> I'm ok with that decision. It's just unclear for me what will be
> direction after this step.
>
> If I understand correctly, the goal here is to allow to register
> multiple "virt" machines, while still having distinct QOM types behind
> the hood, which does no affect behavior of current binaries who have
> only a single "virt" type at most.
>
> That said, if we project in the future where we have a binary with
> multiple of those "virt" machines, how will the current series help? The
> situation we'll have is distinct QOM types, that all answer to the name
> "virt", so we have no way to select them individually.
>
> Slightly worse, find_machine() will just pick the first machine name
> virt, which is a non-deterministic order at the moment.
> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=
=3Dheads#L846

That will handle it properly. For single-target binary qemu-system-$arch.ex=
e,
this won't be an issue, as there is no conflict as they won't be compiled i=
n.
For multi-target binary qemu-system.exe, we will choose the target through
-M $arch:$machine, and when no $arch is specified, the default to arch
to be "none",
so still won't be non-deterministic.


>

> A possible alternative could be to use ".is_available =3D target_X" on
> those virt types, which will ensure only one is effectively registered
> at runtime, thus, there is no ambiguity on name or who is the "virt"
> machine.

That's the issue I want to fix, ensure it is registered at runtime. So
we can list them
all when a "none" target is selected.


>
> Again, I'm ok if anyone wants to pull this.
>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

