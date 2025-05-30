Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74D5C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiY-0002f4-SF; Fri, 30 May 2025 04:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiO-0002Yx-EJ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiL-0004e8-Ge
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTevlSH5ZQkYyW+Mm1Gr4K/vGmq39vmXxviFGBBggFI=;
 b=gVsPpSwsYFhRC2DlWsochc1nYu0nEnc7+AwWavoEyCwBR2Vdeuqhon/dGSZwRsODREUP1R
 ygtQSlqWIdcetg/YhxuD+cWA9w9/gPbcc3JWJ+8yFp8LpbWyhwxSSXZo6TJUno4il1WEKT
 BXzS7707dP9T+F6HZP5P9+0PeF7gCrw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-MWJoTG4SNw6SXHKAAg9pKw-1; Fri, 30 May 2025 04:03:39 -0400
X-MC-Unique: MWJoTG4SNw6SXHKAAg9pKw-1
X-Mimecast-MFC-AGG-ID: MWJoTG4SNw6SXHKAAg9pKw_1748592218
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad556f5f1a9so131907666b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592218; x=1749197018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTevlSH5ZQkYyW+Mm1Gr4K/vGmq39vmXxviFGBBggFI=;
 b=rHLUR+cBWSLB2nI2yDnW/rN0zZs4CAzA2AyUqYB0JdHwDWvm8Gb/KHJd0YDYWlphZJ
 drkbBn9u+AXW0/aZQHXeTFT3el+WHqvK7bWBrqgV+KDE/Epa5LC1klJd5xpwzYZYkTZZ
 Jy4eprZt50PndWXSg9YEbeDLSDRXmrktv+OgJns0QzELx0MIbzPT1c0ey0YC19VV2iFe
 IJQ88JtKD3Cp085d4o78vfAxyzbHkwhS2ltOydzsKcokv3Biq9/3TpBXy9YuDKBiDJed
 Sgp5ZdzlZT7jRljLpQf8uwP18qvJDQa144Hv64I10bwLkI8etjhhUMCrdZub3N9iNrls
 8m8A==
X-Gm-Message-State: AOJu0YzJS8Xkl1DkfPXVUpCIl2SmxemaT1s7WjLbqfLya2+cknI1vDEA
 2DjuzSs5+y8jQ63iXvmqEdrgXirEtB5Hy+hSuIC3+aWV8AXQvTZmbvuuW1TquOBrWO49E7Zhx42
 PgolxdhFKU6Y/fENmW4rpma7VITFmOSl7zI56zd7Eetmt1gCXuobaD4k6lCjYn9MRQr6OIFQD/R
 ZJXSNmDnVm8CgizA7Xmn6r0Ie/FNK4XD6KGpjyo2Ad
X-Gm-Gg: ASbGncsqzAQy7fF/C0akjsJ+MbG6Dg726TaG7Nr634nqe3kNC6sxpuzc69A4bXnUZYg
 uFPTc0s4nbqaMQTeUCfO/VlvMMdCMVSiCG4aFLx7tB778MUvhcz1v1ZFZ0tddLsglwQeRc3Gmmd
 P/UOcdmroNz2R8HPz+cXLxGhQAMae4luJL8T2wy9LJYSBhRO9iZgKa5S6WNgRuodj9tB5n1uxVi
 TYPah9Kb9LGsuD4TuLPGOGOd2zIGoERnUbdUoGPAe+cVtOIQB0c+Jbk9l9nMBseIK9ll+AmzOGf
 YCbICYq2gRPwyArx2Ya43MuB
X-Received: by 2002:a17:906:c110:b0:ad8:a935:b908 with SMTP id
 a640c23a62f3a-adb322ace09mr198482366b.30.1748592217962; 
 Fri, 30 May 2025 01:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQGKio6NRXHsSIQTnkeXtmtHWiIdsWF3pF0J1K64iq//5rjyAERQNoX6NCZ32Oegrk6NwjPA==
X-Received: by 2002:a17:906:c110:b0:ad8:a935:b908 with SMTP id
 a640c23a62f3a-adb322ace09mr198478966b.30.1748592217461; 
 Fri, 30 May 2025 01:03:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82ccedsm283858666b.48.2025.05.30.01.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 11/14] hpet: return errors from realize if properties are
 incorrect
Date: Fri, 30 May 2025 10:03:03 +0200
Message-ID: <20250530080307.2055502-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not silently adjust num_timers, and fail if intcap is 0.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 9db027cf76f..cb48cc151f1 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -691,8 +691,14 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     int i;
     HPETTimer *timer;
 
+    if (s->num_timers < HPET_MIN_TIMERS || s->num_timers > HPET_MAX_TIMERS) {
+        error_setg(errp, "hpet.num_timers must be between %d and %d",
+                   HPET_MIN_TIMERS, HPET_MAX_TIMERS);
+        return;
+    }
     if (!s->intcap) {
-        warn_report("Hpet's intcap not initialized");
+        error_setg(errp, "hpet.hpet-intcap not initialized");
+        return;
     }
     if (hpet_fw_cfg.count == UINT8_MAX) {
         /* first instance */
@@ -700,7 +706,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
     }
 
     if (hpet_fw_cfg.count == 8) {
-        error_setg(errp, "Only 8 instances of HPET is allowed");
+        error_setg(errp, "Only 8 instances of HPET are allowed");
         return;
     }
 
@@ -710,11 +716,6 @@ static void hpet_realize(DeviceState *dev, Error **errp)
         sysbus_init_irq(sbd, &s->irqs[i]);
     }
 
-    if (s->num_timers < HPET_MIN_TIMERS) {
-        s->num_timers = HPET_MIN_TIMERS;
-    } else if (s->num_timers > HPET_MAX_TIMERS) {
-        s->num_timers = HPET_MAX_TIMERS;
-    }
     for (i = 0; i < HPET_MAX_TIMERS; i++) {
         timer = &s->timer[i];
         timer->qemu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hpet_timer, timer);
-- 
2.49.0


