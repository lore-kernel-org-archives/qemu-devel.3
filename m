Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5FBCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3MJK-0000NQ-PR; Mon, 29 Sep 2025 18:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3MJD-0000Mn-9b; Mon, 29 Sep 2025 18:25:28 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v3MJ3-0002h0-AU; Mon, 29 Sep 2025 18:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEYF5Nmf08KWLwmf+8EyF8xn8gsw9EZNJBBMtoiGNxAdQ7DBv50LemSMvKoCvWrf8U/1mvqA0D6lOj/M8QKN+0XSrutHpvGQjza253xLAzX7Ze16NScGp4BZKeaLZeT10gu4tzPuFRMm6Ma1MM1geqhQEMocYP1SR0+itaA8CaGx02eTcsm2+FQiaOzUw+bD54vq7lrdIufSDO+3CfzklgWCeMp1DWe+LK1R2bKVXYuCpKOWfIqL7fAx/B2YeSZ3eGhV2S6LbDd4ZS6G/AwIocf2Hk+sUgAt8R+D+mCgVcLhEPniByfOV6SQAh8Tw27SkbTZ0wnhEJ60C0p20gZ6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYKdn+VTltX02wcXIAGkqGRSB68+myPRFtGvl/cK4X0=;
 b=efX1BULC+GqQ0Dj+p2P8WzUkCMm2E2ZvmVru7QQX+qs9d2UPtTYyHnyJGHzlVJH4lr+7hUO3gLImUPKj//jd7pZ+kRDlTbRXTYL1wadHSgOQqNNq8Zr+7VrMP2ktpj2WNuTtaZQk92rMgyYMi145I8NkFG16WAPD0H1bUoF895fIaVkEvBUs3CVo0yPb54fhSLzXcTEh4bzaVTQf09ea1WiPQQ3cBNudfZ8ceA37WxSEVUiWjn4Io7L0+aW0/ZzEuPuRTTubt92TkLPnQWgIxPmcRyv6E+wypMkI+tXSecnEZQf7CHH2+squx/JDk12H8cV61DJEnXhy//PciwjWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYKdn+VTltX02wcXIAGkqGRSB68+myPRFtGvl/cK4X0=;
 b=czbao7T0oRktjuey6S72+T852aDKwwkUTAiEtczg2e21UX0RWDrMPhDFng1LjvPPmjPGVoSUqqpKXecC2SJefdmiMe0wI3EdnNhlHCckXS0IRNfy0YQSNcYpFYp8egvRzzY4CUKOqDb99s3py0rbgBh8izH9jy+uDtT1hLr8Bl31E4DhsPPvf8kk8rAKpLoyX6ZvZZF1Lbp2w89ZERWAc3K6yEdk0swIbzJ+cfixXmEfvYXprlx5NglUIUyUrkyhY2ZjApmCV0Rn7h2FK+VweBWy7Vhpr9J42r6OcP3myEvE6oJF3FeYRYvi+cRjzIjolPO9Ni2mKkoyqyIUpz+T2Q==
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 22:25:05 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::8a) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 22:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 29 Sep 2025 22:25:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 15:24:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 29 Sep 2025 15:24:52 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 15:24:51 -0700
Date: Mon, 29 Sep 2025 15:24:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 05/27] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Message-ID: <aNsHMr1tf2aRFkvQ@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-6-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929133643.38961-6-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be7a9a0-231f-4fab-df32-08ddffa709ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWEzMFNJN2x4YWdvWW1TQitabnZMZ1oydWE4WkVuVXNMNVF5RFQyOXFLTWFT?=
 =?utf-8?B?TVdhVHNCV2ticG01WkRFcXhlM3B5RUtjYkZJRWdCd0NSTTVORGlTam1TTlNh?=
 =?utf-8?B?VUdWWmVpQkdabVFUVG8wQ3RSUXNla1lYZERDbktQNURzcXUyNFozQTBqS0ZG?=
 =?utf-8?B?SFdsbk1wbUxYbG1hOHRnaFVpSkZUeVJ2dkNWMVZrOWZWN3hZNGY5c3hWOXpK?=
 =?utf-8?B?UHQ1aVVaL0RtdE1CaC9vbERCd20rcWJmT1V6bG5BYWdNOXRsOFJVWFBIbURt?=
 =?utf-8?B?MGpBRGlmbWpQM2pEY2lsRWluNlUrd3AxR0NTOTU3dTcvUnFoWWV5cjVXWlFB?=
 =?utf-8?B?ejNaN3Q3YVU5NXFrYmJQdTF2MUpXeGR4dEo5M2NqK3g4RzU1M2JxR3ZTRGJS?=
 =?utf-8?B?eDVwN3FSYWpNQTl1TGVGK3VXcGZXZHdIQWJ5SmYzeFV2b3BBSURxSnpxVnFG?=
 =?utf-8?B?NDNRYXB5TGViQnFzaVVYblJWZlFBMkt2dWtCT0V5L1U2eThMWi9IREx1R1Fn?=
 =?utf-8?B?MXN1SVl6SThGS0pOaThzRkRkWFVSWlZsanUySmxJYi9HODBNRDVpQVhma2ty?=
 =?utf-8?B?VHFWQmFuRXUrWDU0NStsZ3ljRXB2TWR1akNEcGZYNlU1bGRDM2xaUmtPaEFi?=
 =?utf-8?B?d1pZbWExcHAwWm0wakorZG02d0NYSi9iblc4V0ZsV3hsN29FRi8rVUVvdmZ2?=
 =?utf-8?B?ZUgwM1BydlRZZk51cXltM3J5WldKZWxrQ0tNZm5Qc1BTbVFPaUJwVkFmQzYy?=
 =?utf-8?B?OXJPbkxKQWVIVWJUdTF6K1JzYkpQS0hlVDBsVW90d2dmRHZiYW5UVXBPN0Mv?=
 =?utf-8?B?TmpGNUJwdDNpOWRiMGxETlRWZ1ZoT2lLVkZlMHNUVkxsSVhESm5WanRmcWtj?=
 =?utf-8?B?L21JK01nMnFvaVlyQkwvSFRlaStTOVBLM1pMR0NGbW1MWDIzblhlSEoyU0sz?=
 =?utf-8?B?L29EZXlwbmZFRnBmcVlYM1ZBZmdSR01JY1FMdDQ4a3FOaThwdXhSY29VRDMv?=
 =?utf-8?B?Z1J4aHh5MVZzZGJtdjRmekJKVW5Gd0hqY1V2WHJYT05jMFBITXowbGY0ZU43?=
 =?utf-8?B?WDF2WFpSSUxYSUNWeW56eEs2ckNwdVdERlhpbWdCcTN3bUpiM25tR2JkNllD?=
 =?utf-8?B?ZlZXYlIxc1dFd3pGdHZjdnc2U1cyZWdjNjR4Q3lRUW80ekwrUFZ4VWxpUnd3?=
 =?utf-8?B?YThrWStJWmZyWms1MWMyb0xQd2Z6UkR6T2h1Z1RLa3RwWnVBS0V6UlhTcmsz?=
 =?utf-8?B?NU94WGF1T0NINHBSeFpER21sOHU1bVRFTWIrTWFlSlQ3SDBYeG5rNlR3SThG?=
 =?utf-8?B?WTVPcEhWcytJTXB1NEVsTUhTdU45SmNMOWhGU3YvSEJ1WXd0aFFaM1JRMEts?=
 =?utf-8?B?bWdTNjQraDRteWZibXRuaGRkNDJpQldPSHVkajFPRWhaUFNna01OVm9RUEVQ?=
 =?utf-8?B?WldpZkdySzRJQjRBWXcrbUdFYmpuRUdTaGg4VmduZjFCcHJwSXpPUlJPWmkv?=
 =?utf-8?B?ejJTOEVWMk52dU9nZlZWaWIxRXFkdlpVRFUzVHBLRU5BQmpZbXkzOU1zcFNE?=
 =?utf-8?B?ckFrbExwczlhYzN3SGcrbUtJb3JSeEhkMXd4aXlnMFV2UzJ2Y2xaVjA1elg1?=
 =?utf-8?B?R0NLZmcwdkdZY2wvc0lvOEdTR2EzeUJGbmpwSUErRjR2R1R0QXQyWnJQLzZm?=
 =?utf-8?B?R3Urc2kycEdvUStHL2FiNS82NkEyL2hyeisyNlhTbUl5eHRmREdHc2ZmdmRa?=
 =?utf-8?B?OUxxT3lHaDVhTG0wakliZi84RE1TZmo0VVBSMmVKaHRjbHBMWEM5UGpCdFpW?=
 =?utf-8?B?ZHBNM1NCamZLM2g5dGVxNlYweU92aWN5MGdMMFRNM29GWm1iTEdtTXUxbW1D?=
 =?utf-8?B?d3ZtalBzRU41Qk1VSTNwZ3BmdzdRcHBXcEhnNzZNUVFVMm03S0x0WUNSQzdQ?=
 =?utf-8?B?THhvemFiZ1U5Ry9NMkUyQVdaNGZ3M1J3anVYNUJwcXo3d05aZGdOTTQwdVNa?=
 =?utf-8?B?ck5SRldjUUd0KzlhK2xxREdzSXY5V3Boc08za3BBMk9BTWV2QmFyZVphbkxT?=
 =?utf-8?B?R2pxWHh0QlVQbjV5aTJ5TFJiMGk3SVBRR3ExUkNZV0ZqamRVMmx4K2paa2xS?=
 =?utf-8?Q?u0OQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 22:25:04.6716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be7a9a0-231f-4fab-df32-08ddffa709ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nicolinc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 29, 2025 at 02:36:21PM +0100, Shameer Kolothum wrote:
> Because we now include CONFIG_DEVICES in the header to
> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
> be changed as well.

The reasoning isn't very clear. Let's make a note here that only
arm_ss via hw_arch can include CONFIG_DEVICES.

> The “accel” property isn’t user visible yet, it will be introduced in

Let's use standard " and '.

Thanks
Nicolin

