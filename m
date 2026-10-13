Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF085CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUe-00022W-0t; Tue, 13 Oct 2026 09:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUQ-0001md-PE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUP-0004hv-3T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3zBBhoP3Jd67MeuilnfpDx4cegd3CTTbOUKefyRnxc=;
 b=inDbzGp9sstPa0AxeWG/i+ODemsbYI7ovvwUkFM0R0wktjEXWYFpE0FY6F8pWwSANPOlyS
 Bnq8kls9Tq+/ZqU64+BRefjCn5+ZMbYqX4f1k9nNN2OynOxydFitBh+/1Fx4sp327iw1FR
 yWIeU56tui9pKTOb16LocAuH3RdHQLw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-yuy_EsHhNgaiZRXZ_kF_Gw-1; Tue,
 13 Oct 2026 13:24:19 +0000
X-MC-Unique: yuy_EsHhNgaiZRXZ_kF_Gw-1
X-Mimecast-MFC-AGG-ID: yuy_EsHhNgaiZRXZ_kF_Gw_1791897858
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E20D119772FD; Tue, 13 Oct 2026 13:24:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5677756; Tue, 13 Oct 2026 13:24:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:12 +0400
Subject: [GIT PULL 15/40] virtio-gpu-rutabaga: make sure ctx_ids match
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-15-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kf3xMI46aRRwBSfHIIzXUO+PZr/1QR+eI4AWep3RHZA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDDZJeHlgyRtmLVBGnoQQg42Wo4ebGAgstc8
 k2GEfT/W06JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwwAKCRDa6OEJdZac
 5SiGEACIcVXuqfDGxwcaVm22fJEe6yyWnQhhCqmpae92QuGj+ctm/VH0dtPgGc3TpiJejYM4sHX
 ELQ8KLLSrsFhT/Lp5Xtj3nK+Mv8270YrrC0nrAzUCEZ296yQ1dxyQsLnimTqVQLXRboOzGPbrPp
 am3IpQ48PagbvgBXW68MpdD+E/FGuO2ZI1yixM1CT6u7EIp90kr1eQqxr6pijrpcVEqzLztVncn
 YSdIRUr83eWFmj2BUBxLqdoUClwXnzlk1lwzQfUBe9DEpHmeAehb6IY/7vSBs1ruhiZAE8n1dUw
 Kji8G7I07cbCg0D5LUfy+U/ziO1MCy6JOwLD8SzVAjOUzFw6TYi1xFjD1cpoCnNJxZ/w90q7ClS
 4YU7OAlNgudnBXzAu8Bo8yprOcI2HyABqNTd/DEA5ecLv26dItFYONY/XHXZ5hPwbHp+4WghJV7
 Uq3zlz8TZOXaScuXejaqQNbkTO0Q6+0FR0BHkM0bAtHojasvMRHjMBBujI7Y2U512bRhIU42+Pq
 AvxBKSPpt81rM3hOIgp/KqterXwagYJBKP3fzmL4E6MSKjWBwFbZQbchEyimvC/zuWZxjCsOOiq
 pZjrjaXKiON8JKr5LUUKG8xEGmLIxB8Xek/Iksjz0TCYPATWM70N2vA0bTAgDngdSij/EV/lQZu
 1LJutSIkfBcSHfw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Gurchetan Singh <gurchetan.singh.foss@gmail.com>

The ctx_ids need to match as well as the ring ids for
proper signaling.

v2: add r-b tags

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20261012233742.6389-1-gurchetan.singh.foss@gmail.com>
---
 hw/display/virtio-gpu-rutabaga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 3aafa4dc66cd..edf7b6270329 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
         }
 
         if (signaled_ctx_specific &&
-           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx)) {
+           ((cmd->cmd_hdr.ctx_id != fence_data.ctx_id) ||
+           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx))) {
             continue;
         }
 

-- 
2.56.0.116.g6de20f6092dc


