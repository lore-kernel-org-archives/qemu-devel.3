Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD97AC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGd-0005u7-5S; Sun, 23 Mar 2025 13:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGZ-0005rN-9P
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGX-0002v0-Lx
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2255003f4c6so66876955ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751460; x=1743356260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5/rrT9rGaCRyYHGfR9L9lev75C870EJXXZh29se8QE=;
 b=V0kcn3QfBPvZI+tew/CR1Mc65ccpVAYzDu4sL/tEYVGo4RveRAvX3H1+vO0zzo/SIr
 LItWujIk8rCJ676QV1GvoPUE8D8hg8+Ht+qbbpwr5CIwQe/DO10wBkmuR3/0hT4k5pYs
 FaVibqyEMff7OY5bWaJRUNEHt+9527jodFo7daNZI2omAg0RZueIAzmrPCPK+gl/hYXg
 lZswQkpt0M0AAoXKhM+LyAwrVhKHktpBeriAI0v1BhVWD9Z2PvvrnGqdzJ02Ke7sWdu8
 Zo3+q8PSRprseD9VzCnk8NZHybP1QMWEPdC1Z47Fj9bkkA2ZqQlZ5m7QKS93nwyPnJBX
 e9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751460; x=1743356260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5/rrT9rGaCRyYHGfR9L9lev75C870EJXXZh29se8QE=;
 b=YA+rCNcBxMhYdVzgmHmrq/Gq9YyxmHHh0JyzJGH5RBoG/m6ypXeO6nSnZiIJQ2eKLj
 +ppKYb7OyvB8JxtOr72dkroYwtrGs83qALbYC1nUdHv3ZGXNjZmhUZkBy9lTxdFA8EVj
 g59kJo7Y04fm+xzNZtQbhMUxD67YeYUsm9PpGHzYLDxYgLZElY42iTiyIldh1vX13guD
 Z1fXjFrmxldsS9cBZ/K6TZv0kQqGeu7ZWlBDIrMEP9VMHd2jAjZC+nTqjLVy2Ifq6EC3
 XBUs4TYvqmUbQ+ExJAqwy4oJOlNxF2wqw+G7uKlXyk3HMfDprrSSnjpwXW706CJas9q8
 k45w==
X-Gm-Message-State: AOJu0Yyua2AT2sveXHqHTZwsdRlf69NtGBmsm/HDXpHSUOGPIGFUA5F2
 YHbUWCmA5NQkkzXjT+YRLaCDYYps0mfcPN7dy104aPG7iKgIMkRP8aA8qSY2MBx2hkXRE8Ke9Vg
 d
X-Gm-Gg: ASbGncuuITguODO20uTJamKYUwP1uNZeYYbnwg/pILCdseEIodVXj+xjqrTE/owKcJN
 dUF0hJ8M+kDmzaoEjjRxlcv2qg1nVCO1Uk67UexcK9qZTNALhVG8BsRm093JT4YUZuFwdju94AN
 GyRfVd5XrRVsahLzc7grAFxKMhYtaH+SAmmqLT5zussnrp1ckRLfI93kqcWgGHACIbMg32sy4yW
 fKudnYdgy1s1ld4/94MumiDRmkBtigNP0wzRXoU/p0eTKfTXoisFz/La//zLpjrB4XIQU+8lwTA
 TO/YQqMUrtiRoHWNO3ipxBdu/Ji44E6uQeTn6ylP4E6By4tjOpsWdBCxw/sxXqglQLakU4gPljx
 LEqivXm7UwKw=
X-Google-Smtp-Source: AGHT+IH/b1yUzgQ+kNOeWXZv97pYh9WAiXHTeLCP/1q17A19wPjHihwThAzrv9MMFbpd9mE3VVPK3w==
X-Received: by 2002:a17:902:cccb:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-22780e45f67mr141878385ad.52.1742751460212; 
 Sun, 23 Mar 2025 10:37:40 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 12/17] target/avr: Handle offset_io in helper.c
Date: Sun, 23 Mar 2025 10:37:24 -0700
Message-ID: <20250323173730.3213964-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Prepare for offset_io being non-zero in do_stb.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 9608e59584..3323f32c22 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -69,7 +69,8 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 static void do_stb(CPUAVRState *env, uint32_t addr, uint8_t data, uintptr_t ra)
 {
-    cpu_stb_mmuidx_ra(env, addr, data, MMU_DATA_IDX, ra);
+    cpu_stb_mmuidx_ra(env, addr + env_archcpu(env)->offset_io,
+                      data, MMU_DATA_IDX, ra);
 }
 
 void avr_cpu_do_interrupt(CPUState *cs)
-- 
2.43.0


