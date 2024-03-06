Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A951C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsZx-0006fq-6n; Wed, 06 Mar 2024 09:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZo-0006bc-Pq
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZn-0004EA-8h
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:00 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so775623f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736537; x=1710341337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wx2eJ+KDhes0tXleUJeO3uNoYSnGN+NK8RX0V99627k=;
 b=bzN25o/3dQJz/IHglzntxjO2gU8qSzscQ0OiaZuzrh6/Xvc5ovZL65N1eTLFhR7Mc/
 1AIhjIoPa3o2yx8MyOxqeDViNcqanUuACJon5TgWi7KhMBY+1int7w2gP2RWAMIdKjPq
 +t7ci6OCFlgDSbunAo8mAeP67yt91Lll2Dk+0h242ZpJ2fqBbA/yZAjHqkvWne7v/f60
 EnypX7q2P7lukKhDQaQ5v+vmXP+V7jGj88VVlnRpTyuHmP9XCfdOrWuy9jsuJHOZC3Pm
 U2FWBGWZ+Cp5dwhwTCsH4E+qtA42lI/8pGFl9fyx0yYE3pd5gjhaFLJNaGYCOjZD4OOm
 9iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736537; x=1710341337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wx2eJ+KDhes0tXleUJeO3uNoYSnGN+NK8RX0V99627k=;
 b=sLIgfQYjTPZi1bhHDCPmnzc1Dqd6LLMgZFhpTE8grwrtGAP6WGQ7n01uJ021f3sLGC
 1kXnsnPndMgJYX2N1qr8b80ExmaiEJ2vYU4CigqqeReAZc70vVn9HgeAXK0ZW6GIVgsD
 Tz8XYq1nMcCstY6FeBlrVx+RYuLl1h/tRv3aLAHfk07B6k/CCPxFutnTdE2GY2oZvsSl
 /E0dd9CeG4a2Od6ENaYdacgE94CNdqvzGlSXUgS9rwadCtJY6kvt16McLFQWqLOA4trx
 6pNh8OlIGjxZQFtK1cOgDsh8Tanx/5ovglBwUjBfGqGxwGJ/1JF74upEP9maJIoQ67n1
 y9Ow==
X-Gm-Message-State: AOJu0YxHAkFacspS2AD5spZ2y5P/t6wxy1tPJ70KE4gtSGlrmKseLm3Z
 M/ysg5BTqemMcl4DaNj0AqtBTr9XELgYMjZ5L/l/eEaNSAvx+n5Qdzl9WOpEqMg=
X-Google-Smtp-Source: AGHT+IFTVngPAPsw1J8AaQ/GYWiUnrS87kLbRDO3qq/CDznmNsQ2muUiwI7c2gJZTpdy0BY54MsRqw==
X-Received: by 2002:a5d:6145:0:b0:33e:187e:a5b1 with SMTP id
 y5-20020a5d6145000000b0033e187ea5b1mr10359305wrt.37.1709736537725; 
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bp16-20020a5d5a90000000b0033e0567e90bsm18436009wrb.5.2024.03.06.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2609A5F9FB;
 Wed,  6 Mar 2024 14:40:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG target)
Subject: [PULL 29/29] target/riscv: honour show_opcodes when disassembling
Date: Wed,  6 Mar 2024 14:40:41 +0000
Message-Id: <20240306144041.3787188-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This makes the output suitable when used for plugins.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-30-alex.bennee@linaro.org>

diff --git a/disas/riscv.c b/disas/riscv.c
index 8a546d5ea53..e236c8b5b7c 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5192,19 +5192,21 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
     }
 
-    switch (len) {
-    case 2:
-        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
-        break;
-    case 4:
-        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
-        break;
-    case 6:
-        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
-        break;
-    default:
-        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
-        break;
+    if (info->show_opcodes) {
+        switch (len) {
+        case 2:
+            (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
+            break;
+        case 4:
+            (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
+            break;
+        case 6:
+            (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
+            break;
+        default:
+            (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
+            break;
+        }
     }
 
     disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
-- 
2.39.2


