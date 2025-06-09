Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEF9C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKr-0007Kd-Lj; Mon, 09 Jun 2025 15:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKa-0007Ec-9l
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKY-0004E4-Lg
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so3270235b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497929; x=1750102729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaQPhhHbCamu4uXY+C/FHHXcY6DZYaSMK3JVJyC1xcc=;
 b=KKw2SpxKuOnme5pJdZgtWYiRbTt3gHCbAhI0bgVQzy4ZpJ5RsCM3pYfVTgSvUhfKR5
 sZLzEf9MlhJsUM5CyE9gkzamxsOAI/jz4pIRSVaRx9rUneNW+/9vDopC/81UZy3db2zj
 7V1Z5bZtcQBzvCgMmE5GubXZTNgw/m2BMpyjYaRFAL4kxs3htKkENe0Y9ENQRzBWbGyl
 qenljlQAbZEZr7bAkxdmqQGuq6xyh9G8aRBvQAXKJOB333cqKCE6CIguWfGSm4SJmE0R
 1lcJe1bvLt86wbMalzjZJnxuYQ9caUeBC2ANNW64YbydOlM34MstBjcARDGwZceh4IhV
 qcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497929; x=1750102729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaQPhhHbCamu4uXY+C/FHHXcY6DZYaSMK3JVJyC1xcc=;
 b=X9YjLo//24CxrNL0l/AitTODUlLkNkhCL0r0/2loobFfy877TPsYn8TrVj+Rh4lDLw
 F4TiKJk+bLOd/c2eU9OoVvaEiysFoX5RUgmySaL/HyWHL07VOn/v/o8TLU/j3+W5sKp3
 x2O7/e3YxORfB6BpWl25N9ge1AZyrt/BCECRVUJ4Rm0MmzF5hL9xJP7UnQOFUP2MDIBH
 6H/WO9lbaaRU4yXBqTFM2S8YZS9KspbrWqy+y1cBLUCYeQofDggHfMexM36ObByutCIw
 QEpfnBO/MiXKmiizZIHqbfBcZCGDSs7ZzonP48+3EaPOES24aLyQwrJtNVhEfJv52MwY
 2fXg==
X-Gm-Message-State: AOJu0Yzllo+xbARShFJT8/71bgd63C+Ravo1snIrhQMbw3JSzaw+9Jf5
 +e1ElYTh90VDautUYXza5/KyGVhLz1dyVvU4iQyA7P28lx0Q3uBooUkzSDIEcYKg
X-Gm-Gg: ASbGncvoCotIYEf/9wQd4W3nfEZJkdnbnx5YzbPdh5CYCleK4SgAFhG3qn2GfwvYLtI
 wKvIYa1Bkb24AyiwJAW5YCkHD+blEN4g+5wFhmJ4O1+aRSthwUnRRLahjwynGYMTBWfQ4+fg39Y
 LBdZBnstdFIl5Aa9cCYZeeuOesQ/5OsXvmtNxKMH/G6LSRTj02oRgbkSYQ0ycZBYPeqJh5+G6hQ
 Dk6VIVHO2Zg5SczmuvGWaseIWsiHb/ZxBgatC4qshD0ZkuX3ZoXjCiCNyPKvX3RJR957Pq0F2yW
 SuBR0yx48xUoHg65n4t6sGa2iZwlvTL5X0YLLj/2DnGgclWp+Jc=
X-Google-Smtp-Source: AGHT+IHLnBs72YctJJ/JjakmLtFg+rXBlSlZLY1hfg51kulZvo75XuDB65fWcPdrSgCGRyLh6eBWZg==
X-Received: by 2002:a05:6a00:2d28:b0:740:6f69:8d94 with SMTP id
 d2e1a72fcca58-74827cffd46mr22021856b3a.0.1749497928741; 
 Mon, 09 Jun 2025 12:38:48 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083b03sm6095725b3a.83.2025.06.09.12.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:38:48 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v11 8/8] plugins: Update plugin version and add notes
Date: Mon,  9 Jun 2025 12:38:41 -0700
Message-ID: <20250609193841.348076-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609193841.348076-1-rowanbhart@gmail.com>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x436.google.com
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
index 5eecdccc67..c450106af1 100644
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


