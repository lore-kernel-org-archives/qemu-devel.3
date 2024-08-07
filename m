Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D22CC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmk7-0000YQ-4c; Wed, 07 Aug 2024 15:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmju-0007UN-2X; Wed, 07 Aug 2024 15:54:30 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjp-00024z-T2; Wed, 07 Aug 2024 15:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060465; x=1754596465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jlre7QffNDhziaNO6s3JSgSmrGeNMy5jjI2XtndVfLU=;
 b=JesYBWazaVVqyO/z32ff6dcmKAtW0S4jGWZPs9+JCkhT40K34P4iwlsD
 s5iHU1oQIHdUmpbZUr6wV17U1yqPT6s6/ERr+pUh8MW3G5GAbryG3tK5B
 hwOwigltk6asxGwVVCANfy3PU8C8zVlmiE9Ay/ocE9897sjvpU4rWk3ag I=;
X-CSE-ConnectionGUID: +XlEpqpCQDmfXH/X/U/oLg==
X-CSE-MsgGUID: wgYrTlOyTlCMm0XFX6Yu/w==
Received: from mail-bn7nam10lp2044.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.44])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blp1zE38nLaKJ47XTj9nyhWeedN34CAQcHrP8Tv1tQyhRynlnkXZluXlhMasl/CkZcsmdEwP4o7Dt7nfun5praPx2BAqpWuHzRmnrzO6MnR2lbXepJjnrZgXcmF/oY/GX63m2Wi7c0M8YOpjA9lNTC2TUmuc+PDoHZ7hoyHctwhneP4vW/Maa0aUY4aXcQroMggcRM/Ev/jwel73fjaHstuz3iful+0lcB3YNSRP8pGegzCh/LCmCypG14otB5ZDzPbEoPn14F/Yzt3UIgAL8n0zlhG2yhWAuSNC1I0hs9Om/5QY9LLtemo0tXK5/rlM3Y/4dHA+PFY96k3boBTipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTnf9q2hZmp9z+zSg1kP8aJ+0B5D0tMj06Cd5vv0Wwg=;
 b=ZUUKB6pAwm+kW1QeKfTNEGoIThCov4+JF0I9uqZTBuIUnStoqHAg9A0FynYoXVI5+ZWy8hEqaB3V2aqFNFY91Q5r42pXkHWGE6JhvhJti3zHyeziijK14PwvuUK39ChVN3BeLR3upkldUTtdvdrDWteRbSOoTrdI4IaGc7Z4OIS3a4jCW2wVX/qS7lamh2BSwyYsbIgcV0eEp4xL3KHHQn0JeIEd9gnDz8nekiyzK0jy1MHDkEE2lxf4h5MAOfzGkN0S40zjq/3lsfXY0PlYuQj5s9brXRSi73jJb6OmjwofEkAE7fVUaPQF+0+T0uxtPDFob5KOz8P9QWyZZtqlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTnf9q2hZmp9z+zSg1kP8aJ+0B5D0tMj06Cd5vv0Wwg=;
 b=LbyrltOXqZfbA9R907oLpKhI9XaTl+AIvXo1JS7g02PtwKZYIEQ3ewHZ/DqKbpgVq8rRkkxIBqtz9MRXALcwsGcT3ILwU2ulNv9CWiVLiGCREq67BJJQ6eAkmjHMTvOGE39RxBaVBeQ0cI8LVenZaGEriuI+Qv7ISEgJt5Y85CU=
