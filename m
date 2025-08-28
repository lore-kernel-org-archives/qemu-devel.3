Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1606CA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEC-0006Iw-En; Thu, 28 Aug 2025 13:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdwO-0004VZ-Bb
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:49:28 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdwH-0001nF-Mi
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:49:27 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71fd55c0320so13040817b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392558; x=1756997358; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zz0T724Cg8qpVGFP2GdxwSMtPZNttsO0bvdQ0Q/lSYc=;
 b=vBr1mJ+W4QL91ER5HyNeaBGxpt55Eq/fy7bhZ2GtfyaiKEWErY+Cy9miOdPh4u6XZp
 bsQps8ARQkSQikEKftdiS1g9d/ggaFBNgXFohZN3OjxndibiDRMi+c6/I9y7GanDdAH0
 i2qI2wj0UfVwUyCBq1WpRdgrI4wfU6ds7IHRHIFGa9VilBFmqFvuKMdfGJNNUtISvi9+
 zI58+cKHOMuQVZvzSvXXpJObT+lpBLbvhQ9nymQt6H0ZKxG3tr5ej9WzWlnG0TdlM7ur
 t9fNiCStfLrnQBBSwZ6Blg0m0A1esY1velvRMf4QqEBF5iAidWXFsQsTrhWmzgbEdHd/
 eUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392558; x=1756997358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zz0T724Cg8qpVGFP2GdxwSMtPZNttsO0bvdQ0Q/lSYc=;
 b=AIO/3u5BatfLrDuOfuTyqglP0wcevoAstY14WSZvNf5q20aO/F1dzvCy7j0FPB/ccb
 Mh6aipz9EhY6/JMZbEoYeoakouvXk7IBPZcD4mKEe8iABQ6Dtn17Mf4HLpJay+gYwVmZ
 uuJKD656kQWQEjHRfBiSdSU3xCpzNsCn5JdscqIv062Ue8+vjVqNMrtQTyIMQrfiCpzr
 Y+LvuHeLNim7CVzuIWTqsjsfyh7LTsYwM7DTQ6qlPtZO1sc/K9rt4M+3P+BEn8Q8jDCz
 WCwZ1wcaJ/9l+GgeHF6LL0VrZI5km/3xDzOrRO7lL9cd5AN1xBs6MwFbYVKjD0qkLVjF
 aOMQ==
X-Gm-Message-State: AOJu0YxMuTE4jdDHpKdxJzWiWHDXwkU9JAonjZjJfhC2zN5+eLtS/a7R
 QFGI5VaFe1ltzhZ2GXO6pRTlKFuUhs9fHHC+y2MZvL7y4BgraqOydV+Yo6veMBKoTVoluxHsPJu
 vRCsP0LL0GC9mjfgVyok6GZn8KL08lybdVzeB6PfGuw==
X-Gm-Gg: ASbGncuABor8z1VgQcmUUODEIgKUHF3tjB+A7WjTcI0o+7SVMMdKyuK7qz10iqZ1907
 uOuVbHYhjZefjYht12IMJ7rvf3HJqo3gjcjH633zaXSI5JL6JjLTE9SR0UxNordazrNwkUlh3Po
 43QdNPN5egiYPmFAtqR+5SFSNsZjVhu2Mwh9SMWiGSan7a12rghj+EM9rXjrLuCtPQ3N4KthnTm
 AwofgjH
X-Google-Smtp-Source: AGHT+IEF0Gf/lexOYUYQtrBvWDlpu55ysH0L12I/I+tEVMCcFr0giDiGzcQKFqXUdKBeLvaWcDqw1TBj4bJ6HunJMWw=
X-Received: by 2002:a05:690c:6a0f:b0:721:b47:e22a with SMTP id
 00721157ae682-72132cd73f5mr122213837b3.25.1756392558084; Thu, 28 Aug 2025
 07:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-40-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:49:06 +0100
X-Gm-Features: Ac12FXy_1UC0Y0tydCnAWnBmhEjRw51IdLvibeaWosl-ZKYotYEtdWmz5FZu-DE
Message-ID: <CAFEAcA_Mx2_nBQp5j72u9ARoj46j-izHM514j8cg0HZuny3Ftw@mail.gmail.com>
Subject: Re: [PATCH v3 39/87] linux-user/loongarch64: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove the target_pt_regs structure from target_syscall.h.
> Add target_user_pt_regs to target_ptrace.h, which matches
> what is actually used on loongarch64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loongarch64/target_ptrace.h  | 15 +++++++++++++++
>  linux-user/loongarch64/target_syscall.h | 23 -----------------------
>  2 files changed, 15 insertions(+), 23 deletions(-)
>  create mode 100644 linux-user/loongarch64/target_ptrace.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

