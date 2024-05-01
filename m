Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D79CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2EiD-0007mo-IL; Wed, 01 May 2024 14:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2EiB-0007aV-Ra
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2Ei9-0003Rg-5F
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714588184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51PhOxKstr+7jPXShqzPTAd2+/6hX1EMNZeg4zocuws=;
 b=Xc2naGByFKQpB3yGVQFz9SrzM2L2Ca04od1Yjps1Xlcaj5SQhnB2OzB9olGG8FuaE/NYyW
 tsF4cTfcNDdrooDLWGMzgDvl5YrCFKy2yU8FL3/YLRLLgvsz9h7I495nPPVHrsZYwZ9DIz
 k5zBdaD9+r5gjhGQAmFTUysWMgZoG2w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-8JKz4Z3gO1eUAlJNRoh1nA-1; Wed,
 01 May 2024 14:29:40 -0400
X-MC-Unique: 8JKz4Z3gO1eUAlJNRoh1nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89B523C02747;
 Wed,  1 May 2024 18:29:39 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD4E0AC69;
 Wed,  1 May 2024 18:29:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 09/14] hw: temporarily disable deletion of versioned machine
 types
Date: Wed,  1 May 2024 19:27:54 +0100
Message-ID: <20240501182759.2934195-10-berrange@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The new deprecation and deletion policy for versioned machine types is
being introduced in QEMU 9.1.0.

Under the new policy a number of old machine types (any prior to 2.12)
would be liable for immediate deletion which would be a violation of our
historical deprecation and removal policy

Thus automatic deletions (by skipping QOM registration) are temporarily
gated on existance of the env variable "QEMU_DELETE_MACHINES" / QEMU
version number >= 10.1.0. This allows opt-in testing of the automatic
deletion logic, while activating it fully in QEMU >= 10.1.0.

This whole commit should be reverted in the 10.1.0 dev cycle or shortly
thereafter.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 48b6c98c77..d6214007ce 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -657,10 +657,28 @@ struct MachineState {
         } \
     } while (0)
 
+/*
+ * The new deprecation and deletion policy for versioned
+ * machine types was introduced in QEMU 9.1.0.
+ *
+ * Under the new policy a number of old machine types (any
+ * prior to 2.12) would be liable for immediate deletion
+ * which would be a violation of our historical deprecation
+ * and removal policy
+ *
+ * Thus deletions are temporarily gated on existance of
+ * the env variable "QEMU_DELETE_MACHINES" / QEMU version
+ * number >= 10.1.0. This gate can be deleted in the 10.1.0
+ * dev cycle
+ */
 #define MACHINE_VER_DELETION(...) \
     do { \
         if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
-            return; \
+            if (getenv("QEMU_DELETE_MACHINES") || \
+                QEMU_VERSION_MAJOR > 10 || (QEMU_VERSION_MAJOR == 10 && \
+                                            QEMU_VERSION_MINOR >= 1)) { \
+                return; \
+            } \
         } \
     } while (0)
 
-- 
2.43.0


