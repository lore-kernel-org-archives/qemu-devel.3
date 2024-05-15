Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CE1C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rg-000484-F2; Wed, 15 May 2024 03:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RZ-000448-Cz
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:00 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RW-0001YN-WB
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e0b2ddc5d1so94803901fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759573; x=1716364373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEfUsltW8rumdTfAvGwXpV5AkkGUJRb2ZtYX2v2b8B4=;
 b=BDu0s1/AVAevqwp+t+UuvPkok0WzHr9eUHY7tiYqTL65SD4lcNSql48r2iX3PllbdE
 yWtfm4uH1q2xXRH7Uf76OFaA5OlCz/T7kvJ7yiEuN8B69RIu9NSDyjNBOf8R5cpL1QS+
 XQJWDMio/h7GI7J0GlDw4crowCH3QLJ+n/jJtPdzmjoVPWG5xEAzT14PUYnU4fgrmWkO
 iXnYaIoWY0NrcSt9ocd7zzuY2aB9SkKo4lKS2YYIVNxIv+qWJk1A/49+pkg5CpikuTeV
 nKcUy/5l0ajJaazimHN4+BKAw4Ro0cfiI18ij6KGJRmAe1svg/IlRMjBwJ4Nh3CBQhXV
 YO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759573; x=1716364373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jEfUsltW8rumdTfAvGwXpV5AkkGUJRb2ZtYX2v2b8B4=;
 b=lgAqo6UmXTFwEje/9v+8T++QVJub5Dgx0FXiD0qczi18IR+ctpaTwJK4e0YeQo/9Lw
 j3XA3YJm5iwl2ZmgzFQ/Mg0ix71wg/jVLEOoG8IWNPBMur0bRjlwisWSkwXyU76y2H7N
 9+uir+v+XMPNlRQo/4ImLRXoBAXkrun3t/V6fyoq0DumwlxVf903YOLqRL8bIgmZ7gxC
 veEU570Wfok039xGOkMzN29kI23tOdS1Y8VgJVF7DZKGZ95RRuRAoT1vibxVdNhf61S8
 jZLdexHTSjGjCjPZLEqPWXLcx9PzfUZ0pSXDuqZgrpjfsQM88i9K5BZg4pT2J9V+xwUO
 ++Hw==
X-Gm-Message-State: AOJu0Yz8tE6oLVTZqvCIPd5vag1RhszQ69ncFIuraOkZbk+2nAM9a3Gx
 10sMAtk4tB+qWi6pGdzqftk57GRgsf8L06u5K1asQIPlCb3rrcLQIFs/DvoFf5d+yD+X7tnPeSl
 /Y/Y=
X-Google-Smtp-Source: AGHT+IGpx0zsiVHEZYxAklJSyQOzWLf/V1V/o75oNS7t2vF+62O8kPdB8RSJgFFFlQEtrofCKP7pNg==
X-Received: by 2002:a2e:954d:0:b0:2df:757c:af13 with SMTP id
 38308e7fff4ca-2e5203a4670mr96012101fa.40.1715759571496; 
 Wed, 15 May 2024 00:52:51 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/34] accel/tcg: Cap the translation block when we encounter
 mmio
Date: Wed, 15 May 2024 09:52:18 +0200
Message-Id: <20240515075247.68024-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

Do not allow translation to proceed beyond one insn with mmio,
as we will not be caching the TranslationBlock.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0848026935..18138c61e1 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -240,6 +240,8 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
 
     /* Use slow path if first page is MMIO. */
     if (unlikely(tb_page_addr0(tb) == -1)) {
+        /* We capped translation with first page MMIO in tb_gen_code. */
+        tcg_debug_assert(db->max_insns == 1);
         return false;
     }
 
@@ -288,6 +290,8 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
         if (unlikely(new_page1 == -1)) {
             tb_unlock_pages(tb);
             tb_set_page_addr0(tb, -1);
+            /* Require that this be the final insn. */
+            db->max_insns = db->num_insns;
             return false;
         }
 
-- 
2.34.1


