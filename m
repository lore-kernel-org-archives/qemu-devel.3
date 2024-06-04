Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96738C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwa-0000Ho-Vs; Tue, 04 Jun 2024 05:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwY-00005r-WE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:59:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwW-0002Nw-LS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:59:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35e4aaa0f33so2674293f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495139; x=1718099939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IPOKJ4bfj8H7u0AOUJYW14UBzQ/mD/AN0ShzwkJT0k=;
 b=VgZEP1IYaLhEiCZmyujtyr86zlGWl+CP/mOsP8mykez41DaUhSulyycGdr6MuAB6b8
 xftFDoiUqK+gGSiy/gJ6GwwY8JNU3hXOPbzUgU5Ud6gAavqktLqu/qB1y43ihNIR/D5y
 vna/D9AjX24NNvjYWrMCkwCJvjV4kqHLQCCFCzAMimfKwX5BrcvgGZfMSIpvOrh/o9WG
 0nMH4O/d3hxv1AW+u3B8fTJsPH38TYUPWjJ83DizooQuL2xElGadac6l5F5ui/BTYzdj
 k+4z7Im43hBQZv63dlcWGq5vfUD8vPWj0XMb7KxQNpmYgkyQhpjg3zO1ovaWI48j04Za
 HxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495139; x=1718099939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IPOKJ4bfj8H7u0AOUJYW14UBzQ/mD/AN0ShzwkJT0k=;
 b=LVVLaHKXxrTjrtFGDYS0OTbg32lZnxO0DVI9/IAJ8pQSKevKMawfJAAHr+oYEJH6oy
 VrbUNirKwnpf0QPVBx3yqp9c6jptEtTZjCVrKo+iSbONCeVErEHFyaMQkQpDbQ8GYfQi
 2JWIRGdYS8iAW6RTa51vlnJljWqVJn8EXbdjiJYtJgbW293XNQUJHks/Tu7EzWBZsRVK
 eB9+RnjaFaPLuaIpexOJDnxWao7AvHS7uOZwGrMdjafo93dBs2SOlsym7n9hBkNgn/rC
 ln/RHpOKjCMs8Tsv9RVbkPnHb7DL4f/cCpzcelbkNGKZTOC7AiFWvJIFwDWb3NTth1fv
 X3aw==
X-Gm-Message-State: AOJu0YxtKbiHDKaGwUt/TriDlf0XA1D18/MM/mh06NqwBKp7jzDLHG9b
 QIGoMEAvJCKhsqXjrU9IoWZ88e5IyySOiG1o1Ism3oOziW4Mn0kAxVwNnDKHqkhgGnz5X6MxYia
 E
X-Google-Smtp-Source: AGHT+IEsMCMfNlTLfFoGlaytIalXtFxe3kWoNTZLNJxbNmBvUg8YBI4KAfdppRGBrANGXYplZqOpJw==
X-Received: by 2002:adf:f68b:0:b0:354:e729:c101 with SMTP id
 ffacd0b85a97d-35e0f2551f3mr9370060f8f.12.1717495138820; 
 Tue, 04 Jun 2024 02:58:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0f7esm11074701f8f.22.2024.06.04.02.58.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 31/32] qga: Remove deprecated 'blacklist' argument / config key
Date: Tue,  4 Jun 2024 11:56:07 +0200
Message-ID: <20240604095609.12285-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The 'blacklist' argument / config key are deprecated since commit
582a098e6c ("qga: Replace 'blacklist' command line and config file
options by 'block-rpcs'"), time to remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-Id: <20240530070413.19181-1-philmd@linaro.org>
---
 docs/about/deprecated.rst       | 18 ------------------
 docs/about/removed-features.rst | 18 ++++++++++++++++++
 qga/main.c                      |  6 ------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 187c8a3f97..a6f4655a3a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -462,24 +462,6 @@ versions, aliases will point to newer CPU model versions
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
index 1e64c27cd8..210a90bee8 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1144,4 +1144,22 @@ stable for some time and is now widely used.
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


