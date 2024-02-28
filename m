Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FE9C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIYz-00064h-D0; Wed, 28 Feb 2024 06:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYv-000607-1L
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYm-0005me-IZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412b41a1294so4052685e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121435; x=1709726235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qW+nKetcRkdRlQHCRkk2cCjPEjxiMk24CyxL/Jk2Csc=;
 b=c8zGHcdbjr1R0E1uK8cDFQty5RDs+AiBtegyqngFSNz8dYJmHxG2IcBBhLTG0amSZu
 Dc+AANi7quOgZ+OZNDZSIwDFSsiekD3lIxE+nlVoJFmPvqE0PkH5/maeBiNdWDJXHaMB
 jbFfl6Ton5xiNWOtWdrHNjVQanuXixwNtpFdNlxnWd1zXEkjhobSp310BjFZbMfDoW+C
 RscvGNXpp+63y9/ikrfHw87PJkLHF7epIex8DPKmN8BECyObhX0HMdqbCcOxQI+Y7kCo
 G86Wc0P36Hxc7DMUEWRCWVdTz5W7jYs0oeHP9peDnxO2XyXewxlwSGO1yG69Q8xQrXHa
 RVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121435; x=1709726235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qW+nKetcRkdRlQHCRkk2cCjPEjxiMk24CyxL/Jk2Csc=;
 b=IjabVp78fgJeNvKPiJpPhIC+0kKUGs3bZV83aECSygbGyB2CfXL7GNu6WjR6aXuWtO
 kW55JPblzgIsl42zHDNAEzZCeBHZl2znwP13QAOMy5JW1sjhY+hWs8LncZSmlbUnxQiM
 L4UiASHF4FzKJszRf9CV4WqQeNA3QOxTFmdwci/wgUHnrvSkgso7Z0iYY11NW2rM2Z9U
 hsHtfPvM6SA/oXWKiBSn/E3XKgx85Xlowh2Y49fpWr75XbGM7Ofqu8ioybUHueuJlc6K
 /CsDcVgVUQ/jBz0nnl5ODrjulrNeyj76cnGZjjKMmwFBwFWCtKMltV2YP7VK0MPraaj1
 zOvQ==
X-Gm-Message-State: AOJu0YyU/HRAdRNp8+rPdA4FNOKtRzS589Yx0cSnQnJ+M48g0aZD8HLM
 8BksWz8XAD0rjWnGWHm15UkcSW9QoIbjVKGSzqaTUnYeKwlLgGfJCnsc65wjh2U=
X-Google-Smtp-Source: AGHT+IHoQDDVsuykLT2jifs18DwZKkR5dWr8W+UfJYWlBMqfsspSquUG1QeC9vSGfY/hQVsl2BMYGA==
X-Received: by 2002:a05:600c:4202:b0:411:e2bf:73b9 with SMTP id
 x2-20020a05600c420200b00411e2bf73b9mr8189620wmh.39.1709121435246; 
 Wed, 28 Feb 2024 03:57:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c4f8600b0041273fc463csm1910772wmq.17.2024.02.28.03.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B95645F909;
 Wed, 28 Feb 2024 11:57:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/29] gdbstub: Use GDBFeature for GDBRegisterState
Date: Wed, 28 Feb 2024 11:56:41 +0000
Message-Id: <20240228115701.1416107-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Simplify GDBRegisterState by replacing num_regs and xml members with
one member that points to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231213-gdb-v17-5-777047380591@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-10-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 256599c8dfb..0ea417b2c9a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -47,10 +47,9 @@
 
 typedef struct GDBRegisterState {
     int base_reg;
-    int num_regs;
     gdb_get_reg_cb get_reg;
     gdb_set_reg_cb set_reg;
-    const char *xml;
+    const GDBFeature *feature;
 } GDBRegisterState;
 
 GDBState gdbserver_state;
@@ -391,7 +390,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
                     g_ptr_array_add(
                         xml,
                         g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                                r->xml));
+                                                r->feature->xmlname));
                 }
             }
             g_ptr_array_add(xml, g_strdup("</target>"));
@@ -513,7 +512,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     if (cpu->gdb_regs) {
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
                 return r->get_reg(env, buf, reg - r->base_reg);
             }
         }
@@ -534,7 +533,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     if (cpu->gdb_regs) {
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
                 return r->set_reg(env, mem_buf, reg - r->base_reg);
             }
         }
@@ -553,7 +552,7 @@ void gdb_register_coprocessor(CPUState *cpu,
         for (i = 0; i < cpu->gdb_regs->len; i++) {
             /* Check for duplicates.  */
             s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (strcmp(s->xml, feature->xmlname) == 0) {
+            if (s->feature == feature) {
                 return;
             }
         }
@@ -565,10 +564,9 @@ void gdb_register_coprocessor(CPUState *cpu,
     g_array_set_size(cpu->gdb_regs, i + 1);
     s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
     s->base_reg = cpu->gdb_num_regs;
-    s->num_regs = feature->num_regs;
     s->get_reg = get_reg;
     s->set_reg = set_reg;
-    s->xml = feature->xml;
+    s->feature = feature;
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += feature->num_regs;
-- 
2.39.2


