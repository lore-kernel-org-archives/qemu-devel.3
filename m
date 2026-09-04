Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3576EC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5f-0004oi-4S; Fri, 04 Sep 2026 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5d-0004d4-3y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5b-0008Ku-CP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc4wVdKKRGTcZsKcqY4s15MH0d6IQvOOoL3pkebzII8=;
 b=fq+ueyUKDENolv28UPn/sEtaxbW1tN142B7m1sX9q8U0eEojFuagsf3vZCqtyz8Y6yxLb4
 LqqBJAtI3LKLP127KZjktUz0gFE+L734oxoWJop8wGEJXkJP9mlJyYqRg/Wxa99+3CF4iJ
 adPnSnWmcL58I+y9B/cQKNJMWYvB3DM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-c4-FuaHAOpuYSVgIsLq1Ow-1; Fri,
 04 Sep 2026 16:00:38 -0400
X-MC-Unique: c4-FuaHAOpuYSVgIsLq1Ow-1
X-Mimecast-MFC-AGG-ID: c4-FuaHAOpuYSVgIsLq1Ow_1788552037
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A00B1893ED3; Fri,  4 Sep 2026 20:00:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42CE418005B5; Fri,  4 Sep 2026 20:00:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:24 +0400
Subject: [PATCH v4 41/75] backends/hostmem-memfd: fix "hugetlbsize"
 property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-41-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Lqvv7cNma1pkWuS9OPNIMIEkyhwDxMpC+fmPqA3Y+7E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKbTv+Qk77Ct2PQ2hY6eNtgWV35F1Hq1S5m
 LBB8UkIFHCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5a59EACFYL2DCxdx1DraWj6dwIR0mJR/xNsXgWiQ4+r/AoCX7rQngt8XFPlnRA+M5mVsbjuhn03
 I5wNVN6if0934MpZl2l1HaE3ckeBFGG3qAKp3aUEDW7Le7pMAivdh5Ti0luyU8C6N8TKmmfxZJd
 Sxy4VFlSziavrs6MoSt00Pax7TqF8mUajIhS+TJ0clIymAA3OMNZWQl0PF1LaB1pP4DHuGhOH2q
 aMjMrpsuGMoNOiTY/c+Sc+kbYOt8hLOg9Lm86DNPwErKoocNNvV8p1VUu4xKFZ36OyEArkkz8dO
 hwjdSW5JgmwdQM58apvcQIDywofFBs50eb7wXbGa0j5XqvX3jEo656qfpTeGiRrxaG6Iyr99HBZ
 qn61Nke5lyODerunRZ0oEryuWm0PN33Q7/9bmmeOxlBiwJxhPoQT/9AuZltSaPbnddNeGr73xAN
 bp4tu+BjPcOMZIXLv8nhBdTFGrfOIafrjWCUnFEE6Ejd2ZfIOjSDc0WkmCNuPAe8cwhZlUxGshM
 EcejUKjbS3J0ELbLHE7Uht25VACh3Tlcf6Pvx05wt5YTegdt8qiaNaCd4YlqdBcQy3kMEeGonaR
 WFhU1LurXXe70vG7V0yqHMtzGiRy2Yw3ybLKNMBmeNtNDx9O/XgUwTR0uAgTuY+KjbdCCvPErnB
 iCSwWwQRHpsYFaQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The getter and setter use visit_type_size, not visit_type_int.
Since the underlying value is uint64, switch to that.

Fixes: 3829640049cf ("hostmem-memfd: add checks before adding hostmem-memfd & properties")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-memfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 923239f9cf69..e21c5a3f2e24 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -89,7 +89,7 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_size(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
     if (!value) {
@@ -107,7 +107,7 @@ memfd_backend_get_hugetlbsize(Object *obj, Visitor *v, const char *name,
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
     uint64_t value = m->hugetlbsize;
 
-    visit_type_size(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static bool
@@ -145,7 +145,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                        memfd_backend_set_hugetlb);
         object_class_property_set_description(oc, "hugetlb",
                                               "Use huge pages");
-        object_class_property_add(oc, "hugetlbsize", "int",
+        object_class_property_add(oc, "hugetlbsize", "uint64",
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
                                   NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


