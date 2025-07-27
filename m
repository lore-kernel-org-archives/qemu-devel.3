Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB8C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRz-0005X2-Qk; Sun, 27 Jul 2025 04:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPj-0003g0-6u
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPh-0004rn-EA
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:22 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23602481460so35115405ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603640; x=1754208440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aRYtrkrc/9kZo8KuhActa/u/OWLIUyr4LApQE/Ub6k=;
 b=tTSUMHAl/7n/nH2wIloQhShbcZqDasJIFXLLJdgUJib8Y+TSrSJGRbEYvw6iSc+xfF
 niTxMWBkoqCZqKl3MdOgO2BSJUGowBxqXF7ARGZ1NOzq27O1fR3d7h+27jSKBt8bvxux
 YYGsZJpiB4HSMVj1ktnILZrgY+j4JYM60pFNYXiZntmgUD97azgA0vO1a9ENnlbnbQw8
 gOQE3OHHRmi/g+2Xbcqj7w9uoXMuKaAmDXfUZjr8pu6zQyPpQ2iuraLrt5iG3pi8yeSs
 2tP8i/BOSWEeHvIxfDyly9HXnSy7SGmMhOifATPuhcplPtNsB8gCBNK13Iza40Q2VOWo
 faBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603640; x=1754208440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3aRYtrkrc/9kZo8KuhActa/u/OWLIUyr4LApQE/Ub6k=;
 b=dZhWxQsQ7NhblL+Epft0kyWFyug5XtHUMs1vmiRvvB5tmwP6Rd23KYUGM+UmOLPa/X
 Z/jumzjBtkMaQqfsUROgvta3qM268PBu2ZD8MSgeHAd5QKPtZIHB3rJPohad5lGdhxaq
 daC1ed9CaOX86IHXCxq2qy5W9iVqgN9AziHbBMTGDYfY6lQ+SCaFWYnYadDUK0pq/iGu
 BD6VGsT/zMq3DD2O3BEfeZKjr/e+1s0sTOkfB2n4L+oew4PzIUQiW+I5WPCBaoYdkucX
 eOk3jApX1lLkDw6iPUObXSzoBGomSSq1fS/qR8Wgpof91ht7/I9M5ihXYFHz/nAQGuxz
 CJPA==
X-Gm-Message-State: AOJu0YwWXX7QWGBTwwfkM5+qAkzcWdbl7iZ/1ZUiwt55UoJTT/71k14V
 Y8O3ovCPZoTz0dJYd0l+O4flkP/HJCZBQCoYRx2jvfluhkD2SJ3WfFtTcKJjSh03+Ue3ro52hS2
 h/SRX
X-Gm-Gg: ASbGncuLoODA3H7OQRrS7C6mDTO3WRfWR8QkhPudIkf+EmOVdRmYB3/0PWzocm1JtN/
 Dk0gdJDzAKAawjjiadgkvV5vDGgK9c2VNyASHYuwupH40jdgU5I7YqBiTBD3l8U1BJbuJ+Dh9S6
 2PGsLAEeV7+1VzX4bZnNuJTwWqmKr8B/DirlDKigK9HcuO2bSUOVOtZXhzMz2z6tS1HWVjfsbUZ
 /gp6gdoCIs+RefB1cT934UY/olU2GavUm+CO4ribMxTsv0cfa3NYbX35cS0nShp0Wm8reiRh/T5
 /4r4AZ+eMnRqM7p23J3wmt/8XmtVFdptnH2c2QPIpqV/9ELSQ+VbCy5jCa1Gghl8T+M16vgFIhY
 +EBVdWEzECgLSzSq6Y/zP83NpZ/FO0rCiZ9Otyee9zsv2y+mppZWcTGyZyKgVHeaZLZZ0JlLTNj
 F1gffDYC5wbg==
X-Google-Smtp-Source: AGHT+IEeP+A39mBZ6PlXL8UX44ZOiw0oYRQFS/jwuY/iWxLsPsXXx4nHwqubE7GS+C2auFS9DgJPlA==
X-Received: by 2002:a17:902:f607:b0:240:9f9:46a0 with SMTP id
 d9443c01a7336-24009f948aamr17984795ad.38.1753603640071; 
 Sun, 27 Jul 2025 01:07:20 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 69/82] target/arm: Implement EXLOCK check during exception
 return
Date: Sat, 26 Jul 2025 22:02:41 -1000
Message-ID: <20250727080254.83840-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index f61adf1f80..7ab7ddf7c4 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -694,6 +694,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         goto illegal_return;
     }
 
+    /*
+     * If GetCurrentEXLOCKEN, the exception return path must use GCSPOPCX,
+     * which will set PSTATE.EXLOCK.  We need not explicitly check FEAT_GCS,
+     * because GCSCR_ELx cannot be set without it.
+     */
+    if (new_el == cur_el &&
+        (env->cp15.gcscr_el[cur_el] & GCSCR_EXLOCKEN) &&
+        !(env->pstate & PSTATE_EXLOCK)) {
+        goto illegal_return;
+    }
+
     bql_lock();
     arm_call_pre_el_change_hook(cpu);
     bql_unlock();
-- 
2.43.0


