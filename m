Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E73BC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmk6-0000OK-6S; Wed, 07 Aug 2024 15:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjk-0006uE-Sw; Wed, 07 Aug 2024 15:54:23 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjf-00022S-59; Wed, 07 Aug 2024 15:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060455; x=1754596455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KamPwgkJhAqnJOa0AxKEOygCyaYuLI4pdSH8Qh//SW0=;
 b=qpynRJT+qWsrbCge4e61G7PR61ZqngausrCKwk+CixsOODVO+JZdBpWb
 XAWKq5U2xbY5Zo0GoaZEHCSPYa3hk0qOKxQUOQoojf2q9xs5x2TYeGLqD
 pZaO0IXm9IqMe37RQ1iBF1PZVEG1DKUfWGP362QnfhYY7EGRvMScUa/jJ 4=;
X-CSE-ConnectionGUID: vQYz3fHKS4itxGNOs5wJ2A==
X-CSE-MsgGUID: Fvt1An73Tbas5PhRxxX59g==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq9LvBVekwKytb/l7n1mk7FestORe5yYLjj85PQUTTvddFOrBPSA5ECT4eAxwRoAVZGq3kDR4YkV8N5EOwX5z31PtRFnRQwAvDHnOT8wkJcGABy6k/1gICdtz4T0ULtO+c1AwKlkuSHSU/0EcNTWNn23hvCLCM9orMvRortCLHCSh05bShgMIc47EyikNcfrxQASi33NRik0jPXr6Ey4UANbFyMkyZMhqk9l8Vel0V7WPX+z8T1xH6kdSC01OrFVvNlkEGs8DahFm8rtoCyB6ECAg7+sWhlq/LhFgwIxzBJj99lTn+o9jopQDK0xtnOfbo9tWOUI76GatMyejC3cMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LZQgG3LhCRZlwmuEIvxU1SEGnAy6go4gkyzKK2W9vo=;
 b=UrrFAUHbb7WoYLEwy9oQa2Za+Hee5IcPDSSQRH8QNrIwIHoeHoUyuLC3m23+3EbpftE6bHOuS2sm22j9Vza6A5BdP+7NQ4LosRGiaybqfLfYpGLTqK2SQai4IBFse75IqLpec2zcgLwiDbroLiKrJjlnRxRkpA4SQhnN+ugvQ7S3f6x708yPtsrEuGI7tdE2jWyx+1eWj4tP2oIos4Uy0L3gYy+DCBhGldUzkJhyJBIPGi+nMaCAaEeAfErpIkVVk12R08YRrqMq1bJOuK7Vqi0W89VQI6Vjc4kgEFKNc5jnvG/r09T/V2EfeXpHUEQxJ8efh5x6LcLVHWxILhc7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LZQgG3LhCRZlwmuEIvxU1SEGnAy6go4gkyzKK2W9vo=;
 b=euRfBEJBqSm1Z5SwbMqFaDFJXiYT6CEuaBPqQOZ/cp70JVqpkdaD7d8JiSS8JjnccnLwrvjaiIzIaT2p963vS6jYF6I4Xjx0Rr1WVuf5R5q9ldLPn/8N3J8Thj90pfVd8ynJLY9wWsnXSgslaTxeLSkl3RbHYWwtgPcZ1CR7BZQ=
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by IA0PR20MB6310.namprd20.prod.outlook.com (2603:10b6:208:40c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 19:54:09 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::8f) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 19:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:54:07 +0000
X-CSE-ConnectionGUID: s1RO5+RXTBScEuxHYaJ03g==
X-CSE-MsgGUID: 4gWKFwmfRFiaQkAtl/bfCQ==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:57 -0700
X-CSE-ConnectionGUID: wNZwF9xmRpq2p3sxadg4LQ==
X-CSE-MsgGUID: Ab4542qzRSSQDSnjjuthRw==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235487"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:49 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 11/15] crypto/hash-gnutls: Remove old hash API functions
Date: Wed,  7 Aug 2024 19:51:18 +0000
Message-Id: <20240807195122.2827364-12-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA0PR20MB6310:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4f27331d-a309-4637-ebe0-08dcb71ab34d
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8yExfYVz4lsbePrKm63FWQBuvVAXfUxpvLj6r3Qx+1miPqW2UXoDXvL4jgd9?=
 =?us-ascii?Q?On6Zzkz248CgQKHWT2qX2+9IDaymDhzdru2mbfZLukqd7sm6KhpH9npVgF3W?=
 =?us-ascii?Q?rmNI7/zdJn1newegzjPEb1Z686ooDq6aBDo75sKH39SdDO4i4Zu/W9ignFlS?=
 =?us-ascii?Q?WmIwElWxiv4XF+INgIg7DCA3PfrjRY3oseabxeEEoK8XJaDV0ETPKtW3NnWO?=
 =?us-ascii?Q?iMsKjhrKGxeaVJ9Ib0/ngsCXxAiCW+D/BvUt9p+uCfX/6cmRD83OI52Ldh9i?=
 =?us-ascii?Q?9dUugTJubWaqnvmR5l6kdL3F60fIbybvjSkiQft9aVObC98sLi3FmBNZp7QA?=
 =?us-ascii?Q?p+LGShf5wAQSqQmk6zvU/cx3DQ3zL8Q6pKOQimUu+953KHHRIJ19GlfgV6qY?=
 =?us-ascii?Q?JiLnrMW5UiQUc/lMjgRnVmEBVOuv1pp7I9ENw4cIYmxf4cj34KmVzBmCo1x/?=
 =?us-ascii?Q?7BrHcMa/N5aRM+T1wIliF2c0EihEvISI6tqeQG7hNxT5LGd96Sduow7orWo2?=
 =?us-ascii?Q?AEazHfRgSNq3wOT+DP8sj/L9f848ndSSM6ph/fYV21td2od7x36zP6UK4/Hp?=
 =?us-ascii?Q?qHDsgJG8ayoVWd3USoWe0iTKshC5KkcNPHUImeLqO04mRGDQDXDxDUyyeApk?=
 =?us-ascii?Q?t7zQLMZ7R+ajTIqqmA6L415BTiEF91dUz6KIWxZbfkZsopLvEt0g3FBMn+wK?=
 =?us-ascii?Q?Ute5yZy+B7z8g7L8wzwJtmqn5/03WR+5IrJiJInxTrLJwjH/+rNFrvmXZb3z?=
 =?us-ascii?Q?PJdR5+kBq3bjhRPtlNiLbWNrXkR1OivwAfXW+ZvjJFqZ8fAuuycoS4A3tW+k?=
 =?us-ascii?Q?ar3zLPS2NgTQ5SrPDi1+3TchKKwqwDHKGQHP5ov7utB2Azt7KBQUp8/oLg3h?=
 =?us-ascii?Q?7rjRxUlEmrwg3eXUZZTyfdzd5kId2plFzw4EyyCxg3w0mMTSvth9V2ElTGr7?=
 =?us-ascii?Q?Q+45zUJzhsKJ/qnzD25/Vqo+5iKrnVbHAz85bxQDcYk7vHCerBeMfTX12a/i?=
 =?us-ascii?Q?6mpa+uyG7Qi+UiQAWLH/spcO7BTs8ZXhDb31VZT9R6gjjmDrZSnLSF/TM8id?=
 =?us-ascii?Q?gaCtDcbDafNCH0ZkDG29ijdwjF6ovRj38lWl/fn7Yv0RDVYrAC+JL77sKTd/?=
 =?us-ascii?Q?0ZE1NdGtABPJ1Exg9LidKFmoJ3bh6vP3hZtVwB2cY+Pl3j65o5kIAGwtijBW?=
 =?us-ascii?Q?u7Y8Czzc3Bl0uludgWsC8akXoTUOt+Mtq9P0ItMP9ByGZObUGDQ90WyNuhlM?=
 =?us-ascii?Q?bSNtvdDCWv4mGQzX/u+Min7Wce2V4b6jFEmKDSjhJ3YiAoSbjnTusnyfXtky?=
 =?us-ascii?Q?3QOs25p/7mfFuUFYEFTHshf7/eaEUY0MWd87N82AaBCgGsiN6v/+sTXeFGiD?=
 =?us-ascii?Q?wu0P2bUEOEUEuT20AfVd/4IkOfUB32DaLKrqWXoeWEOWTqtkaF0a+z9CKBCk?=
 =?us-ascii?Q?jNuDMV2Bd0e6XUn9jK0ETV3ojAIW5+sv?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HXVrcieEZTl9xLprygAB8vLTsRal0pDF08SCLVhnhDrBu8end7YLx5Wmq9+Ij2kGqbkZtKMN8M0rSMmQY0OjwbbDYqHiT8iYqEmgPaISKnPdKCYtb8LTfcfS6npOAgFgdRUvsU5NQfoPeEQlsgPCP10z+LMrP0MrZGWUy/NZqLBSE4e9VBn+CdtZFmaOhXzv5hmQtaDNZpbTXioNSPbGnoVmhxPzgtZMSA43OTz67S236f8C1UlTMzQ+XI8cVMKTj7TyD5ikHHq2L/w0SpQ4b0lDT3yBZ2ClqGUzrsFduB/ZeIUjOnjwiaWgzFOkNwkYpqRKccR/jNyu6WkKNs/pqUU5qWBGxLNgLlFGmEbS492NvYgtNoTJRzmbhuTmSlqdllXOnjJgMykKGngQEA4mVzMC1QUq+xPJkx25iNRrCYzSLpTmGHjZ9MDPTXlhyVIiT2NURZfIvHVgLsbFR916tyZCKB3SDUoauapi3lguuT+l5XNMU7lDnnCtl9ka2Ns2mM0qLjAq+A59qV+iJy3xSSnmuLiarA+X6YW/AiY+O6CQB+iRN8sCgYrkAQgTx5n/yzgu18S5OR6CqFpQJKtRAM8WrM9NOuAgH5mqqSBNMOwuCs6+tJQdk7PHKikBlNMp
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:07.5341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f27331d-a309-4637-ebe0-08dcb71ab34d
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6310
Received-SPF: pass client-ip=216.71.153.94;
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

Removes old hash implemention in the gnutls hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gnutls.c | 47 --------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
index 15fc630a11..0c24b0eb66 100644
--- a/crypto/hash-gnutls.c
+++ b/crypto/hash-gnutls.c
@@ -53,52 +53,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-
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
-
 static
 QCryptoHash *qcrypto_gnutls_hash_new(QCryptoHashAlgorithm alg, Error **errp)
 {
@@ -169,7 +123,6 @@ int qcrypto_gnutls_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_gnutls_hash_bytesv,
     .hash_new      = qcrypto_gnutls_hash_new,
     .hash_update   = qcrypto_gnutls_hash_update,
     .hash_finalize = qcrypto_gnutls_hash_finalize,
-- 
2.34.1


