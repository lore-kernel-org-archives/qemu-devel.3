Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF8DC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFnJ-000652-0S; Fri, 24 Jul 2026 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFnH-0005sa-KB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFnF-00052T-Rj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784899105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mn1l/lbquULTeCUDwl9D66RFDwevLGEqALJZg+lV9Z4=;
 b=AYIS49Ljnn+JWanudORQi63C+6pOzcAfAx+DW5c5+L63Rmgv2GzzjdFDsc2RKIOmf7dNv9
 KWDIOjhgWKk3y0BRa2UOh3qpBvFCW7t9mJtJ/k2UfDs5tyIQbxgh8ElvntnVWBxnDpQNDU
 5XnNpGR0gxBW9Oi1P1TqAO8igvK4PEs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-PuTHs4O9Ol2gPvZwT2JksA-1; Fri, 24 Jul 2026 09:18:23 -0400
X-MC-Unique: PuTHs4O9Ol2gPvZwT2JksA-1
X-Mimecast-MFC-AGG-ID: PuTHs4O9Ol2gPvZwT2JksA_1784899103
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f90dbaf84so388097f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784899102; x=1785503902; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mn1l/lbquULTeCUDwl9D66RFDwevLGEqALJZg+lV9Z4=;
 b=Vf3hC1U1X7a5ZMlhkqMz6wsAnGK6agZmcxTaXv0d4MQ5Pxdyf2JQcjoSBE2NHdG7Ga
 FPJYhEIy3/VGA5CSXwIE9QUEcOg2E1KdHOF81WrfukfYCmlrhw0vmZorXwtQd4M/xULD
 ULnnT9OqFybFzPAi5w2A6jgx6xn4law4oIJLOvJ0zRUYWHDfX+FGcXAUcgIJrzoXYVKP
 1Fn0wOlWSq86GEcVgd7wtY6/RCE2atRAI1a5pzJV0jrpjY8Ux9slS/u2phq2/RtjtDXU
 dC77d2rP6eph3sJrec7V1iJxtvTJCjtYigAfm/0YisR9zoSJhHb4M7ZIGlf+oC5ucplf
 6ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784899102; x=1785503902;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mn1l/lbquULTeCUDwl9D66RFDwevLGEqALJZg+lV9Z4=;
 b=mNokwEMOsnjno7IIyxQeFoq2pAEvW5898pomV3G3/yooUrS9WQa9lGkERKa7KnjLOQ
 RDHuNoxlPMSmHiPv2FQeB6hNyvXDeFvz715iiYyEHyKVJpq9+k9BBFELbS983cCulyeG
 3jWSag96POZ++D40eXGLWzTldLA98bh4siDPMyYuakM1z4P5s+ahxlpTaBNNrwI5NX5R
 3Iq6nVomJvfQCZtaUHYgoTXAEidDdxOuQpWyxYcIdpO2l6t1Evl7TF4yh/PwaTTnf5oh
 jKErkeBxiplRcoMvdrUxqhbcCQq8eF5U5q/Phc8/NVrn7KfCDHOKxxKBj59phMCaSSiS
 l3wA==
X-Gm-Message-State: AOJu0YxCnjJk7e7LT9Edu4247aBcCcqzR2oEHRS9QZhVknojnElCl6hP
 myicvrz0fnJdQz+O7agj7zEOeF8yP1am9EFcoDUPha9SFwqMkkTNQt+ow62B+bkPue9S0LhYRtZ
 f1j+nSmxwN74RYv6gWie1O/Hu5r8dsyD0fyC48mpTOvvOlTE41Pumy2qa7KI/b7JFm7qyYo9i8l
 83doVb1UJGAigTR0nWcomMe5YDCMwCNb+O2Q==
X-Gm-Gg: AR+sD10GRfcaBVm0P8NeIV+lyMdEGildvaqvflxznTMo+gl69AEL5BUkZsZkTY2cycE
 fnPxyaFg8cPKMCT/FJqbD31X8xzvJaAttwzdJRLsF8Hy+nga2nfutYT9CVsZLje255OfiGus0KT
 aVfmdKUVXH5cLtVBDwWPXzfYR3LJu5JKNLG8n5ZI58AoWvlN8V+cl9wU1phsXP2QRce752FVmcl
 6sae5eI9+L1QH1YEE+S4+ji3AeSqHfaSB0MTM41upDECXDlfrJhWHYhAPueZ0Eo3Bxi/RmV1R+d
 j4AHZvDAztU1WAQZO/KvhWdQfV/Zde4zFt2V7g9DHP8Gi324n/jRC2LqDHoHxRuT1zkyYPhB7hY
 EZtGTc1/qrKZhOplDsHCnKg==
X-Received: by 2002:a05:6000:1883:b0:474:5a38:f650 with SMTP id
 ffacd0b85a97d-47f8d710ffemr9050464f8f.3.1784899102589; 
 Fri, 24 Jul 2026 06:18:22 -0700 (PDT)
X-Received: by 2002:a05:6000:1883:b0:474:5a38:f650 with SMTP id
 ffacd0b85a97d-47f8d710ffemr9050422f8f.3.1784899101967; 
 Fri, 24 Jul 2026 06:18:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm23494503f8f.8.2026.07.24.06.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:18:21 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:18:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] libvhost-user: protect against OOB vring queue access
Message-ID: <dbba777b25f86587c8d131891a2b4b2be97e5c5b.1784899069.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SET_VRING_NUM, SET_VRING_ADDR, SET_VRING_BASE, and GET_VRING_BASE
handlers all use the queue index from the message to access dev->vq[]
without checking that it is below dev->max_queues, so a malformed
message causes an out-of-bounds heap access.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3741
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 28 ++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8208265588..42a5e2f1f5 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1200,6 +1200,12 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_num index: %u", index);
+        return false;
+    }
+
     dev->vq[index].vring.num = num;
 
     return false;
@@ -1210,7 +1216,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     struct vhost_vring_addr addr = vmsg->payload.addr, *vra = &addr;
     unsigned int index = vra->index;
-    VuVirtq *vq = &dev->vq[index];
+    VuVirtq *vq;
 
     DPRINT("vhost_vring_addr:\n");
     DPRINT("    index:  %d\n", vra->index);
@@ -1220,6 +1226,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", (uint64_t)vra->avail_user_addr);
     DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->log_guest_addr);
 
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_addr index: %u", index);
+        return false;
+    }
+
+    vq = &dev->vq[index];
     vq->vra = *vra;
     vq->vring.flags = vra->flags;
     vq->vring.log_guest_addr = vra->log_guest_addr;
@@ -1256,6 +1268,12 @@ vu_set_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        return false;
+    }
+
     dev->vq[index].shadow_avail_idx = dev->vq[index].last_avail_idx = num;
 
     return false;
@@ -1267,6 +1285,14 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     unsigned int index = vmsg->payload.state.index;
 
     DPRINT("State.index: %u\n", index);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        vmsg->payload.state.num = 0;
+        vmsg->size = sizeof(vmsg->payload.state);
+        return true;
+    }
+
     vmsg->payload.state.num = dev->vq[index].last_avail_idx;
     vmsg->size = sizeof(vmsg->payload.state);
 
-- 
MST


