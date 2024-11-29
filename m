Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACA6D729F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 18:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH5LN-00042Q-E1; Fri, 29 Nov 2024 13:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5LC-000426-8x
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5LA-0006OZ-LB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732903420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QElT273DCPwXRmjrILbj0xzrSJsB2liod7ICaJaBk+8=;
 b=bcKgemqiUaD70az41/xsUNXsJ0vm5ePoaGvBs/1itZtxjcuFFolbCMJJ8JYBbqGxivW+9v
 i0FS0/GkTx/tAJKF6pwnVXc7UMfg0QZHocXaHC3pM/2CZS7IIJNmsubHJy/h+4gAfNJADL
 3Oc+AdO01cb06KBEUzWGs0n1UGDgljU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ScJAr475NBK924dJ04u8NA-1; Fri, 29 Nov 2024 13:03:36 -0500
X-MC-Unique: ScJAr475NBK924dJ04u8NA-1
X-Mimecast-MFC-AGG-ID: ScJAr475NBK924dJ04u8NA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa527da110bso131471966b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 10:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732903414; x=1733508214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QElT273DCPwXRmjrILbj0xzrSJsB2liod7ICaJaBk+8=;
 b=iI1hHu+pP0k49txsuFIUsktzviJbjcVCDM/CMSwZraa2alGEQnBarwNrBj24TXJNkh
 yhE1HmR138BlIbI0EtJuPPrtDBaeg7TxWHF8kZ+8vIeQWmykVc8voeMYQNlBxV7hHODE
 DnSZd0a44Shy607JbdWn6oTcZunY8KdaeXicnlyqr4siml5vSZA7WGiE51IUD2LPXvVz
 GVHGL9emkHYLqHxlexye01Ds397qLhdHwwFmoPjyKv0+rE6UFe+ZEDeKdzm6UQB6lGV7
 l/DfRgcZP5vPmH31OND3/YSoaKaoMKQyKwvx8N8ZKFl68e1hAhyUVU0OJrbqFNYVWkbc
 244Q==
X-Gm-Message-State: AOJu0Yz700wzkD9sLDtbcHu8597rcpsXPhgM3HtC+DudSF9y32TtbhmD
 z85GHpJ791MFfTL95MY19AbaQGVYOFjZ4i68R6srVLul0mjX/hGVfh7ImRtW5CTA7heUBWmNI6u
 eb+bLfiAH5sTnt0f9xww/sv+WZZZEgSIWq7sPA6O8k1DjrwkMNPxvbF1wWxYqv+x12/6XbQYPRJ
 sZ20KSCn0uBPQlO/Kj/aVkDc9q5CDj+fdc7tXo
X-Gm-Gg: ASbGncsJZYzQY2/whxI3PM2N2yeNt1bG/lHjnmcI2zqCrzl387lFJ5+dTUZiFXSB96I
 3qDn7R4mrlCFY2CMlihfx8YxWDXFOEYsIsrH/pMdM5zgRi6dA34+IfL+ayDCuDNOqSohwW+w2Td
 Ya1/SjUP6PbOcBPGKFeeMrk1I6+lIHdHzyIuE65pCQ72DWZluqf7ypggJy/kjnjTFtSV1mJ7Rds
 ewxqBVZPr+mSX2ca/c6093zjfsDRR3w7jhpvCEuVM9pLeGq27DB
X-Received: by 2002:a17:906:3ca2:b0:aa5:2bfb:2ebf with SMTP id
 a640c23a62f3a-aa580f2c485mr898888266b.22.1732903413519; 
 Fri, 29 Nov 2024 10:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYoINRlNeoOxUWMtthfFak97YYyLol5Ov189AJr8YQFCv6Z4XuHwT63wbuqpnSAmJIuoIfWQ==
X-Received: by 2002:a17:906:3ca2:b0:aa5:2bfb:2ebf with SMTP id
 a640c23a62f3a-aa580f2c485mr898881966b.22.1732903412887; 
 Fri, 29 Nov 2024 10:03:32 -0800 (PST)
Received: from [192.168.1.84] ([93.56.170.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59990a848sm196381366b.150.2024.11.29.10.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 10:03:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 3/3] clock: inline most of qdev_init_clocklist
Date: Fri, 29 Nov 2024 19:03:26 +0100
Message-ID: <20241129180326.722436-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129180326.722436-1-pbonzini@redhat.com>
References: <20241129180326.722436-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.47.0


