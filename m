Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E5E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bd-00051x-IR; Tue, 07 Jan 2025 03:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aQ-0000MG-6X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:19 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aH-0003Md-Kp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2165cb60719so225491055ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237104; x=1736841904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cxIQIIs+9zIwIQbdWH4G/YBrrJ9RyT+1RaYfaHX944=;
 b=Q/YuZf+Dxiihf+yUY4OlX6FkM9xs6ciWqgcIYPWUaFAI04Z/ObYUhzeODFqj/wuv1T
 OLkV54tMHFrBRhysB3+sAcdv7Vv9jMoHFF9ua9ueJBxridzoWGE0zgKfinQsD6xD9oGi
 tzMFQQoKQkfeJcuGAmU981aKcRfohUUR9/4h8igaDqUVleSV0cNETzNWbVXVCLnvx5rK
 GE0VlgkcGpeI3S1C2Vt98zg5uYQRAbwvEU9HdipFQur9lF2B/mFgp50GHcFqvJIVM/DM
 neUG8DsDj2vUTGtk27QrmblSWtEQNSMgxZWeyPM725Tq+ymC3c5hh9X+qY1FX0sywj91
 A1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237104; x=1736841904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cxIQIIs+9zIwIQbdWH4G/YBrrJ9RyT+1RaYfaHX944=;
 b=MWOLQmab97KORz4MLl818MK/VyK58EmIRlOCo66MZBqyPGKhOM58UNlwP2Q/I5iUEd
 Ae1m5uDJx2zCdBcAkMju+mrmxXbI4IoYn1T7YZmdeAkmt/blI2Opf2wbJE8lJSJKRbKr
 010qSNmLPCw6XI4PKBwQkDNZiqwp8PokdLIKa4BwNxGSBHhP5l/NjAikHZ5Vq7YCEUkb
 15RIoVxKeSyn3/hHvyoFdcVI2DhvzB2X/UPumwvgQfVwFfKsIGs7ZmWVUFIPhuoS4QfM
 zmy6WBXfWRyFKyMCU27qNIoTmq98aAQdqEaw5iYzEb46p0upKQDToxQBJro76+AHpjlO
 L+tw==
X-Gm-Message-State: AOJu0Yx+lsB48ITl34rw/CUr2GzyrWYXLkB51xuygApu6+UjxstmnnYh
 juMQ/Q5rKLMW24NzevTdNuy7Wd68zinJoUCf132LVT4a9K7ITvcaOOFRtTKtDoLkKzQOvCXq3Md
 0
X-Gm-Gg: ASbGnctWjIy6qEfadUDPdKf5ZaN/QeBhTQQ5COtSlJbXEJH5PLTcnPISMXEgg0cz/wW
 oCwl+/RLy12UZuE2I4IVTJUv61eB3vAj4bioGJi/42PYKCd7es+Zks99YuPaplP/tpcugE+Y5rE
 XfDgdX8TsqOS9qnKCXxzlsCoo7JBallh6wuKw3tZUHivQFce0Hj3rZScodUsDILHCVTBYSCN5S3
 7Lv/I5C/+n9/Wn+yA2yMz4phMPjunMtFun9lzgzGU6a+jvhX2kYs+wClYPGRYSNF0/mzTXCVdup
 Vb4kcEBlgILbYjwQDA==
X-Google-Smtp-Source: AGHT+IF69qYCpRX27ns5cB5e/zUA8E44Quu19KvwuZATk2Lif3/hoVt8xCGiQy5y3NJrgj0iqQwMkA==
X-Received: by 2002:a05:6a21:7747:b0:1e6:51d2:c8e3 with SMTP id
 adf61e73a8af0-1e651d2e962mr42296938637.35.1736237104154; 
 Tue, 07 Jan 2025 00:05:04 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 46/81] tcg/tci: Remove assertions for deposit and extract
Date: Tue,  7 Jan 2025 00:00:37 -0800
Message-ID: <20250107080112.1175095-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

We already have these assertions during opcode creation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.c.inc | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 88cecbd62f..8dedddce5f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -775,28 +775,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     CASE_32_64(deposit)  /* Optional (TCG_TARGET_HAS_deposit_*). */
-        {
-            TCGArg pos = args[3], len = args[4];
-            TCGArg max = opc == INDEX_op_deposit_i32 ? 32 : 64;
-
-            tcg_debug_assert(pos < max);
-            tcg_debug_assert(pos + len <= max);
-
-            tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], pos, len);
-        }
+        tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
 
     CASE_32_64(extract)  /* Optional (TCG_TARGET_HAS_extract_*). */
     CASE_32_64(sextract) /* Optional (TCG_TARGET_HAS_sextract_*). */
-        {
-            TCGArg pos = args[2], len = args[3];
-            TCGArg max = type == TCG_TYPE_I32 ? 32 : 64;
-
-            tcg_debug_assert(pos < max);
-            tcg_debug_assert(pos + len <= max);
-
-            tcg_out_op_rrbb(s, opc, args[0], args[1], pos, len);
-        }
+        tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
     CASE_32_64(brcond)
-- 
2.43.0


