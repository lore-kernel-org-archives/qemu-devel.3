Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF0C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmk1-00087P-80; Wed, 07 Aug 2024 15:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjj-0006pb-Lx; Wed, 07 Aug 2024 15:54:20 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjg-00022d-Ua; Wed, 07 Aug 2024 15:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060456; x=1754596456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RYDTlTtZKupLWxJ53d8EM5+2UmUIrTskgtcJ/stxq3c=;
 b=pLVagtDFoYEE4wtxoY3pPPL7/Vo19UwP/EJOMDsSCqqqiAsfnp6kDfyi
 6qfAABx3DSxe9btOSfNMy3VU36vVkxfwwzKoDNJyKj6mlaFMtDXFnx2Vd
 li59AjDFoR/L6v40bUF7FebtR8S4HbcHEJaqG6ampPz450V+1PHaW9LB4 Y=;
X-CSE-ConnectionGUID: GavfiKbORFqE58+9C5cyRg==
X-CSE-MsgGUID: 8lgvRqiaQ7q4m6BEYk1Q3g==
Received: from mail-bn7nam10lp2042.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.42])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1EctYI0FDpDyQznCWtjSOWZ2ifQclgBaMpgXCborw5J2njAm00IryZEUFp0XFTnZQbaKd2zYrwxLD8F9mvgw3DP8i4e7hovfii9TTyHdTRe4dzi0YJm2rSXg6oDC6BWk/ATwRMRkUocDt2EvO9ljTQ1awJEmv2V3Mc7SDe0G0gShAiIBqntdkAE6VU/lRYUGYA77qTCTrkkEgvaOgmHYhVKNgR6Rq4fkNKlfbZ349CxaArCVUzR/kkjm/GHhJn8YmYqliCC4sC/B/uPLcJj8FSny3emKmqkH2APGWR7d9ZVl8rPYUhWzWbxQeKvumb7joTGPUO7FsBgxJzr1sUadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu2PKmHBKNBvvAMDAMMjT7wALe9phLXftaB9PBEfcj4=;
 b=gjnzg46YSEqIhhBwhUN3B/FWm4WdFYZMKbzGwAP2HtgrHw38PDufSwYyIPLvraqDEGgjc2Ob2XwlSt4OA0ynFglKOow6Xy62wWzC3+eWHdpl5tnLP5y5ALhJzvDNTVDaUlpvZcmKuAb8WsR20+mjC7vXYs7zqFMHANhpj6Mb+PQyApWLiXBuZ5xLeRtdsOmDBMBlf295CzI/1YFdaJyhtJxVikj69JNxec538jsphrvldWjREe1UyEZse5xJ6GVQyAQCSbKECE9JW3qixLMCpXnDb3o4KSteMPgKCSCGYygfNbVM1IPyI2veQLcMjLnnzeZGucMSuDz1Jq0cyYzf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu2PKmHBKNBvvAMDAMMjT7wALe9phLXftaB9PBEfcj4=;
 b=Vl6blGzrkAnbtzuXlGXslzV36e9xyNcPMIMmgrfg0+fvbo8FuV8YVjTDu2AUFxyxZhjOLr3aHwkuu8VTt2sTPIExakUqQA1LiIof5wRLLsH1kpVIvGdwLuarthURqi1JPNBDC5XMj4LGVXFhunDUtUkk0sV2V/uCdiOJ+ncZ4Zk=
