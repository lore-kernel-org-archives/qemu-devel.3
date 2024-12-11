Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27312C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZR-0004X7-UE; Wed, 11 Dec 2024 11:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZM-0003pU-K4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZK-0000Pi-NQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRrSXqg/+YjeMrLl+QDiq1syQzoZBeTQdvPr71n/Pxc=;
 b=Np9w7/Kkip51iBSrn7vOCK9qJ7qDTtik9ejdLnR/iyEKKQHwu4PWweT7VsN83UtXifIkHb
 GMXdbN4Q5HqSj/3kM2CyIRFI9IBIExsuYN8I1gCy9+TEk97JC0m3aLjUE/J5yV28zqKbQP
 W3qUIoWlYgZ8+eaZtyvtaU6BL4urpPk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-dSbmF2--NtiF1v2Km6bfxQ-1; Wed, 11 Dec 2024 11:28:07 -0500
X-MC-Unique: dSbmF2--NtiF1v2Km6bfxQ-1
X-Mimecast-MFC-AGG-ID: dSbmF2--NtiF1v2Km6bfxQ
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa689b88293so390193666b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934486; x=1734539286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRrSXqg/+YjeMrLl+QDiq1syQzoZBeTQdvPr71n/Pxc=;
 b=UHdDuzuTLnIWo+4fwHYhJzFvj+sPxYs16RS8jrXUAwVSBT2wPm1RUar61Ah7+MUJnF
 Mbg9DtY69++6ERk3AhowsaW6vEIb0CP/iyLXSJDX1zzSfJXlE+EMlc0npfG+DW7M/8Wy
 Ja1Anb7RghL5EQbIDME9FKOJ6mnsvUW5Sf3Ol4ghw6oVe0sSbLr6JX35KxnezgsHuy77
 FrSt4QSu+orF9ohu7q1pZ6C3BN8YVD2FyThelApkLaRbXhBOCwStaMI1Vv9DSqKNGtF2
 z/axvu/Vm6d9j3ZCpLz/My0CD2PP3gDYcMAlvHo5PU3OD9PRO4kbqZln/51oKSsObgwt
 QgMw==
X-Gm-Message-State: AOJu0YwT23aUPBQtB6c42iAgcDsSeMupG5BRE6x+ah0FyPHhSy1XV11G
 gbieevBF+YmRUPGkCTHiojZLSuGrOgrSfLMch++V2xGqlf1xKGedY16YrfaeU4YrnBqsJO06LQL
 kbHMjCVnmqeYWYxq1v6WXlMlHGSyK2NsWCUqDtrYBcpzx0IVl0rZ40L8631rVlrBKAU2OMGhnQ+
 4THw2xPhZxBoRT0l7iAVOG/fSVJwAJXgyzUQeN
X-Gm-Gg: ASbGnctrolKGmdbmT/Pz/okF3YQ9BwxUnv61wiY7+cF/tBejtoJQd+/w/8d/+c46WdD
 mXLIBuSxKmzcfXAOWa7XuVPUnKqX+ec8LZM02O9js1QMhkN+lM4Rwulw2yAfQeZDuAGXhUeX23x
 X+G3juNdGDFnyZrsZzZxILkQJZZZbqj2Du6RNPLS6v2r0LHmE/9xMh8uXajEHWHs+9fCCO/VrRy
 JT2dPhXK/WMHuFNNpV20RCaVxxwwlQif7TuXBgGGEQYR2408ucMMys3
X-Received: by 2002:a17:906:31cc:b0:aa6:2a17:b54c with SMTP id
 a640c23a62f3a-aa6b10f5d0cmr363227266b.6.1733934485885; 
 Wed, 11 Dec 2024 08:28:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXGrfANIexBy1+tEtPudrnrfGo/neSKYX8wA0P+6Xq9n/uJ/cIC2Qb9XPY0rFSFaYcDkrF2w==
X-Received: by 2002:a17:906:31cc:b0:aa6:2a17:b54c with SMTP id
 a640c23a62f3a-aa6b10f5d0cmr363224566b.6.1733934485451; 
 Wed, 11 Dec 2024 08:28:05 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa66c646e64sm652223666b.25.2024.12.11.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/49] clock: inline most of qdev_init_clocklist
