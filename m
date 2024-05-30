Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D4AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZpq-0006Bc-Vu; Thu, 30 May 2024 03:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCZpn-0006Ap-52
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:04:23 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCZpj-0003Jj-Rm
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:04:22 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b7c82e39eso618597e87.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717052657; x=1717657457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JY6ELSVZKELLoSKpq9yegBudO5fBYerevqxXi5PwlFY=;
 b=wkJr13TCHCQ71jtRmqj/pkqNqKKTiMp4Bh1UCmCpn74oNpMtGGQoVqAhYdLHfmJ68u
 ww743Ot2OkuSotU8cJy6wLEdJCf2M4qZ9HFIz5FbhzszaRtFkAHUIZdNSuWT8pe31tUr
 TPHey41sPPIzMp1r9SzFYVw0hEhOmvS50LuAIuXiq7xd57dHseMKLUuW/YbH9EOcYwoy
 fEE3SmTjER4QDGcggesXDGBPQN/JfRw92SJy3yUoLIGy/N8hrbSuWUvWHn3aq6qH3uZP
 D5l296E2es3zXlENfRcnqHczLxfPUvuoohl6WwAc+n1OD+QaVTcj4P1GdVVhQfJJCU+P
 1UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717052657; x=1717657457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JY6ELSVZKELLoSKpq9yegBudO5fBYerevqxXi5PwlFY=;
 b=U49dHTyFeVK35Ixw0r+0xt6W7nAMdCTdJsTZ+nngDUBPEG92cjDByeya5MQeaZab3x
 FUakdnVEt7AoBQCGxNS5XrHoI/C/O+6ZhbrNWjoEdRIJJ+nRgvQ2VF3ZngpGCVrG8FaQ
 D9g/Flu6c5tMx2VkV41wBTNrt93Du8irnc3q78wZlYkg7C7/HYNeUiA2PWQ5YBy5BUdI
 hcihDRWCc6ytVzcLcDhJpK+8b2tAbei7ccR+SOD/raA3p9yfqYXd5Z25V6rMMrxgAYUR
 M8LyH1E7Uwg4c/I5odEIBh/pY+MrDNAWWPZeXk31YwIVCX2QqseIIelSlrT6r58L+5sR
 d52Q==
X-Gm-Message-State: AOJu0YzPW8lkqrfMPcQJWf56kBcqKnCspfMvfn3HlneLi12kfPPsSivf
 gNJ1B25rRHlHA6L6PyUhZtvDx0H1gO3B/uajPZ1oWMeHrvu/HOyAumBq4yvl3PmdZkLxwlaTiWr
 5
X-Google-Smtp-Source: AGHT+IEfJoO89lJW9ue6eidTOsuPAzfx06VpWQUBc7ywQrAB+m36jgoVnvlF/07pE1TKcSfy88Makg==
X-Received: by 2002:a05:6512:247:b0:51e:f0e8:d70d with SMTP id
 2adb3069b0e04-52b7d426760mr1314151e87.21.1717052657253; 
 Thu, 30 May 2024 00:04:17 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57872da9dfbsm7176522a12.2.2024.05.30.00.04.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:04:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] qga: Remove deprecated 'blacklist' argument / config key
Date: Thu, 30 May 2024 09:04:13 +0200
Message-ID: <20240530070413.19181-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The 'blacklist' argument / config key are deprecated since commi
582a098e6c ("qga: Replace 'blacklist' command line and config file
options by 'block-rpcs'"), time to remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 18 ------------------
 docs/about/removed-features.rst | 18 ++++++++++++++++++
 qga/main.c                      |  6 ------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 40585ca7d5..a32e0e2564 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -478,24 +478,6 @@ versions, aliases will point to newer CPU model versions
 depending on the machine type, so management software must
 resolve CPU model aliases before starting a virtual machine.
 
-QEMU guest agent
-----------------
-
-``--blacklist`` command line option (since 7.2)
-'''''''''''''''''''''''''''''''''''''''''''''''
-
-``--blacklist`` has been replaced by ``--block-rpcs`` (which is a better
-wording for what this option does). The short form ``-b`` still stays
-the same and thus is the preferred way for scripts that should run with
-both, older and future versions of QEMU.
-
-``blacklist`` config file option (since 7.2)
-''''''''''''''''''''''''''''''''''''''''''''
-
-The ``blacklist`` config file option has been renamed to ``block-rpcs``
-(to be in sync with the renaming of the corresponding command line
-option).
-
 Migration
 ---------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fba0cfb0b0..deca066b21 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1129,4 +1129,22 @@ stable for some time and is now widely used.
 The command line and feature set is very close to the removed
 C implementation.
 
+QEMU guest agent
+----------------
+
+``--blacklist`` command line option (removed in 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+``--blacklist`` has been replaced by ``--block-rpcs`` (which is a better
+wording for what this option does). The short form ``-b`` still stays
+the same and thus is the preferred way for scripts that should run with
+both, older and future versions of QEMU.
+
+``blacklist`` config file option (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``blacklist`` config file option has been renamed to ``block-rpcs``
+(to be in sync with the renaming of the corresponding command line
+option).
+
 .. _Intel discontinuance notification: https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
diff --git a/qga/main.c b/qga/main.c
index bdf5344584..f4d5f15bb3 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1071,11 +1071,6 @@ static void config_load(GAConfig *config)
             g_key_file_get_boolean(keyfile, "general", "retry-path", &gerr);
     }
 
-    if (g_key_file_has_key(keyfile, "general", "blacklist", NULL)) {
-        g_warning("config using deprecated 'blacklist' key, should be replaced"
-                  " with the 'block-rpcs' key.");
-        blockrpcs_key = "blacklist";
-    }
     if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL)) {
         config->bliststr =
             g_key_file_get_string(keyfile, "general", blockrpcs_key, &gerr);
@@ -1190,7 +1185,6 @@ static void config_parse(GAConfig *config, int argc, char **argv)
         { "path", 1, NULL, 'p' },
         { "daemonize", 0, NULL, 'd' },
         { "block-rpcs", 1, NULL, 'b' },
-        { "blacklist", 1, NULL, 'b' },  /* deprecated alias for 'block-rpcs' */
         { "allow-rpcs", 1, NULL, 'a' },
 #ifdef _WIN32
         { "service", 1, NULL, 's' },
-- 
2.41.0


