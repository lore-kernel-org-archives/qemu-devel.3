Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B0BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb02U-0004yo-EU; Mon, 05 Aug 2024 11:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb028-00034X-37; Mon, 05 Aug 2024 11:54:06 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb025-00041K-PV; Mon, 05 Aug 2024 11:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873241; x=1754409241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=82K72XH/udx3p1ujmycocFs1qs8OzQsY1UyiOBnG/iQ=;
 b=oj7+qUnQS0Jnx2A0ZwKgUBZPDmsNm2P41Oyv2zJuTLNayDwpZf4lGlS3
 LHD9C3ip/rKHt+OKv8DPQvYi1evD9Xf/86CaptS1haunZc8NTwR2kWEZr
 6hc2HRSHqPB8tN4uwzXkMPHSkLcu6NM9x1DBcdeL9oZNKWaqRCu7v+ASm s=;
X-CSE-ConnectionGUID: fIFLO/QLTsafSq+8jXKEyQ==
X-CSE-MsgGUID: lUu87QpSRDWK0ImGJbi/aw==
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvgGksBiB9JkDRG7Zt2Aq8uMznPb3QhkVdNAa7WmoNuxbiwkrqroeKTo3VKeh+3yE5u7tH4FMNiL6je98kAM5FgfWWi2/6XOTMrDp33X4NIU7H+K8VjnTXtWrnzLrKz12XVTmWiKK8DP4En1/eZyxzWR7Y9KoK2Eu0xTXNXxwf1OEAUiMckFS/IO8nMz3EIUr1o2HiNQ27cvOEDVZ2n93JpYL+DfZVx4MZNl8HxTUe/MIGv37uuEaqK1ww1n9ZD0eBLJk9CqS+jxZ3Rdp3fefARDSOLnMQP8mNFlfjwYQ1HWxceP/LaVZCernweht2db4QOwqU6Ao5ylikH028Y5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itQb05BoFQpUYXu/wIdi/KoIRkC1h7PlW21RutJWxxg=;
 b=eS8pJdbQ3va2qsiXOZsUWV3cEtmpgOlXyNZDs1RMIFfXGOwxmfMwsJds1n3KOXjHxOQre+zb/Oh+hFl586lj/XOKROZFS6Dipn6qIhpG9lWVcmOm7nazdKyhrJMNjSkfQoReqJUiNcTB3cq2ThStcek2BfxVanZMhxp+cd0iP2DP04bYkvDEj8fkc7MfuGp41EpqDV+53iG1l7+3d1n/SKMfKGrTx3A2YRxgFA1Z9HZcLAhHidAOdJ0I+ZQXpdYhiKZRBa6xsnwKKeA9uEE70c3CBcvYpbsJe5a6E4Kn4aj+qJGt4QNMGaiTo2gaL+6HAlA/ZD+fVhkzAsmfI8gBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itQb05BoFQpUYXu/wIdi/KoIRkC1h7PlW21RutJWxxg=;
 b=VaoKVAxH1yfSY38efPly1WtJY1mW9w1x5KSm7b7FWBt3FdVgvndfgD/rHoCFLnu6Mk5UQudc6MvzqyOtFfYI9wfPGa7kiBRDhQtmxLUy/tlcv7A0up2Ce0wiA8P/i/g0XsLOoHzIffH2cIAJ08T4IhU968AvX3AvJfg6pk5JyDA=
