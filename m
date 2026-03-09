Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E27F4180E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdUC-0004bc-37; Mon, 09 Mar 2026 12:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzdU6-0004ab-RR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:29:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzdU4-00066s-53
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:29:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so1829488f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773073770; x=1773678570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKi6Bpm6ymF2cQPgbmG6Au0bGqGE+3W+QsNw57+BpEE=;
 b=ricZ8xQ9ZeAk8ACWbv4k4SLNH1HjbM1d+O2d5Raw+SBnTay8DADD6lA7OpAX1Sd7Zi
 nEtEmZkLUYc6fqOy5vvMJysZoIXCeTYTv3Y3zOlnRkH++hyCtFu5Rbhntq88rfTtY8qJ
 VmUzMcScUSbdDkDsvNV/e1g0s8bBaq3GH+ROCUr0dIvdNnETQ49kzFro4JeuLHR/MWnF
 lzXLNnGIT1KJxpl0ukphy8DxwTJL9M6AI23obS7tALQ7Wp4xN8oQENVeQMqwdzggC4IB
 SgXFSPs7ChoQHQW9nYtecHRHpKBUK8s0sCwrI0zy+MsjJ5pRu8PkLQvHa9wUvCFkoLKO
 B+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773073770; x=1773678570;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aKi6Bpm6ymF2cQPgbmG6Au0bGqGE+3W+QsNw57+BpEE=;
 b=rDUQREmk6KevrfsJ4MdZjF2X/ebwkAWkRANqA5xpwilGp90pLL/oKz6flZ2qfIrbhI
 oOPRF/iThurXAyktjxLbNCQUfhpFGJrrsPE5mMMPu58wyRv4KgSrFvIAiCQA0mHXnUiN
 JboltKJfNSGZMe3EeTel1YqmEoLVUBR2Ou1tdP7w/eq1Gf3kmGVYpZoYIszQWoQwiQzO
 9FdQc7pgg77Ge5yLskIuo4FlZFTXrujLWtoUxfKw8adqIx9alMkzgjIJUMCpKJ7NW3Gf
 dN5RPam2EZ/+MNL02Co1FjTdgtxnjzu8elkZbTNdHvBabqgPlKaXPfTFEGZn2VyfoPbK
 ZNnA==
X-Gm-Message-State: AOJu0YwGvor5HEFbzUIu4UW1FLI00AMYF0+0OeIROte1xWb3Y26Qm25+
 LvrfH6Eodu4M51gOgnSCL+ig++yf6a9a5oISODfMVkZGx1lAv/dr1IabnLEjAbQrLnI=
X-Gm-Gg: ATEYQzztU0RLSINUZkKUiQ32cdBUIjaf+EAsPWczTjiEcrmacGLsrL23UdvhGaYhW8v
 XUkbrAzKWcF+uf9r36+THUeaIkNxENtq6DcWVNA4wY5RkGa2pYITJsnwP/VDgVoP8nYnTgj1c1Y
 DwmTn2nJEE1G8KEjQSkGXOpDXMcIDjXs0qkKr6yIDGOCmwBLbz8NDE79k1G3wLy3wMZRXo59CZF
 Rod9ublXQKW+ywoy8ZCOOZdj/WB+iG8ttPCNUtKp1SLCafNyIesB+rRALPQbWfLRkre6zLqu7ir
 Vadc55rt9q/aLuGxHdmVw9y+jlXwksin9JcF0o8BNC1WhASZKE45mDVPKnpYCipdKyYS6IWTPL1
 wP+YpusQM27Pfgx1k9Vl9POBa7xtKxivT+1CT9MkkhcD+DHCJoRZ4B9xArnkcK5ouudP7UURJoE
 3l7f5hFPR48wFP0ifqWBmyKWo=
X-Received: by 2002:a05:6000:3107:b0:439:b3c5:ea1f with SMTP id
 ffacd0b85a97d-439da35f8d7mr22417069f8f.16.1773073769862; 
 Mon, 09 Mar 2026 09:29:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8daf2sm28405393f8f.2.2026.03.09.09.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:29:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B3B65F882;
 Mon, 09 Mar 2026 16:29:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] docs/devel/decodetree: Fix formatting in "field
 examples" table
