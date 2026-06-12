Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64D8CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5FC-0005Fe-6w; Fri, 12 Jun 2026 13:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Ek-00051t-PF; Fri, 12 Jun 2026 13:00:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eg-0005s1-53; Fri, 12 Jun 2026 13:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=H9M2Fh85y/22I4XzRmHD0o4NHoOkTKYKEHPr9bbfgkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aajJtZf4plQN/Lz4lweReNZlLfT/nZm6QPjwQaz80fnag6CGe8z9cFiOQ09hWws9v
 uhZxwtawbiMVS94FkPN0vEMBBJHTaTjlbKQQAQJrs/99vRYjkxjy88cODXgVzhwBOw
 4kUr7RkVTG+HtBiVteXq2rYUY9aaUXY2nF89uzFArvrjJNpRjWHgKjfpld0XoVNW7s
 6EDPvOUKJQcbKGX1cMO6MEudy80UdgsJNfN6SIxE29j6Z6Ii/teZU/5VU8ZMrRizOh
 FzL93LRfv4HwSw+71JqV7RLdTdEf+3BlwZH6BfO35h/128dd2LvkFAr7mPAG6MwNDo
 sba2DdSh9pAKg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C06E1B6BC6;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 881983CE163;
 Fri, 12 Jun 2026 19:59:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-trivial@nongnu.org
Subject: [PULL 1/8] net/slirp: allow hostfwd socket paths with dashes
Date: Fri, 12 Jun 2026 19:59:45 +0300
Message-ID: <20260612165957.1779082-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

The format of hostfwd parameter is:
  hostfwd=hostpart-guestaddr:guestport
so a minus sign can not be part of the hostpart.
If hostpart specifies a unix socket path, this becomes problematic.

To solve this, look for the LAST minus/dash char in the string,
not first.

Unfortunately, [-guestaddr] is optional (defaults to 10.0.0.15),
so we still can't parse the thing in an uniform way.

Extend get_str_sep() to accept negative separator to indicate searching
from the end of buffer, to find the last occurence.  Update slirp_hostfwd
to search for the last separator when parsing unix domain socket path.

Inspired-by: Christopher Palmer-Richez <crichez@pm.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/347
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/slirp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index a00e0a9651..9e9941fe73 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -54,7 +54,8 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
     const char *p, *p1;
     int len;
     p = *pp;
-    p1 = strchr(p, sep);
+    /* negative sep means to search -sep from the end of buf */
+    p1 = sep >= 0 ? strchr(p, sep) : strrchr(p, -sep);
     if (!p1)
         return -1;
     len = p1 - p;
@@ -848,7 +849,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
     if (is_unix) {
-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_str_sep(buf, sizeof(buf), &p, 0 - '-') < 0) {
             fail_reason = "Missing - separator";
             goto fail_syntax;
         }
-- 
2.47.3


