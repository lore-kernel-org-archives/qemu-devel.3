Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8A6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1D3-0003s6-Lm; Sun, 11 May 2025 03:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cy-0003ra-1k
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cw-0003eJ-GE
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73972a54919so3426714b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948883; x=1747553683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GD00sUZOZrB9HHzwrU461gFiGd5/EAk6Pa8GbiDiias=;
 b=VzucHF9opKszFFzyFV5IrygWQWX48VMgPphlx6FML1EEhofgJENm9KamHKhVvpgW04
 UAiAFJkPj2FMVgpE15sB7tnGrqJNwC3rseLIzfeTZwc58mUEvOLEhQ90FSwTr+zWPYhp
 Kh8mQEl2txFPk+4Uap9O39Hms/6OVbrc3g6eTenW8wfXb0HyyXEeAXiQ3Pc+fdg7PPMF
 p7QIG58oRF5HWU5lLwgjWSCHg5OTHHByyzBwY3jPGgdhU8mDEgVDs08V3NTtjjR/rn10
 +QfIbeYK1OTGhbuoZ5WGuFkCwCFbsNi4pqNG8S1DnsRz0hVEbtSyp2W1oWaPpPMDsTNM
 BYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948883; x=1747553683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GD00sUZOZrB9HHzwrU461gFiGd5/EAk6Pa8GbiDiias=;
 b=mpWzX+m1m/wkG5yMts8tc5RbQQ13p2dJ2pCS1sYB89b/L8V2kt/y7F0ewup/GjAuHQ
 2Pe/5iWoClO/HMukvBGH71oevHGpN5rZL5DPr86nEgQvD/TKsZbtLJj/uRk9XbEzfYbF
 gHud50t64p6vT+mYI3vCJNPff4oc3BVQr2dYd2xH7SaDqZFD0QRnaGqjDGp5YcQdeS9o
 uxdZ/rx3S28Np/ZwK7Y2zKpiGGKrwoVNRDdw9R/Mpjs8wJSKMwD6hbFkjyXDNGmbJdkW
 MMoSWY/Kz7/yCvpyGvbDlUtqxDDafwIpLHWCGDj17FUeLred8tnNo+jft6VX6etKu4C+
 mXxw==
X-Gm-Message-State: AOJu0YxTSXK0G+f3sz9QuR+wNhjENk5q//WV7fk8JRPwjPdDREOixVJn
 kItgAjUxfR8oaQyyijaOCh+SBFcq/2y1vigKL7TsuzPgZudlmiNkd02L1L0u
X-Gm-Gg: ASbGnctb969BSgliaB6opbOmnZ+Cc3s+M0Kd/YFF2bsGqBqeweFPilXPiog+PmS4ezN
 jHy5uSTO7NHP8bEW5Ur5KmbmmmoOV5wr3UppW0SJboiIlIU/0bAwZgDIeih+WSjKKVI9OVxcPUv
 g894uMvK3Aa2O56qGPfjQKp8YKKpsalWGoyO6mnQkFjStW06Cai6RPkHAsg4chFWBt4PydW/0P6
 pyXI2BGXbqpYUlsWPA4zSQXbQGPVGO9h8EhEr/mpyUHc0dolceOOxlqmY4klcRkuc5PculQV7Be
 RguxRdfFEQXvWfNmA87A54zqwc5XkyPPXquduFoHSu9STN7375uqo+Q=
X-Google-Smtp-Source: AGHT+IG3lQ410cGLegCOdC8n9h11cBwBwT0VfaHZkKceb9eWgMGpzSa6RwBgQFWwEPEYj4BR9/4+1w==
X-Received: by 2002:a05:6a21:108c:b0:1f3:2a83:7548 with SMTP id
 adf61e73a8af0-215abcc7e9bmr13755704637.38.1746948882901; 
 Sun, 11 May 2025 00:34:42 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2349dd1fd8sm3783534a12.26.2025.05.11.00.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:42 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PATCH 4/9] ui/gtk: Update scales in fixed-scale mode when rendering
 GL area
Date: Sun, 11 May 2025 15:33:14 +0800
Message-ID: <20250511073337.876650-5-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42d.google.com
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

When gl=on, scale_x and scale_y were set to 1 on startup that didn't
reflect the real situation of the scan-out in free scale mode, resulting
in incorrect cursor coordinates to be sent when moving the mouse
pointer. Simply updating the scales before rendering the image fixes
this issue.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
---
 ui/gtk-gl-area.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index ba9fbec432..db93cd6204 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -43,6 +43,8 @@ void gd_gl_area_draw(VirtualConsole *vc)
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
     int pw, ph, gs, y1, y2;
+    int ww, wh;
+    int fbw, fbh;
 
     if (!vc->gfx.gls) {
         return;
@@ -50,8 +52,14 @@ void gd_gl_area_draw(VirtualConsole *vc)
 
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     gs = gdk_window_get_scale_factor(gtk_widget_get_window(vc->gfx.drawing_area));
-    pw = gtk_widget_get_allocated_width(vc->gfx.drawing_area) * gs;
-    ph = gtk_widget_get_allocated_height(vc->gfx.drawing_area) * gs;
+    fbw = surface_width(vc->gfx.ds);
+    fbh = surface_height(vc->gfx.ds);
+    ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area);
+    wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area);
+    pw = ww * gs;
+    ph = wh * gs;
+
+    gd_update_scale(vc, ww, wh, fbw, fbh);
 
     if (vc->gfx.scanout_mode) {
         if (!vc->gfx.guest_fb.framebuffer) {
-- 
2.49.0


