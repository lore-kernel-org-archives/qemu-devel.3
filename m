Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5187CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jMu-0000mg-6t; Fri, 03 Oct 2025 13:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLH-0006nN-Dj
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jK6-0007oz-CU
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2134336b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511517; x=1760116317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIGC+NB44/a0H+dR2upS+UgyhxrsXnOzX4fio5wssx8=;
 b=xY7jJ4s0lx64rgKaq6a37p3JFSQm49kGp4xQ1fRtEwXVsz68WoJl1BMVpF2m3vDjKk
 1s0eld5Vj753qorZWiWLpujj6YHDRQEpbAyMv9yIiJ8n4Nx93Jj8CRRiwR2v7do5oigl
 Qp+xCkJeTKAdIseHt/apSDpgaYWoj4Ng82h9tRnf5rb3Cee5r5c/RpcKjPQK/ja8NLjx
 qINlluKmWu4Up3TUlyT7NAwB2fypzpocHVmzJpZi2t3cQKM18nyGAWL3nTaVA32F+Yx/
 I2calnVQSjkAqxX1P49yjU05ws0mFFo4/nXXF9QBk4uhxPMQURq5lfSJj55IGuKn5NhG
 OMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511517; x=1760116317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIGC+NB44/a0H+dR2upS+UgyhxrsXnOzX4fio5wssx8=;
 b=OUVVEeA68l87kbLYvSzPfjL2SVFYb63gQ5MWFSDWYYywDiXn69U2mbTf0rG2jmuDH6
 lyXTG7ffbCV3vuhCbWwIqx92njsqdx7Qf6pJj/kce5qMfheV4JgKYlDr2z9jEbLhV5ky
 MBkpKoJdbTp8DZL6/oIWLswe1QhXqFm5O006shXWuGuHePAY2eELrlwz0fQb31Af7/bT
 tHDdY7zQxh/aBLqtyycyG0ZwUu1j8Qj/59KOO0Z0UuLsyxkGIU3aiP68ds+jlxXJuo4w
 gGYdG5FeU+8LXbMd+lcxj+wc2qvgFhBkgutExGrbQgsIVlecXNxQGlCpEKiNqpeidtE9
 21fg==
X-Gm-Message-State: AOJu0YzeRc+zqe+kobjC9RLxFTWtdl/LlZb4JuyD2ZZwCmy0Tao40ik9
 LE+oV66jGSFRuEfCwMDf7MppfHkaIcztgKgYjH8Qf/ihC7yZbrNKtOXnUBBaFcq3XZugbTseHgI
 iPKm/40o=
X-Gm-Gg: ASbGnctr7QNjWw1ir2cz6m8C1DNGis+zzjyqnOF116Gvg06QVluSzMfpi381lrf3g6T
 f655r0a8sgAUY4OzXlgrcD5pwFBb4FIBxZh+C4oH9Pepi4QNbHNht8WO5vm3tCQ9jyfTuqKqqBL
 sCngPKK7DWwStqlATSVPS5T6hROwePaA9dEs8m9vjhkVyKzO2uRl7oK2HCx7UlIdIESet6H6hO6
 8czn6j9Dvf95CouLKsSEx9C8yNCEKPgCYB2Le8Kda9PcqA/wecUF1pcY5BqhkUC3NI7STsWFprp
 b0WDq/gCidndbzss22daoM+ap8IpsbNFcbERWkhKuMs43hylE1zNzoDTcf0Rs+8PcxFsnbN5kYY
 EPpW0UpO8SicpQWouMDCsTfrSW4BexrT9WlicHqGdWHRKZ3KysRWePdgU
X-Google-Smtp-Source: AGHT+IGlnK5PbF8v6vUzusOfUZPUVPWjJj2h+hPX7jfXkWRSL1taMWC0oWt3T81w5cmfl1+6Wn2EAg==
X-Received: by 2002:a05:6a21:6da9:b0:23d:45b2:8e3c with SMTP id
 adf61e73a8af0-32b61b2e08dmr4990097637.6.1759511516767; 
 Fri, 03 Oct 2025 10:11:56 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 61/73] target/arm: Implement EXLOCK check during exception
 return
Date: Fri,  3 Oct 2025 10:07:48 -0700
Message-ID: <20251003170800.997167-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
index 08b7db7c46..ba1d775d81 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -675,6 +675,17 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
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


