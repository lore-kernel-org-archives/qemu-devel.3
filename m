Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C91AC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 12:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNrc-0001Pd-G1; Fri, 07 Feb 2025 07:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tgNrH-0001Ko-Ri; Fri, 07 Feb 2025 07:53:26 -0500
Received: from mail-bn7nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2009::610]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tgNrF-0000mF-Ia; Fri, 07 Feb 2025 07:53:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8KQBuBB2nDXDXvBFx1rLNOMzUcB51eTQ/gAR4HcLQ20AKfIXjwUiBh7KUAgJkOkYFh79pm/Dp9B9NyrcC2b30MUI4GZE92x1ZhZbgb+Vg05c794PSI4TfKBKQgR49hOhNaoQxR/WFEDy81TNE+tzUgoFJr1CGHWjlWGTERSOlgOHqOM4iOoXKxWRAJxnqJIbocSkH/1qxqsP704yjDHq/GvqjwMAuUHeXYTqpymSUNOZkOY24C20rMUkh7pWn+eBZkxEVzh3Qcxl+nOzWmusFGx/+pDBCg4pCj7x+VFrTgjFHoFFs8xirDVmU6qkHw234nMwrbQVJQCqecOOio1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuk/dfmyJA2/jcB2matVzFgwpGssMj6j/DoBaiPkRME=;
 b=olP9uTWNYrhok52VejduVZEgw0S8UWSNoGD24+fyA9kFQZ7eiQt9cVVZ21Bo2eyV85phCH/Rwi3/wkKO1wa5IdME2CIUdJqA9RZAkrxciiEoWa1e4DIzHPahKdq3XSyIt5diQWEw9S/6G3A39verVqTIrgrnGauHLjFQPe9g9TnMOSn46a3ZN0awGC3ipyJwpWe08p76g2IjBE1hz9Fhw+xNhcs5t6gMmm8mjzTXzaXf+9omGk2h5munzpAjeFa02HP48kpBxB9fsm9aIt8IdG3tiWGqpsktaxmhgnLJomxdw8vs/kTkJYiDbzJ0qPbPoMXiFyacd6fbv0m3iTTobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuk/dfmyJA2/jcB2matVzFgwpGssMj6j/DoBaiPkRME=;
 b=mSMpvPlOeFt2uIR7MmHUaB3lVpgfypiAdHjVB2sb5zfoSyerQmXtG7jdOP2WIiKfg2vW3xsLOslMB4Ai8A6/KPHe73In1SlQCVHqMW5SGRjrQNCYpoY41pXxtA0DYiPUVkw1MfS4KovsXMIVJTwIeYPC6YWKVMh+YXofgp462Ma79Z+Y4wBR4LBRLEczMDvBO/aNDUZ5hbWeUVtTGIg8mGW8V8yv4LyZZzCVJQmZobYjGNaPE9Mueq9NVvIjBz/F2aacGHm+iCvpo0H1cYtJ7bKerI5Q6ibkbIP4wfYxaslucUBw7siFIk78m4hGXtmcFTlC+TkTQCBp1i+uROx2Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:53:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:53:08 +0000
Date: Fri, 7 Feb 2025 08:53:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250207125307.GQ2960738@nvidia.com>
References: <Z6T3cX_fM-aeYbMI@redhat.com> <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com>
 <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
 <9112ba0694bd42199e279e37fbfc9dd0@huawei.com>
 <Z6XhF7VTw9jnIXCb@redhat.com>
 <64a4431fca6f429782a78c9740eadbe2@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a4431fca6f429782a78c9740eadbe2@huawei.com>
