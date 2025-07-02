Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4550C83F07
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2m-0000I3-NC; Wed, 02 Jul 2025 06:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2a-00007u-Gf
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2X-00033J-E3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3718866f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453407; x=1752058207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q++VT0w3BFey6U6AhyjA4yt6pGOWJ3/ulMKQuhSNA98=;
 b=yOIA684x3l6VLvKapzputBqtce1QnWy9/zyHSsxi2FH9Ow5gx6aqRSmVDcE/caj2MF
 bmSdJgWkGtQ8cYONYa6eFGkpswVVuyl2Okh9FrJSdw0yHY/ypVkUpLt3Gr/ea3ns9Zue
 ek1bLh+K1maTOHT57j9mXXsNYJoOUF+c5UKRLC++cYBSggaim3c/c0CcHBbz9xtbv2ia
 Zc3NUqMFSo5TATRi9UalflDiKlE91J2UH21Qehocj1JWOU3x9AhH2ddv+utuv61IJDhE
 +mD0NqAh/H6IrpoVqiWwGMSPKv2fdVeZAim8E0LnO5WSORpBpW5WWHAgxPtr68uD6M8f
 7fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453407; x=1752058207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q++VT0w3BFey6U6AhyjA4yt6pGOWJ3/ulMKQuhSNA98=;
 b=kNYVY08uHLzCkV2JLvMQOiOeHVKiPuCue+V4eILJPM+xtHCRp5CDXl7Jp4DuOxhbfa
 zAveR8lUZe72biSroD4yQ5K4NHuLo5SYTKdxBDvQVzBdGpKTfV8WBcbm3tWc0+F9eFNd
 FlLKCSgHV3H/voQyi32/sbzmiXXS8i723dbR6u7KgKx1I4V6DiTHHp8YVoF7wtQdjfw1
 8hTk0/BB3+NjVG/U2fTRFX0r+UIXyb7VRnGusPHdP2NMiA1ERtwyN8nMQXYdnyDe0kTV
 S2uWw/fSd2hqtMU4pIDvXszgIEzyK297tFiuAFVUwLclB5n+KE2WekyWdIUCida0ytUy
 LYlw==
X-Gm-Message-State: AOJu0YyYuyc4nrh33kKoSAVxxDByEOLq38XzImu6Mmc2jgmCMLjvEcjU
 m6Z0NPcRahgWRVgf45iw3IWfUP8RiEUGqyHW0nReEeFZNCb7yPh84qwu8NkXG/Ps5Ps=
X-Gm-Gg: ASbGncvj22ggtiE4DsCLA4VYvsaFYTZVe/4I0O1xIXkhngx8ngJYzW37R1btN/VVSnm
 yviyQ4DVmWUh3qeVo91GoFN9eklR1DvzhlwzGcv2wMIVZJVh/S2bLIPVFQuWTvMAPKX7pu/ZrVl
 cjgQgYvrWdqWunIS8P4UrMrR4xDGiUGjjv/vFYuT6vvP3+Uu6/QiNGdjxsvcKR3qNLnQivvHyKm
 Lwjqmnl4XnJ4LChzMzakgMwFQQkKN/TmMT43torGb7ZHeBNCJQD1WGmKr9lbd1x6Duq6aECep1f
 YgDpQuIAd/+CiR+ooVAUI+s/+HohMHa7dCNUtewuT+aBS6tpYPL40jQi4IAJF4c=
X-Google-Smtp-Source: AGHT+IHVLEGL587OfhzH6iNK19Nin8MJi0iVFaFH5SJHBg6G/0g/rQcWk0XxYtPPymc3rHzfuZWMTw==
X-Received: by 2002:a05:6000:70b:b0:3a5:24a9:a5d3 with SMTP id
 ffacd0b85a97d-3b1fe6b70e7mr1576185f8f.17.1751453407477; 
 Wed, 02 Jul 2025 03:50:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7524sm15875522f8f.12.2025.07.02.03.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED5675F920;
 Wed, 02 Jul 2025 11:49:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 12/15] plugins: Update plugin version and add notes
Date: Wed,  2 Jul 2025 11:49:52 +0100
Message-ID: <20250702104955.3778269-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-9-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-13-alex.bennee@linaro.org>

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


