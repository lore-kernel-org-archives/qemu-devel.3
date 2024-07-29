Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00651C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRcE-0005Lc-01; Mon, 29 Jul 2024 10:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRcC-00059h-Cd
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:44 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbx-0008T6-OZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:44 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ef2d582e31so43256691fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264267; x=1722869067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I0UyAB3UWkIb2mikOF5Y9Vqa9qt5KlackYDMoOxLtQ=;
 b=sG1vEoLA2oL9obrMh0u1O9ESES+2c28ICDgmpokytLO7Btls7/4bf7ufsomDqX7FNT
 rWFwZ15lHEsZ9zEEaIp0hnuw1tX9fso+amNLUAbUr7rq4s0Z6F0OAa9JNJc497BkZE8n
 1aGjiP064JxTrCWUkaeKEF/60G0h2/13c4wfApbs5/Ez5ksaTfdh08KD7nmNK2cWCDK8
 CLPr0Qt32pcYGWE7sZomFX3+MFOebfETJABkZJTbTDrvivbRrBtHEkDq1yH72h3lnMXP
 rQ/2TH6qJHo6RNKs/2lwNiRgi4IyrWHHKRn+s/1nVLQ2Md8YycHSBNCZnJPTmWI0REuB
 rXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264267; x=1722869067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4I0UyAB3UWkIb2mikOF5Y9Vqa9qt5KlackYDMoOxLtQ=;
 b=Qv59pi2DU1SEM6HPH6epFoh2Vh1V/5pnn3Fpieb53Z8/eaXbW++P6Eu2q9YORRnLbm
 PHNZgpefn2kfqtui3r1b2w4rn6YepOBK2eBiAQ/GNzJrzr2hqFNmBvVEuaQ6Ld8BmcUu
 I0HhdlDSR+iY/SVOOjuJaDYk0hn8gqTrgpkoNmNqy63UW7rZMrVau1wzTITVZtIlJ2Jo
 yDcos5qY1R03xIfE1NvL41uHXaflTqSXQnJzVwOiaERQ3Sj0cWhsspSlQ07SPeCeMVNX
 SkoEuJt5k+SK+GUcR3wuj4KPwuCObTFczYiEMr4h3rlMhd9K4Eq/yiRftpRIFNdPnSFq
 IJGQ==
X-Gm-Message-State: AOJu0YzEH98twn2LWbnh9xReLW6AK43j4XO4/Q/yiYSTMSYJp0scG4iX
 TdQR7cIig58NM0dwAp+av/nw87txi5fCeIo1JdPAbQwntqB59x5294Bniy8E5hY=
X-Google-Smtp-Source: AGHT+IFl4LCULlJKEByDcLtWCZgItRAwJArV3m4eNczbzVK0sd35IGpGBF3Tkz0ksybl+CJB4WXE/g==
X-Received: by 2002:a05:651c:1541:b0:2ef:2d6e:58fe with SMTP id
 38308e7fff4ca-2f12ee55aabmr58999511fa.32.1722264266422; 
 Mon, 29 Jul 2024 07:44:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3980sm5826419a12.60.2024.07.29.07.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BB2B5FA13;
 Mon, 29 Jul 2024 15:44:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 13/14] contrib/plugins: add compat for g_memdup2
Date: Mon, 29 Jul 2024 15:44:13 +0100
Message-Id: <20240729144414.830369-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We were premature if bumping this because some of our builds are still
on older glibs. Just copy the compat handler for now and we can remove
it later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: ee293103b0 (plugins: update lockstep to use g_memdup2)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2161
---
 contrib/plugins/lockstep.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 6a7e9bbb39..62981d4e09 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -101,6 +101,31 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     plugin_cleanup(id);
 }
 
+/*
+ * g_memdup has been deprecated in Glib since 2.68 and
+ * will complain about it if you try to use it. However until
+ * glib_req_ver for QEMU is bumped we make a copy of the glib-compat
+ * handler.
+ */
+static inline gpointer g_memdup2_qemu(gconstpointer mem, gsize byte_size)
+{
+#if GLIB_CHECK_VERSION(2, 68, 0)
+    return g_memdup2(mem, byte_size);
+#else
+    gpointer new_mem;
+
+    if (mem && byte_size != 0) {
+        new_mem = g_malloc(byte_size);
+        memcpy(new_mem, mem, byte_size);
+    } else {
+        new_mem = NULL;
+    }
+
+    return new_mem;
+#endif
+}
+#define g_memdup2(m, s) g_memdup2_qemu(m, s)
+
 static void report_divergance(ExecState *us, ExecState *them)
 {
     DivergeState divrec = { log, 0 };
-- 
2.39.2