Received: from MW4PR04CA0376.namprd04.prod.outlook.com (2603:10b6:303:81::21)
 by BY1PR20MB7384.namprd20.prod.outlook.com (2603:10b6:a03:4a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:53:41 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::29) by MW4PR04CA0376.outlook.office365.com
 (2603:10b6:303:81::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:41 +0000
X-CSE-ConnectionGUID: cbJQWtj3RCqFPfQJAnq0hA==
X-CSE-MsgGUID: /oG6rhDvToeSh2LBnwxKfg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:33 -0700
X-CSE-ConnectionGUID: jGTUoJKeSCSAAjYDA5jC0A==
X-CSE-MsgGUID: La/c6Fn4SW+6j5MaAHktYg==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920707"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:33 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 11/12] tests/unit/test-crypto-hash: accumulative hashing
Date: Mon,  5 Aug 2024 15:50:46 +0000
Message-Id: <20240805155047.3151540-12-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY1PR20MB7384:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 728fa634-0224-4995-87eb-08dcb566c766
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ydkPVDc43tdpFnFANTmlZBF8+OHTfEKxru2g6WCQq2OLAwMVQ0Xk4dUgLZ8T?=
 =?us-ascii?Q?U6cPh8vzIOZ8Q1qTkp+Gvk1qbK5E9B4lvdqxmA7u9DAa9gAwF3NwwV6hl2bI?=
 =?us-ascii?Q?643jDkbTINKhoIsW4megskUNEmWlnI4xjJSX+/JU6vnh/cHCfG1H6rkmsj3I?=
 =?us-ascii?Q?1NK3bA0pgwWxwgPsu6cT5ctfpUl0gTNjh3s/LhF1Nk7Sil92WtiCpLxQalqw?=
 =?us-ascii?Q?tJqInvtRbHAgOQf9TXXz12ynzQ3/0pVDzvD22wsvOnpNiJUxVYRD9b1jNR6e?=
 =?us-ascii?Q?hj/vytyT+Af60tXhRMvVva2+C45oD8mjr0K3eq1ZcgvXgqydVham9boc2bmU?=
 =?us-ascii?Q?bHJxL0y5wy1aP9JLRu33WEyQ9tAg3CpDJyVdGVApQZBu8K0k/t00Pm9pilps?=
 =?us-ascii?Q?NT4vxxbawUu54A8LJpXvniwti8rrOahbm4Vi+SjeGSiEC5aCKNVPPq3ai/+e?=
 =?us-ascii?Q?U79q95vL8NWgMGGk8WCHwyPbX0ryrI8cnVFf3xg/ALYmxos7KR1JcxaRM7/G?=
 =?us-ascii?Q?NIXOuHwo3oaaMdj0rTbgB8pe6986kWunGNUv0UCeoHkWj6A+/eazDZiDi/J4?=
 =?us-ascii?Q?A8QrPP9kym06KJTMwHV05ezhr36j4RiCFD5UpljRo6S0F364uuiof9nSTktb?=
 =?us-ascii?Q?UrAxwdCdIdSKl+N4Pu/4eTu+ILP3QykGlsz/9LS1DSUiTPyeSDuQtD9oawLM?=
 =?us-ascii?Q?UBLaUkMAIi2fjVoP6ai3qPOs1LrQosPpW/4bOpVDEkQlpWgZs6BhJtHNHrSq?=
 =?us-ascii?Q?BlKLWvwYXqtEe2/ECjnsTmErjOJeweVp4yIbwgJSIs5Yn5yE6nPA+PrGM6cl?=
 =?us-ascii?Q?MXQw0BgGoYpGi93mzzMtHcULdSoYddq+5ekTrgyqVSbKxRzUQ/YubSpemoqK?=
 =?us-ascii?Q?YjUNay+LdhU5jGk2VjKDpVxM+CqDSVxq/4KHrjvh2mMg9EWoBNhQ3gfw/gqy?=
 =?us-ascii?Q?bkHQWrrQMGmtMBBl3PXMCBfDykZPEyhp22xQMCcyHNvWcZJvkhTgknfcvPhs?=
 =?us-ascii?Q?7oaSoRN/qMD+Kjhh71QfL3h/V73rdvfVmjeKV51QniEaBuvP28NMxaHDBI8x?=
 =?us-ascii?Q?Y9UbR+2EX/ZZ6Qa1gEw7o+EVJkTWi6hjlGJhkGwvk+tf4AC2qq//f2iXyKY4?=
 =?us-ascii?Q?txy8glrR3yhHq3SxQNG4TZx5RCIllzLVTwQmrFmiehgefoLNH8LD3TAnNhVL?=
 =?us-ascii?Q?SPdPuQYjKL3hFdcBtMh6Bl4FckxfgEB3Sit5Ts8DTnkq8omiIxwCgh28FcLP?=
 =?us-ascii?Q?esZnS97wi0Tj5kE6xwnOohJ8xk8EHUmNg0hp+OelSTcg3A0DxOkRhkd1dg52?=
 =?us-ascii?Q?SM3rB/BvqST/LbGoTx5b0RWVDJfKK0LpqsJm+YxNDk0zmc6nRs3DJ3F5z2HU?=
 =?us-ascii?Q?cwJr9oqYrJ6g7CMSTfs5+Qp03h7kTqckZF/w4R00T480mHkX+2PM5AOtRhmO?=
 =?us-ascii?Q?wHZwXZWNuKFUHGjEe5Ta2d6BUBuHDWHK?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TfSQoNrxAxE07TZphObqGYHNzosfM8IlSg5C4R5h0YKCak2MrHhYe/YyfPiyFZUBpV6SLxFytNKjGBEQZqLlCjajgSpb4A5UoQWpL9hScGFxVc30R3hdlShBpD2vH2r4suOzTNJBMN8UgrnTNmP56ti/0cM9dkoE7m4/BOCxGtp/Pjtuc8jta38HceNtUODAO3pbn+u2/452QDcZuj4A7FyeHal14aqoUn0iHNf6G7AmrzJd3p6dtMw7H56Q1FY5YTEA3tt7JDr/8Ed76osQdvOUuCmhTTx6xHzjpjsj2vnqPHDWXbSDD4SbM4x3ZcBISMChdRwBZpqOn7VMYLcmqk9QHPf5y1dpQPVRc2TvBa2yK167pSJU98/38xTP1lTXQWmY0DEoXzOD56IWzaLUN8rDGDRGAx8xtl1TysxLTOZ83RTk3F0EeVtF3SEEfLVYCEAUzVDXTmhEdgimSv4ONQO3JWS+FUFzkRrD2r3PDP+OMi76slkoox/BvwaWoumU+9Cr6Ns7vK5MUYY/uj9VxE8pfXsKwHmiB3nT3/BG0YaSfKOTpvA39IsRPNtShnHXa89ufUSaTUzDYxV5OpmNXjUDKtR7KgWyDd8AVRcM0eJITZtD7T8FAeHdx5p7RbG/
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:41.3476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728fa634-0224-4995-87eb-08dcb566c766
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7384
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Added an accumulative hashing test. Checks for functionality of
the new hash create, update, finalize and free functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 tests/unit/test-crypto-hash.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index 1f4abb822b..8f66ad4115 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2015 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -241,6 +242,54 @@ static void test_hash_base64(void)
     }
 }
 
