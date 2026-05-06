Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E776CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcVH-0001oq-2w; Wed, 06 May 2026 09:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKcV2-0001av-PJ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:41:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKcUw-0008Bk-Hb
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:41:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so3462227f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074868; cv=none;
 d=google.com; s=arc-20240605;
 b=ZrWppGeOC2te1eDU/+0rpoeMoE7faJTS3o/SSlGUDaTzP2UO+6XD/uDqspfdSf6oC6
 wDdieXII6rEfpLph1++bmhbrrmQXOApb3nOWHbKnUwwdVkyldcbttn7RYizRe/SPrq46
 sizy5RMxIWDAsw73NYotB4B31MMHcCuz+XDQye/0tR73WNpIHVVzs1yR04ES+YZpZtDm
 lzzq5AHuGx1RxEvchlLGNzBaad2Yl3EPk3iSgNpYBeACy1Z8Meas4HIlcXqy/KW1z9OV
 KWNXOULkK78nT76PQJWACW2kee8iqqIBVxFY3tFKzfnK5xuRngcs+tvq68rmqe8LEm1K
 HfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+4Pv3QXOo/HOLtXHUV2cH3f5VPEq3kUQypW9EYkF/4s=;
 fh=c3XECHb45K8EnSvWW5JVFBEgx+XUvoEy8T3Wx5dzP7Y=;
 b=cZVeiUB+wCiAmvwNWebiLxy9niwdHhal978pZiG+YkH9iOG2UmSjiBnsER5qYaGQVn
 2g/pjpVvp6pAbpFzhfkz1PsUqd/TaaRglkYoy5MfyVTjiYqZ9Hd7qfbZ07GvqqJ83oXC
 VfIQ2Z1w48B5pLnA8sEQF1GGAD34UuDEh8LJ4GwrGCuU2mzv11oXtClk8ZqURzKSir5U
 Xsj7f63PkzcmA3orPh/dixlZAcm8a7tvHUFo2p2pvMIf4TOhwp9PRTbK3nn9OjomXEsQ
 HC6HzsChzeY9D/fK8FY6Q20OcemKe3phosaifVHfCuhTwScuIa/laHediMeV3neTN5Pw
 Ngqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778074868; x=1778679668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4Pv3QXOo/HOLtXHUV2cH3f5VPEq3kUQypW9EYkF/4s=;
 b=pE8e5GptQbleenhBgRTyKbR1PoJ6dR+IBDeFv1882aHQkRZD59Z+4OJ38WQSXd2DOG
 ssTBDl9bBTK+LdLiNf9mfC82LomDsUOmonm4fF3jII6wvvp1XsfgSQcsQLHj/1vRmYAp
 1yg8NQPu4d8KLYolfVISkLeBQrdsTygmzXCejNGJmB/BxjHKGMU+QXeS+K/psL0gAIo1
 WRpEvGsak0yJ6iH6tfhGpSUdp6O5eTDMBPxNvtmvfgB7rMzp9kuxO+DdqKJ3tMcVbtAt
 S7H4QVH+puP9DELJ/6RLGOjtRtG1PY2PeugGyfhGVph3PQG2qei77+v1McFqkp6QgZ8+
 iC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778074868; x=1778679668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+4Pv3QXOo/HOLtXHUV2cH3f5VPEq3kUQypW9EYkF/4s=;
 b=IDuxv7oIXjfY1ytHSbB31LG5HMpdO7/G+fi2JDheFhn5py+jYOqDAhPGXubfdKi+lm
 lTrGEfNVY/H7w1SLPCaajahZp2BcWe629OcEUn8FWncDkrWR0TRooxOYTIvpAT2FIuZF
 xRGaqo59OwHf8uDRGeavFc+L9DczTX1OTqeKkzgqH5Vd/zuIsWmNBLUO9/siSNlK9guz
 9rxNBAtdLtKaq7rP3NqtGV38tqUvne3G7ty6Q/IlKzGMz37yM4V4pYSNo6cY1rgA7lm+
 PCG7maan9qrP31jvdeLl8o+8IuJD8OyOMJqRkZvwTEOeR8tnqJBguR+pWzUmal4ota96
 XPGQ==
X-Gm-Message-State: AOJu0Yzl7Tx+xPSO4plrqK9b1jdIC9henhw0QPDhg0Sroq1GLzgDymHV
 6Z81kQp+7MLV5+yLnCzLXzvZ5UozUx+PbXJ87RtVVKMtHRqFY6bc240KlW9QD8IEVkCNM07w7de
 oN/ALeN8dLp4bX5qyG8La8w/998mYM18Q4YRoZrko2w==
X-Gm-Gg: AeBDievWKJL8BuMGHnLDgH9OHBqCW4Yh4DYQvrefRX07LBSZuhT4tib4rsYTlHaDiZ/
 mgC2vRfqSZ/e4jSFXOLKEatfqtQY5YBO3coOorhFoVvYNq04SZn88DYsm0WUKzLH1Up/hKvyhSu
 7mrG/sdW0j6ouA2vaCDmULhI4Gz3fW9BrmI8Hk1myyjo8vSc3tZWF+0YitAwb9Yve9VKgjTRsJY
 viC5EslytN3h3NOPh0mB7oZo8PSuUWw0IfIQ1T1vztJ6bXqvKj4WgBzvecZusnnxRebkLDR5FSP
 YWYhYdqrosM20aOI+oWcqaCCEV0mQZYtfaO0cmomHS8UumHIrVcHZ8dkOchn
X-Received: by 2002:a5d:584e:0:b0:44b:8fb6:9a2e with SMTP id
 ffacd0b85a97d-4515ce1ca99mr5477607f8f.20.1778074867846; Wed, 06 May 2026
 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260506133216.18730-1-philmd@linaro.org>
In-Reply-To: <20260506133216.18730-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 6 May 2026 16:40:41 +0300
X-Gm-Features: AVHnY4Iynwr2RYbFJkDaG-Pstw8T9cVm8Vktp9zAppuf9G2J99I1C8EsdzZcdyE
Message-ID: <CAAjaMXZCGD5ZnRVrk72omYv=Jz=zVMXQD0XbSWcVY8T9r-1WHA@mail.gmail.com>
Subject: Re: [PATCH] meson: Allow building with empty target_arch[] source set
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Wed, May 6, 2026 at 4:32=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Complete commit 83d5db95d38 ("meson: Allow system binaries
> to not have target-specific units") with yet another guard,
> allowing empty target_arch[] source sets for some targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  meson.build | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 4176d020c21..987f33bacee 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4332,9 +4332,11 @@ foreach target : target_dirs
>      arch_srcs +=3D files('target-info-stub.c')
>    endif
>
> -  t =3D target_arch[target_base_arch].apply(config_target, strict: false=
)
> -  arch_srcs +=3D t.sources()
> -  arch_deps +=3D t.dependencies()
> +  if target_base_arch in target_arch
> +    t =3D target_arch[target_base_arch].apply(config_target, strict: fal=
se)
> +    arch_srcs +=3D t.sources()
> +    arch_deps +=3D t.dependencies()
> +  endif
>
>    target_common =3D common_ss.apply(config_target, strict: false)
>    objects =3D [common_all.extract_objects(target_common.sources())]
> --
> 2.53.0
>

