Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CCDC4450A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIGY-0003mf-AM; Fri, 10 Jul 2026 16:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFC-0001kD-6x
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEw-0000rR-Jg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8454160043aso1457389b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716869; x=1784321669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oTQ42LKlvaXUmLWp84DyN7oebX42kH2GrCSdO42BkNs=;
 b=nPlyKx4uzAOKw2uirf/xZ9exHJsp3oN3YTEYePgVhZPpFLWok0T6nbuE5nkc2Y/m7Q
 6D+T+7cEnfIIJbwJAPvd90UDRCj54XlGvC4QSspveQM9k7d3cx0jVjijGx1Tg6hXTjSd
 2a0p+IrIvUa15CCbzxYxCXfDRJH60ktXGutwZuYpnnhGu8M8aWHLenBfSNX+XK1oIeDH
 uvY9sTff79AD5jJ2RCGBywSTeZ+P2ISPd5cWMISZFZnt8FM+p3FYMKau7LY8HFwI0tWh
 0Xttku3klGSHY2+/ErBEHQ4gv+HtLsiv7zD2HtK8yxZaKQvPVBic7E/Ba8Fv+DEzGcHf
 tuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716869; x=1784321669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oTQ42LKlvaXUmLWp84DyN7oebX42kH2GrCSdO42BkNs=;
 b=NcNN6FViDhpfLWF2nV8FlHHuvlXiy+TG3Ts8EYjoFwpILQYh5uWTal1sDtAi01QFI6
 qyTSrz4pyvKPYOeEDXAAqYWtoyxMiS2KRoIHH0c8wLO3AGgUi5uGw2uYBLcX1p7GJcDk
 A1nQr5yU7SU83BVgjh5E0XWBcFn0TsHL1LjfR0dC3xAJDx/xDMf4WuETZJWmDBjF+god
 gSqhJfn9LRdr77kUc8pGucMg4gnUQOly6xFcZhv61FH2R0aiOMvbeieSjhdCaxjtpZ15
 qMjkvRee1jdhIg3X/oMPL9/o1CALp5thTIewttPeoe53BSuRUXbaHCz+RR276RBy0tIC
 AVYg==
X-Gm-Message-State: AOJu0YzIhp52hLLmUtMIrodzQFSz+NX9rlz+2YbtbduSkcgppUHPBUhI
 IGDOa9g8+3taYr20ZojFwC1gHrL5Usm+dCbHRJMPeLCI2uHXBf3C26ZjRRuxlptPug6m3AXY3GA
 gITN8
X-Gm-Gg: AfdE7cnXGadpIkQvXuoWwJaPCDDfe+1AbMfZ64UIAe2Hm1rxVh/CLHCYe7yX2YNMrSK
 31BjGUdEDiZOSfJ8EklIVknd+tL1XHRpIHRQ8V4cMvtJO26JSN8FufkT9S7CYXlMzp6j8xK9U1j
 xsgH7q36Xa8rzZYwSXpAmr8rk7O1N5fV8uMhf8UL1UEUmr2PGkkiX0GI/bK9nHhw4WaY6TduZNr
 VxAaRkbXGzOoE6tAjfcLQllRjEGhuSTQz0ZAply1S4ZRS+/9w8QulPRnIqynLoVYNCMIAqxNYmj
 42+mGV2w9GofR7rcqal4rGSZFR8Y0amOfLapEPw9AEqMJJ5Z3O9clfAfnK1dKrp5ZIZLIsqEXJ7
 WLEvcqI0N2iMmXD7mjtcQhloxRuvE0Gb0WFZ0Q6INNxD/iqGKG5dRHdPaYLp0JIAi/bqkKC1xys
 s3lxgkCnbh0XoD55wSUw==
X-Received: by 2002:a05:6a00:f89:b0:848:3e74:85eb with SMTP id
 d2e1a72fcca58-84889611e4fmr542804b3a.1.1783716868959; 
 Fri, 10 Jul 2026 13:54:28 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 24/51] exec/breakpoint: Add CPUWatchpoint.hitlast
Date: Fri, 10 Jul 2026 13:53:34 -0700
Message-ID: <20260710205401.836304-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Allow the debug_check_watchpoint callback to see the
entire range that triggered the query.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 1 +
 accel/tcg/watchpoint.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 60fda8dbb7..fe6dd02bdf 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -37,6 +37,7 @@ struct CPUBreakpoint {
 struct CPUWatchpoint {
     IntervalTreeNode itree;
     vaddr hitaddr;
+    vaddr hitlast;
     MemTxAttrs hitattrs;
     BreakpointFlags flags;
     unsigned id;
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index a7ce5fa9dd..edd1d5708b 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -89,6 +89,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 wp->flags &= ~BP_WATCHPOINT_HIT;
                 wp->flags |= flags << BP_HIT_SHIFT;
                 wp->hitaddr = MAX(addr, wp->itree.start);
+                wp->hitlast = MIN(last, wp->itree.last);
                 wp->hitattrs = attrs;
 
                 found_wp = wp;
@@ -109,6 +110,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 wp->flags &= ~BP_WATCHPOINT_HIT;
                 wp->flags |= flags << BP_HIT_SHIFT;
                 wp->hitaddr = MAX(addr, wp->itree.start);
+                wp->hitlast = MIN(last, wp->itree.last);
                 wp->hitattrs = attrs;
 
                 if (tcg_ops->debug_check_watchpoint
-- 
2.43.0


