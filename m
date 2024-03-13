Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05545C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRK-00084S-HT; Wed, 13 Mar 2024 00:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQs-0007tQ-Qb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQp-0001qg-BA
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2I5t1vA5twX5O+nB7fme1OJngjl4AglH3dg6yYkL/Yk=;
 b=SwhnGDRqT6ge3Ar1LwGZsScUts8LsDfA9SUyCm9ySs4Et9ZaZ/NYgH8Ics+94Aj8fI+Xc5
 Z3GXqFxcbBsYeg7kMME+KkN26R1UmdacWBNETXKmtcaEpvIztH+/HoFC8LSV1c7tXcYXae
 V5tGKGPnjnAgzMXm79eNf3IRU8yjqc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-SJ4GzRf-OHqWOasp9VzgvA-1; Wed, 13 Mar 2024 00:41:32 -0400
X-MC-Unique: SJ4GzRf-OHqWOasp9VzgvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9048980F7E3;
 Wed, 13 Mar 2024 04:41:32 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54EEC10E4B;
 Wed, 13 Mar 2024 04:41:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 11/23] qapi/schema: assert resolve_type has 'info' and
 'what' args on error
Date: Wed, 13 Mar 2024 00:41:15 -0400
Message-ID: <20240313044127.49089-12-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 scripts/qapi/schema.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b157a3b2bd8..f5c7789d98f 100644
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


