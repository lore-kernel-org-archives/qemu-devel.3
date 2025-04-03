Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF9EC36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0SgR-0008J3-2r; Thu, 03 Apr 2025 18:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgP-0008Il-OH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgO-0003xg-11
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so13613195e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717906; x=1744322706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUBhKNJ33VGc0tAXVv72Kq3hUC0BPxTHmotqIBCHglo=;
 b=LjBdltdtGSMgtNCb9tSVYRr5qTe8staTUkE2OauFlK3h24m9oHBDiuIUBtPrXAzMrw
 qBjlikmV8cB3jiIWsosKOSP7bipGis+xmDTuvCbW+9Hl5e4VqCki0v9nT45mZSxfXpuw
 +/YlmJ/rfa8K599cKnBoSNA+hbH5oP+zH1HGKcCsPQRqyjQKZeb9eDWfvpWXbCsm3b0k
 9nW4wTkhgUlEOdbr8uv7PWQnBkHyUFwhvoEXSio7yt/tUKFzW2q5jJTgAsC9BL7LvnHq
 5rD221gdt0FIuDCj7Ve/EbExO28JifK/XR/IsxWkFTSyFArUg1M5ybSpL3RHRGY3dZWQ
 jsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717906; x=1744322706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUBhKNJ33VGc0tAXVv72Kq3hUC0BPxTHmotqIBCHglo=;
 b=lLu90EYkMfljGTVD5HVUNgdDKq/HV9sH4hfIRGzkaolifeUy+Gwmn5wisxSiiHqqCc
 SM0pMRpeQv8dqrHY8YiwKmawwzFpxqi5kMQ/JMZF2BkB/T+MtgkiroiYp00Kx4BXL2Xx
 l48gKfMFTDsaw7sMxJMvXGupPgHaQnizW5+c7OuFoO7/1iJoRgyF+ZEjkwyU6w+fhoLt
 6blm5PjJ3ry/f7kAw+Wz5TToxfbME1+cFJ0FHvB2Or4Gu5IfsjZUlZpzPrnkHnELNkF3
 9lZUWVZwojTStzA2H2paKAxKh3ADgW2mGxB0axpavxOxDf8oA1h7VmacWbLU3s4tg+eg
 A21g==
X-Gm-Message-State: AOJu0Yysc35B55tBDeXwXXcxMXGntDrYs3seZI5JC/bw+PqLTXcJCzY6
 Fz/eG41ommxPViJVyFSD/kvUaOKkg9i84LhvHgpZfSf6+lw/wm4uQMNhd7E9/hh6i+vlOSG5KtJ
 +
X-Gm-Gg: ASbGncsQ9MeMu2j2CYtVMdWrTbJIjveogBpaevugjXUCqwMNUZ1d+MtM7s9VaV8ZntH
 xE1TGqy1x90sq+Aldk7MQAG3YDSm+RLcb5aowmK1EspTF2kfmR+4YQXeOoVPAuBLU7tLA1z9c2i
 4ZGNMPgb6xwAx5jfngM3GSfNBYrsclGJBIcAG4sFBB0PU1IS9QN692QqMVc+HNuPzwxQYJ3eENg
 FaURMg6VxbN92eLqqQdJAX3l99I+wHxWDBMKpJBtS9SQY/ykXe6gmPKC2EsPw47rrKcRHJjCqOW
 wU42cDMWvYjM7V4cfQvDu7coPzxCMR80EVL2RupaAzP+wuXyuW3iSCuOUzq4kEa7aHe/4E7Zq8p
 oTB4TSy1rUAscbjPmHlhdZ/n7
X-Google-Smtp-Source: AGHT+IGpxkOacXMIFCNXPTXtbODqtbRhVu+F/tN2FdYy5jxoYNLsYx9BsZ5cj/YzY87fkI5+12J73g==
X-Received: by 2002:a5d:5983:0:b0:391:2e31:c7e1 with SMTP id
 ffacd0b85a97d-39d0864b971mr320332f8f.4.1743717906243; 
 Thu, 03 Apr 2025 15:05:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba2dfsm2824683f8f.60.2025.04.03.15.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 09/19] tcg: Simplify tcg_req_mo() macro
Date: Fri,  4 Apr 2025 00:04:09 +0200
Message-ID: <20250403220420.78937-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 05abaeb8e0e..1a46a7c87dc 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -52,17 +52,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7a5b810b88c..a5a1fd6a11e 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.47.1


