Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854DBC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGb-0005sa-C4; Sun, 23 Mar 2025 13:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGY-0005r7-MK
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGW-0002un-UE
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:42 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fd89d036so64755695ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751459; x=1743356259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGR007VvjFffVl8PvgR+T2VNJf200xt2PbQ7cdgNESw=;
 b=Two8K1g2LVyOQZ9cFcyeIpnd33HDl1qspvQAKTT+g1U6STwdo667rdd4D9CQdia5by
 qp4SA1YIV8og6+M+24W02JJFCv2jpZvJkRbtgDuqfdGIsBnHvLGT7s5KZp/gJLHhmv6b
 xrPgvPQ9jJ5udjB9clW1PaGbWz/Ubg55kU60KX4NbyumJvEGqlhaHCFWQBJpX8ttdioo
 HESQ+5ZN/doTGHWkRLN0N2sZjNFmYucAqnhbKpgRrFSvND/OQ8YzPFaHxGLkDkVorQ5/
 rxXOjtkONmQ1paJ7ZSGT9h4oZMqI1vmhd5Tr9R2YtvHXhEpXTnPjq8qTshoGeSmlTwfR
 l8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751459; x=1743356259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGR007VvjFffVl8PvgR+T2VNJf200xt2PbQ7cdgNESw=;
 b=XGjTYG/t6AW9f4X6p14a9+bsZlMIpmVB4vObdwjE5a2U9YmOzWbCYRBy/kjmoldBki
 wWveg51Jr1knChyjN483BCUpGTkp3K7q20Ggh2LzELl0uSijaLyOtYO/4N9sStOxi3t5
 pcNs4qVGzwjdw3Fo7uBpiz/ntkhOWzuM6IGhovCO7Xvy96UsM0He+tCBmo6MI7JlSOXw
 4vgBv2/Qr53J0u1h4Tb5rDo7lSpIZL/WJmDJjDAyPIsaoPrOO0YcI98AdqikSQVd7/dn
 H5aB0r+xOz81ZOz8dslTIk7hLpeDaFu2Sb6UJpeOKH1sJJagJd7XTeeDPGpOvA3pXCyv
 Vm0Q==
X-Gm-Message-State: AOJu0YxCLRmAbBErV9OaANxkAoSEcjSkYerrPbu9n2hC89lB6IcKnuIo
 mj5b0SiSmjDNvA81E6paRtYEC0f3xjX50Dr/LtgeNDCn6eFhGOkgens98KrJuYb5DtAOQe5q1a6
 Q
X-Gm-Gg: ASbGnct70Ri83uKc1LJEKB7wTbUfTV9NLefnDHkJYYQihxFdNXKOhqVnSAQe95vFGKg
 C19FH5rAbw71FDB++qGx6boolEfLAPk7rYsmzVPNxTJIlzWpKqSI8qo8nbOIQHNcXupYXK9ic/o
 3JO/7/6Leh9gQo0wi4PHi4hLacBMVlDMLiDiswElx5uwDsK43+F/yCp9+fBW3L+hLNzyXzlN8p+
 OznLCq2RDFt9crxi9viNWVfzXYL24Yb2NZpv7VB4o4hEUXMdcRTXrKXc0xxzQPLZoewDY/7RtTo
 lOTpWry4eA5+pCLsfyNN44jS95dT+YE5M0HOiDo+nxKuu+6OodMInUhR+VSREMe8uCtNR8Vlb/w
 H
X-Google-Smtp-Source: AGHT+IHHx0nOVmHngDjuW981So2eTho/hEHIb4ep9xftdtoXyFfhar8ZUpbQmkUQtm6NonO0IxxAdQ==
X-Received: by 2002:a17:902:f550:b0:224:26f2:97d6 with SMTP id
 d9443c01a7336-22780db4699mr188214705ad.28.1742751459621; 
 Sun, 23 Mar 2025 10:37:39 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 11/17] target/avr: Implement CPUState.memory_rw_debug
Date: Sun, 23 Mar 2025 10:37:23 -0700
Message-ID: <20250323173730.3213964-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Prepare for offset_io being non-zero when accessing from gdb.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 080f6f30d3..e4011004b4 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -68,6 +68,35 @@ static void avr_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->pc_w = data[0];
 }
 
+static int avr_memory_rw_debug(CPUState *cpu, vaddr addr,
+                               uint8_t *buf, size_t len, bool is_write)
+{
+    if (addr < OFFSET_DATA) {
+        size_t len_code;
+        int ret;
+
+        if (addr + len <= OFFSET_DATA) {
+            return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
+        }
+
+        len_code = addr + len - OFFSET_DATA;
+        ret = cpu_memory_rw_debug(cpu, addr, buf, len_code, is_write);
+        if (ret != 0) {
+            return ret;
+        }
+        addr = OFFSET_DATA;
+        len -= len_code;
+    }
+
+    /*
+     * Data is biased such that SRAM begins at TARGET_PAGE_SIZE,
+     * and I/O is immediately prior.  This leave a hole between
+     * OFFSET_DATA and the relative start of the address space.
+     */
+    addr += env_archcpu(cpu_env(cpu))->offset_io;
+    return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
+}
+
 static void avr_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -262,6 +291,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = avr_cpu_gdb_write_register;
     cc->gdb_adjust_breakpoint = avr_cpu_gdb_adjust_breakpoint;
     cc->gdb_core_xml_file = "avr-cpu.xml";
+    cc->memory_rw_debug = avr_memory_rw_debug;
     cc->tcg_ops = &avr_tcg_ops;
 }
 
-- 
2.43.0


