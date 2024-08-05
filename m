Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF84C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb01W-0000X8-1x; Mon, 05 Aug 2024 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01U-0000Tf-8Z; Mon, 05 Aug 2024 11:53:24 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01R-0003sn-Pr; Mon, 05 Aug 2024 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873201; x=1754409201;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t8bCdwUF9kmwTPWfGbGtm0+1UnJsvOn5om7BCq0kQ1Y=;
 b=IoXDTw3m4haSA/xZtr+eszpMWPi/q0VhFLtLiPwwtn3LWyrLSkXPIySk
 qOS5HHp/aNA4vhbYcPMO/Km/ThquooPy6R6596C6KAIThpKY5W1K+zj78
 ccOg2WAFd/yn9hL8qeY6+z56W/QWplLDaWurGYytiZIDi3Q22H3rJ62Td Y=;
X-CSE-ConnectionGUID: cTANsFggQjO+lAR6Gjnm8A==
X-CSE-MsgGUID: v/EoU1A/RvGG/UdviDAAbg==
Received: from mail-mw2nam10lp2040.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.40])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcoNXgrOrh5uStsmNjqzP2pUw1mO4iFq94FZERqFsS8XjkuFvPfhIcrhQDlsXhF+Ewg94AJV6wN09ml07HNtHfn8YVKCt9rcZ5QkdY2ofmfQlmjooxFxnQamtCbWCVTBlj8svm0l1acMU9sDtJnlw9Hsx2U/wcrujEqp+dlFdRLQERkFuCESDGaSwc/ieJwUBX+2crc+PvIZmhz6X5rxbbUefuQJ0WNSRm+1WvM6fzlmuiNF9ccG4uwhwO0LV7uhUsC87jPP0L9OdEybJINkRs1w3DAVyI/g0dAX194fTNwV+V65n0PhS7T4ZGXFj61UaBN5s+e+en4trk6ZWGUPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUzGeR8IaTn1BGYcyb8C1iLOAOqxK+cVU/ApDR3f/6U=;
 b=OEpD6Fh5WTriaRe7SD3SDuGinyQhXiBuQjmEI+jT0VsesoPGD0uBVhOQLijGekJkh+blbLSGERZ+NJlvmVO5rKlCu4nXg1ES5XtoKNDUI/bIqwXYaMKs0OEXMas6uegssWXa3ZaSlMMKsEGS5X8CjGEfhlIJdLAvPc1lm21jbVBS8ocPf9q4l1gApyvmNMfNIaA+X9ge7nTGcnQCchmmeBN/dKmlCX93SwN5uGkUpqu2t09s0VwGIiisxsD3bgazTuedcHqWKVm/XExlH4rPcrA4+dPkXxi0UHWf2pwwbSf0IeXv0yPjEF+0Gu/m7OSF+z1pfYLLZmFUtnQ6HclvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUzGeR8IaTn1BGYcyb8C1iLOAOqxK+cVU/ApDR3f/6U=;
 b=d6v55r+CpxpQgWU34IQ4nzRLqrOGROH4Tma00EytXbB2MDnW5E1s6X98jFf12OmDzPd3ppuWOboPS9YgBmbXv/z/mJjMPBmeJRc/rBfXUNMb3bZ8thvJkOSMGZrlqTAl/sMaR224Jc3JEmujBkxOX+za8Ema2JtrrBuDkZvcwBo=
