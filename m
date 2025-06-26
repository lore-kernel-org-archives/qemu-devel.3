Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD22CC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 19:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUshL-0001X2-JO; Thu, 26 Jun 2025 15:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uUsh2-0001CS-TH
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:55:39 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uUsgz-0005QR-Ra
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 15:55:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:420d:0:640:5081:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B063960B31;
 Thu, 26 Jun 2025 22:55:17 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:846::1:13])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GtbbZB0FqSw0-LbEy4Sso; Thu, 26 Jun 2025 22:55:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1750967717;
 bh=3RKuNxMTzHc3LawzU8y27y1Drgona9+phlmpSMzgqRM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=l8ZHmiKhjHe9lC5rc33BHDupItI8ELgnQYIFv57lB6VjjL6FI6IsVb5LDvCSyPTX1
 8RqpCz9GJRiWkR3iON9W1IzDP1CtVZHL/J5fROeqi+2IUw2cBmMKIyazRCx1nHDV8V
 QwbZJWOKD6ei+veUSlqz6ozJ6WqWphp/vS0kvt0g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk,
	stefanha@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH] trace: log.py: human-readable timestamp
Date: Thu, 26 Jun 2025 22:55:14 +0300
Message-ID: <20250626195514.366177-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

So tired to parse all these timestamps, when need to compare them
with other logs.

Use iso8601 format as in warn_report() (info_report(), error_report())
already used.

Also, start line with date, to be similar with warn_report() as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 scripts/tracetool/backend/log.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 17ba1cd90eb..61118474b16 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -39,10 +39,15 @@ def generate_h(event, group):
         '        if (message_with_timestamp) {',
         '            struct timeval _now;',
         '            gettimeofday(&_now, NULL);',
+        '            time_t _seconds = _now.tv_sec;',
+        '            struct tm _tm;',
+        '            gmtime_r(&_seconds, &_tm);',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
-        '                     qemu_get_thread_id(),',
-        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
+        '            qemu_log("%%04d-%%02d-%%02dT%%02d:%%02d:%%02d.%%06ldZ'
+        ' (%%d) %(name)s " %(fmt)s "\\n",',
+        '                     _tm.tm_year + 1900, _tm.tm_mon + 1, _tm.tm_mday,',
+        '                     _tm.tm_hour, _tm.tm_min, _tm.tm_sec, _now.tv_usec,',
+        '                     qemu_get_thread_id()',
         '                     %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
         '        } else {',
-- 
2.48.1


