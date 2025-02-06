Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB55C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg7sN-000444-UH; Thu, 06 Feb 2025 14:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tg7sL-00043e-3M; Thu, 06 Feb 2025 14:49:25 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tg7sJ-0005eI-Nr; Thu, 06 Feb 2025 14:49:24 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4ba7787f128so269790137.1; 
 Thu, 06 Feb 2025 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738871361; x=1739476161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFQm2ZHwyxo8JuKx8Z7FDry0rxBkb9nMIXnYNGZwf9o=;
 b=SUJlM6Vb14+m083sabWIxXkdU7wKV9WMw1W1V7Vecyu9WCKgmhwDhekxbHjiKlHgoz
 z6vW8U17DSAB29LruaJ96DhZxZ/+C3vhaEQKVw6PcjdlIFfmL/d9UsIJrYsAMAIuKIRS
 FjbUdIfMeMLMDUHd0en5taW1teGG+Cuoq2yVG8DLoU/G45chRyLGJQb3aLmvZ0fiCxma
 ob+aNSwDX29HoQDISw3YWux95HPlTN+AfREoQayOeE8jG0Stt+57McOSoARV+7WxlipQ
 UcnIE0jHWFbYQSEaqEe7MQ4sOkcwB9pAr76Li911gfR7U33Z4eBbZUHHLv8gN5oFcbC3
 QM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871361; x=1739476161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFQm2ZHwyxo8JuKx8Z7FDry0rxBkb9nMIXnYNGZwf9o=;
 b=gmBoZTct6odqyeG4L/Kkf48oJQ44Cfv2hwFU5A2nrhyP3Pwsijx0jdxeAIQoSKB0Ec
 zsAEjxtH4rLPL53uqYsRUQi9cVgSzx07udtDJQ6dPyKPDu35AgUUNW5qLdcmNfabG2l/
 oMYISv8uouLwrDTlC1tW3P4o99qVBYXzQMTP6lYkvpPu0/PTE8Dhx9gW7uJdOjMRbCou
 b1wOOkPaFmOhiY616ZSysW846G6mqzmtFl20SfyYD/DVN5nA+EGtcosVqreOk9Ud72i2
 CU3dTaAdDWP7eTpaZyOmz8ltzvx6mqPwilGi4J91aLSQm/NqLT515QZNVDehEII1Px9r
 cYYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW19CwbcO8IKTiLKH0ZyWvBw+81ioC0Hhtou0fejdLndwgC2wOy5gi2V+upvDaqi5FcR6bKJQkWprOrbg==@nongnu.org
X-Gm-Message-State: AOJu0YwJjpSz+Y4KDiLs63jz8sUNwk/7uagchOsirQZRlQ2//wvynu3P
 f3/nsFQupivE1W+PLoI+qRX3OrGp4s1NOeThDs6j8XBYBJOrOtRkJD2V1lqL
X-Gm-Gg: ASbGncv6M6Gpk+cZJXMmM8buBm6oY849yYyxwXzsC1/tYZVibVBb5u9zd1QkMIiGBBj
 XyPqaKe3jREZjWxam7c2c8szYU1IpEEH/m1DwR72Mj4x5J2MAVcfyko7UJCWc6RHH8hJtFp7iaf
 pqeAwP5FpEUtjnVRK//lnGRT/EmRrGlDLyCfpH42xAzNwie5gHcUAKQdz/32AuP6qb8ecOVxaox
 vlSfareVwBJWpKiRjoaFEphNLeX9qcDvp8nTTLYx+Yc4WhQIvD1FuhxaTkLLKErmnRmyc3fagTm
 KvPawsjaS+0sIHzbMEMz+T802mEYhpZ6nT1baQ+IEY+ughNzOfpRJx0n7xy3cA==
X-Google-Smtp-Source: AGHT+IHV88cKMntCdzuDGpUdmPinFfIc/Ky9C7BHZqj5IxcpPHEM7cX9qegjV0hcK9kFR/d78G+5AA==
X-Received: by 2002:a05:6102:94e:b0:4af:f3bd:51cd with SMTP id
 ada2fe7eead31-4ba85eeccfbmr429451137.16.1738871361324; 
 Thu, 06 Feb 2025 11:49:21 -0800 (PST)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-866f97d8c6asm294265241.21.2025.02.06.11.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:49:20 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 olaf@aepfle.de, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: [PATCH v1 1/1] xen: No need to flush the mapcache for grants
Date: Thu,  6 Feb 2025 20:49:15 +0100
Message-ID: <20250206194915.3357743-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206194915.3357743-1-edgar.iglesias@gmail.com>
References: <20250206194915.3357743-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe32.google.com
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

On IOREQ_TYPE_INVALIDATE we need to invalidate the mapcache for regular
mappings. Since recently we started reusing the mapcache also to keep
track of grants mappings. However, there is no need to remove grant
mappings on IOREQ_TYPE_INVALIDATE requests, we shouldn't do that. So
remove the function call.

Fixes: 9ecdd4bf08 (xen: mapcache: Add support for grant mappings)
Cc: qemu-stable@nongnu.org
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 00bfbcc6fb..698b5c53ed 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -700,7 +700,6 @@ void xen_invalidate_map_cache(void)
     bdrv_drain_all();
 
     xen_invalidate_map_cache_single(mapcache);
-    xen_invalidate_map_cache_single(mapcache_grants);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
-- 
2.43.0


