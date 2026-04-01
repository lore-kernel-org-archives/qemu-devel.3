Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04010F9315
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzH-000804-Nh; Tue, 31 Mar 2026 21:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz7-0007mI-0F; Tue, 31 Mar 2026 21:03:05 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz5-0007ek-Ls; Tue, 31 Mar 2026 21:03:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZguwpkQqvkWWt1kvncn4+kYS+tSPCes2oniumNjY6xU9FSKNAhz3qM9/7q+tO+zcLfpf0NgebLnk1Upi03xLWZNJsNDVDkLJzTCsjrS0ZMEM0ehMwPTTeBzbA+GH3sp8/8NT7eWwqwNVERi7p2waMrtdpG0DqxNtVnc26EbrRtaIBNEthaKc14heMREk7OzJNGw3YgNBdHz3iTzl6XjhpD/YDISbcAduh6GHRuzRFArijiMfc8g1JvNbav36gDE6FFbjn2gtlJnFY+WuGneFxRslgk8OFdGM7kOI4e4VsUpP03CPZBmu379PsR2/cuzZUwbEtqci5QMdMqy7+uVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/911gL1c8l+TllBkuHl4TYxVgBPzvtKSyzJziBikKM=;
 b=iXgR9H1BEocUtyzHDhcdswK7692UwjYse8II25baburv/pFRWHsCnkrexgKD7aXvdssjl9IU9gz87xo/XnvNzNqO1Q2ESDEjt3Y28FrBdeBGQB/X4cAe7xvReAqNFvYageYeo08r570vgi75Fzsj0GcotDCv2RxgwvNBQaDoNjm/eEcTxxpf2+g2ZIJ9OIRIFY02zg1qWTBFwZ3wrSCzfAYC4Y9ovcFFtjUsRlCJJaDkEj2DADXFtfS1EoTBjFJctuCFSxL2m6bfwI4vODwmnfCD7XCNFL4TQ4adySJubl7s52glHmOX/vt4Lz6aQi++29L1bDpWi9xO6IIfVvH38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/911gL1c8l+TllBkuHl4TYxVgBPzvtKSyzJziBikKM=;
 b=i/64DSEibqr1tjxw3BJQvONY6pHiFL3JjuOT4sSyv7hPlCVvYwC+w6KoBS7HW9e8La2fk93km7vXhkrdHIJp+kkl1UcoUmeCxg7ljwQ06/igDVSUKPX1j5BKUFx0vlsdDMvzSJhm56Rm14cNmMmIvLxZLSa6e9pZofUhaW3xuxWZbTqRx6+sjN99NMDdO1ZwYUZay/L3NedokqTYR5Aw5xL/zoz+m/vYft6AcoBa7hqycmOtZ/l6s72wvk9W5pu8CjAsI/M+1X2rcFoUXbRifs+dty2uC7oqGVg2PZQOhAnGMxbIqQMWYNFeeOdHAwz1n3ChGyP+jdSx0QcLzujpQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 01:02:55 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:55 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 11/11] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Tue, 31 Mar 2026 18:02:31 -0700
