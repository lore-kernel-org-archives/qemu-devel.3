Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159DAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb01e-0000qq-8t; Mon, 05 Aug 2024 11:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01c-0000lN-P7; Mon, 05 Aug 2024 11:53:32 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01b-0003ue-1N; Mon, 05 Aug 2024 11:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873210; x=1754409210;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4aukmjNZLOYAUtGh3i2jsQ2Ta316XlPTZ6e/png8yXw=;
 b=q0nqhhcpjMojovnubUxHCnexj2Rvu7EphXV+WFX+q/a0Yt/ZqMziF58I
 Z0yDFCWAT5Gj9/HvXDSWK+OLrRPrIrqwcIiHn0gieV0yUOS48iLEwZLo5
 4j3xJ8ikmUVtMvlITCxmX7NL9BSM+3LTUHloGbNCv9NyF4NHWWKMwv544 k=;
X-CSE-ConnectionGUID: fVVPxabRSmq3Fogi8cCMSQ==
X-CSE-MsgGUID: iY1dCDbHS0ew1Cnza3M/Wg==
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN6mo9jzFA/8aS1pdFLLcA4BcitUfRgkRDxCjEMxIVPrsdDHGY05m8SxAdVhB9HcFGWxEOa+scA/t/WW334YsSoy/MuL2cCCozj3ltFaXdqurSIRp/fjy6YkzDS+EVE0/X+cFMnbWwDhJmXK5cudwu2c4a82263Ie3V6KUKCu5Yl6O/4nZEuofbU/D5o54VnnhTNQEwfGSAWg0eIKSiIBpoNuAFkpa915iOfbTazAmPPDd0wezD5BqknBP92HIrl7y6qBFWvJ0MmKQqUYsDdudAVHSjozKBSEiVUkGRNJXetDQwuxLRFpTCzzSJzxk2MWcqi07kvITvBEEkzxvilFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFbr4IDJWHmLiqfirPbZROscpP9gK+D4QLeaG5igLvM=;
 b=adabS9DOYcLHdtoyJ7WvP6hs7/j1gpAy6z6x23vsygAS3VKiv+o+DWpRtRvxU9fB5jDq0Oo1H2SJwYf0suyuarwiPBkZJqh2g8egcWjFCb2WPhDo/yjoTOBmRf5X3jN5DGVghge+bo4khN1CqG2IWanerl1Vxe7b24v9yI7Gk2pSrdWOHBInQi7ITDTBkDw2qlRL3djEr7uQOyHud0KZb6N0pN71OZev//ZrIvPPVaz22xNba/ehH4XOrvPM9QLi9pO/z6blKA+NZjxSe0Cv47dk7YTWHfcAwcnHflzwdQZL6YQ5IaVthBEwSnh+wyN9X4CKBO8Jl8QXzCfZzp3i2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFbr4IDJWHmLiqfirPbZROscpP9gK+D4QLeaG5igLvM=;
 b=WN+uSsyEY8xrcaVcF+qFZQiZw1I+k47BGgWCHKOU5z6O6dZ5QiVXrHckkXptCsogV1YsqIw/qU7LWQkB9zxg30RJ2KLP/4xYELc6rlbuitfJt6t/MvvOptN1WdiY4MENDFlgTGbaJm0rPz8KtnOYOBGgpD24yCcx8+3wckjD9P8=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by DM4PR20MB4703.namprd20.prod.outlook.com (2603:10b6:8:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:53:25 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::10) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:25 +0000
