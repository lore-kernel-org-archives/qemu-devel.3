Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31545C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0TG-0002Gr-F0; Mon, 22 Jul 2024 17:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sVzU1-0001RW-4E; Mon, 22 Jul 2024 16:18:09 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sVzTx-0004KQ-Qj; Mon, 22 Jul 2024 16:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1721679485; x=1753215485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u1X1OCgRqReW+TSFc6YitcaDpTgBuZmhc4PLeBqpjZ0=;
 b=T0c++a/JEF4PFUoKbJ3A27v3ZQK947aYNqih0DaUtddGnwLxJTAJ771E
 M9at45p85PGAM5x5YPS4PVHdNEDTSAciu76wtcNrgsPihfzz5DMgdpuxz
 f/YsCS0+wLLL4FpJawAJ36VzaA/GXJiy5XLIkZ4af+St//0T6Jq6gxxIF 0=;
X-CSE-ConnectionGUID: co8uU0Z4SleANN66GzbJIg==
X-CSE-MsgGUID: PfmQVoutTJKhcyABdiyHgg==
Received: from mail-bn1nam02lp2048.outbound.protection.outlook.com (HELO
 NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:17:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmzATadKRUohqCmNGbwjMa8flmp4NF4auO2JDNfSoizSg3Ei2nzJWcozxpUyx4gYldD23Gy/6Xedm0omHA9DkhvzWKmoUwVliPvGJ3NueJjr0kOc/S+Gx0tisvQhVc0T8nv1S/42zTlyDLQLXF6V9r1p7WOzly+em1i3h5gQXJbrhbcZvUKBl72wAWCNNuJQ7RSyc3DdgREyBHZR0jsOKn1UHeNAlRt7rAni43wNq9ezR7Wh52vt9yJv/VPlfbC24dDTCfP0yGxlQyA0yZ6DhCttRRbztE2nn8dfRxm5R3wOvFqX/M3t0ZWA9RhtaWy/3VjuqLLSntMLsXTh3NUNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2ns6jt4vvYKEodtuF/F+J9rzfCgCF9zAo6A9P55gJ4=;
 b=Ymdvt7VXu4lXt0umwxxZIhRPCRLVx22xFEVka1Mg0A1Mv7laLfjoKbEUqkuQQtZb6x2rFCHiyiST3aUHkTUlMDI0Dp+hWgEoaaYdO/jyIEhGrxv4VZRWX+V0E8jgDvldpXuudcKmyQlNM4I9B/3YWl2fG8hH8tljE+DYCBsV45iePYG/YUM/mMmtYRHvDWgT/Q0UVn51JpxXG4wP06hY/gaXDOYPuTuIOHUuI5F2g2PSj+3vn3EBmgfQu4QVX3Ac7owPMjQ+zfe9LZcMhRnlj8aoYpMgwNHdQDMJd5GDgYl3pNhBwcUO08i7Tm8hX5zgxpJn+SS1kEHwZXYkFYLHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.50) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ns6jt4vvYKEodtuF/F+J9rzfCgCF9zAo6A9P55gJ4=;
 b=JhMVKfLteVz6u6ddL7M1FK3Y4YHMl8sq3VUFXqXx6ydhWYBr6nAPzip/4pPpx168d76s23X7upnch5HwT9fF5VB2EX/13fnt2AWmiY/91rqNem3D4qm4fJFOVvIpTumXKvAuDf94qsJi39BGMKWsb/JukTjlaB6SC+SFrIPULFE=
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by MW4PR20MB5227.namprd20.prod.outlook.com (2603:10b6:303:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Mon, 22 Jul
 2024 20:17:46 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 20:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.50)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa001.seagate.com (192.55.16.50) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 20:17:43 +0000
X-CSE-ConnectionGUID: iKj/xre0RGC5VujwmJ0Xhg==
X-CSE-MsgGUID: OW0lHWIrQ0KP4fS0BR++og==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa001.seagate.com with ESMTP; 22 Jul 2024 13:10:44 -0700
X-CSE-ConnectionGUID: 1ZdbERdDT4WGBaGxE/yYgg==
X-CSE-MsgGUID: sk8Cg6RtQzykd8iOOaZClg==
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="121301633"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.11])
 by sgspiesaa002.seagate.com with ESMTP; 22 Jul 2024 13:17:37 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alejandro.zeise@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH 2/2] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Date: Mon, 22 Jul 2024 20:15:24 +0000
