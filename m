Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FE4C54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2JP-0005wh-Hf; Sat, 09 Mar 2024 14:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2JN-0005mI-Ep
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:49 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2JL-00030L-NO
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:49 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4467d570cdso222999866b.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012286; x=1710617086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IXK0wenZmYfT6yBITIHGYESwGfPru4qC6kLvjxG9yg=;
 b=TRpMwXKF63pdPAvGMgc6ixM4eoIBkr6yoc4X6K1oEkSpy9Wxpw4JPI+kljWmF0wg9D
 JE9PEE4DVSgebju7pEz34rvWN8LDjE6Tm8SYgT2BVCFRVZ2cTLc2/alKPlBFtEvr/csk
 8GYG7NWZQwjgkGEseMrljxcEEbdVltS3/Ztk8VOZQZWAiM+FuNCcQ1Hh5OBGrXZ+VCDh
 sqUzjSBMrV25pyBviNeemAv0vw2EICEWfXOlAYAEQBWUxP+CvUms5441fmU2yYJ1jLUY
 GQSknB36f5mXe6W7Npw/Ei3aGNQjsbVgEQYPmnpH9/ksumQlzpavmapwQvXyfbkpX5B9
 T5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012286; x=1710617086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IXK0wenZmYfT6yBITIHGYESwGfPru4qC6kLvjxG9yg=;
 b=VU4fD9WTDwr5xjeufF6VM1BlpyRQUzh3bkm57T7lr5IljdfhWXr8Mzmdo8ss91cuOg
 KyZmdvr3mNddIyEHILWkG0J0DdVYxoAkOSAATsc2N7p43BcvaryHvEvDvdMW6wDKckpA
 SjdsB61SiSWbjdma5GoYREBSGwW2bkKAncF/OJd+0qJsoaI7i2v7u2uw3Eq4YE+yvZRX
 xocKhk8SKi92Ai8n7ablPrJh/gbdXizz+PLh7DCkjnULO7yrLChYGVOwunILp5YZMDOE
 5TpwkQc0L4FosSsaeJgtf8rISlxBHO3J4Je6SWJhMn42LF8sb77/dZyN7iK/473ShEJL
 TVPA==
X-Gm-Message-State: AOJu0YwiztgXDDydi0PxgXmKgEdlhkgTKJX1m+7UbsLOM5cNPxgeeL3q
 Oda6h63rry9kowsQL5lmrEss1naBAc/kCL0QdSwgCiVZ7kRzi1X4s+IjlBr1ldabTCRPE4gXNl4
 n
X-Google-Smtp-Source: AGHT+IHdZOGcI74LpqpnrucOzRjs+bV7tLhNh0HZy5RFuXIPB4cAJdoJYfXFqX4U5X9g7UUqrm1EgQ==
X-Received: by 2002:a17:906:d0c5:b0:a45:110e:568f with SMTP id
 bq5-20020a170906d0c500b00a45110e568fmr1452152ejb.37.1710012286153; 
 Sat, 09 Mar 2024 11:24:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 kq17-20020a170906abd100b00a40f7ed6cb9sm1173609ejb.4.2024.03.09.11.24.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 25/43] hmp: Add option to info qtree to omit details
Date: Sat,  9 Mar 2024 20:21:52 +0100
Message-ID: <20240309192213.23420-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The output of info qtree monitor command is very long. Add an option
to print a brief overview omitting all the details.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20240307183812.0105D4E6004@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qdev-monitor.c | 27 +++++++++++++++------------
 hmp-commands-info.hx  |  6 +++---
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..ad91e74181 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -744,7 +744,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 }
 
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
-static void qbus_print(Monitor *mon, BusState *bus, int indent);
 
 static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
                              int indent)
@@ -784,13 +783,9 @@ static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int ind
 static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     ObjectClass *class;
-    BusState *child;
     NamedGPIOList *ngl;
     NamedClockList *ncl;
 
-    qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
-                dev->id ? dev->id : "");
-    indent += 2;
     QLIST_FOREACH(ngl, &dev->gpios, node) {
         if (ngl->num_in) {
             qdev_printf("gpio-in \"%s\" %d\n", ngl->name ? ngl->name : "",
@@ -814,12 +809,9 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
     bus_print_dev(dev->parent_bus, mon, dev, indent);
-    QLIST_FOREACH(child, &dev->child_bus, sibling) {
-        qbus_print(mon, child, indent);
-    }
 }
 
-static void qbus_print(Monitor *mon, BusState *bus, int indent)
+static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
 {
     BusChild *kid;
 
@@ -827,16 +819,27 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent)
     indent += 2;
     qdev_printf("type %s\n", object_get_typename(OBJECT(bus)));
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        BusState *child_bus;
         DeviceState *dev = kid->child;
-        qdev_print(mon, dev, indent);
+        qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
+                    dev->id ? dev->id : "");
+        if (details) {
+            qdev_print(mon, dev, indent + 2);
+        }
+        QLIST_FOREACH(child_bus, &dev->child_bus, sibling) {
+            qbus_print(mon, child_bus, indent + 2, details);
+        }
     }
 }
 #undef qdev_printf
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict)
 {
-    if (sysbus_get_default())
-        qbus_print(mon, sysbus_get_default(), 0);
+    bool details = !qdict_get_try_bool(qdict, "brief", false);
+
+    if (sysbus_get_default()) {
+        qbus_print(mon, sysbus_get_default(), 0, details);
+    }
 }
 
 void hmp_info_qdm(Monitor *mon, const QDict *qdict)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index da120f82a3..ad1b1306e3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -540,9 +540,9 @@ ERST
 
     {
         .name       = "qtree",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show device tree",
+        .args_type  = "brief:-b",
+        .params     = "[-b]",
+        .help       = "show device tree (-b: brief, omit properties)",
         .cmd        = hmp_info_qtree,
     },
 
-- 
2.41.0


