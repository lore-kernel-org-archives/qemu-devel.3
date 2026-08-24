Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7311C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyU8A-0005Oe-UX; Mon, 24 Aug 2026 08:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1wyU89-0005OD-FX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:50:25 -0400
Received: from mail-eastusazon11012048.outbound.protection.outlook.com
 ([52.101.53.48] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1wyU87-00048F-B0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPdpcIQuygFSxM0G2BiE3bP3Gb3vHj+Dz10tiL+h15DoXHFa0AXEy5k9VIqvwEOoOvFb/eiQDK8Hw95hSuRRRWQf2K1vedFxD6ChuNMqb9rO2SRb6laJeAGIRX+42o/WOUAMVpx4uNxd9lweRoxtUBSKUp/ukL470wINRqXZrevdWKcevNuesnRiVyb/SX0yU5ml3/yiir3yx6zH3I92/JlhimBsvxL07awKExfEZeDlBcu6fA1U80cg3oGohFiFsfdlY6cAmWQwyenOH17QezFXvoLCg/EVMtk/3LtLTf5CTkqY97ZxYiyPIBxHM3X/ZFhHu/FggzXCpHRDDEjLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqXGEAPZorVAQCgilMyaltjUKRO43w8nx6VC8NlkFSg=;
 b=bxn3cUBot41OryiqRBFd3aRNpfKxUEMrDEcZarxqHPa6Ef0vfvYzhKCu3zlwZMSpI58jckI4h2M22NKv9CL5kdhO7xbZmTyiOsM+71PcIThzVs/VM0v2TEjARQJtFeTL0jqQN8LplqQPoot6jNYp4LxFGMqRQBqNUQ1cUpvRzNltGR5siNRrMiyJ4qOCf++bx3bZwQug8BisPQIQF7A5LCHIHrxtg1qPk4DCB5apjhz8oTnReHhrl/YBSrT6ymF82WKSOXvRa0KXLlE0FWbnyMbv9Yjn//upGNx+eRIWwuypK43LF9m8DLs6iTrN3UiyinU9jy10fs1EUdS34u+5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqXGEAPZorVAQCgilMyaltjUKRO43w8nx6VC8NlkFSg=;
 b=mHgIWnz3luXhDIk5GpgFdSmIYNVFChZa7Srqjj/OhNWMrC9OHgSC0oyHa/+aQln2fuwbJk5ed7m+q171ZSvXFTFE9+ZHtsQ5i6c0mLdCaowr1HyMwPx0KtU25g06oS0RVU5Eah6PXpnVxtAno5iGevbXjSZ/+TWxhu92GcXl3ZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) by
 IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 12:45:15 +0000
