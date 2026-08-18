Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA86C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwK9n-0008ML-PY; Tue, 18 Aug 2026 09:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwK9l-0008Kv-S8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:47:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwK9j-0002WW-Vk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:47:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84847482584so787008b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787060826; x=1787665626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W8xw4xuVrne9VPdeHP022FffaXORam9vgUFplH8jy6k=;
 b=Tlu/t0rhxAXLt3JFTnNduEuH6xylGyBzpSnRSmys4QrJOEln0paqdj2pzPbVpcy9U2
 ENqaw/Jc7dEyoATLv1d6QRvKTZp55oucqPA3XCgmd+fI3hzP+mf/VDtLxyRvMxBkHcOY
 gBJacWzQQnq2qXIFGEYSeedJtkFuAJja4bYACUnsfGXp2xjJLKPx58JM+Mzp2pSmmUuQ
 g55kKEC4NrRQjY3dTE0C+26tGvZBcysEWBvlKrr0wwguk6qX7HLP36brzHL4FtJ7Wr3I
 h93D37jcduk8BbAzLvqe5k54VZKNQ+c/+k1EzX6XQwvC0JSxr5x0zk5C4eKYHnbfXunX
 O9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060826; x=1787665626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W8xw4xuVrne9VPdeHP022FffaXORam9vgUFplH8jy6k=;
 b=B2t1UIjmfIe5jdvyajGiRpLCJDfgONvPAjV8D9WtyORIdszLqDHwbV3/L8M7XngCTF
 ScOCxBtWMZJ98zjknJm88uXe8Lh47dQTBftCJkDbKMvZ5t+E05slO4Ey3usePQJ4V+qP
 p4yoJWMAmiI7ui88m2aqZffQnbpLRLn/Pr5PpwwIB9s2FTvEydz1Nx56yGYsOLRp/PTK
 fhLBR2CxEOXH0l2UQzF1jcTjU7QBdIYYUzdikDmrUP9ct8Wd0s+xHb3H+vvAAMQv8PAE
 BdshdeD+5bCWQ3R3eOlkN0LDTx31pUe3k+1g6Jq4GzOl9MrEyDyf4b534PdmjUDVd4yo
 NN6w==
X-Gm-Message-State: AOJu0YxtorlxOmvOIeOMVnYAjujn9azNZM+ehySbJbUoyqbQACL7iTHX
 HNZbT52iEiOK3H0+ZR/D2BaZIzPuey8U6llVVKyNA+DeBvIphlQx3wARzsC13kc3rmUYyw==
X-Gm-Gg: AR+sD13nameoaf4hIh1GIFjv4X7Kd25IgSEvF/KEmEWpuL5dXNue6VDPHap4bxIZu0E
 vAFDG5IdnRfqnogmpe8Z2GWVRVkJ8u3W6ME1uegaZlabk/HGTkkcIuBIoiZxTkq54pqW0Zg0Rtc
 NLrjl9ic5lwm+Inc0SSB4DLJ6tZz+vVOQUpHhDfgTfLDVuxwsV3Dzw/i3iboXR6DmOkKZNkd4WY
 gCHHrXvuOIhd0wpW1skMWBzIjstXkeFvrrww9uc09pkr3c431UfKnTdJ1V4YF6V2tgKm8RdRRar
 Ig4658QbvrYysx+5p5pMDw83gb1cH6c0EOLBkkbjOsOT4B6QFazPHwmXVtR0Oa4Qlb1Z/rkCH0B
 6nJHeOYit936VrVFszUhKuyEjPF1INSP6BtkaFTE3/LZUQlbw9Jx1SAMzlHzKrsrCjF7P3ofl3O
 suQu4IcIbuyeVnZBlWJp4HhUiiPKtr7ODvAbxCZ2xtPdIkDoOQRGUo
X-Received: by 2002:a05:6a00:1a02:b0:851:8bde:7861 with SMTP id
 d2e1a72fcca58-851be598889mr4852469b3a.1.1787060825840; 
 Tue, 18 Aug 2026 06:47:05 -0700 (PDT)
