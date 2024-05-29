Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240FCC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 19:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOhx-0007Tz-1r; Wed, 29 May 2024 15:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCOhu-0007Td-3S
 for qemu-devel@nongnu.org; Wed, 29 May 2024 15:11:30 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCOhr-0008Un-77
 for qemu-devel@nongnu.org; Wed, 29 May 2024 15:11:28 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52b59f77670so128643e87.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717009884; x=1717614684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0/4T4ayste6hBo/m6qk+ZDyOj1SMvuUr74HYHl8bw9c=;
 b=nShQm1vM/gIOaLTyDLKYhI8VYhw0LD4c6P30xwcX7ZiUC7VhdgcMI+LgzAFygRAo/6
 vT+GWNx1C7EeuWDfkLD5CLOV4+SAQKPDYbym6FSSLmFexqkLxedJVLfqPnFtb4Mmaf29
 XpU9lqAXyoTfpCGMI1cZMPE322+Kb75vikAp9dZ78o0P8b2Lgob/Q9q17qYy803kkszL
 8p2Blj8A2gL4mUHjM1XfsNY/BaLgyLklQiA4xC+jdUtj119kDsQ/y/7lnMD0fT6g2wSP
 O8VTYy9CprF2l4HOlRbVm/lGYIqGhY4e1oM+Kc+owBZf3qAD4iyCCcNuy6HyKtpxVzBs
 0xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717009884; x=1717614684;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/4T4ayste6hBo/m6qk+ZDyOj1SMvuUr74HYHl8bw9c=;
 b=FSAc9t3SLm56fG73+ZQIyXhW6wELervRUn+0W//D+34GuWulHW/eGZASvkGp7NyBM/
 P3QsPwUbEAgt5ZDOU3TMRqxE8oqltbrItH34mSLaMScj1qFUAjZS3Re/8RE3x5MYfp2U
 jzRc8brnerDvrPW+YNpbG+uVHsHOg6DscmHTmKzdaZfsZ7MNAwZ0RZYmV5yju43SDWvG
 VeOTZBKGgibsvugvSU56T1XjVXy9SnZWy0ZF1MbkmeoVJohGpw8uk3sA5gN7B9z5zIrM
 1R0gI6nYEpbznP8SOtv3pOqgbTev8lHkMNjlJTKuUTfXykn6qwknbeC4abY9lcoTmDyM
 MCRg==
X-Gm-Message-State: AOJu0YzOVg7LhZ9DOzYoO2N3/2JN8wfVNf7a7iw6p3WmCwnQP0/WB2Ze
 PYG+FMN3Am20CBLg8Kqy5CpM8Z0IZq29TO5UfQRHt394m6/F60EpCGDv2NU2frk=
X-Google-Smtp-Source: AGHT+IETYH9OaP3amgZzCH8GSpzivTKclCsMl6LsR8JnytNJ192LlxBX9ZFC+XxROkU8cU8iAIDqhg==
X-Received: by 2002:ac2:511e:0:b0:52b:67cb:280c with SMTP id
 2adb3069b0e04-52b7d42637amr105797e87.18.1717009883803; 
 Wed, 29 May 2024 12:11:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a64a03e574dsm96622666b.14.2024.05.29.12.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 12:11:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2B1A5F760;
 Wed, 29 May 2024 20:11:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] semihosting: Restrict to TCG
In-Reply-To: <20240529155548.5878-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 29 May 2024 17:55:45
 +0200")
References: <20240529155548.5878-1-philmd@linaro.org>
Date: Wed, 29 May 2024 20:11:22 +0100
Message-ID: <878qzse8md.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> It is pointless to build semihosting when TCG is not available.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   target/mips: Restrict semihosting to TCG
>   target/riscv: Restrict semihosting to TCG
>   semihosting: Restrict to TCG

Queued to semihosting/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

