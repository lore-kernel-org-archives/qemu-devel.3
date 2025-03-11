Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F809C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5et-00088t-Ma; Tue, 11 Mar 2025 15:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eT-0007af-Ao
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eR-0007dO-GK
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so28482175e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722749; x=1742327549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lR7WJngPj1SSQXgzpde1AGJdt/CkMKkAoz5QMBl3VQM=;
 b=g4twhwR0N+1fKKPAumClEosBjgMdwguooTXXel+nzcDp9+h6Gl3FFI0oMsn4ZRYKgV
 baHOxYWpWGCf5KgdNGNiIrRCHPEVzcT1H/z2mEY580ivUi4qSLxh2a5kqrmyyduzg7xm
 QpxSh5Gb9gPEvfMSqWTqNvDpob4P8ibgg0o9cVVKQHYHIT1i79x+3CAxwovq/VdQIYtI
 36GtpsMzaD6R1RQwz6qgPb05XoayZTxGzs5u/uC8mokif5Qc1dsISjKMF+EhiFIDC9w0
 8b+E8YxtXKxvM8QMHEh1M6WENQNp2ekR8h2d6KWufN96nO3JkL1mXQuqkRLo7FMUueil
 cUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722749; x=1742327549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lR7WJngPj1SSQXgzpde1AGJdt/CkMKkAoz5QMBl3VQM=;
 b=Rnia1EAvfK5KAADJ0TlbXJdsnIxXIZjKPA49CxMDYU8W9RM6PcEHPK9dDXA1FkH2EX
 SLRnY7e8vSvqK3L5LGgdqrRBFE7t9Zj40pugl06pEhfEaWTKFFY+8Snt4bjcYMkPiNJn
 v+zu6RwX9BJk6vOd0TlxRakHb1EaYbXPLWOXN4uKFB410nJeeQswvsNmxPxofK7OnIlC
 CUH3BFeq2dh2gKNZkHDVxIQs31ibeeXbjsna99wRboS4D9eI5Qbo4QOHEjnlKgvhNons
 vxqavU6tJPQmFNN3AiWRZg00HFiAN6Royrft79YZyYm+AVdlyFJNfq91s683d/DCX78I
 aGBw==
X-Gm-Message-State: AOJu0YwkwUC7pyLZ6GKrQTyyUi9mK5LDTrW1+q7OcMsLlw0o3yZKb0YT
 t49nLznCVT5li8Jm9HsrJoEx9pCsTICh6LIKWf3+Gm5PSOl3gZwEQR54hx1brbZThUvMuREoPOJ
 j5w0=
X-Gm-Gg: ASbGncvSEzt4Jye88xzlX6m0m7OXiaSQLXZGDQOkepE0itj1+jnRwbdok/eqxYbvBwK
 DHSWSH1m5/+lV4s7U5hJWVC/DEwQIkVj5oyn70JVOj1HaU61b5dkHGM2yLY9wuYty3Wwbc/NyCO
 mDpInPIOYmRP5RvOUeAq02Jx4DcYdDxTUWDA4/wK1mGr5xBZWxPzdqHA+8ZrzFAEKJRmsLEuy5O
 cbKk6Yh/lHIlb3SG7uNFmnVC5fZXYl4SAtxKo/XCJxLHNYiLmjIfS5TG37p7/LB0tSFuKjRCtaq
 3az8U2oa5D1ReErxf3Z1A5BcVHxp7L+vHc2nkLO1Lm2cxeyuSAKADhQUakEtUWR+FLt5ry/URwE
 RwQsKeHYIfJS6s0XoWB4=
X-Google-Smtp-Source: AGHT+IGxB3NcV9q5a7e0Oc2kINkwxshLmQMiyr7uqA0X85wkdig4NrS/rfAh6IsB+GlD7iR68g0ucw==
X-Received: by 2002:a05:600c:46c8:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-43cf3e4d9d7mr121925295e9.31.1741722749104; 
 Tue, 11 Mar 2025 12:52:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0113ee19sm45313475e9.33.2025.03.11.12.52.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/14] hw/hyperv/hyperv-proto: Move SYNDBG definitions from
 target/i386
Date: Tue, 11 Mar 2025 20:51:22 +0100
Message-ID: <20250311195123.94212-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Allows SYNDBG definitions to be available for common compilation units.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250307215623.524987-5-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
 target/i386/kvm/hyperv-proto.h   | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index 4a2297307b0..fffc5ce342f 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -61,6 +61,18 @@
 #define HV_MESSAGE_X64_APIC_EOI               0x80010004
 #define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
 
+/*
+ * Hyper-V Synthetic debug options MSR
+ */
+#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
+#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
+#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
+#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
+#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
+#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
+
+#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
+
 /*
  * Message flags
  */
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 464fbf09e35..a9f056f2f3e 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -151,18 +151,6 @@
 #define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT                0x400000B7
 
-/*
- * Hyper-V Synthetic debug options MSR
- */
-#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
-#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
-#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
-#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
-#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
-#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
-
-#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
-
 /*
  * Guest crash notification MSRs
  */
-- 
2.47.1


