Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C36CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 10:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSXn8-0001Fg-OD; Thu, 28 May 2026 06:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSXn5-0001DS-7U
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:16:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSXn3-00028p-Il
 for qemu-devel@nongnu.org; Thu, 28 May 2026 06:16:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490686877a1so29802905e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779963396; x=1780568196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H1xrkQf3BWF1aGx10+8zTAefU0dp5D6GrwoTAQbjgQA=;
 b=HWwcMS1BytDqmC6zs8TJh7kdTxTNaG5RLIJWYSINH6EYmuB+dj+hT0kkiFwL4nODB0
 eY6HOxo7t592cmQpQ8BMdhTccr4no6CrJAsN7AjoGSPsgXMbsR6DjydexoiPdi8ja1sr
 Vpn6zWHjnMkaEtsWQWE5r9iX9fWqg3GunaDAguJ73ecojWiTqkPr3xwwLoo658GoMFJh
 AbZXUc/1pom+Mw67Ig3lL5+b7LInLDNtbK7riigRBBF+9Js8InJzDvSiDCSdbmMiVOOS
 tKse/hQyGMNNRC3h0CB+KK5r7xVFz2QVTeCIMBjDXjyN/LKNsEBzcYlonWRiODEkfST3
 YPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779963396; x=1780568196;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H1xrkQf3BWF1aGx10+8zTAefU0dp5D6GrwoTAQbjgQA=;
 b=U3RIHi6UFO0PI/G9HWmhFWwJrpmH/RKqKgjny6Zw+a1BE2qimk/3pBTRIEfi1kV9dA
 c4CDN7zh6blD5MOAvfuWQWPHRs23702H2VgVAMT5B665iRgrWVj+kpH+rOtMuQ6nWsw1
 rVPaSzQm+o9y9B8WvWRwLO+XIWa4WLxZIpDZmNM2j1Y4CHzXVfirNCRahfNyJiROxV8f
 WmFM1n3lW+neZTXyZrAtxhC6WnEkXoTGc/IStxKDOeY1pvA4lc/zmLzDgL5rTC3pqRS0
 PW9B2WGxRiFvcRw2N0QdNWRrfr3ePBGa9Mm5xGveoQiTRl76HVZ0ITTTNRVhAweQm17n
 ObOw==
X-Gm-Message-State: AOJu0Yz0ebpFpIKqcCWp0fAw06oorHowFUKrs7Cd/D1R1JJwNAn1DBka
 T3TO2Lh2q3KT4H1g3dskNKlC5zpxGIih+w/priWPT9C1TTzFDutGmo5Wo9UELB7kcTx8Wjj0im2
 5fAst
X-Gm-Gg: Acq92OHEaDeOgzyyI+qBdyXKkOysiht/cHwmNk30xERImigKJCyQrOjrqJaLGWE4fIr
 SqdhMAje4IbpmXD1qU2pxDjLSUCZzzZqVGzhqQiCYkGKUwB8NRa3k5w8AcEzsJ+7p+M92/Yq2h5
 FDf5/5lelvv/R7Od6mmT8B8N7h3/DBmvyTslldJgOaO1Uen/KF2FARfKHTOMtzo+KIvdQm352nC
 tF87KBOEofGQsPVBSOsomNBOhgarg2NvDhWYf3WmOFAqm5VGAHQxlaUTbdxRmQ/bg8lyGHfvtpF
 /b0SNeXgu1pKTUgQ3+hjrF30pAokPMAFLKmqz2POAe82EDmLU8vKS5SpeWEJ0wJ17tsvbRnaGbI
 wEcqmbLmvK2E0QjLEF/zDNPQRMpUw6NocA/J4QaM9rmWYLO/hc4H44KRzLv7rSjVXQvnRzBOLV4
 O9laCAOavNdF1NEgKO93xhn1eK85vWQSgEUg==
X-Received: by 2002:a7b:cb93:0:b0:490:548f:6ca0 with SMTP id
 5b1f17b1804b1-4909478d48cmr11136075e9.8.1779963395764; 
 Thu, 28 May 2026 03:16:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eeb36c40asm1902229f8f.13.2026.05.28.03.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:16:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 386A65F886;
 Thu, 28 May 2026 11:16:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/3] docs/devel/tcg-ops: List more vector opcodes
In-Reply-To: <20260504125032.35465-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 May 2026 14:50:30
 +0200")
References: <20260504125032.35465-1-philmd@linaro.org>
 <20260504125032.35465-3-philmd@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 28 May 2026 11:16:34 +0100
Message-ID: <87ik87x2il.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Few logical and arithmetic vector opcodes are missing, list them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  docs/devel/tcg-ops.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index c417ebe65a8..56c0b0bd3de 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -816,10 +816,16 @@ specifies the length of the element (if applicable)=
 in log2 8-bit units.
>=20=20
>     * - and_vec *v0*, *v1*, *v2*
>=20=20
> +       nand_vec *v0*, *v1*, *v2*
> +
>         or_vec *v0*, *v1*, *v2*
>=20=20
> +       nor_vec *v0*, *v1*, *v2*
> +
>         xor_vec *v0*, *v1*, *v2*
>=20=20
> +       eqv_vec *v0*, *v1*, *v2*
> +
>         andc_vec *v0*, *v1*, *v2*
>=20=20
>         orc_vec *v0*, *v1*, *v2*
> @@ -852,6 +858,8 @@ specifies the length of the element (if applicable) i=
n log2 8-bit units.
>=20=20
>         sars_vec *v0*, *v1*, *s2*
>=20=20
> +       rotls_vec *v0*, *v1*, *s2*
> +
>       - | Similarly for logical and arithmetic right shift, and left rota=
te.
>=20=20
>     * - shlv_vec *v0*, *v1*, *v2*

Longer term it would be nice to just auto-generate these from tcg-op.h
and tcg-op-common.h but I guess we would need to see if kdoc can handle
grouping of sets of ops rather than having to exhaustively enumerate
every bitop with comments.=20

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

