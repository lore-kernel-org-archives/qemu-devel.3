Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00B5CCF9FE
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 00:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEzb7-0008SL-Lq; Fri, 31 Oct 2025 20:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzb3-0008S8-Og; Fri, 31 Oct 2025 20:35:59 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEzat-0006za-8x; Fri, 31 Oct 2025 20:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI0nYuO/paLLTDKVuOZ9X+4cPAd07ytz2HreJvQwg6kOZ+v1Hjehvsslbw6m0s3gaw6hwCMy/8IJGVut24M/xzcVW3Zde4azKA2FrT+lFEBh62guFZga+/jAArrLHlf/d7t63sfHuB/JOb04Cq2Ne/m3g9Je2IIK7zuDl9wHXC0PENsGRUWWaV4QqLtmoHpsWVO+etPzqPdr3umU7LFrA14ReFUndqTmlQGWcEvAngYKiZGAt6ufld1eyitNQeujz/Mgm+UyvE8nfBCxSxXyb1StNZG2nTKr9+VGK8VI1LL2cI6NESkF9Ua6UjY+ER1kXtqzcuAI8c+66yjPKrUbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEeMz2PIUhA5RZVEvJOEZfWuz7wtZnrPks0JGf8Qjps=;
 b=RIVyEvJg9QOQ51GO0tkO7JqGKqhTMzn5uikYYBLvWSbM3MnU3bfU7kXK978XxqLu2A6sNngxDfOQQ4PifAexxKZOorQrPA8LWHhHf4LrKs1sYPGCxC75xNUk/j6OgpJMjVxWdPcgd1nZw6TWzJskDvTT+tcVibpilOcYyqmK9tyQ5vKNG65ytWu/U7d7R6FkORlTfaLMnWeK36FJG+0qIDfah+J0ez7zO4VBOp/ITaWNVsfJlr/otQbbL6YkCuBDD6jqQPhP/1SKkqmWOsBLLpvLxuCWLXPXrJLd3VgyC/c3rDeSSRzqOTJ2/N7xluNHzQVjrEOpRsvuW/2pkyvGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEeMz2PIUhA5RZVEvJOEZfWuz7wtZnrPks0JGf8Qjps=;
 b=Syv5b8tKs9CwltehxcZ2wcV6pJjRVQGw1Lwv3go6ZQkj8/odEczfoUPF4ogifA2AF7g6IJEwe5e6ubnq43fGJYpdydIKktB0JiheCEYEQDpKso1YZIs8gofSSkxbbJVtBQYMGahwH1rrIG0vxNMzZ4hRZNvbdgG0VE1F+fwXGmBxYMO4JDTtp/jaWSEmMvTFwa9Uq/94+zHqvukxo4YRQ9VbwNPkcqVZW4ndepaAHJHIh7tYkU1rZ718W3thqrn3gx2Bx8NbCT5VHRuvsFldGxrUXTzFzcMtcwpYW4YEnAc/uxr/qCzbABNMRfPePcu4PPBfAASI+ywXDYB6IIPGTw==