Message-ID: <20260401010231.4166776-12-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcd2437-c7dd-47d7-821b-08de8f8a6823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: C/8vcSh9r/oS23/zgDHGmkJO2Lu8bqTITBjCNUJFGIzB/XEZUyEYsqaMzr0CjCqDQQwmUmcljuDWzkaauma2YibnSV2oGsNLQgdAHliGbd4ABORiWcJRk7uPVJ5hj1MVGTHSm5RGUFOqkLc1ZHytJAVUg/RSFz605+Dj3o+JdHmuUACK3JkerlMpRqDopEAfyTUbPH/yoo3DQXe1IofGWakV6+ZywbP0Xh56N6ThXK8OMdngC1w2V5HnsGQ8Lf56aOrx2+BnTJkzFzTZ5sBgIy5iiWpYF4o1Z6c/FJHMrOzvvwmqXnpa621HKDdqZrrFsq5uKm9P2pLzZEw0dkLLaJ8Thvf49hMyIISdRUOeA+EzbN2V19Tt+AidLoZePuupDJPLktAo1xckJODlVXZ7Fgw5rj0XGSy1b/Br3GntXgvr8kOLg/vUpq/+MHpCFsN/BKmgHGEaTsiUTiLiZFktYlOKXjUulYfihJxEWBs2NuL55RKhvS9cToEczEJBPzNB1JDh5RHfEJBiHABFCX1mtUCCD/GOeu526nCDYP7XarqFnwGk+gqIts8w08IUH1EP4J36T6Daec9qHdMXal3lOLMZjI4ORajXc3gtGMDquIvdTJjAf1goPBTVSucwJWG4zcG9e6dRs1nOWb0kXesU7b6mpC5a4Kn+8D07OzzXT8Dnk6we9pyTtCka45i5RhDybzAFzueJ8y2Weqb9GhWOvX38ty5khVbayhch/lbOUrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYl+jzIS8ziTdf12U/+IpY4ppnvVU1nOeLR5TmmwhsORvunNgCNfOOsxgf0I?=
 =?us-ascii?Q?9CCluYDUzS1avNHOc8/tKSx9gcvoWCBG++FN92Cqfd6vxYItBZrH2HRlB2VW?=
 =?us-ascii?Q?8eln117ZsYpK05VHspzcx9uwL1cgyrcyhETzV8Qt006F0NQLo4lNXh1wN6xL?=
 =?us-ascii?Q?KBjidu2Fuu+uuiUiSoLW+l/ygPPxTFOcfyaRiR619Boe5lSBierEUgwrHz7a?=
 =?us-ascii?Q?+9y4PgXIj57Gy4knjaHqqzkF97brx0AOvMSxbCewTPCce+XWjdlJ9GJhN/OO?=
 =?us-ascii?Q?hPlYk0pbW/QVFV/pOo9IKEbpUm7IGehtDgpqMXqY5ZHq39dv1+X8ganyaaFG?=
 =?us-ascii?Q?SOelrpwvt73WdOmOeL+buoUQ2OgIOmh1ip1ac+XmMXDhy/LRl1c+NznGbBnf?=
 =?us-ascii?Q?1kJ8FKt56kK/01MjlOFxIZoYNl+rbBaEwYdVh4W7f06bcqShqgB02PY0pGgc?=
 =?us-ascii?Q?3UWSGrOG9okgf6H/CRAkjUgZOrvzqieKWoDsxYAaFbrTruRsgrNKuP/rRRl2?=
 =?us-ascii?Q?+TtCZw8I0xPWP/darJ2P1yRWJrIs6fmaRgMIbgBb8hQPoHdFBgHA7qRNg/ID?=
 =?us-ascii?Q?WlYTEa9i5HK88q4zO0ksijmChByNA0mCdFvUPvGYM5HKn1hLRN7QQFMMW5gf?=
 =?us-ascii?Q?xX+Av/WX4Q1e1kxCNgqAlCkD4lIc8QvoI0T2kKSmccsvVZuktrXz/pyMhn+H?=
 =?us-ascii?Q?u0/yuiUwp6hGddRNI2Wcew37sLPsxHfXCi5EDjnL2OQinztwYhvhzeMD6Ztm?=
 =?us-ascii?Q?QfNW5hzQ4ZWQ2RgoyghwkPlJGvetuldXg+sLW3Na283oaxZUm3NAgTUYH7Nq?=
 =?us-ascii?Q?RMAJ9eiA3yxZQVSil2H/OTe+BPfj0a+wR3vbZTemXVYdHqv7QTLZtnV3bicY?=
 =?us-ascii?Q?eRR8SHoH5CjSFeiukd0IuT8JuC+yn+bDEeVFyhYOX/BW0yIbjUOUwlQSDfKt?=
 =?us-ascii?Q?6kRt7hHDAEwew96Iv+0PMjbNKUt+cpuo6ZyV3Hx8R9lH+Ah3E4P09cyfP/LN?=
 =?us-ascii?Q?0lGOE66BpjgwsKmJxmlT03tb6JdahPA7TSI2CQJtKR8jHv/20HAQxH+P9ESR?=
 =?us-ascii?Q?+mqTU0ZxJD9iYZhTbKCs1Gh8UPLKmo45zbGkySiKMtw0z6gUA3s5WmxlyBZn?=
 =?us-ascii?Q?4Au9YvgnoUWb5wELa16JLlK7wgigbZVpgwGcZ88ACC1Jzu3lrwRQ/ME4vvgm?=
 =?us-ascii?Q?UkP4zz6/e1HWYwkvuQO2AMlazZh0jemvc4rssU+mEqQnqalQDXWij4xGtaJQ?=
 =?us-ascii?Q?SyBvHmiBi1eKNNd4Yce8yGza4Z7szJwDfgZ+L1KuKmQiM9m8OZA+CZeAYg13?=
 =?us-ascii?Q?dzoYeaxVnTuF3asvIweflWjUAO5NWyyG79M8bKRUwoqDCksILXG3+kw86PWz?=
 =?us-ascii?Q?pp3HVB56s5JPl/cUwP6DU3Qdvsc0QdIJKp2UTZ/S7r4Qh07sf+g7p61XDOF0?=
 =?us-ascii?Q?rv6Dm2Fou2GNORuGEPU/wPDUQ1YX94EM+wpE2OD4oS0irnCq8F3cFnxIKjNo?=
 =?us-ascii?Q?pPZu5RLNtKoxQrP7X3V1mYszxyBfjGLmpOAqzbEllrOm3PQvAn1gB+Uq9vVy?=
 =?us-ascii?Q?pMUDaTSo0umACjs+n87YkLCrA1JPNUrTnQlQqJKYrRFW2cQNo7WJcGWaMPCj?=
 =?us-ascii?Q?i/JdytS+5zWwjlNJM670IFxmz3gYVKQ1r1epw2n1FtStF2xs4PVM6IhFPlke?=
 =?us-ascii?Q?q+TVtMaxghp8FhirHGgdInvmx4zo1tklwMCC+sTHIk48Cgsptgc4JPXS64aX?=
 =?us-ascii?Q?EGHKKf11MA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcd2437-c7dd-47d7-821b-08de8f8a6823
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:55.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WkdKs15gVbLGUyStt/C9yHh05+z/7Bi+eR2iOheibmnQSAL4HUlqYqoWSFL9JUuUpexH2r+8KidJ0ZNDc4KxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=nathanc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nathan Chen <nathanc@nvidia.com>

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 21972f8326..bd43258445 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1292,7 +1292,6 @@ SRST
         vfio-pci passthrough.
 
      The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
 
     ``ril=on|off`` (default: on)
         Support for Range Invalidation, which allows the SMMUv3 driver to
-- 
2.43.0


