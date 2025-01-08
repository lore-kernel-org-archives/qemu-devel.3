Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F205E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPP2-0001AS-Ft; Wed, 08 Jan 2025 01:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOV-0000n2-9u
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:20 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVPOT-0000HE-Q5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 01:18:19 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165448243fso45921895ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 22:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736317096; x=1736921896;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nUQUJaOUPrhv5bXHlKSaYOoVtPTOlAhSIbbKfSqWyrU=;
 b=PCqzNLpzHqWwnNWJ038FTh3JOTEouvj+esCMUMjLIC1JHOJjFGLGe+4abQVK+oX5qY
 F7MNy/oI4nvN0C1COFRPKgOjyRAh9Pj3eMrX1Ucl+GJj/KkTgZedOl44iGmYUM/a3sk2
 iZJD1Czg63PwZUwZXspM4oaiqnrNS+zH1XmEYZiwNZJBPbZOn6M0gz/YDvFCtghnVVTr
 jxvrs4vAfoWM/MZDA+zFjYzLwBoplUBtNZb1nD38B4ROq25w3QCOD9X6MvsO9ljWN8RA
 iOnGiSUe4/jQ/KSvqCs1GHqBqGD4Q0RO10fyi6ITTzbe5/81WWXEeLB//EVw7/xob/aX
 lmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736317096; x=1736921896;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUQUJaOUPrhv5bXHlKSaYOoVtPTOlAhSIbbKfSqWyrU=;
 b=dQRY9GHQPhyXgrmvEWE4ExLsT1gChmL2YIcwVPA9AoxqkImfFRZfVJa51Sn+Wy9T6h
 cjF/fuLP3vsIOME4ekQa1kHfCRMuPkkhauHryXpGhCZXJOeLbNnps3rdC7NzTHqoDi8D
 JWzqhkbY7QX470rHUIRau/jpIL0FiCqlYAmV8VyDxbbbTInx72vCm3usXv5HfWXAMQQm
 wtFYH2HLgYXS1mZPQrrnPBtuHPZuZPQ23VMa5xz85w0fzGqd04kq07cJUXoCeFOXv+yZ
 cd0qDdW6UyQsLe1YR5Ej8PbsY4G1wLGtCyFmNN1GLs2OXujpng22Rfxd3cMOjW92x/b6
 SrAA==
X-Gm-Message-State: AOJu0YzEodhg0vC0Gl6nnZe96dOzCRjAHtUBzyGU1/nXs3SeO3I/To4X
 SBNojgXc+4vLw7GOokbBvX2549D0mrqdHa95/fTiTrjy9l3zYV+03dT9gzQyOP0=
X-Gm-Gg: ASbGncun0hF+mBO1nuakOX9RMW0TAmQosl08jYRRJpk5FK0bj+kOGHpRqG7y/W1sn6U
 t7C3YkUicyb91L/1qMejWWM7dhJ00HIGwm0NysHtAi69/Du6RQWzkFPAXFxiO+tdElCyLRkzL9J
 /cq94km6MZllFQ6pyw6wvL0iiN8OdGavFWS1JmBGTlPsWCLBow3TZbprEEG59u9LU4CAFbGI4/i
 0/7sp6qXy4FXTjFvMvd3ZT5tzNTacS5/0IMzxu/IA44wW5S1SAkM89EofQ=
X-Google-Smtp-Source: AGHT+IGCFCfnIQoMVlRzZZOMz/25mJgmLOpJPyL8iO6RmWq3L+oo3yjy/spVycNhbZTm8l7+14ZJfQ==
X-Received: by 2002:a05:6a20:7fa7:b0:1e0:d575:8d4f with SMTP id
 adf61e73a8af0-1e88d39c828mr3360172637.37.1736317096456; 
 Tue, 07 Jan 2025 22:18:16 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8344desm34346090b3a.54.2025.01.07.22.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 22:18:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 08 Jan 2025 15:17:51 +0900
Subject: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
In-Reply-To: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
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
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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


