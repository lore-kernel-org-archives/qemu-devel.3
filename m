Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F1EC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjh-0006ak-1r; Wed, 07 Aug 2024 15:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjc-0006KS-BV; Wed, 07 Aug 2024 15:54:13 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjZ-00021R-32; Wed, 07 Aug 2024 15:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060448; x=1754596448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VM3cfAv611d4fS8qqPwjlFNBX5wZd/DiLnCLj+0u39g=;
 b=i1N6rcsnSIOFEAoPqi5AWOu+8JqwGUBdivfImBKyue4tH08/JcGMhdWm
 06iSPA8fqwDe+j0pOarYTJSocjYy+5gIIH4GnfBNPkfz27mg0GmyrhZ70
 p/w0AJrDwwtX298ZlVDDLX98apex4YUgGq7RjQU0C/iOtovm7RoB5PAU5 8=;
X-CSE-ConnectionGUID: 0X4up6EaSoSaqtZsiBr3gw==
X-CSE-MsgGUID: RwzIFwMBTzaHTz1tfUNaPQ==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJPzbnVckRVJH8WJ0pgYQGm7tVxdL1BV/J+xCU+LNR7eSif0uj16aElk3b7erCaMbaBPNhGm9rk8SzZVZd1RPRWsXrF72MFrKx861733NojDLrip6t+BEF2jt6zdlnJ/OPGPidIxjrJ6F7P7pPg2MlUrFREwcnmuqfVKrWF3psKrAhqRNtiMqwhaWHyks87IXQTA3ZE6U+cAugeCJShd5i/uFB61CQpenaTssVZ6lS4TMvCKDXbT05upxxvBdlOcD6Y9LdLYPv+XeTQsfV6LO9q37z0Fm+Sio0M+pOc8FBYfkebpWt0nRVSwEOXrFWxP4yzERrvd5P5Xw83JnNpCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGPhLucTXBPP4AdnuPAosWQMDPTO5bDMEuP1lRFGOaY=;
 b=k/hJYITG4i1b4NAk7ZGfDVDDvuopAaGJIXlSyEoGgPdin+cYzp7CiaZ8reL/VZ9mAw/mssYlEV2hwgWe0vjYiNEw1NRXtzbIC7bJF+ukgZYMQMs0CFz+KZaBXQ748dXJEDH/6rwPXJICBwM2eO51miFP2d76r2KBMD/nSQcYIMW9QUJ1D04n4AbtVp1dl7krUO9VxA0bI82e17YBkG5Zc+HwQySUR26i2E/gnwM0EDfkk4A6QjSAsUbToI9ATUde/Omces5+VOyt/MkgllHqruRRNblby1+lycNEDdbFcDwOlqu/m1WaaYC4vMM5A06Oj6fq+P9tYS0VlM1RkaBrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGPhLucTXBPP4AdnuPAosWQMDPTO5bDMEuP1lRFGOaY=;
 b=I/Og1dCowlC99Zx8nNSJA7iGI0DMIF6znONqS9sW6PFnO3iE5nI5E/7zurZZBrY9iIweKCSywICbujVZ5pCyE4ByzZwqOJfJwaYadoI9JyXGg13izQKw0XMcqcbmLi7ONKDYe95uqwCpfqQlACI2L6dDrxVugdEynnI9BMQPZy8=
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 IA0PR20MB6824.namprd20.prod.outlook.com (2603:10b6:208:492::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Wed, 7 Aug
 2024 19:54:02 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::57) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 19:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 19:54:01 +0000
