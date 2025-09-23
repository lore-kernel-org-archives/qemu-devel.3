Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69592CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swi-0004Pv-EA; Mon, 22 Sep 2025 22:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swV-0004HK-IZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swJ-0003he-Dt
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so2566423b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595172; x=1759199972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9c9CwLpLhaHtQKrXnaX1zcy9qSt57CBpOe3eqvDcA1Y=;
 b=ZepRR60j1ESKPELgGnOadC6l16nnScjbdQz+IkzW674CBkIFebn3XLp8aWNDFbV5+g
 aROcEPmkr7Bp5+2nB8+Q3DU23Z50FDEK+szNuqpQH3aBnSzgtHxFrnppmHbuYpG/1kyv
 /NPLURKpyxVcZzD1gOv8BKzqQbIikSXgYtzjCe0DaKdEIl1raU6ocvW6I6pbVkId8GKo
 qqnimbuSAf/HdQwZ9mzzuKcw9DnHvDHFjUhaa5XREvACrf6/eD3Vzm/dwUdyVQ+8Fl4O
 +73OxFtasIUCJrnmWOZP7J0mu8TW+CKl1rsXin8ldqt7UPX5zVe3ZY/b3M6yE+JrNncI
 4o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595172; x=1759199972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9c9CwLpLhaHtQKrXnaX1zcy9qSt57CBpOe3eqvDcA1Y=;
 b=pFoIU7mboLXTjJs94FM0rSEbfbR4gM1TPa50ixfwWFStR5CSQygDUhDZpvidf+MeYo
 bNpASLi2jy+Z9HqcrN3nn1ILcFo2PZZx1pGAM8HNfygM636vXxgpzwQZRK4nNPWP0hy3
 AhsdgNGTyS1am7Xf7iKHvVTS58a4B3XOerx1IIJbDxEkgGueiKS+QwZIzsC5m+J+KspJ
 i3uoxYZcHFJlccqexMnH0vNdHfdbZGl49l4FZiWbbsEyx08DyKs1aq+2ifxBh+2X6DlU
 JNKqu7jqYJn7d6kfW8s/M8TmhC8OYyciH6BJowryUImFpu9qNUcAFYRhFhj9Cu2eDx5q
 MVVw==
X-Gm-Message-State: AOJu0Yw1uVljlhEGR3Dbkew0veKK+6qubXi58CeKdyVCdGod4WtfAEv5
 FMaXpdg+Fxx+Y0Fjw9P1pKfPY0ZAxvmlJMxxHIRIJB+5qQejiV0c7EBlZL3HWxh95/5wZmOJIbn
 7FR21
X-Gm-Gg: ASbGncuQ71qzL6v4sDRWhlFi9L1TqlAvk08dg3M410wbsiWq27UZEnqHnaq923LFQ8d
 B99GfrWQG9mA03MTHxDYYuuNA3KrHAFFn6hmgWMT9MBTwkem7CvvodrKypEmeNRnm8/d05kzrxL
 /A+w/vcTDoUVDVaEGlsAI1lC5g6WazHcDsGNV/VtOTVlJRIP+R31RMwbAEBMamwFNBOpr7xGwzQ
 bzKLqcrqXFIlvlWqsQmZjDJnQvFbMhPXRMf3UlEXCjXnrPwbX9YvdNLDJFFP1I/Exy5ExDRAHBJ
 UCfbWfaIBkXrjtRomP7x13YQhBeEtQpY0y5oQ363Vdx7lpUdICSb/NL640vRcXnkPaL9boTseUP
 +Dm9a6XagLSlUKlrJj5ZQ7o+XC2gd
X-Google-Smtp-Source: AGHT+IF5g2zmWDxP2h77YJN9xtoMUSxKuXMdeszPKAqDpP6ME/pR9qMp4qdEy3LyZFUJuTSjm4OoBg==
X-Received: by 2002:a05:6a00:cc5:b0:77f:5358:b43d with SMTP id
 d2e1a72fcca58-77f53847a3fmr1403162b3a.6.1758595172562; 
 Mon, 22 Sep 2025 19:39:32 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] accel/tcg: Tighten assert in tb_flush__exclusive
Date: Mon, 22 Sep 2025 19:39:16 -0700
Message-ID: <20250923023922.3102471-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Now that tb_flush is gone, with its cpu_in_serial_context
check, we can tighten to cpu_in_exclusive_context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 879ed12442..81e8ec14d4 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -770,7 +770,7 @@ void tb_flush__exclusive(void)
 
     assert(tcg_enabled());
     assert(!runstate_is_running() ||
-           (current_cpu && cpu_in_serial_context(current_cpu)));
+           (current_cpu && cpu_in_exclusive_context(current_cpu)));
 
     CPU_FOREACH(cpu) {
         tcg_flush_jmp_cache(cpu);
-- 
2.43.0


