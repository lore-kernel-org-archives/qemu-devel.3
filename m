Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1B1C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8Y-0004RV-Bx; Fri, 17 Jul 2026 07:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8U-0004O3-LT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8S-0003Qq-9N
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOkJZCc1dSzed9vvtL6uu5bHNkp3OjfHM14cHBb4Wf0=;
 b=LJnSgP5q4DnIVaolqSmEDK8klR8MlFFFCTjfpHjP0ko0h4StbQ4B8WiLrzmlj4nvkiaWDT
 H8KrJMkU9Mh5K2UvRf6XUyfUP0H6Hk6+8thMVmhlZE0u5L2XHW1FBHxy1Oka+GY9O5576e
 OlJcu/z/pd2WWPFYKpWufhpndMq+BU8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-VA3DtHE5My6yadTc1EaK5A-1; Fri,
 17 Jul 2026 07:53:42 -0400
X-MC-Unique: VA3DtHE5My6yadTc1EaK5A-1
X-Mimecast-MFC-AGG-ID: VA3DtHE5My6yadTc1EaK5A_1784289221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0B91800667
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38C511955D86
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:46 +0400
Subject: [GIT PULL 07/15] ui/vnc: fix out-of-bounds write in lossy refresh
 dirty marking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-7-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CxVMW5HXmXT2p59JNqgnfulfZZMYD+aakrFZing6FaY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheaVS9XN+hg+MOJZs854MOuV5S8CHIXuunEM
 bzyVLUzxGmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5dtKD/9SKs4FzrBIf3viLrksC3d5RX7mHfyxMpVXVHmmM6nTC+Kzg4NqCk0SkQ/2tlX2k/fADT0
 33UxmzmSZuP3vJWpnNtVfT0bsk8s58+fF3XnMFjKlUcemySclVJt76gJ0cJEx+wMC+rDJC3Z2yA
 kH8bWCJz4h2dKTi1eVMutawx84Ya30wHktSvbmZbYtKaviwp8R8r36Q7WfvrAVV9JJnByfq+96S
 AFyhPoHMTTyzTZnQXsJOoSbyRg8ZfTJVVD89VZTGR+R/TqSkrWcYsFwxLyKh9MKUTEVu60Oh822
 t6HC7X7qwjjgQw85qXZD8CyhscsfGkf/KfypQwyCkYN3ncHWj89rT8vJUjKiKaXTBPwKCd7ghP1
 vOGd8PInTT47qGtBOaERxmpRegGM6UjVc2GBmdu1CvvrbY/t7k8QTuVryidrB/3eWBUU56c32MO
 aGESMZkVgAIaL5txZfugckEMXOPZYfHEqn6FSxFN2JTWvqIlmrIStYiKHnrTpG1Nly5Dg7/mNte
 VWH0Z730S3h8YP3wwh6jq9erNhgrIwqIv6h6fh03MC3r1fIqTFB1XogjTAcWEgg//477yXw7EWS
 LOP0Lhl7aRSyblQCc6Ow77exkB6mPoxXjew+An1USfdY4uhn/eza4oIe9z5iyELLrW6ynRDbkg3
 IoSrCN49UbSHHOQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

vnc_refresh_lossy_rect() marks a full VNC_STAT_RECT (64) rows of the
dirty bitmap when refreshing a lossy tile. When the display height is
not a multiple of VNC_STAT_RECT, the last tile row is a partial tile and
the loop writes past the end of vs->dirty[VNC_MAX_HEIGHT].

For example, with a 2160-pixel-high display (VNC_MAX_HEIGHT), the last
stat tile starts at y=2112. The unconditional 64-row loop writes rows
2112..2175, overflowing 16 rows (640 bytes) past the dirty bitmap into
subsequent VncState fields.

Fix by passing the effective display height into
vnc_refresh_lossy_rect() and clamping the inner loop.

Fixes: CVE-2026-61475
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3935
Reported-by: "Vulnerability Report" <vr@darknavy.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 8d91cee4d9f..c957731877f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3000,18 +3000,18 @@ void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
     }
 }
 
-static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
+static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y,
+                                  int height)
 {
     VncState *vs;
     int sty = y / VNC_STAT_RECT;
     int stx = x / VNC_STAT_RECT;
     int has_dirty = 0;
-    int height = MIN(pixman_image_get_height(vd->guest.fb),
-                     pixman_image_get_height(vd->server));
     int rows;
 
     y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
+    rows = MIN(VNC_STAT_RECT, height - y);
 
     rows = MIN(VNC_STAT_RECT, height - y);
     if (rows <= 0) {
@@ -3083,7 +3083,7 @@ static int vnc_update_stats(VncDisplay *vd,  struct timeval * tv)
 
             if (timercmp(&res, &VNC_REFRESH_LOSSY, >)) {
                 rect->freq = 0;
-                has_dirty += vnc_refresh_lossy_rect(vd, x, y);
+                has_dirty += vnc_refresh_lossy_rect(vd, x, y, height);
                 memset(rect->times, 0, sizeof (rect->times));
                 continue ;
             }

-- 
2.55.0


