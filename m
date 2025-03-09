Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1378CC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH4v-0008Jj-QV; Sun, 09 Mar 2025 09:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4t-0008B2-8q
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4q-0002gI-2k
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmUhIz0pU1pz6YGmXB7wCr8A1w9Dx1XLPXmsJziuv5w=;
 b=DTDAXsbxngj98NtWdktiUuPboOaoCUaCXUW7sMC28FWXqkyqLWVW8lkXLCs5mRjK22j03N
 O6+y19mF9C2LyDJMqiNhMSlmoj3Bo0nR9dnJj99k7fCkx5SYO4L+RruSJ4E2rlO0Vgt76B
 ZVFu1QycV/RqHVuWECFw9fp+6oFmSvM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-bTA39x9JPrmx8EmsBptNqw-1; Sun,
 09 Mar 2025 09:52:18 -0400
X-MC-Unique: bTA39x9JPrmx8EmsBptNqw-1
X-Mimecast-MFC-AGG-ID: bTA39x9JPrmx8EmsBptNqw_1741528337
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 377D518004A9; Sun,  9 Mar 2025 13:52:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B58D1956094; Sun,  9 Mar 2025 13:52:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/46] hw/arm/aspeed_ast27x0.c Separate HW Strap Registers for
 SCU and SCUIO
Date: Sun,  9 Mar 2025 14:51:00 +0100
Message-ID: <20250309135130.545764-17-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

There is one hw-strap1 register in the SCU (CPU DIE) and another hw-strap1
register in the SCUIO (IO DIE). The values of these two registers should not be
the same. To reuse the current design of hw-strap, hw-strap1 is assigned to the
SCU and sets the value in the SCU hw-strap1 register, while hw-strap2 is
assigned to the SCUIO and sets the value in the SCUIO hw-strap1 register.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250304064710.2128993-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 56e43d45ad22..4cee6ddc0b57 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -333,14 +333,21 @@ static void aspeed_soc_ast2700_init(Object *obj)
                          sc->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
                               "hw-strap1");
-    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
-                              "hw-strap2");
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
 
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
                          sc->silicon_rev);
+    /*
+     * There is one hw-strap1 register in the SCU (CPU DIE) and another
+     * hw-strap1 register in the SCUIO (IO DIE). To reuse the current design
+     * of hw-strap, hw-strap1 is assigned to the SCU and sets the value in the
+     * SCU hw-strap1 register, while hw-strap2 is assigned to the SCUIO and
+     * sets the value in the SCUIO hw-strap1 register.
+     */
+    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scuio),
+                                  "hw-strap1");
 
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     object_initialize_child(obj, "fmc", &s->fmc, typename);
-- 
2.48.1


