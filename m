Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B938BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCI-0006Tx-R0; Sun, 14 Jun 2026 15:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCB-000661-Q1
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC9-0002IC-V8
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUPJ12Es9QnfxKUKTquG6Gjp9/vUPl/q9LFmvTsYL0M=;
 b=gXv6u128TH7ZGWRDtjTw3CVCknlhi34t33VIzV2nPjvqUQDHxTerly0XR4hPLMYQsISaUz
 iSCtNEiV/vucSKMVAfpDpc2Zld+Blq6+rNa8ANqODDmYw53xrZRpMveRZ20vOZhceLCNGi
 PUD4Zo1fUXrnMe8S8/hOJjbM7nm80js=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-9sEXxhQrNC2Oc6QMEORX3w-1; Sun, 14 Jun 2026 15:08:31 -0400
X-MC-Unique: 9sEXxhQrNC2Oc6QMEORX3w-1
X-Mimecast-MFC-AGG-ID: 9sEXxhQrNC2Oc6QMEORX3w_1781464111
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490ae016853so16990885e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464111; x=1782068911; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KUPJ12Es9QnfxKUKTquG6Gjp9/vUPl/q9LFmvTsYL0M=;
 b=VaEt0zwvLJhzPzr304HKj+1wRf5dAtXhDgJgYHf4gBlIWkB8wDhI7XVtH6WgGpifTA
 qIX9fZzaWcrWQ4LbB9UzaEhuFXuKtV0kCK1PxiBLiNJq4dxgapI7l6YWCpepiZCWUmxO
 NgW+Z4wnASgSrzKL3l0khNaOBNdDHHN3+R8Kf3OGMSKaQMTJlVKwHBe1fVZDNszcKDqm
 pB6eQmLzBOwiaGYrA8Eo1w9i1ZrLh18h4asaFrj90gA1iHcbseapAKM28vT0zJkdrDsZ
 mqnVEhMLh/nHkVgQ5SVeH/KIOdXDRVYZqUDz5NWLxGMiYT8IAOhJ5Gs0SgdxtJuSJwo4
 +2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464111; x=1782068911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUPJ12Es9QnfxKUKTquG6Gjp9/vUPl/q9LFmvTsYL0M=;
 b=qXOG8MjZq+Zjehsmv7r9I2EazOvCO3XZFzFVMDal3Bu0hLUBSLMFZmPCf3juri1zeI
 /28phl7MbZXaG5XNESdz084IGnB+YPbY/QqLWnKN9ByxLBUJhWm3rXov4eUn75EW/wm6
 if4UmboRp2UCLo5ALbVkgPLcldlTKZMETdYRsav4ZCCob9unJ4QFTkTySGbMtHFPnw/H
 RWoNqWvdk96ufaTfb0qNdDU5onXsK3rq39tdjGYNlKOcTIlYhPTPhJLB7iugus11el5b
 VG18PJkPiJ4tinlasnQDfio0UrKn8jELspg5kJL5d4N9gDtBiumK58ot69YMdQgqK+oT
 CQGg==
X-Gm-Message-State: AOJu0Yyi/c0ql62Hhyt/1SuASx8UGx1NjCCVtld9zJ0bK0omzI4Vgt9h
 Oc7Oo7ueIZnoNPweqD5QLB9KbRV9Cvqc3MaMu8kW1mSQGMWgCIcvL+tUDbrjUwPdzbXujJSf20J
 b0T1rHC2D4dCk6nKyoXb4Migduh3955T/JzhznrQyEaVIsshRQkdlbdNtJmHUgvGDugTpwqCKzX
 5NrZeULL+eoKQUPYKcWIHaV05ZxR8AlV1DXQ==
X-Gm-Gg: Acq92OHKvkVu5OjAobQQVLS6lH3TUr4DmXNrjEpAxhjx9+9WMPhcr7nR5ECEa+3M7LR
 ooo/74iuhSuOXTWksVKDP7rPVLvPLi7gw9sQFSc0HocEefTsPGnyzEYS157hBbXSfjk+HVB1H6K
 N8a2FqoYNbaTcsf79+X6r+EuLpbqE/tlHVf/VzLIVekq5FDVfXfgJsRqmYuP1OGUCggaPaPEiNC
 TuVAnJ6si83SyKjctN7n+edDi9j3+UCGeDpqHkKPqdAF3S+bHHdlyAWW77qLZmUTqgDjtDy0g0v
 YQMCLg0y9IZb98XyArKWOM3io8VA6/WhrqMsMgERyI5Ls/kOR/bMJn67Ua/k1bUEVESgnkSNvjh
 VpqZnkObcFWMP2SgbRN448H3W+dWTWrn9V3DCpBdN6YM=
X-Received: by 2002:a05:600c:c8a:b0:490:cc1b:15c7 with SMTP id
 5b1f17b1804b1-490ec52114fmr138425185e9.30.1781464110650; 
 Sun, 14 Jun 2026 12:08:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:490:cc1b:15c7 with SMTP id
 5b1f17b1804b1-490ec52114fmr138424815e9.30.1781464109973; 
 Sun, 14 Jun 2026 12:08:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033dd59sm176900185e9.9.2026.06.14.12.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:28 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Sairaj Kodilkar <sarunkod@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 064/106] amd_iommu: Reject non-decreasing NextLevel in
 fetch_pte()
Message-ID: <291aa70ad254b6c48012dbfd16a4af0978ea1b84.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The AMD-Vi specification requires that the NextLevel field for a page table
entry must not be greater or equal to the current page table entry level.
Enforce this to avoid infinite page walk loops on corrupted or buggy guest
page tables.

The initial implementation of fetch_pte() did not implement this check, but
was not vulnerable since the page walk code explicitly decremented the level
instead of retrieving it from the page table entry.

Cc: qemu-stable@nongnu.org
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260330212817.992673-3-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index bc083d0073..99b05b2ab6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -771,6 +771,10 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
             break;
         }
 
+        /* Next level must always be less than current level */
+        if (pt_level <= next_pt_level) {
+            return -AMDVI_FR_PT_ENTRY_INV;
+        }
         pt_level = next_pt_level;
 
         /*
-- 
MST