Date: Wed, 11 Dec 2024 17:26:47 +0100
Message-ID: <20241211162720.320070-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move object creation out of qdev_init_clocklist.  The input/output
cases are very simple, and the aliases are completely different.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-clock.c | 71 +++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 2f9d6cb7579..dacafa4e036 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -22,7 +22,7 @@
  * Add a new clock in a device
  */
 static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
-                                           bool output, Clock *clk)
+                                           bool alias, bool output, Clock *clk)
 {
     NamedClockList *ncl;
 
@@ -38,31 +38,8 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
      */
     ncl = g_new0(NamedClockList, 1);
     ncl->name = g_strdup(name);
+    ncl->alias = alias;
     ncl->output = output;
-    ncl->alias = (clk != NULL);
-
-    /*
-     * Trying to create a clock whose name clashes with some other
-     * clock or property is a bug in the caller and we will abort().
-     */
-    if (clk == NULL) {
-        clk = CLOCK(object_new(TYPE_CLOCK));
-        object_property_add_child(OBJECT(dev), name, OBJECT(clk));
-    } else {
-        object_property_add_link(OBJECT(dev), name,
-                                 object_get_typename(OBJECT(clk)),
-                                 (Object **) &ncl->clock,
-                                 NULL, OBJ_PROP_LINK_STRONG);
-        /*
-         * Since the link property has the OBJ_PROP_LINK_STRONG flag, the clk
-         * object reference count gets decremented on property deletion.
-         * However object_property_add_link does not increment it since it
-         * doesn't know the linked object. Increment it here to ensure the
-         * aliased clock stays alive during this device life-time.
-         */
-        object_ref(OBJECT(clk));
-    }
-
     ncl->clock = clk;
 
     QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
@@ -90,29 +67,25 @@ void qdev_finalize_clocklist(DeviceState *dev)
 
 Clock *qdev_init_clock_out(DeviceState *dev, const char *name)
 {
-    NamedClockList *ncl;
+    Clock *clk = CLOCK(object_new(TYPE_CLOCK));
+    object_property_add_child(OBJECT(dev), name, OBJECT(clk));
 
-    assert(name);
-
-    ncl = qdev_init_clocklist(dev, name, true, NULL);
-
-    return ncl->clock;
+    qdev_init_clocklist(dev, name, false, true, clk);
+    return clk;
 }
 
 Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
                           ClockCallback *callback, void *opaque,
                           unsigned int events)
 {
-    NamedClockList *ncl;
-
-    assert(name);
-
-    ncl = qdev_init_clocklist(dev, name, false, NULL);
+    Clock *clk = CLOCK(object_new(TYPE_CLOCK));
+    object_property_add_child(OBJECT(dev), name, OBJECT(clk));
 
+    qdev_init_clocklist(dev, name, false, false, clk);
     if (callback) {
-        clock_set_callback(ncl->clock, callback, opaque, events);
+        clock_set_callback(clk, callback, opaque, events);
     }
-    return ncl->clock;
+    return clk;
 }
 
 void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
@@ -183,15 +156,25 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
 Clock *qdev_alias_clock(DeviceState *dev, const char *name,
                         DeviceState *alias_dev, const char *alias_name)
 {
-    NamedClockList *ncl;
+    NamedClockList *ncl = qdev_get_clocklist(dev, name);
+    Clock *clk = ncl->clock;
 
-    assert(name && alias_name);
+    ncl = qdev_init_clocklist(alias_dev, alias_name, true, ncl->output, clk);
 
-    ncl = qdev_get_clocklist(dev, name);
+    object_property_add_link(OBJECT(alias_dev), alias_name,
+                             TYPE_CLOCK,
+                             (Object **) &ncl->clock,
+                             NULL, OBJ_PROP_LINK_STRONG);
+    /*
+     * Since the link property has the OBJ_PROP_LINK_STRONG flag, the clk
+     * object reference count gets decremented on property deletion.
+     * However object_property_add_link does not increment it since it
+     * doesn't know the linked object. Increment it here to ensure the
+     * aliased clock stays alive during this device life-time.
+     */
+    object_ref(OBJECT(clk));
 
-    qdev_init_clocklist(alias_dev, alias_name, ncl->output, ncl->clock);
-
-    return ncl->clock;
+    return clk;
 }
 
 void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source)
-- 
2.47.1


