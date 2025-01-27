Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3941C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 20:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcW2F-0005dB-O6; Mon, 27 Jan 2025 15:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tcVYE-0006hH-GL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:17:43 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tcVYB-0000Un-8I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 15:17:41 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467a17055e6so53725531cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738009058; x=1738613858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrPftONXk3GzsFDMQyrnwK7mxsH9D1E2c7v5NO85doA=;
 b=O70/eyY6pIDgvvZRMkovOF2cMzHUFLQKMa9LQfiEIGTJjIQDFjCUj/hyP3jWiCDMT7
 RwHn9StHyg7qqV5e2kEqvvXEh3qdKDTlUqX2MWtoy9+8vPcSETrgAIziRzAPiYGG69AP
 p+4sovpFtX0JVbQKoX8TbEKsk1Na+13dtLmFfnU98nrmH9vfbGflTCn9mFOXmlZB21HI
 aCx/8HJXdsjV/wgxPPIGmuQg9HsLykvD0l1IyVr0+ZNaKRSiLPRiq1wUkn0XQV+E64Fa
 AeKeg3Bz8cNjm2SE2b/N79XoSEaEPHP9eABo1/pnqQoEwd8gzYRFn2r1l0UZ5453NsaL
 pQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738009058; x=1738613858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrPftONXk3GzsFDMQyrnwK7mxsH9D1E2c7v5NO85doA=;
 b=tE9X5DRGwQR/i2sQoimzN6XuGAktIIgWkSGTIoCFWztDy2zLALmkqWmaoYYCFtJrmC
 q5lCuCsNzOjoKkNfxW0XLYAUoJYPv286gzToboacyVRV79IYWYU98bMg2AAqE/1wQpBK
 fayTfsX+na7va+1sUq1SAZPk/9cX89zh763Iy8QFl8HBYWfpWugBggEd35u09XbpbrG4
 Yz4kMOvMTnmG3ribLqZDExcwAmACLWHg59UPyQmrWpFJtTNDDzs00exr6kamT8EieM/Y
 fbHygegFDHNyuC+swtTMHiGwE+dYkHCFYjdskGCdvwus/GlOXP6W+00Ijl6OXXIfYaA3
 OxIQ==
X-Gm-Message-State: AOJu0YzDsHPUlDOAo+lTQbYES3/+JJnzrhPJ3qmhzNlnZuahFykusM1p
 HQvx4OD4cpK2G1lWBJGeE2cjUdB9yNuQukaTpo75UYzb0W8GTENMyhnWVtvq
X-Gm-Gg: ASbGncvBy9v+SOYTCoAFzcskvSKFc47wSu9JgqrBWkQRDhkhZmqxSevbMLEc6tvdzSf
 /21Vv0fUpN8tourFMKg3Q6UPfvTHwfNPIgbQZkDN1s8qEviZUTFkPQ08JdhpwjnzOuPWdsMf79L
 J4gFXnbyL9NWuY/F29ZsRB4pRT0UZ6sBS/Ls5yphpMS9KD82UUea4pN3LlD5HHQzJevmGzI+nWt
 DcrqKRKFO/c/EzM8MvrpFG3TOP4y3X9q3jNIKuLSNNPATAwAoeLM5dXe+KxoFWfu+JMQaWW89TX
X-Google-Smtp-Source: AGHT+IFHu7n0kzv/4FfvnulW3Q9HJrZXrs0KScjWoUJI6Hf5SwXwrrRAfEmGIB05/PdsiY90tl0sWw==
X-Received: by 2002:ac8:5ac1:0:b0:46c:7646:4a29 with SMTP id
 d75a77b69052e-46e12a8727cmr643033001cf.29.1738009057943; 
 Mon, 27 Jan 2025 12:17:37 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e668636e5sm42601081cf.4.2025.01.27.12.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 12:17:37 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH 2/2] plugin: extend API with qemu_plugin_tb_size
Date: Mon, 27 Jan 2025 15:17:34 -0500
Message-Id: <20250127201734.1769540-3-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127201734.1769540-1-lacraig3@gmail.com>
References: <20250127201734.1769540-1-lacraig3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=lacraig3@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jan 2025 15:48:33 -0500
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

---
 include/qemu/qemu-plugin.h | 10 ++++++++++
 plugins/api.c              |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index a1c478c54f..1fa656da82 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -476,6 +476,16 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
 QEMU_PLUGIN_API
 size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
 
+/**
+ * qemu_plugin_tb_size() - query helper for size of TB
+ * @tb: opaque handle to TB passed to callback
+ * 
+ * Returns: size of block in bytes
+ */
+
+QEMU_PLUGIN_API
+size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb);
+
 /**
  * qemu_plugin_tb_vaddr() - query helper for vaddr of TB start
  * @tb: opaque handle to TB passed to callback
diff --git a/plugins/api.c b/plugins/api.c
index 7ff5e1c1bd..177f0ac9b6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -241,6 +241,11 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
     return tb->n;
 }
 
+size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb){
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+    return db->size;
+}
+
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 {
     const DisasContextBase *db = tcg_ctx->plugin_db;
-- 
2.34.1


