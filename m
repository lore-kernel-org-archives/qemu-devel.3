Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3A2CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEO9W-0003oo-Qc; Wed, 07 Oct 2026 05:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xENvy-0002f6-8v
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:27:34 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xENvw-0004zn-Gl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:27:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2e8e738ae0so229898766b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791365250; cv=none;
 d=google.com; s=arc-20260327;
 b=jjUZwBthfvu43xRP1cd3d8uKJPERBygGDktMWF/L+QM0QTQMS9J74rwY31aY9mdsNb
 NGEcFBi5EarUKqDLRtKqgDzk3jfC6YdT0mWy0UhgGPU7Z9BYHiF3rFIVQFIMTLZIsj4P
 Djcl+nuel2CSYFUlTcNL5ek3p+hzdROuFdSE4RykxwExIyyVUDe6EY9C4/xx8aDK0y0G
 zhR4WFwqQcMnoO9VbUBkxoENziQ9HzGJKnYeGYO0jE6Bk+nyJYth5epORWE6vFH9PvyX
 QKksw4JSrBECj3J1QLWBIqAMgPUeCdkEyvJpIiij6Sk0FmYnRkTgbU55RPoF6XPu9Ahc
 Ci6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=r0/jgHzLPIZ4ZJaM6hp8kL+6vddbwSUPlrhLZQ94kyU=;
 fh=Rf2FRz2f6v7UzNXpm/2mOpceTA62539SES2epONmX8A=;
 b=fPgYSPdj456ZY1mWMVZLFXjGBXa5Em3UW2EtxR9quoSBNExL3RPawfYd/eLLcVgej3
 D4Jl7k1vPKvHemc7+3aI9LjpsM4Gf5LYdzWM4m2nsHxKUl+Bl62fO8TYt2NKWMjgo/EH
 r/CCCHBTykir4Q63VHn0VxKY+lP5pz3TBzGl9ZZNkvXv3+EKccpMeKAkIOnxNQCGRKO/
 m4xCU7Dlvd25P7O9+2BWzdonHKORyo9ViZ1z/B/P7azl59F2ACxVUaQ1mD/zFN5W0tzA
 vkFb+Ho5bQRrPB1lawKWFsoaBv6R6Ns25uX8cdAg6AQOF2NfD9iZkqh5jwkvBhqabOT9
 WauQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791365250; x=1791970050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r0/jgHzLPIZ4ZJaM6hp8kL+6vddbwSUPlrhLZQ94kyU=;
 b=VNjnjL5RkSCHZVN9C+JSNgoWSAAz2cfWaUyd1HPSwRaMjNNLVbsD3E3bv1OxXPMzED
 fHRVD46aUVDOltv/mSQPjIijSRrzYZnR7MNulwZlptUfPNmLTyghcIMGcsD5laZY/6w1
 SubjdJeoeJ8vtoiuuw0jL8GYm/7jTrZKoapG6bIY/8Jn1zSAr4qy99O2tkvKLqhx0Fwq
 JsnhcFxBeSd3XS7i1J0BzAAPy8EEZkEqVcAyHwmPxc+DO+zMEv4U2vwpsElAugpr7beT
 +wERYDxeDmfkhYqRK8AaNOiToYPoQcqAh0h2lnJfNcQaPvnYSwl9KnedT9HQI5Afc8r9
 s72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791365250; x=1791970050;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r0/jgHzLPIZ4ZJaM6hp8kL+6vddbwSUPlrhLZQ94kyU=;
 b=2Kvmi7qZpZAUHdQowXwjfatHpHv65wPqkefSHMVLnA3uPMgmueWaHkcHaF15XxQ6cf
 81Q68xiyVL/rkzJkViai6IHrgiiBztoCBKHRJf2zKrhtivV6pLvG9LIyBREt4s2eqDeO
 8HA/2qD8LxK2xTFiVwzKD8BfSJAz5GdksyXkz2AhG9vyUq0VodfxARAHFCiWqOOBClUN
 XTmP3dYif9z2EvItJqTXxjwMNb2K7zYipQhi3riYHgZe0Z6l3lQdVZbWlj+2k7naV8mK
 9tW1q3LihFl9ArZ05+wfIBu6bYdmy8Qv2a19K8p/OiHpeIdK8iOjv67idU+TskvblyEj
 kzrg==
