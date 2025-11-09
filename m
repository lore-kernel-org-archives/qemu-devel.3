Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900D1CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vu-0002C8-2P; Sun, 09 Nov 2025 09:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vs-0002Au-8H
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vq-0001nM-Pw
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwqTfvgEpRHDMwJR5147QuaByS8jiQ7jRhJSWfgblyQ=;
 b=KC8v33fEljvoHRzYnl8sR7/3kIItCFvxWkJNsSOd+0bInNYbNPkpgCb5VRE6oO5t5qnju0
 6d0R/tv4A/WnoYiPcBI1TI0BZhpOcwQKNC2FTtqFGoNA8l2LugogPZr7z8MlCt8yS1Yxya
 jpfu42ixrl+i8JvNLlnCR5R7arsuJCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-HkOEZI1sOnOc7KxgFu8MMQ-1; Sun, 09 Nov 2025 09:35:24 -0500
X-MC-Unique: HkOEZI1sOnOc7KxgFu8MMQ-1
X-Mimecast-MFC-AGG-ID: HkOEZI1sOnOc7KxgFu8MMQ_1762698924
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429cbed2b8fso1057364f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698923; x=1763303723; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SwqTfvgEpRHDMwJR5147QuaByS8jiQ7jRhJSWfgblyQ=;
 b=ZCz4m2SdAhy1Ws3Jeavhwa4bgLTF/tYlIZpufpR287aP5C4RFWPBScUWpLnVPuIW7x
 E/VhymiMBnyGpV4I/DNFutx7w65D2e7NpjAAviPtyV+041QZNvmOhWe28kHZdcUOIX5P
 D5JdR4GarzPDSknC7eOskONCu/PCdQFHS4fySN5B5C7p8phkQ0TSS+sWP3Hi4yOixlNs
 XW6YmSKt671i3efNwrBhJyTEIzXUb1Hy1uRcCX46LbswNaSas5i6NneyIJZB6gdHdCf3
 JnyejXDL8k1gqg5BewAhUqq5Er6utlgmr8TCwLU6kRuWZZCbPD+XsxsedQzjiByjsVdp
 7lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698923; x=1763303723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwqTfvgEpRHDMwJR5147QuaByS8jiQ7jRhJSWfgblyQ=;
 b=W0YLtBwjycCW0NfPWE9XRgsHszNy0rWg6u0EQEEvVcWWD215+QAxSILsHwsxErrVVn
 uLDhaucLyhtOIrPbitiManA3f5gee7NlTIfoYgILYg91BBOFuikXV2lLrpNzohYpH+XN
 ImF8hcZp4UpmUGDZrPCsFPfHEqpTTGmNzMXzNGWyeNgu7DTFSDvKhJEdwcoYqWrhliGh
 Hj8SzTb5gvIyohBYv5d97FRpjBVhe6+2EXSb4fFE+kZe6+SBQkZcmJA0eJx7lqCNn7XE
 eylIJPAXzKEcaLKBjjAfkTLMEtwFK2yipWRJpSp66uZ0XbSz1ZJ3vudDi2/TU6an5Dq9
 YQzQ==
X-Gm-Message-State: AOJu0YwCHZ8D+MG0574qGDQQeUegyqBbueh0o5EQl7c7w0JMDlqdWgnt
 pveJ2sYWXJ4hVbjyp1MfAEnXp/H2Hlw1ViZcC7f9RoEMuzl//GObSmeUjyQ2KMIgkEjX6IGhk0/
 xMU+Cb9i6tuwq9O53QwmG+JGg3KEhqB8doqaqpVQx+e6QAI+mHl8/9CMCkX1EhKe2xNHhI3Wl5f
 aexUohjY+ghnhhoIa1jIYsny5Shjc5faXKeQ==
X-Gm-Gg: ASbGncu5BVPMrWhWfBBY5Jb1M1iV/AxH66AU+Fxu9POENNJmvd8t9aSx/Uzjs5c3Y+o
 nEFgdSiwOJlc+qDj7dDDwPTHSkUfLnuHKIo0BkotZX6HrH3HuSae2gDbQz04LT6KojXnKfsFwDq
 d7ObH1NxxwRhU/ycKQC8iid5kA174flxDwmho4/dSeqVc8Gz5Gnba/m9vFxjCtKOCa/A/LfbbR8
 yMDvup0b/Vt6S2S6281KwJd0HvQABb6BQDUEkGWCXRL+/dp5TB7ecx4t8hmT3kR4sJqwUkA0NUq
 8swjlS924ArpeIU73KcbS3WsFQp96ZXhjonUolIaBhtK4vQOowvoDIlJip+0iqTFR6o=
X-Received: by 2002:a05:6000:2107:b0:429:bc93:9d8a with SMTP id
 ffacd0b85a97d-42b2dc228d1mr3146178f8f.37.1762698923281; 
 Sun, 09 Nov 2025 06:35:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2u1X9//ApsXxZgattmDR31jenRuZ8vL9TchcfugbkS/zdpgIuI7TFE/Mh9Cm4y9u6LlUR2g==
X-Received: by 2002:a05:6000:2107:b0:429:bc93:9d8a with SMTP id
 ffacd0b85a97d-42b2dc228d1mr3146159f8f.37.1762698922706; 
 Sun, 09 Nov 2025 06:35:22 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679e06csm16596490f8f.47.2025.11.09.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:22 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 06/14] intel_iommu: Reset pasid cache when system level reset
Message-ID: <baff72ca2a67974cb19499e7f8b7d87675adc746.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reset pasid cache when system level reset. Currently we don't have any
device supporting PASID yet. So all are PASID_0, its vtd_as is allocated
by PCI system and never removed, just mark pasid cache invalid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251017093602.525338-3-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 15 +++++++++++++++
 hw/i386/trace-events  |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c47f13b659..cf0b62f29e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,6 +87,20 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
+{
+    VTDAddressSpace *vtd_as;
+    GHashTableIter as_it;
+
+    trace_vtd_pasid_cache_reset();
+
+    g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
+        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+        pc_entry->valid = false;
+    }
+}
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -381,6 +395,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 298addb24d..b704f4f90c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_inv_desc_pasid_cache_gsi(void) ""
 vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
-- 
MST


