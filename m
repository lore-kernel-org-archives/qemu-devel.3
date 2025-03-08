Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A92DC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqoXZ-0001OR-0q; Sat, 08 Mar 2025 02:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXR-0001NG-QT
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:24:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXP-0008KS-92
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:24:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso14885665e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 23:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741418637; x=1742023437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7kazZRyRImLPrA4ARMvw47fAUrwdo+TcmyR6boI+Q8=;
 b=uGKueCZaxDwRKB0zxm5T4tZqz/88qQOd3UvIxlwNI+rvGiJxX5k9artcXUz0vrcZBf
 aT+4Z56fm6FhgvgThxo9ARCSQ8AKRuZSNufROqjZkCYHvdQkWan/XTSs/raqkcPMCepC
 mLpB2boeolp8VYqf/72oCwAuuhVqMspdXP+VZDVVJsYzN1a7fgHGWsZerrSRsjffurnq
 3rs6nG8sb26oGBzNJ5Vkgxb3Znf+bHFhbenoDJBQQV0lrBIdb6OrjTW8pyUxvWCt72Rt
 vDExfkQUCQSK4YMZQIr64RFVP7YXjJbWQ7oqBBZ/kD5ztNblfXnGgIBIHgRJS7yeU0Ao
 ETIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741418637; x=1742023437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7kazZRyRImLPrA4ARMvw47fAUrwdo+TcmyR6boI+Q8=;
 b=wr383qkQST/J7BlxXkkGPYEull8W1pRpqvlYjZFPVpxgOemltfvwIgUUN4J3induLy
 cseBV5v132e7+6yyUKj03p/INf/vskeSxQ9zm7s6i9Z76mObcUOj3qmh6sBybkJ+Gg4j
 JPMfq+wsE1RbD2TIJrqVdZ45ukPf1woIu0FI1ckGIwkEVCRBgOuJv2eShATaOwn9FhM6
 ykNa09aIJKqqvwKif+AG8z0sHsS4KLz+6Avwe3znkfjWw4nz2C77xkmBYX+mFWeImSwn
 Bk7/gYTFt/AI54JBUS0+9hMcJt7eaZHLBdK/4rh8XmMHlMU6xk9acQoXLPqmb+/kS3Bo
 wbUQ==
X-Gm-Message-State: AOJu0YxMIYbL50Wlrpj3Q0ARu9upAyssMaEGPupYtfvVUV1zVRClS3u+
 fpQC8YHAwwWMbHcJI5DkxBiZVZdYSI3ymHqeh30ynkuYym2jk92Uh111AlJ5QPfFuy19T71qgoI
 +jmY=
X-Gm-Gg: ASbGnctJP5g58PpBocojIWc02E4qxY7oOB5/AqVNqROTQCrxUDkC5vjQSe2DnT78D+M
 TICzKtqsVq4dIIwnBBPjrxhaSEghq8T9IVX3ve7orB6r6/kGEHxi1RDu/f5pkNjFoF8Yptee9f7
 o/G7yThBgArrMILG7/H2yTBuQsKtrEbTQR38Su8dZvFlk5zhgywV7MFHPboP+n3aR+TWh7if4ui
 HPcIQPXPep34t96e1v9neVWATD/oGBNb9PFwIYNIlOkeG2DY5ouhkPAnxQV25v85XQuDC5CB+a0
 X9swD62/klZPeTlWAmxpnFDb1vHRs6xj27QOwymyM4SQMZsljCqY6jfnA9bU/O8ykXvdJo/jNzO
 rOQaz4t4bT7j+PJ8QPCdLVPfWGiZ76Q==
X-Google-Smtp-Source: AGHT+IG6lu1F4MrwjLyrEw+hb8DV/uF+PitaOMr+pF3KBvKdBH8qbamgRnpWd6nB2TsCcatYjG6Siw==
X-Received: by 2002:a05:6000:1789:b0:391:1f9:c59a with SMTP id
 ffacd0b85a97d-39132dd94dcmr4239025f8f.46.1741418637238; 
 Fri, 07 Mar 2025 23:23:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352ed7sm104826185e9.26.2025.03.07.23.23.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 23:23:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 15/18] accel/tcg: Restrict GETPC_ADJ() to 'tb-internal.h'
Date: Sat,  8 Mar 2025 08:23:46 +0100
Message-ID: <20250308072348.65723-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308072348.65723-1-philmd@linaro.org>
References: <20250308072348.65723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

GETPC_ADJ() is only used within accel/tcg/, no need to
expose it to all the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-internal.h | 11 +++++++++++
 include/exec/exec-all.h |  9 ---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 62a59a5307e..68aa8d17f41 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -13,6 +13,17 @@
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 
+/*
+ * The true return address will often point to a host insn that is part of
+ * the next translated guest insn.  Adjust the address backward to point to
+ * the middle of the call insn.  Subtracting one would do the job except for
+ * several compressed mode architectures (arm, mips) which set the low bit
+ * to indicate the compressed mode; subtracting two works around that.  It
+ * is also the case that there are no host isas that contain a call insn
+ * smaller than 4 bytes, so we don't worry about special-casing this.
+ */
+#define GETPC_ADJ   2
+
 #ifdef CONFIG_SOFTMMU
 
 #define CPU_TLB_DYN_MIN_BITS 6
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a758b7a8438..2ac98e56c41 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -186,15 +186,6 @@ extern __thread uintptr_t tci_tb_ptr;
     ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
 #endif
 
-/* The true return address will often point to a host insn that is part of
-   the next translated guest insn.  Adjust the address backward to point to
-   the middle of the call insn.  Subtracting one would do the job except for
-   several compressed mode architectures (arm, mips) which set the low bit
-   to indicate the compressed mode; subtracting two works around that.  It
-   is also the case that there are no host isas that contain a call insn
-   smaller than 4 bytes, so we don't worry about special-casing this.  */
-#define GETPC_ADJ   2
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
-- 
2.47.1


