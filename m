Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAB9C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a6M-0008Kj-6y; Fri, 04 Sep 2026 16:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6K-00082d-7S
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6H-0008Qt-NJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqbhsKNjbgDXlQcuFtKvsuc9htp5BzIptdWvWLI5SlA=;
 b=E52iaT4NuTWhJzT58Ua3AS8XOnweUtW3vCaVDjk1+jq5w6nJiJO0P24cy3i+5zAvVs6vOA
 79HWQ9020jV7sI7aw6MCGwx+TCQFUVXT2nYVOyDBDiZySX6mviOg7+TKYUC2WrxGlhaUV7
 LxLioPD1XxFJMNdYeVCwHzqrrp3smUc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-uqSMrFebOG6q6pJ4rC9taQ-1; Fri,
 04 Sep 2026 16:01:17 -0400
X-MC-Unique: uqSMrFebOG6q6pJ4rC9taQ-1
X-Mimecast-MFC-AGG-ID: uqSMrFebOG6q6pJ4rC9taQ_1788552064
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E89019792DA; Fri,  4 Sep 2026 20:01:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9478830002F4; Fri,  4 Sep 2026 20:01:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:30 +0400
Subject: [PATCH v4 47/75] i386/cpu: convert strList property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-47-a985f168e938@redhat.com>
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
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SPRNseSbAdO6Ph77aIE7aq7IziNtT5hbLLPbez+gQAA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKwEGY7uDbn4CvFUvrfo40tXmrHG5DRw2x/
 taT8YmKYE2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5boID/9FsU0ecwmOF/m+ceIXZ1PtzxmVqI5abF+b9YkODS/rtXPQm/tLB82yVeqSOnBbOlwIL0h
 d8ANDXHfRMwildkgrrqvgxienBelNBbQhONzmR/SgUlg+6LKQHhu1yPU7TmNxF7iTrNejWprd2A
 TG0q8fEYByIwLqCrt3MGUHTCxkxfYx62PiA+zsbH6kBCdzRIGMykaFHHzKvyo7M+REqjYBL9JY0
 simpfgjNxtjEzMuYHJUIAFb+A518XtsH665yA1zxO0fDJvk13BRyCrHUz8oaZIob2lGHT7xOT4D
 FTTcY4wf8rntzCPA5q4IvD8B4TMoEY+7Pth90d8oP+PLuYm46XMfsa3WZQRqlVxxVeUtFCiRXJ4
 JPtyFN3Vv7DetORiYhG9YTTIIjXknXgUhxB0NYE5Nv4+xzC5K9Y9j3Jey2r1A2IO7zaT7bch/+q
 XqkA1wY8PJmLMfD8Xitl2v+FenQ4DVhGAqWmNzXLsXFKJJp0/A2utm36kIE+PRedqxukWQlwupF
 rRoSDOoafmgBocnFEwacBPrxOy68eCxza3OjjzydSk93DapqRoMUqy3o4iJxtqTOOoNxo36Gn5d
 L6Pu2MsiayHEgDS27aKV6mDecDB76zguufZgpa4aBoKX8W+miFS6a2UZ12E9ERuHsT0Kz56Xhbr
 YNzqvEweAiPtRkw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ebce8e128224..f5a9d7c3d2c2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10974,7 +10974,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
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