Message-Id: <20240722201524.822730-3-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722201524.822730-1-alejandro.zeise@seagate.com>
References: <20240722201524.822730-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MW4PR20MB5227:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87f2f9e3-3a37-4b47-5fc8-08dcaa8b58d8
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OFmt4TmYpBQMWOyxbBdKG18s/wdrtI1zijHtb0uEJJA3ubtP/+GuqjdYHEFX?=
 =?us-ascii?Q?zQX5wknWJZibmjau8OG/z7KFH5UENlikO1QM7P4ZOom8UpGzYvFGA0LmEUkg?=
 =?us-ascii?Q?7AYVXAhmM7AXZnZHjOenv/BYUqTBAiAztYFV+36+ZiSs2MJlcRNIb56Da6OW?=
 =?us-ascii?Q?Eo9JvwQWCIuPHDxR4ummTbloND5AkwJdQhGm/OLAuYaEAfAjxWN06BAOIeZN?=
 =?us-ascii?Q?Q64eWtvK6OBAY8DhPH3mzuUiPtFMUZ1e/ljBV5gddSeyoRXEOoTfBwGUtJUs?=
 =?us-ascii?Q?XX84F6j9k+74d8tOF6Q2KC2vz5RhInTgGzPIjZ16uFdU2dO2PvcCj5AmwOXI?=
 =?us-ascii?Q?dj/g0ZMkOq07j8lhehnX+KDt9DpvQNyehyupaylsL5wfZ4DhE2tTQhIBlQcr?=
 =?us-ascii?Q?isyfY7wAy6GYlgGBA0mQHhBsOd5C7GkDLp3gaxCGu5m03ve/t/UwP7R8RG9D?=
 =?us-ascii?Q?A0rMKwfcIN96yxLr7X2jlkTP/PrLoYQ9s98V+NJD6mqSDp+7/LocVOpRWDnC?=
 =?us-ascii?Q?u48VDE1Bx05vMik+kVb9CMgCRy8jiv+cIXqATv2P5/v6RNNm4b+9nnvV8D5h?=
 =?us-ascii?Q?ffQGhYAeeBkM6TVVgz5SrMm1Z8j2k2lddrMpyA0RUIicZ0+MNRULN5lv/nBi?=
 =?us-ascii?Q?AX1bW3v7XqqQBgnu3vVzc3Xtc69vieHyjv6O4VAI6vEvEUaLgurU5QgnK4b5?=
 =?us-ascii?Q?yFjh6T4K70fIWRkrrT+ILvS8Z+fZfRrvhdRxvwyFX/TltNp7hti9CfvAmymw?=
 =?us-ascii?Q?lomO6Vdfg2KYnOMWb3dnzt9aQXMinxq4bFWG5ZjKf01AzPajDR0QFZ85NmoB?=
 =?us-ascii?Q?wy3SuZ7FV4xLcDFEnfk/Pgh2lcHIGmqOn+FWGcaakXX3otzPk05zry6Xaz1E?=
 =?us-ascii?Q?TTXdaOorlzhoxVcP/hnjsqnaf2CY2eHLRknBMCVo/fEvPVrdiIexwJ8a9K6w?=
 =?us-ascii?Q?XVm+G11yp4ZA9avqPc7TR/ntme7Lq6VyWKY2XHDVNhZ7tQur0Sdx9xV+43aB?=
 =?us-ascii?Q?WIuo09+nANxuUuDEjQFrN4TdtlZkFnkej5BLpjLG6D22niM6lstzDeQC9Pa0?=
 =?us-ascii?Q?v/BcBQl+kM9SvpdnHw/KvdgjPjz63VIiZyTfTDT3i038y/S7OSYEW9JZ3is/?=
 =?us-ascii?Q?nXRNhsmmG3XG8tR7zOvr5tkWrhB9CHPdPGWvqFnxDSuMMjI2FhU/FF9EADzy?=
 =?us-ascii?Q?IJRFh946+xRo1c6+qkz968bgC6fI32v1AMIKqKeYejkyzeu+/DLomgxfH+1Q?=
 =?us-ascii?Q?y+iYY/F5RzItnB4PzZJvPV5349mJdLB3G4piQeKK8l8uB7l1Bv/io8PhT49b?=
 =?us-ascii?Q?M14jKXK0K3comivolcFiBCQFX75VzPQtqyt5ZgCb5TeGSvHoaLrY8jDrb2mr?=
 =?us-ascii?Q?St41STkX4LRbD2bBH2/D4PM4qOZ2?=
