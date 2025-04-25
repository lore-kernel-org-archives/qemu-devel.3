Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE01C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCs-00009q-Gg; Fri, 25 Apr 2025 18:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAu-0003gl-JN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAs-0001rO-QF
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so2355452b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618733; x=1746223533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bn+fYYVtHN3qvewyz0TX0oyqv2ad5uAcH/EWQW30FBI=;
 b=DcBephtOgou/u5LEK/7IDKy3uV+w2dpxLuflXittDsOO9zx7FaGsOExHd+QDWQwXDy
 SXQoqwvEOOODlxtc4V8X/COlXnW4yWlmY2HegOPIcAZ5VefB+dUQ65NPSeawol9RqdGK
 YJqrtFMaPrIUc5JqFNvd6kCPCl9wCS6M5Ma9k6fjYcdCbCmiWKo2jB/TsBxFRlIZnP3I
 2Utg8NNfN+0RWHfreI+V5vF/IIpP748OELGTjzqD2fMMUxJibWdFNv5eDmYSvoaDNvQm
 wbIrGSsl8+OfSLTthiHbvpHAo7YYXmmK1bHJ3p0OJfk71jwm24813kxOrBqIGqwTd4CY
 PZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618733; x=1746223533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bn+fYYVtHN3qvewyz0TX0oyqv2ad5uAcH/EWQW30FBI=;
 b=Xz11Ng+7WRMlWaIqeBUTGT+1PImK+XxMlgy39YjR88/4504JtlSqlvdJL+pJpYRwmT
 RzhINBCTLXA2K+AfmycnqhGVYIgfCq/mQWIH8DCA9srGEBbQeLja25nkfz8mwoNCdiHU
 J0Cux8IXm09LY+R9+gD+qUs/uRIu+GaMxpZzuSuTpKpS1AWCXwgsfP7UTUFFZ6ScUAGd
 TQDDXtj+E1Jyrbq1MVzyDez6a/JO3VJ7c4TfBglZfqmgCPYDKQJZ0QFql3j3wd10AS2e
 eR+WINzj0OXExraAAYpnem/BY1X5/ya9W1nfS55GxXQyZDJ73yRNiGaOC4MlkC45Vpyd
 Q2IQ==
X-Gm-Message-State: AOJu0Yz0g3/iKVv2UMHvlNmPXmYgOCL/InpzGyk6DkDexqIEx70hGQzF
 qKSLKK/P50H7fj5CHXZil0sFwLCWUKbPxaYcnJFls4yCEqxlgkJDksnP00Hj5P9h9LqYeFCCHq7
 +
X-Gm-Gg: ASbGncuU3pRZVbcvnYzGS727a3k5BTtQB1LPWyxHRODdkUegS6/OGN9iuDq0lQgzpBM
 bj9159JcjTVgueO5bKQEKnARaY3gEgDGzgF0E6nXM8X+534Hz0zR2IfuQ/08byql2KqJGAuEHm6
 ThWrCyQ9/5UF6driNUKWXpq7K+LrDodWe78qd+zd5m+w6FL/NJe4gq3zIyBXmOidYdNFbT9e9jh
 PcZo/Q1RT0DXqqbhsSzaysjx/xrWiDVd8kcaH12+MlmFi1gB5MCvzvu67ujkRZwn6k4WNtJbwFF
 plxiui/jOKcnEQj9Be0oMgS8VQ7Qd6ZwydopVUTPMyCDF91u7ug9qEo6Wolie4yOUzrlxrDtsTM
 =
X-Google-Smtp-Source: AGHT+IF1+eP5+bgKynYwHu36Djb2xW9L/JAOxC7Z3BYN74Wlm52lG8eXRqnOtNjPw3qLyZ1Bdf/82Q==
X-Received: by 2002:a05:6a00:10d1:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-73ff72e26d4mr1251201b3a.12.1745618732957; 
 Fri, 25 Apr 2025 15:05:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 132/159] target/s390x: Use tcg_gen_addcio_i64 for op_addc64
Date: Fri, 25 Apr 2025 14:54:26 -0700
Message-ID: <20250425215454.886111-133-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/s390x/tcg/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 00073c5560..a714f9c0c2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1250,11 +1250,7 @@ static DisasJumpType op_addc32(DisasContext *s, DisasOps *o)
 static DisasJumpType op_addc64(DisasContext *s, DisasOps *o)
 {
     compute_carry(s);
-
-    TCGv_i64 zero = tcg_constant_i64(0);
-    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, zero);
-    tcg_gen_add2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);
-
+    tcg_gen_addcio_i64(o->out, cc_src, o->in1, o->in2, cc_src);
     return DISAS_NEXT;
 }
 
-- 
2.43.0


