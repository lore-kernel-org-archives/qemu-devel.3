Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89619E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xi-0001Cv-Er; Tue, 07 Jan 2025 03:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wn-0000Dk-1V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:30 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wl-0002u7-AO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:28 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2165448243fso22815735ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236885; x=1736841685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSkAiGreHx4Ryy+vrW4QMYxirpKhMWpXD+qfj535RZo=;
 b=wmHuVf8YCag+Ea53E1OMvAsoMLPEcH5V6Hemwx/yZfmXkZ+IhcacDvl7OWYP+/G0WB
 J8IC9G5G2KraYPzNW6MLV3v0TrPadtSqeBdEVjzzx+EQv2q4KZ8k/YIBuxMBl6dFNsCb
 ODv4QsmiNZwZ+eqkKIXaTFnuWkRxUynVZWBIQJrhCySOvL57H29HSrTrfTKrB0/Nx1uG
 dv85Qvc6MoC5uacif7tsellX6CRM2dNDFiDtuRvfHgrGasrmJF0GnJXiy5STM+OWN6eV
 eBeftWq8faNjb294zHqj11Gh3bT7/S3FOAVnllEYWgBcbvh6bKV0zB1noBKhBlne4FAX
 xIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236885; x=1736841685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSkAiGreHx4Ryy+vrW4QMYxirpKhMWpXD+qfj535RZo=;
 b=vZaWBthAZpOKLHwDQlxF5iQ1TMK/11tBGQTQ9bWM0gM4EUPILWalGL61hN2XZGATt/
 Y7B+iUsd6EP9C99ul14U/J6kkg5ba0fVexpIX/Q0lv6Irvbf1VokLlyC+2q2U3lEtiCj
 Fc6m9J2LhGIARDsd6rmV/FSBZPM/oN+MtM1yzIifwFFXno9TQuiXW7IdKnV9ikEIW8ZJ
 Q9yERF0YqvV0o+Fqcl8O1l8p8Zqo967O6/NyTEUxddIMeYtXPmodvi/bvXQuu1fnXQ4s
 fS31xiyljcA6kc61WnBYSbsN7YcmiTIlH+6ChutlbcIAeWgtyf6T1BUrIrzmiQuMWkis
 tdYw==
X-Gm-Message-State: AOJu0YzMxlnqK2ZKG/TAMmYQHtkvp9mvTNjmM1NE0IlmP4xggS/sY4to
 HsPkyjfWf/t3zFlkjQZme4ORqwLfykgR4I/JfT/OOhsQaT+pb9YOHwtO9BtD7Pb/eudB3CANObp
 1
X-Gm-Gg: ASbGncsf0AuniFSLwRQA3JNKpqn4QIjPm9xqvBgsP3k1wnO4i1BronCHoFs7PrAdFk+
 CtwhhtHfpw73I3V3aTHeFeuGKHbyAmr2RsYnsPZzfCDaWgzUn5a9C1wVgYZ1Xs2YjZbq97f6R4P
 OBT2K8TMl5kOtJn9njavHrnWhnemkzJcGB6eFqnRiIEmrJ2YfsTpE/+Zg5nqCEi5DvpXE4llhcA
 azYihppTWRAbeF8dzVr/V4c6pyG2s3MHgm3dr4LfnyUUgY2f9PWGWQvA4QGoAXVgql1nEoNb1v6
 BduBeW4Bpm/gpqEE1g==
X-Google-Smtp-Source: AGHT+IG+Vx1VNopDE2UDi+5UoXMA4y+KsUFw3sark7C5j2+BNkpALPpo6B32s0XKJ9D+dnDjflV+QQ==
X-Received: by 2002:a17:902:d2ca:b0:216:393b:23e9 with SMTP id
 d9443c01a7336-219e6ea1b9fmr679661745ad.20.1736236885228; 
 Tue, 07 Jan 2025 00:01:25 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 10/81] tcg: Add tcg_op_deposit_valid
Date: Tue,  7 Jan 2025 00:00:01 -0800
Message-ID: <20250107080112.1175095-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  6 ++++++
 tcg/tcg.c         | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0fc9a94007..3a80dc2053 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -840,6 +840,12 @@ typedef struct TCGTargetOpDef {
  * on which we are currently executing.
  */
 bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags);
+/*
+ * tcg_op_deposit_valid:
+ * Query if a deposit into (ofs, len) is supported for @type by
+ * the host on which we are currently executing.
+ */
+bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len);
 
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43293ca255..6b318873ca 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2238,6 +2238,27 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     }
 }
 
+bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    tcg_debug_assert(len > 0);
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(ofs < 32);
+        tcg_debug_assert(len <= 32);
+        tcg_debug_assert(ofs + len <= 32);
+        return TCG_TARGET_HAS_deposit_i32 &&
+               TCG_TARGET_deposit_i32_valid(ofs, len);
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ofs < 64);
+        tcg_debug_assert(len <= 64);
+        tcg_debug_assert(ofs + len <= 64);
+        return TCG_TARGET_HAS_deposit_i64 &&
+               TCG_TARGET_deposit_i64_valid(ofs, len);
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
 static void tcg_gen_callN(void *func, TCGHelperInfo *info,
-- 
2.43.0


