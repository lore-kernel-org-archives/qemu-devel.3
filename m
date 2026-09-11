Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81853C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAu-0005mq-LV; Fri, 11 Sep 2026 05:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAL-0004Jj-B2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAH-0008IN-0R
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xO9Jj7yHXJpXhsIddL9LHeTxBWYycN9Rwv/iB+IGEU=;
 b=IsKiX4sQwz7hA0kVHtA5y07S4V/PFDhp3NSDxhp/BzvbpYu3j5T7bgv5GO3cIezLIN4S+Q
 W7SixhH2eBWDonwU7zm/VJfhN0Prr7ZMgCJr6jDDqC12mEUfuJBPfer0yi2Dh+jZSUZqLQ
 6HqRqUyMElc5700viIHJUmjC+0uBMKk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ndqtfExFNKiVrNOKUf7uPA-1; Fri, 11 Sep 2026 05:03:19 -0400
X-MC-Unique: ndqtfExFNKiVrNOKUf7uPA-1
X-Mimecast-MFC-AGG-ID: ndqtfExFNKiVrNOKUf7uPA_1789117398
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4957287363bso4192205e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117398; x=1789722198; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4xO9Jj7yHXJpXhsIddL9LHeTxBWYycN9Rwv/iB+IGEU=;
 b=JE6Z4oBYed1n4UjeeLzWZKfq5rMuF3+SQ7Cj0bLjGfAjwo4VrTJGGc5jXCadWuWi9I
 TbKJ8uGM7DbRzr/n9twCVqB+F2xCh2/lDkQjTNl+5ef/c0rKchWyq/l6L+FNEet19ezb
 tOqWm16CZzH0IqXawDcZW8d4Lbr5p5nLbL6O4Xfyv6CQZSDNXCtnSJHUq7XKFnRkNXD2
 UE2UhBNZwFDFJUJuw/Z0xid+iWN+TwAO2j+5lyRdGrry7ZZToR8MVJNyCzR+ZOm+68Wm
 Y5M7CjLFuVC/48VioorVe2QU0UkwuYK+e8PAk4cVc+AOUKMvAfncgCc5fFTz4dO60a3V
 PkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117398; x=1789722198;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4xO9Jj7yHXJpXhsIddL9LHeTxBWYycN9Rwv/iB+IGEU=;
 b=sDuSAhDvxoItlJxk4m2Gw8NeThAhCxPe6HeUOdK/M+PRus+lj4h4pcKDoTeapb2N3G
 u1xUDXUAvT8aVWzqq8fAfv2GAFmOr8RYWmBW814Fvc4dIzcWdEXcFmAiW342ZUwmJdTD
 o60p3g5DLYSE4PVNY9popfmA4tmcSm+2EXawgC8ezRSX32EX3JBPgMj/j9Lj9gtzdxaP
 sZXi37pnrk4qkyObc9QzLbNtNy4qEhP8/42kIRr/BwubLIhRSsekDQamC+T7WnQXa/yn
 98ipg6JmDadX5E5IRxCt2kY5FZXFWa89Me81JiroJT05XwsIWv1b1Ql9a2H38ZVHVLMf
 r9wg==
X-Gm-Message-State: AFuF++m4gki1lPQgxlPExc8WnazyyImicpu04RFsh9J15D/DYqExQwqW
 Y/FJCHRqN9+iUDa3j9yvaAFPsr+b9VoRVVgokaekbYj8E+/JrJDCutTDfJmJQ0zfN29Qc+NTWfo
 BVIKJHRwi3n/HUzYItMssTJ5Xpo3d+bHY4UFqz9mUcrdgfzY3z+qBntGeFUVQJ1bzuK3GLLrx0w
 jkPYH4I2B16Hvk1Z8hsoGGx+A50y0qIWGZuw==
X-Gm-Gg: AYBFou0dzr+pK6wY5ooHWUtXIsAQGLH6VY0z4bM3/SAs+/Dzt8nrxzxVZTGj2ZN+NbT
 sQoWUuel3BuHX94yIIstq9mxN11cemOJ6ul/i8nRplb4QPjRNHBvcnerjJBsaGT+ptLJuF9ngPX
 blrdwss/3XogSdOyN6r13PPAuKzSWeFAAqAW7k6bD12hsr+KRnwk0iv82u/a6hajB8nEUYiI0BL
 dP35MDkfYlN/b1GKId7NPwQ+CdiLyZ5INqy7YP3yZg1eZPKoNrrxVmrNLWOYkbPjbFKjoecSPQA
 a5D7QAKcsdGJCF4oC4Br38ey3GBzvb65hoRw3KDREXv1nr21w5P1jEyHihzhFErqL/zpQBDAXEV
 gwfsN4GlibJhyEfff4hpIlSY=
X-Received: by 2002:a05:600d:8496:20b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49e6199234amr23189565e9.14.1789117397583; 
 Fri, 11 Sep 2026 02:03:17 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:20b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49e6199234amr23188735e9.14.1789117396753; 
 Fri, 11 Sep 2026 02:03:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm239150075e9.6.2026.09.11.02.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:16 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: [PULL v2 49/75] amd_iommu: acpi-build: Remove unsupported PPR and HE
 feature
Message-ID: <95d03f5268980e31042d8d0b7e595c66e286f1d8.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

AMD IOMMU does not support ppr and hardware error registers. Hence do not
publish these features to guest through extended feature MMIO register
and IVHD 10h flags field.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-7-sarunkod@amd.com>
---
 hw/i386/amd_iommu.h  | 5 ++---
 hw/i386/acpi-build.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 319db18618..c5b346cc35 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -227,9 +227,8 @@
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
-        AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
-        AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
+        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | \
+         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7bf3858b63..6d7308b4e4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1938,8 +1938,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* HtTunEn      */
                              (1UL << 4) | /* iotblSup     */
-                             (1UL << 6) | /* PrefSup      */
-                             (1UL << 7),  /* PPRSup       */
+                             (1UL << 6),  /* PrefSup      */
                              1);
 
     /* IVHD length */
-- 
MST


