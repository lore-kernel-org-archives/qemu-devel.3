Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D4BC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmi-0006pp-NT; Mon, 24 Jun 2024 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmh-0006ov-JX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgme-0007hs-Mt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:51 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a724b4f1218so133438366b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224326; x=1719829126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csz4agAZp6lldiHiVd/L/1KnBx9/0btPjs2vbkrKDHw=;
 b=ehrNIR6s2ugtuKX1oJKaSxMT6df7vcm/OIwEV1MmbzUDFepB1Fk3vhfNeF9p/41yt7
 GjKWgxjYnyKB8xrM0rC3wY8kaqN4HeYXw1R7rEIdBU7FykjAfp10TZwH1YtxEnPQPdj3
 z1vJP5RGAAIrUJE8fQz+kIRtv1KK9LkFa2Uue7pv4Jbq/UsFskd8dt1jtznnfXbGOTkS
 A+fE8R9nrpC6Drf/lsI83KUf6ytZf+r8a3MEQk3VyQbRcCEOfGXJiGvvkE4QrUlYsnCD
 P+K9Oh3V31bHkT5SDVv3hJ5/Rz9poM1EQ3up8EDE9+66gkcjVbTHcM8ZDHgoUrIQrw4d
 c3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224326; x=1719829126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=csz4agAZp6lldiHiVd/L/1KnBx9/0btPjs2vbkrKDHw=;
 b=Io4JWUhpLC0S7fPNhq2sCklsekqjmLhiZKz7e3xxOEXDh8Km7bPkKSOOSa6g6U4/vC
 ZeL3Egv1SlEcYVpueXptnvdsL86ddgqH6lMqaoqKT6TZbZkWFl48nIj0rl9KlGwAuU5k
 rUI4EjA5y6onAIJP1tA+11fmPcK8QNne2ddz12Lm9gyiP4PebTbzFAAHufDnpJaKzfmL
 2OOP6CKVkW/VJM69D8YBAmmiSG6Lrn684YZcZWq0pbk8ZYwqXEy/kUvor/KlfqPiMw3o
 KgXhDexZc42um8lkqJ1aJnbUB8/X0RPdq2GYt02BTbJFLm/wyE9XMdjCz6/jqsJryqkw
 J2+Q==
X-Gm-Message-State: AOJu0YwEJGnKp5HqF2eG01sE0cGx68Yo8fOedjrnXFHtDJ30/SY7scMm
 FoMtCdUovZr/RpB/GCGhu+UOTwcQYG6MKFV3LTwlJxsyaCw+7S91IthQcaKS7rUHgiVq/MjH2Cw
 S
X-Google-Smtp-Source: AGHT+IG5BSidx52uhSWpp/mh6pNM+q21O4sxjvtkcz4NhOy76Clte55RiYYAyLy5AoXyXPbRdt1JjQ==
X-Received: by 2002:a17:907:8b8c:b0:a72:4b31:13aa with SMTP id
 a640c23a62f3a-a724b311555mr241195866b.55.1719224325881; 
 Mon, 24 Jun 2024 03:18:45 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf428c24sm400211666b.17.2024.06.24.03.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7ED865FA2E;
 Mon, 24 Jun 2024 11:18:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/12] accel/tcg: Avoid unnecessary call overhead from
 qemu_plugin_vcpu_mem_cb
Date: Mon, 24 Jun 2024 11:18:36 +0100
Message-Id: <20240624101836.193761-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Max Chou <max.chou@sifive.com>

If there are not any QEMU plugin memory callback functions, checking
before calling the qemu_plugin_vcpu_mem_cb function can reduce the
function call overhead.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-Id: <20240613175122.1299212-2-max.chou@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-13-alex.bennee@linaro.org>

diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index c82048e377..87ceb95487 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -125,7 +125,9 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
 
 static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+    }
 }
 
 uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
@@ -188,7 +190,9 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
 static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+    }
 }
 
 void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
-- 
2.39.2