In-Reply-To: <20260309152617.1611566-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 9 Mar 2026 15:26:17 +0000")
References: <20260309152617.1611566-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 09 Mar 2026 16:29:28 +0000
Message-ID: <87fr69ge53.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The rST syntax for a table uses ASCII art to draw the cell
> boundaries; then inside each cell the text is treated as a body
> element, so it is rendered the same way as text at the top level of a
> document.
>
> The "field examples" table was assuming a "literal document" format
> for its cell bodies; this meant that the single line cells were being
> rendered in plain text, not a fixed width font, and the multi line
> cells were rendered as definition-lists because of their "second and
> subsequent lines are indented" layout.
>
> Fix this by consistently using inline-code markup for the left column
> and literal blocks for the right column.  (We want to be consistent
> within each column because a literal block renders differently to
> inline-code, with a green background.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> You can see the mis-rendered version at
> https://www.qemu.org/docs/master/devel/decodetree.html
> ---
>  docs/devel/decodetree.rst | 44 ++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
> index 98ad33a487..33cd6fe583 100644
> --- a/docs/devel/decodetree.rst
> +++ b/docs/devel/decodetree.rst
> @@ -64,23 +64,33 @@ A field with no ``fields`` and no ``!function`` is in=
 error.
>=20=20
>  Field examples:
>=20=20
> -+---------------------------+-------------------------------------------=
--+
> -| Input                     | Generated code                            =
  |
> -+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> -| %disp   0:s16             | sextract(i, 0, 16)                        =
  |
> -+---------------------------+-------------------------------------------=
--+
> -| %imm9   16:6 10:3         | extract(i, 16, 6) << 3 | extract(i, 10, 3)=
  |
> -+---------------------------+-------------------------------------------=
--+
> -| %disp12 0:s1 1:1 2:10     | sextract(i, 0, 1) << 11 |                 =
  |
> -|                           |    extract(i, 1, 1) << 10 |               =
  |
> -|                           |    extract(i, 2, 10)                      =
  |
> -+---------------------------+-------------------------------------------=
--+
> -| %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 |    =
  |
> -|   !function=3Dexpand_shimm8 |               extract(i, 13, 1))        =
    |
> -+---------------------------+-------------------------------------------=
--+
> -| %sz_imm 10:2 sz:3         | expand_sz_imm(extract(i, 10, 2) << 3 |    =
  |
> -|   !function=3Dexpand_sz_imm |               extract(a->sz, 0, 3))     =
    |
> -+---------------------------+-------------------------------------------=
--+
> ++-----------------------------+-----------------------------------------=
-----+
> +| Input                       | Generated code                          =
     |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> +| ``%disp   0:s16``           | ::                                      =
     |
> +|                             |                                         =
     |
> +|                             |   sextract(i, 0, 16)                    =
     |
> ++-----------------------------+-----------------------------------------=
-----+
> +| ``%imm9   16:6 10:3``       | ::                                      =
     |
> +|                             |                                         =
     |
> +|                             |   extract(i, 16, 6) << 3 | extract(i, 10=
, 3) |
> ++-----------------------------+-----------------------------------------=
-----+
> +| ``%disp12 0:s1 1:1 2:10``   | ::                                      =
     |
> +|                             |                                         =
     |
> +|                             |   sextract(i, 0, 1) << 11 |             =
     |
> +|                             |       extract(i, 1, 1) << 10 |          =
     |
> +|                             |       extract(i, 2, 10)                 =
     |
> ++-----------------------------+-----------------------------------------=
-----+
> +| ``%shimm8 5:s8 13:1         | ::                                      =
     |
> +| !function=3Dexpand_shimm8``   |                                       =
       |
> +|                             |   expand_shimm8(sextract(i, 5, 8) << 1 |=
     |
> +|                             |                 extract(i, 13, 1))      =
     |
> ++-----------------------------+-----------------------------------------=
-----+
> +| ``%sz_imm 10:2 sz:3         | ::                                      =
     |
> +| !function=3Dexpand_sz_imm``   |                                       =
       |
> +|                             |   expand_sz_imm(extract(i, 10, 2) << 3 |=
     |
> +|                             |                 extract(a->sz, 0, 3))   =
     |
> ++-----------------------------+-----------------------------------------=
-----+

Shouldn't we just use the proper markup

.. list-table:: Field Examples
  :widths: 30 70
  :header-rows: 1

  * - Input
    - Generated Code
  * - %disp   0:s16
    - sextract(i, 0, 16)
  ...

?


>=20=20
>  Argument Sets
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

