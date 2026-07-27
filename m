Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDDBC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsm-0000uT-6D; Mon, 27 Jul 2026 15:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsM-0000a9-Vo
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsL-0000e4-9K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTP2mrPTOCEv1S2HwfgF4Ye14Bhz50OTeDYQ5YoPY/s=;
 b=DgwFVG7Mc1yM0bGVbb2zV5hGNiay4r+mZKeYZZLj1b1eiwVMCPFwvbwJ+uwINTvPmPUeKM
 SCjJjZfzits5PMRNvPVdu7OhdNjmG2Lzpq0xiO/dlyzTTyrSkFG6N3aYuBA6m5BsXGfyxR
 RBg7nbMneqbG09yRGkbcJza8RqG9CeU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kHCRPHpjNwuKKHMccX49Xg-1; Mon, 27 Jul 2026 15:20:29 -0400
X-MC-Unique: kHCRPHpjNwuKKHMccX49Xg-1
X-Mimecast-MFC-AGG-ID: kHCRPHpjNwuKKHMccX49Xg_1785180028
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955d314945so21666595e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180028; x=1785784828; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xTP2mrPTOCEv1S2HwfgF4Ye14Bhz50OTeDYQ5YoPY/s=;
 b=jDbVnvgidRO9a3FoGTtygOBvo7CFpII+4N13eMbxyi+YBc7RIcsf5cJY66Z2Ps+4oR
 Jgo5d6UM2JsOUtAuxfQHdlB/ZwjBV3Yu9UQRJjz9kumZ48v0OszUBBY3njJgHhX09I2x
 zEmb2wugU37Wjn1ZK/zZtWS1hZwHHpjqFGKJ0bPS9+V2BmTTDK4qt9QUWjB4eBoYgqis
 S6K+cKIktIR0NA1lTOMFZl1uGkqRcfZIDplLhL3OTLXyAMufrcsIwTDRtd7tQyhEJBy3
 F3v1UcAlG8h9+fcAe5/6ysqk7ARy7WpEBxqIcEtZ6Bc2Mdb7h0Lg6nv8wvh5eu94nGZt
 5lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180028; x=1785784828;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xTP2mrPTOCEv1S2HwfgF4Ye14Bhz50OTeDYQ5YoPY/s=;
 b=NOESRYASsI+LhPvXJY8472bokEZ/dQvGSSU9CrBMlrmKBJURHkCxKqtFdvnpzpld7P
 0xfzLDZhSbSyMHb9schBNzF2lPlJP498cHnD7gVsNc1OEIEgLj1ZBrz9XDuHZr/j5+6E
 YnwOjPV/e4lUWNcnp6rzmmAEK3X1YtSRYdgSEninmJ1Az94KYUeAJxJf/vKcXWMPrkb9
 1SB/bDAKmaGAT/N2ImqzKDB3Q9MslBUsFTWH1jFYH6eEL4Rvp0XY+VswaikpOWcebRTp
 /e/p+xiF7XGN95aS1f/1SMYG7sZjtpbZdnW+T/+JwUO3RnI8ENpb8Z19XtLXaWh3wcps
 UdXQ==
X-Gm-Message-State: AOJu0YxxnKxDA55YituwAeMy9xkzgUD4OmDqJEt5/AgkZHfeCUjlDyOF
 WdHdMrHM7xF/2tc8rBV5lBT11tc4BoNqaY0jNWyRkgAEdOVB5dCMIkyJZEr65J2XGxaeNmH4BM5
 HmP7TgLzkvWXoFVKM7VLQE5KO4AnFAvGfhTz2iWMY2wdhrFNC8ci2wSOCuK0ls8fIvO+p2GbIf4
 UY/BJsWZfmRZFTQrtoHN7bUnOiaILQbDSNow==
X-Gm-Gg: AR+sD11nz8flfFo6ZyOuICf5a/jUfYFCeAIfVmC1eZmbhYsq6AYuzHxtiQMydwegkXY
 7kUYCmmrvSFK3uRuFJf8InseT8eF3DQkfiKKKSHE8FmhmuibfJQMiodAJV4OaEkAZ5mDVzMuegH
 1T2RxIUaD0ld92x/dRb0UCQfkaJMugA0yaCXCHi4XOas2Fi6zMohHPbS2f2Zm2CGCKu/7FYikNN
 +CCmQEUqMBOdzewa6XTrXvS4TBAPRdC+HICjYKGwN4fxI/Ic7nOq9TNk24rfqyUvK0Y4n8bq5ZV
 r9C7XlMKOYvqyCP5i1FxuRLOYUnig6HB6Esr1sZXHb5dAHvF2ShuVKM4DKCbHy+5RNASMZfl09C
 vTK+WeUVECcIC4e22lcc//w==
X-Received: by 2002:a05:600c:1d1b:b0:495:6f6b:fb75 with SMTP id
 5b1f17b1804b1-496b57678e5mr141548675e9.38.1785180028056; 
 Mon, 27 Jul 2026 12:20:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1b:b0:495:6f6b:fb75 with SMTP id
 5b1f17b1804b1-496b57678e5mr141548305e9.38.1785180027528; 
 Mon, 27 Jul 2026 12:20:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm17051265e9.2.2026.07.27.12.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:27 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL v2 23/30] hw/pci-host/q35.c: Avoid early return in
 mch_write_config()
Message-ID: <e07c67584c69da44a4d52df747a6fff1f411500d.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In mch_write_config() we return early if has_smm_ranges is false.
This is slightly bug-prone because it leaves the door open to somebody
later adding non-SMM-specific code at the bottom of the function.

This case isn't as bad as the one in realize, because the function is
a lot shorter.  But putting the handling of the three SMM specific
ranges into an if() rather than having an early return seems better.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-4-peter.maydell@linaro.org>
---
 hw/pci-host/q35.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e42b84b978..f4556ad03a 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -485,22 +485,20 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
+    if (mch->has_smm_ranges) {
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
+                           MCH_HOST_BRIDGE_SMRAM_SIZE)) {
+            mch_update_smram(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
-                       MCH_HOST_BRIDGE_SMRAM_SIZE)) {
-        mch_update_smram(mch);
-    }
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                           MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
+            mch_update_ext_tseg_mbytes(mch);
+        }
 
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                       MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
-        mch_update_ext_tseg_mbytes(mch);
-    }
-
-    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
-        mch_update_smbase_smram(mch);
+        if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
+            mch_update_smbase_smram(mch);
+        }
     }
 }
 
-- 
MST


