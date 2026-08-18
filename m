Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BE4C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHri-0006Yp-98; Tue, 18 Aug 2026 07:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrg-0006Xm-Ij
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHre-0006iQ-Iw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EeAJceYlgEHPn5rZ7Ch0GVKDUfnI9lHjds0xq0+jCA=;
 b=X2rgbX+SdowRYHvKglzcn6u5a5UilMdLJa2o2yN+zMgm/HAu2hAgziUbXwdMXek8C3I8hG
 YZRo2zE8TQ22ajl4g3NqQOoOMRxf+EjvDUQmsgXDH+VY63w4ksENCxinwanTEeddgyntb3
 QT1HvcQ9hbb8uNrC/eBzKrEUuZVVaWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-Dy7mJQhaNiGoXbpIh5te1g-1; Tue,
 18 Aug 2026 07:20:14 -0400
X-MC-Unique: Dy7mJQhaNiGoXbpIh5te1g-1
X-Mimecast-MFC-AGG-ID: Dy7mJQhaNiGoXbpIh5te1g_1787052013
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C66519560B4; Tue, 18 Aug 2026 11:20:13 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8A1A434; Tue, 18 Aug 2026 11:20:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:59 +0400
Subject: [PATCH v3 32/74] backends/hostmem-file: fix "align" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-32-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=945;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3OAzBeiuJnoEej4d65hGPxt8kwJF0iyloYN1xTb4Trk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD25gzgRDSOTcq3hns33Ic0VataMAJNfqb1zG
 dDAhU/yuHaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5TV9D/98irIfyj53vsu4CQQ9BahT4qXupV7apnywBJMrJ75jaAJfej+vzqg17PsPDyKFb+cqytd
 a3MJtZxpfxsHlQRg0nmKmeBIPtl7Tqv2g6mTRABUQJh3YJHXAp4q7IsF00JTwkYWUPmN7ftfahm
 Od1eoR/WNAbXvtLoDoCNpasZncmBCZV90Tz4cmTl8CElWo5SbIU9y6j6om4zKjx249aUsprVVBj
 FiIofNkPo/lHv2HgTnxTYefIa3WHNlM8G6Fi/0PRK1tp4nIUxAQK9YAteYTdT7yjUYyFi9a5ufb
 6DDsdYOew8emG6w0LRNXIBUAiAUIpDG5y2+zt+PnDcl/FbuQ9T0TnbxdZSH6vI+3lCTfAo0ZH7y
 FoejoMdmib9zRmFqZZliIfEjTxus0k64L5OmPF6IDXvOOZ/aocLgrdO7P75ciesfrdCfMN94xVf
 ft8Ex9FfovY1M8OcmWs1Npsp756mkkkjuFU+H/JBsTKnnC3uS02n/Jx7M2uCvomzbbaJMZUWYQG
 vm/jSCDhIIQzuBep43gok4KCjpJBrHctGO5SrdK9YImK5Yj+XycOVs4MyxGLbC1OIuzYtynUeaK
 56E4N0jpPmMyHi5u0kAvgzv7xQAX48c3G1vkIk5+Z5vpB5sOOCOwm1yEIcrjvSYCXuMJJGtZJ+S
 /oQG0jfmVEHpJKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fixes: 983768431676 ("hostmem-file: add "align" option")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 52b62f715334..39a46d353839 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -275,7 +275,7 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path);
-    object_class_property_add(oc, "align", "int",
+    object_class_property_add(oc, "align", "size",
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


