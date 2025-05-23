Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF93C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIHlY-0001IL-II; Thu, 22 May 2025 22:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlR-0001Fb-Kf
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:04:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uIHlK-0007kY-8m
 for qemu-devel@nongnu.org; Thu, 22 May 2025 22:04:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso7276735b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747965832; x=1748570632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=KPtJTBCjpu4yKyYaF50u7cuy0NGXkpcD4uC9z0/x/qu9S0L5XAdbPmZ4u+/FhvHp/b
 NHigaHMweOX1lxjArpikI/Ak/M8fUXWWugHysoPMdMgaocXkQVFwA8LnBw1tjHnPwOVS
 NqU45LrkHtAYUbwxtp5cv/CMa6xtnHGRFLkNOjGbQNg56Q4gJP9kga2abT8TdjnN8BoB
 FwSyEDeSoqWveggXvKXmxrJnK8YhPsC5MH1K/Kr2z2ARdTTlsvYgZntGomBnX5ahbSS3
 7arl8bZlctdG6Q1ZKcWPs6awzyfloBAW6GV1vskcPjU6aypS65Ja6KFVIRByexbKZg/Q
 C1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747965832; x=1748570632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVjrW993BqqXU9EpDADVH1dB+hpwPyajnX8KVD/tm+w=;
 b=v8XmbquWQ/GRs3DmT7qQAGyvhOxDsOkyyyOCxHHyPIHtL6ysRwsHgZwtp37wejWjaj
 L4speum6Hd9qDedR7OHVD/dXsJnW4qdZXn2HjEBHaIf1oc0muYJE1I9Ql5HAVY5lsBjK
 CSitoroXxT3PSWPbZoDdEvolkko1Rc+heWxxts0lAgZ9BqH9k8HYZnew5oqJPuGJcqR8
 v3EVrGIGFp9b/oVXpd0kkojJwYxv92XsHp4O4WcbOuMIzOf8VSBWtN4Sk//AzfE+QCv9
 wDgbIjjP781TEM4yfCWQKbVAYZfaXxfqHuouFmchk4MZS8f8OdliQu4B1svVsQuzditd
 /VVg==
X-Gm-Message-State: AOJu0YySRKQUHFTCw8/M7cUgygfr4xL9uq4uPkKuJ8T/406P/qV1mpON
 wiknNaGQR7myq3CxFWd1Fafa9UdFoBT0jHsuG9vcU1r7Rgr+wns2NXDw665SKVEXs3o=
X-Gm-Gg: ASbGnctfHQBS4NKaWxJbnZowy46tFGahDdxgTaSpxtriayryf0KLQKOuoxN31TAgglW
 bPASpIZaG/PwGXfGhjjkyxE9pRB1WEpc5CGgh45m+2E+tbSnviTWuO4fEOb7FnNtwpvgEYAwZlB
 UL8g7+78lJ5blfr6WzGmm0gT/Cr3YTcRW21a2XcvE91LV759VPcBbELIAaby4hjJQM8wTkIq9pV
 HEhFOutjUbUiWjmVxFK54VPecVNykXwtywk1y0/cLMmU0QXACaDFdRxViBYJoDvEeXSRE2ySEuO
 /PkYNOhWDqWgcn7cJXOCG7rUOFgND0P6MDUYZGqFZCTJyIgf36Q=
X-Google-Smtp-Source: AGHT+IGz2k4fDV9rjGYiKdTpJPGXIe/yOlC77/dhqjjBjm7sOduhKPxFLeaUDfyRXF0isS7EIj2rgg==
X-Received: by 2002:a05:6a20:3d12:b0:1f5:59e5:8ada with SMTP id
 adf61e73a8af0-2162187a945mr37029337637.4.1747965832319; 
 Thu, 22 May 2025 19:03:52 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a242asm11820818b3a.164.2025.05.22.19.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 19:03:52 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v4 8/9] plugins: Remove use of qemu_plugin_read_register where
 it is not permitted
Date: Thu, 22 May 2025 19:03:42 -0700
Message-ID: <20250523020344.1341179-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523020344.1341179-1-rowanbhart@gmail.com>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x433.google.com
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

This patch is required to make the insn plugin work after adding
enforcement of QEMU_PLUGIN_CB_ flags in calls to read or write
registers. Previously, these flags were not enforced and the API could
be called from anywhere, but this was not intended as described by the
documentation. Now, the flags are enforced and qemu_plugin_read_register
can no longer be called from a vcpu_init callback because it does not
request the QEMU_PLUGIN_CB_ flag (nor does it have a mechanism to do
so).

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/plugins/insn.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..265d3ebe9e 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -81,25 +81,6 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
     return record;
 }
 
-/*
- * Initialise a new vcpu with reading the register list
- */
-static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
-{
-    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
-    g_autoptr(GByteArray) reg_value = g_byte_array_new();
-
-    if (reg_list) {
-        for (int i = 0; i < reg_list->len; i++) {
-            qemu_plugin_reg_descriptor *rd = &g_array_index(
-                reg_list, qemu_plugin_reg_descriptor, i);
-            int count = qemu_plugin_read_register(rd->handle, reg_value);
-            g_assert(count > 0);
-        }
-    }
-}
-
-
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(insn_count, cpu_index, 1);
@@ -295,8 +276,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     insn_count = qemu_plugin_scoreboard_u64(
         qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
-    /* Register init, translation block and exit callbacks */
-    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    /* Register translation block and exit callbacks */
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.49.0


