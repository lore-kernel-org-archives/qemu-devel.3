Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA847CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHE-0001eu-8o; Fri, 03 Oct 2025 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHA-0001da-MD
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGU-0006GQ-SP
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:59 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso1969600a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511294; x=1760116094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=a7mbWGGsdyJTsjlPFi2qLfm5t/74Bb1Sb9hGvoTHGPEYJDKp61u27Fj+kplmFb1+AM
 KBbkfaSzmbbZGW+LTomGFLeqZPS44fBWfIJqEu1ztj2phiLjgqpXdGjJAEeLDNhtKR89
 WYNJktO3HbOkAbdTwzFGqiTomnoRIa0RVZI6DPleH2AuAP43iQpMROHny+rq1x02dzCn
 7WapQ1T1do/23A+TQ6SFnlaxNQ2dtCE6I+OkAsOb0oRKQwBbWZOoz08IE+xRvC7iXVM/
 ewTDS02Z32XNvkOq2vHkh5M2EZajotHPZbgyl9diErt7h4r+8NaSl+klQ1NAR9J0gQCL
 7Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511294; x=1760116094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=AQo5uBLlGnli86O7zpLvteelr+OuVNCXrixIkYFdtaPewQYGATKURMHFHqBq+np1xY
 Hiu32NKyJgpxrTRndfxAttPK2B1RewuxHJqB0nhZZG5JsgJ87Xx63SXv/XgU2RHfcNgY
 xudSpDvJL/uFDclMB89JgL17A4LQbiiM8y292kC+3BeDCBAos6q3SmvaOhfdhsl+eO4o
 /dcVK3yHu+pfAR+JFBHDW4MndycdI1RmbbiOMnbVOG8HU3tXTyX52GOUjgbyTVDa5yfH
 sQ0PTaMI92hXMSLWj86/di+TV095BayFO9OO9z3yJNGfoE26OrLrkTtAJ9U/CjAgWa9z
 y6ug==
X-Gm-Message-State: AOJu0Yy9+ZI/HniPif+dz0Rvj1FlBR/AamKFKSCSn1x+RSlNLPvs4OWP
 VnvHRHydy5shcuG4auRfd72X9XsXIv2JzAiqofaHXYp/FsOePlaR5Rrcown1cl0CN50Xw75BPfv
 ITKbkCw4=
X-Gm-Gg: ASbGncs4/7t0hK0S5noQR4pmZPXMEDamQ80kEGbFH8Hfl9Va0fltRc7agSf0+E9aBg/
 83qh8rKF9oCQjnMaTZxneDW2w8s81zJD6hivCCD9afINJ1OvANfGBBuH5kcW60xFQB2uz78ODrH
 5vkG+ZkdPQ39mQ4bwaoJB2zUyHsgv+6n4hVWvLaKpgQNfW52oveIw169eo4Oo8bDZrZ+myDnrAN
 u+p6COKPSHuasAL8Sho4poFCIPZq0heuvd8Wy16EjwaeXjcs+u7uT+vD5LZLar2l2yNa2VFahTx
 1x9OYUpo0E5Qr0dImT7hIOIfoKqiaQ4wU1qSIHoEFXqoG/z86GoALef2wLdQj0Na7P1PD7zE/2A
 LxKoB7snk+dMqQNskuLEwFiMhIIamfYTNUQlRc/frB9rG412O59LvDQq7
X-Google-Smtp-Source: AGHT+IELyLr+8U71+WNl4ytbdPdYdP/WxQOEiP3eHIBgGShvGnJjmPYxdK/TxLm0nI/MNO/jWrXbKQ==
X-Received: by 2002:a17:902:ccc8:b0:28e:80bc:46b4 with SMTP id
 d9443c01a7336-28e9a664f0dmr39901635ad.55.1759511294154; 
 Fri, 03 Oct 2025 10:08:14 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 14/73] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Fri,  3 Oct 2025 10:07:01 -0700
Message-ID: <20251003170800.997167-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a3..66d9c58b3a 100644
--- a/include/exec/memopidx.h
+++ b/include/exec/memopidx.h
@@ -25,9 +25,10 @@ typedef uint32_t MemOpIdx;
 static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
 #ifdef CONFIG_DEBUG_TCG
-    assert(idx <= 15);
+    assert(idx <= 31);
+    assert(clz32(op) >= 5);
 #endif
-    return (op << 4) | idx;
+    return (op << 5) | idx;
 }
 
 /**
@@ -38,7 +39,7 @@ static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
  */
 static inline MemOp get_memop(MemOpIdx oi)
 {
-    return oi >> 4;
+    return oi >> 5;
 }
 
 /**
@@ -49,7 +50,7 @@ static inline MemOp get_memop(MemOpIdx oi)
  */
 static inline unsigned get_mmuidx(MemOpIdx oi)
 {
-    return oi & 15;
+    return oi & 31;
 }
 
 #endif
-- 
2.43.0


