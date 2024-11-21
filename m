Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD41E64006
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECks-0006Lp-Nz; Thu, 21 Nov 2024 14:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECko-0006KN-W7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkn-0002WC-HU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rw/GClsfR9o9I7KixsNs9zzzzwG0HdX9+W2Tp8XS1Ew=;
 b=AHkY66WxeELjD0Y5zc/OVZdtwtMhnfAX6FzdoMy0I4yHNxs3n3oPAp0vx8Slc7EsKYIwq+
 0DmWvXzfjapVTQNlBcHUweuTtCI1q34ASAy5nmXASwfsPZkwKjvuICxdt/TiJQu6SaBYPv
 svQFky4zUGnnoJBarPwzWn2wDwVixbI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-8FuYqdvlOBqG4CVSz19RSA-1; Thu, 21 Nov 2024 14:22:11 -0500
X-MC-Unique: 8FuYqdvlOBqG4CVSz19RSA-1
X-Mimecast-MFC-AGG-ID: 8FuYqdvlOBqG4CVSz19RSA
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83ac354a75fso136802839f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216930; x=1732821730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rw/GClsfR9o9I7KixsNs9zzzzwG0HdX9+W2Tp8XS1Ew=;
 b=SIbWmsGOwAoeBUjVYGfPOO8CuhbN6CcEdjR8urzrCMcKX/gecsF608ot9dJGGGHTOH
 X/cyVMsL5bO8G7PaOsCsl1uac5Xk46guLIhBzD7pOOEvkeQr4fproKbPe1Xo9fnqMCzf
 ReuptgSOgP0wJ8bn4djtDnAcrUNmguQ3q544QC3nrmsvD+eqgH4mTbdffUtfGETmrQTV
 dJI5yr27le2+J4w64qYXpbpLa49hdTlAgPccyZVV9NWwrdtZ6l2JOMaVkbegLHdgRFb5
 SwKXjNreo3CkmxrYBupowYdbDsz5cSg7IMC0J8uoLalS3KQpVAjunNdZoCoRqc8dEbqG
 Wrkg==
X-Gm-Message-State: AOJu0Yx4h+JFwmal+m1QN0pdIgPyfkjhnk0Wc4U6tBJM7FW53f2fINyX
 WGxiLSVQjYKk/Shw7pM7vYmMaSbCRskedbqX3Em7Fl0kYcDHkf2ydUuIofj/5iF1Y6fJtLGPGx6
 LP08sSH8ASnsO8T3LDmQnOihg4coeJhrZvFB7sE/OlLTTEWNrHIU0eJ8SpXYQNuiFDAyYVS93lA
 ztGTk+INM+MeMfbAThut5h+46dDemOTi0l3g==
X-Gm-Gg: ASbGncspCb2JaXFFvNSATVXKji4DCXh2hNWyWI/FEV8Rk/bS02Wp7zsl0TWYctmpP+T
 01snQzTLyhyYWULSloXPrxpCFb+zVXmL+Qslv4j/W42m593h9QZVGscb/GE0eSSRdGNxOawqFip
 PrYEYiimiEgarMY1jrvBQavtAS4289xRV0TGsoHGUif0EDZvm5wMn1jq0XYNoecdgrJd7F777sq
 LNtXjusjUI9981p7qv83DHdMKxt6oJekcyVOgFeT97FuvhVhr4afAzDDGkd7uerIDBpoPiGLWN4
 N4hMkMx4BN+87O0ThaZP/L/0VQ==
X-Received: by 2002:a05:6602:6406:b0:83b:2c8e:c4 with SMTP id
 ca18e2360f4ac-83ecdccd02amr9561639f.9.1732216929865; 
 Thu, 21 Nov 2024 11:22:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/7FmvnXr6M6psjVVPSnYMPInMPRY2OdxuTteVJo/OryGFXGMO/kGrmpXhr5dMti43tMx0Wg==
X-Received: by 2002:a05:6602:6406:b0:83b:2c8e:c4 with SMTP id
 ca18e2360f4ac-83ecdccd02amr9558539f.9.1732216929525; 
 Thu, 21 Nov 2024 11:22:09 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 03/13] tests: Fix test-qdev-global-props on anonymous qdev
 realize()
Date: Thu, 21 Nov 2024 14:21:52 -0500
Message-ID: <20241121192202.4155849-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

test-qdev-global-props creates a few subprocesses and test things based on
qdev realize().  One thing was overlooked since the start, that anonymous
creations of qdev (then realize() the device) requires the machine object's
presence, as all these devices need to be attached to QOM tree, by default
to path "/machine/unattached".

The test didn't crash simply because container_get() has an implicit
semantic to silently create any missing container, hence what happened here
is container_get() (when running these tests) will try to create containers
at QOM path "/machine" on the fly.  That's probably unexpected by the test,
but worked like charm before.

We're going to fix device_set_realized() soon, but before that make the
test case prepared, by creating the machine object on its own.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/unit/test-qdev-global-props.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index c8862cac5f..85756d39ce 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -72,6 +72,26 @@ static const TypeInfo subclass_type = {
     .parent = TYPE_STATIC_PROPS,
 };
 
+/*
+ * Initialize a fake machine, being prepared for future tests.
+ *
+ * All the tests later (even if to be run in subprocesses.. which will
+ * inherit the global states of the parent process) will try to create qdev
+ * and realize the device.
+ *
+ * Realization of such anonymous qdev (with no parent object) requires both
+ * the machine object and its "unattached" container to be at least present.
+ */
+static void test_init_machine(void)
+{
+    /* This is a fake machine - it doesn't need to be a machine object */
+    Object *machine = object_property_add_new_container(
+        object_get_root(), "machine");
+
+    /* This container must exist for anonymous qdevs to realize() */
+    object_property_add_new_container(machine, "unattached");
+}
+
 /* Test simple static property setting to default value */
 static void test_static_prop_subprocess(void)
 {
@@ -295,6 +315,8 @@ int main(int argc, char **argv)
     type_register_static(&nohotplug_type);
     type_register_static(&nondevice_type);
 
+    test_init_machine();
+
     g_test_add_func("/qdev/properties/static/default/subprocess",
                     test_static_prop_subprocess);
     g_test_add_func("/qdev/properties/static/default",
-- 
2.45.0


