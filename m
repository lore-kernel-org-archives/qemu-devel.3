Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA2BC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSZ-0005fk-IE; Tue, 01 Jul 2025 13:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSW-0005bk-6n
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSS-0003ZD-Nk
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4539cd7990cso14794685e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389667; x=1751994467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NkAj0AEskJHRUO2iJr99UKhDE0MC58f7E9SHfeTX+6I=;
 b=junCE/Dn3xGDj4M5gJa0Z2FztUvwVwF4/QfuXZYvSt5bIP+8LArdQFqzG2FU5iLopP
 HlS5oTLlc9UywYFJ50TWz1AgzyPr3RaMz4TYbyKGG2mvWUyGpdO137alZ2Nz2/eSk1hr
 zXdBCIz3688v9EdQoLLmkec2JTFbQaD6DGYYmWW8CBmU6eqhHKXdDDNyzrbDrsUDFLHA
 XwXXV8zC6NhAHWAZir8QWegTv8OBQP0CX5ah47V4iB4OC+u3n+ypZHVVTOba/hQMg8Z0
 kXBUp0MsFIs0ZnFTYOeVql1Y6shPBfuRUnBtz++obXVLRTAuMIoGhe4KkjXphP3HABrc
 npzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389667; x=1751994467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkAj0AEskJHRUO2iJr99UKhDE0MC58f7E9SHfeTX+6I=;
 b=ZCY/82F60kjYUr+5PdpZTf+ZErizek8HxPI0osKqak+FQJ0l+J0bVsB7nRBu/oWHKh
 LCYzJKhII/7ibG/rQuBm/SWwBxduhuU4oMwe7eHsVC3zwmzNtzZAA7MK7BgBDHGABRg0
 Vt6nHvVxZ1x80LO/LsjixK61ta28rXOorjHyGFa3zs3LT5r/2nA6y62k4EcCsDCPVql3
 OY+F+P4xSmAtw2bEvExqkToBk6FP2BZ6Qx8IEVr3Ym9y23ojm2X56fzqMI4HGa6hnnQd
 vkUbhvFIpVdLOgSFRD3rYwalsvsGVI0r5Zm6hBPjBPTY72arplVrja+O2MWuelSqKG6B
 /q8A==
X-Gm-Message-State: AOJu0YxneOYq+fy+OJf4Q8siMj8LNQ/DRuCOjGoon+0RfHo+jvj979pH
 Rx3FY9z/HTg+FlgMm0eExl9LsBbQKYSbpGG6tffKYmlYfQHB4d6MO07w0ZkgPjM/Hu84q+sxMtC
 LrZzX
X-Gm-Gg: ASbGncuUY+dMous5tF3JXtzPtVTYWpkunLHYPb0iQMFo6rEzX9Je6DQ9GulBN9o/aoc
 +a1itIOAnU9XtgbRcGPvkEjSZ4Gw447UyT862rF9XKJdqZuzXshXQwV4PqSm2WNYYnHKRwJ5r4L
 6DAgiz4YW0fM2dGMfnuHKxRYYKMfHhAShQEm/ALJE57hNd3yWUJMxvmJuC/bt4Ac7xX8NrHLUBw
 hECBuf3iVilMk0henSiygtkFc7po8LiNHr/i/q+tgmRLbnumehNnsroV2VFgGFmsB7npIQaoa99
 y61DKAsh6kn6jj+RwThQdeHJtRpz6kRud8OlhOi4UbZqAVGIu6+iTA+TRg1HjQUedLoa
X-Google-Smtp-Source: AGHT+IGPbfqymNcerVijn9RpKuTQ8RDZFYlNcTB6zlgZxHmAMYeUJfGZOH1UsP/XZZ8suYfNTJ/8KQ==
X-Received: by 2002:a05:600c:35cc:b0:442:f4a3:a2c0 with SMTP id
 5b1f17b1804b1-454a32d595dmr1812915e9.13.1751389666867; 
 Tue, 01 Jul 2025 10:07:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/43] target/arm: Remove arm_handle_psci_call() stub
Date: Tue,  1 Jul 2025 18:07:00 +0100
Message-ID: <20250701170720.4072660-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 0c1aaa66c24 ("target/arm: wrap psci call with
tcg_enabled") the arm_handle_psci_call() call is elided
when TCG is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6216f68c94f..21a8d67eddf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -650,16 +650,12 @@ static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     return false;
 }
-static inline void arm_handle_psci_call(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
 #else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
+#endif
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
-#endif
 
 /**
  * arm_clear_exclusive: clear the exclusive monitor
-- 
2.43.0


