Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C818606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I4agY6rA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7N3-00032c-VK; Wed, 11 Nov 2026 07:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mq-00030I-9O
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mn-0000aM-FJ
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62srTw2+wEyhFy6oLDYqzbOfVJVthJpFlv/797xXiCQ=;
 b=I4agY6rA364L48YDZq8wABcx9NZj1MWymSBe9pi9KxDKIGt374kH0dRV7fUGZp4gmCT5Gc
 MO8S4+Y6GVHGNWMwKgR8Tde3P57GpoYWU4edzetvwuzeZvyUFPfuaMJ2UM6ebm3EC7F7uo
 2Z+Eoh8eFZCzzLgL071x5IbOL9pJg+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-Ch4UfNpTO9W7EMNyXLabhQ-1; Wed,
 11 Nov 2026 07:23:48 -0500
X-MC-Unique: Ch4UfNpTO9W7EMNyXLabhQ-1
X-Mimecast-MFC-AGG-ID: Ch4UfNpTO9W7EMNyXLabhQ_1794399828
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4F561955E9E; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3E7B428; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A4CF21E6884; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 5/7] backends/hostmem-memfd: Register QOM type unconditionally
Date: Wed, 11 Nov 2026 13:23:40 +0100
Message-ID: <20261111122342.634370-6-armbru@redhat.com>
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We register QOM type "memory-backend-memfd" only when a test of
memfd_create() succeeds.  Such conditional registration is unusual and
problematic:

1. Management applications use introspection interfaces to find out
what a certain QEMU can do.  Conditional type registration makes QOM
introspection results depend on the condition, which generally makes
them valid only for the process that produced them.  Undesirable.

2. For user-creatable objects like "memory-backend-memfd", it also
makes QAPI introspection unreliable: query-qmp-schema claims the type
exists (object-add argument @qom-type accepts "memory-backend-memfd")
even when it doesn't.

Conditional registration actually serves no purpose here, because we
still have to memfd_create() for real when we create the object, and
need and do handle errors then.

Register the type unconditionally.

To test, I hacked the qemu_memfd() call to fail.  The error for
-object memory-backend-memfd,id=mem0,size=1m changes from

    qemu-system-x86_64: invalid object type: memory-backend-memfd

to

    qemu-system-x86_64: can't create 'memory-backend-memfd': failed to create memfd with flags 0x3: Invalid argument

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/hostmem-memfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 11d456e3ebd..54f84ae331a 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -223,9 +223,7 @@ static const TypeInfo memfd_backend_info = {
 
 static void register_types(void)
 {
-    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
-        type_register_static(&memfd_backend_info);
-    }
+    type_register_static(&memfd_backend_info);
 }
 
 type_init(register_types);
-- 
2.55.0


