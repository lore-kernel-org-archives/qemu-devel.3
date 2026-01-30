Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D5D73EB5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlf3m-0006UT-TN; Thu, 29 Jan 2026 22:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf3k-0006Rz-KI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 22:20:36 -0500
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1vlf3e-0002Sw-Eq
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 22:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail2; t=1769743224; x=1770002424;
 bh=WVy4sNDOphKTLy9/cV+3JDIaPJ0F26seSVQGtB0EQjo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bbSQYFks0nbbdSXG6XpImZQ6V3LSVvL83xRrmSYrKJ02WWzQ/02utO8meIHHpaDyr
 wdrMJVq7cKNfEIasjanLVdYMcX1+bfntWo8HIp/nJJMSA4sJxcnOG2uJy05MJDybsi
 9GaI4yJF6hFXDiKznMWXsYPdB2umx10yhxirnRywyG4aDADhdTYb2HhhEhLqWob5zS
 FALmKP5AEK1xO6q3NASjNApWdoj+Yr3Hz7UYcrsY7mgzgOZzBLc9kT7xft1pOuqW8m
 iT85Mf/8IrRt5ytp+uxgvSxkrtx9o3HqrufygIkqjGhTo7RhVjo5OUVkstGaqwB1ui
 3ytv6R5KKPJ4g==
Date: Fri, 30 Jan 2026 03:20:20 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v3 1/4 qemu] Include new arbitrary limits if not already
 defined
Message-ID: <20260130031954.1661880-2-damien@zamaudio.com>
In-Reply-To: <20260130031954.1661880-1-damien@zamaudio.com>
References: <20260130031954.1661880-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: 5579f7624c42d0964bd65989e5584d5529c43fb9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45; envelope-from=damien@zamaudio.com;
 helo=mail-06.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Manolo de Medici <manolodemedici@gmail.com>

Although GNU/Hurd supports unlimited path lengths
only bounded by available memory, for now we can use
an arbitrary limit on PATH_MAX that matches what POSIX requires.
We don't have the bandwith to fix this properly right now.

Author: Manolo de Medici <manolo.demedici@gmail.com>
Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 include/qemu/osdep.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b384b5b506..2e67d75042 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -385,6 +385,17 @@ void QEMU_ERROR("code path is reachable")
 #define TIME_MAX TYPE_MAXIMUM(time_t)
 #endif
=20
+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+/*
+ * Use the same value as Linux for now.
+ */
+#ifndef IOV_MAX
+#define IOV_MAX 1024
+#endif
+
 /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
  * the wrong type. Our replacement isn't usable in preprocessor
  * expressions, but it is sufficient for our needs. */
@@ -661,10 +672,6 @@ struct iovec {
     void *iov_base;
     size_t iov_len;
 };
-/*
- * Use the same value as Linux for now.
- */
-#define IOV_MAX 1024
=20
 ssize_t readv(int fd, const struct iovec *iov, int iov_cnt);
 ssize_t writev(int fd, const struct iovec *iov, int iov_cnt);
--=20
2.51.0



