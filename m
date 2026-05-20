Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20619CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPooR-000715-Ca; Wed, 20 May 2026 17:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooQ-0006xQ-9f
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooO-0004A0-WF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdeg6KZimag8UGjN/vDgHGgf4EKwXlKAmfn2EJzpOFM=;
 b=SHoI6yxKNLPK6qJaIHZmZ9XskJ0ReNIhEJAA0oa5UlDfvGjB7rTFOGl4hLOJarKEu4MDZ4
 n95hsfJm/0y4CxHzRWN2L75qChsofPK8A2hf9e1IQAAmt+2C6gorr7KBr5URah7/ad1vH5
 89HjWTbuwHi5LqoiopQuMBw0bQ97NSM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-5BJmYDtMNgi_Mdp79VrOVg-1; Wed,
 20 May 2026 17:50:42 -0400
X-MC-Unique: 5BJmYDtMNgi_Mdp79VrOVg-1
X-Mimecast-MFC-AGG-ID: 5BJmYDtMNgi_Mdp79VrOVg_1779313842
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBF3C1956080
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7975630001A2; Wed, 20 May 2026 21:50:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:07 +0400
Subject: [PATCH 06/40] s390x: prevent crash if given invalid CPU#
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-6-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=630;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RCG2TEBkp0lXDDkBP+4/T7m2pCFCYtedJ2NUBZ+T14M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCeUpyYYR/MzgGz033z4WkmvVaneW1ZlBGp
 pMwiIMEBGCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5clnD/9HhJl8/gAzGIHf+gKXoTMSt/AZVVRsoqiRDk0HLnuJ3P1XFvdVBBro7kI4WfBjqDszzYH
 JilJUcxMx6GXS8WJ5oytNArOkvrB0PriiDeqDfmgJqOozTWXxW677B/OOQcc5uzyk64BTM3ZiLU
 rUOfyvH+hSeAokwtQgG/yPIYweJ5qauuNq/ScqIUL0sJM3T9Pw4kQeocVPhLmgbOcODslX+VyYk
 FqGVBBaM+KxRG53Otz45PXcUvok06gMvZXDbhESXw/2j6bOIuF7mhbvB06GtO7L3xg7q+xH4QgB
 jwPQCsiVdxqlTKIPk08W7YKHbAcCCglsIy4JwZwExePN6f+OSdtTh/Nvmi2biMcL6oMK//jnP5L
 +RLdj/Rvivxl5rhU1C0Yr1NkjUHv+zwC15xy5uNmDzBUJL0Ga98Ao7yN6AhPu6Tej7pxOpcN39k
 hRyQQs5bZ9hxjsIdX1AnQafuYi+uDif5U0vGsOGonysyZo+ZNvXKmoWyAiNiYYGl1hEr+Wxdm8K
 4u39vrF5tNaWO8jzFMSF3m5pA/8zAbdAA4+PYHxh18yTq+EKwljHt2HLCVAnpVXO7KKIyjTCx8/
 zu6gRP3N40BdfkuPBHs+EQHm9Gxpye4D9LSMc5APaUylAbFjKsGdyGhXx6uObAgYHQe8fs8uV9T
 OrVWiYStbBYA4bQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/s390x/s390-virtio-ccw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4d35f9b10bc..d27d82a378a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -729,6 +729,11 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     CPUState *cs = qemu_get_cpu(cpu_index);
 
+    if (!cs) {
+        error_setg(errp, "CPU %d does not exist", cpu_index);
+        return;
+    }
+
     s390_cpu_restart(S390_CPU(cs));
 }
 

-- 
2.54.0


