Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81855C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 09:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u64qf-00019F-LJ; Sat, 19 Apr 2025 05:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1u64qa-00018x-MC
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 05:50:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1u64qZ-0007Rd-15
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 05:50:52 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227cf12df27so22207085ad.0
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745056248; x=1745661048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5BQAo8K2RwE4MbpagvSvoYPieHxR7+KEEFsonadnuo4=;
 b=ec/3byAjdvPYDMarBqfADUdKtP/0QHQ3fnenwlkyakgeK+EfyRRdl1KPxqIkkcCb2n
 VzFXw/kcupFD+Z5lxUSyISPDxVEYqG7FS6LAWQlJ9yV8GCMGDPITy12MTSGbugiqEpFP
 Pjz9A0aHRDOliOXDQP9DD7uQzo9T+xyqwWUAX17FaXtbCumLP6pOi3oEeu62rsUtDMw8
 2or/8uUXclVe5eVdYf7Tsg2/4Y3gzS493lsZHiQDs1rjHxVnyqtyniYY5Y2NnMv0eBCP
 P9LhHpKFf92Ux172JrGLNszuWOrsDRcLIU/OeQx1LbEvo0Xz0x+d4XS5DFjpmnr5KnCM
 00tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745056248; x=1745661048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5BQAo8K2RwE4MbpagvSvoYPieHxR7+KEEFsonadnuo4=;
 b=H5uTZpJ4wayYh69f/iHQMeT7kUq8pD6aEy//ijC5/1QD++AAHDSar9yx4iPCyyeTrW
 gZzCfZsdHKi6LMil79aGMv77g49BcTar7FtZVzx0sThmDccAxcBZtKGZ3taKNn/7qKz/
 Q9lrKoURZNhZsims23FN0WDPL9rpv3ctj85AwiaW0nm72/xgVg70gndDYqj5yKRuRro+
 laPjwnhLpxLFGf04NALwtudsGhILS+UDFpN5xqj8Geu1nZbPABXYh4wz/3m+AL/Pbyt0
 UqMzGFYtS/YzMgMnyFGeej8uRMDL3ihWavxV9YMZp97S6Tyk6SUvBPOv08kx1saoos7G
 1LUA==
X-Gm-Message-State: AOJu0YwFU78r9MN2u2pzodZLrut8opi7WiV0MgpOdbvgyn3+SCphIt7y
 7DDw2BJZj8CZjmiTsqDuZkZy5X8ztrTGeLU16YIPQsLVzSin4Oaxwo5WPnVX
X-Gm-Gg: ASbGncuZCFYXcz0aWf8Cxt6ZhhyBokESm9DXPEzE4dghkJjs4oOZjCj9yYhcL5O5am5
 HesvVLSYtpQlstwKCwon1bbEVsHkA2tr0f6/woz7tk6LUey5kmNnDIqSrVcLL5LmmzBL+XupJ53
 h8yHvEihYbRq7amYgW+nIy5fx57JYy1e2htqxVlwBUymvUmBTBJHj9dxQ4AgQqBDgjfR+if0yLs
 o+QU69PcfL7M+BzZ0fjaRI5vPIQhXKqGc1ci8+8Y6xRXSK/mhKg99Q9rT+Q0WZfrn+LeXlS/4v5
 +PnACmnbXJd0v9TKf3Md4CAbq0Fd/b2NHp82MvxPOQf0
X-Google-Smtp-Source: AGHT+IHnIJ0Qv20Lqds6ft3wAubCYhUzXRBw+SSPDV1uAClaNneCvqCf7ypw4Ks4mggDCcFP+5xLwA==
X-Received: by 2002:a17:903:3d0c:b0:220:ff82:1c60 with SMTP id
 d9443c01a7336-22c50cfa84fmr99580135ad.14.1745056248216; 
 Sat, 19 Apr 2025 02:50:48 -0700 (PDT)
Received: from localhost ([103.192.227.29]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c04afsm2956908b3a.23.2025.04.19.02.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Apr 2025 02:50:47 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>, hikalium <hikalium@hikalium.com>,
 Alexander Orzechowski <orzechowski.alexander@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui/gtk: Properly apply x/y scale when rendering GL area
Date: Sat, 19 Apr 2025 17:48:41 +0800
Message-ID: <20250419094959.224954-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On startup, scale_x and scale_y were set to 1 that didn't reflect the
real situation of the scan-out, resulting in incorrect cursor
coordinates to be sent when moving the mouse pointer. Simply updating
the scales before rendering the image fixes this issue.

Cc: hikalium <hikalium@hikalium.com>
Cc: Alexander Orzechowski <orzechowski.alexander@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk-gl-area.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 2c9a0db425..01235f876a 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -42,6 +42,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
+    int fbw, fbh;
     int ww, wh, ws, y1, y2;
 
     if (!vc->gfx.gls) {
@@ -53,6 +54,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
     ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area) * ws;
     wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area) * ws;
 
+    fbw = surface_width(vc->gfx.ds);
+    fbh = surface_height(vc->gfx.ds);
+    vc->gfx.scale_x = (double)ww / fbw / ws;
+    vc->gfx.scale_y = (double)wh / fbh / ws;
+
     if (vc->gfx.scanout_mode) {
         if (!vc->gfx.guest_fb.framebuffer) {
             return;
-- 
2.49.0