X-Forefront-Antispam-Report: CIP:192.55.16.50; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa001.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /7Jfux1winX7k0YJEr1y8OEh/VMNqe5L3Wo0rY+w3ED07qY5XEJgrjo63CK8a2sRK2K+bAupoW5IENB86xxRhtO2gnSChykAEAXEl64cj8HGdvfpW2V+JaWtKVOKAgVOnPoT87DirvBXdkXx2df2WqGo98ZdsoVQTi1o/1rBpoC83oJyYVOlo6jJMaDG5tHRnD58ePo35RcnVHP/ortW+YkKlPRurFKT6SlAr6iORd4Tmks3yIcbS0nkMbfKbVqzSK7jQrxPjFc1wZUCcqcZvolwdRUE1sYSBzfxFlH+Jayxbua7EpGMGr+C7aMvdEH7BCZChTm3OHG4tSFK97dVkdV8KY0BUPIN6J5Jg+5+WR4+Idtnk/rAc6giQS/qa+XWSkQnvTnALe91b57He311i5C+8lIB99iwa5fI6SnNVFt9Ycpg4qw3PL81DMIoGXdcm0s7QEUpUYG7mbafPMokz/FIwmcftM1LO1eRb19mu6w16GadZg+gm638KvTKs3GxFbikY+3R4zzbamyAB5cpKHK2tJH/Z2iWkZLhxzRG4BGJUQb9d7nAyZFHsQszIMOdkoKbfpjpMAdKLv+LNHIc7yU20Dlb2KcBDYuIU7UhvmTBKSDz0tBbGCOgvrkyBTIx
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 20:17:43.9081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f2f9e3-3a37-4b47-5fc8-08dcaa8b58d8
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.50];
 Helo=[sgspzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5227
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jul 2024 17:21:20 -0400
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

Make the Aspeed HACE module use the new qcrypto accumulative hashing functions
when in scatter-gather accumulative mode. A hash context will maintain a
"running-hash" as each scatter-gather chunk is received.

Previously each scatter-gather "chunk" was cached
so the hash could be computed once the final chunk was received.
However, the cache was a shallow copy, so once the guest overwrote the
memory provided to HACE the final hash would not be correct.

Possibly related to: https://gitlab.com/qemu-project/qemu/-/issues/1121
Buglink: https://github.com/openbmc/qemu/issues/36

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 hw/misc/aspeed_hace.c         | 91 ++++++++++++++++++-----------------
 include/hw/misc/aspeed_hace.h |  4 ++
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c06c04ddc6..8306d8986a 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -1,6 +1,7 @@
 /*
  * ASPEED Hash and Crypto Engine
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2021 IBM Corp.
  *
  * Joel Stanley <joel@jms.id.au>
@@ -151,47 +152,15 @@ static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
     return iov_count;
 }
 
-/**
- * Generate iov for accumulative mode.
- *
- * @param s             aspeed hace state object
- * @param iov           iov of the current request
- * @param id            index of the current iov
- * @param req_len       length of the current request
- *
- * @return count of iov
- */
-static int gen_acc_mode_iov(AspeedHACEState *s, struct iovec *iov, int id,
-                            hwaddr *req_len)
-{
-    uint32_t pad_offset;
-    uint32_t total_msg_len;
-    s->total_req_len += *req_len;
-
-    if (has_padding(s, &iov[id], *req_len, &total_msg_len, &pad_offset)) {
-        if (s->iov_count) {
-            return reconstruct_iov(s, iov, id, &pad_offset);
-        }
-
-        *req_len -= s->total_req_len - total_msg_len;
-        s->total_req_len = 0;
-        iov[id].iov_len = *req_len;
-    } else {
-        s->iov_cache[s->iov_count].iov_base = iov->iov_base;
-        s->iov_cache[s->iov_count].iov_len = *req_len;
-        ++s->iov_count;
-    }
-
-    return id + 1;
-}
-
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
     struct iovec iov[ASPEED_HACE_MAX_SG];
+    uint32_t total_msg_len;
+    uint32_t pad_offset;
     g_autofree uint8_t *digest_buf = NULL;
     size_t digest_len = 0;
-    int niov = 0;
+    bool sg_acc_mode_final_request = false;
     int i;
     void *haddr;
 
@@ -226,8 +195,15 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             }
             iov[i].iov_base = haddr;
             if (acc_mode) {
-                niov = gen_acc_mode_iov(s, iov, i, &plen);
-
+                s->total_req_len += plen;
+
+                if (has_padding(s, &iov[i], plen, &total_msg_len, &pad_offset)) {
+                    /* Padding being present indicates the final request */
+                    sg_acc_mode_final_request = true;
+                    iov[i].iov_len = pad_offset;
+                } else {
+                    iov[i].iov_len = plen;
+                }
             } else {
                 iov[i].iov_len = plen;
             }
