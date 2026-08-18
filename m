Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D886C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHvP-0004BE-8U; Tue, 18 Aug 2026 07:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHvO-0004AS-2f
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHvM-0007Ee-FS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dPhzg57AIP/b/5RABXJ4M7IQXJ/WdHSh89Rr6LInl4=;
 b=VL1zpzOW/qUaLfJQCXBFTslg+AzqmQHF21PotIpOVzT+AdFrn7iSEOIYun5M1z/FiWVPA1
 fg5lwlE0T9tB+Amv0BQazIf8xn0lNBwKaffEp9Wr24nW+DudFoahOvKWpB15OIRKbfWBi3
 wuv+47y8nGSY2ipuFhMnxW8K3fDKjhg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-JjBuxMZ0PByHAWTmMQydZg-1; Tue,
 18 Aug 2026 07:23:58 -0400
X-MC-Unique: JjBuxMZ0PByHAWTmMQydZg-1
X-Mimecast-MFC-AGG-ID: JjBuxMZ0PByHAWTmMQydZg_1787052236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0641118004A9; Tue, 18 Aug 2026 11:23:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 474B2180034C; Tue, 18 Aug 2026 11:23:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:13 +0400
Subject: [PATCH v3 46/74] i386/cpu: convert strList property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-46-24b8bbbe3d86@redhat.com>
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
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=P0mpI4GCVHWe5iSgcj52/XLJiYVktGNENom8IUSaw8w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD27tV2r9GWHObbNRtWkx88Kjg5gjmRpO0yAN
 Z7g5862tHeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uwAKCRDa6OEJdZac
 5XXfD/4ngHtxPMSQDPV1UM6/6C+KiwoDsBiFO4eXrCy3HfkXMS5Gtg2KyrFrZ7MABDxtEKFwBO5
 eOiRcRGHNQjyVMAG7CCkGYZif5qm5Gq5KsHoFgXFJmzB84B5z0WfBVcaBO8bu4lu+EFfZxbYXPg
 ah8YqOGOOokq9CIvVvPjFesAd5i+v5ZJ4X4BxPfuTGOtGj+KcQdMiYcblf2Y/XNJzhE3hikQ88F
 3LkF8zPOHqwjU7zwws7xlQN1qa6j3sRY96qk1lSfNAKiqD2v9pH2EVEPgEYKKxAOlw3Dvf8N6Lr
 //Aw3mER4VBEdiO1e0S4dhJjIwYg2LC+owlcV4v3EqQ6eeeuS88z+MrOrVxyVS0GWqAYJDjivpb
 tgtxWh+62Hz/S/QowaDaAnfFHvlv35IvRz6E++3cTHPs+/WoFM5uvWz2YqsEUYalLxOLu1GVEzd
 9rxs1fAhcjsMzW63Nii8YRED7k2MQkvKPNJq4l7KS9HQKE8XgmQX6is05HGl3zRhHahRvdtiIOa
 +M/ca11V0UnmkoQuHN0YH42l03vW3IxAqddcNEqCKtXgscQC6mKMDfYluWrhc+7rSTwulr0aDwD
 4noRIx6mwxc+pIoCEJVVrnIEq3FCg2yObLrbmEYiTnXG4E3HXblW+qkNRQ6Pz++yMQm7IctAqbL
 o4KCqS5/yieGhXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 472c33736f36..24bb4512ae8e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10971,7 +10971,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
      * QMP command: they list the features that would have prevented the
      * CPU from running if the "enforce" flag was set.
      */
-    object_class_property_add(oc, "unavailable-features", "strList",
+    object_class_property_add_qapi(oc, "unavailable-features",
+                              &strList_type_info,
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 

-- 
2.55.0.543.g5ebe2ebe4ea8


