Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D09C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5RV-0002tw-IZ; Tue, 25 Jun 2024 08:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5RN-0002r6-Rh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:38:31 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5RM-0001sO-Cx
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:38:29 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so5272965a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319107; x=1719923907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kcWgWYD2GIFGfKoXbG09siq4L1d5KHolHjJ73IqMLZU=;
 b=uzqXPaqIIyeqrEpxaccT+kY5jENych2mO3709CoXIejg03a3bPGNnnTEmwxjcTl8x0
 +jw+aEBBrWxyjemCsPb8AsvAR+GPFl2gyUJ1R52fdBeXpwt7tOQ1mAywxnsHQwf0a+Tn
 obd7k2zLVrsIA5jUoIvZ3OzMGB8/vD5ObbCQOU1BrY98jLfe77UDjO7CN7cYkB/0XGWg
 fYKFB9OY1hrQevsW+SVYxOmMSKBRPxw4ZoinOHhHVRMUUTq6dXO0T8MEL8G0ANXM3YEJ
 xCJFALBSgOzKlthmU3RmQLOp8e1OvzWumxqBRu0gJGY45sI/R41r3TFP0hDBsO7Fby0i
 7sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319107; x=1719923907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kcWgWYD2GIFGfKoXbG09siq4L1d5KHolHjJ73IqMLZU=;
 b=qOj5AHwHdK0wJA3vmtubSdHST9u8qSKe+k42nBnOi1ZjRdIMeJ1ntBigZfqT1nwrvb
 SnC/va/hqzEqH8AOeQssDOeghSJcBqjF5Ma1h/LKGlCIuwmTBeJ/Yb+P0BeG5Wzm7jIE
 X44tfPAk+XPgGgmYPVHSG0sNeDfgrOLu8zfh30TZSstLdMNIRNqpUftU+x3/kPE4xMu9
 CkSQV1+bvZBJvgyvrwUf/Sn1NquySJD2b/pPpIaXSIPbOro8FB3Y09Xyc5f7xuYBnhPu
 Cn+NypToMVnuYT0mSnzO8+Lk6VCtOIfpfX6ONyR7xXIjbOWWBm2OA9q7VCCu9k+nLF7j
 uZeA==
X-Gm-Message-State: AOJu0YztQP8nvSZT8Vy7XQdxCzXIOcWExov2qQyHnHMMZ/V1dlzZENrQ
 LljZXjeEIeuHE0vqr51zv/oD3FpTdtJVoHBUfMN/mtZgqRr8XnXasw1ODZ7xP3Tk1VmA6DwgUqW
 XnAhydPtgy6RsnFM9kB5JBujgS2lp2PYYMq3gYg==
X-Google-Smtp-Source: AGHT+IGsXSIw7RwYNdCCv6AQz+ca4Q89AL95oHh6NutK9SEWbmXyn5rRnGtOrRtTmENyULUI1V/TQPPHDAaqocdFZwI=
X-Received: by 2002:a05:6402:270c:b0:57d:6079:3916 with SMTP id
 4fb4d7f45d1cf-57d607939edmr4482108a12.26.1719319106728; Tue, 25 Jun 2024
 05:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-5-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:38:15 +0100
Message-ID: <CAFEAcA9YewrLJdU0EnZ5TdKcCvaR1S4vFNH2cPdV+AZzmXsPkw@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/arm: Convert SQRDMLAH, SQRDMLSH to decodetree
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

On Tue, 25 Jun 2024 at 06:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  10 ++
>  target/arm/tcg/a64.decode      |  16 +++
>  target/arm/tcg/translate-a64.c | 206 +++++++++++++--------------------
>  target/arm/tcg/vec_helper.c    |  72 ++++++++++++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

