Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CA3C636EE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjMmJ-00085U-Eo; Wed, 28 Aug 2024 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMmA-0007UW-Q4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:11 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjMm9-0004Vu-3P
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:48:10 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093997dffdso3903115a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724867288; x=1725472088;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Cl5ZRMk7pbT7QMKFwfdbtGEqWg7VKl5rT980Ov9IbY=;
 b=po+lJHCtxCXmkXlLcf2iKVhRhF9RYTK8FP6gvQQUB6iicvq39yJCtfi2otE5O4OZYJ
 BooIwY4OJIlcLqWQwmsqjxq0POMMgYwu+ADDUgkmMQOK51EWAukE/eyfd1/39ypKxfbz
 n1j/6px+C5rChE9A3vOFkwPrJ8S8Bt3fk+WNUlnBH3EMfFdPg1e5fBDNldCE5skjdJUV
 1/wWQvlmBDsZBCkP94Qc7K+rSy9sFn++aNsprekDIvVkt3dsHNQ2aSK+HA/xob4NmDRs
 ZfLxLGhZJMcuin0875Mew57IGRBw45hK/+XSi6xqB41Rry45tD0dEHW+azaeP2PUpwEO
 lXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724867288; x=1725472088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Cl5ZRMk7pbT7QMKFwfdbtGEqWg7VKl5rT980Ov9IbY=;
 b=VRbTG67QGHUrI94z6imZoM6sT4cOR2x5kfsVz1jGDc8uthpxF0/NBclYSEBwdUwlbS
 iF1lhkfqNei0OYL5WL2H50ZHd0i/hkVPk+G+y/HUWPLRcmlvxvvfpJbFFAZPtcJfCChW
 kL4cfzZL3pUbALtagIR0xQ1nNqD6NIwujmiZ6b8w/fECGOdq7i5SMquy8qhZUtH/G912
 mAgeC9OOQW8cGTXHHQuntosU3DEf5Bd0/l5Pa/orA+vSEGdXYo9mkXI+Qi8d1PjQufZs
 Dqea9wNlWWXXD3ML5JblvrLjVTqp11dRmt1oAuXR6uxWDWP19h5dEYo3FbaFeAHNbbrP
 hm/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMnyTM6KFMcKmMF5dmPUGN8p+UexYK2BTdPO9HG1J587ZOuKc9gfhGLG/GRbAMz/2dIxuOEXrQtqcY@nongnu.org
X-Gm-Message-State: AOJu0Yy3z6RtiBsTgG0Se6ywxGkWeyD0dZ02yV2pQD4znYdAK36B042r
 AemOxAgfxLSRmAB1diH3+xqhzuM5POSOoYTjhnO5QS2KBe+pEwoBHrlp2bDy28w=
X-Google-Smtp-Source: AGHT+IG/UP3MJnf3JA1W3lByGgBqmprMbdeoZsZkKxUPdK7VS/347dx0XEpeGWs3aABtIf+Uyo3VFQ==
X-Received: by 2002:a05:6358:7e4f:b0:1aa:bf62:67d2 with SMTP id
 e5c5f4694b2df-1b603f77fbamr55744055d.25.1724867287630; 
 Wed, 28 Aug 2024 10:48:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acdcf7dsm9778316a12.50.2024.08.28.10.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 10:48:07 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v11 17/20] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Wed, 28 Aug 2024 10:47:35 -0700
Message-ID: <20240828174739.714313-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828174739.714313-1-debug@rivosinc.com>
References: <20240828174739.714313-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..bf893d1c2e 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  # c.sspush x1 carving out of zcmops
+  sspush          011 0  00001  00000 01 &r2_s rs2=1 rs1=0
+  # c.sspopchk x5 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 &r2 rs1=5 rd=0
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.44.0


