Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C0CCD8C84
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWjL-0004h2-OV; Fri, 05 Jun 2026 11:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjJ-0004dN-Bd
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjH-00063f-W1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40y9nUEM2k+DgX74L7br+FVh1cGqfh7EYiI+WllmI9w=;
 b=gszf9gIKXyJd1OOt5kwWW4yJjHt9XBxKnoZDWCfMWiY9fe4KhlRV7nHQ+dsbjave7D/gSY
 Zrzs7n4Av9iiLAt9QDMAXS7XLneczh+rA/6XIOkzTikYoRgFcV6coUzFV9mC4ntPtdP7fp
 VepHht9x7eKjrDtci7JNqQtD/nW8LuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-NVmsIupeP6WRZKHc9ydd8A-1; Fri,
 05 Jun 2026 11:44:59 -0400
X-MC-Unique: NVmsIupeP6WRZKHc9ydd8A-1
X-Mimecast-MFC-AGG-ID: NVmsIupeP6WRZKHc9ydd8A_1780674299
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E843F1944B03
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:58 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0A7F1955BC0; Fri,  5 Jun 2026 15:44:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:26 +0400
Subject: [GIT PULL 06/23] hw/ipmi: reject NULL 'bmc' property rather than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-6-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mEwe7/OMVJKZh0U5KU7As11b7hk3pWmV01Cq6GcNgXU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7Ug6zqn1gagGfsYTXgrcLMRhhJGF4dbzm2V
 nVaSnuWyOmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5XExEAC5X19Hiz0hhGuUz4AjJYxBslmbDgJD/ERKuRnSawJjHzbyH8XtLRNuth4jWBuDzpYqPLY
 0mfDVvX5h3r3WH/vj3f5+CGAEU0+tlR2nPxkkg/1jTjEMFDv4vqwag5yTqxlTHMd35lDwBEERij
 TcFcRKYxiYt1DeVHlNr0D0OleSEGZtZICodKiAh8gMSmEeUzMUwlarjTnX+IZNa7Y/HfrgOMJvQ
 Ujaq2zbJPvSJk/m+NRApPtZcKcU99La1lE/+NrDxKPtuYOvxlvaRK6AFGz+3TIIg96hh7NsPfMv
 eE03lf7k9OnnpzCtN/xKiSRajmQHH6fKIa/ZAvxzAW09T/7a06buIwwOFdWeH+lLJxT0iOpP36+
 NCVqABlmDMCwsnvoca0b86iBNYF08yLpq2RMUPp7WstMlx2dDuN1mVxcyPc2DoRImFMo2Px+VOG
 YF1NVGrXNE6/1NK3WRHXaiLbaszFIFUqiVng1LzVM+Khi/pp+Z1Dblg44JePCVR17hosEoSkTES
 ChrngUpPRoZHSFgjAbmFnR1D9yNnX+5Khl/vwGRfnw1bshHHWYM5CQIZF1Zfby5s7b0zMDZx3pC
 Afs60EFhO06dNY2L3n72GJtr17unn9y/kfbXowbOHCaqJSZqkJXFqgKj5xvpLHmFTw/YM6Rg7E5
 SYsjRIgRgZAMq9w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


