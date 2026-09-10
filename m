Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5CAC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4cqA-0007no-An; Thu, 10 Sep 2026 07:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x4cq7-0007nK-Lh
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x4cq5-0003Jr-D8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789039268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=75y8fbSSBsVoXXytlvYFVts1fH9wHg2fB8NH5CeU5QI=;
 b=Lbxxx/QvH/ABeU5n+CK/Mevd0oV8KtFIFROz3xy8A1vvtOSevYDZL60dQ59oTFTGat6MIe
 Q+bpmsG/3dFIxL4jpP1IExtb8nXYXb99eKlCWlcErrpP0f2pH3kt59aMDmB5x2o30DQ4nc
 7u9HmlOMo1vHaKMj104D9OXtkt/4rs4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-TZpbVJ-9OpivN2gHMXVXIQ-1; Thu,
 10 Sep 2026 07:21:05 -0400
X-MC-Unique: TZpbVJ-9OpivN2gHMXVXIQ-1
X-Mimecast-MFC-AGG-ID: TZpbVJ-9OpivN2gHMXVXIQ_1789039264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00CE9195411C; Thu, 10 Sep 2026 11:21:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74311180057E; Thu, 10 Sep 2026 11:21:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH] util/cutils: Use qemu_isdigit() instead of isdigit()
Date: Thu, 10 Sep 2026 13:21:00 +0200
Message-ID: <20260910112100.365573-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When building QEMU for NetBSD ("make vm-build-netbsd"), the compiler
complains:

  In file included from /usr/include/ctype.h:100,
                 from ../src/include/qemu/osdep.h:123,
                 from ../src/util/cutils.c:25:
  ../src/util/cutils.c: In function 'do_strtosz':
  ../src/util/cutils.c:245:61: warning: array subscript has type 'char' [-Wchar-subscripts]
  245 |         if (retval == 0 && *endptr == '.' && !isdigit(endptr[1])) {

isdigit() should not be used with plain "char" variables since these
can be signed and isdigit() could be implemented as a macro that uses
its parameter to index into an array. Use our wrapper qemu_isdigit()
to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/cutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index 96c80d4d429..91ddadfd15a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -242,7 +242,7 @@ static int do_strtosz(const char *nptr, const char **end,
          */
         double fraction = 0.0;
 
-        if (retval == 0 && *endptr == '.' && !isdigit(endptr[1])) {
+        if (retval == 0 && *endptr == '.' && !qemu_isdigit(endptr[1])) {
             /* If we got here, we parsed at least one digit already. */
             endptr++;
         } else {
-- 
2.55.0


