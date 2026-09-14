Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97509C88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFW-00035G-H1; Sun, 13 Sep 2026 20:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFN-00033H-0M
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:33 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFL-0006tL-Fw
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:32 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc149372c14so1674291a12.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344510; x=1789949310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NISPAeUPvsgRNajDvmHaQc1XWEGMuFuhN2VPCZGR4LA=;
 b=ONS+qabT40qrkH+G6kZ3yZVYXtkpU/yJw335nLAMuO2ctWPS2xiZ7DNSxDfepNqiy8
 BJmmtqjC9+fxiR0Cks8nmCqKPxzeEKMrDfr44aKaq8tRyHsI6zs+ZjEVCgY/k3nHJR25
 eojrkrqP2yi4Xet675zhRhuZVt8Xs1YiNe5hejNfe723fYazn6a/gbF0dUcuh1RokMXk
 yTubqYsTz5Wf/9DS2AnLARAVeur9cDvqbRSb72WNX7uhq0Kg7qKPETc0zApqqO3CNV4t
 bVtzSZ1GLpEE7LxBTqZBHvn4o1kbYNBzCxh0/gqlSwx8rmZBMHr6pHFr4QMIbV/D2Qka
 eV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344510; x=1789949310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NISPAeUPvsgRNajDvmHaQc1XWEGMuFuhN2VPCZGR4LA=;
 b=NSmptWjZIERDcTvg/qyS2u7kndRyY3E85urC70Sc41I4GK7AHLUNMUqEhQ7qY7dslZ
 KL22VYZ+yuIiJXfAwTQykLFdLSHTpP7VALhlGEd4B+W2c1BKe0uS5buqG61lyLqktnKw
 J4Bc67CiyO7WWjPtwrFFWKncD5JmvYXh6IHJEBxYe5iHTn8qpM7zcOa6lwsXu4Ol79ZS
 tvOQQZJSTJUsV/BcGEeF/GGSDNSVWL+nbw1uBOOS/r+qp227x7An0kkL/VGYYXO87qE9
 dywOOpgdUqKM5XeR5JnQbBwdbO+Q/sKQvsPxu4JXdsCKbGeXk2lXEJhNV1ptoRKmjFal
 XiUg==
X-Gm-Message-State: AFuF++kV8V4e5+chZ4jnUcGiAH6AIVEnlGA26i/RzGmTQXnayrAGywWb
 P5nUEYzuvUEjjAbB9i/4UhqGSA2LoqE8+9kjPelaTKRZE5PDEkPjatcbw7F89nUJY9A6ZKkIEss
 XKwbA83o=
X-Gm-Gg: AYBFou29mRbZQp0S0rAWDj+KfzocK0W0efqOpkIXZY33nQRmZqw6BQh2qxBKLrFTocJ
 zHuAsf1BBSmIRbysPzo9pxRV4AcN6rhGVYhD/noPAzRDRzQ55CU3MiaxUYI4tSitx/+CgG5TPJW
 QIk1hWjQ7QcZDoCkiVvO1+gNMOXZf28JhPY/0uuIANkdub6szKZZCFT2EANOPkQ4SJBeY4bNHy2
 YTAJkv2PUs/b1xzdkReKCoHrRYgUr0W1azOBKoJNp9ljpzKyOKbmL6yHH6UF+K3B+WID5yHhTw0
 Xbq3z4oTDZ5IlKh5MmKIpgc3x6JHRjf+tLWB8QtxgnUU2/rfB7IBwBZuJ6XtFNmTIwpL2oiDUx6
 +M9zN7PS07Vjaodbl3/ISoalGZzR9siNsDSdiDnGl3AYpZNN5uouDLXCDGuCSEJxOgUvBGRYtfh
 BizpWp/pFaXekvpNtB/H6RsDx41vzxa8nMCUFCu+ABp9m80ZZk9KS3DHb6jzdul6xHEt+qBc/pt
 aIZj/fk
X-Received: by 2002:a05:6a20:6a26:b0:3da:5eda:d167 with SMTP id
 adf61e73a8af0-3daed1515e3mr27460656637.5.1789344509851; 
 Sun, 13 Sep 2026 17:08:29 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 09/11] tcg/riscv64: Fix off-by-one in branch range tests
Date: Sun, 13 Sep 2026 14:08:12 -1000
Message-ID: <20260914000814.785155-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

We tested the size of the field encoding, not the
actual range of values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index e8e1480016c..c167ff5237a 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -480,7 +480,8 @@ static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1,
 
 static bool encode_bimm12(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 12)) {
+    /* The 13-bit immediate is stored in 12 bits, with bit 0 zero. */
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 13)) {
         *insn |= ((imm & 0x1000) << 19
                   | (imm & 0x7e0) << 20
                   | (imm & 0x1e) << 7
@@ -516,7 +517,8 @@ static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 
 static bool encode_jimm20(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 20)) {
+    /* The 21-bit immediate is stored in 20 bits, with bit 0 zero. */
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 21)) {
         *insn |= ((imm & 0x0007fe) << (21 - 1)
                   | (imm & 0x000800) << (20 - 11)
                   | (imm & 0x0ff000) << (12 - 12)
-- 
2.53.0


