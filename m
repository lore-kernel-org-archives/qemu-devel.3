Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E038DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwJw-0008F8-Bn; Tue, 26 Aug 2025 12:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIn-0005gN-NX; Tue, 26 Aug 2025 12:13:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwIk-00089M-Hk; Tue, 26 Aug 2025 12:13:41 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b475dfb4f42so3988355a12.0; 
 Tue, 26 Aug 2025 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224815; x=1756829615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztIhxTK30jqaWUf0PzyD81CT7DKpl8JVd9KnfePGnW8=;
 b=SDwgBQXyihjim6v/L4SsXGDBrrRxKI0+gfDbYCAKrOqdtPAYtQrYj+qqXDzSHx0VJN
 xhvxkcllzyByMm+Fkmt/i8+4EdMhYjA753seUb9U65L5ciBmvDt881tRPoqOx36nxfZL
 d/dKBrHkzkO19FunC1YGrs9TpvasmiBZdPVaN/6A0pkz42lurlgWQAhiR5Zm6jtK7C6z
 G6LQZS9LpbgoemZbHveNHNqUIlWnhH3Rs23TTOOls+yUlF5LMS58gVl9+mwn/DYGAreG
 9oCCxGsvk6Vu8uC70rjS5RWSjXOo5nTy+EthDMT5Y4QkOyIKukhYI5iUfhTHazcUn+dw
 LKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224815; x=1756829615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztIhxTK30jqaWUf0PzyD81CT7DKpl8JVd9KnfePGnW8=;
 b=r+N3tdBMsBmOxW/nbyGd/xCAWvTzOlu6FZBAIK7SisXhzMY9HT8C8sALOt/wAzoyJ6
 MFzC72hXYDw0UIJM5bXiV0hdpXRC8pedDpJL8uPfKaKII+wb+FvBqMJki6S0x8/U4Qp+
 2tqFDrruF3h272ydcKRzd29WfqFTJtPr8N8ioPyh3YbBhSOZFHKZyJM+rDZZFJRAliPm
 jwQb0CxGX8WxQalTn0PfrtFJAjt2M3a/FHgVzf88/afsocbrpU4Nvfnav7ByRZXshoGv
 VwHD4hR2dtpmcYeDVJyP1v6+/Ttjgw9HIUyhVGKkWp17uxrTKN68GchWmJPOLxkvtQxy
 EhEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8sV4Zp3TYsd9Q2Tb5Z9KoeWpKdJUWWfma2RGmalzoo7a/JiP0Pf4tBE3Ki1D4KS+GljbzNRqZMA==@nongnu.org,
 AJvYcCWxqr8VjsrcwX/0szCgunEkQIMtQX2Qj/OQfrAbHnXLi8unY9mKZxXPkyeJrE3BlRTxDqbV9shcYTtAvQ==@nongnu.org
X-Gm-Message-State: AOJu0Yy/rmSDZMP+weatkYgzyffm/SsJsM7m9rGQbMxrp/WgUCMuzB2B
 rDCOLFWRaDj5gNTbFLAYgpNJ+rUNBXPQlxQAV7hk8SjxxOT7aUyR2KGrgfxwBQ==
X-Gm-Gg: ASbGncs6cspGzXMOa3OjUCyKre4z9fP6VljH9oLZ7QX2RnJ8k7MTn7aSOsLV1FtDbrZ
 XO0Nc3W926n04WMN5iogFlUSA9NBo20y/xuBgd7qrKSW6Doha/0BFmYu2BFnjLnvzX8o9naXk0R
 CuumbMlpdpahXe5FdcLMe/fGIQIeVsRhXD9+kpDeOsGlPcav9HCk8pFmRNRTwbpweWlTIH1mkdh
 nE7qQhIowhnB9QfcXRlcdFavKEuyIExqf6+Bnxpp4piP4YCcSXYtS3/UKUWDTpzG8/ae+DBO61l
 O1bnxovZK7MQ5bhVJBtZnXnhnNAS1EsLHkuWsV9pzGjBNU47/GBcmCF3ZDJXx72HNrDw2+r5VUq
 7hO7TT8jU85KtSbM9SuT5/Q==
X-Google-Smtp-Source: AGHT+IHb0u8U5NuTT+w+uO8pDlDh7WG/BO17hLSDo0IQiOeg+cxO8ms2iRt3PZrT/44dP313eeFvLg==
X-Received: by 2002:a17:90b:38cf:b0:325:42f8:d734 with SMTP id
 98e67ed59e1d1-32542f8d92amr15054834a91.22.1756224815162; 
 Tue, 26 Aug 2025 09:13:35 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:13:34 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 25/35] tcg/wasm: Mark unimplemented instructions
Date: Wed, 27 Aug 2025 01:10:30 +0900
Message-ID: <a3656a34217da7ac63ecdab31370b35b70b3ac94.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x536.google.com
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

This commit adds the C_NotImplemented constraint and provides stubs for the
functions that aren't implemented in the Wasm backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm/tcg-target.c.inc | 119 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

V2:
- Added C_NotImplemented constraints and stubs of removed instructions.

diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index 1d639561db..598db7b4bd 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -1950,6 +1950,125 @@ static void tcg_out_mb(TCGContext *s, unsigned a0)
     tcg_wasm_out8(s, 0x00);
 }
 
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpExtract2 outop_extract2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpMul2 outop_mulu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
+{
+    return false;
+}
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    g_assert_not_reached();
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
-- 
2.43.0


