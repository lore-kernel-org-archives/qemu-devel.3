Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8248D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0ba-000794-5b; Tue, 09 Dec 2025 11:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aV-0006Ho-HG
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aT-00022w-RU
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2AcrUG9/G/Q5aMS5M3ggKBjSnTnF15A94G53j7mYT0M=;
 b=EXQIwvqaGCMUJRwTDsxZzuRG/Sbtb3q/kgnp10ho8jSHMXBYJUQtZ5k8iagtrezSnz75s3
 ctjqhLuKreoQ9WHbLqaYfKJoTKq9ntkGQ/5tPiwP7W9Id+qMqd0dOSsRAVLk82CDJ7H3dj
 Go3dZx2vwWw0pXx+sqjStxyMOQ+uuJE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-tw9MTtxIOYCVu6bQPEVcNQ-1; Tue, 09 Dec 2025 11:29:14 -0500
X-MC-Unique: tw9MTtxIOYCVu6bQPEVcNQ-1
X-Mimecast-MFC-AGG-ID: tw9MTtxIOYCVu6bQPEVcNQ_1765297754
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e9b2608dso948953685a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297753; x=1765902553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AcrUG9/G/Q5aMS5M3ggKBjSnTnF15A94G53j7mYT0M=;
 b=NgqWKAE1jvDJZLqnv7gRaa6Qg7D+01BRviJiKIxH02BYE0cTjlrevHytza0mTz6glV
 Kgfe9aYXjOrckvXkEyJ9HsABMr+ZRp9m5KYeWCzV4NzKJxvI9QpM6fQtJngjE6+roeEF
 EVHRdSsfLYmL1IJ1viWU7eFTwiRGgHbvNNGI/Q/KjK7FpoIZZFGbSTz84gFle8RD5VIU
 hBW2E8TEiuaU+WFd38BPz77wvV5z/AhutcYhSv8yOGkfEJjWGgl58fAcnKkiKcSmD7iD
 SXq7mf1b6skw/R+6Q+5KCukKkpiAV6V6R2wmnOW6NOBt3fRU2tCjf/BpVeDLeZ+wk/Xu
 h+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297753; x=1765902553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2AcrUG9/G/Q5aMS5M3ggKBjSnTnF15A94G53j7mYT0M=;
 b=e78pz9bhuWQQAVylWatAQAThRBZoYACVvVcjE6WjMeIyzZYU+Y1seIUQzTZrPmt+vn
 kGanBRhStMmHN8nmsT/TWwLO8avBjpvfkoo37SXPIA0Sy9atD4A3+TguN++kl3OQpj1G
 tMOjuWnAlc5SBpzNlDX/GjnLdEypzIe+/btRF4uulMqz3Pkf7NBORdrnGmpqjiH/3qXa
 hUVPcRGerucS3g3TdmO3qY0klYmTXdCKslD7Kpn2Aq9o2UDTF1baGfFYRvFP/kvrfqpi
 gldUMysQtN6kM1gI1m3DuEnq32d9LV6Lh0Gw0y1Yp/ERY+bnN2wOlCyA65pemic47CQ9
 T4LA==
X-Gm-Message-State: AOJu0Yz8iy/oNl5NigRM1K4J69J5qOM2tr22P7uw11YDL7afIvs8E8uE
 PL7BbB5RErUr8qRUSAW3aCYhFwykxDtQL6CQOK0hT4OXbaVtmDV/Juooasyg615SQYAcAcwEAxZ
 cZUNxWDdne1OVAzpx+s6Nqbbzfo4SKcYjCS9hmMbWQygeIZELqzPWHiXmMmbRzicTsQjzrNlSgm
 omJPLfGcZ6pXfrV+cetmW05NndnOvBgjSu5MT+qw==
