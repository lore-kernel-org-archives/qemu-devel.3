Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCFBCFA462
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hSe-0004Zr-OF; Wed, 23 Oct 2024 15:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hSe-0004ZZ-0x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:56:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3hSc-0003oo-Ba
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:56:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso12995366b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729713360; x=1730318160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2VeZfk5RhUV4m/3QRWtunltjmFsa5OFmqGhIhq+qkA=;
 b=PLl0XgiPCY8t2kpMXafI2g63LnJmOFbOA8LO0dCNYbKgoF7GkNDZShvEsy50PJC+PS
 SkjyuL+93SkKAKf1lbULXQxfd7gXD6fM00A1c1KdwP5qkdiDwaHI10Qslg+zYGLfVaws
 lJ2Fw5vPv9WosDHSQBHH1Q4bNeNObBcKYA9RNXgkCZfCcJM74wVriKeDqcXlMBzHvW5O
 0c5eqsL13GDMQEj8w8BrJwfEmsn1/gFEC08JYbPcW+5AOk8f62ckRR4rxshR0MfTeofI
 BBpwp0mjb74VgKguasU1pEjWgzAeOqctX6BWYpCmSx2Tt/0lDpKJ9cmcWi9SHdMT3UjT
 KAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729713360; x=1730318160;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l2VeZfk5RhUV4m/3QRWtunltjmFsa5OFmqGhIhq+qkA=;
 b=eA+1Aiib4UsuBsKd5uXzXKCzZ40+9+IqfM6vCIPsvu12R7XxL9z5Jp7MPjZZvkUMWH
 +XsHgbB8mWRRAltiSK9owtxnfbap7xmckcD0UlY7KG6EngA+KzlN/T9kE8VuCRMc6NS0
 RGkS/FVuwMSf94R9wuXmprbDAH4nYobnG4zCzsaS34xth/EbqxXdU7T1Q7JZNg0ngrDO
 X/PUL8rYmi4tRq+VpmLR53iDSNW6Kx/CoFIJTpozS1/0rU64FRTNSuhVXHRoCQRnMcDK
 SZdI0oKk0iHkYdIQ0Zp9379qakaD0fkq4bJGO7NdK4JZhlvdAsA/t6rLfF2qcb2yZdcx
 2VAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL6uqtrlHvc4p348z6p5oPSjmjp54yxP3a/daliXaAbEV3CDdzGfmRd4KxZ1jrLBm66GOWjy4vvPJ5@nongnu.org
X-Gm-Message-State: AOJu0Yypr2rTFjZj9DazpIHBlrlE+/BLYjLbkowk2wC2qsxa/VYpKdWH
 U6kUMenWwphDyAJYafujlzWzpEBObewtmc7eB9td4tMnuVgo56BeIl0+tc9Y7Bo=
X-Google-Smtp-Source: AGHT+IFg+o/t3R9ud6hJg9jQUspWFCR/JaFye8S8cIXVSE/IiZRl5fWlHNThCXVcAe3D13kDQEzcVw==
X-Received: by 2002:a17:907:60d6:b0:a99:89e9:a43d with SMTP id
 a640c23a62f3a-a9abf8ac3a2mr337451466b.39.1729713359807; 
 Wed, 23 Oct 2024 12:55:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9159a265sm515355066b.212.2024.10.23.12.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 12:55:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A6BF95F897;
 Wed, 23 Oct 2024 20:55:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Kewen Lin <linkw@linux.ibm.com>,
 qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  John Platts
 <john_platts@hotmail.com>,  Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v2] tests/tcg: Replace -mpower8-vector with -mcpu=power8
In-Reply-To: <20241023131250.48510-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 23 Oct 2024 15:12:03 +0200")
References: <20241023131250.48510-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 20:55:58 +0100
Message-ID: <87ttd2k301.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> [1] deprecated -mpower8-vector, resulting in:
>
>     powerpc64-linux-gnu-gcc: warning: switch '-mpower8-vector' is no long=
er supported
>     qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error: expected ';' before '=
float'
>         4 | typedef vector float vsx_float32_vec_t;
>           |               ^~~~~~
>
> Use -mcpu=3Dpower8 instead. In order to properly verify that this works,
> one needs a big-endian (the minimum supported CPU for 64-bit
> little-endian is power8 anyway) GCC configured with --enable-checking
> (see GCC commit e154242724b0 ("[RS6000] Don't pass -many to the
> assembler").
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D109987
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

