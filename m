Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D636C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 19:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYVda-00018M-JL; Mon, 29 Jul 2024 15:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYVdZ-00016r-9S; Mon, 29 Jul 2024 15:02:25 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYVdX-0005MB-7m; Mon, 29 Jul 2024 15:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722279743; x=1753815743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u1X1OCgRqReW+TSFc6YitcaDpTgBuZmhc4PLeBqpjZ0=;
 b=aFpht4YWl3ZfVYCRZIL/j9ZiDUAn+QXjsq9jD6RQkd7PjSJrjXBXIfwn
 EAaczjpgM7ex/I5S7jjplfxs667tjBi5/XjkObdCknf+7u19F5LWdy2PX
 MSD5fnxA3FcFIwlv55jXfvtgEOUIVhPyBGVnBbSwGTEBMsV+6W3FhVKky U=;
X-CSE-ConnectionGUID: jojkk50eQ12qJ89zbkyU9A==
X-CSE-MsgGUID: EvnIjg6WTxWUvE8jPU4ogg==
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 12:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ4sOURFVEtBA8V+zpJ+4dWfBOT1fh41SpUEISVQcS/lC2nsn+hFzBI5dJIBfnjwPTNdWs6C3xWLtLx9YtYUmO7JqJRyKhBlL6b5m0YQjjoIIYKb0eBrAUxlwkjDDKXPmevPeIYVPXQnIOqjdK6RA5aer/hhg6PPmPWXBdu1WRtB5vMawsOXcM7KtpE090Y6tLykt5iqSd4nOYb3yOqEPS0AVXTVa3HEZoTbcXtm6Nx3/vpVmGF9l2F8cljrNaLZC8kkt0++6heD7P6NwHtioy9cCXzMdt4Cy+6eG2907z+nfSc/y+qKVDH4AtMRXZQS/p44vztzlyu5ObQ4PyjJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2ns6jt4vvYKEodtuF/F+J9rzfCgCF9zAo6A9P55gJ4=;
 b=ofeT84WS8Ak3ORfHjYqLm5Egser7YLiM8pHd3ia5PPtZHQOg/15/NP1lVF/dOLt1YB6/k2J1Ctc9tRaFktKECkrjRG9qG4WVN8ZxrQz7tLsNkc8PA++gn06ADYAhrRThg3P3lZQv7GIDHHu4ZMspLAlgWoHYbtfIMisqRTVr+h9aaEMUyKjWfcY/l7th/iAikvKIPTw66aepyFAEooOkBFBAI7ervl7c9LxZK6p/bnbkiMakhye9QTM4a7nVt2B7106OWAUBzjbzgUEqNiEY+y/2bWaule835omlUEpIBOt6644LDa81kDp8OSPxE0oYex8k3kkIyjWNvOACztvlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.50) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2ns6jt4vvYKEodtuF/F+J9rzfCgCF9zAo6A9P55gJ4=;
 b=A0EXMqXB2BLCxPDXfBD4E4LxzONoqUSLsTdmOWNklwZemrplaviLoixpYMtwmktYnreh2y8BNgGkXDCm14U9Gs2n8ZiJw+WAgk9saljdHcUqLBJAr2fq5JxPwPNSrN5YVMUf1JfLQ7P6cdneYBO3lUV9TwOtxA6JcRNDwjRr3YI=
Received: from SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8)
 by PH7PR20MB5369.namprd20.prod.outlook.com (2603:10b6:510:1ec::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:02:15 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4e) by SJ0PR13CA0093.outlook.office365.com
 (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.17 via Frontend
 Transport; Mon, 29 Jul 2024 19:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.50)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa001.seagate.com (192.55.16.50) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 19:02:13 +0000
