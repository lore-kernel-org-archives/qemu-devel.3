Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998E0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjJ-0006bV-PZ; Sat, 30 Aug 2025 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wb-0002eW-Ci
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WY-0002aL-6x
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso2273561b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506284; x=1757111084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0Ggm9wlx+9xy29EQzn7RdgHf/CbCvu60/I/6/mmVNA=;
 b=EhJysH+opPv6pKep1Zygg23NlGgRn8M5mFaFMYYdZ/8X8B70o0F4DagjMyBzzORf/l
 tmkfmckBrLOXB0tx/3O30uEHe2nK+Oht+6ouBKzAmDy11CKFHmA7h0qnHyBrv7xP3/yv
 1yxwGoKeDhZHikEAbPFUjZBtAd6D5WYZTHFLnxxBl7KltxtFO6fQFuWO5voythsMcnEm
 mZT2AcyzPDyqBqdWlUN/iAYQlMdd139lefZPMpMWspXMsO+1HYLcnHaP8ZHbW6rR8rQa
 NUiZVrIpYIgRy4seIt1gEfxFo8B7Fwq5PeUW7gkGttW3RPcpr8vDGfPnu3fHNzliAcdQ
 GSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506284; x=1757111084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0Ggm9wlx+9xy29EQzn7RdgHf/CbCvu60/I/6/mmVNA=;
 b=t8Q7gp4fdpWGr849a/7MRsGg6XQNCGS5bUDlmUiXFyTf+LUCo4YryJwwXR5BegucKE
 qPrQ/5ZDZ1DAzwPz5i/SZnfy4BdV7tqoQrPfLqPRy4TT1XaL01xV5r7ixtbmPUyVgz/E
 eEY/Dydy8ixZzli6TqTCEGsHoB1OdWdrfUttTsXwpTmPnDz9uIt+wZq6q5eYh2cQ0+LO
 6sy3nJtGgb122edEgRz9IUHPTaRok6kkOwUK8rnOHKLYlu/7LCQpUcDxuOEBTZWBKya/
 bCHgtw8mhkchIqjg5aUKCRIL71lZieKy7S3GmBet+FGlEkf64AzQpsN9kaP36qcxINq1
 OA9g==
X-Gm-Message-State: AOJu0YwqmoTtHwJd4jQ4QwauPJmb2cjHBhXwq3ByFwK/iwWEFAkqMdvx
 xSKnqAFgK7b8TPig7xx4o9aK1kiLqWoFJ8WQQO6QynrWYSwcJOJrrrnCgvhomzc+t5tPNpkbwra
 smZnAzrk=
X-Gm-Gg: ASbGncuXLO0dDlKtBRjUeuLqMZ86OZ057y8zXyE7cm13CWESzc/AiFTizFCayxZIq3e
 ADyWYXt3PkWmagyHf+PipuIBakZK+RHvlZ/9LsujDwbVvD29fcXpQevydBqj+1/OIX/beOfKkpO
 aFxlsPsHl0Ob/7R3QhtXrB5XxfoBb037k8PpJGaDXl35fJzIt9bMJHLQxyvP1z/qONuDzp/Lp8P
 NB5RhitEYbPRLIXA9YIyv1+X67QGW71dK72XNIeMa1cyZDnuUMWbRvzoJLom9keJO0phXvlUoMv
 n/9Qvjx+rPBtQ4OLv0aX64/aBIYLa7tflmYYMoFlKAYcbNVoBQ8sZafoFGbXlGeGqN/CPZ9GPD/
 wqkjDx+ZWSsyHX1+SsUe/HC+Qpwlr6chA8l4yKmTiwwpDM00OcKmZIqb2mLol
X-Google-Smtp-Source: AGHT+IGgwAtFm/zW2VAYRCXULc4/gfxnnGl50fxq7QFYBAUx2KYn8im8KALQfb7CJeO3wj7g4v5e4w==
X-Received: by 2002:a05:6a00:114b:b0:771:d7b0:6944 with SMTP id
 d2e1a72fcca58-7723e21ed20mr275593b3a.3.1756506284484; 
 Fri, 29 Aug 2025 15:24:44 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/91] linux-user: Drop deprecated -p option
Date: Sat, 30 Aug 2025 08:23:00 +1000
Message-ID: <20250829222427.289668-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The user-mode '-p' option has been deprecated since 9.0 and
doesn't do anything except emit a warning. We are well past
our minimum deprecation period, so drop the option.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250828162012.3307647-1-peter.maydell@linaro.org>
---
 bsd-user/main.c                 |  8 --------
 linux-user/main.c               | 12 ------------
 docs/about/deprecated.rst       | 10 ----------
 docs/about/removed-features.rst |  8 ++++++++
 docs/user/main.rst              |  3 ---
 5 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7e5d4bbce0..9ba69642f5 100644
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
index 6edeeecef3..7b0ccb6fd6 100644
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
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d50645a071..5d1579dcf8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -81,16 +81,6 @@ kernel since 2001. None of the board types QEMU supports need
 ``param_struct`` support, so this option has been deprecated and will
 be removed in a future QEMU version.
 
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
index d7c2113fc3..25a904032c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -571,6 +571,14 @@ The ``-singlestep`` option has been given a name that better reflects
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
diff --git a/docs/user/main.rst b/docs/user/main.rst
index 347bdfabf8..a8ddf91424 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -262,9 +262,6 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-p pagesize``
-   Act as if the host page size was 'pagesize' bytes
-
 ``-one-insn-per-tb``
    Run the emulation with one guest instruction per translation block.
    This slows down emulation a lot, but can be useful in some situations,
-- 
2.43.0