+static void test_hash_accumulate(void)
+{
+    QCryptoHash *hash;
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
+        struct iovec iov[3] = {
+            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
+            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
+            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
+        };
+        uint8_t *result = NULL;
+        size_t resultlen = 0;
+        int ret;
+        size_t j;
+
+        if (!qcrypto_hash_supports(i)) {
+            continue;
+        }
+
+        hash = qcrypto_hash_new(i, &error_fatal);
+        g_assert(hash != NULL);
+
+        /* Add each iovec to the hash context separately */
+        for (j = 0; j < 3; j++) {
+            ret = qcrypto_hash_update(hash,
+                                      &iov[j], 1,
+                                      &error_fatal);
+
+            g_assert(ret == 0);
+        }
+
+        ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen,
+                                          &error_fatal);
+
+        g_assert(ret == 0);
+        g_assert(resultlen == expected_lens[i]);
+        for (j = 0; j < resultlen; j++) {
+            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
+            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
+        }
+        g_free(result);
+
+        ret = qcrypto_hash_free(hash);
+        g_assert(ret == 0);
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret = qcrypto_init(&error_fatal);
@@ -252,5 +301,6 @@ int main(int argc, char **argv)
     g_test_add_func("/crypto/hash/prealloc", test_hash_prealloc);
     g_test_add_func("/crypto/hash/digest", test_hash_digest);
     g_test_add_func("/crypto/hash/base64", test_hash_base64);
+    g_test_add_func("/crypto/hash/accumulate", test_hash_accumulate);
     return g_test_run();
 }
-- 
2.34.1


