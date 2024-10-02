Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8153CF319D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuPT-0006jb-76; Wed, 02 Oct 2024 04:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svuPQ-0006iu-4H
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svuPO-0002b6-Do
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727856509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yt5iZp1dTfoGX3oQl/S895IgZ8jP2df8Omr2EArZoPk=;
 b=gd4DzG7d/9UR4eMFzEWx434fHXgSYoZ+XSP6+TJPqlTPX+MC7CZsVr+y9XXmXla85sihdP
 ddxwnh83U2rH5jsVwP53cmEXz4o/mqTAfqwmXBA+i71RG63pid32Q9TW9e4BBYkrWhD5jI
 d1jdraz7qJHcFaSoIktE456uUAYpJWc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-QIgxOhqPNiSzKbTBPKpFoA-1; Wed,
 02 Oct 2024 04:08:25 -0400
X-MC-Unique: QIgxOhqPNiSzKbTBPKpFoA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DE3C1944F03; Wed,  2 Oct 2024 08:08:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA69919560A3; Wed,  2 Oct 2024 08:08:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/3] qom: update object_resolve_path*() documentation
Date: Wed,  2 Oct 2024 12:08:06 +0400
Message-ID: <20241002080806.2868406-4-marcandre.lureau@redhat.com>
In-Reply-To: <20241002080806.2868406-1-marcandre.lureau@redhat.com>
References: <20241002080806.2868406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

- update doc to reflect that @ambiguous is now set true or false on failure
- specify that @ambiguous is nullable
- use some gtk-doc annotations

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 13d3a655dd..2af9854675 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1569,8 +1569,8 @@ char *object_get_canonical_path(const Object *obj);
 /**
  * object_resolve_path:
  * @path: the path to resolve
- * @ambiguous: returns true if the path resolution failed because of an
- *   ambiguous match
+ * @ambiguous: (out) (optional): location to store whether the lookup failed
+ *   because it was ambiguous, or %NULL. Set to %false on success.
  *
  * There are two types of supported paths--absolute paths and partial paths.
  * 
@@ -1587,7 +1587,7 @@ char *object_get_canonical_path(const Object *obj);
  * only one match is found.  If more than one match is found, a flag is
  * returned to indicate that the match was ambiguous.
  *
- * Returns: The matched object or NULL on path lookup failure.
+ * Returns: The matched object or %NULL on path lookup failure.
  */
 Object *object_resolve_path(const char *path, bool *ambiguous);
 
@@ -1595,10 +1595,10 @@ Object *object_resolve_path(const char *path, bool *ambiguous);
  * object_resolve_path_type:
  * @path: the path to resolve
  * @typename: the type to look for.
- * @ambiguous: returns true if the path resolution failed because of an
- *   ambiguous match
+ * @ambiguous: (out) (optional): location to store whether the lookup failed
+ *   because it was ambiguous, or %NULL. Set to %false on success.
  *
- * This is similar to object_resolve_path.  However, when looking for a
+ * This is similar to object_resolve_path().  However, when looking for a
  * partial path only matches that implement the given type are considered.
  * This restricts the search and avoids spuriously flagging matches as
  * ambiguous.
-- 
2.45.2.827.g557ae147e6


