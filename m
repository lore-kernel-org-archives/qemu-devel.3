Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35321CD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjOS-0002Bd-6j; Sat, 06 Jun 2026 01:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOK-0002BE-Qr
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOJ-0008Da-AR
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780722974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40y9nUEM2k+DgX74L7br+FVh1cGqfh7EYiI+WllmI9w=;
 b=FbYOpK6th0sihw3mY7eLOuTW8WqjEeObP25fAtCons+LkfspeBZuh1FjlnsGbMMUVsRIMS
 nQfxyhDfIEaZXJHSxaPM2IieAR7qoS3zJPjL1XPN+Lhk2SXpXMKBZHG/9Zd300k2eUUc8d
 645aHsKFF/a0xSxhpahT395DdJIgRoI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-xevUJlomP7KpSiBhzLqKlA-1; Sat,
 06 Jun 2026 01:16:13 -0400
X-MC-Unique: xevUJlomP7KpSiBhzLqKlA-1
X-Mimecast-MFC-AGG-ID: xevUJlomP7KpSiBhzLqKlA_1780722972
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CDC81956089
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 049CD1766; Sat,  6 Jun 2026 05:16:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:38 +0400
Subject: [GIT PULL v2 06/23] hw/ipmi: reject NULL 'bmc' property rather
 than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-6-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mEwe7/OMVJKZh0U5KU7As11b7hk3pWmV01Cq6GcNgXU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0Kx3lkfCikOCRNQ5lBbBNDTLznIR/ay9TO
 1nggYpHv5eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5QSLEACedqZocJ8j+9GmocgwIuNIp1MDhRD3MKaT9fTW1aePMDe+KAn2SZwuIKBujjDtvGeqJeD
 wmTpQkZWEI5GP5eD5mUr3PlZhsboguyLsCAEok5T6kG7JvqHtQ4qwCaQSWxjBVqKUpfRpPYR6OL
 Fgz5KL34Wkf8q86T4JVb7qRFmf3ii2wJhuGP1gXM7bcY2CMNMV9uYqYoJwSC4aZKzQIMgtcnj4b
 LeWDZMwzVZTfuzVCARKHU519iKzuzDU5m84dGj8ahgWGe2O45iZ+5lsRJwRaPZmJFlUlN7VNKS9
 2WUYsGnbE0NOWt6gTV+Rm1UsemZvj90qPshkLQyLn0AlFWgsPTi6Vs5u+ZjM6fjkaPDo8s8hscc
 fQiKTMXfgjiqzaene5ToVfBeJOgmI4WfsvqfOUYvw/7Oj1z5CRS6rXmYOYHrCt0+lDJakNzTiqQ
 /SGir0i6XkcAeop7KzDJwYf/2IkGXAP1UorfZN3xCtcpuBpSl3G9zbznnNUu0aJZ2XRWLdgxpSj
 t4Wi296pHhdKMB2nFZma4M1kg5kjfIK9bAZFIk6vdOurbNTYxNA+67t9lG5eEkeA7/KEOkvu/n5
 4qMmJ/dugMjjgB+aWOcDxeRqCXrf4TWoxlG7B7mZ61ZwKftr0f3jdV56Vwt0ZN6MiqCNHXhw+/Q
 OTicuYPzPLx7Khg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ipmi/ipmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index b49affaccec..74818ff3cea 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -97,8 +97,14 @@ static void isa_ipmi_bmc_check(const Object *obj, const char *name,
 {
     IPMIBmc *bmc = IPMI_BMC(val);
 
-    if (bmc->intf)
+    if (!bmc) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
+    if (bmc->intf) {
         error_setg(errp, "BMC object is already in use");
+    }
 }
 
 void ipmi_bmc_find_and_link(Object *obj, Object **bmc)

-- 
2.54.0


