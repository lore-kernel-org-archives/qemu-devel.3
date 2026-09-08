Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8E3C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQG-0003wU-Ns; Tue, 08 Sep 2026 11:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQF-0003wG-Nx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQE-0007jO-BV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc4wVdKKRGTcZsKcqY4s15MH0d6IQvOOoL3pkebzII8=;
 b=BaQN9ep9cK1dNjeEax/LC1+sTXaesKN8diy/4MZpuXdI6AGwInbKCV3SozN9c5ORuCAHwQ
 bKAkEeVAjZvkEdBEQ/oey14tmu/ZETBD45Izsby3aRwx09JU/X7HCuPYf4XpCvB0HFEUET
 Z9W6uLyZNHYZmyHJdHomCR4ozvb++X8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-DUoQDhs2Or-kFAUWopZY5Q-1; Tue,
 08 Sep 2026 11:07:38 -0400
X-MC-Unique: DUoQDhs2Or-kFAUWopZY5Q-1
X-Mimecast-MFC-AGG-ID: DUoQDhs2Or-kFAUWopZY5Q_1788880057
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 856ED1944F0A; Tue,  8 Sep 2026 15:07:37 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1090A1955F09; Tue,  8 Sep 2026 15:07:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:54 +0400
Subject: [GIT PULL 11/15] backends/hostmem-memfd: fix "hugetlbsize"
 property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-11-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@kernel.org>, 
 Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Lqvv7cNma1pkWuS9OPNIMIEkyhwDxMpC+fmPqA3Y+7E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPJNrLlu0yT0w44yhGp4GRcVzpOAoAaoDBO
 xJlDUyD2aKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5YmWD/9RO+JSlAnsVw2zuFb04iCj1WRRUXUYm4VT2ooZZ+Uc4aMNELpnIp9KNJdv1Tg0ehdvqxd
 03BCJYznGvy743KMLt0Lx6GfEIYf7dVTtik5xMy3AsixPEJMHUgFONmypjK/QRp6WZszw3yfdIk
 dYCvdD4abzyr64F4ji4UyVYRgxH2bLd1qM2QJ4oUJzRbnxDiSx88CoLKlJH0j6+cqCQfOZz2W5w
 K05KO0YHmegf5glO05PeTltg7iHfpDfR+Z0x2lXlTEtKSxZTXKzMHeAa/ISERp48Zi/0BIC1FO+
 esN6cb3Lg21wIPOLA17XWHNu7eFvpgRTOTc4TQ7lpKhYpM25C63vShSxKn9h4LFRsv53vkicxXP
 vKHAHXe8pMRiEnIHnCs0PQpk8tGtIerZY6NoiekM9dAhtUfVO1v8hSHwAN1JfLhdoaNJZGSnOPC
 zh5HY+FT8TOtC/O5ePTZnt9ZEyQ63euhQxEnvw3y/xUsKChidiuUhoSIOBY2YqUQTo0i7f25qPV
 BTurEtjn7qCuE2N8nW7/sj86R9Uj6HKvCGniYLuqjj6VRHMTD99CLx9YSjjr07BL9Fep2ZY/wH/
 X/II7QXUS2WglhgnBt+fTTN3cqY/wPjgs2dEleqe73RiYzI42iUdmwUeFBU+SjT67Kx0gaBmI2X
 VZAaeHLwmnqk2Tw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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


