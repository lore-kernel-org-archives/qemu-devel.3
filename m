Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED857D2A52F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 20:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFuq-0006gJ-Fn; Thu, 04 Dec 2025 15:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFuo-0006fa-8w
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:27:02 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vRFum-0003FS-B4
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:27:02 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AD94F80879;
 Thu, 04 Dec 2025 23:26:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:83c::1:2e])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sQswCW0FbOs0-W5fLwnUV; Thu, 04 Dec 2025 23:26:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764880017;
 bh=mOZQQM83Os2QIRroZDeVQZFDUiml4r76Fkwg884qylI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=K4XxF4IodVacyYe2tkHB9E4EcIOilWryC/9OKCD1CAjgXnOd+byYLKeJUdDmLNxuF
 z1wMyj+CE3Z/kvSmtaZu+zE4g77w5py9jV/WV2ZbaZHMqVZqDgvaccIZVUlgJhePnQ
 Eqcpt+c2UgDh386BYtQK2BDWTrq4pIXHueVGzCBQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 2/3] error-report: make real_time_iso8601() public
Date: Thu,  4 Dec 2025 23:26:47 +0300
Message-ID: <20251204202653.597319-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204202653.597319-1-vsementsov@yandex-team.ru>
References: <20251204202653.597319-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

To be reused in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/qemu/error-report.h | 6 ++++++
 util/error-report.c         | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3ae2357fda..bcd542a118 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -74,4 +74,10 @@ extern bool message_with_timestamp;
 extern bool error_with_guestname;
 extern const char *error_guest_name;
 
+/*
+ * Returns current datetime in ISO 8601 format.
+ * Caller is responsible to g_free() the returned string.
+ */
+char *real_time_iso8601(void);
+
 #endif
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..d6b7448183 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -169,8 +169,7 @@ static void print_loc(void)
     }
 }
 
-static char *
-real_time_iso8601(void)
+char *real_time_iso8601(void)
 {
     g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
     return g_date_time_format_iso8601(dt);
-- 
2.48.1


