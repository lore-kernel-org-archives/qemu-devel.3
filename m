Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DAFC54E6E
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJC-0002v5-Ej; Fri, 15 Mar 2024 21:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ6-0002s5-Uh
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ5-0000m2-5g
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dee5daa236so15052625ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554273; x=1711159073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfrhB6wtiY1dRspgCcVihnqjgoTQCBAZYhtK1KymQU8=;
 b=ZDXl6Je7jGLn16nCYdR4z7RTllvyIjvsYUgmSvNxFvajUIegfVv7WS1K3IyT1GRLR0
 4vbxdgm5gGq+K1JuqUpTAr8bDOEwh8CX0P2/48gcMoYyd1yCDUzsJ8kBv6J8q0+dvcJd
 j17DJIvvTZaG69KkbxBzULHRHSEYomgfAiqy/zYSV8nE+Q17iraTBa2sUJ5uH2PNXpVi
 IqOijzjNkTfsiDec/5jRZbCna1eQIdl4UaUtqm9zoakPfnR8rh5dIB7I8sLA+fyF0+qG
 E4vxMWGwpr2tKjnBpMA8obUg+mRMR4a/+3iKRz0wYp96Z0n6+MkgeGLSkRmDMgfHCdyY
 bzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554273; x=1711159073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfrhB6wtiY1dRspgCcVihnqjgoTQCBAZYhtK1KymQU8=;
 b=eEMu38Yu0suMy4qqDrvIuTOYIy3pSO6NqKLmd0IXFfYNLoC6i79ZZ1oPkECs1fNdyO
 /bBBGsoTUfMlAOplqccVc0BlvwkXDTzjlo/3B3Xoz6jhIBryKP3M8VnhcoNkseqqkt/x
 ZwTvlamAVhFYvkMeU1f8bJ7lbwAvNSGta9+yK7w6MYgsv+P462mtsIIrZ6meIeMjmLNX
 bLKLJdIrFG1dH3vz2rfOOOvBYcKirgbeWImz24rtAy7YchANvQPszUtUdr8P2JP2Ae+r
 MV2DtS8g7VNjrWoXBhsi6gn5N3TfzyohdY76kq0/iLEzgoSR022YC0KtTWJ5Sqz01vxz
 aVbA==
X-Gm-Message-State: AOJu0Yx126+IM7Xikvo7covqNxSrref0+40kV4fqjL1j1CWBVq17ReF5
 Up2SCLVUb7/Xs8EUWD83hg/uNT7zJomlfInwyaQi29UdvLqLwqCYp+UHT6hmm8kNnS89qiFn2g7
 w
X-Google-Smtp-Source: AGHT+IEq9WsJg7CuaTKFZJ7C0azoW88XvhxDcoUysH22FutYdCk7rhUxe5fCUwncIkmRmUMnDdwzVw==
X-Received: by 2002:a17:902:d2d0:b0:1dc:6d64:dcff with SMTP id
 n16-20020a170902d2d000b001dc6d64dcffmr6432966plc.37.1710554272928; 
 Fri, 15 Mar 2024 18:57:52 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 14/22] tcg: Remove INDEX_op_plugin_cb_{start,end}
Date: Fri, 15 Mar 2024 15:57:12 -1000
Message-Id: <20240316015720.3661236-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

These opcodes are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 --
 include/tcg/tcg-opc.h       |  2 --
 accel/tcg/plugin-gen.c      | 18 ------------------
 tcg/tcg-op.c                | 10 ----------
 4 files changed, 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 72b80b20d0..009e2778c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -76,8 +76,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
-void tcg_gen_plugin_cb_end(void);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index be9e36e386..546eb49c11 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -199,8 +199,6 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
 DEF(qemu_ld_a32_i32, 1, 1, 1,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b5261edc38..c8f0e0ecaa 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -58,29 +58,11 @@
 # define CONFIG_SOFTMMU_GATE 0
 #endif
 
-/*
- * plugin_cb_start TCG op args[]:
- * 0: enum plugin_gen_from
- * 1: enum plugin_gen_cb
- * 2: set to 1 for mem callback that is a write, 0 otherwise.
- */
-
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_AFTER_INSN,
     PLUGIN_GEN_AFTER_TB,
-    PLUGIN_GEN_N_FROMS,
-};
-
-enum plugin_gen_cb {
-    PLUGIN_GEN_CB_UDATA,
-    PLUGIN_GEN_CB_UDATA_R,
-    PLUGIN_GEN_CB_INLINE,
-    PLUGIN_GEN_CB_MEM,
-    PLUGIN_GEN_ENABLE_MEM_HELPER,
-    PLUGIN_GEN_DISABLE_MEM_HELPER,
-    PLUGIN_GEN_N_CBS,
 };
 
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ae12fa49d..eff3728622 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -322,16 +322,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
 }
 
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
-{
-    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-}
-
-void tcg_gen_plugin_cb_end(void)
-{
-    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
-}
-
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
-- 
2.34.1


