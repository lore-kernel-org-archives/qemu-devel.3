Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC27C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDu8-00027n-PF; Wed, 12 Feb 2025 09:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu5-000275-In
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:53 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDu3-00080n-3h
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:39:53 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B509A611E2;
 Wed, 12 Feb 2025 17:39:49 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6b8:b081:b518::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ddQHZB0Id8c0-uma463PO; Wed, 12 Feb 2025 17:39:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739371189;
 bh=ybIkw9tiflFmhaHlKoA26s39xuP3YJHyyhxeEkdpcZU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ut3oeivrSCZq1DF+AZlFqIIremfC5Ex0T+chWpsIsf4WCt1S7Z0L1vTBDKOcY4yO7
 Ke8xcQ8Y/I7y3KJSLMq+BYUxtSOkk+4ZlUbune2o7FrD/RILNuhqbbsDVQK1ASCOzG
 2tkdgwdUC5qDYMoO6NpW0UtQGVKba6/zlRPJoA8U=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 2/4] system/vl: extract overcommit option parsing into a
 helper
Date: Wed, 12 Feb 2025 17:39:18 +0300
Message-Id: <20250212143920.1269754-3-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
index e94fc7ea35..72a40985f5 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1875,6 +1875,19 @@ static void object_option_parse(const char *str)
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
@@ -3575,13 +3588,7 @@ void qemu_init(int argc, char **argv)
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


