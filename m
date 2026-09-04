Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20241C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5V-0003hz-OW; Fri, 04 Sep 2026 16:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5S-0003O7-34
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5Q-0008IW-F2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I45vBLy8mR9FO7QFOJ9NNNU2qKzB6oMkrFNeXIX3qdg=;
 b=VkI2WCZ34P+S21uFZBcYgzMOSwiXH5+61mGvr5H0pIzPB3eKn719ZeoAJ9wyK7rLLuhEZo
 CkfAQjymDEggdo0+IgfbnjodGBoPWgGp9Eusy65vZ+jWQQV+ZNPSCvc233KH2laytWlmdb
 zdwcwwyWUQx50XlrJRaxdd0YAAGtnN0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-jHdQ1ck3M72sx02V018i8w-1; Fri,
 04 Sep 2026 16:00:28 -0400
X-MC-Unique: jHdQ1ck3M72sx02V018i8w-1
X-Mimecast-MFC-AGG-ID: jHdQ1ck3M72sx02V018i8w_1788552027
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4813818D727A; Fri,  4 Sep 2026 20:00:27 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F7611955F0D; Fri,  4 Sep 2026 20:00:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:21 +0400
Subject: [PATCH v4 38/75] util/thread-context: fix property typenames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-38-a985f168e938@redhat.com>
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
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=06uELAnv7q0WduS1iwJjsed0nBZGdIUdjr/uI9WI748=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKixMPjsuy6lbj+NvLjbk+ARkgK45C1mONf
 C3nDAOD1lOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5f3PD/wMNHXjcPj2TqY9zdTliK0DR246VdnZyn2ZaP7vyWyje9td+jUWeKSsTFqTDxqCyB1bPZG
 VT/RmfpPCciSR0ZLm7T8qhShJnDiA/iIFY50jwUGL8gXLig0dKhuMDLGSIZw6cJ4nr44iXI3+XE
 7lwkwvmMdVBKNxk4z7k0xwe75SRxVdLLK9vDyI7lwzPkrhy67zPHrY/DF3lvuCbdib8B2r+oe/r
 1Gt5BkZv1PPxW4rR0mbT8lwR9qAXaEdm36BX4VtzblFXoVXN8g8YwWXGeNBt0c2XUzaGXm27roM
 lRtzCsxTBdYHaqmRvSUTRrRLL0GuB9cwROpiqE5NqGGfEvoVE/kdm0ZSQkKvOnxn99sMPRDriW6
 /+96BMIG93szhT93VtJKwOnkvqw/MNV2WX6zj1dP4zipMnkWuDA923yeBRwXb6pMWe2Zh2ntMAr
 lqNDgE9l3wZOaL3cvmauVs/GjSJzRX/0vVMMBaFlWQtfZ6CMtbJuXsaHmqK/wIG+xUk4pRG887G
 geo54yCrT2o7BI5XZCc6bnwtXyjUl3UyW7WYXZo6SK4xbB+uKDzYbbjbjalXCCg5zBD3Xj4c5vb
 AUVG21gz4QY91qhvmU0ABL1Y45Iw7kdUuZn8lfzBt3OlLAA5hHimoqSECY2c1iu6lcMWa2/LHB7
 bzYpkgmTFyyI+Pw==
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

"thread-id" uses visit_type_uint64, "cpu-affinity" and
"node-affinity" use visit_type_uint16List, not visit_type_int.

Fixes: e2de2c497e57 ("util: Introduce ThreadContext user-creatable object")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/thread-context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/thread-context.c b/util/thread-context.c
index 0146154fa56b..88d8f0a55a4e 100644
--- a/util/thread-context.c
+++ b/util/thread-context.c
@@ -278,13 +278,13 @@ static void thread_context_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = thread_context_instance_complete;
-    object_class_property_add(oc, "thread-id", "int",
+    object_class_property_add(oc, "thread-id", "uint64",
                               thread_context_get_thread_id, NULL, NULL,
                               NULL);
-    object_class_property_add(oc, "cpu-affinity", "int",
+    object_class_property_add(oc, "cpu-affinity", "[uint16]",
                               thread_context_get_cpu_affinity,
                               thread_context_set_cpu_affinity, NULL, NULL);
-    object_class_property_add(oc, "node-affinity", "int", NULL,
+    object_class_property_add(oc, "node-affinity", "[uint16]", NULL,
                               thread_context_set_node_affinity, NULL, NULL);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


