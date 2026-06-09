Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9CACD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0D4-0007g5-Dl; Tue, 09 Jun 2026 13:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ch-0007O9-Ht
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cf-0001rJ-27
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NdlNtbeLa0/ps13OdYmmm+9iFxk0+Y/xOAdI1YEzAQ=;
 b=Tlk78389EI7y3M8hGShRQ8f5OiGvN/OyWNl2kOh6BWu71ML77PZnvTByoSNFDi+fEyxN8d
 6YikEcaRbdGvamkdacX1Ril3tV6EHcP0N7mfbAMxgKRv61TDeWUveiKpIGDPWYGG1TsxH+
 qIku7F9wdj2qiTSi3LYoxm2WX+5CdhQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ThDCM-r_P1K9eKTYlh-_lg-1; Tue, 09 Jun 2026 13:25:26 -0400
X-MC-Unique: ThDCM-r_P1K9eKTYlh-_lg-1
X-Mimecast-MFC-AGG-ID: ThDCM-r_P1K9eKTYlh-_lg_1781025925
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517d766e05aso15457421cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025925; x=1781630725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NdlNtbeLa0/ps13OdYmmm+9iFxk0+Y/xOAdI1YEzAQ=;
 b=hBm/GjCD3p+7KkM6V2DemMWlGq8mTT5UG1DZWn7M73qb98t2px4K04SPV/KSRvk1Lp
 9ODL9Hj9zI186KESUdUZcHyyRaD1K31TEFCkcJRZMzfZpCjjptDh5Cd1TV+Op6JWsBMC
 /YTPL49pCAXjHJjogHevmg7u+76Tee6SChb1Yutn6RBgHZHGFcjNrD1G2QiPEDH/SGeI
 WNx+pkqOprWHhQr0MkbyktZsUARYbltyh25dXid7BnexwNfzzPeNk/GmVpEyr8UTOlbx
 EBV03Z2od6QMbaRojbcis3uWrdFrrDsBUT17PPRPUcofoZr93nNwd1Zhj4qAfCO4hdnB
 jUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025925; x=1781630725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NdlNtbeLa0/ps13OdYmmm+9iFxk0+Y/xOAdI1YEzAQ=;
 b=be+YPK3Ib8L5geg18wLrGtdHTsTIaIoAPs4WZJbFedS3oEjENIgREsZPUIyPlqRVgC
 kiPfl9Tx8dOeMjBl12dpoA8cQ18xddbjAy56zN9v7DpkfdOlgMgIT2XE0iq98AMwl/pj
 Er7R5jzRQkcn66Il3g/Wmdl6OdiVFTozkckmx+UmzqZhcahUWaQFLHz2pn1Uwz1puXnu
 OfVU/UFDxi7HMVsbFyK4x6IAOg1JHVucKD5VRrRa+6qmmlYWzb+pScSdQtKmPe837YHX
 cGt0Iw65R2oz0qGT1FRDRJCoyfma0pPq4u/5sBYDdZNmT/MttabaSd+zI0p/WmCpYOUA
 JlgQ==
X-Gm-Message-State: AOJu0Yw7v3lvZVOGBbCfaFAukBKE04a6InUZpsbXaNBkrBFLSUqdQ2mZ
 CIbr2cFhPhbMonFfEld/VTbihrrWqVpRK9BbSeQpurZUYXM0RZoyXYK1UIObSHRSaTSYFFEo/bi
 /kDLQenW7Xb2iDyDMV83X6OT5NCnoShTuLfJEZTDmZVt+XYdWUqcOFRZcXmhoKTvAJI2rrZ6tRv
 ie3PTTryCfscQw7DL548s1a7wcWJ6OC+27lqEThw==
X-Gm-Gg: Acq92OFunI9AJi4j2jxi/y3pTlxn1m9vNWOwX0JPcBE1UFGv4tEa2pN9T2/yQ9dzi2j
 6jyarDnXVgzgGxb9U9jHjNjetwXEJA+LqS3shhEwFXU0HNRbqQ4/Kj988mVouZfP1SZ40SIBuT+
 S8GxaUq6vIAoReg7FjSyVDViXx0fxx3HQetOXxeInom4fZK6h4Mr6nkFrGfe7OoeTQi/FrcuROA
 aMJBE9Dp9LcKJVENp8C6xXYwdcdxNL2BxpZBHJdP2TCYswuG9j9eARXJoQOaHqAB0MS1jU6jVI4
 +Pm4WF0IiFmHkSY7vvYMEXf2MjcLkNKLVMzDUJ+UYhnWCVOSyGDlfWO/jG/CjKeI8z61v6N9zFa
 xOJjtUWxPg3l4lPHbmVxPcus=
X-Received: by 2002:a05:622a:5518:b0:50b:3429:a10b with SMTP id
 d75a77b69052e-517986d4a6emr218254851cf.12.1781025925478; 
 Tue, 09 Jun 2026 10:25:25 -0700 (PDT)
X-Received: by 2002:a05:622a:5518:b0:50b:3429:a10b with SMTP id
 d75a77b69052e-517986d4a6emr218254171cf.12.1781025924798; 
 Tue, 09 Jun 2026 10:25:24 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 04/10] hw/arm: Use nodefault version of qdev props when not
 needed
Date: Tue,  9 Jun 2026 13:25:08 -0400
Message-ID: <20260609172514.2037645-5-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We're going to introduce defvars for object properties just like qdev-props
defvars.  It work slightly differently in that props can be added in
instance_init() with default values, then the default values can only apply
after instance_init() completes.

It means any explicit set of property values within instance_init() when
used together with object property's default value (or qdev-prop, which
builts the default value framework on top) will stop working.

This patch touches two of such use cases where the device may add qdev
properties with a default value first, then quickly set another value
within instance_init().

These are the only two outliers I found across the QEMU tree that do it
this way.  Switch them to use qdev-prop's NODEFAULT APIs, and always
initialize the values manually.

Example 1:

bcm283x_base_init() adds qdev prop bcm2836_enabled_cores_property with a
default value 0, then it immediately set another value inside the same
instance_init() hook.

Example 2:

aarch64_add_pauth_properties() adds qdev prop arm_cpu_pauth_property, but
then it will immediately update the same field (cpu->prop_pauth)
conditionally when hwaccel_enabled()==true.

Without the change, some arm test may fail (boot-serial-test) after
introducing object property's default value framework, because devices'
values will be overwritten by the properties' later.

OTOH, this patch itself should introduce no functional change.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/bcm2836.c   | 3 ++-
 target/arm/cpu64.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index f4ecea908b..9e4d30c99c 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -19,7 +19,8 @@
 #include "target/arm/gtimer.h"
 
 static const Property bcm2836_enabled_cores_property =
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
+    DEFINE_PROP_UINT32_NODEFAULT(
+        "enabled-cpus", BCM283XBaseState, enabled_cpus);
 
 static void bcm283x_base_init(Object *obj)
 {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2816735577..a3a014a994 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -635,7 +635,7 @@ void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 }
 
 static const Property arm_cpu_pauth_property =
-    DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
+    DEFINE_PROP_BOOL_NODEFAULT("pauth", ARMCPU, prop_pauth);
 static const Property arm_cpu_pauth_impdef_property =
     DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
 static const Property arm_cpu_pauth_qarma3_property =
@@ -660,6 +660,7 @@ void aarch64_add_pauth_properties(Object *obj)
          */
         cpu->prop_pauth = cpu_isar_feature(aa64_pauth, cpu);
     } else {
+        cpu->prop_pauth = true;
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma3_property);
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma5_property);
-- 
2.53.0