X-Gm-Gg: ASbGncvIsFvwdIZ2d4FZ4jJhwQpImh8jRG5J8PGMgPAOG+uNZg3GknylWUdBSvi45t0
 R3UADIN/id2W7NQN7zLlk/7m9bwgnMSWvz5J2qt33jg1iOzHVw9WivIlvyOhlh4oam4SIKAEezQ
 5PqG0XulfO11npPZSUJozhyPDrYgZFkIUPzLJOxHNm8TbtMoecjMbFgRqk2Pz+BlsaYJt/dCh2e
 a9RmgQRx/VGZnUG8iDi3uw+tegF/uH3EJzKJm/LKkGTmVSphZTnY3ArFYiGmx/xcX4xzdrWcEX4
 XFwExVtqSN9eXbmCGzajGAd86CVJzFBnmxXWHEwRE7Rbesf46vBrlSIb/24FaMrx0Seet54kwm9
 kfSg=
X-Received: by 2002:a05:620a:28c9:b0:8b2:f090:b167 with SMTP id
 af79cd13be357-8b6a24ff1e5mr1678457385a.24.1765297753482; 
 Tue, 09 Dec 2025 08:29:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7x/6p/JI/zPrZ5AOlKdYuWTJDwsemho/emnESwiVfnfgZROCSHYKsaZgkPj7vXY1jIX9bqQ==
X-Received: by 2002:a05:620a:28c9:b0:8b2:f090:b167 with SMTP id
 af79cd13be357-8b6a24ff1e5mr1678451385a.24.1765297752921; 
 Tue, 09 Dec 2025 08:29:12 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 07/10] qdev: Pave way for exporting Property to be used in
 non-qdev
Date: Tue,  9 Dec 2025 11:28:54 -0500
Message-ID: <20251209162857.857593-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Property itself is a well defined interface to either support smooth
conversions to Object's properties, or supports global properties.  However
currently it's tied to DeviceClass, aka, qdev. So non-qdev cannot use
Property list.

My current observation shows Property is almost ready to be used as a
separated exported interface, except two small things that may need touch
up internally:

        qdev_prop_allow_set
        qdev_prop_check_globals

The 1st one currently checks against realize state (which is part of qdev
attributes only).  The 2nd one checks for all global property being used in
all non-pluggable qdevs.

We can loose the check in both spots, keep the check if the driver is a
qdev, otherwise we can safely whitelist non-qdev use cases of Property.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev-properties.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969..c8110ff0b8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -30,8 +30,14 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
 static bool qdev_prop_allow_set(Object *obj, const char *name,
                                 const PropertyInfo *info, Error **errp)
 {
-    DeviceState *dev = DEVICE(obj);
+    DeviceState *dev;
+
+    if (!object_dynamic_cast(obj, TYPE_DEVICE)) {
+        /* Currently, non-qdev can always set Property anytime */
+        return true;
+    }
 
+    dev = DEVICE(obj);
     if (dev->realized && !info->realized_set_allowed) {
         qdev_prop_set_after_realize(dev, name, errp);
         return false;
@@ -987,6 +993,7 @@ int qdev_prop_check_globals(void)
 
     for (i = 0; i < global_props()->len; i++) {
         GlobalProperty *prop;
+        bool hotpluggable;
         ObjectClass *oc;
         DeviceClass *dc;
 
@@ -995,15 +1002,25 @@ int qdev_prop_check_globals(void)
             continue;
         }
         oc = object_class_by_name(prop->driver);
-        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
+        oc = object_class_dynamic_cast(oc, TYPE_OBJECT_COMPAT);
         if (!oc) {
             warn_report("global %s.%s has invalid class name",
                         prop->driver, prop->property);
             ret = 1;
             continue;
         }
-        dc = DEVICE_CLASS(oc);
-        if (!dc->hotpluggable && !prop->used) {
+        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
+        if (oc) {
+            dc = DEVICE_CLASS(oc);
+            hotpluggable = dc->hotpluggable;
+        } else {
+            /*
+             * Currently, to be strict to assume all non-qdev are not
+             * hotpluggable (whoever will use -global).
+             */
+            hotpluggable = false;
+        }
+        if (!hotpluggable && !prop->used) {
             warn_report("global %s.%s=%s not used",
                         prop->driver, prop->property, prop->value);
             ret = 1;
-- 
2.50.1


