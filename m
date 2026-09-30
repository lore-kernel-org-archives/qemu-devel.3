Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5CCA5FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxVv-0006v5-Mm; Wed, 30 Sep 2026 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVd-0006ZX-4H
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:23 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVZ-0003Xb-1s
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:20 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b0591cf85so158743f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787014; x=1791391814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7YZqbxUsWx8TcPnKOofK6gyVGdQ+2fV6RVy3rIunwZ0=;
 b=qrAG8Q50gCyv/cRPkXDQwxydkLKC5ccwfPMDDqgvmnCmNfDZv74d55SVjbUA2IV3Z9
 2E6MjtJe26IjGjvNK0wn2aSJG1EDozIf/+kXiJv4CzUSbmz4fviZ1bBBF3H+/L6wxMV6
 cjcqz8BOUzRLAo59ePv12tPwB/Nph8QS32tGMHK34KGc9e2m1yheeGx4RacKpTza7jjt
 LHf8RrAy+tF+tWgq8JO33Gh+ljTb9fY/jS8rtlu95jj6fcKyrp9BXtkytkPEpQvzg56/
 0KgnEuK780zT0wZvjf0b5vmdQQZybqoY9JfM71bs2CQOtjWsR8bFFOMfbm7i/IHRzurb
 77nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787014; x=1791391814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7YZqbxUsWx8TcPnKOofK6gyVGdQ+2fV6RVy3rIunwZ0=;
 b=PH7NcejLVJoZfHHo3cCGTTx3klacxvyd7+Y05Gdt1gpLMYgDfzIf+D+YMTPXWFuyGu
 HVv3kAzEsaBeZRLbPztOky7DyXwK2+QqL/dkD6zoRlxMC3n17OP+26FjMGJB0Wd+7OVf
 Rqjb7UVX2mtp9zSco2IEsmBORLsx4D4nXnyd2uXStJW9/0CzUuv/cYZ5NOdSnYGuuYCd
 E6/EQ/Tbnc07BcjXmEOb0z2CmnOAqf2lsjvb9tiLCemFuDiF1Kbi0kZK+i2zq8ffhDCV
 5zLo8Tqt9t/uO8kbkMD93EPxEkJgKxwfk7TK6vmGYhxRu3jCtvvVgiPQZh27OxGbDslz
 sFMA==
X-Gm-Message-State: AFuF++mzOlxBqv9sHg44iDNPWut1AHf1uYbU8u4jAhc+zSeTuhjK4IG+
 gePt2bh837ZxcIQv8PzRBTZDswxOz5aRRPfkFbskYJmOy4WDjr69Bn+7M6Gr+eqhZUBWwbuhaQ/
 HdTXc
X-Gm-Gg: AYBFou14Kbks9MC7hkObDhEUJhORzHmyN8oFFG8H3Kq7msDLgSKB00s0CcPLSt6pKZ3
 5LjRRtQOMs369oOlC11KBjz4QxV6U9VAT2kQ3Va493FfPtdy2eHcuY3nLBb0p7D8yfcHGEx/YOd
 DQnMHsPmBeLcHaEKw+o1qbKSciAeBl2Dp1rf40NEb0ujfLvisJPNjf6JuFz9AM4yqHGPl7JfYcP
 mVYkWJOFMGaTeuwMpNUdnDQxr6ofLi2R5F8ZhZa9Lh84pa/eOEkFP2nsLZnYoGuf7s/A/DbJS6x
 cK7hZs5n7wiTC7b1PzDXx9iaC+A7cdec/Z7VIqgUVkUSdXx4cwv/0jffUKhyunkwEPZb5DwcFBe
 wIushnDQGLtJaiAOW/1nQ20xsB6tCeEAXYb0qGCqH6OQKVgWFNljVrDL/F/ICPG35X+ABDymClu
 d/6PqBz8A2Vvj0or0dwhVl1dhhyiWzE48bJ01o03W2VYbypROgzbR4Gc2DYBB+/dSXe+w=
X-Received: by 2002:a05:600c:4e4b:b0:49f:fc13:18a5 with SMTP id
 5b1f17b1804b1-4a01ea5719cmr6635085e9.6.1790787014116; 
 Wed, 30 Sep 2026 09:50:14 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:13 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 08/13] qemu-io: accept --object iothread
Date: Wed, 30 Sep 2026 18:49:54 +0200
Message-ID: <20260930165000.303236-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f; envelope-from=den@openvz.org;
 helo=mail-wr2-x0f.google.com
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

qemu-io refused "--object iothread,id=t0" with "invalid object type:
iothread", because iothread.c was built into blockdev_ss, which qemu-io
does not link. Move it to block_ss: it wraps an AioContext and has
nothing to do with blockdev, and linking blockdev instead would drag in
os-posix.c, whose qemu_system_killed() every program linking it has to
define.

Collect the --object arguments during option parsing and process them
once qemu_init_main_loop() has run; nothing before that point uses an
object. An iothread created earlier registers the timer lists of its
AioContext with clocks that qemu_init_clocks() then resets, unlinking
them silently: no failure, just timers that never fire.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 meson.build | 2 +-
 qemu-io.c   | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index cfac634cf1..4c3f6518fd 100644
--- a/meson.build
+++ b/meson.build
@@ -3816,6 +3816,7 @@ if have_block
   block_ss.add(files(
     'block.c',
     'blockjob.c',
+    'iothread.c',
     'job.c',
     'qemu-io-cmds.c',
   ))
@@ -3830,7 +3831,6 @@ if have_block
   blockdev_ss.add(files(
     'blockdev.c',
     'blockdev-nbd.c',
-    'iothread.c',
     'job-qmp.c',
   ))
 
diff --git a/qemu-io.c b/qemu-io.c
index 598d5b1c9c..2b684ccf55 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -532,6 +532,7 @@ int main(int argc, char **argv)
     QDict *opts = NULL;
     const char *format = NULL;
     bool force_share = false;
+    g_autoptr(GPtrArray) objects = g_ptr_array_new();
 
 #ifdef CONFIG_POSIX
     signal(SIGPIPE, SIG_IGN);
@@ -607,7 +608,7 @@ int main(int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OBJECT:
-            user_creatable_process_cmdline(optarg);
+            g_ptr_array_add(objects, optarg);
             break;
         case OPTION_IMAGE_OPTS:
             imageOpts = true;
@@ -630,6 +631,11 @@ int main(int argc, char **argv)
 
     qemu_init_main_loop(&error_fatal);
 
+    /* An iothread object cannot be created before the main loop exists. */
+    for (guint i = 0; i < objects->len; i++) {
+        user_creatable_process_cmdline(g_ptr_array_index(objects, i));
+    }
+
     if (!trace_init_backends()) {
         exit(1);
     }
@@ -686,6 +692,7 @@ int main(int argc, char **argv)
     bdrv_drain_all();
 
     blk_unref(qemuio_blk);
+    user_creatable_cleanup();
     g_free(readline_state);
 
     if (ret < 0) {
-- 
2.53.0