X-CSE-ConnectionGUID: HvL6uwxhTk2Nv/k+vBqFbQ==
X-CSE-MsgGUID: EJxyGIaKS3a+sd+FY+GxJg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:17 -0700
X-CSE-ConnectionGUID: Bx2ZDrgjQWmJJzBBXPfnOQ==
X-CSE-MsgGUID: tdI0H+YfSI2KqJcCIRL4vg==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920700"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:17 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 08/12] crypto/hash-nettle: Remove old hash API
Date: Mon,  5 Aug 2024 15:50:43 +0000
Message-Id: <20240805155047.3151540-9-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR20MB4703:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a690c78c-30e1-422b-0b76-08dcb566bdca
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yhKxJ7qREN59huyooQCyvbPwT0cHqSRqZTUdhno0vdrSkiCl11girYYlihtP?=
 =?us-ascii?Q?v03LHsH06cfQCGvnmnyKfeebU0Sgq4RedQEeuovdgMThvyPnyq7BmRrOkhwX?=
 =?us-ascii?Q?bHxU0pIqe19D21B1faY/pvyuMQyyRR1jTzapMXj46+FaRPwvmKhtiFEl19Zc?=
 =?us-ascii?Q?z506Z2SHmRGIwZUkx75XN65g6ftd5NMaHsoKXoai9Ya6myvfOhheFyzW5vZ/?=
 =?us-ascii?Q?u8IdL6kvWOIrfJCi1nRId/AQmC9XnQnL00e80xp0WaoTFYBOJoip9Nalp1bu?=
 =?us-ascii?Q?zYLc2GCbT3Dxj5vHoO1nI+s5fqewl6mn2pdFr3E3MtsJThzNGHKBJteZE3y7?=
 =?us-ascii?Q?s2WckXKkk1HiMccE8Sg7zOptzThdCbVyjdn1sXr4EDOeJQ5LenPBQ94zlq3i?=
 =?us-ascii?Q?6fVwWg4Im9WPIab/CpgZVyZp3ugjQMsqHDNppjt3vqZ7y5LfuMR88ZpbHqCw?=
 =?us-ascii?Q?G1yjFpwCqW3faUdwY5g/0OjPwbYHIZbtRasAaYObrSvJZz5kCRvVH4BJ0glJ?=
 =?us-ascii?Q?nyoZ8BRdgjAUdehWTYEj0nQVeBy5E7uT5qcyyHEqnvkFBP1ZgtpyhMzqPnX5?=
 =?us-ascii?Q?oIgHNI5p40e1aurPHCBLmTD8DWFFgPRjpgZn3CG/k8CiDk1+yzxBSNoIikBD?=
 =?us-ascii?Q?7OB77vF55W5Vu03YoBoJYmrF306F2RnGJVhP3BxvSWJukztYYLqcsrjcB6nw?=
 =?us-ascii?Q?V+3RbW9IwrbrLg+LI9JdUnpCZ0a/QQeHcySAC64+JwXUMwBu1HOt28dO5Oh+?=
 =?us-ascii?Q?s6ZtYoJKDbD2AuEwNWWWaM3TdCCxmXxfomhs8EWclz6iOhPq/8RazvfeIJij?=
 =?us-ascii?Q?DxPtxOZgCaTQFefmNmHqP6PW2M0cGKKQvu8Ze7x87vKR5T75i4rFRW+tiMCo?=
 =?us-ascii?Q?tFMCmJari0FrPygdkmIZ1Z88xJFeccfq5Fb31pxIsbR9tK/LpnqsjPFGjqrF?=
 =?us-ascii?Q?d9z1QT/GW6zBskPP9mVjWw+suEE18ijc5DT6swFWIZdzR7duzEu2w2uWoNdR?=
 =?us-ascii?Q?7HVAtIABDYgGQybWF3Y+fd5j/S2mGr2HI5uQICioIv+2QBr+csJFe6+2qjPp?=
 =?us-ascii?Q?HUsUE0UURqy2KwndnTTR/y6Plb9DTtqNmh7HZsWDB4OTWIknKDwx8rOPXXBf?=
 =?us-ascii?Q?1RovfS/1HdGQVm902BSoUqwbXXSlyvF9GBK8NjqbQf9tIoJWG6glhM+MswKt?=
 =?us-ascii?Q?2zvR/CnZ9hh7jtIdMAoqi4It2SCUNhJZ5DeOtu7OCjoGOFwK3ZXxmCV94GSO?=
 =?us-ascii?Q?tEik8Z3x+chYm0RK+yocYLcSUWurtgQilDoBRgnKfRlGmcKb4jR3vvwYjQFt?=
 =?us-ascii?Q?fTjTZ7I5Uu5beo+4Hh7Su9XFTzfPl5D+RBIM52jjaU3D21RuJR3LrisZEU7o?=
 =?us-ascii?Q?uFXrDCWTjvpIyG48eY70ngosjS3LL6jSpOnz3WW/6Pxf9/ol8nkuWI7MMQ6z?=
 =?us-ascii?Q?gg9uGaAqSmZ9ONYdQruT5K+iipVfb2sC?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sLf2isyrZv4ZG0zYd2hXdwpcElLbgFEam9IRzWjyeR7pQNoTdvKjQIAxEPypD5lmqO6EzvL0phOweK+kCaF7bjGo88o/GvBxGFQUI7qU87rBd0F0w/X0KxDZwlmt/53OJfNs1KpBm65ea0j3v1nps8azxCLbMrvOWdC36XI4HVx56VEf0hyG+yjWPfJUFy4GF+pZgsyPSOZ7+vsF6OQdgmsetW+P392SGaKVgJvbvYLcLJU2Di7LIpg+PZ7BoK5vmoaM7Y/A+hFQqdDhFC3vxAf2WlAFBpy+8GQCj0dePwCLHcaA+zcYyuoUNfqrnBsk+sc9GtRCfx7ydOOB3DATi+67D3bmCyHcN0rASGblTM34UgthViRV49eFcY0GaFIkdAUIdXCiR4prBIO9Gd/tuQRQfg+CeEuSzCbV26V0iQu/F5mUizgq/lTcpWSOrIArAuFdWIjsWcBZsmK9vd56tXuwjAuMQjHDGQiQrzckId7+wbukNev6ty3oVord4OIfdWxg5+KBFwkccxSK2h+Mw/5WQOhJOIyvDsMbVNzjiYFA0IQGX0GQthlHBCd+gUJiagHcaT6ICXeMxJUfPXWd9AMICeX7h6FPMLrIlEFkMhHs8j5dtK8wANXETmZZqXGS
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:25.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a690c78c-30e1-422b-0b76-08dcb566bdca
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4703
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