Received: from colazcyASUSlaptop ([2a09:bac1:76e0:3d0::26b:c3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6ff0a13sm1620529b3a.59.2026.08.18.06.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:47:05 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC v3 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
Date: Tue, 18 Aug 2026 21:45:43 +0800
Message-ID: <20260818134543.654949-2-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818134543.654949-1-colazcyg@gmail.com>
References: <20260818134543.654949-1-colazcyg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=colazcyg@gmail.com; helo=mail-pf1-x42b.google.com
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

Currently, the SetUIInfo method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This patch adds the UIInfo interface containing
  * properties as staged display settings.
  * property `Supported` indicating whether console UI info is supported.
  * the method `Apply` applying staged settings.
  * the method `Reload` reloading settings from the console.

Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
---
 ui/dbus-console.c    | 71 ++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index e1ac06814b..2c71272a1c 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -55,6 +55,8 @@ struct _DBusDisplayConsole {
     guint last_x;
     guint last_y;
     Notifier mouse_mode_notifier;
+
+    QemuDBusDisplay1UIInfo *iface_ui_info;
 };
 
 G_DEFINE_TYPE(DBusDisplayConsole,
@@ -155,6 +157,7 @@ dbus_display_console_dispose(GObject *object)
     qemu_input_led_notifier_remove(&ddc->led_notifier);
     qemu_console_unregister_listener(&ddc->dcl);
     qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
+    g_clear_object(&ddc->iface_ui_info);
     g_clear_object(&ddc->iface_touch);
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
@@ -528,6 +531,63 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
     dbus_mouse_update_is_absolute(ddc);
 }
 
+static gboolean
+dbus_ui_info_reload(DBusDisplayConsole *ddc,
+                    GDBusMethodInvocation *invocation)
+{
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    QemuUIInfo ui_info = *qemu_console_get_ui_info(ddc->dcl.con);
+
+    qemu_dbus_display1_uiinfo_set_width_mm(ddc->iface_ui_info,
+                                           ui_info.width_mm);
+    qemu_dbus_display1_uiinfo_set_height_mm(ddc->iface_ui_info,
+                                            ui_info.height_mm);
+    qemu_dbus_display1_uiinfo_set_xoff(ddc->iface_ui_info, ui_info.xoff);
+    qemu_dbus_display1_uiinfo_set_yoff(ddc->iface_ui_info, ui_info.yoff);
+    qemu_dbus_display1_uiinfo_set_width(ddc->iface_ui_info, ui_info.width);
+    qemu_dbus_display1_uiinfo_set_height(ddc->iface_ui_info, ui_info.height);
+    qemu_dbus_display1_uiinfo_set_refresh_rate(ddc->iface_ui_info,
+                                               ui_info.refresh_rate);
+
+    qemu_dbus_display1_uiinfo_complete_reload(ddc->iface_ui_info, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+dbus_ui_info_apply(DBusDisplayConsole *ddc,
+                   GDBusMethodInvocation *invocation)
+{
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    QemuUIInfo ui_info = {
+        .width_mm = qemu_dbus_display1_uiinfo_get_width_mm(ddc->iface_ui_info),
+        .height_mm = qemu_dbus_display1_uiinfo_get_height_mm(ddc->iface_ui_info),
+        .xoff = qemu_dbus_display1_uiinfo_get_xoff(ddc->iface_ui_info),
+        .yoff = qemu_dbus_display1_uiinfo_get_yoff(ddc->iface_ui_info),
+        .width = qemu_dbus_display1_uiinfo_get_width(ddc->iface_ui_info),
+        .height = qemu_dbus_display1_uiinfo_get_height(ddc->iface_ui_info),
+        .refresh_rate = qemu_dbus_display1_uiinfo_get_refresh_rate(ddc->iface_ui_info)
+    };
+
+    qemu_console_set_ui_info(ddc->dcl.con, &ui_info, false);
+    qemu_dbus_display1_uiinfo_complete_apply(ddc->iface_ui_info, invocation);
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
 int dbus_display_console_get_index(DBusDisplayConsole *ddc)
 {
     return qemu_console_get_index(ddc->dcl.con);
@@ -550,6 +610,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "org.qemu.Display1.Keyboard",
         "org.qemu.Display1.Mouse",
         "org.qemu.Display1.MultiTouch",
+        "org.qemu.Display1.UIInfo",
         NULL
     };
 
@@ -626,5 +687,15 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     dbus_mouse_update_is_absolute(ddc);
 
+    ddc->iface_ui_info = qemu_dbus_display1_uiinfo_skeleton_new();
+    qemu_dbus_display1_uiinfo_set_supported(ddc->iface_ui_info,
+        qemu_console_ui_info_supported(ddc->dcl.con));
+    g_object_connect(ddc->iface_ui_info,
+        "swapped-signal::handle-reload", dbus_ui_info_reload, ddc,
+        "swapped-signal::handle-apply", dbus_ui_info_apply, ddc,
+        NULL);
+    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
+        G_DBUS_INTERFACE_SKELETON(ddc->iface_ui_info));
+
     return ddc;
 }
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d96bae2ed6..2a8a8563ee 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -1159,4 +1159,85 @@
     -->
     <property name="Encoding" type="s" access="read"/>
   </interface>
+
+  <!--
+      org.qemu.Display1.UIInfo:
+
+      This interface is implemented on
+      ``/org/qemu/Display1/Console_$id`` (see
+      :dbus:iface:`~org.qemu.Display1.Console`).
+  -->
+  <interface name="org.qemu.Display1.UIInfo">
+    <!--
+        Supported:
+
+        Whether console UI info is supported.
+    -->
+    <property name="Supported" type="b" access="read"/>
+
+    <!--
+        WidthMm:
+
+        The physical display width in millimeters.
+    -->
+    <property name="WidthMm" type="q" access="readwrite"/>
+
+    <!--
+        HeightMm:
+
+        The physical display height in millimeters.
+    -->
+    <property name="HeightMm" type="q" access="readwrite"/>
+
+    <!--
+        XOff:
+
+        The horizontal offset in pixels.
+    -->
+    <property name="XOff" type="i" access="readwrite"/>
+
+    <!--
+        YOff:
+
+        The vertical offset in pixels.
+    -->
+    <property name="YOff" type="i" access="readwrite"/>
+
+    <!--
+        Width:
+
+        The console width in pixels.
+    -->
+    <property name="Width" type="u" access="readwrite"/>
+
+    <!--
+        Height:
+
+        The console height in pixels.
+    -->
+    <property name="Height" type="u" access="readwrite"/>
+
+    <!--
+        RefreshRate:
+
+        The display refresh rate in millihertz.
+    -->
+    <property name="RefreshRate" type="u" access="readwrite"/>
+
+    <!--
+        Reload:
+
+        Set the staged properties to the state of the console display.
+    -->
+    <method name="Reload">
+    </method>
+
+    <!--
+        Apply:
+
+        Apply the staged properties to the console display.
+    -->
+    <method name="Apply">
+    </method>
+  </interface>
 </node>
-- 
2.55.0


