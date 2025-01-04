Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1870E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyiL-00039I-N1; Sat, 04 Jan 2025 02:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyiD-00038X-Fw
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:47 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyiB-0004w8-Uw
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:36:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166022c5caso159765885ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735976203; x=1736581003;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nUQUJaOUPrhv5bXHlKSaYOoVtPTOlAhSIbbKfSqWyrU=;
 b=YPMPl3dJQYDClO+nYZYoO0GKrBu71n23IILz8dd9B2oy8b07+hBesJ0QJJMhM26hmx
 HnZYis7TCNljbrqZ8V4KsCzoyIpCs260a87fm+XJwrC511f+dSJoXfXE67BlFDfQWBSY
 ea6EUpb1cF7Lu1yJzw/XXmWqWF4sx5MbK2d0NxTnuLjOn90CAJwUAjfm3v4Y8DywFRIN
 dCF+it1cEQfdw57Z9ROoGQeNUN/T6/8YxtxOu4bUUE9Pei6oCeq9bwwkJKIeJAZpoSlw
 Gu99gkvYv+vS6AAJP+3LKRpEmMsRmO4VVoafz8osdzkjW8CyH//mmtJffhTDg+0RqO3v
 s4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735976203; x=1736581003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUQUJaOUPrhv5bXHlKSaYOoVtPTOlAhSIbbKfSqWyrU=;
 b=CoLbfMBcHaiBY4kkNbfgJon47lexOaoSD/VAYZbsQvJtyqC849qWKBdThfI9nyX4WE
 391hLka12uS8JBdC3TgeQ5mAMCNW6S1uKMptzKZ4vxhK8IhhpqXOlVX+s5K7nbS/K74F
 QkYo8UXt3doG6yaZTW9xiAv54e9ts8P4zo3hQuAseZGGPUQy7MFygRzSHsEkvgo+1kUj
 v9mSAU7GrMvuKWuv41mI7mmFfTO0Fn4eA4CXuzlGF0tvlTSENFnRqLHBYmMz7THbalpA
 KT57IulpDjOaQnXTKrMyc6d7uO3Z9mgZFtWcQa7yWQDLQEaVLMiIcXkF7Hs9RH5HNBYo
 e6QA==
X-Gm-Message-State: AOJu0Yxya8/Qcwte9iAqDjSrpbfqp4d4X/WQIcq0/UnWvbyFDXOOVESU
 TQ7VKzdEU7RCZvdWrQQ4Q+tyR4ulyLZSvABbIquue6CVFAYMyH8dKToeZORHtrc=
X-Gm-Gg: ASbGncu8RdRsOktUHBR5jNVuLqOXEzIX2tVp5BiGOR8c4DU9U5PBfmGXEDndfoWgE2a
 bg3FTegPSJlFDoDpQAHUhybo0/7MBM8/l/cKUP8tpU3/6XKkOSjvE9arKuqDai7Vr/PgvLVlU3o
 p/IAuvQNZD01GrES2p1rTfFMGt56bbKSt+PC98o5vnn+iOwQoWT1NFEw79HmPd1/iIh5MzgJC7b
 rZ9PpcA2mJA1HTV0gA6bi1jo7DuOCxEOAWxSZ/vDooLD8O+UX8kAzOV/Gd+
X-Google-Smtp-Source: AGHT+IEWU9/cRizzUkr9glce1nyiXStd+Ml5FG/leQNJ4RKB7dbyiKSUJTstIgVqKz/sfjQHQA99rQ==
X-Received: by 2002:a05:6a21:6f87:b0:1e1:ab51:f531 with SMTP id
 adf61e73a8af0-1e5e048adecmr92981783637.22.1735976202703; 
 Fri, 03 Jan 2025 23:36:42 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-842e89059b1sm21196482a12.86.2025.01.03.23.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:36:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:36:05 +0900
Subject: [PATCH v3 1/3] qdev-properties: Accept bool for OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-virtio-v3-1-63ef70e9ddf3@daynix.com>
References: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
In-Reply-To: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 434a76f5036e..0081d79f9b7b 100644
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
2.47.1


