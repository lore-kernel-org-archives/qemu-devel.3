Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B14C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5hG-0005BA-Nn; Mon, 03 Jun 2024 07:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hB-0004km-HD; Mon, 03 Jun 2024 07:17:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5h4-0006IB-2I; Mon, 03 Jun 2024 07:17:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f6134df05fso38297945ad.1; 
 Mon, 03 Jun 2024 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413455; x=1718018255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rwx0SPD4bR7zPO/4n31t9fpXIatcICjktSL4UeCf/R8=;
 b=H/40aWslX9Eu/Nv67P1tQvFFfG3s/KsXZuvpMA9DlcqLQxP9X5JHFRwEjF537fq5JR
 Pm2ARSgMVaIf1y4bDYERfp5TmNQoTMzQPVjPnVXfQNvCW11Q6KkbPZxyNm5LKSFh9Ajq
 DICDAZHffFDw9Xmo8RlgpHV2qIhQ0lsfbf9HMjvPHG8OLMwyEje+OZrqLyO0giqkDCTL
 91pyZsCuiO13xdwAIS8e1lrqJc+F9ABUcrXj9iJvYQoBimooohpfa7XW5RxYSKePzVbw
 oEod74REZ6Sz1iayyn5nrgggtiZomlGU9Y4AvFlKOwwOvvM2OYm8aFhBL47scIMycmDt
 /vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413455; x=1718018255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rwx0SPD4bR7zPO/4n31t9fpXIatcICjktSL4UeCf/R8=;
 b=X84OdSJbHrkUaALalO9eNM5kHaoxrG3d6LAmyFKRSC5tBI1T/Kpll/2f5ppOeAxXRE
 1HX5RMAKpk7DN7USQT9/jRB3uT11LwIA17/yr/e+YqWNq/d+lXbrYGf46T8ZSYpjD6XE
 +Et+xku6KkI1tkmKOUE2tzyIgZmMqZ/P+QJKk0Vs2pwl4a0N7GnYnepWDJjeHMXiZse4
 4eLI8VLsMGGjRfCHrtBS7KtQ+xMAwLWcmPMHbVl8YRlk7Fi2KpCN61dXpsyhKwrwL7/3
 g0+v8EvAnuL1US3DT83l0AuoEI2o8ty47BH8GLDGX0WgE97YymBavEiQI/0w/xWFYsEK
 /sSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9lXOX7KbWYOZkdQXJnrx4Vz4l7yeRY3Onf6+mw3+oDoohTPIe/l20/LCKIRPAzNmC3lV8lEOtlC3axBAcKewj6H2ThpV
X-Gm-Message-State: AOJu0YzgWoPo1R3LUcMxiSnTnuFB7YH0Npztkbn2joJISP1dRqsgqgE+
 e2h7MAabNNK33EVu5N5Mdd0cHaNG5lV2x2+IyVNjPwPYNeJ1P530DaKycg==
X-Google-Smtp-Source: AGHT+IG5UvPfbBB0v2XrQ3gefMLp1whTssZ+CYnpJJKKoRrcvhbjWsuWTe53y6bjWbt5ByzLVbCNhA==
X-Received: by 2002:a17:902:d548:b0:1f4:7a5c:65bf with SMTP id
 d9443c01a7336-1f6370320dbmr109693475ad.38.1717413455174; 
 Mon, 03 Jun 2024 04:17:35 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 13/27] target/riscv: Fix the element agnostic function
 problem
Date: Mon,  3 Jun 2024 21:16:29 +1000
Message-ID: <20240603111643.258712-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Huang Tao <eric.huang@linux.alibaba.com>

In RVV and vcrypto instructions, the masked and tail elements are set to 1s
using vext_set_elems_1s function if the vma/vta bit is set. It is the element
agnostic policy.

However, this function can't deal the big endian situation. This patch fixes
the problem by adding handling of such case.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 996c21eb31..05b2d01e58 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
     if (tot - cnt == 0) {
         return ;
     }
+
+    if (HOST_BIG_ENDIAN) {
+        /*
+         * Deal the situation when the elements are insdie
+         * only one uint64 block including setting the
+         * masked-off element.
+         */
+        if (((tot - 1) ^ cnt) < 8) {
+            memset(base + H1(tot - 1), -1, tot - cnt);
+            return;
+        }
+        /*
+         * Otherwise, at least cross two uint64_t blocks.
+         * Set first unaligned block.
+         */
+        if (cnt % 8 != 0) {
+            uint32_t j = ROUND_UP(cnt, 8);
+            memset(base + H1(j - 1), -1, j - cnt);
+            cnt = j;
+        }
+        /* Set other 64bit aligend blocks */
+    }
     memset(base + cnt, -1, tot - cnt);
 }
 
-- 
2.45.1


