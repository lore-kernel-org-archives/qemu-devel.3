Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD6ACA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgC3-0002fR-5I; Thu, 28 Aug 2025 13:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urfMM-0007pL-9X
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 12:20:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urfMI-0003yJ-5E
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 12:20:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b6b5ccad6so6850945e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756398015; x=1757002815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DDd2OozNZz4+6MaekqAmY3f6RjG9TC2sT7ply03DQP8=;
 b=BBsW8X1tQs9wlJaJT0vY9pKGlRW4arOVbvzBRuXgD1Az/XpbfxPiVV3symhHHQaJ+A
 ToWSCPRUUDTJAx1NMEPnIQjBQ+GaVph0e0iQdZSCPDMc5TuD6+dty723IGlwJvTU2OVr
 Li5ZED31yPzRfMi67I+GqR6I4x9p/GCkLxhrsBNO8rnR5SH5+9X8hqFgAMJ6T1T5gFye
 e9FJAl6Fqag9vU8VI13qOPgngBlF61IYCmJEugt/SSNhF7kihYqiKyAVKxeYRnZzXT4z
 +cEamDi1MwgAUoSjEyp4dINOU8vqcm7cL4dUDPRM9Kjz1B8DxB+CDTMsZE6mLuwUENSH
 tdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756398015; x=1757002815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DDd2OozNZz4+6MaekqAmY3f6RjG9TC2sT7ply03DQP8=;
 b=UpAOSFWBS5VWw0MgGun2XSZRR+sM3k0EskHAp/8X7MBs1qT8nsqOP7cHI/3RSZK8S5
 kdiJDCEgexYkE6x8Bd8eRiFjczHF2gs8Qo/z2+QmfD728VQh+2JZsHUOsaXMWNNb2NQB
 rqYFRHfkIFIbmBdGOUtx7vtpiBS8lpJbpDQN9QL+23VYQjtH8kkCEpxayjK8t8axC5J4
 1NyU8v/HeikeNUgT4gTBt3zQYCRgS0spNtqrFnS43m/lpO/MX0hwnohdDXlXLZLwoP8U
 VP2P8+jLWYVbL2phbqmWETdy2wgnYCVmBjMZOiGNMbfyhiE3Ll9/TlbrXTDYrGfReywu
 M2Yw==
X-Gm-Message-State: AOJu0YzVMO3DHh86AUOdoRt/9C5Hq1KEWUdYazSzY21UF78RQxPgOAUz
 5r9ubgpeebCtHFxb79STftMzXTl4w93Fe7Dzf0UqUoYlWM4DXmzsP6+zxrlU6N8dyPgIKrKWrJV
 SUk9g
X-Gm-Gg: ASbGncsq/R5P/2b1vQn6C7DMPd9JySClbK8NKFj34ORh3xr7zbTfkVikGSa4qpY5nah
 pzW5iNw5WOi5vVnjrQbc11rR5KsG0bsX8t0f58ZoI9yob2u4aKm2FFcmCHHbeUsyHmg9baMTSIK
 Jr2yTMHYJr0sSkvH8BeYgorB0UDl6MG8ZWihtj5dMAAWDME8akHakUkRrSTGSz9R5Pj2OEBl6HH
 OllaZnL/2ZCveWySOJATA/CFqbGxBrom3rNulVGXX/MXRrOZ3yb7ObBW5c96+dgNvb5+NV0hwfM
 uM//t2i0lr1wJH+t0OvzmzQCdc2jTYfFVZYqP8Q+iSRDEtY0SJqzt5x8teVQfmPIk7AVz0EeQqI
 XMqC3m1P62rfA0yP8gUUEw+tJmC1KB63D8jZFMaE=
X-Google-Smtp-Source: AGHT+IGNUJQb3qZ57Zt1EkOqA56gTHKV3QWn53B7oqTUjiRTWNUMVXSbLD8jO33ea6r+YgXf+DmzyQ==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id
 5b1f17b1804b1-45b5179e897mr204379445e9.10.1756398014681; 
 Thu, 28 Aug 2025 09:20:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711211b19sm25977595f8f.39.2025.08.28.09.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 09:20:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] linux-user: Drop deprecated -p option
Date: Thu, 28 Aug 2025 17:20:12 +0100
Message-ID: <20250828162012.3307647-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The user-mode '-p' option has been deprecated since 9.0 and
doesn't do anything except emit a warning. We are well past
our minimum deprecation period, so drop the option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst       | 10 ----------
 docs/about/removed-features.rst |  8 ++++++++
 bsd-user/main.c                 |  8 --------
 linux-user/main.c               | 12 ------------
 4 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 58bce715f9c..dfb7882e3da 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -68,16 +68,6 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
-User-mode emulator command line arguments
------------------------------------------
-
-``-p`` (since 9.0)
-''''''''''''''''''
-
-The ``-p`` option pretends to control the host page size.  However,
-it is not possible to change the host page size, and using the
-option only causes failures.
-
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index b1b3d1b1b3f..06f186991ac 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -583,6 +583,14 @@ The ``-singlestep`` option has been given a name that better reflects
 what it actually does. For both linux-user and bsd-user, use the
 ``-one-insn-per-tb`` option instead.
 
+``-p`` (removed in 10.2)
+''''''''''''''''''''''''
+
+The ``-p`` option pretends to control the host page size.  However,
+it is not possible to change the host page size; we stopped trying
+to do anything with the option except print a warning from 9.0,
+and now the option is removed entirely.
+
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7e5d4bbce09..9ba69642f50 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -367,14 +367,6 @@ int main(int argc, char **argv)
             }
         } else if (!strcmp(r, "L")) {
             interp_prefix = argv[optind++];
-        } else if (!strcmp(r, "p")) {
-            unsigned size, want = qemu_real_host_page_size();
-
-            r = argv[optind++];
-            if (qemu_strtoui(r, NULL, 10, &size) || size != want) {
-                warn_report("Deprecated page size option cannot "
-                            "change host page size (%u)", want);
-            }
         } else if (!strcmp(r, "g")) {
             gdbstub = g_strdup(argv[optind++]);
         } else if (!strcmp(r, "r")) {
diff --git a/linux-user/main.c b/linux-user/main.c
index 6edeeecef38..7b0ccb6fd60 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -340,16 +340,6 @@ static void handle_arg_ld_prefix(const char *arg)
     interp_prefix = strdup(arg);
 }
 
-static void handle_arg_pagesize(const char *arg)
-{
-    unsigned size, want = qemu_real_host_page_size();
-
-    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
-        warn_report("Deprecated page size option cannot "
-                    "change host page size (%u)", want);
-    }
-}
-
 static void handle_arg_seed(const char *arg)
 {
     seed_optarg = arg;
@@ -522,8 +512,6 @@ static const struct qemu_argument arg_table[] = {
      "range[,...]","filter logging based on address range"},
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
-    {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-     "pagesize",   "deprecated change to host page size"},
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
-- 
2.43.0


