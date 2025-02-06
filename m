Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6571C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 12:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0lo-0003Vd-7x; Thu, 06 Feb 2025 07:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0li-0003To-I0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:06 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tg0lf-0004UN-Lh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 07:14:06 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dca451f922so1913654a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738844039; x=1739448839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwppSC9bUdiVJfImWyhfu8oDCEOSZwe3dQfmc79YoG8=;
 b=Le0IwoB2u7+F9A/1sdCTbwRQPiURpdFa2xC9Qci92RBn0PqfaZfsFygZayOxE/JciC
 VBFrWG3PP1FoPDpeyIaQpOmB8IKjrdNZZ08cto1ow1ehhvHhWzxOuxV2BgR0/nPfCVx2
 nQxLTxe6OpPizoNnfQ1JgGyaNGHP/Ulxh00xdf9MGm8eeo/BLuO2tCt47R8jX8izoWy8
 joULQCZH3VW4T6n57Md3sKR+ctTXqJNy7trkB4TvwYzMYZREmd9x5Yv+IsckKSPTzRh4
 NjRLuPwKdFLCChkW/oI07FOPYvbJRtCjlf9S+1E9eTYJ4AdNjiBpgprGCRPRW7FfJVNc
 +yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738844039; x=1739448839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwppSC9bUdiVJfImWyhfu8oDCEOSZwe3dQfmc79YoG8=;
 b=BY5geyWo1K9jjm3nF5dJCESj+PYCAfXPheBqt5FtbgtJZd4R6+Unec3sCyv7OVllGx
 x3suBnb8RShOC5iZNYx31BQN616ghHHinl2U1QIiaQ2h1byJlryOX65JZ2w8oqbNCPEq
 8fApwftnfqU32TE+j2mB+dWK2r3tyCB/Zx4q38GrNL1UNdoETXV1sfpN9777v6OK9ibJ
 s09VAsy+DxL0K2OFJAdCwBSVLPm8vRcJXSviUKHaf98GUlgYBLVGk4qltYfCEsxjJ182
 HZx2yc8aRtPkQK8a5rC0i4kRZPH2T+F6q2EkQjaj+iEWa0SSR52XMm87JfiN5hrRi1Xb
 xlMA==
X-Gm-Message-State: AOJu0YxqSTS0o57Ms6YbDHBeX9nl74bNzCMiDSCvRl5d6wcZ8rNnbDVC
 19oBbVUwDJHEK1Z9N/kYPVXEs84IszSeJD21LYxAxrOf7svP1Se95hPkcFL/Dwk=
X-Gm-Gg: ASbGncvyjQoobEPJrNhDDCmwaovZwtslucuEn8DrpRuYWDJoFchHzyde8XKvFMRr55A
 kCqqYY6S7PzQ+ymJH9oHx3R8dI6B6uwXBx4wbo+q/1W9rrJhlONkRyr5szsQHikkX6ACmZjGdzf
 W3ppMSiiNIOdzDagv93ATOKG6qlLnEn+j3tNOlqxIY6Z95NjoGOAsvtQU4dPRz1/SaqnQ1boSpE
 9p6QlCs0p1IY9BikKcPX8NnYbogLvGedAS/E1h/H+P0dMLUY8EJUwSw8D1xP9BzbaOoBG52Plul
 /UGcrq+k5vIBueG+y72/tP84b2/+bZBHse6GxAKe6cI=
X-Google-Smtp-Source: AGHT+IG4qHO+Aai17fvD6xzyZwPuKm9DZKZRKsOwUrSPhKuE9zeqJYtKUREaOGqArqtkLJ18iHLkSw==
X-Received: by 2002:a05:6402:540b:b0:5dc:cf9b:b033 with SMTP id
 4fb4d7f45d1cf-5dcdb7001d3mr7517360a12.5.1738844038847; 
 Thu, 06 Feb 2025 04:13:58 -0800 (PST)
Received: from corvink-nb.tail0f5ff.ts.net ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7ade9sm772388a12.25.2025.02.06.04.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 04:13:58 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 4/4] vfio/igd: sync GPU generation with i915 kernel driver
Date: Thu,  6 Feb 2025 13:13:40 +0100
Message-ID: <20250206121341.118337-5-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206121341.118337-1-corvin.koehne@gmail.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Corvin Köhne <c.koehne@beckhoff.com>

We're currently missing some GPU IDs already supported by the i915
kernel driver. Additionally, we've treated IvyBridge as gen 6 in the
past. According to i915 it's gen 7 [1]. It shouldn't cause any issues
yet because we treat gen 6 and gen 7 the same way. Nevertheless, we
should use the correct generation to avoid any confusion.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/i915_pci.c?h=v6.13#n330

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e5d7006ce2..7bbf018efc 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -64,7 +64,7 @@ struct igd_device {
 
 static const struct igd_device igd_devices[] = {
     INTEL_SNB_IDS(IGD_DEVICE, 6),
-    INTEL_IVB_IDS(IGD_DEVICE, 6),
+    INTEL_IVB_IDS(IGD_DEVICE, 7),
     INTEL_HSW_IDS(IGD_DEVICE, 7),
     INTEL_VLV_IDS(IGD_DEVICE, 7),
     INTEL_BDW_IDS(IGD_DEVICE, 8),
@@ -73,8 +73,10 @@ static const struct igd_device igd_devices[] = {
     INTEL_BXT_IDS(IGD_DEVICE, 9),
     INTEL_KBL_IDS(IGD_DEVICE, 9),
     INTEL_CFL_IDS(IGD_DEVICE, 9),
+    INTEL_WHL_IDS(IGD_DEVICE, 9),
     INTEL_CML_IDS(IGD_DEVICE, 9),
     INTEL_GLK_IDS(IGD_DEVICE, 9),
+    INTEL_CNL_IDS(IGD_DEVICE, 9),
     INTEL_ICL_IDS(IGD_DEVICE, 11),
     INTEL_EHL_IDS(IGD_DEVICE, 11),
     INTEL_JSL_IDS(IGD_DEVICE, 11),
@@ -86,6 +88,8 @@ static const struct igd_device igd_devices[] = {
     INTEL_RPLS_IDS(IGD_DEVICE, 12),
     INTEL_RPLU_IDS(IGD_DEVICE, 12),
     INTEL_RPLP_IDS(IGD_DEVICE, 12),
+    INTEL_ARL_IDS(IGD_DEVICE, 12),
+    INTEL_MTL_IDS(IGD_DEVICE, 12),
 };
 
 /*
-- 
2.48.1


