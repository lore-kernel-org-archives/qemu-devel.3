Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD2DC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RE2-0001xQ-Ic; Fri, 25 Apr 2025 18:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAu-0003gi-EG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAs-0001r1-5H
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739be717eddso2237330b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618731; x=1746223531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FD7zSVR3Q4LrZfRx0ERWq+DQq4788FZCK/1Nh3SIM4=;
 b=iD9wdmXbJM9YI7KVuU8Xz72lfB9axpBceQQdhb9WEobMpwaojUhLg38wH5PTzFBRoz
 PydEHo0DulaQbpEzEMJFuh3b6zcV1KJMLsYHCU0sZUhWkgKQXYEOi9cmGWPw2ZZf5ZGC
 qwVGEhEBY83a+YSm2Pb5wMGswkz2HHja9jIIRUX1XKQZIzHlSrng/lDC1ACEgl9Dwqz0
 zVeiMbp8j+sVfaV4ejNyEQXQ9neGWYCTj6p3fLndo5xIKzwbScL4LbpYGFikO93GSMKS
 2dojniCOLjewg9iZjr/9L1z/hjqFLkdjZDfQrMprTLftoJmPculmJIPXS6nzvaJyWADO
 e35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618731; x=1746223531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FD7zSVR3Q4LrZfRx0ERWq+DQq4788FZCK/1Nh3SIM4=;
 b=rgnFk/JQyaTUEDx8gjobCvuq7cXgFgwMJF5KS7PyWqKmQpoOUttmHJZnnXzX81F0lr
 AJdeCqNZmh8xRgyomEEbPrnwbPpQPdD/AgcektWQV/umS5ZvME0W6MMi/jPJc1K5vK64
 G6/+/SuY/sCOxJZjq/J++0ynFQmy67S/brGO6sKIqAJ4zX0PRcxFQ1mpA8B9c0YfgW46
 9wIzAHVg19aXCxMNxkRdRjmXxTCuNXJGTDkEySNRs1JXOVa7OZz908QVLP5KAztYkOG5
 46YhRKtet0rLceMQysNIQVYhbhasG6nmMQGv01AH0RUCQbo+YRHp6HPQR+bpB0ifhtKU
 P69Q==
X-Gm-Message-State: AOJu0YyFp/VrZ4RIPOFfvtnAXC4a0UoJKKCEtjt3i+nxRx7R1RTOVl9e
 PtxBrekevcUHnbVNtE1hReZvcEz+jCvU6xxF5bs/j/oA73GE2uLjiYGJk/J7p7zkqrI+ffk+P0z
 A
X-Gm-Gg: ASbGnctg5gwRqVA7sQEKJgxDwY7ICls5Y+8RnKrtc3Ulyrhi7nmSsoh9whAvgHaTe/8
 /XpueDV+2RC0jzDs8xxqHh31GWV86HU6xaFqhxvp54QPjZu2NO4CmbRTWo2H8GA8QVlKthiYHdG
 asA4cLzAlFuUh9TbH3/mOwzyr8IZhvUgW987QjtxGSQWC22aCTJ7vlxuJkpG5uXdDyXJ/bguQeN
 4NIQvP7m7c6HFNbD+aGbdZSgqumx2RR9WGaJIFlufdFJNYJj/bovWrTHT0+YaNBy4Yhpg/8XGDP
 Hq6aBqWzYb7+GZ+eQ4kT1L61rSfdSLMCt6LgwU0PzBomHtoVv56JsB8x6YTZirfHXGl1ilHaF9E
 =
X-Google-Smtp-Source: AGHT+IH6aMKZGW/Fl6LXQlpvYYLqqGaxhndGJrmItNI5Kz9wy2gxOpqEekYHQln9JnWDOrpjCoI7ww==
X-Received: by 2002:a05:6a00:188f:b0:73e:2dc5:a93c with SMTP id
 d2e1a72fcca58-73fd75c4b31mr4963636b3a.11.1745618731450; 
 Fri, 25 Apr 2025 15:05:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 130/159] target/openrisc: Use tcg_gen_addcio_* for ADDC
Date: Fri, 25 Apr 2025 14:54:24 -0700
Message-ID: <20250425215454.886111-131-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index d4ce60188b..baadea4448 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -221,8 +221,7 @@ static void gen_addc(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     TCGv t0 = tcg_temp_new();
     TCGv res = tcg_temp_new();
 
-    tcg_gen_add2_tl(res, cpu_sr_cy, srca, dc->zero, cpu_sr_cy, dc->zero);
-    tcg_gen_add2_tl(res, cpu_sr_cy, res, cpu_sr_cy, srcb, dc->zero);
+    tcg_gen_addcio_tl(res, cpu_sr_cy, srca, srcb, cpu_sr_cy);
     tcg_gen_xor_tl(cpu_sr_ov, srca, srcb);
     tcg_gen_xor_tl(t0, res, srcb);
     tcg_gen_andc_tl(cpu_sr_ov, t0, cpu_sr_ov);
-- 
2.43.0


