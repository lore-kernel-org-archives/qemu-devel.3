Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E133C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraVs-0001ky-Tx; Wed, 05 Aug 2026 08:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wraVU-0001jr-B4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:14:00 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wraVS-0001ZA-QG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:14:00 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6680ae2031fso861410d50.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 05:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785932037; cv=none;
 d=google.com; s=arc-20260327;
 b=CVXHVt7YsKygQlEAFrnXLJFYhLVmKIH7dN5auxFaWtuBQM/DBodi/E5q9TkdpNuNUp
 SQY5mt9ojK0afYShWcUK8CYfAJpntXkOq+8U2/RAXhUfz44vgqcOlhRnMyD5obew+TRy
 meo+zXfOSRi8mpRd0rhyBT3fpEHsvLvBXarFrUrMXZr+GwqtTVL0TquwKziB05GcoBrw
 nbrNCT1Av9GwFDlFt2k71YkR/bN4nW7mQofJAJAl9cyFdHCDywGfXwCqVdeKYsCOi5uR
 z64dmHUyb9phANJj97ATFFwaN/8iCrzxP1Nc56hWtXWtv/LH38x+WbYqoxJJuYBmX0QX
 XrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XFNVZxblF4wD0KOyU3Ptz6pFM3BFf3v/ZY+DhVpmGoI=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=WJv3Vf6eeoGYq9y3FMZSzqwV/JVRkvy2TQbQy/90pCHgRU5uQ9qhqikDerT2YlTStb
 SWx3rN6gg9l2TjqTNE7QYDo65Wc54KGPP4KatGdVg4CzfNyuC47tx6azGLGNT2mjw8G4
 GXND/Sa8Fk+UeK+7zxq9fxDuKyIml2v6srIx0CkHrc5GvaqGO3lRzCVZrcxBnshR5nMX
 8t/MYaWRzLIIso7/aCLGK6T+qLIwhsrd5KtE4KCGFDJ0FOt8yqnV3V1udXqcX2VQJRk7
 r8GVG10KyEzU7/d72vUdyvwzGIpVishb961DcXwjXl0OUUtsgKFcLBiK//W4NdDA7cs1
 5o4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785932037; x=1786536837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XFNVZxblF4wD0KOyU3Ptz6pFM3BFf3v/ZY+DhVpmGoI=;
 b=jaZLWOwvwIwfzsVOVN2yQCk6JJZMzmwmegjKBmhUYnDDiMWQsuXLOGC1ex6sJJOkqX
 zUnYLdmIVlnIQew8wVlKnVEPh4F/Goqn8MJy0JQR1ZPMCbpPqbaEHi+w3lOPJI32ff0Y
 +hB/Cx8VhOlE26XaUK5cMVLfjfVErRie7ez7CDKzPDEZY9EkGw+9r+2PA+omCPTLBj5K
 Y9A90Vwe8cDrxtvGEUiCRu9rUfDL5rP97+dTlNFYKTICmSe8OEuybRPCxiIiHue7A8SR
 RunsFFHQ2A2IAEhr2wn+Nc9/lx8w/WQbaXZk7GRsAksjPdi8nZjmieblwHdF/BD6QbxC
 af+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785932037; x=1786536837;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XFNVZxblF4wD0KOyU3Ptz6pFM3BFf3v/ZY+DhVpmGoI=;
 b=tDhqA/7YxiTFXTdkRb7PK8t/kJhWh50MVbSicccMUX1ACx7R2Ct6eNpVXQPcy1wHCC
 F7jl25QarAYYyBwB0ptPLKH3aDWpg7jlGcVtw/6NX8Rp6Pn3j8++J5ZUhXGS0qS/SWJm
 g7CX6CdVFWmYW93KYjWk01SEf5lufXifwD8vRclBYq5aNW3NKPlcL6PNIqT6x3n99DSa
 ekVwW3VTx4GBjL1uEdaXhFWOj7PtYnihZE4oXKrAidFqD+rjyethkW+yY/7SyEtnB1Pm
 bT+xzoq766VU/IGeCUnL9A41WlqYhlKEmk3B3dRAlqarzc4CvHUsg00exJ4twNEUW5Zq
 +Evw==
