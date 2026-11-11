Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1B606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iXgDrk/P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Mx-00031v-W8; Wed, 11 Nov 2026 07:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mq-00030J-Ae
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xR7Mn-0000aK-FA
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794399832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYeIuHkJq8KVmqRw5LWmD+FFHqEWlzgVfMlQuWH72/4=;
 b=iXgDrk/PXL90mDY9YO5nEP9w4kSCKKV4Fl6OTB2BgUUAlMD8aEcMQrbmOkt0IzeturARhJ
 pqyvduLrd8DEpclYtB5fUnEpTQAZW1tSv1FmnzHPxT7smmwNSmIdAlHaTnm+IHLPuyFKuw
 rKV6G3heoAhN4+yaAtusRqDVZ9NCHJk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-sS5pvsqDNRSktdh4QG0vqg-1; Wed,
 11 Nov 2026 07:23:48 -0500
X-MC-Unique: sS5pvsqDNRSktdh4QG0vqg-1
X-Mimecast-MFC-AGG-ID: sS5pvsqDNRSktdh4QG0vqg_1794399827
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE0E41800D98; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C99E1800495; Wed, 11 Nov 2026 12:23:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5256721E6886; Wed, 11 Nov 2026 13:23:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 7/7] backends/hostmem-memfd: Add huge TLB properties
 unconditionally
Date: Wed, 11 Nov 2026 13:23:42 +0100
Message-ID: <20261111122342.634370-8-armbru@redhat.com>
In-Reply-To: <20261111122342.634370-1-armbru@redhat.com>
References: <20261111122342.634370-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We add class properties "hugetlb" and "hugetlbsize" only when a test
of memfd_create() succeeds.  Such conditional registration is unusual
and can be problematic:

1. Management applications use introspection interfaces to find out
what a certain QEMU can do.  Conditional property addition makes QOM
introspection results depend on the condition, which generally makes
them valid only for the process that produced them.  Undesirable.

2. For user-creatable objects like "memory-backend-memfd", it also
makes QAPI introspection unreliable: query-qmp-schema claims the
properties exist (object-add takes arguments @hugetlb and @hugetlbsize
when argument @qom-type is "memory-backend-memfd") even when it
doesn't.

Conditional registration actually serves no purpose here, because we
still have to memfd_create() for real when we create the object, and
need and do handle errors then.

Moreover, we actually KVM ioctl KVM_CREATE_GUEST_MEMFD instead of
memfd_create() there when @guest-memfd is on.  If the memfd_create()
check can fail when the ioctl could still succeed, the condition is
counter-productive.

Add the properties unconditionally.

To test, I hacked the qemu_memfd() call to fail.  The error for
-object memory-backend-memfd,id=mem0,size=1m,hugetlb=off,hugetlbsize=512,seal=on
changes from

    qemu-system-x86_64: Property 'memory-backend-memfd.hugetlbsize' not found

to

    qemu-system-x86_64: can't create 'memory-backend-memfd': failed to create memfd with sealing and without huge pages: Invalid argument

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 backends/hostmem-memfd.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 54f84ae331a..b945fc46021 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -184,20 +184,18 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
 
     bc->alloc = memfd_backend_memory_alloc;
 
-    if (qemu_memfd_check(MFD_HUGETLB)) {
-        object_class_property_add_bool(oc, "hugetlb",
-                                       memfd_backend_get_hugetlb,
-                                       memfd_backend_set_hugetlb);
-        object_class_property_set_description(oc, "hugetlb",
-                                              "Use huge pages");
-        object_class_property_add(oc, "hugetlbsize", "uint64",
-                                  &uint64_type_info,
-                                  memfd_backend_get_hugetlbsize,
-                                  memfd_backend_set_hugetlbsize,
-                                  NULL, NULL);
-        object_class_property_set_description(oc, "hugetlbsize",
-                                              "Huge pages size (ex: 2M, 1G)");
-    }
+    object_class_property_add_bool(oc, "hugetlb",
+                                   memfd_backend_get_hugetlb,
+                                   memfd_backend_set_hugetlb);
+    object_class_property_set_description(oc, "hugetlb",
+                                          "Use huge pages");
+    object_class_property_add(oc, "hugetlbsize", "uint64",
+                              &uint64_type_info,
+                              memfd_backend_get_hugetlbsize,
+                              memfd_backend_set_hugetlbsize,
+                              NULL, NULL);
+    object_class_property_set_description(oc, "hugetlbsize",
+                                          "Huge pages size (ex: 2M, 1G)");
 
     object_class_property_add_enum(oc, "guest-memfd", "OnOffAuto",
                                    &OnOffAuto_type_info,
-- 
2.55.0


