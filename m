Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B6C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tax83-00080Z-FJ; Thu, 23 Jan 2025 08:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tax7y-0007ya-8Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:20:10 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tax7v-00025o-6Q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:20:10 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c00:2790:0:640:fde4:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D0B2060026;
 Thu, 23 Jan 2025 16:20:02 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b702::1:22])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sJYg2w0IhCg0-AJ5zRZ3f; Thu, 23 Jan 2025 16:20:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1737638402;
 bh=EWFl1Sav84Q814BPI9CwJ2ON+K6ogaJYLDRh2TeYwZk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w72z3pScUzfkFLWIbM5F7GSZbhvxBwNX2c39sCExTe3EQ1D6qzYWWK6HgkyDTAuAK
 AHLCICpx8gFDdrrgk7yyqN0INw+DmdYyBmadIdgzGJCOxiROxPeUbhpqXG5XzftgIS
 qWTMGpUE3nXu2B9Hc61+h7qr1dkIzzvJJtFyUOvM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v4 2/4] system/vl: extract overcommit option parsing into a
 helper
Date: Thu, 23 Jan 2025 16:19:42 +0300
Message-Id: <20250123131944.391886-3-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
References: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This will be extended in the future commits, let's move it out of line
right away so that it's easier to read.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 system/vl.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 09333a48c5..faa50c39df 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1847,6 +1847,19 @@ static void object_option_parse(const char *str)
     visit_free(v);
 }
 
+static void overcommit_parse(const char *str)
+{
+    QemuOpts *opts;
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
+                                   str, false);
+    if (!opts) {
+        exit(1);
+    }
+    enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
+    enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
+}
+
 /*
  * Very early object creation, before the sandbox options have been activated.
  */
@@ -3543,13 +3556,7 @@ void qemu_init(int argc, char **argv)
                 object_option_parse(optarg);
                 break;
             case QEMU_OPTION_overcommit:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
-                                               optarg, false);
-                if (!opts) {
-                    exit(1);
-                }
-                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
-                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
+                overcommit_parse(optarg);
                 break;
             case QEMU_OPTION_compat:
                 {
-- 
2.34.1