Received: from PH7PR13CA0018.namprd13.prod.outlook.com (2603:10b6:510:174::22)
 by SA0PR20MB3343.namprd20.prod.outlook.com (2603:10b6:806:98::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 19:54:10 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::10) by PH7PR13CA0018.outlook.office365.com
 (2603:10b6:510:174::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 19:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:54:09 +0000
X-CSE-ConnectionGUID: iIln6l1ZRvOUUH/w/TGY5A==
X-CSE-MsgGUID: Ll+BwVN2Q7uWB8LcViGMtg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:54:00 -0700
X-CSE-ConnectionGUID: bsIny87pRxqmqGqRGmTlzg==
X-CSE-MsgGUID: RFLrfgMHQJKRYUp3z1b1tg==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235489"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:52 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 12/15] crypto/hash-nettle: Remove old hash API functions
Date: Wed,  7 Aug 2024 19:51:19 +0000
Message-Id: <20240807195122.2827364-13-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA0PR20MB3343:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f312d229-9ce8-4ef1-7b96-08dcb71ab481
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NipDYk1yZZ8JdNiqE9pcEBBy55EzGSGOwxH6NmNfnj80bnQuGicFZVZEitTM?=
 =?us-ascii?Q?Y0yObXBRB1hEF3xefAtnGzvqn771dxZ7WWQEg0fRAvGpwSa5JGvwoit2FRwe?=
 =?us-ascii?Q?e5S51il+SoCoxMaBEOWXxf6XfIS3IL5Wv8EkCc7jZpHaHAYN3r1aXnQdChxz?=
 =?us-ascii?Q?mq8ODQojd7/OUESgFN7coWL1CtbuAP5J++mE81AWAR9S83tg2d2t9VraktuH?=
 =?us-ascii?Q?INxsedhiLyvfHFcwiPhBegeiRrQszJMELH40slHHbbYbIHiMZYOMQeB5fuoB?=
 =?us-ascii?Q?AlI+Othx3czGUue7503xUHfYSKUpPAGQdrHHU/kkpIvxEwVA54Q4yBDollO+?=
 =?us-ascii?Q?H82CLEh5Urg42Xop+w/pf/+MQvBpvNNEZlgfWDlq9/2lWDhpdzWVIAgFX+KC?=
 =?us-ascii?Q?aybXqaRsQtEOyqMv1WrecpclK1Q6CkIVU6udNRedA2+RMpG2u3JBPnMvdoJy?=
 =?us-ascii?Q?2l/iT0WsryrTi5C/uhwstHOeHJLKOMYL5mX8SvLwZu3X1QjRmq/ywMLPGvxB?=
 =?us-ascii?Q?Ap8z0XRYeL8rlGhjdJVs+ktRGnQ4Gzt8iV7xJM4mm4kGnqkHStuzpS/lGYLO?=
 =?us-ascii?Q?/swYjZShZGL6B9f+JkE/KQv4bzH4Pina+gOgS2NqPejBqNX3P4rwmagXxSCJ?=
 =?us-ascii?Q?5AVR08zdUzjY1zWIrUJlIGlo08qvpA58GyXm8Bd0TJ04rOWAElolmmxDUTg1?=
 =?us-ascii?Q?0RgPuYwH7Hdb0y4jMW94lKOlTf4VtGbSJIIGNfXMqqpOP2jArXyJSzsf3pkq?=
 =?us-ascii?Q?p4NaOJEQjAe3APZNzxuDIcUuOC2h2Y0c9FweqVrOPIC/6s44EEfpmg4+YHZL?=
 =?us-ascii?Q?P2hT3eD/e6h6oEkylnRILQPVJPGHL9ZDAOOKEf7lWcpc/4+cmnr+ElBIUhaz?=
 =?us-ascii?Q?QPQsmcWuOWhOIgXLg31FIWR32H+lQSxlrRCMiQEERxKHT/M8wPMyLvGwyHJQ?=
 =?us-ascii?Q?0HtKHYMOGzGfnCLHcOUiXkXX05t/RCCx25OVjsfFAIxltn4ArDgvu6S5aViZ?=
 =?us-ascii?Q?IfSulG+oimgXIvw/yMxiTB84JuhU8dTH3uFAwsiQYai3sS0qQJfH5tgul936?=
 =?us-ascii?Q?J0XI+lM3xCYSEZw8BU55rP+iKwB3+MVLWXpAOEoqRjrnHVGF9rxaCxmTsUDi?=
 =?us-ascii?Q?wMy36nVKeHJFTIlhHaaLQiK0dZeOluHh2bjVNAOjl3C6ZlzL5JYeuOZ0xpGJ?=
 =?us-ascii?Q?3vjTbPSq71S75/hz0ZfiqoAcKE+Q+KNgbeZ6A/KW0slcQnTtha2JZ2NcrrNz?=
 =?us-ascii?Q?U7kMNF5Ssc9nMw4BbM1HrlMZFnpfvBwGiUVbB5hqAAUnrpLoP4g+Xq3Z9PoW?=
 =?us-ascii?Q?CLa05rM8KyDWhGF/xdtsch5E4h8Zx7w81LG0b4HKZE4csg5BEQM1MH+8bp/l?=
 =?us-ascii?Q?8XrZr1zP1t5l6IiA2h2YUIKxGbEKKP9P5+FA67OeIYkljK1Uz3r17gcSMmiS?=
 =?us-ascii?Q?0FWB7aEmd0/vGMfayc3ItffmSAn59INm?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UQjQ4qMBah4yZVz0tKS24IyYN3FuzwwaLdQNJtmmprPP0fQN8TP1HSA985B8ZmQYucq6DFPwxFYUQ0NWpKo1HKlT94aoyesHrcID2xwwVtvsRP3vH2GD8lJtHsPnSBKtyX6/n3s19rtEfYWEDHY9YdSuN2ruZQADJee7Wd9iGdAO+RdBOmp3ybC+CsrAoY2zsnpP2saXM9/yDG4O3/Jhymgq5IB9Fxiz6Rd8eVIoB4QDfWlOXzgPLNc5a8fd/qLLaVSNRIA9v65kzIy/TYqNAnvzUFFxuDszuvmAa0ZlOkuv7cswRECVYBmO6W80/qT4SqTiA5YmfFFO26REfzo3/CZnzBiDXz3AgKpDVLXQHV1hj0bK+BlVshNOAOisnN5rnDzhNxf7WLrGYxMJIZr9AJMpdYNOgUztZZkecRHlrObBe5SefqS5MFe6+1ftMnA2wVzYDPlHBRvNow93Dg9TzDiIJPk530uifq04aTPg/szbKqQYbk6lki2X+sM0gX/q1JHBneTQ3waf9dQvWFMncLxYfvWQ+Z65beIZNtmYqfOvciXeK/pcA/CNq7m1X+QsbqknUS7V4j3BUEub2+nOAswRE04fH0u74LIIUrqzEhgn3Z8gL6V+X00DDRAVzwAM
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:09.7841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f312d229-9ce8-4ef1-7b96-08dcb71ab481
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3343
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Removes old hash implemention in the nettle hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-nettle.c | 53 --------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 894c7b4fc3..bd489f865e 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -104,58 +104,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-
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
-
 static
 QCryptoHash *qcrypto_nettle_hash_new(QCryptoHashAlgorithm alg, Error **errp)
 {
@@ -230,7 +178,6 @@ int qcrypto_nettle_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_nettle_hash_bytesv,
     .hash_new      = qcrypto_nettle_hash_new,
     .hash_update   = qcrypto_nettle_hash_update,
     .hash_finalize = qcrypto_nettle_hash_finalize,
-- 
2.34.1


