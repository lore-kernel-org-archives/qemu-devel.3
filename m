Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FECC5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbc-0005gw-Oo; Mon, 24 Aug 2026 01:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbC-0004xc-Ra
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNb9-0002wQ-Ot
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso42953385ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550713; x=1788155513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2F4kXj+XlomzI5ywD3BSgCQbVAV2xTdDpSTO+oa8Tk=;
 b=qn4oWTALeop4eARopPQziG62FbtppHV0eSXm0rrFOACj/gLGiPFd+1phCEO3HNWSNm
 kKMYlMfhJjCXSR86IXVUwuSbLOhVenc93weqUWGR899XGDlGfus2RKSLS9texUEe0ui8
 yetUe5ChtCKbwFWfBSTNFjvVMq8ojFFr0XJtFYOCdFksbsnkY8t6iCcXdrcCtp02U5FK
 HSTKlGM6YkeFXt4ft237Xo7lvgEsEq9vOX3EGdIc5bI1GkRX1TgRbKLctRo9jMFZx5KC
 dTmBFTUraQLen4moc3HGv1VBR9vscepVX0IOHTNZCZKSLVWWBBfvf2M/b8ZP7m2IAlvk
 8y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550713; x=1788155513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b2F4kXj+XlomzI5ywD3BSgCQbVAV2xTdDpSTO+oa8Tk=;
 b=BlsWz79kYgCE+bTrYDqtRT9agOBPeqZLIT3YZnzOC5Bg4c14UfIZ7i1uwFbq8Z8c7c
 mPAV850h0yy++Gxb3owm3f44iKgN99gC+cp1XvowShxho9H4Bhl+CGCumnQFfNgxk/rU
 5D5F5casaJ/n9DNLgtvYyJya3zPUkbf6Yu/fV+DBjbJCRNmPlRD+ARQwIe4koQchPw4o
 /SKyp6dhuo/7YDLuuSj88izZACovcbmzB9qcy3M7LdjmVv9bW/5QrPHk1uPz0R8VyX0D
 StPcJ+TYFHU+E2SUV6cHithXklEfeA2ZKzWHlEGg+5W15k2VZcw3aBSGc0yER6guAF1e
 atLg==
X-Gm-Message-State: AFuF++lGH9NcQ3DPmEO5ZSXSw2w5fspC0aLBnCXEUcycyuagif8uXyJR
 shW+FDgQpVnLI5kpCSOAM8rmGw1TnYNpNW8zcC1ddAXwtGYy15JC7NOfgyl2lw==
X-Gm-Gg: AR+sD13GxHmcQrMYzwO1TQ8bHwi6BkAZKs/pNp+XyUMfKy6T521WxMrhcVI56hI+2uN
 ohNmjl46EdtWD/DjyQeVtTqUrPGi2xRj0hJiEI0dyDi3LYQwGyp24c9NV8oWkzYx3ej0v0KFslJ
 eHtuWQaAWkGXfeMNCGaeuyJBNhIF8NTtxPnQJeMgi78VXblve7+d8nH5U199d7AvQhl+7r84rys
 /NoWg3U0Gkw2/BFrjtS/dokU+Lh0oPfExvwEFZin88vRgu+G2hkLS6tmz6D2aI3H0N0MpJQNmaZ
 r/jJhRfgEZqxlZjLxjkDDYoKwApZ0LXI5Xb8q9Gv4sA4QpPn+jPG2p9NoRraIv0nuxZxwEiol7S
 OFd9oHSBlkhlmhaTn6nTnppFPtAMwzOtMTx0uYxOnPhiDsmJpHTc46kG+zGQIkxenb+0H4MyLPo
 UNeIFUSk4LBbxjWqkiYSSHjrZb6eGrMTMDxudqNOZ0l6sCsU40rHQ2/BRHf3dQMt/RE+SGskW/L
 ojtTMykpjSpwZ7u
X-Received: by 2002:a17:90b:3e8d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-395c4fa444bmr14527042a91.5.1787550712677; 
 Sun, 23 Aug 2026 22:51:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 71/96] disas/riscv: Fix rv32 encoding of zext.h
Date: Mon, 24 Aug 2026 15:47:41 +1000
Message-ID: <20260824054806.2790041-72-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

For rv64, pack with rs2 = 0 does not encode zext.h.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-39-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e650ad7688..5624e7f60a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3506,9 +3506,10 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 14: op = rv_op_rem; break;
             case 15: op = rv_op_remu; break;
             case 36:
-                switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_zext_h; break;
-                default: op = rv_op_pack; break;
+                if (isa == rv32 && !((inst >> 20) & 0b11111)) {
+                    op = rv_op_zext_h;
+                } else {
+                    op = rv_op_pack;
                 }
                 break;
             case 39: op = rv_op_packh; break;
-- 
2.54.0


