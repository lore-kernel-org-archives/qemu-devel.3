Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4F0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rf-00047b-2n; Wed, 15 May 2024 03:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rc-000459-9F
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RZ-0001Yx-Vs
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41fc53252ceso45478335e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759575; x=1716364375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Iqnca+HhnCCBvOshaH/DqsUrANLuNbYvwccCz1eMgU=;
 b=ZMbpsqZ/JpCVkNuwB18S4EZkjyaFzI3hd/m0OMxvVKoj+4zwITahTAZwG7e5Q+toEU
 K6UdNgMnX+cqVRFmMTL1tzDF2odygnkFvb2Rm+wh8EpupJWgZ/sybQ9pjrydJyap2h3S
 Twsh5bYVlAhtVqZLj/XaQWPfTbyKP5XBR6RDEWHyyRT/TAGUWnSEGQId9kGI24emWZmH
 7xtaDWBELcRrjhuwMqEpLLVi7OJZ5a6L29i4mgOwIoJYjavHzz/ARKmhPMACtA4nfN8J
 f5keGQ/hGlz8dW7Ai+6iPPRbNNFZHkX50GA8nysrHQFkCJcmruiCM2CUU83ThyV/9Fwi
 v3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759575; x=1716364375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Iqnca+HhnCCBvOshaH/DqsUrANLuNbYvwccCz1eMgU=;
 b=UWvDpvetA7YFGmDUt5pTMkayqpSUqF7Sfg25odD1ElBel+meRnRh5S+CWOY4aXfmsT
 hNpRuHOiygTVvjwdpoeYjYZn4hDGheGTOU/DzPYmEtI9PBCrtPoN+POuQkhJagItlbe4
 TcqQhiCMhmGtqezafoga3Wo+txTujwCJwfmrxj+/CWcFfOJyTf+EGmdqeih7H3anP6qO
 kg9BS9vPbQyf/ccFqIPZArKW5JNDcsPJOd5PYKue3ryUl48TPj48UcAK6+GeVTX0Edbv
 cHUYlwPEdUQkfSAO6BcJzuivBx94zTYGf9iCGnk3+WHxQhwH8Pp6hr3c29SEXtPfiOCW
 ouPA==
X-Gm-Message-State: AOJu0Yx5Usq5Du2gsUzn6CYZ/HolaRVApop2vwe9wub3qoO+ZtVAbpGv
 HxM11z1EPDi6KB1Dj5R8OIw3sl0BDteifQV6mflgLj6oua3UQ29Csmbi+M39rmBjQDjb1xR/H/k
 eHw0=
X-Google-Smtp-Source: AGHT+IErZClWZ8+m1NNDBmn5mCdS0GibT0sHIu7HWZ2qkQUE6YE95stVMs2AWHBjZrqxaCoWi6rMqg==
X-Received: by 2002:a05:600c:3c83:b0:418:ed13:302d with SMTP id
 5b1f17b1804b1-41feac55135mr125046055e9.26.1715759575266; 
 Wed, 15 May 2024 00:52:55 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/34] accel/tcg: Record DisasContextBase in tcg_ctx for plugins
Date: Wed, 15 May 2024 09:52:21 +0200
Message-Id: <20240515075247.68024-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      | 1 +
 accel/tcg/plugin-gen.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 135e36d729..2a1c080bab 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -537,6 +537,7 @@ struct TCGContext {
      * space for instructions (for variable-instruction-length ISAs).
      */
     struct qemu_plugin_tb *plugin_tb;
+    const struct DisasContextBase *plugin_db;
 
     /* descriptor of the instruction being translated */
     struct qemu_plugin_insn *plugin_insn;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 49f5d1c2e4..842da97204 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -329,6 +329,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
+    tcg_ctx->plugin_db = db;
     tcg_ctx->plugin_insn = NULL;
 
     return ret;
-- 
2.34.1


