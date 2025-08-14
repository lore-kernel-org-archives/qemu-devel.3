Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDD6CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXek-0004V1-2W; Thu, 14 Aug 2025 09:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXds-0003LD-AU
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdf-0005NO-QV
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:16 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e2e8bb2e5so1141811b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176699; x=1755781499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52VfTzYDSgjyTkCxi2KMOJnfbsQ5A6/k4xx3za3L80c=;
 b=ZhubJs+/BwZY0lumJQn1nYBtM6oFZcZw1e21YQxrqPynYS3xH+lF7arO5BrxUi0Exc
 pok/qVjqrc5q57UrQE4Ye0lRtM0D806uPuZNC2isd3t+kFFZE38utXgd7M2GP8AyeFYd
 twSLzlW78rJ7LqLqJywsRCYfZ5txIRB4OE15oW+uICyp7RvlezWh0rk7ct4yTrQiheFY
 wIg0q2UEHlzldck6H/eQFzSh7Y7VCiiDuW03HWEdsJG6WCCW2VufvimFTnFcUNhBJWsg
 78Az97GpdYh5vQCVefeboaSzom/v3jp6AJeDMIgW/+8GVKhgYins1/0DCButtlniidJL
 gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176699; x=1755781499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52VfTzYDSgjyTkCxi2KMOJnfbsQ5A6/k4xx3za3L80c=;
 b=byVgX+fSi46eyklVMOydu5Plovh97vo4qn3v5jx4avlnrui4foYwvIqH+cOiGnVpGX
 zKlUwH1UQ8GAOMfzTBBiPqAFZXTLo2KnHhHWTRp1wBy/lxIdnvOkWABlgzU7mVdBi/NT
 qQD9ta+pyv0QmHwS7J1T3aGMAGwLdC/G6QUaaxA/zkGMMOSIsn7gGXWVg/Cwgwx7Ne5d
 pJgbnmp1jAMyUv4Z5TaY9smG+tBjiOzI8TXUosaDD9U8xEUUAnKwACav8b1DC46VhLl1
 aMPRVZsl3H4uLs43xgze61iq6IqZFYSlz7/NdaVwvfBkl6e0jG+raoUHfG2AJap87z4M
 LMfA==
X-Gm-Message-State: AOJu0YwYLH3Jr4tEvAAhWmpMNPD5c7ofU7cF0n4sWm4+hoSrpJ0ZKqQA
 uYpQdMBEELxEN70UR2DdYjraS5aUR/rnOOLDA2NkbXhXLw9nTuoZ+SYVY6FnpfgMSC+3zd3+6ok
 S9Q8Ep6k=
X-Gm-Gg: ASbGncvhkYv0LOjyeNqXXPinp7Xrku9KFwKbNzpv6h32GsROEXoDf4/qTTaOKZhPYwD
 cO/IR24Y7NODSe9GYNjbOTheXpX+cryAk2atquGlpwEVpZeXW99guSStZvGMb+KoVCYKotuMmvO
 m3Lrz/tsc66A3kLu3NVsLUl9x944VelkQWEQFjrmdSqY3NDuGD/3nrIEC/TPopX/8aumX+FGjkc
 JMGXGU+Y9+RvzFdUD/XdqBdbGX/Bb3tmoPqwOF/CqDU+rNJVVRCs9TPybw90bqP4eZosRuQe0Yg
 JTQJGBeaRDQOKNoE4S/AXdskizFUDA99mw0KoFDjU3hjMCoLpnLHq/iFvdxsl0vF0nApVxUMzI5
 pfJq6O+ryf969745OjeHnJxYHsXx0iSvMe1Cnzgu3Ytend5I=
X-Google-Smtp-Source: AGHT+IFYy6VeKxegeUXeSlAob6/MtLuOQ3HsrHHD3yLrNCg8ojehEmagSqWqjoHYpFGC42rI/oGmkA==
X-Received: by 2002:a05:6a20:728e:b0:240:c3d:2449 with SMTP id
 adf61e73a8af0-240bd2b465emr4986051637.42.1755176699035; 
 Thu, 14 Aug 2025 06:04:59 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 72/85] target/arm: Implement EXLOCK check during exception
 return
Date: Thu, 14 Aug 2025 22:57:39 +1000
Message-ID: <20250814125752.164107-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