Removes old implemention in the nettle hash driver. Will
be replaced with a new implementation in accordance
with the accumulative hashing changes in the patch series.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-nettle.c | 52 +-------------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 1ca1a41062..dbf1d96dfe 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -104,58 +105,7 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-static int
-qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
-                           const struct iovec *iov,
-                           size_t niov,
-                           uint8_t **result,
-                           size_t *resultlen,
-                           Error **errp)
-{
-    size_t i;
-    union qcrypto_hash_ctx ctx;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    qcrypto_hash_alg_map[alg].init(&ctx);
-
-    for (i = 0; i < niov; i++) {
-        /* Some versions of nettle have functions
-         * declared with 'int' instead of 'size_t'
-         * so to be safe avoid writing more than
-         * UINT_MAX bytes at a time
-         */
-        size_t len = iov[i].iov_len;
-        uint8_t *base = iov[i].iov_base;
-        while (len) {
-            size_t shortlen = MIN(len, UINT_MAX);
-            qcrypto_hash_alg_map[alg].write(&ctx, len, base);
-            len -= shortlen;
-            base += len;
-        }
-    }
-
-    if (*resultlen == 0) {
-        *resultlen = qcrypto_hash_alg_map[alg].len;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != qcrypto_hash_alg_map[alg].len) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %zu",
-                   *resultlen, qcrypto_hash_alg_map[alg].len);
-        return -1;
-    }
-
-    qcrypto_hash_alg_map[alg].result(&ctx, *resultlen, *result);
-
-    return 0;
-}
 
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_nettle_hash_bytesv,
 };
-- 
2.34.1