X-Gm-Message-State: AOJu0YwnL6Cn94Edkv7ZMAlnwwGbcxvtJ6TBpfAx3D+nwlzJuvmeDu9r
 ILsJ2kw0SvRhgjyz0IQii4xBKJCAs2W45/A7m7JND3shIRXm+V8qonw1kalCzYYQ1zF+7jwc/9R
 8a+/ZK0ThcwqQt6a3lCL4PfPGXjr+ppgtKoHR
X-Gm-Gg: AR+sD13WNUd0xMutViPtQKQ2eKOPWqhT9/Zz7iXDU66T4WzAjaI5Q1VjEmXw3QPQSD2
 dFc3sSr+GQ9MblrLJB99DCYXq34qFyUL164PST6Sur3RYgNcFgLJuYScRz3E5u3PFWa8fOfZyb9
 peU9X6PZhtqSDi6ZtOeSO5c+7RvUEV2Q5MUYl1EAfcXCPnE13xP8bPOjzsX/dFiVfWn8037rzGk
 hKdPdWOWxDHn0s3UNpt3jZy3JM9Ws5KETWbNE0ShfRpur1B9UDQvFZyzYurqml15sCC5GM3D4QY
 /iDxF2eWfmvFumIZWJo++HNiVTNOYWuO5spBVAJVLQUjE5iY9roxircaCABftg+1nPoNHkJ0XpP
 KBpqzzsus5g/3C9EFfJ6+YRaGdfeQHg8=
X-Received: by 2002:a53:d88a:0:b0:667:89c0:71b1 with SMTP id
 956f58d0204a3-6699aa98fd5mr2679588d50.31.1785932037172; Wed, 05 Aug 2026
 05:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260625155613.192643-1-scherer.simon89@gmail.com>
In-Reply-To: <20260625155613.192643-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Wed, 5 Aug 2026 14:13:45 +0200
X-Gm-Features: AUfX_myiMw2rXiduOsMaWMCPKNpD0xDMNCxlPwXY_7--iy3Tn_aqB5hH6BDkdi8
Message-ID: <CAEQwQt+3vmH6Vd47mpV-ZB2KhqWgPXUvLczFU3dYKO4rx+PXUA@mail.gmail.com>
Subject: Re: [PATCH] target/i386: fix incorrect decoding of EXTRQ_i
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Ping. Just checking if this patch might have been missed, or if anyone
has time to take a look. Please let me know if any changes are needed!

On Thu, Jun 25, 2026 at 5:56=E2=80=AFPM Simon Scherer <scherer.simon89@gmai=
l.com> wrote:
>
> The decoding of the extrq instruction with an immediate operand (EXTRQ_i)=
 is
> incorrect. Per the AMD manual the instruction encoding looks as follows:
>
> EXTRQ xmm1, imm8, imm8   66 0F 78 /0 ib ib
>
> The /0 indicates that the "Reg" field of the ModR/M byte must be equal
> to 0 and the XMM register operand is specified by the "R/M" field.
> However, qemu incorrectly uses the "Reg" field to extract the register op=
erand.
>
> This patch instead extracts the XMM register operand from the "R/M"
> field.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3611
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-ne=
w.c.inc
> index ac181308ca..acb300457c 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -605,7 +605,7 @@ static void decode_0F78(DisasContext *s, CPUX86State =
*env, X86OpEntry *entry, ui
>  {
>      static const X86OpEntry opcodes_0F78[4] =3D {
>          {},
> -        X86_OP_ENTRY3(EXTRQ_i,       V,x, None,None, I,w,  cpuid(SSE4A))=
, /* AMD extension */
> +        X86_OP_ENTRY3(EXTRQ_i,       U,x, None,None, I,w,  cpuid(SSE4A))=
, /* AMD extension */
>          {},
>          X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A))=
, /* AMD extension */
>      };
> --
> 2.53.0
>

