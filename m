Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBADCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xWS-00049t-40; Tue, 23 Sep 2025 03:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xWQ-00047o-Fv
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:33:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xWN-0002nz-Pa
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:33:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee155e0c08so3251797f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758612785; x=1759217585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYbUpWjqr2gmb39G6W5t3wpFpH8+zLeMm1eW5ZIhk3w=;
 b=M4lUI1bIclvQkeQ3ROyyHYeV+PH2nfgzWFSMPwYDL4qmmpGOUUxPJYOHbuH/XNqqUP
 TsY94U/btbItWWwJPDJsNzk2COLYAYZh9lVmhYdvLFLP7fumr7G+8lhvnhR/B/bcNpvF
 uj2ST5y9xs4xGg8nvtp9dKUfCY9Sv+KtUGVa/BdofuYKOGLhlHQcGza8SkISEQFsiSEr
 Mi82ZiHkkrIOwpXXp/tml50rQIAiLf/OVygp7sNjknSkmwYokhCiXhvwYt/MTYA18U09
 zz0cMv7d7F/ulkHdb9rXs5zkdpUZWoPX9lwAFUixSSpgXiUh1iJtLtKrxZuPj/uBiIK/
 CX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758612785; x=1759217585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sYbUpWjqr2gmb39G6W5t3wpFpH8+zLeMm1eW5ZIhk3w=;
 b=oE8sVaTGqaKOHRtN9S9ZcArQlZo+eX33P4laCGpZe2MCHpz85LkMNfpkebmIkLXzYm
 frSUUUj3wdDwreKSA6lGqVhEhqeLTtm6MgLYKsU0GOa9UmhOYSvzXEJJ5fz6llBdf6TY
 7b6Bw8L5ej5Lr9p15sdTdqe19Rv3No/p/pVMSC8nLlV47CSC0/dVl4N8IB2Zd8tWug/Q
 99TTeQwDseCm6GSZbP1j1u2899nwpO78ioU7bu2j6ngXRDfHm686DRio3ecopNlv2h48
 f1mhEOsBtQpZ4ewpPZf9XVMc9L7M59AdFxDP9dbmRyueHn+mtabKk3UQ4cEP88I4AftX
 Ovrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX79tpGhxyuzxWYT6t8BKxsGWB/RH+yUO4aXgdHSKaWPhzoEUGPmxZnXRlO62TeHQSBehCfG1o1F+tg@nongnu.org
X-Gm-Message-State: AOJu0Yx4LDLm7D0lkBKMXLXlDuIZ7I8gW6VewyWXrzt6HSlYLXzgLYPW
 urCN5GpAfn7vX0sI9S28dWEkr8nJRdYEVGS1y9RXdxlqNsnQ/+n+Zvxx2SmPVuV2ozY=
X-Gm-Gg: ASbGncv/OfrEa9Lcc1HOQUPj0VtuED99KkB+ltRj1A9BoUBcz+4gJv5E1RswF8xlbjQ
 hWrJFVcR5v6aihS8smqYei0PnklGcG21a1MiAAVePSJT0NhWM6J0OzBWxhCGHX7MbYABZ39HT/g
 fKQErXGdlLLKw6COfNy1i/4jeT35KUr1YyZAz7oJ0YuSlvkCO6U7I3z1pdNT69jh7d/0h1GfNGi
 9nP4UWBKLfNCeoX4Rh5kdsa5pGwyuySPwaEIkhvreuZoyo/T8GZKMhfoOF603+LVkPRhRb9n+dr
 iPiE+QZme/YQ2g80/HK9k6nXohDye+roiW73o770FXLN8TXM1a+nm/i96r27o26B9IB49O7fOIY
 p+25/4XIZtFskE7NI3OJUf/scuQnYAAl8O87mEzf7xE8n0iVW5lZri/rxd2EjIoSn3Q==
X-Google-Smtp-Source: AGHT+IEt3M3UWOUaVobp0+d1+c/3kD3hzWb+Ued8bJIBsJAqvmL8JhCPeCCWc0nY3Xi0LyTGQQ8Rlw==
X-Received: by 2002:a05:6000:1a8a:b0:3ea:446b:3eea with SMTP id
 ffacd0b85a97d-405c3e271a7mr896840f8f.4.1758612784714; 
 Tue, 23 Sep 2025 00:33:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f9c62d083esm10680020f8f.32.2025.09.23.00.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:33:04 -0700 (PDT)
Message-ID: <f93841f5-5f0d-4071-928c-07a55486a3dc@linaro.org>
Date: Tue, 23 Sep 2025 09:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] plugins: Use tb_flush__exclusive
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 23/9/25 04:39, Richard Henderson wrote:
> In all cases, we are already within start_exclusive.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Alex Bennée" <alex.bennee@linaro.org>
> Cc: Alexandre Iooss <erdnaxe@crans.org>
> Cc: Mahmoud Mandour <ma.mandourr@gmail.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   plugins/core.c   | 6 ++----
>   plugins/loader.c | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)

To squash:

-- >8 --
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 9920381a84e..24cdb53e137 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -102,8 +102,8 @@ static TCGv_i32 gen_cpu_index(void)
      /*
       * Optimize when we run with a single vcpu. All values using 
cpu_index,
       * including scoreboard index, will be optimized out.
-     * User-mode calls tb_flush when setting this flag. In system-mode, all
-     * vcpus are created before generating code.
+     * User-mode calls tb_flush__exclusive when setting this flag.
+     * In system-mode, all vcpus are created before generating code.
       */
      if (!tcg_cflags_has(current_cpu, CF_PARALLEL)) {
          return tcg_constant_i32(current_cpu->cpu_index);
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


