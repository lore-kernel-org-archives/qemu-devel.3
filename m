Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5B3CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxWA-0008Ae-K8; Wed, 30 Sep 2026 12:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVm-0006iI-EL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:30 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVk-0003YF-MC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:30 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so28742805e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787017; x=1791391817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5US/vIcb1jdJXn35ECQsGQA2Ouaa1Ah+FNh4z4UiZkI=;
 b=IhLECNnPewpb5MuAV588HFWozZhvMtuzpZJVpk1HxDRveNQN5QDOIAVKBrbhbL/dcT
 T5xrYdchUT7EJZSx5ZCsBun4mbkl9bTI/3UCcu6LtO1i3+fOeAUyQuxV7vYTkkHy4AZO
 pE4cQRFwTxoJZ1Z+WO/g6pxlFRQ+AkiD9VXV+yDatzNZuMqaEsTuBeTMv8Vpa7cQxTio
 J2fUuIPAHzktGvAYn2veul5/yWZcwP0zMyip/qJsAoBVbU+ttuiIPwiXML0/lxdLQ5rP
 iq0kpymAr8Dd2HL8isp0RJTWqbwATwRmAG+jYPbFs8cDpEylAgC2bZLw/5VxvV8aYh9B
 uhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787017; x=1791391817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5US/vIcb1jdJXn35ECQsGQA2Ouaa1Ah+FNh4z4UiZkI=;
 b=izCMPJkU/okO8DlatBa94fhndgS8SRNaQl+q7vcucmn1oKzwmb2hJtdhwBGEnDp7XZ
 Qa/gUH9nnu5jlrQFoXVqivAyehQTorgcHmnyJRYN0wAJPsS5MTGEXx15aVDkyMx+Oe8C
 ClaQF2uKC9NoSAYojbFm0eUZgv9Lu/yKRLG+V0Gbwc80MejydxQvZG5oP0kinJH6wjRK
 d4lZlZe8Pp3TjkIN0hgWNbqJoUZghO+oHAX8NX+/3DkzInQjSl5XB8t5gAd/oYMwacQe
 YxBFLmLvNM4JAIqu+ktSRMul0BWAjztXj6e+0hsfjtsDQ78csUTrjgKK9IqMqaepDVQl
 7M8g==
X-Gm-Message-State: AFuF++mD5W6V/iU2IxyiCvsr87Z0PzUDyBiAgJhwdxY3QlGGiSRzZ5/P
 sVXlUmnz5l7tFJKPUPlrw4bsk0piqAeDEOvaaCMd/oxmNYW/BdZnqtPPRLGxbAJDT0GVW/xO7kB
 xsY0h
X-Gm-Gg: AYBFou19OZxmg9TvSHlrgWfbeaew4Y4g003UIg6I/sJrmASKV4mT0UHSi3qUCJCnFxH
 jAPe/mw/wBS2l/vITYfq3xhCXl5NmYAh6hroOpBN83wyTfLXSRDzl2hpIWKrIW5rBSOiZThh4JP
 e/8Kh15QaDsXqur1wTQ7ikjsLRLaDqZIHDqwHQMJD00XBXfrSi061i4o9UvSNv+YQRjHw3ctTVb
 kxM9IS/KDjhkkV8VtGvCafhXiuLHeflYu7Ftv0yxx2j13bqzGm8oeRhunM50mTEfVUOBs6O0nJc
 y4WQRfw0oM8dYJRzLw5lXd/Ta1nASGqOYRLM+COMKPAdyPpfzwQTTSWLKZ2T3po1H6T9h6ogJ6s
 eDhAlcOK3Poo0bENe5poWf7o/Nro3zb3Eap5B150ewdBe8u9NBDGQeX2F7LrIfB/f26YsMjiJwZ
 Uguu6u7my0RUG6sbrZmKzxodnZ/QBxw3EMSvtCf2gEicBzP5WX7YyslribmQN1wlg9ph8=
X-Received: by 2002:a05:600c:c162:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-4a01afe1dfamr36181175e9.8.1790787016651; 
 Wed, 30 Sep 2026 09:50:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:16 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 10/13] qemu-io: add -g to write past the end of the image
