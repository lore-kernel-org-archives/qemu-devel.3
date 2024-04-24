Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337B3C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpH-0001VU-Sj; Wed, 24 Apr 2024 04:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXod-0000MW-KO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoa-0006M4-CN
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1f9N5gj8dDzD4ofeRluY0Zm4ewm4jdZorGX3BtmJLI=;
 b=NhKzOmhO3ZN3Sa1vao3Vh7Zwuj2yy+Gzb9u6VpIdLf7Q2bKhpkjRjtcJi4xFtG8dA9eeOV
 /3tJFgydqQ/faetw8hczWVX9F6bAT9G61+TiVPmXh9ZU226BWv6VS5qfrtmN1cqpJGwXN4
 rNmx2sDfFi0+Ei0HY8FI/VLRcZQ0KxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-N9ZFeA_GPqufiKqkGLaxDg-1; Wed, 24 Apr 2024 04:17:13 -0400
X-MC-Unique: N9ZFeA_GPqufiKqkGLaxDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C722834FBA;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CE5A20296D2;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3A4E21D49C0; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 11/25] qapi/schema: assert resolve_type has 'info' and 'what'
 args on error
Date: Wed, 24 Apr 2024 10:16:56 +0200
Message-ID: <20240424081710.2907748-12-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

resolve_type() is generally used to resolve configuration-provided type
names into type objects, and generally requires valid 'info' and 'what'
parameters.

In some cases, such as with QAPISchemaArrayType.check(), resolve_type
may be used to resolve built-in types and as such will not have an
'info' argument, but also must not fail in this scenario.

Use an assertion to sate mypy that we will indeed have 'info' and 'what'
parameters for the error pathway in resolve_type.

Note: there are only three callsites to resolve_type at present where
"info" is perceived by mypy to be possibly None:

    1) QAPISchemaArrayType.check()
    2) QAPISchemaObjectTypeMember.check()
    3) QAPISchemaEvent.check()

    Of those three, only the first actually ever passes None; the other two
    are limited by their base class initializers which accept info=None, but
    neither subclass actually use a None value in practice, currently.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-12-armbru@redhat.com>
---
 scripts/qapi/schema.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 1034825415..0ef9b3398a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -996,6 +996,7 @@ def lookup_type(self, name):
     def resolve_type(self, name, info, what):
         typ = self.lookup_type(name)
         if not typ:
+            assert info and what  # built-in types must not fail lookup
             if callable(what):
                 what = what(info)
             raise QAPISemError(
-- 
2.44.0


