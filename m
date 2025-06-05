Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2571FC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKEO-0000N2-4U; Thu, 05 Jun 2025 19:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEM-0000MQ-3M
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEK-0004gh-AF
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso1379483b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166958; x=1749771758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vbz0CDPq236t18mBju+EUapSkDzWeN6uVn3bY2hAz/g=;
 b=RMi5BdZTVGbS+oCio0JpnHSPp0J+sdvW+jCDx0824yN5a/G/OtMgdxI7igVOB9LhRs
 JDNLVhknXOAEKSB8wm9+F7q3D3XUo9vCPy8k2VYpaFzMYmj1mnNTrYuFdVMSEV6PkCIx
 u3f2jAo5Um6aLAPumB44CbAHjVOT7MSBwErq8ua1xvWlXm76A2cnm/KHLjjprMNl/WuS
 lc19iwp6+z8YB7Lu4hc6kffviXkqlQH1s0gKfkBsW3lW343JF5gqh/L2PBDZrm9NuNkp
 GZqaCV3SsHYO5Fh5d5jY9QTqE3CLFPZOhp0vH3RJZbtJvqBVXktcj3GNOvWFZq+1n/uK
 esXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166958; x=1749771758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vbz0CDPq236t18mBju+EUapSkDzWeN6uVn3bY2hAz/g=;
 b=KnKf/uQVG6W8vEQSVsdkFYrlSwrJ6EfExoaC5jBRrdfIPUbWoAx2+465qmhS5MCfm2
 aPzzBd0aqQHTwQ2X77QuSIYCrcqrpmoVlwYFy/phabF5WHvHf1vI5wfTyKDsZQP64TdB
 p+1Ipvl9ekO0tqpR0a21ie0HNakorcgfmcBnTUOg6mopalGzz0fK3bUybtQ0x8eESKCj
 3glxOzVkl0zn8xmH4a8IqCJanzlmZVYRHHXhsxxCXBiHfZld2nAe68FKrk9xH/fezP+/
 QnkSXNYkVcKPlC2Hrotl49cmZL/X7vY/QmzJNkonVJuqvf1W24VweLUV3PdG9kCH3aZr
 WaCw==
X-Gm-Message-State: AOJu0YzuZJkurB/pA1nTUn4+jh98D5BZ4xAtwoxIC6kJOB5jpA5vOue9
 tbigmZ+gWWgJfCfTXdJGyVtOJE5m+g6t7PxjG04LgLQN3PkEXRcoazyOt1fmgw==
X-Gm-Gg: ASbGncu/UqqAVTE1U9e+GxVEoRB6ajWUdB3yRsErui4SwRXdxSSRlakszIxIL+qBYHv
 mPLZwcN654IGIjXMnFcB11zUPuxtsRbgDjTA+CiRSPvlUqRPfNCrHjOmkgXKWqF7gqTROKQGbhA
 IVgHm/+QyvpROhd+8sKtajqgS9yq3s884nE/mscL03yGPyKJMR4CY1sA7URydB31TDaY21PlZzi
 dLlhs860ZY0Rd2TU01qPagq9EQM/cZIhDCdw3dR1z4rhv05BpxihTklQ9eab3fVBEJxp4kn4eQy
 YH7vfYAuzkm8G0NFqI9WkaSFECK/laIv/3oLqc6sJHZNjf90frqhBbohVM+yRBRYyDBabcnQ
X-Google-Smtp-Source: AGHT+IHuxw4YKp3xud2AJIiH0aYA6/yv1A7vzszTQ/nO3KSTaQQujwTfKuvf03Rd0cgb7dyMoOsqGQ==
X-Received: by 2002:a05:6a00:1818:b0:746:285b:595c with SMTP id
 d2e1a72fcca58-74827e7f47amr2068617b3a.8.1749166958518; 
 Thu, 05 Jun 2025 16:42:38 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:38 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 2/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Thu,  5 Jun 2025 23:42:16 +0000
Message-ID: <20250605234227.970187-3-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

Add booleans to DC Region struct to represent dsmas flags (defined in CDAT) in
preparation for the next command, which returns the flags in the next mailbox
command 0x5601.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          |  8 +++++++-
 include/hw/cxl/cxl_device.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f608470362..0fccd22800 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -226,10 +226,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
          * future.
          */
         for (i = 0; i < ct3d->dc.num_regions; i++) {
+            ct3d->dc.regions[i].nonvolatile = false;
+            ct3d->dc.regions[i].sharable = false;
+            ct3d->dc.regions[i].hw_managed_coherency = false;
+            ct3d->dc.regions[i].ic_specific_dc_management = false;
+            ct3d->dc.regions[i].rdonly = false;
             ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
                                           dsmad_handle++,
                                           ct3d->dc.regions[i].len,
-                                          false, true, region_base);
+                                          ct3d->dc.regions[i].nonvolatile,
+                                          true, region_base);
             ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
 
             cur_ent += CT3_CDAT_NUM_ENTRIES;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7eade9cf8a..469e5d872a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,15 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* r3.2 Section 7.6.7.6.2 Table 7-66 DSMAS Flags Bits */
+typedef enum {
+    CXL_DSMAS_FLAGS_NONVOLATILE = 2,
+    CXL_DSMAS_FLAGS_SHARABLE = 3,
+    CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY = 4,
+    CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT = 5,
+    CXL_DSMAS_FLAGS_RDONLY = 6,
+} CXLDSMASFlags;
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -531,6 +540,12 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    /* Following bools make up dsmas flags, as defined in the CDAT */
+    bool nonvolatile;
+    bool sharable;
+    bool hw_managed_coherency;
+    bool ic_specific_dc_management;
+    bool rdonly;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2


