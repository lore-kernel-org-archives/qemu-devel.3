Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B1BCF11CB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqSc-0004zl-Ou; Thu, 10 Oct 2024 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syqSa-0004zQ-OZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:31:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syqSZ-0005xV-A5
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:31:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c8af23a4fcso920977a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728556314; x=1729161114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H1G+pjpLn2GOdI+rwjFTLXfPNvFegxvIu0XfXLq6fzA=;
 b=IBoETuk25rBAvLN0XJE/XiwXYQuMhmfvdtL+Fiv9sXcWWd/CaHioLc2TN44NsBIPdZ
 EK3lvZjMGs65SCv3w0UMTId6hjIrhqxV4qy0Tqi/fxxp6BwZmOsOi2ygG9gyw0+swF9X
 hDw+C1Dm6/gnQFO8eGXAg4F9/gcbe2dcAQtroCEod+bAH/LYS0O4eQ+/mMZgOlCTQAvJ
 84YluA2eD+qPjXO5k7I7zzShQdZa8KyPfRW0atcrr8XDJNgK2aQBR+ckuJOSal5Cybfd
 Qi+vdmAm/nTjM+tZZr1VDgmvfsNKcAY0SXBrkf9DXCtaFsRpLmzD+6F5hSRLhUHOf7y5
 4mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728556314; x=1729161114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1G+pjpLn2GOdI+rwjFTLXfPNvFegxvIu0XfXLq6fzA=;
 b=vdONgByTw8CvSSIKWta4Heedd4egVVHDnm8QNcYyoRrtC2ZM+yyqzRKv3CWkQujDJQ
 JkEIXje+vuu/PD+vdHrFHrRoK4cuWjEi9R3lkwj+sJnIHu0xyNppOZzGM3lFQn4kVpCx
 QBhSMzIljC24m06jOvCEGj5KowR+baFr++HFbqmdubC0K9rHF1aGEdPWUgPC4Uj5Zead
 GH58UMIAVwRX3+1uKyMcoaHAmP7NWbfg3lFmH7Kzw3aiKB6P/9EhT5EbSXJeFN4EK6cP
 gwzw5QhmQxcNYEcdUXhXaGD3tcvlYGNMlNVK/x8pqq5vDqQ+TY6L7Xp5Ov6gzRzIhdy9
 koVQ==
X-Gm-Message-State: AOJu0YypZysetd0FYxL8sSKWk46qB0Hhk7BQggxFx1BHRIwcvpyawW+9
 5ilxJra85AE7p7QHkGHsy0MC06Y7T6hrKsMRpww9nHJNDycr41jBUKTsm872x7+10SVkfHc4ajS
 1h/2ISDRxN8P8HMP/Ew572+h4PjFASK6VlT5RIQ==
X-Google-Smtp-Source: AGHT+IHXWCaOuM26uI4vYxRXMejs44Sq/vl9y9MIMUEOp9FtK2w6fzGYcpXyhYXcgFA771r/xnv8Frul05iB2+FclDE=
X-Received: by 2002:a05:6402:2712:b0:5c5:c447:e4c0 with SMTP id
 4fb4d7f45d1cf-5c93241dddcmr1744450a12.4.1728556313592; Thu, 10 Oct 2024
 03:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-6-richard.henderson@linaro.org>
In-Reply-To: <20241009000453.315652-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 11:31:42 +0100
Message-ID: <CAFEAcA862FYbm-Mojww38m2n8SqWwKSHDr8irLbj9--TA-PJyQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] accel/tcg: Add TCGCPUOps.tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 9 Oct 2024 at 01:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add a new callback to handle softmmu paging.  Return the page
> details directly, instead of passing them indirectly to
> tlb_set_page.  Handle alignment simultaneously with paging so
> that faults are handled with target-specific priority.
>
> Route all calls the two hooks through a tlb_fill_align
> function local to cputlb.c.
>
> As yet no targets implement the new hook.
> As yet cputlb.c does not use the new alignment check.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Other than the typos Helge spotted

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

