Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E5CF31A0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuPO-0006iU-ST; Wed, 02 Oct 2024 04:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svuPL-0006hv-77
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svuPD-0002Yn-Qd
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727856498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVkQIUGda3DTCbaq/5d+CBdPER8ydShcszuxJPMfK7U=;
 b=NDyyX1hcNoOqnty/kpBNwW/i9KWTKUWQVa7GgYDBD2GwU9T2nWEo3yyDqZ3UE9aj3D1xD2
 NkwSpnbsd1EnvdSNSLhRa2ItIoy3yNNqlx8ezeoj/B+Ur5Ssn4+tt7QmMUg4J7R8dV8s/9
 eWwCHLrSbHMb56oJozzPg4fs1BJCWUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-8g1PFlA9PMyXtMVrHSjTmg-1; Wed,
 02 Oct 2024 04:08:16 -0400
X-MC-Unique: 8g1PFlA9PMyXtMVrHSjTmg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E12661955E8E; Wed,  2 Oct 2024 08:08:15 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBD133000197; Wed,  2 Oct 2024 08:08:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/3] qom: rename object_resolve_path_type() "ambiguousp"
Date: Wed,  2 Oct 2024 12:08:04 +0400
Message-ID: <20241002080806.2868406-2-marcandre.lureau@redhat.com>
In-Reply-To: <20241002080806.2868406-1-marcandre.lureau@redhat.com>
References: <20241002080806.2868406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
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

Make it match the function declaration & documentation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 28c5b66eab..0adbef2946 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2184,7 +2184,7 @@ static Object *object_resolve_partial_path(Object *parent,
 }
 
 Object *object_resolve_path_type(const char *path, const char *typename,
-                                 bool *ambiguousp)
+                                 bool *ambiguous)
 {
     Object *obj;
     char **parts;
@@ -2193,11 +2193,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
     assert(parts);
 
     if (parts[0] == NULL || strcmp(parts[0], "") != 0) {
-        bool ambiguous = false;
+        bool ambig = false;
         obj = object_resolve_partial_path(object_get_root(), parts,
-                                          typename, &ambiguous);
-        if (ambiguousp) {
-            *ambiguousp = ambiguous;
+                                          typename, &ambig);
+        if (ambiguous) {
+            *ambiguous = ambig;
         }
     } else {
         obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
-- 
2.45.2.827.g557ae147e6


