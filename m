Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA3910F9314
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzF-0007zA-K2; Tue, 31 Mar 2026 21:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz7-0007oA-Tv; Tue, 31 Mar 2026 21:03:07 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz6-0007bB-8k; Tue, 31 Mar 2026 21:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjygCQ+VcgMIDB4nJio6Lxuouxp3tY2yLRCJFqT47JsGELjSq8g8Me9nC4nI49aiLQBB75AvAE8P8tIZAWAKhe4KW5lRDyrPETRwBJ2T0UnkDZUFzaJEJ3RCvTfORmHadZx+BJerPzK47Gtyedt/kFqNIWZNJXUSYSWPRLo8ZLXHYAZ1sHr9iLDXb8fYDMvyDvK3oAmTVLMFz0IONpHEPu6QvUGkeiFSmB2blKFo2501erq0/6Kl5KG8qO/zzqsNfGcwEUt+WsF3+p99RYpkS0IFVQVgICcJMOP7hOYcZuzdtggzLlYZbshplo3ySEQlGB4MeKgfaOGTGPe14Q7iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmzZRhFROEQ4zoXADgAMHQAqsgcRm9XkKp12Mb8wF18=;
 b=JVYv7+L5DCgNzpWJTGSezazZljrBN3Y8L2ClCiUUU4xHiRIQtv8fxa5LyKV2Sj1FmK8w6rscSIAM/4jUS9p4txJ0VBiWgpTrCxM5RyPDfasUIdoBKMs21KY3KT7wnnd+QyFvrjnpBG84CCJjAg6vlw2Qys1aKPHn4Xv0BuV+Q9VOEgwDZ75cy02GybnrdY6WLAUJKOzRjijcNz5DGPoRk4kB2sGmt/tBQo1Qa/BFuuIj+FmdBcVDMWZq/Axv4DI9wFdI5F0ToeZ1tQGvyoiaKPdQXD1WQwCXG8E3ji666kDlAQg1Oi5lr4ljLpoBqBc9TRI4o/NvBtapqnFVtKjw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmzZRhFROEQ4zoXADgAMHQAqsgcRm9XkKp12Mb8wF18=;
 b=PGz84OCPj4/jDUl8Q6fSumnb0iutf6HR1Ye2V4XhkU6rKw9ObqOpr2TWNVuVpJJXEKTU7XP2McuhoIEDYgeuXZRJD94WBXm7x4wm1/U/OfS0w5vK8w5KaFw/Ri23AHlYoHAHEig7nMPF5OXHp/2DWCWBiCh1pIdbmjQsFXW6ax7Hx1DwHE2BojntWzsvswBAK+An2BVG4D+rEbc42hx0JsskzYBjqSSy17FRGcG0pn0muNepY2WgP2gRlYboikfawfVR96DxVUZg5H2iYYhMUD76rQk3xFOq9AsXHZaEHlKOljzf8ZoCZwyNzSOTkXsVVw63jTkTf6nfdR7Y1bavuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:49 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:49 +0000
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
Subject: [PATCH 08/11] hw/arm/smmuv3: Change the default ssidsize to match the
 host
