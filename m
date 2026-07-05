Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4DDC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwU-0005Yq-8j; Sun, 05 Jul 2026 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwR-0005Wk-K9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwQ-0001Pd-25
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XNytVY+RK4HHxAkd8Avgx+3Crv9VVEXYr/YVFcZH3Jg=;
 b=NAdXtUJsgDGMVM7ExL72J5RGj1dc0/ZP4J3DrhjdGKiQDm9fEYfP5R3aBX7/5vjktXA9hl
 EMdUI+SlicBmPClQoXffC9drKn7Vgk9jZXLtM0+xIRAp8PAYwPzBKWye4zvih7lHizkUbj
 royw+idZGLU1cnPBi00ZC6zLB7aSyBE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-iY6jdKFbNcmjgU5sHZjN4g-1; Sun, 05 Jul 2026 10:35:28 -0400
X-MC-Unique: iY6jdKFbNcmjgU5sHZjN4g-1
X-Mimecast-MFC-AGG-ID: iY6jdKFbNcmjgU5sHZjN4g_1783262127
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso183316f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262127; x=1783866927; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XNytVY+RK4HHxAkd8Avgx+3Crv9VVEXYr/YVFcZH3Jg=;
 b=niV39JKzkeHWAmJ+6wTtBuRXU3HuILD9lfPJCFBPgRHfD17oF/fq0GDnnEQovaIPIB
 6YyBw5RIVs1nQOJQsHjZCdN/zjNLy9zujKWv/9E5LNKv+QxxxXLrNuK/YiknebmTtgKb
 qFEsRzGmp7LuiylfYACbAWUYE3eOwK3tJMDCBirc+/FrD93rnCqCFS3eEZGLJC5C5OL5
 uo6JM0TMOHt4ggHdayV6eR0PeVgg/U9DheDD7eV7R/D56kR81qMuJdBVA2oZR6oiFN2z
 WHptTyow7lIFU3yM5VB9gPwHmmEg1aT74ukFZLXnbwnVOnRZ3XMYO5mYzdtg/5CzB4H5
 1f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262127; x=1783866927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNytVY+RK4HHxAkd8Avgx+3Crv9VVEXYr/YVFcZH3Jg=;
 b=Lrd5Or2IBRoDqJyVs2HtaNrBRHWdSdh4Wf3T/TnQoMjt5kaNOeYlYDiUZMKQX+hY4j
 +8BHuxG2YC4QxUaNMkQNJsPj0i8j4UXs7Qb2V0ESVeXVywHpSFGT/MfsUYmVdeqSMavC
 7CXgzNJtgre3BkXHlhABFptC0Od6Nc7kos3hfreoWW7ZO1jXUb3mj6DRRtzX64RPWYCx
 1tKlo+PGX2Vspi5PrlA7oDLr3gmJXGX7BkNPx7cZLOzP/psX4LKorQtXlNTdq+hOnZDM
 d9D2hQIemPE9S6EAaUcygYK41F3QpEucipONAamLIoxw0hEUR1oJrOe3CDTz5/XDxETa
 knmQ==
X-Gm-Message-State: AOJu0YzmA/FIgIIR29zU2TGKUvS7B/XiUW5LSUE/7cg/VOsDNAkggV/V
 vpe+AZBjKeTQp8REABF8ymkcAX4d/X5VrF9CfWmhmx6hQV7RnD0IOqi4NLsp3y0+2sCmkb0troD
 gkX2WS2PzB+R//cp/yF6j48LFSbzaF4+VH82YAzQCJeV8hV2b2VhcEC+Z6ALd5bQkvg/NCW9pzb
 ydqOrZJCxlUFd3c4T7VSI7Uas2M1ai+IdTZA==
X-Gm-Gg: AfdE7cmVYos+H9V/KONMIilE5BZSdYTAGGggm4vW3IcUB59mgi5e0J2wOTH1rDyyEbR
 bOAAbrYm4wgOIDquvfYkWrZjAp6aukQGPbvvLj2CqS4FVNMWZIhDrW5Obt1mRg1+XTSsNZge6b8
 8I6fglvL+AKgeL48tDA6Tzc8Ms/Zlh+tzv7smE1GUqMSaqfqm/aWdebdP0QIB/CDvhwDLxJSJOn
 6BP65HTbAHke5635wHaC7Ms6NAtUo2B9CcsDARHQ5QeS/sxR8+v5H+2UmMupYkICC+lFMCyHVRL
 oAyRucyftvSCeWXcKUO6Kex5csA7dPYgP5lBbMKkxtAPbpmx/kIGiHOEkybXIQjeqcZUVVQQIAk
 TctKSSfz2WD7LkarJfXsLwINE49leUKzY
X-Received: by 2002:a05:600c:c0d1:20b0:493:cfc8:12e7 with SMTP id
 5b1f17b1804b1-493d11f38e9mr57690155e9.25.1783262126763; 
 Sun, 05 Jul 2026 07:35:26 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d1:20b0:493:cfc8:12e7 with SMTP id
 5b1f17b1804b1-493d11f38e9mr57689845e9.25.1783262126219; 
 Sun, 05 Jul 2026 07:35:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccb4cafesm195863905e9.0.2026.07.05.07.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:25 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 18/44] libvhost-user: look for available vq buffers upon
 SET_VRING_KICK
Message-ID: <1ace07171a4f772afd85a419bcd55fe56631966f.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

When a vring is started the back-end must look for available vq buffers
and process them. This scenario can happen if the back-end is stopped
with unprocessed available buffers and then started again.

The inflight I/O tracking code already did this, but it should also be
done when inflight I/O tracking is not enabled.

Move the code and make it robust in case of EINTR or EAGAIN.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260604201029.250450-3-stefanha@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index d2df50e3d0..2c35bddd6f 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1390,11 +1390,6 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
         vq->counter = vq->resubmit_list[0].counter + 1;
     }
 
-    /* in case of I/O hang after reconnecting */
-    if (eventfd_write(vq->kick_fd, 1)) {
-        return -1;
-    }
-
     return 0;
 }
 
@@ -1436,6 +1431,20 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
     }
 
+    /* Inject a kick to look for available vq buffers */
+    if (dev->vq[index].kick_fd != -1) {
+        int ret;
+
+        do {
+            ret = eventfd_write(dev->vq[index].kick_fd, 1);
+        } while (ret != 0 && errno == EINTR);
+
+        if (ret != 0 && errno != EAGAIN /* already readable */) {
+            vu_panic(dev, "Failed to inject kick during SET_VRING_KICK "
+                     "on vq: %d with error: %m\n", index);
+        }
+    }
+
     return false;
 }
 
-- 
MST


