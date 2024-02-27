Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C791C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexap-0000uD-7a; Tue, 27 Feb 2024 08:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaO-0000ki-Os
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaJ-0002sv-QZ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:32 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so2734232f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040806; x=1709645606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ot/DCCzfEEMRuguhLsrlbJKXVHIQGJaIdaEMWlsQRG0=;
 b=pCudQqdelax8+ox6iak4SBF2V2rVDwKPaTxVXr9RY5xadj/CB6ho0uXE/HDno54h6Y
 JnX6EHnDq/+sAJXex5jfqET8cVs4vHy9bf5cMwy6FMyRpbOwqOpxyh+zn3HDHcuVkCmz
 3Vji4VP1hGWHCC04Pi5drTwFE5c8cqEWkZP775wFMWvD+LPWCIBOlpblr8S83xIG9Ghh
 hG18Bi9JZH+01c8PkdrpcI1nPy7JDkWp8uuF9HJKrkk+nfV4MeenY3pBNclHwZ5C0DKi
 rWInY18FVkOJCPbB4eBwFQrBQOIA6FgHd/SFBdg+HhWIhKCm1fsLQRqtawIS7u0JFj7T
 FI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040806; x=1709645606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot/DCCzfEEMRuguhLsrlbJKXVHIQGJaIdaEMWlsQRG0=;
 b=UKfzFobq2Y5J1Syh1vet1IbP6KjX4o4JIxa9mxvydqgTHtS1NRqp+vAt/CKJUtrngj
 8JfSh2kMWC6LBiXk5sovhGEessLS2qsJhyHLJwdeUc5+J+zTtqy+Wr9Ry5C5u3jHDW5z
 L/R0rNfx4eb6aBS9j5VdhS/WmAg1gMe2JsrAuX/mlT4urd7OcvmkYvo+YtgGoeaKR5DE
 c84p5IvkAcDnIhLrJ9zb9woyzKin0BPr1wRA7u1PInL9i/6e9FmG5k56+73weJADR4lh
 vioNzT+kNacnfroq+SkmTsv8xdaOULVbyyACgptouYtpygceyUGJpI8SeFL8Dvlpjxep
 aEwQ==
X-Gm-Message-State: AOJu0YzvWqXamI0beG2XbSoZm6p3PqxUalbqXNJtqvGLApoSnkuAoH7+
 3YbvFlq5cjo+H40pVd+zlUBHTbjQjK+LsMER2g5xSG6zjNCVpyFc7yHg9jHTaf/msIR9w6xfMMh
 X
X-Google-Smtp-Source: AGHT+IEzsIWI8ODRFarcZQyXVZ3d1KD4ZTu5j5n0Qm9sxbP9uixV9oj2ZT1fUYRtpX4e63iEGVyEKQ==
X-Received: by 2002:adf:d1ca:0:b0:33d:f46f:6384 with SMTP id
 b10-20020adfd1ca000000b0033df46f6384mr994495wrd.23.1709040806229; 
 Tue, 27 Feb 2024 05:33:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/45] hw/core/machine: Use qemu_register_resettable for sysbus
 reset
Date: Tue, 27 Feb 2024 13:32:48 +0000
Message-Id: <20240227133314.1721857-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Move the reset of the sysbus (and thus all devices and buses anywhere
on the qbus tree) from qemu_register_reset() to qemu_register_resettable().

This is a behaviour change: because qemu_register_resettable() is
aware of three-phase reset, this now means that:
 * 'enter' phase reset methods of devices and buses are called
   before any legacy reset callbacks registered with qemu_register_reset()
 * 'exit' phase reset methods of devices and buses are called
   after any legacy qemu_register_reset() callbacks

Put another way, a qemu_register_reset() callback is now correctly
ordered in the 'hold' phase along with any other 'hold' phase methods.

The motivation for doing this is that we will now be able to resolve
some reset-ordering issues using the three-phase mechanism, because
the 'exit' phase is always after the 'hold' phase, even when the
'hold' phase function was registered with qemu_register_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240220160622.114437-10-peter.maydell@linaro.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4c..9ac5d5389a6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1577,14 +1577,13 @@ void qdev_machine_creation_done(void)
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     /*
-     * TODO: If we had a main 'reset container' that the whole system
-     * lived in, we could reset that using the multi-phase reset
-     * APIs. For the moment, we just reset the sysbus, which will cause
+     * This is where we arrange for the sysbus to be reset when the
+     * whole simulation is reset. In turn, resetting the sysbus will cause
      * all devices hanging off it (and all their child buses, recursively)
      * to be reset. Note that this will *not* reset any Device objects
      * which are not attached to some part of the qbus tree!
      */
-    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
+    qemu_register_resettable(OBJECT(sysbus_get_default()));
 
     notifier_list_notify(&machine_init_done_notifiers, NULL);
 
-- 
2.34.1


