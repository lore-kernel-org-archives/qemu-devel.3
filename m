Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F2C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgup-00089h-UN; Fri, 21 Mar 2025 14:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvgul-00088n-PH
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguj-0000Xo-VV
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1942512f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580972; x=1743185772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eigCKA57FDdckzJucxLxWrPBLxcaGkw0LIij0a/Esg=;
 b=elU4qrGXsGj/K7PdG5QiWpJoPJq9GEDfcxvdbhTUDsJkajqY7JgkXGEv91hghrBiGo
 m4EcrX4t0lo3436NjBuPlKAUzqqkMhOsoFwYvAR+Lti66NmQIfB6knRXDOKDjDEWiCYe
 S7kUIBxEzyqAXOlgsFfZuKZGTMDMTrfObfnyh5p8uKu36bRY7qWashU91gxKNmYJnr4h
 93O2HnqkKWRV4PFIh+Nco1/1KHP/N97RpD7oFcRquyE65gJOfg3BXitVbjNO7GQLVbyz
 q8qebaG5ueieg6bZbk5TJhv1qHsgMnxLVCm1UKCjHYNTAjwmt/rDC6msbqzqCT2lTdX0
 5yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580972; x=1743185772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3eigCKA57FDdckzJucxLxWrPBLxcaGkw0LIij0a/Esg=;
 b=wkZrsXoJa7s32RBaiPm8IuKB3inS/4hUuXar1I3Tv4nP4u9fMuvTD/qiQP3G6SE6UR
 47pWU8b/r9hyf6V+QWQmDOiZR6//74oVcIb3QNRywuRpG56oA2FKsQzbEmpFWsHYOdLr
 OrAxLFzk2N7t8eIP3F93zWld2NIZTg3Emq+q6uXQH8lT/yGOYOCyoEIfNIP6j8/PiRAn
 3b9zpsAtEodvoaCBvnQoKD6Dds0NH9mS/Jry1EoD8v+Mc0cCsTqz7D2WXV6HVndWuYMG
 ZSXptAr2nv8HqgNcio2Ir2EGWX3iU2DaaTr3hr0axIebXGJPz3dzimdt6mgzVEGmxC/l
 JV/A==
X-Gm-Message-State: AOJu0YznGnthwM5u1JEXihESR4EPaqlnDD53aMdFxjwKwstwZV5fhmev
 bDmzxsXwhzLlaOSP4b7HMhk/Wq2WtenXRRkGuJ7yVg5v17MQ2UC7Pcsmt6lCV+Vi+aL/peAtjhs
 F
X-Gm-Gg: ASbGncubyGjh1SYhSYKWVe+WPUvM0pZFIFVfsHnO+BDEaZugnQKfC8Ukg/q3dmfC4D3
 wKnrpEPmGfXMMIBcab01VLH9HLZmaDXemaK1IFOwQucoQui/qxmj2mfddrUqZwQHykmFcztrfTA
 8GV8Y59YagFIeqOoPfLYiuDsyHLnuprONElEdYQ6HgVm/cLmXSEmTnEyuLo6+8nMcn+XsgagyFc
 6mskIfqkuETcOvNtCRgJNXE+UFOgTyMdWvmSBvv5TqjWP37CGfOxbSt9EptI5jAB1a91vFjESG0
 2xzglABQw2USQ2iigILPGIXs3i+z87RmVEgB+AUi/PDayes24nDxwxH5CYK6sDIXycDo2vm2wd0
 9IZY+AsHOMrGVszphoPZ+6CInU7SR2Q==
X-Google-Smtp-Source: AGHT+IGTcNc4gonc4wjHqUg5TijMWxyEU+//+Upm1LKtczYPT77WNfQUQQKhExyvuXd+vJktNYEb3A==
X-Received: by 2002:a05:6000:418a:b0:38d:eb33:79c2 with SMTP id
 ffacd0b85a97d-3997f9154e2mr3257491f8f.32.1742580971926; 
 Fri, 21 Mar 2025 11:16:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3b4bsm2972568f8f.25.2025.03.21.11.16.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:16:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 4/7] tcg: Remove use of TCG_GUEST_DEFAULT_MO in
 tb_gen_code()
Date: Fri, 21 Mar 2025 19:15:46 +0100
Message-ID: <20250321181549.3331-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fb9f83dbba3..26442e83776 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -349,7 +349,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


