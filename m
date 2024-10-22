Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2FFD0E6FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36rI-00024q-6y; Tue, 22 Oct 2024 00:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36r9-000234-MH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:50:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t36r8-0008R0-0n
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:50:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso46825645ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729572652; x=1730177452;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vf5mc+JebpfS8OAvWe8RuE/C+y1x64JofpC/2Ctgm78=;
 b=lO3DdG69Rp0QgQPmV4El6N6B7NmWhpRwUYQurIaBhYMYNDgg61Q7RcyEhBMBauBsBa
 H1UaF0yf+19i3iVrf0D4uHj2QdTLeavUqSaZ2Uq4SHj2vdsAUsNmGtIzz3l5Ui3nubC/
 b58QUdVYV9GgeJ/wLgz2Dwn8gjgQoxdueFE21KOWcAxWQ0ruwL2WWBt3/5pwyhvYwF6q
 G4Syk5XucAqIru5HmhPUrgi58PIwD4Ofkw3LVqzcxozXC/0eivKX5dM8Qd/dItEHEDUB
 NQuHm5DGTEEE0pFrpfMXs85moCKoe/rRjuT7gcPZ/ljPOZ9lPO9uGe9YSze0SdK+AR21
 Wy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729572652; x=1730177452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vf5mc+JebpfS8OAvWe8RuE/C+y1x64JofpC/2Ctgm78=;
 b=HIWn07gzLTntfPFP6A/TMlz+ogt/y3W0/qF7RfClM6eNkJS/ZMkcvQh0YoiXGHoa4c
 WCGhz8XUOC6hELF3ijDlUzVPrcTIrkvhjmbQe9X+HeOJ3hDGgPw2JBIl1RQoSRm1agp4
 eTB1cg9hw8ncVeKn+ed+KNGpGlw3Xw0Yx/OPsAgBTefOXBaE4d9iRKrZxG07/CuTPYF2
 nux/XpS/qEfQSo7ELurhLaZoAQh2dG/CKBIeYEoi25B/C4FR5Ki1n1bYripZMg0ZHr/I
 Smx0YWyRUgEvzE/sTUgDva7Axzm/ZFWvpmkc6ca02ayD2zYzdT1qhtyJZsh6HwOH7NJ/
 Rvbw==
X-Gm-Message-State: AOJu0Yw1ExhSHgtjmkuiWfbKLkGvjiz8zebQZYBf5YGlnMhbb0k/v9Q1
 oXKWPnYILbZRGhNix+nthcjTkCFiDeiZlhLa9QgvLWdFQgThgB0UiCRCYhkad8E=
X-Google-Smtp-Source: AGHT+IHHW5QHFZLwhGcyEWmIyiMIsQIYxScquDd4gvYSnJsfatXfWJifgfYy3uxfvdrKQL/urprhpg==
X-Received: by 2002:a17:902:ce89:b0:20c:f648:e3a7 with SMTP id
 d9443c01a7336-20e5a91b7a7mr177011575ad.50.1729572652658; 
 Mon, 21 Oct 2024 21:50:52 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7f0f6d1bsm34158575ad.292.2024.10.21.21.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:50:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 13:50:38 +0900
Subject: [PATCH v2 1/3] qdev-properties: Accept bool for OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-virtio-v2-1-b2394236e053@daynix.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
In-Reply-To: <20241022-virtio-v2-0-b2394236e053@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Accept bool literals for OnOffAuto properties for consistency with bool
properties. This enables users to set the "on" or "off" value in a
uniform syntax without knowing whether the "auto" value is accepted.
This behavior is especially useful when converting an existing bool
property to OnOffAuto or vice versa.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/core/qdev-properties.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574dd0..f0a270bb4f61 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
     .set   = set_string,
 };
 
+static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_field_prop_ptr(obj, prop);
+    bool value;
+
+    if (visit_type_bool(v, name, &value, NULL)) {
+        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+        return;
+    }
+
+    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
+}
+
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
@@ -498,7 +513,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
-    .set = qdev_propinfo_set_enum,
+    .set = set_on_off_auto,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 

-- 
2.47.0


