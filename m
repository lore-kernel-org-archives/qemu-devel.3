Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F586C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 19:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBHg-0004Mq-0Z; Mon, 02 Jun 2025 15:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHa-0004LJ-D9
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHY-0004sA-Gm
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-742c2ed0fe1so4639794b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748894235; x=1749499035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=GFbqxgrzP1KceJqc0hlwobkG5lpnHwq3lQGmOtI8EhBgnLvxZSPVuI4wB9K97V8iue
 WQwJBpOw+dZtAgzKqR0y7ybiCmtAAFdzyqqTzyUUzEneVFkA808xuve5Hv1KIqUwPOPP
 99xMgsZ6zSuvRsLKNTr8XCaq2VfYogN8OG6Asdj4Hi077++4rAMdr7wDKb2RtqphJNkB
 1dMdFK/LLI2pcA0x7gXEPHIoxC7+R+GV2PoFWgLMYy8qNi67FN1cownZm5cuGwj6L/09
 k3odSeWvgIKSg9HFPTgU5xUO7FwSf1jyMd7aLawmyZQKe9GtxOeenA8E0a5cT4yyWZY1
 yO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748894235; x=1749499035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io8QAlH/AZbTYfjODl1SD6d4ZkI/a0qoPWASwOSekic=;
 b=QzHwFRn6cc4v9gCemWfO+wJ9DlAqua76/rtDHcLnseABZ8fxIIwwqs9WrTVv74Qty9
 aKTeAt+sllEM5Y0XolfPtbT3gtaAE+PYMMXU8meSecinmUXgr6Mx256JT3ZMyH7pWYvY
 CB258bxaa0IkixQBEq3cGU+najEJejq2AwIrXa1vQ8xjI7rmUCivq3RUEBG0ourxdhsW
 ZW4el1u4yFyZ2UXoks6J4mLL2rD5T3W2iB4b4Cuv/E+R4rPTn9ySJZ2AQE82xM7PhYQj
 X9ON2DDzBoxjLGnUO8VeMMDQ73QMIywOR/K+IuFNEm4eC2Mu9pnwoOhkyg2uqKsRxaKg
 99Mw==
X-Gm-Message-State: AOJu0YzxK2BAvEeirPxLbdbEc3xVjWVR4VPVWkF+no3k2TRPKc0ghgJX
 oQLtX3J4rklhFSLTfznqC7+jmibAndPiTpCYQcGd0dzz6CTTOR/F1m94ScAgDfp29eY=
X-Gm-Gg: ASbGnctGVXCmCWG+s2+d3P7UIkuuCF2Q/4GPJmogHsz9FPskGUK5KEnnOXejeD0n5OL
 aJdJJFb2SK5k4818PcYc0HUKmF9iOOCTAj8rdrWJH6j7Kshlz4lY5ZakN9DQlGkfBw+OriAbJZd
 ZJZukLfn0q03A17KZu2GWBazCNzBeE9Wr7wjO/TS99J9hYjC/qfO1VOD2+vABUK386Sr7uwukcg
 /y4Z8/CUbLuXad0/WyIYMrXLg2C+qFhEP/geNstrZluqXS11ytyuCG4evxBPRc5QqAbhz6Tg2/a
 /BBbGYUoYvhfHA0JkYSMN3phqVhmulFar195XPpG7a1r4jhYOxdIL8BFMHf+eA==
X-Google-Smtp-Source: AGHT+IFKzZtkhga61FspNICt4qR2PWgZXcJLOMzgCJYUJeZrzxM8so3TxRL119/pqNA3mnYRaYCiTg==
X-Received: by 2002:a05:6a00:18a0:b0:740:67aa:94ab with SMTP id
 d2e1a72fcca58-747bd84fae5mr19222958b3a.0.1748894234994; 
 Mon, 02 Jun 2025 12:57:14 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab820sm8244575b3a.60.2025.06.02.12.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:57:14 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v7 9/9] plugins: Update plugin version and add notes
Date: Mon,  2 Jun 2025 12:57:06 -0700
Message-ID: <20250602195706.1043662-10-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602195706.1043662-1-rowanbhart@gmail.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x433.google.com
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


