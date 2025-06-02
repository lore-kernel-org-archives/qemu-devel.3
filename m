Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CFEC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyeA-0003uj-0w; Mon, 02 Jun 2025 02:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLX-0006du-8l
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLT-000276-7X
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2975454b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844504; x=1749449304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=UHdTduXIYYtuMt4Wjw05lttAyOMHaTqQ206d1a9VCgqN066wVrpOBCCnjzElD7UPbC
 wHVQolSoqBp8zfQZaWgbxeIlhQ15ESQ5xvbZkXlRrowtxQUfDIDznCcWlkcTbw+xELX3
 xm7ogQnNKYp6xBDxQT0K7QfowYoFfMQmtFO8Co2oey4zkyo0JDtMlw4DbZlEOGn1onJB
 /hNqt5JY5AsWiicOlU7UFA73EXVxG3IlTNI7UdFTEEIOqt8NxPBCRjYoeDwi9fW3wvlh
 1ex5Q1IQLmO4jbe2O4rOPSn/5KUbNZ6Va41SgS1sIkLwyDQ5FMhjkJ6xCSQNWweZTrmq
 hsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844504; x=1749449304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=i43RKEi6GyvTxMpGpxwtzzwyLiCA3w5TLc3iRI4eDuDCthKnUdFSU6LSEI4+acgpm7
 1UtdXYd5uyYg/FLZShisXedSByt3qrW6PqrsrP3MkMiHG364Heu1Vxtn1fGrYlxwBswh
 uwK0qSlGGQ07CLIySf4tPB889owRtWItUr/k6HBU80ipw0yGUrGLjlxuMMKQ3cBs0X1e
 oemPk2Tc9YjS75HJHqGAhTkGKV80seAJ6QgGlsfOLGs1O4a4cXdMmYltauYYRI/fvuaL
 dayMoLE1lUJ/si/Kt974egCE/WAiVnMWYOnqI+CjRmGmkXd2wzagFbzn9+rQM3+HBG/E
 UR0A==
X-Gm-Message-State: AOJu0YzfqDvbv4PrGUDKaeANtub8YBwG2+sKAe7B9H7Nle2lrQKfM9LL
 Kla0TV328Kj/aUaPpyfg1KMJtlTn5bx7f2LIPSqetTP9kCHvwfZtfse1U2AnlD9efHM=
X-Gm-Gg: ASbGnctg96j1Lbz/VfW+vHeAt75aMzfvT7d7tREWl3nPLnDSG+tvEurp00qxHKAwu4P
 mCgB2jLjHIH3m9v5cLF08GSl+MOI4y/QMaBBPm+OFZMLVWP0va3dprOyJyWzmtbQbjjXcWleEhW
 QiCpva7POsUDvbrmJAN+YJE6XVismwokWm1vqmH7xBev+JY/yZOdAzEcqAnXAXuImyquOruYK1B
 CNkRnfIUg3aJozwgw+yYgP2OCOi5d7k9EKGBgS8WJckBBlqBbyp4e6fO/1QKlpGvKD3rhmLw1D5
 PeElufPyRNkC1Z0mvkopIJ9FkI9LuK5RbVO1aVN8WRe8dw9A1dol9aDo+crCKQ==
X-Google-Smtp-Source: AGHT+IFsCd60MwQlPSbPE9zoGjSZbhQGbyvtTMVn8TBg0/D8U05PQj6vdkRIGuGVLQlXFmKTnPllaw==
X-Received: by 2002:a05:6a00:b44:b0:740:9abe:4d94 with SMTP id
 d2e1a72fcca58-747d1ae068fmr10176403b3a.21.1748844504393; 
 Sun, 01 Jun 2025 23:08:24 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:24 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v6 9/9] plugins: Update plugin version and add notes
Date: Sun,  1 Jun 2025 23:08:15 -0700
Message-ID: <20250602060815.328261-10-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 2cb5de9f64..170a79e667 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


