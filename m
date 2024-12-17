Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823FCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3Z-0008FM-1H; Mon, 16 Dec 2024 20:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3X-0008EY-BM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:23 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3V-0004wq-E4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:23 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-725dc290c00so4462902b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397640; x=1735002440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71S+eNcZf7pM/na7HmYGPvv/ip7o5rdNjP1L6odqfR8=;
 b=Quf0Ud2MqezhHoFIGSUpiAGM3YzC+xhikm42h8KKcS/D49EXK8JBY8N2TRSm/ZsP6i
 GHQx9UrnFGFWFxDIiyoE8fcuxHEjG1DrVFelFy8GRImJx49TnOnYPjEmXgwNryh60S7b
 +8KWpRUNv1RHwzQPB5lUlrU797OoPcJTit24q36Qkbw+jSStV8M1OEYXGdjXNzukmlA2
 Tb88dBme8fa55oWkWjApM/2l1LgnjjQh7XhNnNVYj4hGMOz76pTCPMkRCYpsPqByu+t7
 VIPYyjluVyrQxL6uViFpyAbmdLa9Dfj129J0yPq2wVXUWxNY51ErSxI8VGhSXl9fPlsS
 UUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397640; x=1735002440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71S+eNcZf7pM/na7HmYGPvv/ip7o5rdNjP1L6odqfR8=;
 b=pdk93qLxB7E6E/7kPGniu4SF/29gL6HpF92dSm0mhJkHWRaaQQZeOHgFCHEaG0I2jp
 /lzt5YxTg4FQtmsJojNhe+O1AbU0fs8FFjdGa5UmlWotYBj5Nx9HKmRFBy8Hi6ZabOWl
 0yCUaClkpspAQ0UqC423T5eJK22jBwPZfFCJMMJefrSZ1jvDDirf9inhKaidClejl8k+
 DeDHePfnRHqDQTjRpIAu+zLB786DlTG7IPxNuUhLvddRR/1zMLAoKR51+dkUfKDaK0Pr
 p+y7zc4Aeu6LF06jpz/r86j0ojYrj1+893RPgeKsAWtLZCBHS7DGvl7nEe0AAoAMcbKc
 Djdw==
X-Gm-Message-State: AOJu0Yyv6kXoczM5ckbsB37cbn5NBuf7rv/eBlaGsKnnVCmcpK9JBhMy
 TlNbnlFjefqqHqhJUT8VULLbTbTwpyZJWNuVtcjl4jCvzs6RazeKEvHHSSBwOjoiD3aVujlS9h5
 DC90=
X-Gm-Gg: ASbGncvC3j9xT5avCztwGDGM1K3b0CljuJOskcqOPnnlUuvSlhPPOue6Y94oZ9uFe26
 9PrOIxJbRnx/psJFbVYr9J4bhMkluxz0qSk2Mu7YlE3xl+8dM/9wTkezjhs4NIzhIoW8MajAtna
 hZdnooUqRh8pxqEoENM9rX9oMU4yO6W6tPxmVxAZowWL5JMM1rzdtf22CQRRN8XTJAp6JK+VlS7
 e58nzb98BhB9+1Q5jRUKt/O8MruZkjzYabF34o9kRvCuN0fllQ4Jm/Lj0kj3weElWO6rClyrHAC
 L5nwmGbZVkOovMk=
X-Google-Smtp-Source: AGHT+IEtIZcfnSxoQHgZorNa3YMvfu/h2xUJZkwNswZw6HhCeJHrbIVAiIF0ZXmMAinvorm8IlrT5A==
X-Received: by 2002:a17:902:e852:b0:215:58be:334e with SMTP id
 d9443c01a7336-218c92136edmr17023625ad.10.1734397639895; 
 Mon, 16 Dec 2024 17:07:19 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 02/13] plugins: bump API version
Date: Mon, 16 Dec 2024 17:06:56 -0800
Message-Id: <20241217010707.2557258-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 6 +++++-
 plugins/plugin.h           | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 1fbcff6e1d2..a611f912139 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,15 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - change signature of qemu_plugin_insn_haddr to return uint64_t instead of
+ *   void *.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 30e2299a54d..b83c44fda64 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -15,7 +15,7 @@
 #include <gmodule.h>
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 2
+#define QEMU_PLUGIN_MIN_VERSION 5
 
 /* global state */
 struct qemu_plugin_state {
-- 
2.39.5