Date: Tue, 31 Mar 2026 18:02:28 -0700
Message-ID: <20260401010231.4166776-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4c35fa-4746-42eb-d760-08de8f8a64c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BaERQyVmD8va+oAZZvllPdthBppY4Gv5TKb2XrGkHiiflxqUNhPsKml9pnX/02nq0Ps7qr16INSAdvt5y0KAnCNorB6EgqliohGxhCCOk45kKqHSNyQSGhS344oiBzOh0F+W5OTH4C6aSy4naJoWKJ+k0UcLxsx68CChrQT/WGIAbrGphJ+VByVt3xoYquk6jCg0yShELypBp2zoV979jvvQZQG4ZW6CLYxvDKWNBhTBUg/3zqlMGhyYTPi6CuANDWpyu2oVVI+vg9/LbD1g4Wy+2l1qAXNnlrMRjiGvejMEym74SFGxA9D3mKv4aFn+Zi2tygDOkotKNFczOH+vwM2DAt5T6qVWiq90ThTgl1hNWeM+Q70z3R5ufPu26ICgNrRT79CJ1hAl8voJlYuu7LTTxn63ul8T1nDU1JLfnH2uROqYYuZkbw4gA9ldxnH6Zb8LxLiiE3oYDKuyOWtl9OtmowBTOFxQqkjWkNm87+Rd2WBEx1jG37mDyNrwuMGrRIMD4j3/BwUuTIFnETh/2uxsI8ywF7i3EYyeoHp3xPSPrrfsp4O4vt3/qf8Jc6r8XLMANqr3DyW4Mj6TlVKTz94U4HvBROSJSv9XJAD5hqSqKtXWjc7EM2IpP+T1QqQIReWeTJaHbgEMTsQYIEmuMowNdfJe6Zdk6fVcHc1HdaPcjvYYsWWWj/O1HbvKq+8/q2jVNI4Tt4i+M93iR3KS1g2NG89qUNjPnf2eJmpo3PE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8pFUSkbQu6dTWZxfrVVlYFT9QYsQKgID817jpVo4wu2r/AQ3STQCgy8WrVw?=
 =?us-ascii?Q?a5mb8bJNx8lIi9/T/xopa1/9Wjk3PGba+/+XKM0faWcdMxGZq0y6wdY6+nxR?=
 =?us-ascii?Q?TRzvAFXr+W6Chwb4sPLvAAo0LkBkFUEYqsY79XsoW7eo6Rr+YD66ciMUacFE?=
 =?us-ascii?Q?h0A2yqwJPHdK9nzUN7yqbzw1ZQfDlzmMfl6vGU2pGmbnREm0kLbIpd1upxVl?=
 =?us-ascii?Q?J7Fx+ZjSaTn4dZy1jdd97ioZ3Rsb0J/uHMcrUL99mO0gKPhpcOti4HfoECFC?=
 =?us-ascii?Q?ixyZxZ/ZUKaMbxsQ4VlnVIdsJPhnk72jSYYNk2hF72AEb40CEMknLtXD5Rmt?=
 =?us-ascii?Q?aQQwN9Vha55EPDsAMbb47F1EhppqAwSekXpwAfV1ftx/oILbjfEcNj+Pwg0h?=
 =?us-ascii?Q?XoSbau9JM2g0l+RWYnZ1CsYbSTwZeaSZ37L+0q7U0UeA37okHZlmZJoiyfll?=
 =?us-ascii?Q?MxC9uHlxl+dG3MTet/EGEcXzPuuEc5aCHGGs8H/WYOJyOhw2f0v5RhF+oKDO?=
 =?us-ascii?Q?w1wIv4Zuke5FXkOJmkCXvW3m7I71hRxrtl06nKPS6MX6bMYAX/05AUdIB3ur?=
 =?us-ascii?Q?npqBNrWkRHM8vjhkJQo+DIa45aLy2zE+RJgT6oX+5M+NDnB2nysDnJkFUoEO?=
 =?us-ascii?Q?VA99Cl7X2Xeva6XlNna2Fwogrx/aXtRKIaC7WTB3qefLVzpZpq8vORrdpRai?=
 =?us-ascii?Q?M5z211EnI6OYdSpjIeY/oOWkIdCA5Ruym+XQ+4z8X25XZbKEuUeM8D7JxWd4?=
 =?us-ascii?Q?h48jevfPd4O14dAaERO58zT4cS6QyRIQnlskUKuhWucSz/tUQdGcwKZtImT4?=
 =?us-ascii?Q?8V0Bm9SQt+R6WNgprFLbPlQGnxrELLJ9v1Ke26PYXKlR43FzRqxThWnCC7HD?=
 =?us-ascii?Q?R+uG2/2P7In3x9HVLT6QVwRfxWEz1h10Bd3nXasvsLOFs3POxeC/1VNyaP1u?=
 =?us-ascii?Q?e54NhnUgKmsTewUTHJW2BnTlE1A7IZ5CT91ZWUDre85N+QvJ96SNbKGWFb9z?=
 =?us-ascii?Q?QRc92CvLOaw5ulUwkJWdnmGx2z9h+iaRJRK3+p35qvUe7zWVfDRDUOnmyV0w?=
 =?us-ascii?Q?kKj+lTVeZ6j0nlVW2fp1vS43i9qXpbHsjegBJpX0LQy2binNeBTC1U08jW2g?=
 =?us-ascii?Q?NK+m//5XPASAHOpv/efy+UX1Oc+DZLNqhnHq1IFHKCqnC25nqQL7xRqbrkYs?=
 =?us-ascii?Q?Xsl0molZBM2+sZNNJYEJGhSv8vwZF4dH5fowbVrhvl/H+KwvsrqoCxo97zTk?=
 =?us-ascii?Q?EhLT3BvaAE82WYZ6rz1AKoXKKT7vJt+yfQZ38PrCgkZUNxeYWx1pzCqb/pno?=
 =?us-ascii?Q?7tArbul7F33DY0Wt+gZqzNWOg6NSuc77LhklE3Ra0hUdz16cHHaJcn8+TA5T?=
 =?us-ascii?Q?Y1jdIq5C29mgAtGh4kQsPKDNJXjGSjTmIAIZWFsxXo0GjnxcvlLfYMHUxs/U?=
 =?us-ascii?Q?ovhlCb+gehx+rM7M51QWRShfiOm+9xbYmaKBE4GfASn0Xk9LWcpw9lmaElT2?=
 =?us-ascii?Q?BtOlUTnraVlZXkk7NpRlPfs2jghkbAKhYCLdnNiyY7Fa0ZkuiL19LLZoLNLk?=
 =?us-ascii?Q?riGq521CdlMJreTFl8HcMmIug0USyrsBlnni+/NE8mT7Wt8/POzO/wfu9gLm?=
 =?us-ascii?Q?pKDKz+ITA3gUbqUxkBfIFmWrhCb0VpGolpvGzZwC9ZUD/ZEt9gzEjOqtJcYp?=
 =?us-ascii?Q?irh+5Enz6CTGyiSdavj5AqvFvVFGy8eFxCC8s2cKPzMBydVpepCwJ9+WvJeM?=
 =?us-ascii?Q?mXqMaq0+RA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4c35fa-4746-42eb-d760-08de8f8a64c7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:49.3385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX4rnXWScWZJ82bIoCMo1uMXDkwRLDFqHBWbKlXzoij7EvirB+kfaWiYlNV5OF5i+lUBV/TLEfK6pRm9BC2s7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Set the default ssidsize value to auto. The default SSID size used
to be 0, but we change it to match what the host IOMMU properties
report so that users do not have to introspect host IDR1 for the
Substream ID support.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 4 ++--
 hw/core/machine.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 67c499d22b..cb14a08a66 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2156,7 +2156,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
-                              SSID_SIZE_MODE_0),
+                              SSID_SIZE_MODE_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2195,7 +2195,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
+        "Defaults to auto. A value greater than 0 is required to enable "
         "PASID support.");
 }
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8f8c26bbe8..aa208a2d9a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@
 GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ats", "off" },
     { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
 };
 
 GlobalProperty hw_compat_10_2[] = {
-- 
2.43.0


