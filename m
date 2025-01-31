Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7715BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFN-0004WN-7g; Fri, 31 Jan 2025 16:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEi-0003MO-16
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:36 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEg-0007yw-Fg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:35 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab6fb2940d4so249574766b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738357652; x=1738962452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAxgMccAKNQBSKmFJ6B7KReCWa28c3YSMMPb7G/6Mi8=;
 b=jmCRe/jrlnefXi65wsgnrJeI+OLMes6wplWT2HAUaYMSfNoUXiCzpncSOsliuLc+iK
 Rc9dDNHLhKXCb8D3TxAefDnOSQcHTQClxJmw3jd92Oyb4abT6q5W9zyQHn76KUAHZReE
 EcfuCxo21Nu/igEIBpBvLPRUXaHCgyc0gUPcZt1rzWKqxQT1QEvA2xqu3LMkQ3P+JFlr
 72qWSC1sn/vypyO0fP7tnvmI5s9xrtkrs+pfBnj4+uMTkcaWPrgFbH2N+LgMYvhXWoiZ
 X7P1RL4j5tRPbssdWquId2aiavypmQ1MbgxaPLuDzEV86P3H8DHCJ2LzY5h6BJFecW/i
 6OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357652; x=1738962452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAxgMccAKNQBSKmFJ6B7KReCWa28c3YSMMPb7G/6Mi8=;
 b=OnUjlTXMbTODVlfHVHLM33JQx27RQrKl6SW6dKVYUoH51p6U3VGirKwjDkBCHy4wuy
 pYLKCb9HQ4swIXRExT4FxBxcQW62JLbkpe+xe7pgFemUuDMBA4s/hWr/bddlmejiFkiD
 W/6XrzhFfxzu+REebxXNS2kWHyA8ozVDJBiWDzK5mREKgnCZ1FdQ4ZKvyv3dw2g1qeC6
 EF9sMk04gVKaAgwEKa2R0NVez2r/Ft5g2MdqyOoktGP1EUDm0vze/wEoZ6+3b+qoTA+o
 aaPfETTcprLSbeHjWjbsjkLNKFWeHGIW9c1gBGoSvbJo1dtX7NeWD6MPMWHaDxMMVb5o
 L52A==
X-Gm-Message-State: AOJu0YxDr8jrMUCUf0me3MoeRvyv/62YGhUY4chX1OytDBAF2aREYP4T
 wUQmRAWquT3WaDLdwo3CbdF+x9Ru7OsTbiyifYbB/ywv0eAvgGqAzmN5XA==
X-Gm-Gg: ASbGncsKsXlc3hLPM5Np+AYhJWrPCp95XxK+VXX9rffVpHZ6upIL6hwIft3VlS3FZPp
 1hNfw3Qxd54n0I/EjUyHUZOgohyRMrS+ELYpdT4dXETbyBNnWOlh+3ifp7bh752qQBNdtrlv4CT
 jVzyyL/knmvWf5EftcxeWQDKCS61JhdNVaRivp1lf/fNYkdz0d3oduJ9y/9uHd+pNU9ondU810G
 qqcAI98iatwd/ZosrhciW/sJ0lmqNU/MrLJJeP+3UZrFZqy8Koc9JaDX0L+ms4KxPvbZATY61gw
 q/Jf0fw/RKk=
X-Google-Smtp-Source: AGHT+IFHNLIbIlNPVeE7/CWgy7DSofk+5tnWE39IVhCWcwXoBpZKaDFp3rm8iUt7NUdxa2tOLz67zg==
X-Received: by 2002:a17:907:9412:b0:ab6:f140:1668 with SMTP id
 a640c23a62f3a-ab6f1401c4emr888951066b.7.1738357652389; 
 Fri, 31 Jan 2025 13:07:32 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a31624sm347719666b.142.2025.01.31.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 13:07:32 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Luke Craig <luke.craig@mit.edu>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v3 3/3] plugins: extend insn test for new convenience functions
Date: Fri, 31 Jan 2025 16:07:24 -0500
Message-Id: <20250131210724.3330110-4-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131210724.3330110-1-lacraig3@gmail.com>
References: <20250131210724.3330110-1-lacraig3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=lacraig3@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Luke Craig <luke.craig@mit.edu>

Signed-off-by: Luke Craig <lacraig3@gmail.com>
---
 tests/tcg/plugins/insn.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..5974e9d6e6 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -142,6 +142,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
     size_t i;
+    size_t tb_size = 0;
+    struct qemu_plugin_insn *last;
 
     for (i = 0; i < n; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
@@ -156,6 +158,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
         if (do_size) {
             size_t sz = qemu_plugin_insn_size(insn);
+            tb_size += sz;
             if (sz > sizes->len) {
                 g_array_set_size(sizes, sz);
             }
@@ -188,6 +191,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             g_free(insn_disas);
         }
     }
+
+    last = qemu_plugin_tb_get_insn(tb, n - 1);
+    g_assert(qemu_plugin_tb_get_insn_by_vaddr(tb, qemu_plugin_insn_vaddr(last)) == last);
+
+    if (do_size){
+        g_assert(tb_size == qemu_plugin_tb_size(tb));
+    }
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
-- 
2.34.1


