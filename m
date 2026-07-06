Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C910C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiqE-0005uV-LI; Mon, 06 Jul 2026 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgiq6-0005t1-GK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgiq4-00082W-Ss
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783342460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvRhR53UrAzcMNlT2sX9FL22cxe12mJf+ORaQ6a9Dew=;
 b=haIHAPI4m4KwtJccZsLXA3D6sNM0VfCdHA6bNnH6z8wNaRV9mpsoCKVKCvewt5ALyrx67q
 DN7EI/ig3jej/6lZepiFSEtdVHeeQsgkZdo8Bazv28GFmvQnKvp1RZBVYdSap6cimr7q8S
 YU5NLm+sT2Td3BXS0BcFmBcHWu4Q0bQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-CD-Er2OzMd2O4nrWU9Rp9A-1; Mon,
 06 Jul 2026 08:54:17 -0400
X-MC-Unique: CD-Er2OzMd2O4nrWU9Rp9A-1
X-Mimecast-MFC-AGG-ID: CD-Er2OzMd2O4nrWU9Rp9A_1783342456
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F3F318052E6; Mon,  6 Jul 2026 12:54:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1056A36535; Mon,  6 Jul 2026 12:54:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 06 Jul 2026 16:53:49 +0400
Subject: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
In-Reply-To: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Z78cz1W83ZCTre26QU2Eg5dadzpsa2kEeUScuSzoE8k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnJqMo8xpRd7aCTIXw8rftrnufpHdZk70GQ
 NcvXcAz5uCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5VWwD/wNdwT+by3j0vD6hfUoiAHf+qx+2qluQ/ZF/ZMpTSOtz4Tj0jykZKVWIpDK89Wu+9dCqEr
 e50o42fTdpluHRybjJGujilk6kc6uzrLIQkE7XGi60S2bGFT93p7fzmZNHxCbbLbg/b7hSpqEzG
 dMDa76MH0QtWfzIH4VtZsB4rYxUrzNmlT+ZwVSZAHO8A0TulMTYFz7wrvNvAmRUG1+qL1Kqn0n3
 6UlujHIIfA+InEnc0hR9vImHYK8rjfMrzl2XlrQvvEEo5U93Pbns2VMr4qH/s8NV9C2ACvzLA1A
 NwkVY2ax6zB/7BdamxK1sjgDxtqOQ5viWuYN7A683EbUnHqCiphuvDdtQ3V6A/KGvGFJnBr2GMp
 pnI7NHdc9ALUN9kCjNSaU+X8FEhWP3I/Z0pgiPmJ5gPUcxZ2NWyxvSflceG4TyRdM9M8ghJ+pKd
 sYpr4aPg48f12UCdyzxY2p5FYE9Gmd57rtxzsTyfyUQxEzss+47ExVCTTpFeLR/16FLgYKD4igL
 +AztFIZPiJZ/w6wdrkbySOEM69rDAAAAuhnuzSYQui1grlNHYOfhdIl5Fk9EIYLF2OsSvfpXW/C
 kWlhNuZhdw/RLDNy8QbKa3GjPYYjoAzSxJZrbsO6VpnRIoYfmTXmSnfQ+vKwDasIXHKx93Qvrbr
 kUErf1bw/IunfzQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


