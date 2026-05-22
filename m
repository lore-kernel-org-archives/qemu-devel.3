Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60775CD5BBA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXzH-00028t-UR; Fri, 22 May 2026 18:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxw-0007lZ-Gx
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:41 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxu-0008LQ-So
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:36 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3695bf7d082so7056216a91.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487413; x=1780092213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4/oXai5pEbDALBm3TmsWJxy3mbxaK4d7WIz9ipLnbE=;
 b=EwaX73aAN+XBBJJrB/6GMU0mfgYBsCUiivMaceWjaVfiC//+THOk1FgIYOvkq6VISL
 F9NgPhP6m4UmUrB80rMm/dGF3YhK3KBZa1EOnYP1tHO2oBQYVunrPwv13J1XjxTHT97t
 O9LLTq+7Kg8xrx4ZplKOC9QO14ROt1LqHMpOGS5qUJRnhPh56sWCP1giXUd3mIWwrZfg
 mOWB2u9jzsmf3a392qC0wpyBdZ0b8d8lslV/RBGP7Du5Wn6mU5AIxSUJyKlTlqd2m/Do
 jHxr/Mc4g7xzh+Punsae2mTp8kIURlw6pdg3gNIciHpOnjEsTUOGEiV96BKQMv2y/j5k
 fNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487413; x=1780092213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v4/oXai5pEbDALBm3TmsWJxy3mbxaK4d7WIz9ipLnbE=;
 b=tJ/lqqBjYe/swuIFWm9VWJqTM8J1yBmFJYnmkqM1Xx4rUbdW53g2zbRoDzlsDWCmPN
 0LbJU8McbCdz/6KTWT9md7LLrUi8ElmO2z9RZwydCw1JR4Xp19S4+DneP6766KPgAOIY
 64YrrNIcHJX+A7/fIPCq7dgmFCg3LdkGvk4KZX0WkWfEllo1WtSA/VfLfqzE0LFPjHBH
 hMaqlS7Ae18pPcFAG6J2FBJwIGivVTejprg71gcoP5q+JC/pMMMMEOyavipA90qSIhix
 k0pAyksDYEmNiRW4HBDaV8YX/+nbn2TuVaHYDCm+6ZyKPFd4cnHWSCd5Qjqv0vIzDNrq
 1Tow==
X-Gm-Message-State: AOJu0YwyS24ufYJlgUjoHHBE2f0kjMkDNj0EMkTdQQ9fiqY4uRuPdZCk
 SShCANmeq3lpWrYyCEmjTUGk8wDZbbO/QP2kAhEZD7IhAKBTP0vlsuXIiJDfO2DKQxgXG73I5F+
 VKkaE
X-Gm-Gg: Acq92OHRR5CqyPU7md5h8UPTLfJ/upFvKYXOar/kuGJO1+1I1to3LVZ8J4G+Pp5RGQN
 tiDeKulRaxq64n0Io5ZUfUjp0V7rgV1vAmdATGnMv28Wu5daJyz4UVLS3fMVoCyeWK40KpE7uVM
 kQ5XtyrTJ26OL458B8q+AWNHCZL/mUASxPYoMaC2v2LjfKZzAlgHPHfnCnoLpaEc4PYC92Idb54
 /pWRfqhAmNL4lIgu6QSJ2MN5smh9zHXv1FyIVYWYg0JNH+UnVpUZwKvNk/uQGJHwGBojeyAajqm
 tjBFfDquqq8ugwO+wQxF11XDeR570HPY2Llst/+aksZGW6pPfUYnsaXDvtFki9JB9SZfc7Ldg0l
 icFc6t99jPU7jxyQJcV5h+oojxYmvXXFcLBhoHYsIqGZTzMYCGcSQEZ8MoanEgUW/0dojtvUhA1
 LJiFVVV5HiaSHEpr6qEnCC4m5koDDg9dhWsarr4vM=
X-Received: by 2002:a17:90b:5845:b0:369:223a:cb5a with SMTP id
 98e67ed59e1d1-36a673ff9c2mr5643904a91.5.1779487412665; 
 Fri, 22 May 2026 15:03:32 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 25/64] target/arm: Set e4m3_nan_is_snan
Date: Fri, 22 May 2026 15:02:27 -0700
Message-ID: <20260522220306.235200-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The unique e4m3 nan encoding is SNaN for Arm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4ea076fe4b..ffe0f6bd09 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -313,6 +313,7 @@ static void arm_init_fp_status(float_status *s, bool ah, bool fz, bool dn)
     } else {
         arm_set_default_fp_behaviours(s);
     }
+    set_float_e4m3_nan_is_snan(true, s);
     set_flush_to_zero(fz, s);
     set_flush_inputs_to_zero(fz, s);
     set_default_nan_mode(dn, s);
-- 
2.43.0


