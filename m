Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBDDC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhDkt-00039L-NQ; Mon, 04 Mar 2024 14:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhDks-00038a-LO
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhDkq-0001au-FA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412e784060cso5735565e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709579618; x=1710184418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0d/Phj/7yIgxNG2HYpQbbRbVtCMOAMLsAUj8z9GTaE=;
 b=q/buDX0golA1fhq4rpurn8iIdNHffew24Ace9ub4WuZstFE8TCYxej4h8oYnWxjPKG
 xBja1V/pjUx3sujJYBEr8dANtzGOJxjGRiQO5dS4wxd0c12EnwWg37sDESoJ45x6sz3N
 nypAIqWp3oixSz+ZTgQw7O5LvDzHQRM6hMQoOfxOIIOQeUyMSyttu0cx/s1GGlmCJSjv
 2Qifmbep+/BtEEHQBWFDknuCSVNurTHbXQ+AMMXnuGizuN5PZfNrzDKV+IPMJuR3QDF0
 aR8Az5dN+HloxLBkX0EFokbyYDPGYF8DEtcuujAG4QPutS+LaGKPx0CUxRu2S5xM6sit
 JZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709579618; x=1710184418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0d/Phj/7yIgxNG2HYpQbbRbVtCMOAMLsAUj8z9GTaE=;
 b=Za2GVIAqePaUSevjSUNpy87l8wJL0Z3mvBZ9M+qMrXvi/96vdM/klkEcQIGNhqKKIA
 igZLcwMnnjlxWsqhfrq2evpXVK9YrCRVWOQ/GuS+KJ77ndz6bIAsjqM5S9m7+xrF6T+x
 vUZexy5NqzfqBqCsODgHZs+XGi4PBN9kniMZ40ARwfOIkIvthQ3QZ0xlymAWT7m/cTF7
 EzSIZLUZtZC8pox6zot3t5kqrEoXKs5qIZV0ZslWR0Zi6r+S0dXMlf/nqv6eb9PUh2f4
 uGoLD8raC4KHvk9HAe4nfpEj7uuDi27kXqPZWlJBA4jmnUR0GsX05i4WhXvzAaX3xH0l
 U1sA==
X-Gm-Message-State: AOJu0Ywc/nkqGR74rc19gh1WijAdt9dcEtMrUFXMEhIl3fO6XjBZyxTy
 ENJQ1EpKpWuvnVdOHoJOTxFDT7P81LSmVpTAgi19k6pwmilGFuBVogSq8TkKtTU=
X-Google-Smtp-Source: AGHT+IE1hKHBoMvTNIkUWYdNqLVpfLTaIoJcEeJKLrWz3VcSwLJ9ywNhMqxn/GzIc2dn2HPigOE+hw==
X-Received: by 2002:adf:a792:0:b0:33e:4865:9ced with SMTP id
 j18-20020adfa792000000b0033e48659cedmr47540wrc.2.1709579617987; 
 Mon, 04 Mar 2024 11:13:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p8-20020a5d68c8000000b0033d87f61613sm12891321wrw.58.2024.03.04.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:13:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 364D75F8A2;
 Mon,  4 Mar 2024 19:13:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/4] disas: introduce no_raw_bytes
Date: Mon,  4 Mar 2024 19:13:34 +0000
Message-Id: <20240304191337.3101411-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304191337.3101411-1-alex.bennee@linaro.org>
References: <20240304191337.3101411-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

For plugins we don't expect the raw bytes in the disassembly. We
already deal with this by hand crafting our capstone call but for
other diassemblers we need a flag.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/disas/dis-asm.h | 7 +++++++
 disas/disas.c           | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 2324f6b1a46..5c32e7a310c 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -396,6 +396,13 @@ typedef struct disassemble_info {
   /* Command line options specific to the target disassembler.  */
   char * disassembler_options;
 
+  /*
+   * When true instruct the disassembler to not preface opcodes with
+   * raw bytes. This is mainly for the benefit of the plugin
+   * interface.
+   */
+  bool no_raw_bytes;
+
   /* Field intended to be used by targets in any way they deem suitable.  */
   void *target_info;
 
diff --git a/disas/disas.c b/disas/disas.c
index 0d2d06c2ecc..feb5bc4b665 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -273,6 +273,7 @@ char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
     s.info.buffer_vma = addr;
     s.info.buffer_length = size;
     s.info.print_address_func = plugin_print_address;
+    s.info.no_raw_bytes = true;
 
     if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
         ; /* done */
-- 
2.39.2


