Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1B9C3DA6A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNht-0004Ur-M2; Thu, 18 Jul 2024 05:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhp-00046n-39
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:45 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhj-0007hG-FM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:44 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ea929ea56so253290e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295937; x=1721900737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylkt+dork9PKLTjjXHJbOq2whhnT3rDmt5DUEGl1o4o=;
 b=ipfBhn7cBlC500LwXpTMDBzFYLz/lG0mLuRRqk3rxLWPaIR9M0ioHd4jjsqIBAk4o9
 hQwuTI2XZway+WXMNTOwTMQI/WOmP4YpKkE6NAd14XEMrIBgDuC/61ce2omVk9YXhMsJ
 6n/1kxjTi9pntef73FcGKSKmq/smY7XTnnw5jW40yUsikV82kSauibqrXarg+hV5pH5d
 dnsQktlelQjZl6HWtt9ARFuBrjHnG8AKcQVtfALCO1vQe4T37mR355AePJRYctYCdD07
 611Gze+KXMqueQ+uKCaJ0MS2x228Xuc+X0K2wR+11hf5tPn2xmLQDvXX+79C3QHXxhvz
 JCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295937; x=1721900737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylkt+dork9PKLTjjXHJbOq2whhnT3rDmt5DUEGl1o4o=;
 b=gDkRlvvZvU5jqFuq90jfKNvWDmHsdurfTQoBxFvy0QfqEtAcf62u5KlTp7HoYaoJi0
 FWStn4kaAF5Y5ja5CO3BDf1RH22pEv7GPf1wzQlDS8ORcZZA6ur0kKXvVdRJZg5h3200
 4w0IFz9Splwrrs9QY/MphjceYKGJQg5vpEB0KAlSGnYRXB/U3rRdNbVUHIgmZWC8/qJB
 Y7j+6I67G67XBuZ8h9kC7sBy+i0tICeeI941W0qy7SsoEk+QVP69qWwsHvRq1WanOYhg
 NMRVAhe7UERAzvtP5B7K7bJaz/jHeaGaMf/mojnr1gSRhemKMS6nOSSpWf8lYv1caQhS
 NZSQ==
X-Gm-Message-State: AOJu0YyBtKpsKsEh5dHgvD+LkaECF6ja9i0sKDYnVpwXIWpPQYDeOWCV
 T/HJvhaD3y/leZzC+Bw/jpbw8EP2mryGraezyo8i7na4HeqbPWkGTwlnPFa2zKs=
X-Google-Smtp-Source: AGHT+IFYR7suPnUMmr6prBjb756y5egUzEjTRbRx/2xnnFB+/+Zbmh1gGUfvplTvIoD5cVL2krCpIQ==
X-Received: by 2002:a05:6512:a8d:b0:52c:d5ac:d42 with SMTP id
 2adb3069b0e04-52ee53a76a1mr4011463e87.9.1721295937215; 
 Thu, 18 Jul 2024 02:45:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a3584sm539375166b.45.2024.07.18.02.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D0865FDDA;
 Thu, 18 Jul 2024 10:45:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 15/15] semihosting: Restrict to TCG
Date: Thu, 18 Jul 2024 10:45:23 +0100
Message-Id: <20240718094523.1198645-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Semihosting currently uses the TCG probe_access API.
It is pointless to have it in the binary when TCG isn't.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240717105723.58965-9-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/Kconfig b/semihosting/Kconfig
index eaf3a20ef5..fbe6ac87f9 100644
--- a/semihosting/Kconfig
+++ b/semihosting/Kconfig
@@ -1,6 +1,7 @@
 
 config SEMIHOSTING
        bool
+       depends on TCG
 
 config ARM_COMPATIBLE_SEMIHOSTING
        bool
-- 
2.39.2


