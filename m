Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E48C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5V0-0005uS-VW; Tue, 25 Jun 2024 08:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5Uy-0005tS-Bp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:42:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5Uw-0002h5-Hw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:42:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d457357easo3349578a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319329; x=1719924129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7FMp89KlTT9yfOrJqLXt+rOuYxMVOMiwzcFBRkXFrPY=;
 b=gx75oBCSyNpNgf+XaCccfDYWG9/Z6CvoClZZ7/M4Nv9FVL6F0L7qwmj0LZJ3/rYI94
 rq7FxUJtFuKRizGu2TwL+sZdIKjiUgYx0yHtMSm9d4BDKh6GCk4xRc1Tz7fZVd40qo3P
 uuua6h0zXnnMJNgZIW1KaRzvcm9rUdETwhhagzJob5ZApKQSv9uN17G1UvE5bFprMwFB
 aeFlsRO+/nhzDD0aD1eE/Tr+Bv8hOpXgnnOcboHR+kF38hm0wirQcZ4j7broX80CSA8a
 F3hHPOLG3wzvfab+l6u1ckG2Ruw+gLzpQ+iHriEy9QsGClfyLxLs7ox5661oFkpH9pAa
 VHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319329; x=1719924129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FMp89KlTT9yfOrJqLXt+rOuYxMVOMiwzcFBRkXFrPY=;
 b=bYXp+zqT4xcCoGQIehSfd9lLzCvivUFx7PWP/ngw9TRI4g07Y17i4ShIdjBGBi4v9Y
 xY4EfUN9iun7CG/n5eZFawITyCc1Ccps3WvMdyCc5RPQ1NSYoMYvNx8OwpvkDgEOIrAx
 FmMzHiUOWHHfrq+vfTjvNDq6e1NbISHSBNZ4oiBiCcoKLhU/MSmURqtI3cPB1xQ6BBYB
 5hon3q+8l9t0cgfu2fbHCY536KIkRBTKF1b205GZYz+Bb9jnzr9pDxqT8GS61KSBJYvL
 GbbU7JMrTmTeHOHX4DcsZLmL5l+5ZsOib3fLMkyZq0uwN6ircKhv//ySW4MpIuiOUu5i
 outA==
X-Gm-Message-State: AOJu0YxSRLwmdG349NpCzJbHQjzWtS++N/gzuZGacdnQi0b6MjQvpJR+
 kG634jcqpL4coFO+yPrAkw3S1v0fFDyavq9bcTFdCwvxdD7uSWAUNwOJvTwjnFU+BDA04HfjdlT
 pI1LtReog0cBgmT+4cdhTycKGZCjkNPhWuAn46mM54+ESER+a
X-Google-Smtp-Source: AGHT+IH0g80TL6MgKwKPj94gfKUvGmHxgNytfRDw3pX8o+1EW2cLVzK5+D8nczZvpUBoBJtpqXeQxnEC37frJS8h5Jc=
X-Received: by 2002:a50:9b42:0:b0:57c:672b:ca34 with SMTP id
 4fb4d7f45d1cf-57d4bdcabacmr5176372a12.28.1719319329069; Tue, 25 Jun 2024
 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-12-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:41:58 +0100
Message-ID: <CAFEAcA83F2OHrt36VSamzCgZ3DA_7m4mqTyvGoQ+Ffc=RBCwog@mail.gmail.com>
Subject: Re: [PATCH 11/13] target/arm: Convert FCADD to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  3 +++
>  target/arm/tcg/translate-a64.c | 33 ++++++++++-----------------------
>  2 files changed, 13 insertions(+), 23 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

