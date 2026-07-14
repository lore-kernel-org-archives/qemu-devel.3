Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B9C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZVx-0003tc-RB; Tue, 14 Jul 2026 05:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZVu-0003sB-LE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZVs-00010v-Vb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784021596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktwNSG+9SYLt3awQYC3iZDbrlo8kvB62BAXH9bVMoY=;
 b=guccBWolR4N2ZLIrKssgXgsSxB35ZHBEHPWTdNN1FGyfAYtsAq4iVGgA61zTbPREoEQcQQ
 74TWMECKhNVy1uVbv75lAEE/V6rUwjcjtAIKyJduSFae0bcIEKK+u9Xp8SistmGCsFSt8k
 JXf4X2zEMBdC7OuxDmqFMxZyFX3FBFM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-uCvt9NDkMGyGLT9XoGidsg-1; Tue,
 14 Jul 2026 05:33:14 -0400
X-MC-Unique: uCvt9NDkMGyGLT9XoGidsg-1
X-Mimecast-MFC-AGG-ID: uCvt9NDkMGyGLT9XoGidsg_1784021593
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D8DB1802666; Tue, 14 Jul 2026 09:33:13 +0000 (UTC)
Received: from gondolin.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57DEDD6E; Tue, 14 Jul 2026 09:33:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL for-11.1 3/3] s390x/css: firm up handling of chained TIC CCWs
Date: Tue, 14 Jul 2026 11:33:00 +0200
Message-ID: <20260714093300.2193848-4-cohuck@redhat.com>
In-Reply-To: <20260714093300.2193848-1-cohuck@redhat.com>
References: <20260714093300.2193848-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=cohuck@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Eric Farman <farman@linux.ibm.com>

The logic in css_interpret_ccw() correctly returns -EINVAL if a
Transfer-In-Channel (TIC) CCW is command chained to another TIC CCW.
The same routine also correctly returns -EINVAL if 256 CCWs do not
perform a data transfer as part of the I/O operation [0].

What is missing, however, is a combination of these two, where a loop
can be generated that will continue processing CCWs but without
providing an opportunity to catch a breath. Fix this by capping
the number of TIC CCWs in a channel program at the same limit as
the CCWs without data transfer.

[0] See "Invalid Sequence" in z/Architecture Principles of Operation
    (SA22-7832-14), p16-27

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260713074708.884282-1-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 7 +++++++
 include/hw/s390x/css.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 29ba39f79ea1..3a67b6705319 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1078,6 +1078,12 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             ret = -EINVAL;
             break;
         }
+        /* Limit the number of TICs in a given channel program */
+        if (sch->ccw_tic_cnt == 255) {
+            ret = -EINVAL;
+            break;
+        }
+        sch->ccw_tic_cnt++;
         sch->channel_prog = ccw.cda;
         ret = -EAGAIN;
         break;
@@ -1129,6 +1135,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
         sch->ccw_fmt_1 = !!(orb->ctrl0 & ORB_CTRL0_MASK_FMT);
         schib->scsw.flags |= (sch->ccw_fmt_1) ? SCSW_FLAGS_MASK_FMT : 0;
         sch->ccw_no_data_cnt = 0;
+        sch->ccw_tic_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
         /* Start Function resumed via rsch */
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d3326237c9f0..79b41f305e8c 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -132,6 +132,7 @@ struct SubchDev {
     bool ccw_fmt_1;
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
+    uint8_t ccw_tic_cnt;
     uint16_t migrated_schid; /* used for mismatch detection */
     CcwDataStream cds;
     /* transport-provided data: */
-- 
2.55.0


