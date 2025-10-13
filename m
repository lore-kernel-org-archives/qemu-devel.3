Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC131CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4U-00075L-B2; Mon, 13 Oct 2025 15:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4S-0006xF-MF
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:19:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4Q-0001t9-ND
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:19:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2281270f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383136; x=1760987936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CB1VK/yjYxp4/URxQ/T4/YFokgwgN5AuNNyA+7xghsY=;
 b=SwcptS4q6/A/LRiXBBC3bxPzg8J3+9dhBk80nOKREk0DBQWR7D4NO3IjDp0xSAqzLj
 IEw2/9sevVi/Spsaxeu7X8EDSZwHZySnnYXVVjf/DHtimfrXJ90RlRn3dvYLLmf3XhGw
 TOc2E9IiBi7KmgldcZIOdGQ7j/1vTWRE5u5RiDu7kwRMgBD+9S6u/G7l3cL+3Yl4hPo+
 ypf74sehHbCwNUcdRBvexWkNVsvJVNTgMbT41/BKEmBrr8kQp7S4R3vFhKlQmGLShuUe
 Vzy6hXLjpyCscfeJYYEakxqzeMhQpP5mF02yX3nIzLxGlqr4wskn6SPHcY48h3ZPa+o7
 izXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383136; x=1760987936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB1VK/yjYxp4/URxQ/T4/YFokgwgN5AuNNyA+7xghsY=;
 b=kfWGf39q4bM/g+DUDkumugwA4T2iLOITjnx6RyWXr085me8EAAarrkylJVdhmqc5vt
 Gc+5yzJnNyp0/YBM8ulbIY5aHRxZCPtnZtaK6pLTyhIwCgq+eMfmus+jmoVcNcJqBwYG
 P2rzhcHi8oymjHVmqQrGQt/sYsnJgvw1m5cpHW+ffOIuneg3BXDCbD9u3hVO9EA3N8Ft
 CoLCBEFFc4sGW+gXJJOVJMGqoIBfTEP76U9QN2JqIyPIwNh+wUfxNeKYP2KbpTZFlquq
 ls6MmzHo9KRaS/+JBLhEHPBxYkUoBVPpwAiP5uY4KS8QD/t+UFz66csEhN0tPTT1CqcX
 xfIQ==
X-Gm-Message-State: AOJu0Yx9PZ5Fc8HXcdLODIf0gaRJV50C1hJCOUMC72lKU5FytYWHi3YG
 BqyLGp11dG5qA0y63J0PD3pNVYXmdJngNpKI6ujuCKecVJmJPcVSE3WEthRiIff6xWsywEAQl6R
 36wpBU2gORA==
X-Gm-Gg: ASbGncubvM2mivwrkluL0OSJpy4PVBXaihvQIspLl5ZZtcPlhpNqW4VbP6BCZacGiEy
 M3efz5uZu+YO38HkFWQE6qRxCAXReGIINuAPjvQKAuXkiQwd9zOQmXB++EmNAvl+LwlVBEkTfZf
 /vQWSbJfUSNlDcGx4U+PibM3E3UeW8mSl9QVWYFJqpTRkgUPqj1ywMO+pbiikJhcjluH5j8KcsQ
 cIwZvpEcsRsJoWvVp2e7Y8ScJavhz6TdLbCBNDVww5/o49LaIAGU60OVnlMTGzCJbAqdF4i6GbN
 2ie93my17fZS9AATqNn0Qk13o8EnI2oRt8HDDKfALmfKYAtrCZJLYyx64VFrzQa9+08u9kVmPXp
 PPzt2ZMTuox88v/8Cn1AXJclYBG+gs3KpzBum0Oma64YDAnOkQexEIKvWvXBlC02ayKEYiyTTGV
 DhyPbFsPSupuzm1uyDr0Y=
X-Google-Smtp-Source: AGHT+IEZ/inCgUIVwBHqWsvqvOAAgAj78jhcsdU8s7M8LaGWyvxttBitBVrHVlfX2bWU77Rdoj2lgg==
X-Received: by 2002:a05:6000:24c5:b0:426:ee08:8eb4 with SMTP id
 ffacd0b85a97d-426ee0893bemr181012f8f.44.1760383135974; 
 Mon, 13 Oct 2025 12:18:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm19579127f8f.19.2025.10.13.12.18.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] hw/hppa: Convert type_init() -> DEFINE_TYPES()
Date: Mon, 13 Oct 2025 21:18:05 +0200
Message-ID: <20251013191807.84550-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Prefer DEFINE_TYPES() macro over type_init() to register
multiple QOM types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009143106.22724-3-philmd@linaro.org>
---
 hw/hppa/machine.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index dacedc5409c..2ab5fcb471a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -709,16 +709,6 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo HP_B160L_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("B160L"),
-    .parent = TYPE_MACHINE,
-    .class_init = HP_B160L_machine_init_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_NMI },
-        { }
-    },
-};
-
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -745,20 +735,24 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo HP_C3700_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("C3700"),
-    .parent = TYPE_MACHINE,
-    .class_init = HP_C3700_machine_init_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_NMI },
-        { }
+static const TypeInfo hppa_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("B160L"),
+        .parent = TYPE_MACHINE,
+        .class_init = HP_B160L_machine_init_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_NMI },
+            { }
+        },
+    }, {
+        .name = MACHINE_TYPE_NAME("C3700"),
+        .parent = TYPE_MACHINE,
+        .class_init = HP_C3700_machine_init_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_NMI },
+            { }
+        },
     },
 };
 
-static void hppa_machine_init_register_types(void)
-{
-    type_register_static(&HP_B160L_machine_init_typeinfo);
-    type_register_static(&HP_C3700_machine_init_typeinfo);
-}
-
-type_init(hppa_machine_init_register_types)
+DEFINE_TYPES(hppa_machine_types)
-- 
2.51.0