X-CSE-ConnectionGUID: z8nKl17XRbOU16gR+WJ2Yw==
X-CSE-MsgGUID: 4X1MfAitTFept7ZFxBm1Mg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:51 -0700
X-CSE-ConnectionGUID: 047zpor1SMOAJ0sZ3lZWlA==
X-CSE-MsgGUID: 11XnzX+5T2SNImIDQYmtDQ==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235481"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:43 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 09/15] crypto/hash-glib: Remove old hash API functions
Date: Wed,  7 Aug 2024 19:51:16 +0000
Message-Id: <20240807195122.2827364-10-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA0PR20MB6824:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 300b30ab-1f02-4226-4154-08dcb71aaf85
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9RE6lQT89JMEPNj16SGjSlgJR9cHEjd5Vo6qFxeRYsqZvFgzqOxdShKo2B9h?=
 =?us-ascii?Q?nPrsqVHjEsmvlwXpuo0IfveDDEq9dNqSQEhSs09YvDOkDXpr09Hp/ICs6iA3?=
 =?us-ascii?Q?GTKceZ+Apo8B69ykEt1+JdG5B5Yq+SPOR58Lmz3QgXeKYOkwDGUhPPj5Dmmm?=
 =?us-ascii?Q?Zrxen94ALMxESRMJtSXxQVVbd8QzVBSeoTIpWu6T040Z3pl8hBbtCVliBxjH?=
 =?us-ascii?Q?ir0mXy0twAfCjwbU3G6JpMdsRrLDk2ERIe8sDI6YLXWXat2F5h1ly1Ra+n0y?=
 =?us-ascii?Q?J3gnQ02iLJwk2anSDJgj62FkEodSr8X8tzRFBIQZPX1ZQmum5GgZP9HYILku?=
 =?us-ascii?Q?RbE+BYLJY9d/mHOxaKmz2llPLoDynJk+6h2ev2hDsQwKIycPpivxGdWrt6dz?=
 =?us-ascii?Q?Vn9HYmnMZ49KjLR502O1Y3mbcDAwk1NO5tzHGFmLz9bWQxT0KmvW1ZfGAKzg?=
 =?us-ascii?Q?0C6vfglw6P7/XZOLrkCLYV8FKApr3O3TH3O+tYmS2ZLIbItJnXONX7D6Jw21?=
 =?us-ascii?Q?2lFAzOwjqDVcllWkGMKRHKIY1ngxWCYTYwArzJmjQoTryJx3ybwkbQwvjLrz?=
 =?us-ascii?Q?SKVwLnHm2XBG0okLlutqlQq/vLRKvGljjnaxtHmP2tXBO6lo4oliIF/3lBQQ?=
 =?us-ascii?Q?JJGK/KXJQhTT+qy7bAmkAITH3SUjhyiVLUzQ21o9wv5yAWBLh1siTGkRuZFG?=
 =?us-ascii?Q?S17IyCJjMGsOhjnb5wKsxDt0/M5oJwv5jqEgA2xAXTXTUiVfjSIxPltcwG8l?=
 =?us-ascii?Q?GyZOitBl4qPa7SfqLpNyD29w7W/C19I0gMFqbbbWcKBjrZ/zs2pZa3MHM+6l?=
 =?us-ascii?Q?2iSWcwQYUbub09VFucov2P13vj67j70Efqev/yJWfb+fSlPRhTTX0hvaPSkY?=
 =?us-ascii?Q?yDZCh6P9mqhp72eG5C5XUieNbyXpelIKhyggW0KvkjbTaGyKtcNUSfClMFhG?=
 =?us-ascii?Q?pxSy58n8ATU5RDHd48+OQ2RYCE4+OFNWebtizZ4I3tOu7VA4b9iuBXkNg5a1?=
 =?us-ascii?Q?3VtZDZGth9Mkt7rohbJHMZaosiDGfuChUNJddB/+ljGxsc1CowdMRwQ+pEvm?=
 =?us-ascii?Q?VbtBJpiTUeGBgcHbwFw+OJ1iMyC1MJnWzy7miTtBnpTDP0bzOgsnuNrIROV5?=
 =?us-ascii?Q?neTbWyACupdneT566nnh4OJ9LmDsithsrhDwxqVHGMRXyUwPdIqPuV495ysS?=
 =?us-ascii?Q?f7bTdeeTGjcskthmLKCSQuZo7HeUxS3GO/rLPdXn7E8Mo7xHfScWCZ710lCa?=
 =?us-ascii?Q?DCgmKUCq1XIiRjvz2qmjF4V9WcKvT4FJyQCTE8S0j+6wRgl2Jq5KJwsyJ9aN?=
 =?us-ascii?Q?+i6cth5e6EPDpamfTlQyw5kJaOGsegkFe/VaPvKummhQocqVtL05aVjfEeQK?=
 =?us-ascii?Q?Sj9W9WBHlYl/jD0JpiTHGIo4LhpHpYGYYvZYAGBxm7KRakHeJWjCIib07+ks?=
 =?us-ascii?Q?DEeOR4uY7nAwn5ve0xbf1OSRHCQabGPB?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OJMqFnjnDeyaJTEro2ihlhrUDqqm6vzAC4Z44/84UFLLzWbatwABH+9954+tog8LGATdWI9qizAsvwKceS3YzegANcXI0RK309xdUAFfCL4wZSvuSSV6o/DccbyCzq5/+m8EN5NNeIRB/Vx+vusFAf7u0DblYisf7OrrXrOitiqRTlkwA0l4gQ+5dyZOr+iPaGPpiTA8lhC/6YWGmVjPD/ooyGIsqtJW0zOhA9LNV2hBgHMkVCIif5Tfxd/PpAVhnPBjo24UaZ7IGF3WC8ZWqGn3u1AJNiZ2lZayCorRjTMel7EDmPs4ByXxsGa/ofKZKhAnWmiYMgW1vHGrHtUtldNC4tsjhQEPXnj9nYWL2rk9dp+0Ei34W7okAh/oDrGaPhos1WshYriZSaM6373a6EFJ8pLWw/+OXLgY8Zd/ABxHFUkvBCVuiM28X9RK0ZDUDWMMN7XNbH0KmEHR0Q3AGCkZoj+juOW8/FC6gEKEt3Ski3y2HOeBe4CyuPQw74gnciwDFZn/tfYO7EppmOXsPfQD1wgnOj8aiahVISZOVeMsfqm/9oOpmC9MB7QKGWS/DHjWQsmj7nwcImfUYkMqtPuUQIYjZUTWyrLJTwvz/XfWnwAWOazUe1MyZWnJB1Nk
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:01.2640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300b30ab-1f02-4226-4154-08dcb71aaf85
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6824
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

