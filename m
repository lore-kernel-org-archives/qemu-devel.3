Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A493AC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvGi-0000OI-5E; Fri, 31 Jan 2025 12:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGg-0000NG-6C
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:26 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdvGe-0004TX-KP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:57:25 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab69bba49e2so338103066b.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738346243; x=1738951043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVbnKaU7RlSgIZ7qVYEauJNFrVGZ7rmvt3ZQ+hTVMow=;
 b=V4XyUTPwBb3RkUjpruB7xe6ujRgct/qSRA4NaqJTtlX8UgEEkPYsDsOnMxjumdLaT3
 TJWG/8UNfZHqIfKvfjk9i80Nvx2W8EpxKkqXipOQMPa5BK2sovP881JVKaSaJlguM3+z
 b+YMBE45Y9hFqmTmn1+LgTMfOCBOWUHKn1SokuVorFvCVBhkSbXzFYdC3vT5HklAdC/i
 pvNqkkIEBnYcQ9TfTwUenheAEyMgKOvgVHsti2rzlyK14VX8IvrzPHQeMMDYhtNndvUY
 dvDYFJTPOrB0TNWuwmJL/jcTxaj3X/w3dhKaBKj/gYwo/tiPMbacsfoHmUy5Fbgjcle5
 aYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738346243; x=1738951043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVbnKaU7RlSgIZ7qVYEauJNFrVGZ7rmvt3ZQ+hTVMow=;
 b=koJwMGNSoaU6kImFnEZeNXb/Pkkldon6FMLnQv1vvRKxU4ZWe3wElv5jUqCn/WiI24
 XV6Z405trkocvqJPtMf5mAICPyZrG+FY1Uf4/H/qhL3/gedMzHgdYUhmuL6qqV3FRb6s
 VRlo5vwTIlhXw2H9WBLYVspmFCxgQpdnF1250/B050voHtqXacfVwctUw4HxK+JUwwfY
 c9IW9QA8Y7l5fqzbutetppsUO91HAXi3bs5C5eAuCY6Ffz+b6XoV60sSiobYdhkkxREp
 wioCzMuhFWr6G1+5WgFpKn9dBwMyfk+IHCovyhbZFT2rZmHhH/wm7B7/6qg4GpBYA2Jh
 zGcg==
X-Gm-Message-State: AOJu0YzA5KCBnLeqhku20zlFXuhU601nUXFurh8Jia/3BWnoqNMD7Ye7
 zAvS6IhdAyQlnuCZZ1C9Ia7guNKhJIJBLhDmegPcnpCpTNzNHeJqj58JLg==
X-Gm-Gg: ASbGncvbjLX1pjWGTlT9WXtEqs7IGHowQb7dDmwTontIT/mUcyj/Y4157khI6L1LOTp
 xJtmUvA13OM5Nnj1STs7GDmSYO2Wb7Qj3MNYS/iDCgRu21ChX0D6veSNmKJKcvMnNGa6T3LQ7x5
 6N8mWRAdzkswrX/Ri/gCdyluu907J27vJKu2zHITqTe+hj0Ee/35DFN5FLRqwJQ4gdo2szAabPz
 0gkBDdzQvUu7dAEGYknFXNZjpebs26rkSpWgj6onjGqB0IVGiG8M1ATwy4y2Soot3AedJ+EBm+L
 ae+xscA0p/U=
X-Google-Smtp-Source: AGHT+IF2+/2pREiFDxPijy/zZiDL+9qVSY1vmDs45HbLIReTGNez3Lt4v6KO0HqkxU/Ef6WLhShtxw==
X-Received: by 2002:a05:6402:a001:b0:5dc:796f:fc86 with SMTP id
 4fb4d7f45d1cf-5dc79700476mr9506439a12.16.1738346242346; 
 Fri, 31 Jan 2025 09:57:22 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723efc45sm3110074a12.32.2025.01.31.09.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 09:57:21 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v2 2/3] plugin: extend API with qemu_plugin_tb_size
Date: Fri, 31 Jan 2025 12:57:15 -0500
Message-Id: <20250131175716.3218600-3-lacraig3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131175716.3218600-1-lacraig3@gmail.com>
References: <20250131175716.3218600-1-lacraig3@gmail.com>
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

---
 include/qemu/qemu-plugin.h | 10 ++++++++++
 plugins/api.c              |  7 +++++++
 2 files changed, 17 insertions(+)

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
index a6bd912c56..ae74668c2e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -241,6 +241,13 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
     return tb->n;
 }
 
+size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb)
+{
+    struct qemu_plugin_insn *last;
+    last = g_ptr_array_index(tb->insns, tb->n - 1);
+    return qemu_plugin_insn_vaddr(last) + qemu_plugin_insn_size(last) - qemu_plugin_tb_vaddr(tb);
+}
+
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 {
     const DisasContextBase *db = tcg_ctx->plugin_db;
-- 
2.34.1