Received: from MW4PR04CA0389.namprd04.prod.outlook.com (2603:10b6:303:81::34)
 by SJ1PR20MB4740.namprd20.prod.outlook.com (2603:10b6:a03:45d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:53:14 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::b8) by MW4PR04CA0389.outlook.office365.com
 (2603:10b6:303:81::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:14 +0000
X-CSE-ConnectionGUID: mWRiNZIvTwC+x24ud1Tvdw==
X-CSE-MsgGUID: LaYwB6S7Qz+G2LngFzdnpA==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:06 -0700
X-CSE-ConnectionGUID: ULM0OGYeSt+my+idKatEHQ==
X-CSE-MsgGUID: SdEreMh/TxW+qSbNQXVfRA==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920694"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:06 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 06/12] crypto/hash-gnutls: Remove old hash API
Date: Mon,  5 Aug 2024 15:50:41 +0000
Message-Id: <20240805155047.3151540-7-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SJ1PR20MB4740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1843ad27-d465-43c5-2f26-08dcb566b758
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IrOmOvLKgomzspvIrghKJ9lN64wA+9cdMRXLHhT6mX9V/u4T4KtUkukYt33J?=
 =?us-ascii?Q?CaQn9kXFaJDCmcVX1Mz5ZkZ6qx53V4hqSlORV7qd9hzzmXO93vo9HuKFLCP6?=
 =?us-ascii?Q?Qqd4iX+vb9cqDDI7tqcAfB15MoiCRai1OQdUEFsPU73sH010giaUk1ZWRHoc?=
 =?us-ascii?Q?SPkF8LdBa/yMyuiHb1zs9mzyxxkMOjCZ0UQf6Dn55yCqxR+l/9cBkFQwwBzF?=
 =?us-ascii?Q?EVb+XJb816NYesRgdLTPeHlWJCDXMivNJIt12IKgwMdjeZb46RS8eBJ/b4o9?=
 =?us-ascii?Q?MBNfS1HVio9PX8lTJyppRybrRP0owmgQ3LMTpCKqhYLPfuUCcrunG43SAyYN?=
 =?us-ascii?Q?GCUjYKSw7gwOAz7MkECU8yqr+UDr6vkaCCLJTcMSwVllxYRnTX8GJou3hpvl?=
 =?us-ascii?Q?g0/gGS/5+yPALC3MrsSIfEbA00YthLxx+XcdlfIZAYZbt9zP064ZNqsmwza8?=
 =?us-ascii?Q?pkKTFAT+MeVqyymo5HBiB/xmaOIwOqeDEw5WSXsMncIKWrG1yTSAwmtTsNjj?=
 =?us-ascii?Q?82f3ezarE5UTIIW7iuHtgBGmeuvu6UIEjf3/Sl0UUvRG+OTqTosu/T4oS7SR?=
 =?us-ascii?Q?w19hc16/Wqw260TQDaG4S1d+NG95e1HtgUuNgGl1j+KTaujR27mu3XhUQHUK?=
 =?us-ascii?Q?9j7jsyUb4q1omagGELNs0FcOqZU/oZaKJfALc4jKcB1FB9+iBO3qGiFfNaWI?=
 =?us-ascii?Q?91Ze31w2T4+f7uxYVUqtLYDz3CCcq+mnHjP0HOelMA/aabhBGzBqrFOpm/vB?=
 =?us-ascii?Q?3OWki8FE0rLQ9KZWl18OO4S/N7fllzPr+S+N1aZlyK6wQvDA5qHbfpsP1mUs?=
 =?us-ascii?Q?VrUKiDHz0Sb3+2FFHOxq+yfKZsKpUZsBqCaT4ZdKc5Mswc8xw/Dy9vN33wss?=
 =?us-ascii?Q?RFR40e0f00iYBPskSAcx6Y/oanqUAFsN8h/LvkrkreUl5fu/HMM31JM5DVgO?=
 =?us-ascii?Q?MQu/xOI5lbSGM7Axg0g6b1ruwuJapes491gzU3b1YKc3CyxlbR4+liLMJFDe?=
 =?us-ascii?Q?cX2uHEGAzRvVePLqSkerS8/R3BlskXky8DqdiiPWkpt1tUV4gWzPyxEy0K3H?=
 =?us-ascii?Q?tl0QBA4WqipE2D4iV7AOHaR0JAKAXizQlSKAXXYju+GHgQEVo2se2KxObBnw?=
 =?us-ascii?Q?ErwKmuuDHldV7ncywKgaxi0lNgB5H9xzXZYualmCl2wjj6vUdLQOlv3TUlTP?=
 =?us-ascii?Q?wkQQvLbfOIxro+EfxsOIupBEpuHIfMhf8g/VeKrGTAcs4VRkRbzWjO/Z335p?=
 =?us-ascii?Q?7vPw44Gby4fZhYHu5gVZVaKLUVwk+6eySyPhDNNfKdUPQHZArnd7MDo+Px3y?=
 =?us-ascii?Q?LKEnUpiHRA0yYJGwVc1YXmFscuPlgUQ6t7WFgUkZQKbaNNAGpoK/C2fZxnYC?=
 =?us-ascii?Q?3pnGpa52rod2K3iPHHUkbGKJrtONeDe6ArdXukWvqxoi297/MPhi34DTd+hR?=
 =?us-ascii?Q?KjfRtKEFtI0EKExvXoJSr4Bez6ZnaOQY?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LchwE9gal3Rl1I/2lXGgm6alOAQf6q6z28ECj3L0Rubi1jt2QG5s8b+C4DUzWeOjRZJlFiZEFjC46iVSjRUGfmKy2eE+Cexf5nJfviPlfjP5An3bACCVwVU693uJT3LtpaZEG1eNCSCAOQfuO/a+wtwn/uhOCHx7mIVOlRP07pAyKxiSreYR1GHu6XJobJSH8zHB46CSaEjPDtKtrZFRUSvBlGTyj6T8LzzaMA14Ql/QVo/UwxUZsa4XkboPgr2SUB+vlA7upcUlrWLWruZ2bKn+GsZOElzTy9oNNvrK8Na65jEP3qtaxZAD+JBk0/AC9u75kJLWYRNkAS4rfdeJRKVvD4tE7bzFgkXodDcTMCk+XHXv9W6oxMGJOfrOMPjkrglf6VDpOTRuecS55gOXNtMre2C7NBfmeV6A/Okj3Ry8+GYp92mD20u7NAyJjjeODuvbvAIVC1w0rgVORkNi4DUjog80d6S86HVZDAzpKIc8Fk1ACjPSdBF/t7g5q+U+8UCo3yRe2g+MM7u3agYjMrR4hdlgB+dJv9i4J+QiY2ZC7Cs1ozy6R1fMGUyu/GXsnCLi8eKaQpRQ89DwTVLPeTtx0rOlgQrG9RaIW+j78X2hod8s/pfM0tZAUJjNlVD5
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:14.2850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1843ad27-d465-43c5-2f26-08dcb566b758
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR20MB4740
Received-SPF: pass client-ip=139.138.35.140;
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

Removes old implemention in the gnutls hash driver. Will
be replaced with a new implementation in accordance
with the accumulative hashing changes in the patch series.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gnutls.c | 46 +-------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
index 17911ac5d1..84ce7073f5 100644
--- a/crypto/hash-gnutls.c
+++ b/crypto/hash-gnutls.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2021 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -53,52 +54,7 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-static int
-qcrypto_gnutls_hash_bytesv(QCryptoHashAlgorithm alg,
-                           const struct iovec *iov,
-                           size_t niov,
-                           uint8_t **result,
-                           size_t *resultlen,
-                           Error **errp)
-{
-    int i, ret;
-    gnutls_hash_hd_t hash;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    ret = gnutls_hash_get_len(qcrypto_hash_alg_map[alg]);
-    if (*resultlen == 0) {
-        *resultlen = ret;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != ret) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
-        return -1;
-    }
-
-    ret = gnutls_hash_init(&hash, qcrypto_hash_alg_map[alg]);
-    if (ret < 0) {
-        error_setg(errp,
-                   "Unable to initialize hash algorithm: %s",
-                   gnutls_strerror(ret));
-        return -1;
-    }
-
-    for (i = 0; i < niov; i++) {
-        gnutls_hash(hash, iov[i].iov_base, iov[i].iov_len);
-    }
-
-    gnutls_hash_deinit(hash, *result);
-    return 0;
-}
 
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_gnutls_hash_bytesv,
 };
-- 
2.34.1


