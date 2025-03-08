Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA86DC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39e-0005oC-25; Sat, 08 Mar 2025 18:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Z-0004cj-At
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38X-0005NP-27
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:19 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso55290645ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474755; x=1742079555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLDUWdvnnBB356eedHeiVggZlsL+ljood1zAHBJkFew=;
 b=Rm3+vDtt63gVMmcgLcp6g1ngRsh2cyRRnHulV8Y0JmlD9prC8hYyELdDCtASrmvdxK
 2XSHG3DFRbTWVmgHEz727aaSdVpa9lYPLtkIkz1ByQR/it/xUfjuO2j6jOaflVD9yHyv
 eA3wPk99o6hrtfzrz0MB40B9c7jfstgO7Sb3wiOE83ba3nLqr78A/dUi7K+a/wAiu0mB
 AFKvRhQXdhRJfWN0MnoivWCvVv7VSQ61+730UIV/JOtM8l/iq05a1RkcNAjW0DxdVLiN
 9adH5Wp/rzcEBAuCTufqB575KQxr1sjghZz1Dm6y3UO+gnvUI2tfFmN5UdXB3Y+M3H0b
 f7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474755; x=1742079555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLDUWdvnnBB356eedHeiVggZlsL+ljood1zAHBJkFew=;
 b=Sx9aOt4YmiWxmyD1mhfsLdnkHqZtxw9a/tS3UFRuKyuAGlJjZb2UeGjoXdhCik/RgF
 PZjv7BedGn6WWL9UIERdGbzfLHJkH4uUATFTlcgLApTlPC4jWVxjuN1aOmqPGcTRVQoU
 9UHh0rzMnDLlsTb8AlMh/IMIPXN2untDIC93LXzHmvTsSY0IOyPgdm10TEpQXTrwUyW7
 Wn3Y6NYqRKpifqe5BTMzXvrgEPQlA0nJfUJMSt7hr3GBjZbtHz5IlYBBUsNDXKTkQ4g7
 M/xHxxtBEC4LxIj80EGOphBeXuvgKpJKF3YFxAjkdv6DYgTUPtmJrnRDza1JvkI5wQ0c
 C/JA==
X-Gm-Message-State: AOJu0Yy03mifMBc3cEMbduMp7MiURWAGs/Ouhjq6YftusmplMSIRGo4h
 jN0Y3kPqOiIVogjvKmsV6Vtzph8u1RmuWZbyUGEmlfiDDT5rcVbk1vYw4nv01fKXqEs8mCTJxUD
 Q
X-Gm-Gg: ASbGnctffzElIjVPDq143b8NLxtUQU0tmaS+2ZpOiSHu2argmdw7e41aWz66ufYnkPM
 EWDQhpkCKJ/GpBg7svQKLcUd+S19EvUow9etaoydgg38qvOTzYSOGglC+Un9STrrc3igrVGjjRG
 K1+/rI60amXNV2eHc9otw6aubzTndp6qlh3F4KfMkgnOo0lTS+ZYopbhv/vY36NER4xMocLSn4F
 eD8DBsqYztEKVTDtS3o1MngomC8BXWSOj1ubE0t6nZXsOzHL0370uL6na3xKjLHeGeZhkKk0GG1
 zhnEUo5c2zFcdt0ndCFPbT0jn8y/DWMPoXk0nJCHCW4SMlM/qtusxah5NybnePcDuM2drmmFtTV
 9
X-Google-Smtp-Source: AGHT+IHaQPXRYsw+ROqemtdEfbQtJ4SegmYcx6iDbcgH/6HAsUb4SKfHxpYSO2jDqICeqJJWkbDdnw==
X-Received: by 2002:a17:902:ccc5:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-224288971fcmr144299935ad.21.1741474755261; 
 Sat, 08 Mar 2025 14:59:15 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/23] accel/tcg: Restrict GETPC_ADJ to 'tb-internal.h'
Date: Sat,  8 Mar 2025 14:58:56 -0800
Message-ID: <20250308225902.1208237-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

GETPC_ADJ is only used within accel/tcg/, no need to
expose it to all the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250308072348.65723-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 11 +++++++++++
 include/exec/exec-all.h |  9 ---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 62a59a5307..68aa8d17f4 100644
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
index a758b7a843..2ac98e56c4 100644
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
2.43.0


