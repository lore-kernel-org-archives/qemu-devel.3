Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36576C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMU0-0001hB-5j; Tue, 20 May 2025 08:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTb-0001H4-M3; Tue, 20 May 2025 08:53:47 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMTZ-0000sX-AC; Tue, 20 May 2025 08:53:47 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30e9e81d517so2784234a91.1; 
 Tue, 20 May 2025 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745621; x=1748350421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muYREexfGkNao6CbCGkvnw0ziWfWGPqgkjYPqsUlkEQ=;
 b=UDxU7e+I1vZRXuNAr33LF4zFGlilhPfvmyGUMHSS6FYVVSlvMAqGld8B+WzV0p/5FS
 RCNXq8MuDghmvX2sf/PrW03xBWTrr29aNvCkogw2KedhnWtglKVBI6L8u/vB+ABx7BWi
 RqJduN+H0E2n2adUw7wkOoEVJRWbcdvVNd24SRPlseB6IApv+YwTTGV4I/nw4nQXoFDh
 fWP2N4TTcNDLp9aQnOID2C2E1dfxbUkvnYPhJKOZD67lgsNchwfi6JyTb4qHwY/E2sAp
 OWIojBNhVm7mO0MKDkBIsAQ/l3mSg+MEoxdZd+IBq0a72dVcMJoYDcsRxZQ7/GNgnc83
 knUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745621; x=1748350421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muYREexfGkNao6CbCGkvnw0ziWfWGPqgkjYPqsUlkEQ=;
 b=H7AKup+/iEB3bMOqmM0TxhsKIFnh2dql0FLlGyZdlbXD9sDyL7dk/fB3kFwiDHQqM8
 jTsK2FhamWt0ntlFyHq7DQWvN0RtfNd3T/rnP2qlGzg0z/TmnrAuC7TAFJd6quh7REgh
 +9xL+4kbQfPM/4VgIKgFCrLV9NyR01MAdO+iZYaqiA8X5uewrJcJ+ARh7Ct33AWLobVE
 dKMsWCNXRt+rfYSvP1+7hqfxQlC43+nkNnwW6EFoyqeVvr+8Uwn7rQ37fuPX6fYP5KOS
 acSSjTx5aclb+bRGAjA1YnZ8xq/swvWNZPwtZIVSdG12hbdHes/yHcE1VjBgqq2pLiS0
 0E0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW80hthT4n8dbGJ3/JnxQKGE/kcTLWcfZfk6fJl09j1Nlp4XbOcjT96pd4FDxE22SDWQThSkRPd4g5g8g==@nongnu.org,
 AJvYcCXf4+8y+L8+OVpndmPB5BAP44AlQTBws+vsmCg4WnXcuGM8SbLhkEvo6k7a1ugg+m8WMd6ElYrMPQ==@nongnu.org
X-Gm-Message-State: AOJu0YzLFKP1dNIhc+hX4uqE2l1ij4xRAG+vTRF6Qg5qVHVP66KkAbSF
 7fXX/0QeaP3OWFBcyrg0oZzWCFQvaNEknX6IfEC5DjsgQbmIyXu4B5fzvEr9XgAb
X-Gm-Gg: ASbGnctwGNXOqKXu/dw6ftu60/VJRdsW9njtYtP5qBtNh9gz57qmEmPZ3Djbk+lZPcM
 DW8TDzWg/DKOcuqECCzqyKJLDYn6Ot5xccNlkvrgvMbc6AWjkst9TuN6OhFLS+tIBzpxzdR0vDv
 gISn4cAJbIE2eN7VZXIcU9dhDTlUuCuksM1xjxYL7GNcupaalFAVb3eVhCOmoaH/kMa6uL1IH75
 WTrgcwL5FhGWiluA7Ps9DNh3darkRFazvvg8LtPBwffW7uONmuvkiOWAJ71AOI4fwyYKe2G6rK0
 HJDylzWo2eurG/PRSAvdbOWlU/ydmq6iq6BEEtrvXC3BGu6yJVA=
X-Google-Smtp-Source: AGHT+IG0tzA7tiR6O7xDX+cIgsbg7F1YbaiTFl+UQp9GDGzuq1KjR9A3Fqt0K9BadY1lb0SPFB22fA==
X-Received: by 2002:a17:90b:51cb:b0:2fe:84d6:cdf9 with SMTP id
 98e67ed59e1d1-30e7d5ac8abmr21767013a91.26.1747745620806; 
 Tue, 20 May 2025 05:53:40 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:40 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 15/33] tcg/wasm32: Add andc/orc/eqv/nand/nor instructions
Date: Tue, 20 May 2025 21:51:17 +0900
Message-ID: <711394a374ef6df21e8759a1768ab542a787353a.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit implements andc, orc, eqv, nand and nor operations using Wasm
instructions.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm32/tcg-target.c.inc | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tcg/wasm32/tcg-target.c.inc b/tcg/wasm32/tcg-target.c.inc
index 66d3977d31..50d772f3d6 100644
--- a/tcg/wasm32/tcg-target.c.inc
+++ b/tcg/wasm32/tcg-target.c.inc
@@ -520,6 +520,56 @@ static void tcg_wasm_out_op_not(TCGContext *s)
     tcg_wasm_out_op_i64_xor(s);
 }
 
+static void tcg_wasm_out_andc(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_orc(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_i64_or(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_eqv(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_xor(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_nand(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_and(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
+static void tcg_wasm_out_nor(
+    TCGContext *s, TCGReg ret, TCGReg arg1, TCGReg arg2)
+{
+    tcg_wasm_out_op_global_get_r(s, arg1);
+    tcg_wasm_out_op_global_get_r(s, arg2);
+    tcg_wasm_out_op_i64_or(s);
+    tcg_wasm_out_op_not(s);
+    tcg_wasm_out_op_global_set_r(s, ret);
+}
+
 static void tcg_wasm_out_shl(TCGContext *s, TCGReg ret,
                              TCGReg arg1, TCGReg arg2)
 {
@@ -1618,6 +1668,7 @@ static void tgen_andc(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_andc, a0, a1, a2);
+    tcg_wasm_out_andc(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_andc = {
@@ -1707,6 +1758,7 @@ static void tgen_eqv(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_eqv, a0, a1, a2);
+    tcg_wasm_out_eqv(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_eqv = {
@@ -1788,6 +1840,7 @@ static void tgen_nand(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
+    tcg_wasm_out_nand(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nand = {
@@ -1799,6 +1852,7 @@ static void tgen_nor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_nor, a0, a1, a2);
+    tcg_wasm_out_nor(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_nor = {
@@ -1822,6 +1876,7 @@ static void tgen_orc(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out_op_rrr(s, INDEX_op_orc, a0, a1, a2);
+    tcg_wasm_out_orc(s, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_orc = {
-- 
2.43.0


