Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167A3CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDC-0007ZU-6B; Sun, 14 Jun 2026 15:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCU-00072i-CP
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCR-0002Me-7t
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cc3Wh/bP9QvRlcbbFg5rG89g4DUdCV/mjJ1W8SnJKno=;
 b=DZjn9yXNm1AIcm2S0XSIJ75hy21T5QEOFwzzBc6SlJA/woDcQbfi+GnsbxpJG6s45cI9lL
 QqHzP+esYzNGPmkIHph6MAteFa/rmHf11l/t7HrEvvu5OF5iU92sOi1ciTA+1GFfg6Q1K6
 jDw9ssWQgoHhS4WALMeWj/kYmf+sIVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-IveXA_WdPU2aCDWu69xSiQ-1; Sun, 14 Jun 2026 15:08:49 -0400
X-MC-Unique: IveXA_WdPU2aCDWu69xSiQ-1
X-Mimecast-MFC-AGG-ID: IveXA_WdPU2aCDWu69xSiQ_1781464128
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45f3d008865so2062894f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464128; x=1782068928; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cc3Wh/bP9QvRlcbbFg5rG89g4DUdCV/mjJ1W8SnJKno=;
 b=UJSUw6TGvdhyTi2cES8xo7pVc+ocP2UCEjcgmpng7lO9/xU36tCLoPCjmf4YGB9vMR
 TWYVWGXt6qp602/8vu0WBCawaMldw7eMXwi6gacMuMcUSj0JFCy/JsQF2CLSL7+853un
 w8gZLUevQ6k8iQxiH+y3wh8DncilV8zxuIndcUkMn2fk7DRVxQrywgaL7vfFFoYsr5Vy
 oAIl8M8I/YvsDAKgwUzLeAQol0an85CIPT1xMO3uLhzIscublEaqyE+eUgROtnuABhUb
 8uXoS2xCGQLdWJQN4PMNO2FeElod2pAMbwhz9GzsywRWe91ETdEfhtXwLqAniPVdyGTZ
 h4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464128; x=1782068928;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cc3Wh/bP9QvRlcbbFg5rG89g4DUdCV/mjJ1W8SnJKno=;
 b=ll+ehTNlFeHCi4UKYIk2Bi8M69FmUUv68McI7k0szrDtXQqIKOLkIdui4fAbWVPB+1
 lpUFbXdECjeQ6yB6TBKubPhEc5+haOCS6/89rlCmyw70ZGTeay2joHpdRhKYoVngGkHC
 I9X2Sgcac88hmcqMxVZAjMrgY+A6Va0/5u6wbsCZSCjlyj88Xn1lNPN8xFiB6H/oZc/y
 rqBSeaVkipAOPEoCvt/dOtL0gu4IUKG1aNnc83OP2RiDh/QCLW9jU9pmlOo1YZ3yY83n
 w1uoPHGD0RNIUjV83tfAnhzh+yPaZnahKxUbAHuIn7GIYzwlVpeQf2e/8SkcIt4mxS2Q
 00VQ==
X-Gm-Message-State: AOJu0YwrabImjzxJFFuPDrpqxMkyXLHaj9b/Uqii1JUX+xCDvXbUiLtm
 vVuLUyFizJViJwu4Vc8lKrBb9Uv7jpOyu7iCPb6PvkPUsllndpggd/GDil0wtm1lmsVTBdSe9g7
 jlD2ZmFzp5PvMocHAmwsOZNqxQWKZxmz43VtXS1nnEybOedE1VkqYU3l2VwMHhEL21Mqfx0cRqo
 l4tozS8SULqlJmlDMYvdsI3Ao4xJjmpBqZqw==
X-Gm-Gg: Acq92OHusIWeDsG8N9Sdnq74FAQDIVYpiORoj3OOmrg2t8gGEX63IZGR5BQq8MzZwQo
 KCSc9Qf9o3f04Qzek2mlW0vr9wFKp4PHh71yqiddxiENBolANQH1NWKkPgZClG6Rp1FfjIxZmSV
 VcOxgn06ovMV4YeODTGVJDEcFD5BF61WFyXAKxy0gmYrtECDyRzT4FpCX2xYxFMxBc8BuJJigEu
 /WTUVWcBLEkqpDMWTsIGWUfsHdrEiEljy4BgT1BYLQNni1EnuhB83xDFrQAVUJYPWr/vQ0jnh34
 tPXnorloeRbu6+bsvakLvS8/GNpSJ2K2LEkt66HZY6Sdh+xVWHKgOTdkvbCFpxg0OqkK0gYAIRT
 MOyRhRgRRHCF2MGMgir17X8qs/PAFoAbo8qX9qNAKsKg=
X-Received: by 2002:a05:6000:4a06:b0:45e:f93a:2069 with SMTP id
 ffacd0b85a97d-4606d023b2emr13415157f8f.23.1781464128291; 
 Sun, 14 Jun 2026 12:08:48 -0700 (PDT)
X-Received: by 2002:a05:6000:4a06:b0:45e:f93a:2069 with SMTP id
 ffacd0b85a97d-4606d023b2emr13415118f8f.23.1781464127696; 
 Sun, 14 Jun 2026 12:08:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm26264966f8f.14.2026.06.14.12.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:47 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 071/106] net/vhost-vdpa: enable vqs before DRIVER_OK if no cvq
Message-ID: <66232095a1c71880a3fecc5ecaae47ec9a403134.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

VDUSE do not forward the enable message to the userland device at the
moment, leaving the dataplane disabled.  As there is no functional
difference if the device have no CVQ, enable them before DRIVER_OK in
that case.

For devices with a control vq, keep the enabling of the dataplane after
CVQ so QEMU can restore the device configuration.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Fixes: 6c4825476a43 ("vdpa: move vhost_vdpa_set_vring_ready to the caller")
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304173857.2705296-1-eperezma@redhat.com>
---
 net/vhost-vdpa.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c85956a04b..c526c2b2dc 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -396,6 +396,7 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
     struct vhost_vdpa *v = &s->vhost_vdpa;
+    bool has_cvq = v->dev->vq_index_end % 2;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
@@ -405,6 +406,15 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
         v->shadow_vqs_enabled = false;
     }
 
+    if (!has_cvq) {
+        for (int i = 0; i < v->dev->nvqs; ++i) {
+            int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
     if (v->index == 0) {
         v->shared->shadow_data = v->shadow_vqs_enabled;
         vhost_vdpa_net_data_start_first(s);
@@ -414,25 +424,6 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     return 0;
 }
 
-static int vhost_vdpa_net_data_load(NetClientState *nc)
-{
-    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    struct vhost_vdpa *v = &s->vhost_vdpa;
-    bool has_cvq = v->dev->vq_index_end % 2;
-
-    if (has_cvq) {
-        return 0;
-    }
-
-    for (int i = 0; i < v->dev->nvqs; ++i) {
-        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-    return 0;
-}
-
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -449,7 +440,6 @@ static NetClientInfo net_vhost_vdpa_info = {
         .size = sizeof(VhostVDPAState),
         .receive = vhost_vdpa_receive,
         .start = vhost_vdpa_net_data_start,
-        .load = vhost_vdpa_net_data_load,
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
-- 
MST


