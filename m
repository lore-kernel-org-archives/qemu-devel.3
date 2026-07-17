Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF5CC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh88-0003fY-GF; Fri, 17 Jul 2026 07:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh87-0003fA-0v
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh85-0003Of-8x
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZ1WP+O9s6QEcDNkMenKtPj1/KWw7oDwlYf4583qKxQ=;
 b=fh23B/5Rdem5A6SZqmBcIJGdaB5Gqx4DQd8psW/SyDeBjSFTyqiETrqTFqGNX8BtaAfCga
 8VnU0kMCawU3IB+Z3U/Zo9acYZ1YBLy9zpdA9Eoqx2/lt0jPGmwhlgPctvWlc0mKe6d0T7
 NwkWfjvkCgjuptpRXstjsg8vDS08mps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-dk8wSvBaOPGAVHzA0Wz0Iw-1; Fri,
 17 Jul 2026 07:53:15 -0400
X-MC-Unique: dk8wSvBaOPGAVHzA0Wz0Iw-1
X-Mimecast-MFC-AGG-ID: dk8wSvBaOPGAVHzA0Wz0Iw_1784289195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27A7180074E
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:14 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBDF8180034C
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:41 +0400
Subject: [GIT PULL 02/15] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-2-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=d9iNnmvHwz9V5eb/jktzHMJMRQuIJZmRJLaiZr8hjbc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheZIcuGkn26LiPnDDQ9Py5Q73jtihRboQE+U
 f1umep+Qv+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmQAKCRDa6OEJdZac
 5b0OEACGtbJ/thrBFKZ1F1XYfmvdONWJUWbW7O77XtXr1X39W/WXC/oBd2mU7yY7fW27fLdE+C9
 1gb4bMDQM7ZXXKyrUOqb+85xSz4+CYXyAZAl0JMuf3XD0zW7sWN+8v7PZbMjVkTlEUZ2GVDebJ0
 cplqd7B7NpsH3/L8gIS2QFT1Ue+Wc3y2lu9QCrFmuCU9v2HoSJUYlW7qaluv1/VMlsKc/WWjY6D
 gjyyMID6E/4iDA8Bs3mbcFrY02QvHu9YE6/q4MO1LO5Y4Ul6IPzQejeLU91GTVVXA3lskthbPpm
 e8Kon9ohyWQFVfmmvhsgeoXkfvbSLtOQdQITI9Umzdoi/t4iIS39nT2fq7N4fwrQAjLKL6KjEtA
 NZjk1YszxecN68H6MOEtu88v+83hwQ679i3WRsLPMDiLVJ8ywLX7TtAWoegE691+T2F3ZQ90hiv
 tYmzF6FQH6LG9m0Z6PMQ5ieKR8qXVayRhzbOWQKJeTqYXSw/cXEfuMWl2K4TAJeiBxuxLBG6SHX
 TSCWBYXIRkuLoK+U8bAuafg+anOmBjs5C3gY9jTe1xdziYeVcZKAm7B+cUO2Cm79nuzur2yi8ZN
 kcQn7mFPx+to8z6p2zvkGbWKC9zAmRuSPdpEW7eCs6u06BzIsLDkrIf0QeW/SvD5kuDjNb6Tx9A
 4eDBTFaF0cM5G6w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

vnc_refresh_lossy_rect() always marks a full VNC_STAT_RECT (64) rows
as dirty when refreshing a lossy tile. When the display height is not
a multiple of VNC_STAT_RECT (e.g. VNC_MAX_HEIGHT = 2160), the bottom
tile is partial -- the last tile at y=2112 has only 48 valid rows.
The unclamped loop writes to vs->dirty[2160..2175], past the end of
the VNC_MAX_HEIGHT-sized array.

Clamp the row count to the actual surface height so partial bottom
tiles only mark valid dirty bitmap entries.

Fixes: CVE-2026-48002
Fixes: 7d964c9d2fc6 ("vnc: refresh lossy rect after a given timeout")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3950
Reported-by: huntr bubble
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index b2b69923b75..559d3954b87 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3004,10 +3004,18 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
     int sty = y / VNC_STAT_RECT;
     int stx = x / VNC_STAT_RECT;
     int has_dirty = 0;
+    int height = MIN(pixman_image_get_height(vd->guest.fb),
+                     pixman_image_get_height(vd->server));
+    int rows;
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
 
+    rows = MIN(VNC_STAT_RECT, height - y);
+    if (rows <= 0) {
+        return 0;
+    }
+
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         VncConnection *vc = container_of(vs, VncConnection, vs);
         int j;
@@ -3022,7 +3030,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
         }
 
         vc->worker.lossy_rect[sty][stx] = 0;
-        for (j = 0; j < VNC_STAT_RECT; ++j) {
+        for (j = 0; j < rows; ++j) {
             bitmap_set(vs->dirty[y + j],
                        x / VNC_DIRTY_PIXELS_PER_BIT,
                        VNC_STAT_RECT / VNC_DIRTY_PIXELS_PER_BIT);

-- 
2.55.0


