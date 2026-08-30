Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2B1C61DE2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 05:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0YNi-0005Bd-Vx; Sun, 30 Aug 2026 01:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1x0YNb-0005BG-ON
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 01:46:56 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1x0YNZ-0001Ri-MA
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 01:46:55 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso1693918a12.2
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788068812; x=1788673612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sCLqvCcl/TsgvcW8ZflsErBGVRq5eKuTAYlxhpxwCPc=;
 b=JaOtxbnk3ogIenZ4UhBGbiHDW6Y8uivxv/tT6kKDFZWXGqX7nTMqn043ELd3l9eovt
 NvzH9/KSU4zsjepLQHvAFNXWrDUo02elzG/fm1IYD5ktgbVTJgEpbtbBqfMPXnScHpmB
 hOiqWZeq08G7X95WWEPsv+CkfrYYiAXrtDbkcVTR/CkHcS+W8q4PmAd/0kkxMrbsP1M1
 spXU25oFcy9479qrL5beXeUWz844n1vQGNd6b+VSzP0mRp70TBxPHu4MFKMyWkrWGJ92
 jJiIZZBPepvxrVtFj21BS3R170NpMxxi1/ziBn4QUyzRhidh3ptWU2+h5ItlQechuz3W
 o9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788068812; x=1788673612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sCLqvCcl/TsgvcW8ZflsErBGVRq5eKuTAYlxhpxwCPc=;
 b=BUm0OV06jGnML9SIkQdNTJGI8sCd/CPbsPzpybfPPWzFNGzV1mU2GHW1bZ0M18/pcr
 yBvYEbMtHdwOfLJjzBfNcxLJgbqu1uwY2oXx6gJJmx1rfLHLuYgaUwhUjzaDkecmQYVs
 MVq6bxCtxwuQU5wptbJo1Y87QTJe46zDO2S4drNDXzELPLCObTjE2hsI5hxd8pgw05B5
 okLFwAULMCs2MLMpDXLhHaImANUEYaTvvH/VxvJNis2Z1M21gIRAwhzHcQvgnRjfnf/9
 IUDLlB2FBg2pb7i1mo7nb1IILQd61Bt5gMCkH/jhpM7hdGUuQbUxdSZu65+YsnbpB0iW
 kDKw==
X-Gm-Message-State: AFuF++l0mXjM7KUnQsiNis7/yuvjD50OWhyYqhtw0+CZIIQxWPmWVE7E
 5HiinTOV4L0qXR5bZZNGB3YNwV71c3bSYGJYIU1tubReq7n1l2Geiw1Q7ZIy8py5v7TunA==
X-Gm-Gg: AR+sD100KZu2Ft2kwpIuTTkOMx//k2kqHQVACETacIIbEnzUx7OHiNWQtsjcIOcVv7G
 q1Wmwbcx/lojFPNLqVym/bJLzbOMQTCb2GBWKplbXrsRzTjuaJwXjfimqqokJWQb0Q+dJnVAPLV
 F2UEzlxEwPsgyRYjQS8GvFdSbn8SZEseKLhPqx658S4Zs/M4WaP8JMQRb0LtzRUJZHPhEuUzOdO
 21zf9NHUFsCsZkbmN41Y/vXR0XeZy/cqW9HXGDajujAohY/IO2ej3CAcSOUJO1mlHZbTmv9loiJ
 wlchSC3PBbOJGHLR+Jua91frAq5gjUCV+RPT1kGHUklWDhdpE5LRza8dsdnFl1YDmdaRpR6Er31
 Hvfnz+JfLH/NWfk8SyPcgu+KD/rFZHSnQDxPxO9umyAlQvm0Wt45bCBc+2L5Wp92loRccR723LJ
 +e5WWDKkiap5YTqGSEaupuf/COVegdZN2xdTJngiXnfVSDR8geiteIXHFef9M9Qai5mAd3Dw==
X-Received: by 2002:a05:6300:49:b0:3d3:adbf:7782 with SMTP id
 adf61e73a8af0-3d3adbf816dmr15668004637.23.1788068811842; 
 Sat, 29 Aug 2026 22:46:51 -0700 (PDT)
Received: from colazcyASUSlaptop.localdomain ([2a09:bac5:636f:183c::26a:c4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286fa5517fsm22878963eec.31.2026.08.29.22.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 22:46:50 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC v4 1/1] ui/dbus: add org.qemu.Display1.UIInfo interface
Date: Sun, 30 Aug 2026 13:46:41 +0800
Message-ID: <20260830054641.45437-2-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830054641.45437-1-colazcyg@gmail.com>
References: <20260830054641.45437-1-colazcyg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=colazcyg@gmail.com; helo=mail-pg1-x52d.google.com
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
  * property `Supported` indicating whether console UI info is supported.
  * the method `Apply` taking a dictionary as input.
  * the method `Get` returning the current UI info as a dictionary.

Signed-off-by: Chengyang Zhu <colazcyg@gmail.com>
---
 ui/dbus-console.c    | 106 +++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml |  50 ++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index e1ac06814b..947c3b3a54 100644
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
@@ -528,6 +531,98 @@ dbus_mouse_mode_change(Notifier *notify, void *data)
     dbus_mouse_update_is_absolute(ddc);
 }
 
