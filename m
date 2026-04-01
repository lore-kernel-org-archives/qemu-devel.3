Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1E51076386
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zEK-0003Oq-PE; Wed, 01 Apr 2026 13:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEJ-0003NQ-GJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEI-0001MU-6R
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775063985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5883psE6nyExrf3yguXNZZAHUfPO/1/LQet/5J0xfFc=;
 b=NtIpBSyuEqa0RTimrPn+n2WHp0emjrqHfGXDR2IzziQhUST9H6teQ1T1uc3DOCQV5Ktfp3
 YXqvxIWUrNblbonCi9izuE70kMiTSX/AT1YqTtHMehEHEjeMVrgtZhzQtswDgM6AlzeG6Q
 r4FLri+cWp4ltcY/6OVC7I1L5xuA/b0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-b1B6vwiQO5m3alZc1kQQTg-1; Wed,
 01 Apr 2026 13:19:44 -0400
X-MC-Unique: b1B6vwiQO5m3alZc1kQQTg-1
X-Mimecast-MFC-AGG-ID: b1B6vwiQO5m3alZc1kQQTg_1775063983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35936180034E; Wed,  1 Apr 2026 17:19:43 +0000 (UTC)
Received: from localhost (unknown [10.44.32.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 283F41800671; Wed,  1 Apr 2026 17:19:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, <qemu-stable@nongnu.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/3] scsi: register again after PREEMPT without reservation
Date: Wed,  1 Apr 2026 13:19:27 -0400
Message-ID: <20260401171927.396672-4-stefanha@redhat.com>
In-Reply-To: <20260401171927.396672-1-stefanha@redhat.com>
References: <20260401171927.396672-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

The SCSI specification says PREEMPT without a reservation removes all
registrations with the given key. Try to register again after PREEMPT
since our key will have been removed.

In practice some SCSI targets keep the calling I_T nexus' registration
instead of removing it. Therefore we need to handle both the
spec-compliant and the non-compliant behavior.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-generic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 349dea6bdd..5182f9236d 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -513,6 +513,16 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
         if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
             return false;
         }
+
+        /*
+         * Some SCSI targets, like the Linux LIO target, remove our
+         * registration when preempting without a reservation (resv_type is 0).
+         * Try to register again but ignore the error since a RESERVATION
+         * CONFLICT is expected if our registration remained in place.
+         */
+        if (resv_type == 0) {
+            scsi_generic_pr_register(s, key, NULL);
+        }
     }
     return true;
 }
-- 
2.53.0


