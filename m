Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA150C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyF9-00041H-3k; Fri, 31 Jan 2025 16:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEg-0003F3-BQ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:34 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lacraig3@gmail.com>)
 id 1tdyEe-0007ya-RO
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:34 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso530152066b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738357651; x=1738962451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOiwNYhDbwze8gvC4dinwCwNJ6c5NfBut9RqtRXEoZg=;
 b=M2gE1u/E5yQ4fuX45Vbkh6mO7A/btW3RQyUP8+snnZtk49UdjaI8ImkCh/O00gJPFE
 BVRhoFG/UxqjpT/wlBNU1pR5ZK+gGvcmKH+k1R0LF8dcI6F98cUqZ/RNjNm5zikqNCr1
 GmxrZrcCsdUxpxHMn8GX71PX0fGKepnzLl48tFCwncV4VUrpYTbb/H1LaFzZ74TYA3mk
 z6EHEw38+1NmlACChWDdNxNBx9sNySoM0ejozt86kky0jop4B+L736YCRjJLReR88RSu
 BzYucbexjwn2qNtETQKnNGkzpga8dQ7xMJRI7DHjiTYYJgRzxxx+90w+QA/s/PiEgxAA
 qeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357651; x=1738962451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOiwNYhDbwze8gvC4dinwCwNJ6c5NfBut9RqtRXEoZg=;
 b=Im4IwsAuTq2IfYCngF1Z9gUJXJetlvMeZ4WK2OXrdbRFmeVdB9dRA5pcnC4lCv/kNe
 EJDVfRcqZqXXyatbZvxs/XM4RMlARCHnDsSR64rWzkDPwpRPf1VDVJtwLnkhRoLCCpEN
 mTOA+281L9tu5QympPPyIaQLKPlfdbl9BGFBJ2sraF/+6BeOJ/no9dgveqbnyU7iQ/ci
 C9EsUvhn/shgv9JdAXxtLZjsOVqxvqJrj2mqsTM/RPAg50p6Rkra2clIczSbpnRxJYEY
 zzUkpteiDJMuwVSTcCY8QzOjY5fNa+Uw5pOsIMnDqlXgh0X4ehYYhXORk0xa0Wwwky1Z
 ++cA==
X-Gm-Message-State: AOJu0YwK+X9g8e6FGlvE9DWb60qrtHB3TydN/IgFWos4ROUjA6wPawEb
 A1u2w/BRk80/hqgkyW5KWTW/MU9gmmUc+o8kYvFfqYeCpZwlBXE77nyBqA==
X-Gm-Gg: ASbGncuTmuhufQkwtuo5asFbHsaJjW813a1UyARlteg7ljy5WYKn7/a4C7Wm19eKVIQ
 y7lw6eJ+/L5tK4508z3RO0IKAxLUOkDxfzoIlPl1L+U7F9CBxS1+I2hqq9Xfjd31w2bCxxPqllA
 iBtAePKTt8dz0aj2B0gHTh/n5VwuQjNeySO498ZYLhlEAJBzrsNuyY47+f5gLJPO4PCVquJVggl
 FqxzIYz+QYJ+JYIs8Uudlke4Lt8u9jINYnxCYnuMVGyaAZR2teDWJqbftLSW0xkx/9/h9LdCnZp
 TMSU9Mhv6n4=
X-Google-Smtp-Source: AGHT+IGK0o2EFZV2uelWHTqvTwMGAWgr5/ThhWq+g9nf5kNDLsjXsnMqgff/WFfW/bJnNNA6WjOizQ==
X-Received: by 2002:a17:907:6d1f:b0:ab6:f06b:4a26 with SMTP id
 a640c23a62f3a-ab6f06b4c6fmr770176566b.34.1738357650802; 
 Fri, 31 Jan 2025 13:07:30 -0800 (PST)
Received: from luke-igloo.. ([18.4.85.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a31624sm347719666b.142.2025.01.31.13.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 13:07:30 -0800 (PST)
From: Luke Craig <lacraig3@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Luke Craig <lacraig3@gmail.com>
Subject: [PATCH v3 2/3] plugin: extend API with qemu_plugin_tb_size
Date: Fri, 31 Jan 2025 16:07:23 -0500
Message-Id: <20250131210724.3330110-3-lacraig3@gmail.com>
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

Signed-off-by: Luke Craig <lacraig3@gmail.com>
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