Removes old hash implemention in the GLib hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-glib.c | 53 ----------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 9f4490762a..d1dc00547d 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -44,58 +44,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-
-static int
-qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
-                         const struct iovec *iov,
-                         size_t niov,
-                         uint8_t **result,
-                         size_t *resultlen,
-                         Error **errp)
-{
-    int i, ret;
-    GChecksum *cs;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    cs = g_checksum_new(qcrypto_hash_alg_map[alg]);
-
-    for (i = 0; i < niov; i++) {
-        g_checksum_update(cs, iov[i].iov_base, iov[i].iov_len);
-    }
-
-    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[alg]);
-    if (ret < 0) {
-        error_setg(errp, "%s",
-                   "Unable to get hash length");
-        goto error;
-    }
-    if (*resultlen == 0) {
-        *resultlen = ret;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != ret) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
-        goto error;
-    }
-
-    g_checksum_get_digest(cs, *result, resultlen);
-
-    g_checksum_free(cs);
-    return 0;
-
- error:
-    g_checksum_free(cs);
-    return -1;
-}
-
-
 static
 QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgorithm alg,
                                    Error **errp)
@@ -169,7 +117,6 @@ int qcrypto_glib_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_glib_hash_bytesv,
     .hash_new      = qcrypto_glib_hash_new,
     .hash_update   = qcrypto_glib_hash_update,
     .hash_finalize = qcrypto_glib_hash_finalize,
-- 
2.34.1