@@ -252,20 +228,42 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
              * required to check whether cache is empty. If no, we should
              * combine cached iov and the current iov.
              */
-            uint32_t total_msg_len;
-            uint32_t pad_offset;
             s->total_req_len += len;
             if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
-                niov = reconstruct_iov(s, iov, 0, &pad_offset);
+                i = reconstruct_iov(s, iov, 0, &pad_offset);
             }
         }
     }
 
-    if (niov) {
-        i = niov;
-    }
+    if (acc_mode) {
+        if (s->qcrypto_hash_context == NULL &&
+            qcrypto_hash_accumulate_new_ctx(algo, &s->qcrypto_hash_context, NULL)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: qcrypto failed to create hash context\n",
+                          __func__);
+            return;
+        }
+
+        if (qcrypto_hash_accumulate_bytesv(algo,
+                                           s->qcrypto_hash_context, iov, i,
+                                           &digest_buf,
+                                           &digest_len, NULL) < 0) {
+
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
+            return;
+        }
 
-    if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
+        if (sg_acc_mode_final_request) {
+            if (qcrypto_hash_accumulate_free_ctx(s->qcrypto_hash_context, NULL) < 0) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: qcrypto failed to free context\n", __func__);
+            }
+
+            s->qcrypto_hash_context = NULL;
+            s->iov_count = 0;
+            s->total_req_len = 0;
+        }
+    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
         return;
     }
@@ -397,6 +395,11 @@ static void aspeed_hace_reset(DeviceState *dev)
 {
     struct AspeedHACEState *s = ASPEED_HACE(dev);
 
+    if (s->qcrypto_hash_context != NULL) {
+        qcrypto_hash_accumulate_free_ctx(s->qcrypto_hash_context, NULL);
+        s->qcrypto_hash_context = NULL;
+    }
+
     memset(s->regs, 0, sizeof(s->regs));
     s->iov_count = 0;
     s->total_req_len = 0;
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index ecb1b67de8..b3c2eb17b7 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -1,6 +1,7 @@
 /*
  * ASPEED Hash and Crypto Engine
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2021 IBM Corp.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
@@ -10,6 +11,7 @@
 #define ASPEED_HACE_H
 
 #include "hw/sysbus.h"
+#include "crypto/hash.h"
 
 #define TYPE_ASPEED_HACE "aspeed.hace"
 #define TYPE_ASPEED_AST2400_HACE TYPE_ASPEED_HACE "-ast2400"
@@ -35,6 +37,8 @@ struct AspeedHACEState {
 
     MemoryRegion *dram_mr;
     AddressSpace dram_as;
+
+    qcrypto_hash_accumulate_ctx_t *qcrypto_hash_context;
 };
 
 
-- 
2.34.1


