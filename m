Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=YsfiCcVn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMvgr-0004Yw-4t; Fri, 30 Oct 2026 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xMvgo-0004YY-U5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 19:07:14 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xMvgn-0000ox-8V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 19:07:14 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jGcDn0bvbz8Pbj;
 Fri, 30 Oct 2026 19:07:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=uqcjuzOwYh+6MZvjUSA96NoFjyRNAzR7AYpjvCoafrk=; b=Ysfi
 CcVnQ6GAtiqz+R1dE89KKeSIjptkX38H1Usb8zF1sUb/8xixQf+f5SUj+WddXQ3Z
 6pLgYgaxxQvkf+XKt8VUKArO9uMbshPnV+evLEhjP4CXdG7xWIcf8ErpeozOhAU4
 EJC6jwW9LD8eaz0U85S7WHJRnLwUWn7x45Gxu/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=q3JnAbQeg9bxZmg2MZVY59B4p1T+jhKzK84VdLPr8dO+HAGbxBvKI
 VtEDe1bjhppqjcu5nwMfiJ7zldpDevJm2CeajmED4CCq/eVtH4xv2tnxiBXyvoCD
 phb7ArhDDu08tY3YdWhwWr+hJkQM2L6iGhwvopEF740zP3iWVcOeTg=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:72be:d7:b79c:1bb7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jGcDn0PFjz8Pbg;
 Fri, 30 Oct 2026 19:07:05 -0400 (EDT)
Date: Fri, 30 Oct 2026 19:07:03 -0400
From: Brad Smith <brad@comstyle.com>
To: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] qga: fix uname() return value check in guest-get-osinfo
Message-ID: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qga: fix uname() return value check in guest-get-osinfo

POSIX only specifies that uname() returns a non-negative value on
success. Solaris returns 1, so guest-get-osinfo treated every
successful call as a failure and reported a stale errno.

Check for a negative return value instead, as linux-user/uname.c
already does.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 qga/commands-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index dcc683f6c9..23abaf1956 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1322,7 +1322,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     info = g_new0(GuestOSInfo, 1);
 
-    if (uname(&kinfo) != 0) {
+    if (uname(&kinfo) < 0) {
         error_setg_errno(errp, errno, "uname failed");
     } else {
         info->kernel_version = g_strdup(kinfo.version);
-- 
2.56.0


