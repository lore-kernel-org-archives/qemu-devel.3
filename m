Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD679C7EE2E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSene-0006TZ-OA; Fri, 20 Jun 2025 12:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenc-0006TA-8g
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSena-0000Dy-Oy
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6qBhhYU0EtvM14oRBz0nwskdUiQCwK4GxAn5RYA6Xc=;
 b=eRzEHIif0aHESKd9b+ubv2ufFG8hY+bf1OjZ3rmSt4OtfuyhLT6e8EB3FOZElt9Nq+6cN2
 H73i8LHxL8F31Ijiv2OYPn6Gc12ksJsrTHUAgnECapSJqdKkiwRayKJGZyTCQYjzY3MdUw
 oHVS3Su2CvdqUCzX3sftFDc888/6sac=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-oeak_Qi_M6awbnF6VFp45g-1; Fri, 20 Jun 2025 12:41:04 -0400
X-MC-Unique: oeak_Qi_M6awbnF6VFp45g-1
X-Mimecast-MFC-AGG-ID: oeak_Qi_M6awbnF6VFp45g_1750437663
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6077833ae13so1591880a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437662; x=1751042462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6qBhhYU0EtvM14oRBz0nwskdUiQCwK4GxAn5RYA6Xc=;
 b=Alv+gTg2cMxP4KHEe1CPNZT29YLYsCUds2pvKCejRLolFSsK4g0szxm4tqkkBEnbgA
 7sM9i9hHIMkLZV/aT+B+OGueRRywua/ru2u8f0+NHabQXaHX+Dl7Le/ma/oXxe2oXBpZ
 4p8gOV4WD0fyTBHaDBJkq8yuSdsIBwJXmDDEGkXZxKvHpAVrmdwWORkkhfEKGreZseR7
 QX0zOUh6QNNlLiIni16Uu1VF9xqnL8BlTtRUttRKfsgKQLwSwq4BlGHzPlHshUaG8iKx
 PrDcdH6WkSl3t2hoghEgKPGiEz980FPFJ/aMasiKmlIAxf+JQjRuEB1NUkO5HY52ElCl
 LZ/A==
X-Gm-Message-State: AOJu0YwYOsqtQp0oMhuf11VZeMJYRu4HEvAyXT0KJY5dS2rLcgM6jF7Z
 Na2T31Q23tOXdzpEFLVircK9s61AH1Ilk4fk7AqbV0iRvsCjv6SKawhUyCAKInpwz6FOIeO2AEz
 tMVTmhGAbMVrooW1kJNRY+sA3ey2m55s8sh4W236lNU5q/eT4jtHa16SfSw0WTXM4pFCNi3WAxj
 +5qn+KzdHJzWcT484mAKKroLvihNJwSTrv0YAuVNzH
X-Gm-Gg: ASbGnctffjGsf3gX4zVPkB7GvEX7/IFreTe8jBH7YKo/QV1SNiWk3xRx/jNdpduA61W
 AwviEFRaBse6e0KemRkQBg+gnxX/rvmFWNpiikC0Ruh26hHLwU0GxmiAkazTKs3GK8clGm/Flwp
 1eQGBhLPpp54wCTwF/qgzWhrIl0vnH4gs0hWlpIqqjUSVwQtRqkEW6r+5v5c6kO56nHCHuD/wct
 RautvTT9hgXkTy4ey1REnRyie3HFrqcuBWopZMaoZJbR9QZajXLxiACM7fEtWuR3Czg7rFRNtXT
 rzkqaz2yvLgXDplyiwzgX4tQDg==
X-Received: by 2002:a05:6402:274a:b0:601:8481:3268 with SMTP id
 4fb4d7f45d1cf-60a1d183e66mr3202880a12.25.1750437662388; 
 Fri, 20 Jun 2025 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpaNZzFQOOIniltBH0eOpP8fFnwWWWY+FRCIdjsyzWy3dlm1XcaFI2dWTaaf0+xJrzepMfUQ==
X-Received: by 2002:a05:6402:274a:b0:601:8481:3268 with SMTP id
 4fb4d7f45d1cf-60a1d183e66mr3202863a12.25.1750437661989; 
 Fri, 20 Jun 2025 09:41:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a18d0186fsm1626737a12.72.2025.06.20.09.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 03/24] hw: Fix type constant for DTB files
Date: Fri, 20 Jun 2025 18:40:31 +0200
Message-ID: <20250620164053.579416-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Commit fcb1ad456c58 ("system/datadir: Add new type constant for DTB files")
introduced a new type constant for DTB files and converted the boards with
bundled device trees to use it. Convert the other boards for consistency.

Fixes: fcb1ad456c58 ("system/datadir: Add new type constant for DTB files")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20250610204131.2862-2-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/boot.c | 2 +-
 hw/ppc/e500.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 79afb51b8a5..64040504a1e 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -527,7 +527,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
 
     if (binfo->dtb_filename) {
         char *filename;
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, binfo->dtb_filename);
+        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
             fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
             goto fail;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 6899802bedd..723c97fad2e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -408,7 +408,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
 
     if (dtb_file) {
         char *filename;
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_file);
+        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, dtb_file);
         if (!filename) {
             goto out;
         }
-- 
2.49.0


