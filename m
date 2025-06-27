Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDAEC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DJ-0005K9-Fh; Fri, 27 Jun 2025 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7DB-0005Dd-Sa
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D4-0007BW-4b
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so11134335e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023527; x=1751628327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Pd1RtgwCrG+l//FG3lAy5+Wn22Yz3H9EAA5DA65uK0=;
 b=ndlTQTV7pNvgpQmt9BolABFa5rbXZI/z7qBPJxCSmywGijwQRgrXYnQp1LTNSq69Ji
 jWFd5isZcNwNrjhjHEWavUVCxlnl0mHgQsJPVd4qI/uMFfUDrV1UnHdwTJSy/Cj36MXP
 SFOKVhXaNif7NI9XBOFdPwHQlK7xTMmeUbT0CUx2pnAxnZuELOJwSh2SqP2r6yTOvVlQ
 aLVvDrdIodrUMpn4rJ6rLnohWvtqL1JNlmKTAQkG1h6yDjaNVPDOOMX48lciZQUjc38E
 U3qC2UmgrUBxdqbrIdNCn0giZ6seI7EkbN2fCc5Z9VLX+BCGSjv3nidlasf3jbMsZq9C
 ot9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023527; x=1751628327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Pd1RtgwCrG+l//FG3lAy5+Wn22Yz3H9EAA5DA65uK0=;
 b=JCiB40vgKKyG9erjsL/W6eJn59DcXFnXj18CahsKeLD2mxeXiUB5i3UiP+3td7pmzk
 3XsBqhBfigt2ayaoIlQyhm2FvVhT9ajbbphGs7OrV1/MRTeufA1laQlaVRig+J8Mpg5f
 vy77Ae8xgFJP3Czj8G9jNabuoZQUGni7GmdyqBICGfSAgzEGQ+pZdQTaz+Y3RAJR3Pgw
 3629DfnUe8EA3RXuZ45zHC6m36Vsedu2Wdmv33VQPnzFL3HJ8VSupLeXj2BZ83YJUTS6
 bgNaGDw1RV6W5ATnZ2Z8PQ1aEueSlSKQ4zWc5gL6fZD1bfs/RVtPPZehOtQU/CSE5Fa2
 1p/Q==
X-Gm-Message-State: AOJu0YyyA4ixN9nwt3DY9SkHxYpZvoOKC/0NxOf8nyMPWjCm8ScgAg+K
 dJbpGjAkorn6ESevg8pMyCKkL4KEr+Itc3Dmb4reL0nhSJQbdja9SOYYUIamFcfe8qg=
X-Gm-Gg: ASbGncu695XLfboSNH25oMdHrmHbl244YCS7I6sAykmMhHIJKNIZx1P0EmfpTjw2oBS
 Mxe1qA5fSQXSa+YGNfXxVpiWFAXSg+r2lVXyeZBXsQthNZKw8VqPJvtbz6mDTV6n3KygWduDjfm
 TK/13jNgx+hEjC0MDUz8qQ83aRFmObpXVbLaT0jMHxReUCEACL84CilCJ05DvHMPmwObFDrswlP
 wiscmVd5rLDcxTadMJ/ny1b1e4AHlQp/VLSSMzvS8uGk4Lg5VsmHYml1DELtgiFwUgSR9UBWpmy
 EzSnToz5cDhgDucfKx0WK29Hja+f1HEB9KOuGtjQ5B7rdRx8zYnXWVJsZLUvg+A=
X-Google-Smtp-Source: AGHT+IGI50QcJFlh3SbYPz0r/5GDHEhZSYpu/0k6p5YxZZZqqIN3/4FtwsI0M+Seu9z8EvJ7TCJNDg==
X-Received: by 2002:a05:6000:196a:b0:3a4:f975:30f7 with SMTP id
 ffacd0b85a97d-3a900854644mr2640802f8f.56.1751023526698; 
 Fri, 27 Jun 2025 04:25:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7524sm2482131f8f.12.2025.06.27.04.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 659D55F915;
 Fri, 27 Jun 2025 12:25:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 12/15] plugins: Update plugin version and add notes
Date: Fri, 27 Jun 2025 12:25:08 +0100
Message-ID: <20250627112512.1880708-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-9-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.2


