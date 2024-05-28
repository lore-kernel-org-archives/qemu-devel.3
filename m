Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1C7C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzmS-0006xU-QQ; Tue, 28 May 2024 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBzmR-0006wt-L5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:34:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBzmP-0003vy-0Y
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:34:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421208c97a2so6147805e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716914067; x=1717518867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtsDOfTtpe5aKrCNPT3XEOej6fxFTf5r6QrMpL9j09c=;
 b=yQtcjKi1wZryiyTss4iv+uuMXDOp+81/PJCvZbvKMXhAYUG06nsfwrKus5/lgA5ABD
 xqpNGGN3+ovudQW2iFJ+I4OKEpg7vpkIxWmk2rPOnGxeD4yogjFPocHjbrI2XYkSQRLt
 6egBU2+fW3YCKZlvxiVi78t6EwB7rTqWja6DpDlbXYkYlI++pUYKaHso7X4MIwmPe9eg
 ieNxseBSbkKCEI0m4J/e9dG1APN/9bJ/0tIOcJ1a/khN3j+SEcgpKAOzVa5ryXjGih8j
 OJMHjE94e3ntEbvhxhsix7KmalPxVvAh1urUCXqu1zQCKEJmm6X9+XL6GynVDQ1wXNMi
 c02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716914067; x=1717518867;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtsDOfTtpe5aKrCNPT3XEOej6fxFTf5r6QrMpL9j09c=;
 b=BNued29mJEATWBTWNeR8fSg9fddyaW84mIv3yk+It5FRtkbuadeg9zBBdGfMf+G8bB
 WAVrszbabbhJs028PQRgN2H1WaYu6zQhznhotdIaoNhgFC4pSORvR4XjE7hcrY4O7+TK
 hvL8BZd+FiZMieQu+fwUbe2Pjz8j9ecJ5h1EzuMQT6G+CQ0INx3MBoCL6qZb9cob5DES
 D1YqaAvq8mUd43HS1wL1REnE/b7vAt3lPXo1D1+I1CtKvri1DiiiPDw/OHABxPXPRNx0
 D+uYPfvgBzi0OsRoAQOprcTr7OwhSszPoZ1XVBYXHqe5fTFA3CaEUxNs0l9/y4uh31m1
 B/0g==
X-Gm-Message-State: AOJu0YxtPOxP/W+cCcdCfRr1F+SuBbdKHqCEPVVHrjo7bBCZ0driGsAj
 pieNjOiIz4l1tz5wM/WVOk6+KS7zqT9hjvC/JwTEwVm1ARfRr3jVhqPJhAaOALY=
X-Google-Smtp-Source: AGHT+IGFIUIIUp5PlXS2ERsA89POExqywOUR/z59XpcQhQc/PS/H15yZhvxrqzMwcIPgU/LpzQvGog==
X-Received: by 2002:a05:600c:198d:b0:41b:f41a:c67e with SMTP id
 5b1f17b1804b1-42108a20cf4mr79848465e9.33.1716914066999; 
 Tue, 28 May 2024 09:34:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fb99e8sm181368235e9.43.2024.05.28.09.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 09:34:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E30E75F88D;
 Tue, 28 May 2024 17:34:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH 2/4] gdbstub: Add support for MTE in user mode
In-Reply-To: <20240515173132.2462201-3-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Wed, 15 May 2024 17:31:30 +0000")
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-3-gustavo.romero@linaro.org>
Date: Tue, 28 May 2024 17:34:25 +0100
Message-ID: <87cyp5gajy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This commit implements the stubs to handle the qIsAddressTagged,
> qMemTag, and QMemTag GDB packets, allowing all GDB 'memory-tag'
> subcommands to work with QEMU gdbstub on aarch64 user mode. It also
> implements the get/set function for the special GDB MTE register
> 'tag_ctl', used to control the MTE fault type at runtime.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  configs/targets/aarch64-linux-user.mak |   2 +-
>  target/arm/cpu.c                       |   1 +
>  target/arm/gdbstub.c                   | 321 +++++++++++++++++++++++++
>  target/arm/internals.h                 |   2 +
>  4 files changed, 325 insertions(+), 1 deletion(-)
>
> diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aar=
ch64-linux-user.mak
> index ba8bc5fe3f..8f0ed21d76 100644
> --- a/configs/targets/aarch64-linux-user.mak
> +++ b/configs/targets/aarch64-linux-user.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml
> +TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb=
-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml

Ahh there it is, this got missed from the commit

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