X-Gm-Message-State: AFuF++lVhYDgcxeFeiVbrdRo9/9l0MRuryE6o2pOP73aS31MxVwLuhqu
 q86LSrFKnQr7dXAsak1IXY29ZhzF8vv+SRyBJiDSpPafJ3RrkcDwSyblLOHZVSSxGQec5IIoSA6
 uHTdADA1S9Xo5VF6dA6Yv0LBe+f4KoRk=
X-Gm-Gg: AYBFou14BbfytujyyapoynA4VxjYeoBvRG7lpJhl+JwwsarAjV47HR4hzcbLOJ4OEQk
 sgDgigJy/w3jXvzFH++OCHDNVdsgxq8eypSQiHEuK4l9g9QmdfJ9DPaAtbzuMYYX7NvE1pQ9hBN
 qiw0DRc6oj/2xSsEegvjkGc7c5zeMjBjbwZFgPdokgcywP/nHY8A+WRL1nBEB98Ib3oTMrvU/UM
 csBIQ48+f19S5pVnIkBjSs1hQXb7eIG8V5F8gazKzFSJ/oBpimi9+SriRcNqnEwNw6NFgyiNkzn
 M7L+NiBrqZ+wJZmVDEWxzqu+rc+H0NIjKYq3szRa0KwN1JGNpbfXibbijrA/u868kA==
X-Received: by 2002:a17:907:94c5:b0:c26:1649:47a5 with SMTP id
 a640c23a62f3a-c317bdffebemr143297166b.27.1791365250436; Wed, 07 Oct 2026
 02:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 17:27:16 +0800
X-Gm-Features: AclHuK_N9fttBxcjR_gmxlAgV8xxwn0f5rBRxjAUZ4w3lhzB6lxnvKRufaXnoAQ
Message-ID: <CAE2XoE_6L6vkjjDM5LfXpy34-CP=4iJvAQK72qeB06TgvKPsSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x630.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Why not close: https://gitlab.com/qemu-project/qemu/-/work_items/4640,
I'll close that directly.

On Wed, Oct 7, 2026 at 12:03=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
> based on endianness, are accessible through TARGET_NAME. However,
> TARGET_NAME is a string, and thus can't be concatenated to generate code
> and retrieve matching SYS_EMU_TARGET enum entry.
> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
> identifier.
>
> There is one more subtlety, user binaries have extra targets that are
> not present in SYS_EMU_TARGET, like armeb.
> Thus, for user binaries, simply export TARGET_ARCH.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index cae1591cd28..9bcfe84daba 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3288,7 +3288,14 @@ default_targets =3D 'CONFIG_DEFAULT_TARGETS' in co=
nfig_host
>  actual_target_dirs =3D []
>  fdt_required =3D []
>  foreach target : target_dirs
> -  config_target =3D { 'TARGET_NAME': target.split('-')[0] }
> +  target_name =3D target.split('-')[0]
> +  config_target =3D { 'TARGET_NAME': target_name }
> +  if target.endswith('linux-user')
> +    config_target +=3D { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
> +  else
> +    config_target +=3D { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
> +  endif
> +
>    if target.endswith('linux-user')
>      if host_os !=3D 'linux'
>        if default_targets
> @@ -3372,7 +3379,7 @@ foreach target : target_dirs
>        # do nothing
>      elif ignored.contains(k)
>        # do nothing
> -    elif k =3D=3D 'TARGET_ARCH'
> +    elif k =3D=3D 'TARGET_ARCH' or k =3D=3D 'TARGET_ARCH_VARIANT'
>        config_target_data.set(k, v.to_upper())
>      elif k =3D=3D 'TARGET_BASE_ARCH'
>        # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
> --
> 2.43.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

