Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5457C3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoyK-0005xF-6e; Wed, 07 May 2025 20:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyF-0005wT-Ub
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyE-0006uR-Bw
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:18:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso563071b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663517; x=1747268317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24J3bQARsJAxNOHuQ8xXqx3aKqY63r09Vs0+/glM9oo=;
 b=D1eBbyMw/rCCdKVOqEe1qEVygIgfwNJCVfpbH4qIoMhJKcrs0iIeKoG+/4ID7vL6Yn
 ov/C9/j8HNf/9PSTe2RKMOLJFn9+NTG10ZGbuMBjLVz12c3JccA0ref8+6Xe5tdkcCK/
 5UM4+N9RaPrLFYlIQSUA6VRky2IAN+2aWBKWl8qUd0hFJu5Bc1zsTCT+A0hr5DZKhaOK
 7KzRf782BJBTWKdIHiwp3y2nGnEj1nLz53hMk1jcpjoDRXjgKwhWX+Wd4By3IK50Bgyq
 +YEd58NZby9O4J/dFoooWiEi0VUrV5LKuRYSR6+rn6qe4GbT026Mn72+OyBY3fYEli+o
 yeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663517; x=1747268317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24J3bQARsJAxNOHuQ8xXqx3aKqY63r09Vs0+/glM9oo=;
 b=mjsmxl4xkaVZr3ne1fR+Vbl5YDsVZRP9QvS2YcfzN4fHX6j8qGMKuLlYb5FLEAeBfp
 CG1o72jEDeRp3yUrskk947FcxjncBfGYQ0LN+N0Z1hgRmSnSkAuvf1tiLHSltEHQYGXL
 XdfRb4DRdpbqDa+HR0vQTvlN4kNoCNR0ODxXctPuzNEjqUolDb/jEtbs6h3S+yaejG84
 pYmTcF8XER5UOf51pVB4vxb8mJjdfiaSrFsY3y3p4qRrU1FnQb/bGhl7NgQ3h+kAq1Yj
 2j8Vv+es+kLCmxYma5ILXoXlHzTHBAWCgP6BLTuYNQl3di2zWqiwg7jSglWT4gb6rSx1
 rjqQ==
X-Gm-Message-State: AOJu0Yz1ZIg4iaZv/8ZsKTfOdIJjPqNbWJgkrzzhUc+IGmfHspBTtVNH
 C9DNCeM8rJhEEWDEswtFhl/JW4RK+ueoqdvVrMOTrerTLmvBpVY2HOgdLg==
X-Gm-Gg: ASbGncsRYeYQX2OkFwOF82wPxJp3QNwSnujXgpiYhpW0sOKx9YLLwPwRCez+C/Cd/T2
 kfF9i/xzvp0wDyOh6I+B9TOqLulsv58BgQdJ9cslHAkIv31QMX2mMD+rKoCgJCG4vyPFlCb3945
 bad0CkOpQbUJc/FIC3xmHz2Oo2MEdm7TCb043REZxuOomAUBsk78Be9/0ZkjNtx96Tr9M5thWyw
 nq03oM0LskvhiupHUyMlROIXavVBNRQMq8trU88v0YgFrCqWaZbvg6xSObN5hxWVn0BCfOGOfUp
 pI3SwFKuzKt/lCg5DQDWEEBJRBvZbnjWKTEOkdB4WAj7yIqs6kRi4FAyELAT/g==
X-Google-Smtp-Source: AGHT+IGoeqjRK7ZFr56WSw5bWPKP7f1TV1YrmaY01bM+y2gZcRS32IpW/MbpQWlGq8gyRlz5VeG8lg==
X-Received: by 2002:a05:6a20:d489:b0:1f5:7eee:bb10 with SMTP id
 adf61e73a8af0-2159af312a7mr1779842637.8.1746663516792; 
 Wed, 07 May 2025 17:18:36 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:36 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 03/10] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Thu,  8 May 2025 00:00:59 +0000
Message-ID: <20250508001754.122180-4-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42a.google.com
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

Add booleans to DC Region struct to represent dsmas flags (defined in CDAT)
in preparation for the next command, which returns the flags in the
response.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          |  8 +++++++-
 include/hw/cxl/cxl_device.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7129da0940..05d4c861f1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -232,10 +232,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
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
index bebed04085..cbcc1bc9f5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -177,6 +177,15 @@ typedef enum {
     MAX_LOG_TYPE
 } CXLLogType;
 
+/* DSMAS Flags Bits */
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
@@ -609,6 +618,12 @@ typedef struct CXLDCRegion {
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