Received: from MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44)
 by PH0PR20MB5867.namprd20.prod.outlook.com (2603:10b6:510:28a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 19:54:16 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::b6) by MW2PR2101CA0031.outlook.office365.com
 (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:54:15 +0000
X-CSE-ConnectionGUID: ONfWMHF0Q5SsGgrYBcwZSA==
X-CSE-MsgGUID: 0BjogIONQjGcL3z3/iVA4w==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:54:06 -0700
X-CSE-ConnectionGUID: O9fGi6w1QmKN0cekIfNOjw==
X-CSE-MsgGUID: 0duG3VChSe6VyflNhKyhPQ==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235494"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:58 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 14/15] crypto/hashpriv: Remove old hash API function
Date: Wed,  7 Aug 2024 19:51:21 +0000
Message-Id: <20240807195122.2827364-15-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH0PR20MB5867:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 258440c6-1ed4-4235-d006-08dcb71ab800
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cSmWbuKbo9TgwxP6qjY4vJ0Rd3o5+v0NomoG6YW90ZM37rTmaAoYt2aLEabs?=
 =?us-ascii?Q?n3ZFjETnAOUCQ5AxDpkQy6wyx/ieqvELKVMMjdN7sXgqIxMZ+p7PzKjW4A5D?=
 =?us-ascii?Q?PeIU+ZX+SeOGHAMoWaROKM1Mj83X1as9RpDoTuJ7I8UoZeVbRMmEa4RbYFsC?=
 =?us-ascii?Q?Sz/lckmeNz72FNTV5kUvTrWZv0lIaxl5bc/91t5GbsoNtKtKKZEoZ5XunoRy?=
 =?us-ascii?Q?GMfWdKbR7UVim1rHx2oWKzv0dDl5HV1ARy6r+6M0cq8/hd9qsQi1xKQ8vr41?=
 =?us-ascii?Q?stxktfYVT4oEATX66xvoqkA8krNqpE9vjCYKsN8ws5yAXHBMzGymZI1dxHtt?=
 =?us-ascii?Q?p3JbBeW28yi7A5aVn0VX2wZLcC546zpy1mnG4T9dNGPMjR2e6tlS7wwmsw7U?=
 =?us-ascii?Q?j1yyeen+FGKoWhXxoCga7oFyenH4c77rMBjAH5nBYICNKYk9H6dld0aHepiP?=
 =?us-ascii?Q?H7lU86MbKl9ZQAdumgWsFRuf6/P3dH7G4L0Fmxq5yhdugRUMmdZWbeu0m2Nm?=
 =?us-ascii?Q?7MrFXVs7CAOiJwvYHNFIF7bfRFJ1GLODNRlYzLLTwdnP7yAN+N9mLNRzzyUA?=
 =?us-ascii?Q?5mL1Y9uC/xMZuN8ZeHDcxBwWCwoGMPp8RIGcyQpU+XF2ogladkw4tpYnsN79?=
 =?us-ascii?Q?2yZyHzflGh8YIN9l5UKDbQflLWUrz8A5l29BgZaJSEqJhylmRANd5xzRorc8?=
 =?us-ascii?Q?vD3VIU8gZdu84xS99vZUjwJ4Kz7PhxoKUICvGcoYxQL8Srs1C3oli1roGKXx?=
 =?us-ascii?Q?xKFSK3i1/mKuZg8gLeHAjxEzEvsX1sJ59KNx6OTt1BBEWQ6OUFleZiG0ZPSA?=
 =?us-ascii?Q?KQ4JNa1rZNjqjH16UW4Aa/h0QvksW9U2CWAnGVl76wsZUhWamf79WaB+oNVA?=
 =?us-ascii?Q?0k2F/I2uEdymOW+K+bu6m/DtQQ2WwfSs8m31u7DmWBIm9/PHHZ3jk59QDNIi?=
 =?us-ascii?Q?jhrnF+sHJWTmFHHnJ8j/UJ0PnmH9EReSDxAM9Dezq00RooXdLLRultsUT7Uq?=
 =?us-ascii?Q?wo0jJiIHFWfsGCJE2AVsmIL82YF68BtoQoktd8lrlJgKlOFwjtlYFjdB6EJ8?=
 =?us-ascii?Q?iC27HECxYfFN0FnGce4yrwJkif95MNNMeDtZmv42U3EKTe5TwtbObDRNT3C9?=
 =?us-ascii?Q?TJFLKes9rTu5rUBeaSz87dEoMBvBClwnQwKlJsQBjQDUvn8miqI7bZEJfJn0?=
 =?us-ascii?Q?/2HmoR5bX66FSmRQ4ZswbjTeFWTBSkQOCPsjIq1Grtxm6wz9osqWquHatTSH?=
 =?us-ascii?Q?YFmzH7PITmvOHQ31Qvt2jSbCpBpvrmlPkuDkT8avHLeSefWrW4pTyM2cRr/2?=
 =?us-ascii?Q?+wxaCopvlh50wE+aztkneSQWiOKp2tGWHdg3XYZwg7xzCP8buOQX31zSTTMq?=
 =?us-ascii?Q?I7xOO2xddtCUpBw3ueHBg27wwPigyny7Xo8uNT0xACi6gApxWlX9k5NDSZDe?=
 =?us-ascii?Q?krl8JcZjF1sbI63HhDPLp9EUAyqBV28M?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2tBkCRMgFFqW42qdRE2oAplCDMKmq9WlUYoDPP9VovoVQuTK5uLjx8kaBUgG3bsMCfgT/j5RWvjXj74mSM/CY9yzqerQspeACnz+rY9Gd85E63amhDD9CK3Q63kWvTs5DpWExOTRpOv8zaYDZuPez3J1+LDikkaYKs516eMkooDBysFq+ZpBGaFVdk6MWrx3wwTmyEUDToEL3PotDjTqkxgVYAz1q7BnYlVgEnZLLYqQ1nXdEBJl7GL2BDbvU+ohTG9z6+oBvpCLtDYOWoAXf3JZ1XzjtbfN+4MDgqYNKMnCNYNG6xD2OlDPCvtPwawTTQAORFxxJqdaVf5GzAhcvMujC8zm+koJPZvIqT6xBckPgegq1dbGRnhI9aBzQap4E8nF5ZnJWGNgmt4TiGLKNEQDI3tJ4Jc8pal0K3FD+NOMoiCc+WpdE4+Ubngwvs3FTykXKJ+3Wb0yiIRjZAx1VbIjXBA2Z/8Lk8mOwHyMcrzsYY2eipeQC0eH1utkB/6WWGk7dllGxju3dJx0kUIB2bQs5EENN7IWx+YiNL8MxrkhfydlSD4DOxsL5VsgDZNBdhz+v00cQXxBhRpGnyYLB55FZI+1m7sVt1TWngbKMLWwbCNwyYHkJvUFHfizfP5M
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:15.5267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258440c6-1ed4-4235-d006-08dcb71ab800
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB5867
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

Remove old hash_bytesv function, as it was replaced by the 4
new functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hashpriv.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index 02f17ee99f..aec29b3ec3 100644
--- a/crypto/hashpriv.h
+++ b/crypto/hashpriv.h
@@ -21,12 +21,6 @@
 typedef struct QCryptoHashDriver QCryptoHashDriver;
 
 struct QCryptoHashDriver {
-    int (*hash_bytesv)(QCryptoHashAlgorithm alg,
-                       const struct iovec *iov,
-                       size_t niov,
-                       uint8_t **result,
-                       size_t *resultlen,
-                       Error **errp);
     QCryptoHash *(*hash_new)(QCryptoHashAlgorithm alg, Error **errp);
     int (*hash_update)(QCryptoHash *hash,
                        const struct iovec *iov,
-- 
2.34.1