Received: from BL0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:207:3d::32)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::993) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Sat, 1 Nov
 2025 00:35:34 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:207:3d:cafe::6d) by BL0PR02CA0055.outlook.office365.com
 (2603:10b6:207:3d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Sat,
 1 Nov 2025 00:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Sat, 1 Nov 2025 00:35:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 17:35:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 31 Oct 2025 17:35:20 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 17:35:19 -0700
Date: Fri, 31 Oct 2025 17:35:17 -0700
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Message-ID: <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-18-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031105005.24618-18-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: dce36f86-8440-4dc1-01c8-08de18de916b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RC3DjeetKRkRac/ikJZFVOKyD2cp6NlMgbydPEGwzSOlZAsu2fEVmqtct7?=
 =?iso-8859-1?Q?b1fiGlAUEnxM7NpgV3/DbnCTBTHXkqNYgSgjrYipB0GWPlGLzOUwaA22AX?=
 =?iso-8859-1?Q?x8vXsEVzzYZ2X9F5hVqORYqmJxWdpaYNq0Eyn2mDMHJZwW8cQ7I10KYI/R?=
 =?iso-8859-1?Q?SPWrpEAIlKPFbopWp/XPgjx0YkgxfcRRVFwquqEZNLOOf//UMpCNWe1ck/?=
 =?iso-8859-1?Q?TmFUBnwXBKnRFXOTNUgj2YAOWGn94gY12d2yOlL821KQUIJRfwWQRPiPib?=
 =?iso-8859-1?Q?ahWaexpH4bRUJzGIGLiGUzJEMoUCy0Dvr7imaJtAikY5nZTc1T6Slfzj8o?=
 =?iso-8859-1?Q?Ir5kstSo2Qfb18Qkt6Lm8OF+kWlVeMhPyKG+jraHHUggD0XX2AlTRipc74?=
 =?iso-8859-1?Q?Cq3FKLk9aPYFEHCp48UY5RSqrq+c4p6CcMuIJuOlZISCcJWHDqs3djG4PA?=
 =?iso-8859-1?Q?P3e2rtBIGakyhOV0XwYDdTAh5Y0HCme+FwmVBykcIlbreKkKRQyrwsESnv?=
 =?iso-8859-1?Q?W3ktOJJJKQ1acSWR1RmU19n6IjIjrcQn3BruTF932iy55YbpY/emBPTXvR?=
 =?iso-8859-1?Q?HE9je3ZwSjb2eE9vSQOTHljsy9KAw3zcdiyfN4vaN0H2G0prx6ymHgvvZd?=
 =?iso-8859-1?Q?ot862oW0y+44pHP+MzbK1wWBxzWUDFU8OaJ5ccIWwSxHs/FilS7t3CGrld?=
 =?iso-8859-1?Q?emwvb+l2MLFHHf7wRRIRGrxo0vpWmxsggA2AkMYW16Lpt9GKHL487KgaLQ?=
 =?iso-8859-1?Q?m/O4BnjbmeuGKrvaQC7dG5UCyiqCA+LhaDzn0/tT23up83mOqoST62o873?=
 =?iso-8859-1?Q?XBt5acGwhMBRMlo8Znmj0AmJleye4Iqwvnf5IBCY8zrU47HVIU8rPVKBCM?=
 =?iso-8859-1?Q?0gy9tA6mVFwDnvSomZNJL41LHAV21Q1HOAqF2m5rdPDpWHQTZa150AuQPa?=
 =?iso-8859-1?Q?Ik/2+oCUk6ZkMtP3vlyPjyAgHMOqSgLLLC7kuqaSkYqDAD7BbB+yaSRZx9?=
 =?iso-8859-1?Q?JX8+pYEb1OCGEDgigXSErIJ+id/ajeVJGTgLv4enyMqeA4os1LpB4hvHkg?=
 =?iso-8859-1?Q?gnO9Qu26/1WelKTbEpf2d5ljp4D7Bx379ZHmT8JfN5o4eLtnJ7FgKrLsOR?=
 =?iso-8859-1?Q?wEFBj3wTcsoaLP9agfj7Hht9fQMDqgftFJ9kz1yvfTRkI1PikMaQ/ptl2u?=
 =?iso-8859-1?Q?i1XF0i09kteSdo6XeJvbCVncI7URuJfeLLgLG/wGoRcZXJd0p2LzZqQbwR?=
 =?iso-8859-1?Q?AziSGSYlcM5yslKqJZPGbOuYHa1quCt9KgR8TScRYgMQlL03lCZ8l84Utx?=
 =?iso-8859-1?Q?e1SFD0IokUoLplPh1l4d0PdEVzlUwwB1mq74Owtqx9Y6WRZ/YABbL11oa9?=
 =?iso-8859-1?Q?xnX7wagFw49qtWCNm/O+rTCpb26ikc/qOHVhdYLWhMPQCPkUz1uNNqWGlz?=
 =?iso-8859-1?Q?224EWD/ZUMQl8KNmurt82xbfx9YMwL68LE/99Oi++aFJe5jIyNc01DJ8hz?=
 =?iso-8859-1?Q?OIHxY4wpNwm+U+0ioz8nM0CSOJRgLEUQurBQHHTPmkH33hDaAyPnUC9k4c?=
 =?iso-8859-1?Q?8zE08B7k7O4iYmkPGiu7HSG2MSyPwGZIKhjMyytrGsV2PlajArTLxOzUHG?=
 =?iso-8859-1?Q?RFp6RGo2cNSuw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:35:33.2871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce36f86-8440-4dc1-01c8-08de18de916b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 31, 2025 at 10:49:50AM +0000, Shameer Kolothum wrote:
> Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
> We only issue one cmd at a time for now.
> 
> Support for batching of commands will be added later after analysing the
> impact.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

I think I have given my tag in v4.. anyway..

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

>          case SMMU_CMD_TLBI_NH_VAA:
>          case SMMU_CMD_TLBI_NH_VA:
> +        {
> +            Error *local_err = NULL;
> +
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
> +        }

The local_err isn't used anywhere but by the error_report_err()
alone. So, it could be moved into smmuv3_accel_issue_inv_cmd().

Nicolin