Received: from DM4PR12MB6472.namprd12.prod.outlook.com
 ([fe80::4a4d:4208:3862:fb7a]) by DM4PR12MB6472.namprd12.prod.outlook.com
 ([fe80::4a4d:4208:3862:fb7a%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:45:15 +0000
Message-ID: <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
Date: Mon, 24 Aug 2026 14:45:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
To: Neal Frager <neal.frager@amd.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 xen-devel@lists.xenproject.org, stefano.stabellini@amd.com,
 micheal.saleab@amd.com, john.ernberg@actia.se, matthew.l.weber3@boeing.com,
 vincent.stehle@arm.com
References: <20260805052723.2823538-1-neal.frager@amd.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20260805052723.2823538-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To DM4PR12MB6472.namprd12.prod.outlook.com
 (2603:10b6:8:bc::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6472:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2cdfb6-db75-4db4-4a71-08df01dd8b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: R6F/Kk4sikH4CKAH488XnS2/cMI03+Cx1ML21gmDpNigllhtMU0Tvo5FqRhERxAZcXKa2H0Wm4PSwxCxn96lC0OXZFjjX/arsacLqLxwCHkzP1CyD07wKPVjCrbaay2kfj3ox/ss2AWm1ZILEpu/FxPB0vfitrUsaLQQNVS9t90rihr7hqJs1Aedj2haySHz5eLw1Vq4IEtpkxZzbHKhm55/5XzMJXXiGaToXrPhbzQc9W8hktKYd355ps2tIq7PbOsC7ec4XqBMBp0coLkZ3/UrtO/UbQwQShw11f5e4lgayNjiUCh5nSlETVdeWch36oS16ZsXvkzmQuU7JGASxSaEsjDENzZxE9f/wIwnEV28STD+WruixkgJdqSa6lYXTg/lj8whV9RxIKZnvVlP4uEsf2WTDjsTkrcbRCn44OOjAQ9b6WNKMDVfXTaiP1r/d/qAIB0SrIPro27J2mCe4WPm69T8Ewrq2OV9n9fDAjkTNBmOy0NR2A8i1WzbykBuZi6FDSAyZA2fSgzm0bgm8rBWdkpSeqv8BQL9ajJ+x3rPoZGWZGbSDpg3kPF+JXShbvOjUbUrAmhxDx3UZq8UrJGDZcAEePFXEUC4/xl4Bbvy9MZ4PjMmVcGA1XrUpmC95T28JoDE8caFxJgAroz4DSaGfcvsU2I+lQebB446NXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6472.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JHd05SRFp0ZGRqVmFVNVhDZWtGbk52ZEFjQmUvY0Z4Uy94eW9Sd1J5Yjl3?=
 =?utf-8?B?aW5BSWVyR0xQT1BmdFErejhqckk3MHFLRFV1UHd3dzdQaHdIOGpocHB6NEF3?=
 =?utf-8?B?VnFDSERHU0xYOE1ROXFxb1VUS1JtSGFMbm01TU1Gek1QMERhL2l5NEdvWHJD?=
 =?utf-8?B?OFBvMUJaWndGMUJkNTczY3NJdlJ6TGJDa0xzNWdHSXl0YzVvZ2lZSmlhRjlq?=
 =?utf-8?B?WG9VcDYrSFI3Y0xPZTAzZE8wbnBvMFV6UXhDRVJxc1liQWFaTjBVMnMyTklI?=
 =?utf-8?B?MU5ORjF0R2dQSmVkaFV5TnZ5STdWWnhSWWFTb2cxblY1RGx4T3lsQ2VPeE5V?=
 =?utf-8?B?Mk05RzlJbS9BWjN5eXBja3FLeTBSaW5VbUZGREJSUWZFN2VYbHUyVUVXTXEv?=
 =?utf-8?B?cHFiRXhRakZFQmYzSzhBVVFBTm9FbzIra3lCS01YeE5rWXk1bmpYdzdVdDRn?=
 =?utf-8?B?Vi9RQnZocm56OHlrd0cvQzRSQkdYR2JvcnNTT1NBU0JrWitFbjNueW1lQ1VZ?=
 =?utf-8?B?NWsvR3RDbEtZMlE4VnJVd294U2FjTlpWQmpBQjNqd0tDKzNRK2NGNWVZTHda?=
 =?utf-8?B?MzVoc2lHSndxb0lobTQybkk1OEpIb0dNMEphZWZBa3hQRnFSZnV1MllSaVJ0?=
 =?utf-8?B?dmFQbUJEa281Zk1qRkRkWkk2MDBiZTVLMUtlUUtMWWNCeGdWZW0rbThPM3NH?=
 =?utf-8?B?K1ZlSHpwWDFUakJjTTJmdmJ5THl5L3pNS05JWFlGOEVwcnUrMVdVbjVSaVlu?=
 =?utf-8?B?akJBY1J3amQ0UXVsNytWSVY0a3hZRk5lcnFteGVlVnBhVjFMQjRGa3RqWkhV?=
 =?utf-8?B?aDNTYlJCVzlrVFVEMmFuQndjdEhzakQwK3BOZ3ZCVktuYkpqMGFubGZPV3ZS?=
 =?utf-8?B?Q0c2Y3BJeE0xdG4vOTVSUDFhQjdSdERjUUZYS2g3dFVIU1dydzQzU2d2dXVZ?=
 =?utf-8?B?bHArTTJYbkhhS0JKMkJkVnhvS3N6ZkJ0ZURwUHZ4RkVuNVNXc01TZkR6S3ph?=
 =?utf-8?B?SUlWVzBFbSswSld1VXpnV0QxclFSbjA3dFFpdjhKQkVmRWhVdlg2M3ViN1kz?=
 =?utf-8?B?MWpuYzdMMGpJUjk5aWlRQ0dSWHgvM3BjVHg2c3VWUkUvOGdMTHBhckUwV3o3?=
 =?utf-8?B?WEUrRkxkcU1MUlQ3TjF6UktsS2xmM0NVbkFLNkxKKzdiVS9Eb1dnTFZYVU1O?=
 =?utf-8?B?d05oM3FobVVIYVFkQ1lZU2x1akUwN0kvMnppbWtTN3V6dXJPQ0k3cWJwdEtr?=
 =?utf-8?B?WWUrSlN1b3dzWFM3eWo1eU8zdm05VFRncklDemVSVTBrSldmUWxUNTlhV1ZC?=
 =?utf-8?B?WUloeXZxVXo3amxsUmhqSnZic1EyTkhTb09kc0t0eFFQVzlYeENNek1HVCs1?=
 =?utf-8?B?VjRDdy85VytYc1V3S1E0R3E5ZXVZRHM3VURzQWNvUmFPQVRvUlZzNXBWRXps?=
 =?utf-8?B?bDhjRlNWZEdLUWRHNGo0Ry9KcDcwd2d4bkZtTnhCUjVRN004MFVWTGhPVStK?=
 =?utf-8?B?emJuQVR3TzhSR2FSTHBsRFpSVzZGM21FUm04UmJ2a0NWdy9hNXpwcWs5ejJ5?=
 =?utf-8?B?dVYwSVJCM2ZnaTZiME5rVTgwR3h0d1ZWSDloMnFMTFIxWVMvYVh6WEFpNHFR?=
 =?utf-8?B?VnVKQ2kzL1hKZ1BhWFUxY29wRVJFZFN5YXJQVGc3bW9XVG1LdE1nckUybzhZ?=
 =?utf-8?B?WnVnUWtzZ3hjTnZ1cS9lUWJuM0hYakVremdQQU5RNFVaNldhZUtBdy9od29W?=
 =?utf-8?B?WENtRXcrK2t3N0hnSEZxQWV2VDVkc2tuTVVuT0RhdzFYOTR1djk5UmR3NkZv?=
 =?utf-8?B?K29vbFB2WDZHUkJKMll4QmoxQkRsRG5nRWFXdEVXZnJQSEhkVC9VdkJFZ0h6?=
 =?utf-8?B?dnZqUE4wZnRvMWh3cjY4QmFNcVNoUnpCUVF5NHArU3lJYjI3OG9VMDBURzBa?=
 =?utf-8?B?M212RFJmL0UwN3B5VEM3anhrL3hLcjg2Q1RlRVhjengzcGpJTmhSbXBteGoy?=
 =?utf-8?B?cER1dldQRm1MaUNqR1BWS2RYVDRXKzd0MmdxeWZDSEtjeWFkaTZzYStkUDkx?=
 =?utf-8?B?akl2MDQyUFRZazYvQjFqTHlPRTJ3VVJiRUFZcWV3SkI2Z1ZYaXc5MkUwNFha?=
 =?utf-8?B?dTJwdGZ1cThiNkJIYS9wMTdRVlVOc2NtNUY3MVZIaWI2MFJiUng4U2E1ZU50?=
 =?utf-8?B?ZTh6NW1yK0hiUDhjT2JTMi9tNGV5NEkrdFMzZlhMVmtSQUNqWnNZd1JJakhv?=
 =?utf-8?B?NmFIYUh1UHZxc2piTzU1SDFHRVZucC9jUkVaZk9KbjlHejZsSnJOcVQxRkx1?=
 =?utf-8?Q?GvFtCs6hpLwIjMPzor?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2cdfb6-db75-4db4-4a71-08df01dd8b6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6472.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:45:15.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zUykAnEZR3KllfoZ2h8hZN68DD2o2qY2sAbkxB+WVrKpF/nLUHLRAwXzz/ZJKS9GUwqtjZ1oRqJ/npY+2X9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
Received-SPF: permerror client-ip=52.101.53.48;
 envelope-from=Stewart.Hildebrand@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/26 07:27, Neal Frager wrote:
> The -I$(XEN_ROOT)/tools/include added to QEMU's extra-cflags causes
> __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included,
> triggering an include-order assertion. Downgrade to a warning since the
> version is consistent in cross-compile.
> Ref: https://github.com/qemu/qemu/commit/e2abfe5ec6
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> ---
>  include/hw/xen/xen_native.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 5caf91a616..3e1137efc1 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -2,7 +2,7 @@
>  #define QEMU_HW_XEN_NATIVE_H
>  
>  #ifdef __XEN_INTERFACE_VERSION__
> -#error In Xen native files, include xen_native.h before other Xen headers
> +#warning In Xen native files, include xen_native.h before other Xen headers
>  #endif
>  
>  /*


This is a buildroot issue, so I don't believe it's necessary to fix from the
qemu side.

