Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4117FCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHDr-0007FY-KO; Thu, 04 Jun 2026 19:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDq-0007FJ-JE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDo-0006LB-SV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780614690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jh4FKDkkZ9fI3XwVHCClBi0qhOegTlBzdvQBSit/whg=;
 b=WNx5EazuJRQEePuYGfBkeOWVPY0ySF3y5tRv6DQ5wLsZXZYz0daoxaK5mMmwEczASo/iLl
 qKF08nVyuVdcDNrSE1evp3L42eqTXiqnoUwaFxYDtmNOkTuRwkEjHI0Wc6qknaFTAJlm07
 pho1+7YgmAJVAZUJT1LcDG3syIuCogo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-PLaxo61COVyrJUrep4fITA-1; Thu, 04 Jun 2026 19:11:29 -0400
X-MC-Unique: PLaxo61COVyrJUrep4fITA-1
X-Mimecast-MFC-AGG-ID: PLaxo61COVyrJUrep4fITA_1780614689
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157f1be04aso35697185a.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780614689; x=1781219489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jh4FKDkkZ9fI3XwVHCClBi0qhOegTlBzdvQBSit/whg=;
 b=Kd2X0/gsn2JlekC+JI0W2kVPhht5oODYYEzKkZn7MAYDztw1sm2ZphWEcKP2aVX7UU
 1znYjaNlodhL//i8D+69huqGezxBEGOTfYFhrUGKj5NPjcmncVJPtLJnquXc4GT3+cn5
 7tu4mf/ldUNGhlwDxuzcDxjfhLdqgTflAKJXhghKjrOk6/z2M26XxlulRIRXcn/hnqIX
 VApirxIF91IlJAPEH6Z603JGdpphEh8t1mUYBr6JWnxzJ1ywOKxXlH/GgoeapceAk+vj
 BQHD7FBj/+1A5Uez7pbuCLtWP6DhWqWS80fQcl2HfFK0ekraxwBwFPqE9iuGUGNozDom
 l/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614689; x=1781219489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jh4FKDkkZ9fI3XwVHCClBi0qhOegTlBzdvQBSit/whg=;
 b=awigZ7KorL5McZjEPzZHReqpqB+2KgRGz9S7CCvPQQZhtNwENGKQs/p3ibfaA1iVW5
 gXwI5NFEXGk64B+0HpMLzaCnFLEDnmUIJXm5RtbsELyEsZGFzTeX+gNBCnZtGNi9n71q
 Sbd4Vl9l53JOJ+K4cceFq1enePoNiBGG1Mtz7CWID/9Gu3PQo+gEyEg7Lvzv7By/pxRA
 egWJwuksKoDW8JBPf+XGHYoC+226O2dwNKewCdnQG5YrRO98ZvO3v4QiLyb0w0CSwUh9
 WoLpeYgfIXQ3tYR/UV3O5S2ODcElsJKOHhi/gSNrv4d7he/THmHo5bxaUWa0N7OSWpDr
 rGSA==
X-Gm-Message-State: AOJu0YxZ8ckURN0xt2S2H1syqMkcqVHiHrfkhfkeQHekwNL4RBpwX8V6
 tbtRshf635W9dolRY1vKr2K0akEQIcMDJ61aFWC5/pHH7fsrjS2lrvzhoinbfm6X+BcDe9GxT/p
 ajz+sn6VhZnMt6rcIcbW7si/U4MtWDpG9Is1Fw8y5rCVgoLG2lomexB9dkhiZFOj9zC44gHEDQY
 dy8Dtbvs7KS4pANPo+hXOnnlqzmYlprPAHBF1E/w==
X-Gm-Gg: Acq92OHnPjsSP5b1NmpjFFbnrWxK9YHnuaGgGpTjsXhF2v0JCZkw6yFVk6ob8mHzE7y
 t4FppeFOU45hLllbSinPiYWkNuwJLSeqYy08xj7UULuc0nt4bikq+Z9EiDl+Qv+h0ee8hHgDr4I
 h2Ak+26RBexuO6tPZOJJe3R01ObStBbRpZz+dDlf5yAFqUCIUTpwNqxWtv4/zQ+IZJtXU3G6s59
 JRhxSQCwgZsh+Htk2O48d6zQEOENB0DJ1haEXl17n7KwYoQg6j4EYAsNFsu5q8ij2+OyC1wVqXW
 RAd4gQ5YkZp0EKTOEdap3DFMj60iQxO1LWPIpNS7Hz1jvOs/3KxthMD2OZRmgWR9ILLN9+LE7nP
 fGrBuwa2+yPN/Tflzf4PMT+E=
X-Received: by 2002:a05:620a:2a05:b0:915:9125:e634 with SMTP id
 af79cd13be357-915a9db4ce4mr216936685a.42.1780614688466; 
 Thu, 04 Jun 2026 16:11:28 -0700 (PDT)
X-Received: by 2002:a05:620a:2a05:b0:915:9125:e634 with SMTP id
 af79cd13be357-915a9db4ce4mr216926285a.42.1780614687779; 
 Thu, 04 Jun 2026 16:11:27 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm707617285a.22.2026.06.04.16.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:11:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 1/4] qdev: Pave way for exporting Property to be used in
 non-qdev
Date: Thu,  4 Jun 2026 19:11:15 -0400
Message-ID: <20260604231118.1584889-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604231118.1584889-1-peterx@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/core/qdev-properties.c           | 24 ++++++++++++++++++++----
 tests/unit/test-qdev-global-props.c |  6 +++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 34d7b26a73..8f870c85fc 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -31,8 +31,14 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
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
@@ -997,6 +1003,7 @@ int qdev_prop_check_globals(void)
 
     for (i = 0; i < global_props()->len; i++) {
         GlobalProperty *prop;
+        bool hotpluggable;
         ObjectClass *oc;
         DeviceClass *dc;
 
@@ -1005,15 +1012,24 @@ int qdev_prop_check_globals(void)
             continue;
         }
         oc = object_class_by_name(prop->driver);
-        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
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
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb9..86bb1458d9 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -275,8 +275,12 @@ static void test_dynamic_globalprop(void)
     g_test_trap_assert_stderr_unmatched("*prop4*");
     g_test_trap_assert_stderr(
         "*warning: global nohotplug-type.prop5=105 not used*");
+    /*
+     * TYPE_OBJECT can opt-in for global properties, so the error is "not
+     * used" too for nondevice-type.
+     */
     g_test_trap_assert_stderr(
-        "*warning: global nondevice-type.prop6 has invalid class name*");
+        "*warning: global nondevice-type.prop6=106 not used*");
     g_test_trap_assert_stdout("");
 }
 
-- 
2.53.0


