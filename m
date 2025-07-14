Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C2CC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubJ4l-0000Td-Mj; Mon, 14 Jul 2025 09:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtP-00076d-MR
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:48 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtK-0003rb-2z
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:46 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so754467766b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494558; x=1753099358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FH07ylFIriqs3Ta+bo0GU0IZk1KRc8iHSIoU8TNWUw=;
 b=UIEFYOWrSjMRX1P4GaKFIA6BSLQXDIif7I4gJ/TFe5ngHZbXn+vRgQtOzYbwcwEjkx
 KXe0AJ7mA9d49NqDwORnKHZ8/UGAHJcpTZ/mhdXcT0TOYqJgZwo0/XknREq9zN8qpVJH
 HlKmtxwXOVRD2Gu1zI3s4TOoxiWfAvBIcKNNivoeXzffMB/pbiIOzjlE8G6N9aZM9ROb
 kIM02qlWblsGiJDPM0lzYVmWrGpMV8C/K8Ve1dN2hJSInkdkWqp3dRkn87F46q92xYkU
 eRliEIC5lKBhwNNLpSjP3bmfIriBcUkUDpzTdXeYYL4ldHSy9AiRiS/2oRMgDRTtzrEB
 pimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494558; x=1753099358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FH07ylFIriqs3Ta+bo0GU0IZk1KRc8iHSIoU8TNWUw=;
 b=VGVtq5Po5KbPQsLkaXhIwORZvbAY2IPFDi/ISYteYAev0SZIuZxAao+WbjJY5VnDZL
 oPif88vKpmu32PZz9urHv85/nZgSyWUAU9m7v7CCQFOpgeW98ln4gdqeH6f3fEzbD7Vk
 aQK9NNWyR9CbG5t3N/reVahrXDgGFrqnzXVCMZNhW386ISbYVCJlfiMs6MO9vuiCR8yj
 1XwX0z0py/8BpTobIhHJYt6uuRkT19SwdLlTpuabnC0jx5omqc7faslSE6NrLESHIH6P
 tpFF9vPRwZ0jzz6WtnY/oCxw8wSlzirlGJSD3OSCS/AkGLMNDsuwfSGw4Y729U5lV3VI
 NTWQ==
X-Gm-Message-State: AOJu0YxpJ8ydIqnPTFpEtLUbuh6mCjXp7QmpzrX3JQo66MmnqSH+o/U9
 TOlmD044xAnknmbOPLzMwe1xtgAQ6nujY1NTtDz4kyUR/8kIk2WnVeNQcz15hcF/pcs=
X-Gm-Gg: ASbGncuq93HLTzh+Eiq7iuut4Q0Qh2KjbXFDs/K2OcOfRRqy+yV5vRatMP5l5u/mRZ+
 UdA2Zm9ZGo57MCWVToDvJFk8YYok75FSJlfpP1BRB6WOxcs0z/HNZwrMkzYmBg3yacXTH0RwUzW
 qAQ7UWiiqjsva2uD9/CCjtIbUGgpcHid6A6CqNwINkH67LX/QVtE2KCFalzkdic4Wg1s8qK/NJX
 bT7ls9p6XrXkUY6e59DZPHDZlS1SP9yiiXRQOC9jfOCMXi7zxXiSLvoIPb7JVHntMLxJF9/NWGb
 py82eUGxxhri+sOfN3a80PlIfqg54dzBEJQ3spOW/3eMlD++JqryJE90O7GIbmDHcmOAjVecXSM
 NKsK9WOimMilQzwsE/gHfnI8=
X-Google-Smtp-Source: AGHT+IFqmxUVwrCdv3YHvpI8CCpf1lbAdOOgdg5eGegOEFuQM1qn7rYvfcbzrXweYGVNmQ7azC5cfg==
X-Received: by 2002:a17:907:c885:b0:adf:f8f4:2001 with SMTP id
 a640c23a62f3a-ae6fc0da44cmr1315985766b.49.1752494557666; 
 Mon, 14 Jul 2025 05:02:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7e91bd0sm816420266b.33.2025.07.14.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F28435F8B4;
 Mon, 14 Jul 2025 13:02:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 3/8] contrib/plugins/execlog: Add tab to the separator search
 of insn_disas
Date: Mon, 14 Jul 2025 13:02:29 +0100
Message-ID: <20250714120234.1524401-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@gmail.com>

Currently, execlog searches for a space separator between the
instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
use a tab separator instead; this results in a null pointer being passed
as the haystack in g_strstr during a subsequent register search, i.e.
undefined behavior, because of a missing null check.

This patch adds tab to the separator search and a null check on the
result.

Also, an affected pointer is changed to const.

Lastly, a break statement was added to immediately terminate the
register search when a user-requested register is found in the current
instruction as a trivial optimization, because searching for the
remaining requested registers is unnecessary once one is found.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
Message-ID: <20250630164124.26315-2-yodel.eldar@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250710104531.3099313-4-alex.bennee@linaro.org>

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d67d010761..06ec76d6e9 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -232,12 +232,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          */
         if (disas_assist && rmatches) {
             check_regs_next = false;
-            gchar *args = g_strstr_len(insn_disas, -1, " ");
-            for (int n = 0; n < all_reg_names->len; n++) {
-                gchar *reg = g_ptr_array_index(all_reg_names, n);
-                if (g_strrstr(args, reg)) {
-                    check_regs_next = true;
-                    skip = false;
+            g_auto(GStrv) args = g_strsplit_set(insn_disas, " \t", 2);
+            if (args && args[1]) {
+                for (int n = 0; n < all_reg_names->len; n++) {
+                    const gchar *reg = g_ptr_array_index(all_reg_names, n);
+                    if (g_strrstr(args[1], reg)) {
+                        check_regs_next = true;
+                        skip = false;
+                        break;
+                    }
                 }
             }
         }
-- 
2.47.2


