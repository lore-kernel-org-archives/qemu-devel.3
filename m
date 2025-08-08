Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC87DC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 08:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9Y-00079c-EX; Fri, 08 Aug 2025 04:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9V-00075U-IG
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9T-0006Um-NX
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLTZcSj7iNq5OuEH8/JlnbJNdOKdUQD0MxDROOyY5U8=;
 b=R7AeL6L+TOVR+MdyM+VWCvti/c10sgZBIcL2qZ885aARY3YlHZEpzx9lX2nKzqYp7cPl7L
 hrCff3Fcg1nbP5hi3cHfwF00pVSD2F23vVDty4DX/6fug6O9l5bvGKp9tO5wXaU8OCemjx
 l7hlJ6H39+gfJiZa8DYtHyu/UU7dYVA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-KJDt79g7NeurZo2YeYiZsg-1; Fri,
 08 Aug 2025 04:08:31 -0400
X-MC-Unique: KJDt79g7NeurZo2YeYiZsg-1
X-Mimecast-MFC-AGG-ID: KJDt79g7NeurZo2YeYiZsg_1754640510
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0941B1956080; Fri,  8 Aug 2025 08:08:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67FDD19560B0; Fri,  8 Aug 2025 08:08:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63A0C21E6741; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp,
	marcandre.lureau@redhat.com
Subject: [PATCH 08/12] util/oslib-win32: Revert warning on WSAEventSelect()
 failure
Date: Fri,  8 Aug 2025 10:08:19 +0200
Message-ID: <20250808080823.2638861-9-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-1-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
NULL @errp as &error_warn.  This is wildly inappropriate.  A caller
passing NULL specifies that errors are to be ignored.  If warnings are
wanted, the caller must pass &error_warn.

I'm not familiar with the calling code, so I can't say whether it will
work after WSAEventSelect() failure.  If it doesn't, then this should
be an error.  If it does, then why bother the user with a warning that
isn't actionable, and likely confusing?

The warning goes back to commit f5fd677ae7cf (win32/socket: introduce
qemu_socket_select() helper).  Before that commit, the error was
ignored, as indicated by passing a null @errp.  Revert to that
behavior.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/oslib-win32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b7351634ec..136a8fe118 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -296,10 +296,6 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
 {
     SOCKET s = _get_osfhandle(sockfd);
 
-    if (errp == NULL) {
-        errp = &error_warn;
-    }
-
     if (s == INVALID_SOCKET) {
         error_setg(errp, "invalid socket fd=%d", sockfd);
         return false;
-- 
2.49.0


