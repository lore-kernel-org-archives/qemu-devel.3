Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9369D2A541
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kM-0002fs-8A; Wed, 16 Oct 2024 15:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kI-0002cc-Pw
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kG-0003nU-7m
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so143455a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107103; x=1729711903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvpTPvpHazkQ0TVI9JimtqNfgw0t+6U1n7b/YyBhtQ4=;
 b=iCKE+s4oHkOGdCICtWWhn1yK/uyDLV7FssOUP1YjQL7QsvBI9VbpBHoWFSa+MGAwc/
 D3C4qq1p6kk5uW5Y00O5++C8cQ8cjF4E1dbfCt7uWZ7qHVU0HWFOOAL655/pW/WsazbO
 XJHy57/Gny9mmW2e1B20oIPxDvWQa5ufHlk9S8YAmdCRLQtfgu55Va685oNn9J+xGkU7
 fdgGjZqegqVTl8TttEdrRqmKrDSFzYTYH7cR0rJtpb6Dh34R5pAlq/rMJRRfX21Bcj+L
 LqjV76m5ajxJmvHrEy770XGbnQr+qulozAyd01zCbk1Sox77OUAKhZCRgrLkHs5lxIZ9
 6hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107103; x=1729711903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvpTPvpHazkQ0TVI9JimtqNfgw0t+6U1n7b/YyBhtQ4=;
 b=u27m98U5RxFY0k12d765zjON5ns6mLkI35glcKKX5Y/OPVIaQb9DVPP89qY6xZjaKA
 iHOssT6PtT6QKvoR8SpiMWfqejFV1syueDvF2XrLa6Z9FqZxvOF04MY89o4GC6wVnULM
 2vxmsApNXwp22hj3hH0G7aMwoGSIp14tKVSUnOuEmdHkml/OTaRKaWfzp0oszzR4pPRV
 blXFkaxedaO7G/VMuxybkbFrmf8BUWpOaWVD1HPmUkFOBKnHunCZ3CRs9DH8x/pH/2Qn
 M9xAoGu4Gcu2pjYdLuCOlMGB8DlvJuW7YYzl7wj3NrcPF82tGFUqtz4iFdRuyTcxi0kV
 W17A==
X-Gm-Message-State: AOJu0YyWbaeFWbHi0lHV3I4KmnJrVH8TnnicLCBPF4qut7H9mwoapOEo
 hr8zt3Yp7k7bbxfZOZUgjm4dEBZAmXSP4V7ox4xqIqZmWKJq0+E5t+Y9JMdE6h6WjtD4lcNsp8X
 6
X-Google-Smtp-Source: AGHT+IF8/I7V0wy+N403TFlqBl9QrPskdBCJTLhy4rEFJMIFj8e1TeWG8NPIXKlD9R+5TNnykNwJog==
X-Received: by 2002:a17:90b:1215:b0:2e0:894f:198e with SMTP id
 98e67ed59e1d1-2e315357b40mr21424498a91.30.1729107102699; 
 Wed, 16 Oct 2024 12:31:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v6 02/14] disas/riscv: Fix vsetivli disassembly
Date: Wed, 16 Oct 2024 12:31:28 -0700
Message-ID: <20241016193140.2206352-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

The first immediate field is unsigned, whereas operand_vimm
extracts a signed value.  There is no need to mask the result
with 'u'; just print the immediate with 'i'.

Fixes: 07f4964d178 ("disas/riscv.c: rvv: Add disas support for vector instructions")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 2 +-
 disas/riscv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 16a08e4895..0d1f89ce8a 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -290,7 +290,7 @@ enum {
 #define rv_fmt_fd_vs2                 "O\t3,F"
 #define rv_fmt_vd_vm                  "O\tDm"
 #define rv_fmt_vsetvli                "O\t0,1,v"
-#define rv_fmt_vsetivli               "O\t0,u,v"
+#define rv_fmt_vsetivli               "O\t0,i,v"
 #define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
 #define rv_fmt_push_rlist             "O\tx,-i"
 #define rv_fmt_pop_rlist              "O\tx,i"
diff --git a/disas/riscv.c b/disas/riscv.c
index 5965574d87..fc0331b90b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4808,7 +4808,7 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         break;
     case rv_codec_vsetivli:
         dec->rd = operand_rd(inst);
-        dec->imm = operand_vimm(inst);
+        dec->imm = extract32(inst, 15, 5);
         dec->vzimm = operand_vzimm10(inst);
         break;
     case rv_codec_zcb_lb:
-- 
2.43.0