Date: Wed, 30 Sep 2026 18:49:56 +0200
Message-ID: <20260930165000.303236-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

The preallocate filter only does anything for a write that lands beyond
the end of its file, and that is what a format driver above it produces.
qemu-io could not produce it at all: the backend rejects such a request
with EIO, and the write path asserts without the resize permission, so
the filter could only be reached by stacking a real format on top and
letting it choose the offsets.

Take the resize permission and allow writes beyond the end when -g is
given, which leaves the tool free to address the filter directly.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qemu-io.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 2b684ccf55..87254b32ff 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -45,6 +45,7 @@ static bool quit_qemu_io;
 static int ncmdline;
 static char **cmdline;
 static bool imageOpts;
+static bool write_beyond_eof;
 
 static ReadLineState *readline_state;
 
@@ -114,6 +115,21 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
 
     blk_set_enable_write_cache(qemuio_blk, !writethrough);
 
+    if (write_beyond_eof) {
+        uint64_t perm, shared;
+
+        blk_set_allow_write_beyond_eof(qemuio_blk, true);
+
+        blk_get_perm(qemuio_blk, &perm, &shared);
+        if (blk_set_perm(qemuio_blk, perm | BLK_PERM_RESIZE, shared,
+                         &local_err) < 0) {
+            error_reportf_err(local_err, "can't take the resize permission: ");
+            blk_unref(qemuio_blk);
+            qemuio_blk = NULL;
+            return 1;
+        }
+    }
+
     return 0;
 }
 
@@ -129,6 +145,7 @@ static void open_help(void)
 " Opens a file for subsequent use by all of the other qemu-io commands.\n"
 " -r, -- open file read-only\n"
 " -s, -- use snapshot file\n"
+" -g, -- let writes extend the image past its end\n"
 " -C, -- use copy-on-read\n"
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
@@ -149,7 +166,7 @@ static const cmdinfo_t open_cmd = {
     .argmin     = 1,
     .argmax     = -1,
     .flags      = CMD_NOFILE_OK,
-    .args       = "[-rsCnkU] [-t cache] [-d discard] [-o options] [path]",
+    .args       = "[-grsCnkU] [-t cache] [-d discard] [-o options] [path]",
     .oneline    = "open the file specified by path",
     .help       = open_help,
 };
@@ -175,7 +192,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     QDict *opts;
     bool force_share = false;
 
-    while ((c = getopt(argc, argv, "snCro:ki:t:d:U")) != -1) {
+    while ((c = getopt(argc, argv, "gsnCro:ki:t:d:U")) != -1) {
         switch (c) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
@@ -228,6 +245,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         case 'U':
             force_share = true;
             break;
+        case 'g':
+            write_beyond_eof = true;
+            break;
         default:
             qemu_opts_reset(&empty_opts);
             qemuio_command_usage(&open_cmd);
@@ -310,6 +330,8 @@ static void usage(const char *name)
 "                       specify tracing options\n"
 "                       see qemu-img(1) man page for full description\n"
 "  -U, --force-share    force shared permissions\n"
+"  -g, --grow           let writes extend the image past its end,\n"
+"                       as a format driver does to its file\n"
 "  -h, --help           display this help and exit\n"
 "  -V, --version        output version information and exit\n"
 "\n"
@@ -503,7 +525,7 @@ static QemuOptsList file_opts = {
 int main(int argc, char **argv)
 {
     int readonly = 0;
-    const char *sopt = "hVc:d:f:rsnCmki:t:T:U";
+    const char *sopt = "hVc:d:f:grsnCmki:t:T:U";
     const struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -522,6 +544,7 @@ int main(int argc, char **argv)
         { "object", required_argument, NULL, OPTION_OBJECT },
         { "image-opts", no_argument, NULL, OPTION_IMAGE_OPTS },
         { "force-share", no_argument, 0, 'U'},
+        { "grow", no_argument, NULL, 'g' },
         { NULL, 0, NULL, 0 }
     };
     int c;
@@ -607,6 +630,9 @@ int main(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case 'g':
+            write_beyond_eof = true;
+            break;
         case OPTION_OBJECT:
             g_ptr_array_add(objects, optarg);
             break;
-- 
2.53.0


