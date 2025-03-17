Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5281EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS1-0007NZ-Cv; Mon, 17 Mar 2025 15:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZc-0003eW-IL
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZV-0001GC-Gf
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:20 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-225b5448519so85480805ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229840; x=1742834640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuObOv7hVkPzGs/EkWPUQYYcsZbgB99BokPUyC+2nNg=;
 b=INPmDcuEkz5BL14OBllVi3BO35i5q6CbVphqcgZ7cMnzGZG+q1jqr5Fh+pgJIDr33u
 6m9AUQ+Qw49irytwQ89/ZIPxifZ3Vs0rqB2JaDcKdsItZjakr+9gCpV4zO6a7k8lNIco
 SDlx+2d1RdT6lExScG436kY6tBtEHNJMHl43eiWKSb7s7i8KptvY3FrU7f+ghdemJA2U
 zYV1Mp5oeDIcJjrV///EHPk8j2XydUVBYELPDoC3cKnBWsILdw8q1BIWGE/rbiy+ym2x
 wHGCmerVgEn5wwBY3ebZammj0SIhpUp10aphkek78tlxkog8IK7ZY5Ra1+wZmLiKkfWO
 G2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229840; x=1742834640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuObOv7hVkPzGs/EkWPUQYYcsZbgB99BokPUyC+2nNg=;
 b=HmrreCcoeR34v2J5L/9Q9Kbh+QkDpge6ppbAC97qZtyqCIzvg/o201opIG/NzHuT+w
 gaMHGjCRtqFK+vcOL90/X0OaphQ2VL4xmUlYr20uJa+yHPk4SkXaxio5svLcyyQJtrIt
 eyQuzitVh3BftM2CoNhekCecjFQG+Pb2LUbsc9/JUfj0w+W1qwMN4px+nT83eeZq5F11
 aM6fpbrPI4o8akP+88XWGw4/bdsQGjjE+oqt1YX54PdgM0hTfI549r/n6n06eqqwB1cH
 d1+zoV7cbgBspyud2Upon40V2f6HmRaqbFHnzWFtknQIA5CZ8LZqauQncLkWArN0cVC6
 0iMg==
X-Gm-Message-State: AOJu0Yzp232VRASzPncZsHl+dlLxQnMjSwla7EaLUiL+Ufo6vf1oks3W
 CFoLOACBDBsqJ2jZx/HuP6AExlpnRsXSye7dEwMtqLZoilCKv1gk/tCuFQ==
X-Gm-Gg: ASbGncvhbiU/9t/H/44uWTQdysxiJ5bgNuh1d9u/1SPY+ORnCYFPPiZgwia45vs3FHG
 cPKq7T1Ab6QG6jxlC2KsMhh/emElN6nQIsrRVCFEIDijabEkfqQSKef3mYsf6G8v5Mta2IOqaPb
 UXQzR1Ogik1Uy1Ov8GzWriMdy1VTllYHU3SEopFgjUu7BvkXQlLdQKxT90ac0TzeaGIaJi5I/TC
 X8F/eUcfKdNzjknJ9tJTWU/+geaThUKTmiuDCSqc73i8qL6W4a6fjK/x1b5ifMPQESmN2fy0eWb
 prKaVQ43W/79Bh8HUG/LStwNEaXhz6MabF1DqbTxQl+QNH15OPIKXRmWKYXX1H/68g==
X-Google-Smtp-Source: AGHT+IE9pdhC//ePNgMp9s0EvG5nIUDk60Qus2o8mI6ZGm9DAyJpfV1qoZWjtv30LUTlH7bL6Ce93A==
X-Received: by 2002:a17:902:ea06:b0:223:6657:5001 with SMTP id
 d9443c01a7336-225e0afb86cmr170861585ad.40.1742229839789; 
 Mon, 17 Mar 2025 09:43:59 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:43:59 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 5/9] cxl_events.h: move definition for dynamic_capacity_uuid
 and enum for DC event types
Date: Mon, 17 Mar 2025 16:31:32 +0000
Message-ID: <20250317164204.2299371-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:11 -0400
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

move definition for dynamic_capacity_uuid and enum for DC event types to
cxl_events.h from cxl_type3.c for shared use in next patch

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 452a0c101a..ac74e62875 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1977,21 +1977,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
-- 
2.47.2


