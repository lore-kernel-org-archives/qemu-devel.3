Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC62C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 22:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3hg1-0001ZV-41; Mon, 07 Sep 2026 18:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x3hfy-0001Z7-RV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 18:18:54 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x3hfx-0006Ny-B9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 18:18:54 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ffe6893503so52624a34.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788819529; x=1789424329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tqkb0nxxvLlir4EclLaqufHCETs9Ige8/dDC2rP09D8=;
 b=lcGn73n4mvbnIazhK5Zd3NAW01SzZxrawRSstesGWSMe0USyyFDZrSaSNwqSmv9e2s
 S7kpH/DobNAjRXIATuDRSRSW5wGR5ekROSRtpoTBWJqcbsRNUmrRVYERD3MLP4EaLRjh
 zBTzsRYfU73QzjgdMzmXKhWdBZ1Iczu2k68iV3Pn9BXmcKe0tfkx5WzImBeDASEnqadv
 PQERA8VF8zcWszDozdovEb99IZ00B3R1VgHK/pe/s7UgkO2H/GU3tHZADHIMmQBvtaqj
 vL2GO81qQ8vt+m13UbjV/t7V4AqtaBW5pMTyBn2pwp36eJicLcnDLHKUgeNY6XKUKl6b
 5e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788819529; x=1789424329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tqkb0nxxvLlir4EclLaqufHCETs9Ige8/dDC2rP09D8=;
 b=jdrRv8VKRxXkba8nxWd65Q5vfq+qD627CgLJkNltz4J4KgUDJMVhYDgzT4AP/eclQ0
 rQAeged8HXwReqKEDEeenZ9JwjD5vpot6tcIypWxecVmQhd+9dWceiZsfWfQPQ05isvP
 3ZtgYY4joyMZ6msxpnFUr8fTqtNL6afe71d+XgpM68C5BwCJXrzr5JZkaU2MaAJ8DUP1
 PyV/LQoa1zFuDYktCJD/sn/rcM1tJqtz7xPiiFASMaywp4QPSldlil6giRyRCXUJI0Zg
 P7eU1WnIgQuLAe2LG3LQIteLOCWZ4skP5CvMZX4IFrJ6UR+5oyPIPAT0JWPxkTXfB++F
 qw6Q==
X-Gm-Message-State: AFuF++kFyvUfqKqp/TXld/E+xi6PE0SNhkuX1PAKTrXgPL/Vm9P6hdD2
 yiUUXrIXDmtP98KpHgnQDumHvSxLeMXesqMT4ZOg9YeFi/3v0ItME3ycKIW8gF7X3CI=
X-Gm-Gg: AYBFou2CI+D5Gr+2t9f5aY3E5GGqFN/MmbBwkOhtQn7eEM2ZufZIu1/kZgshpNIVPk0
 I0NIywjz5sA/kCMBKLcRR1PZGm01/1FZKwdPGCetXqMu1QpPHuczr9+snB6Bnu3T0KHhjwSVnQQ
 /ZAGupTDPnbkGYcz3NT237TnXhO22ghSDoKWM6ry0Ky/35adLxHA801e/UH25C5lQqEF+uLlpys
 swLXZJZQIEI9LB1FaKTgULO5DPWYzBE3paQkKfZGmQqtjgZw6gwExP9X7lPr4XmC75qXv1jkPeQ
 7O+jPM4g8EB6lTSC19F5beGcI+jTQGUvvrlGW4NBUjXYfMSxNcrjfW1Xz9NrO3Yr9zxTpFwdOfF
 ApRz6osPjuiUdWrYRdIKWf1g3PcSJIpp6zkcG73yJIq0wOcfVqDF71vENrVxeIW/j0cKl66fH5/
 jHzFqRhx5Z9wxj9CRRJT5E0M5tMUS/MYvT116WNbfGV0qJGg9Fq/u3JRjFohnDEdhg6p27Ww4V3
 tEHwpvkQR3VjTJHksiDhOOxDktInCa0DDw4jJjsnu4Nx8cwwOCsDg==
X-Received: by 2002:a05:6820:2005:b0:6b6:4f90:a62a with SMTP id
 006d021491bc7-6b6fc7d4063mr24648615eaf.11.1788819529375; 
 Mon, 07 Sep 2026 15:18:49 -0700 (PDT)
Received: from rick.hobi.hobi.com
 (1393128-v117.1221-static.oswgilaa.metronetinc.net. [69.174.143.208])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dd57198esm15013902eaf.11.2026.09.07.15.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 15:18:48 -0700 (PDT)
From: Rick Vernam <rtvernam@gmail.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	rtvernam@gmail.com
Subject: [PATCH] ui/dbus: skip GL scanout dispatch for placeholder surfaces
Date: Mon,  7 Sep 2026 17:18:38 -0500
Message-ID: <20260907221838.519111-1-rtvernam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=rtvernam@gmail.com; helo=mail-ot1-x329.google.com
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

When using -display dbus,gl=on together with a virgl-capable video
device (e.g. virtio-vga-gl), a guest-initiated reboot aborts QEMU
with "dbus_scanout_texture: Assertion `tex_id' failed"

virtio-gpu's device reset path blanks each console via
qemu_console_set_surface(con, NULL), qemu_console_set_surface()
in turn substitues a placeholder DisplaySurface.  The placeholder
DisplaySurface does not have a GL texture.

Other GL-capable UI backends already guard against this: both
sdl2_gl_switch() (ui/sdl2-gl.c) and the 2D SDL path (ui/sdl2-2d.c)
check surface_is_placeholder() before touching GL-texture state.

This patch adds an equivalent check in
ui/dbus-listener.c dbus_gl_gfx_switch().

Signed-off-by: Rick Vernam <rtvernam@gmail.com>
---
 ui/dbus-listener.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 2e2f6ba418..5f627f6acf 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -861,6 +861,9 @@ static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
     trace_dbus_gl_gfx_switch(new_surface);
 
     ddl->ds = new_surface;
+    if (surface_is_placeholder(new_surface)) {
+        return;   /* nothing real to scan out; avoid dereferencing a non-GL surface */
+    }
     ddl->ds_share = SHARE_KIND_NONE;
     if (ddl->ds) {
         int width = surface_width(ddl->ds);
-- 
2.55.0