+static gboolean
+dbus_ui_info_get(DBusDisplayConsole *ddc,
+                 GDBusMethodInvocation *invocation)
+{
+    QemuUIInfo ui_info;
+    GVariantDict dict;
+
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    ui_info = *qemu_console_get_ui_info(ddc->dcl.con);
+    g_variant_dict_init(&dict, NULL);
+
+    g_variant_dict_insert(&dict, "width_mm", "q", ui_info.width_mm);
+    g_variant_dict_insert(&dict, "height_mm", "q", ui_info.height_mm);
+    g_variant_dict_insert(&dict, "xoff", "i", ui_info.xoff);
+    g_variant_dict_insert(&dict, "yoff", "i", ui_info.yoff);
+    g_variant_dict_insert(&dict, "width", "u", ui_info.width);
+    g_variant_dict_insert(&dict, "height", "u", ui_info.height);
+    g_variant_dict_insert(&dict, "refresh_rate", "u", ui_info.refresh_rate);
+
+    qemu_dbus_display1_uiinfo_complete_get(ddc->iface_ui_info, invocation,
+                                           g_variant_dict_end(&dict));
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static bool
+dbus_ui_info_apply_lookup(GDBusMethodInvocation *invocation,
+                          GVariantDict *dict,
+                          const gchar *key,
+                          const gchar *fmt_str,
+                          void *res)
+{
+    if (g_variant_dict_contains(dict, key) &&
+        !g_variant_dict_lookup(dict, key, fmt_str, res)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_INVALID,
+                                              "%s must have D-Bus signature %s",
+                                              key, fmt_str);
+        return false;
+    }
+    return true;
+}
+
+static gboolean
+dbus_ui_info_apply(DBusDisplayConsole *ddc,
+                   GDBusMethodInvocation *invocation,
+                   GVariant *arg_ui_info)
+{
+    QemuUIInfo ui_info;
+    g_auto(GVariantDict) dict = G_VARIANT_DICT_INIT(arg_ui_info);
+
+    if (!qemu_console_ui_info_supported(ddc->dcl.con)) {
+        g_dbus_method_invocation_return_error(invocation,
+                                              DBUS_DISPLAY_ERROR,
+                                              DBUS_DISPLAY_ERROR_UNSUPPORTED,
+                                              "UIInfo is not supported");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    ui_info = *qemu_console_get_ui_info(ddc->dcl.con);
+
+    if (!dbus_ui_info_apply_lookup(invocation, &dict, "width_mm", "q",
+                                   &ui_info.width_mm) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "height_mm", "q",
+                                   &ui_info.height_mm) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "xoff", "i",
+                                   &ui_info.xoff) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "yoff", "i",
+                                   &ui_info.yoff) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "width", "u",
+                                   &ui_info.width) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "height", "u",
+                                   &ui_info.height) ||
+        !dbus_ui_info_apply_lookup(invocation, &dict, "refresh_rate", "u",
+                                   &ui_info.refresh_rate)) {
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
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
@@ -550,6 +645,7 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "org.qemu.Display1.Keyboard",
         "org.qemu.Display1.Mouse",
         "org.qemu.Display1.MultiTouch",
+        "org.qemu.Display1.UIInfo",
         NULL
     };
 
@@ -626,5 +722,15 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
     qemu_add_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
     dbus_mouse_update_is_absolute(ddc);
 
+    ddc->iface_ui_info = qemu_dbus_display1_uiinfo_skeleton_new();
+    qemu_dbus_display1_uiinfo_set_supported(ddc->iface_ui_info,
+        qemu_console_ui_info_supported(ddc->dcl.con));
+    g_object_connect(ddc->iface_ui_info,
+        "swapped-signal::handle-get", dbus_ui_info_get, ddc,
+        "swapped-signal::handle-apply", dbus_ui_info_apply, ddc,
+        NULL);
+    g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(ddc),
+        G_DBUS_INTERFACE_SKELETON(ddc->iface_ui_info));
+
     return ddc;
 }
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d96bae2ed6..26483edc37 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -1159,4 +1159,54 @@
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
+        Get:
+        @ui_info: a dictionary of current UI info properties.
+
+        Return the properties of the current console display.
+
+        - ``width_mm`` (q): the physical display width in millimeters.
+        - ``height_mm`` (q): the physical display height in millimeters.
+        - ``xoff`` (i): the horizontal offset in pixels.
+        - ``yoff`` (i): the vertical offset in pixels.
+        - ``width`` (u): the console width in pixels.
+        - ``height`` (u): the console height in pixels.
+        - ``refresh_rate`` (u): the display refresh rate in millihertz.
+    -->
+    <method name="Get">
+      <arg name="ui_info" type="a{sv}" direction="out"/>
+    </method>
+
+    <!--
+        Apply:
+        @ui_info: a dictionary of new UI info properties.
+
+        Apply the properties to the console display.
+        The dictionary schema of ``Apply`` is a subset of that of ``Get``.
+
+        The properties will be merged with existing values.
+        Extra keys will be ignored.
+        The invocation will fail if any key has the wrong type,
+        leaving the UI info unchanged.
+    -->
+    <method name="Apply">
+      <arg name="ui_info" type="a{sv}" direction="in"/>
+    </method>
+  </interface>
 </node>
-- 
2.55.0