X-CSE-ConnectionGUID: x8CVU2hWRU2InkNuzXYIyw==
X-CSE-MsgGUID: MHP9bCUVQaKMXbiLGg50Lg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa001.seagate.com with ESMTP; 29 Jul 2024 12:02:07 -0700
X-CSE-ConnectionGUID: oiQkqixcSDi6FwPsQob3zg==
X-CSE-MsgGUID: qU8VJmBpTwqDBymhERYUNw==
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; d="scan'208";a="121679667"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 29 Jul 2024 12:01:58 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 berrange@redhat.com, alejandro.zeise@seagate.com
Subject: [PATCH v2 2/2] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Date: Mon, 29 Jul 2024 19:00:35 +0000
Message-Id: <20240729190035.3419649-3-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|PH7PR20MB5369:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f1baf58-7a9a-4d1a-10fd-08dcb000f5a8
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l886aBd+BkkM9iIUWSFr1w18wPXEDHCaxwQY2uExhoEBPlgg2YdMt4aHVnEg?=
 =?us-ascii?Q?Jg5x2FneAa6yehBxtP7Km7CFup/tGzeXDUjqNIhRYa+6LY9amroUx5rwIMAc?=
 =?us-ascii?Q?I/Ge7/ULJ6oKDhVtrCHxj1D7OqPysew5huSDvpq07q+xY6FN0qMR4Nvhz0W/?=
 =?us-ascii?Q?iPof/zEesD7ygXkfQ5/QUqA2vGdUEh3n9FKAX/P7p7qYl4UacIN4UT2mGSSm?=
 =?us-ascii?Q?ktqrLRqzAnObThqixuXAYM5UBL2gvZm5fGliwHRpk2P6dLryqwe54zGsjzTy?=
 =?us-ascii?Q?4SjuUWOHQL/IiBur2kypppyKde0+PO8iu1Ls5GwAdWgUS2ZxhvyfndTTk0A5?=
 =?us-ascii?Q?jEBRZreqlpCaRZVMNSoWr9LpmcpRK+SIhKJDdrRLFqs8no1NKT3X4D+HZCi7?=
 =?us-ascii?Q?goFpr5g4y8Mj2i9uuka/wOAdS154WXVU8eS9nkY2B42mVj76k/i2KhdQ8J/s?=
 =?us-ascii?Q?PmSRFr0jP6CbUow4SRtH+EEoVagbafzMFriibkrv/U1HleY4DInvL6r+tXJW?=
 =?us-ascii?Q?WsTiHJP7rYJVEo6S1rR1Aw8dzGmt+Xhvw5AQ232ms07Wgr6+12Q1PKTJKaFF?=
 =?us-ascii?Q?+msYyMRPeOWS3SC97pfeia0JCz3AoySYHBKxiNGDR9bPoPyGRyDGcCnoJvMC?=
 =?us-ascii?Q?nIzgMI7SO+FQ7DXssuTSO1G500N79/7EBdXfXQXkQhVys1H/I1U6k4ObPyjF?=
 =?us-ascii?Q?YYnahzMhZL8m9vxUaHMpl2OX6qP+hcc/u+Yl9KUzkjmJsQvmK4X5W1nggSmy?=
 =?us-ascii?Q?tvsgJAKRprMMkLChZslGv8QY7nbkgzArki/SylmqlWalWmXdtgOLCGVCJ9Rj?=
 =?us-ascii?Q?ZT5z0yVHrujNM99UGoPI2C9K0rPR4BI8o1f5LWCO1O6+gaIt/UMbjyIFygkP?=
 =?us-ascii?Q?3TzbLVkEGHrhk16DWbP5Ph+ml9rxTdpk2drd8PCpVN1RUd3lJIcwRaR63VN3?=
 =?us-ascii?Q?tufJjlMC5ca+lH4QAMeTWKLSiiqR9OGebJCAg03CYRYz03wsE9ZYyVcV7xPW?=
 =?us-ascii?Q?amNaKmPXpmwf7FWVjZYBFxUm/4tTK3UtTGrJqKTxIld8KYgIApt52uDo7wJn?=
 =?us-ascii?Q?0T5NVlAKkC8h50a0jaWdWs6fsFdqyhbFygLHE/YudzVJDxGKq0M5sT458qLL?=
 =?us-ascii?Q?z/Zv1uVEeg4BPHt2WbHNpCBy1ROxNMUfOSLvUZCWyqDKjtPAzCnNshcRHBbH?=
 =?us-ascii?Q?qZExJUBcheEiqNyapgNyrp5YH7iXl5yzP5nztfd5x+QYn9miPdFTggQ790Zv?=
 =?us-ascii?Q?HtNC3ZEd3s2hcTA3lBOo5BHDIlZoYCp7EC8Ty5mkTEY3F/QTTjJMXhblrykE?=
 =?us-ascii?Q?eRmhnDj09aXSaq+z4sIT1hgEb2TEvR/kbJHp5Go0HtWJJ1BSLHTSJ7mAMdrx?=
 =?us-ascii?Q?f09Fs47ZOpyM+mndt0ScKpyYCRmFHZZ0d0eQDXBGazZNpiMCQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:192.55.16.50; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa001.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fNs8JUFNjXD73FzL2Ybt3k7epk+KR1BLTO+wW43WVnJvV5aGT2iGefEq5P7+m+lEBXB+aoSJpIlm171H64EHK8EDJR9WAxuZxlgcVjthW7rF2+M6wIcpXVBHoT4lkOLWbZWT/bCEeSaG7M07/Nkt9qc6zhxkB+O84Leqww1BSyN645bPGtLP+nOhrDd7feAePKvEaT1h18IM2PeEVqDHzlefliOX0i+7WS9/fUr0AVOr9fV5lvWaHCrN6ZELuc9/xbSFuk19Sr0bc/5XUWnbwrTkrWy2YtAokdHdBZjAyc/MQ2MlI1IC3AtWXxzeE2fbA1u6+1KM33705JMX1789qd7qAHAuqaNCnsBwXbfS4Y4ZqElfCQ2r1rYmHyG5SmxKz4lHZZuT46byVriX7YWfMhtnaP2N9qdugqPCmc7mo0F5oSJEdcstO4xVzglfVjdNbFV3GhM5KPDhFUrMSe47Ih9dcYzecwTZmAvqLTh20WntHxvN1tDHJEbRAbUortgnYQkaEtiRceACOBh2yS2uZi0unp47qlrH63eck7+ZSwl4brbbIQCivPSTK2gIlIwDSPSC+E05CLXa4CtcjXq+P3d2BHnDwMrPcDmbWl52zNZwZL6ROzENtMeLSHNB9b+p
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:02:13.9407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1baf58-7a9a-4d1a-10fd-08dcb000f5a8
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.50];
 Helo=[sgspzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5369
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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


