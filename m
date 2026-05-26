Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB36ACD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRozg-0001aG-ON; Tue, 26 May 2026 06:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRozd-0001Zu-P0
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:26:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRozb-00082s-Kx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:26:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so5605895e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779791193; x=1780395993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AL2B9lxj85PgaoPWFz4TL283sM8mMu5xvDy/JJxwFRI=;
 b=hx0oELTIIHvet++8he3IXvBBVHQXx+VoNDrtKID8PRZ6TIGiB3oaS7N9ivaVo/sJTf
 f7XoxU5vbThSHRdSnG3xckqqNtYMuFAx6tPr2RHh9+kKjNGjRnhg61W1pn4hwHt2PCEy
 fuKl3gxDJYRHHr5lEcb25+OsBS6Io0eR7ygXgxFn1JJdzASr8DBZyRepeklFP0OwHgXq
 tY8jFs1IjiHsZuGK3AHeJSznePojy6T+cXpDZYU8geAbYo6YZLmbQDBN+Mqr/3Xu1QsE
 zJVab8X1Y0ag2VDZhtnoR+KRbsuuizmVzc5SZ04OgWvhFFX/qt8HEotfHNRPVbVYn4Pf
 DPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779791193; x=1780395993;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AL2B9lxj85PgaoPWFz4TL283sM8mMu5xvDy/JJxwFRI=;
 b=EjOpdDWHVIxu6RiwOQpcOS6TWy71rVT32F48w6T9rUZPJ87ZiDAwz3T7Zn89Wm8J8s
 igNny5NA3hGTnQP35Qzl8qa8zuLxxIPsm+vr7vocRPJ9ZnsefCozNRpv8fUGQiXVuzZD
 PCuIJaPDjJOqYeBdiA8AqRUrH6R5O7S17w9hSyD0igV/qWSt6kwcSPnha2VktkjhO9n/
 c9lHiHUTmMvTKcF3aGWU0/Vp3j37OVwEzG8PcRLnne50f/zNXYupOAfM5glOdiHyNpwo
 wCLSf34dPrtvvEflKNRm2mEybNBiqCiM4yEg6QYVTf88GE5Z07GKH/b24U3jzaXyjDQ0
 Axvg==
X-Gm-Message-State: AOJu0YyBPAYxeYfYrKCvoMuVwmyVFXxDwimEUr4d29A5X1An4SFTtbgu
 nb7ZE1FO/D1+q6yi21UDmHWEwQKQ9AptHgzBqlCkV1hak44LY5Hs7DP7qxV5TINc+Fg=
X-Gm-Gg: Acq92OGb1tjtLrHNhmDPBpqcy5vCGSIaUEO7Hr5TVicpMOZuyTpxHkd4DogJ5JIYmCH
 6zE0X2cflOVm7+5gPLB7YwtH481osJe3pNuvHdqsCgazs6I3jiD/ksgYFa7JQvlKB203gUPhKX4
 tt05oiqWNo2XVujZFvR83g7qvb2ukinO0BtMcli4m2v/9+S/Bn5c0ccp9GiS2uuPzfSt6Fzmske
 Dl+fCKyZXaudrUpP1dcpFzKnWQsR0If7ilOklgrTX+cRvWQt5mqOEIvmWSgpjRHzPLJW97p7BsY
 viS5G0+K3umBLu5pMZckkptUxEYUQ5ey3ZWPotk7G6bxKBFvTmNJ1HzWRn+I2R2nrsqJ47SBAeY
 adn3p293JXFHy+n0iA62A32viIS+bzPrsmqeNWlbyF9psRgHGF/cgliEb7OZ/7DKho4XSM4Xe+y
 jcOqsfS/MXt1TzKu2bTHlC/sk=
X-Received: by 2002:a05:600c:4511:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-490686947bemr105705525e9.30.1779791193048; 
 Tue, 26 May 2026 03:26:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d493dfsm35071131f8f.23.2026.05.26.03.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:26:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5904E5F7DC;
 Tue, 26 May 2026 11:26:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  pbonzini@redhat.com,
 stefanha@redhat.com,  imp@bsdimp.com
Subject: Re: [PATCH] code-provenance: add exceptions
In-Reply-To: <0bb3f577eff40a6a834d14db94a1612a2108ec67.1779748353.git.mst@redhat.com>
 (Michael S. Tsirkin's message of "Mon, 25 May 2026 18:34:08 -0400")
References: <0bb3f577eff40a6a834d14db94a1612a2108ec67.1779748353.git.mst@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 11:26:31 +0100
Message-ID: <87wlwqzctk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> As a first step towards moving with the times, let's add
> exceptions. Let's also do what linux does and ask for tags
> on ai generated code.
>
> This is not going far enough imho but will hopefully be
> noncontroversial.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index 4e6a9afe0d..c3ed7f5e69 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -347,3 +347,22 @@ requirements for contribution.  In particular, the "=
Signed-off-by"
>  label in a patch submission is a statement that the author takes
>  responsibility for the entire contents of the patch, including any parts
>  that were generated or assisted by AI tools or other tools.
> +
> +1. When AI generated part of the contribution is not creative in nature
> +   (so not even copyrighteable).
> +
> +2. When the creative part of the contribution is clearly QEMU-specific
> +   (so derived from the prompt).
> +

Before we start adding exceptions I think we need to be more explicitly
clear about the responsibility of the person who adds the s-o-b to the
patches.

Once we open the door to AI assisted contributions we need to be ready
for a potential avalanche of slop.

> +
> +Attribution
> +^^^^^^^^^^
> +
> +AI agents must not add Signed-off-by tags. Instead,
> +contributions should include an Assisted-by tag, like this:
> +
> +  Assisted-by: AGENT_NAME:MODEL_VERSION
> +
> +For example:
> +
> +  Assisted-by: Claude:claude-opus-4-6

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

