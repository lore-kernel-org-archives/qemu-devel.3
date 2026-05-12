Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490FACD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZZ-0008J9-Jz; Tue, 12 May 2026 02:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYj-0006gN-0g
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYh-0007C5-6q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3146576f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567133; x=1779171933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HfbY1c3UCIy8gQxFWOZ/VIeIMJesFzcBvmUGEZHahNE=;
 b=Z9k3OsOzb5Hg4KRbohexQVjqyQ81LWYIBnD8ilCiAC0qJRgmv4LdUAgGGwWmR8nNuf
 5CevgiHX/jBkp8lhBuUl3nCREXOv/4iBmKqnXqCe6L4JXSfxCmWVqZQAPsYdLDFvjOeL
 EaEQv5amy6PZRuI0N/ISdw6D3b+xooEXsWWe/nDg5FjgG7otYJyKuryqr3SUWtuy7gp7
 tv7v2S1JTNrTn+4OvL8M9ApLrp/b5QiNznVUp5Bij1tuEhX8JgyDZgSSaYjXzNfYqZ4O
 DAkEHhmdaNgW1vrJcwYv68e9TsPcOk2x5e86PY97BmswONPFBVvRdHRHzQV/DRC3j2P5
 m3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567133; x=1779171933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HfbY1c3UCIy8gQxFWOZ/VIeIMJesFzcBvmUGEZHahNE=;
 b=W0u21aR6kxqx4YKTHzBKohWo57Q/GOqL5qdReFXU5ErHXMeG18gm+aqf5IwBdDUl/r
 z6B9l0ibHckEM+IHv6cm3I4JCA++XwPAom7TGSoWx2J4jytk1a4c02Q0eINSfhtC8vIN
 N5ARw98I04m/DxG8zec4Niq/UEcl+FMs42N1eQNt07wHBj4TPB+NE9FWf960KTjA1WxC
 JpxpYsrg2BwQCAzpy1WM5viRsTSmWWpXA453xmGZf8/JnRd9M5AMJDsWrFx0caYVlJkB
 t9cs/kHodh2xPjHLzWS9jrUep8E7f/4SzY9p1pK9G9ddsBudNI2bQQ54cuBsJWUY+Qc+
 QnUQ==
X-Gm-Message-State: AOJu0YxL4INVF5MRbpiqhMp6sN+wMkN0uD62mVnqijEH/4ULunD4zgs3
 7IMAphY+/UXNEk8NOaf7OV7tsescf7FH9JBCkKRNSgxpjPMyj+5kKscMsltwXAlR1yNoGzgqQNn
 ur33l0ps=
X-Gm-Gg: Acq92OEmGaQ04fMmKVDuILqshlMKlKcEb+CfXZA43PVnVDJINdfFCgCjRgtsIz8lul2
 0WrmIttJ048BhWWUpfeaD0GC1BcwzPEZ8dSAdO5uxf5ejEM1X0aaVYheWV7seAaWMAf2p90gCoO
 cEKyZE5E/tZgEKzZwQ0H6qAtTULiT7hndUr4rvmUlJa6uMMsanr1ewsXRuPq9zXmybos8UKVhPr
 1OgYyaFYZhs9L+fnaKsA9VoeFULJzPwE8ksRf7GguzbLDS9X58jqwPTw9G74ZXAZMNBzj0n83yp
 fVYR6AqFzXvFc8Xz4P3fotwDQuGeI5UjvKD6eZUez540DkP9/vgazgRRRVg+R0vdetqyXUnqOas
 ystZIydLCCZCwZj89WqbL9/QzWObsdxueuuVmtJVIfGj7s2DNDCcexmvlmaVGRMf6lmfg+lbCuP
 NYa7Ta/j86C2E4IhEk2ASImmYn2p6ebvQC0c9MWdkiAvIrREWWZ7VocVq6EawlfLAONekG8V1g
X-Received: by 2002:a05:6000:24c3:b0:455:51cf:9f92 with SMTP id
 ffacd0b85a97d-45ac4224ea5mr3317203f8f.18.1778567133150; 
 Mon, 11 May 2026 23:25:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm29937331f8f.17.2026.05.11.23.25.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/41] monitor/hmp-cmds: Use cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:33 +0200
Message-ID: <20260512062142.67998-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We want to remove the cpu_get_phys_addr_debug() function; update the
HMP gva2gpa command implementation to use cpu_translate_for_debug()
instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-24-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 88f9788bd9c..443b8c785dc 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -764,18 +764,17 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
     vaddr addr = qdict_get_int(qdict, "addr");
     CPUState *cs = mon_get_cpu(mon);
-    hwaddr gpa;
+    TranslateForDebugResult tres;
 
     if (!cs) {
         monitor_printf(mon, "No cpu\n");
         return;
     }
 
-    gpa  = cpu_get_phys_addr_debug(cs, addr);
-    if (gpa == -1) {
+    if (!cpu_translate_for_debug(cs, addr, &tres)) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n", gpa);
+        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n", tres.physaddr);
     }
 }
 
-- 
2.53.0


