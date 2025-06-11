Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6272DC71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 23:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPUnv-0007Zr-Cq; Wed, 11 Jun 2025 19:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUns-0007Yt-JU
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnr-0001kR-5X
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-235ef62066eso4295865ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749684258; x=1750289058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xngZvcERBrHIiDDbzOPfea5jz0IsdaSOpmqYDGzty7Y=;
 b=fYH4ZuyvMp+6cfrUs7P9kH6DNdmcb2n44wwVXcd8TQv4v+6uoR2VUH50XNfEXKPue9
 Zx7gvCIfh7GMhWvBIqDFqvk8wa+8vKmahZfG7iRDYDDpAqC3n+9/cpCWr4gSw3XijyEm
 pJ6UdUmsIqOD/BppeKXlfxS7VnaFMaTPldKrxlSgkrCYnT3Y0nFoPJ1C7+V0ldws8U9h
 eSKs+k65QAd1jCZUjl5a2E+oi2HpMf06U+h+e60khCgFic2tPxHYoRlDdcQOwH5SbUo1
 InysKnAtTiVqhNA2dpE9r32vlP+Wz5A7Vi3QWFLsp4PyfcHyu1kAQWpFDgebW6kwegox
 zYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749684258; x=1750289058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xngZvcERBrHIiDDbzOPfea5jz0IsdaSOpmqYDGzty7Y=;
 b=UIAZ8sCBiOBBRCLlukIcWa+b4LvQtT63FEOv3iMxWSnnamgaKKTQU4bv9l5Q3UG7lm
 3S21mQBAdtD1RepOFXbGTRkpM77oq4QaElzG8bgEVmh5GpmoNAOHGejjkT9sUMBtAg3T
 ReJ+1sDGiJALMSoWbY3rQfyfjfHhJQo7a/XAJYWA+mDYzS+7C05/+zHhQdtBDMXO7Ksq
 u7DzUHZ3ZCuclsn3gzD/uojZwPhBTvezF7vK7WQktDt6IpI7JmmRF8L6pkSpYeQXTGgm
 Dc5Rjf4ivWzMdmFh2F50tyjtg/d/CSTIF9KX0MAZK5DXNBPLHB0/fzdSJHkluSOe8p4Y
 KaZA==
X-Gm-Message-State: AOJu0YyJMc9sgOKfeSfg5b4flQEcZ/B12yKgifx1h8l+HxJQSljQ5T0A
 bK850MXFLjBRbdSIwqNuyBRaYwBXmqSvVfYzd99f5nVRZ3nmJVuAn80Q22lNWgFN
X-Gm-Gg: ASbGncsaiBwLUMxIDrwH7hOTGDnawM5uazTTTmsez6BN9fOJazrFOrLLOM9kv4e8Se0
 /x4q59b7BcwWpCiCqeLZ+O4zHbSjxmZQcrIp1qxvQ99TZdolwoGBtjxREuN+vHRxKOSY92bEr9q
 IlDTcODQZy2nQHv8U2VZgYIH9q8yGgirsqzLGs9zo6mGRh9ji4CXqAKxHZZ10puRS4mpytN7/IY
 n5T4hxNijqEwaJGByIZAYsa5Q7foJVaZ67hK6BrNk9FVgi7DGiYmrRLHUwLt/TUs/eaZnMq+R6+
 HjBaggRZqOMnHm1onr4fFH5yJGO4Wi7XsV3qp2YklACiPrgrjwJVMsNO6AebtA==
X-Google-Smtp-Source: AGHT+IE3+b08fb7YySx6E+o9nkWmxNrxjn6KwtjxZ/DU65+zguF6DWniaUjiD7ChfnyRHzNjA5wVQQ==
X-Received: by 2002:a17:902:f70d:b0:234:8c3d:2912 with SMTP id
 d9443c01a7336-23641aa226cmr74100945ad.11.1749684257665; 
 Wed, 11 Jun 2025 16:24:17 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e6d9c86sm1220295ad.101.2025.06.11.16.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 16:24:17 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v12 7/7] plugins: Update plugin version and add notes
Date: Wed, 11 Jun 2025 16:24:09 -0700
Message-ID: <20250611232409.2936521-8-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x633.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