X-ClientProxiedBy: BN0PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:408:eb::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbf6ad0-e344-4df8-d841-08dd47765ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IyPx9GSHkDA+0d9AT3aHqjWVlcKilWlrxuy2M1LZfHZDuaqSe4IK2+ai/k6B?=
 =?us-ascii?Q?yu6CAqA2wp5KeqxGQmpcoBuLr73Y3Cu12TzuVq3M6eX1UMDCxWlTvvOaNr9J?=
 =?us-ascii?Q?/NlECPXgiFgvDayrDBD80xRuST/TMP0JNssDm+YK3em4VW29Mm/Gr1PpJlv7?=
 =?us-ascii?Q?8agNIsp91fQ5IgFpsnpHW9ZDvjWLSLEoBhd6VdBl2G6uXIXd2dnd3aIH4D42?=
 =?us-ascii?Q?3Ba50Z4zsFFKIaeSyx2+vk8+voFxSS1H9ElkZL39QsNmUNsSa/MttA0OzXFu?=
 =?us-ascii?Q?GPrepc2P7WPB/C33f62hoMgHVAibE9qRArXnOPcYuu4bb641Xv/zpWeTja7A?=
 =?us-ascii?Q?06wIDhpw6+j5W+KYytCCeRmiTesb3QkXmHiRczgH29zihcwsiiZsnEoYTdOL?=
 =?us-ascii?Q?gyB8eEJ+0zOy4J+FULyoAw2e3814VSa1X42ILYrygFV+e/de+a5Z+FHH/5mW?=
 =?us-ascii?Q?BAaEeo0vREHUxlKZhuj0NLyVK/XtCWJA6l/4yph5p3KS8YGvGUscGyE5H4kb?=
 =?us-ascii?Q?gIMl+sjJNcX2RGbJLlzmioNYmb01gFXVPZdyw0940OhI5gOAcXfxCPudFTZb?=
 =?us-ascii?Q?jWaxT1LZWDq0QgIc//tYHu3/VzSkvR+GnyRDiGorBafl1u4pgY334GrUvWja?=
 =?us-ascii?Q?hn5ls7Tnf5wpe5Ca7AOwwQQ+KMPa5XtXZYcx3vkhnxM51lnbWk2a4N4W589s?=
 =?us-ascii?Q?wmkUJ2VcR6b5iQdhM1ZTCYXxnI3LgwHYTNasmrAXSgSDNWVc8D/LCBELJzX2?=
 =?us-ascii?Q?s7K95JDDfr1RNVnPVc7XsYYUL8PjYCzzYOYxRC/xO3aMKIMU6nhpvPDfpx3V?=
 =?us-ascii?Q?x8fJZpLlaBOl3vSaSW3d7Su6TaiDYt2uLNM6MREDwy7+RHs5BuGj/2Z94g/B?=
 =?us-ascii?Q?05v2UEqTSO8ZFsUvtgnaN15f7FKAgxSc1UV9S4A+jbcy+nVzCXjz0Z+unHg7?=
 =?us-ascii?Q?pBO1kI2TarijKMOQ1EydT6j6TIm7+L4nA/Wwkzzc3zfuAwX952jnonnDO+wh?=
 =?us-ascii?Q?MoYkgveJtpbfwCeG37EQgQhXuXEVkvk+yLbaM0NL3ckffq88Q0SpMrW4FOI5?=
 =?us-ascii?Q?/dXfCJOUVSzrsa0goPdTxccUrCu3KLp/h2/Fqbj3051h/u2ml8+m3c4/g3bS?=
 =?us-ascii?Q?ytRIx/z2LL3LUSEgwYQM/+ify/Dn36K/VFZdkGJLwjuofBDl7UbAzCVL1Tde?=
 =?us-ascii?Q?Zub2z9DwZZeFqEwWDBF8yyxod68h23z4h6RRN7k4HmRTIkQhjd2YDTZR8Jvv?=
 =?us-ascii?Q?HQPHK70TrOP1P7MMDi0mtBSSBHz/FdZQeU0QSvRYgbPvxtxGY17SLHJpwrju?=
 =?us-ascii?Q?ei3ZAI2xglz7fhWixaQm332uizMrw4/ltGvYRgfU215BplzMkH1jv1Z5WDBz?=
 =?us-ascii?Q?f3XPS8MDMyUmFVpPEkJ+Z1V0/J7G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06hwFRpIOhYILH8TY6xVzxmtZmGvuUZFzQEUUl6YZaPhAZdkuFRpulklFzJv?=
 =?us-ascii?Q?2ChFKUIJYcRD4gCOhnOZhMPY/esKUAyxQLU+27TnJ3Hm2VBQ2Imz+2aJ/U+z?=
 =?us-ascii?Q?dKV4TGBDCv0tseogweRSQ9TEDM5VEBr0ktTwNvs0jhkHnMnVIxleJMsD8JqM?=
 =?us-ascii?Q?HzybouFxBwaUnnJh3WaTlapaFiFW+NOiF82VLYWXepGfLWx0dEUPA/u5Rism?=
 =?us-ascii?Q?Xao8ShiwsgHwlkviWM8uJCV9hSFfoVgjpzzJlQj2V0h/RarP8ciKYqvy2C/B?=
 =?us-ascii?Q?97/Ik15KUcr+xPnS3DaZa4nzyHa3ItbzvBGYSkvSHxuhrl2jWEdRTCgnXRwD?=
 =?us-ascii?Q?5xLzvDTm1xh7vtnXmXyeyb0JpdTGNR8ydXnRYXv6gcTThs+sML35piuPwszb?=
 =?us-ascii?Q?Qq5XC778WFhicScuG67bGesnV9S4keoH4BhLhPpaPawQuX90xA5JtSckdWnS?=
 =?us-ascii?Q?l0/zcEOCjyUGId/S9Et7O/pnkt4bZv9be5gYgBU2NoFZovFZUc/72EGmldcK?=
 =?us-ascii?Q?OavEL2ozQzoifbFO9DaotYHOatyGCnQoJzix7Ge+v5LaiC7sYaFohF+h/K3k?=
 =?us-ascii?Q?UQujJ7VlohNoltmdPrEb4Ye26MHhkisqAO83OiVp3VR1ar6o9zuSuarVdq2N?=
 =?us-ascii?Q?KQ3J9SpTlnZU+gGqblj3Amb3bfc+l7WIEm47RVRxWiuZYJ+S8lKVXciWDBNE?=
 =?us-ascii?Q?CY16dpGmJO2OzBO6Ww9td7tOgqXB031TG4vSJSt1Ek7OJ7pxc4whH3d66QbD?=
 =?us-ascii?Q?rTUyr/IwxVEx1c1hoQux8XRsAAbW04SoKaQoBLXdqoXQ/Pa0keAmSKPel+0W?=
 =?us-ascii?Q?31gw0LrBY+q1iVMShUCOquh4ucywIf71wKC6ASwnU+hj6WTcWVNVtNiON/ag?=
 =?us-ascii?Q?5yYNaMey3PMtjUyLspbiXQXETiLXPUAV+oOv3ZiuQlg/F5TTy/fBlV9Jo14p?=
 =?us-ascii?Q?uM0Yy4SPBs/Q7hR5QkYqVRDSiz6EgQ6T70pkrRKQrPNHZk2Fcb20xXTHXYya?=
 =?us-ascii?Q?Rj17aLSKCLt9RuxEpgwFwS4fBMm2MQ+IX9QK/CjE6W7URMrixoV7J+kV3KhJ?=
 =?us-ascii?Q?YaX9033/08BpoVuOT+W0ujO6OhF09BAxDH6PdMeNEIoIw85H3PAaApP1iVpd?=
 =?us-ascii?Q?81au7Csy77KWgZkdqAOM5tJEXbTnZzkiF8FefqKaOiU4KHAatVsKKTLoWjBj?=
 =?us-ascii?Q?VX5+N01uEc7spo+x01L7XApIgtnpZq/edidlyqTL6AJXnUrGVWOM+YVSBlSy?=
 =?us-ascii?Q?rhaGQn0wSuifWLwv13IUf+dkiLdf7/SJcY/jwg8Ppc2hqZIRbzvmyMc6SHrY?=
 =?us-ascii?Q?zdFqLNvmsydWyDd+rkjHxK3zfhv6o4WH8idqHnXePGXsK0b/qcCjIsDWtIGc?=
 =?us-ascii?Q?MoKImC9/BHzQCG3varMeSW+9hF2SqXroBh82vabwZN4Z6ghmsOjmWSGwxucg?=
 =?us-ascii?Q?wJ8FbUE/cVPnLBBvXEKO1NMLr/jS0pI6LBQ+Zv5GVA6HfB+ouElU9V9MAj2C?=
 =?us-ascii?Q?oYqsUHSiFNa+CVTehy2+2fo699aUYqY9nNa61Xl4zziKCOpqbau12UNkZm3u?=
 =?us-ascii?Q?z2j4plRktvcKwzMkzOP7IJGp1rh9tgwDd4hn8nf7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbf6ad0-e344-4df8-d841-08dd47765ef9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:53:08.3588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7VlUJ0D/NUTb8XgIwWzEyHRgiUuzsAY4McOoTvq4CGdKIVnJzPBHYJfXgWfywXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
Received-SPF: softfail client-ip=2a01:111:f403:2009::610;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 07, 2025 at 12:21:54PM +0000, Shameerali Kolothum Thodi wrote:

> Just wondering whether we can have something like the
> vfio_register_iommu_driver() for iommufd subsystem by which it can directly
> access iommu drivers ops(may be a restricted set). 

I very much want to try hard to avoid that.

AFAICT you do not need a VFIO device, or access to the HW_INFO of the
smmu to start up a SMMU driver.

Yes, you cannot later attach a VFIO device with a pSMMU that
materially differs from vSMMU setup, but that is fine.

qemu has long had a duality where you can either "inherit from host"
for an easy setup or be "fully specified" and support live
migration/etc. CPUID as a simple example.

So, what the smmu patches are doing now is "inherit from host" and
that requires a VFIO device to work. I think that is fine.

If you want to do full hotplug then you need to "fully specified" on
the command line so a working vSMMU can be shown to the guest with no
devices, and no kernel involvement.

Obviously this is a highly advanced operating mode as things like IIDR
and errata need to be considered, but I would guess booting with no
vPCI devices is already abnormal.

Jason

