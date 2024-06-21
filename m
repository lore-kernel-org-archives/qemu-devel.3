Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BB8C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKaUf-0003ZN-UJ; Fri, 21 Jun 2024 05:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sKaUe-0003Yd-8y; Fri, 21 Jun 2024 05:23:40 -0400
Received: from mail-dm6nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::628]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sKaUc-0005r0-Cn; Fri, 21 Jun 2024 05:23:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/2mQI9rWK2ZrTU7EbsXhy2sCIqs+39uWWzyyziFu0y4RG2G1IaJ05albJmIhwbaLgzUPMh/uTxi7TFSxAdYgI6nQ97i+oLlZCOsKqesGs55tb/bQcSdXrGieJXiXZkscZ/QBCALwCCLOICBYoAuN3rCJ3eW/w5cIGYA32TD8daJ5k4c3BqmNvOa9AlJCPHugXvaRaSqcVkB0kX8G4KurRyXxLKr1dA0jbRHQWc+KgABLU/8G6fAIGNq2ZMyQQPY56+5emImuSF9QAcc2NPr6UTeEt//v72jZtudMcuMtXHMI/5rmvV4fYEkIgw3fORNqCsFB1RmqlAPo4Pottslqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2lLoTnw648KvbZps9FujgHaaROazEzHTs/AYYbHWlA=;
 b=bAj3Mn610mp5Zoj08QIo0Vs/zR2m+imHCf1HUo5+KBGlBCl87bAtibCW/0QR1f0zq0AT0Etr778Sn/eIOyYwZRFsDByYNanWyXFoqqnAeoXEvJIhl8BP/wQyIu3SiO3EvHnn9rtVAu4aVr+nGdovKNjTr2br2FLzdz8d3GLuafwHOl8Ah7GtsXvnu0/tc0Vjsp3/DvfiHHr/2Lbhq0h/Eb6XsQa14V5LwgrII4Kzb4+5VgKnFP4ykPpZLM7CfAEATWG+JVGbQwyRlYiMiD+oxJkitkEo7/Kuk25bAfbTJo/3XtXubz2isLYuSPhMlMtvjEs0DZJAdOhjt8yuR7id0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2lLoTnw648KvbZps9FujgHaaROazEzHTs/AYYbHWlA=;
 b=fHQjyujSnZMXInHM2dTJO8Bbt/SPRq46PJy9irYL8wS5E9ZXRYYvjWhyXZpkxflqKVL9KTEwNXZMC4YPwTsAgb06+SwVzqfD9aeMYXMPNlz8brHErdUg7BJlIeyc7cZpojxkgMhT6bFTGhUYL2l3PYgQYx80McbA6mXz9bTasS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Fri, 21 Jun
 2024 09:23:33 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:23:33 +0000
Date: Fri, 21 Jun 2024 11:23:19 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v3 1/3] hw/misc/zynq_slcr: Add boot-mode property
Message-ID: <ZnVGh+fz9SJsdFS0@xse-figlesia-l2.amd.com>
References: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
 <20240620104139.217908-2-sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620104139.217908-2-sai.pavan.boddu@amd.com>
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ebaa97-cb59-4f7b-296a-08dc91d3d234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXRDK1JRQk1IMHZCVFhsT0JtcG5LR0NwYThrYmdCK1d0MkJWaWxmWVc1eFo4?=
 =?utf-8?B?TGtXUExKUXlPbTNaUjZ4a21NckQvWDFZZmFqcFg1WDJqTTJPM285azNnSndl?=
 =?utf-8?B?Zkl0KzVmWHFCWGgxdHhncUltM1E1a2ZJNlNHVnRvQlNJb1k3SktOWVpOU2VV?=
 =?utf-8?B?akkyZkxCckVDWXFSZ2I5ZytLQXNkNXM0LzhYYlhPSHByeFBPeWlqZDMvclJt?=
 =?utf-8?B?bWJqVE91NXdicjNjOXQ1WDdYRCt2L2xrSSszNmVNYVZ0QkJtSHlFUTNEMnFS?=
 =?utf-8?B?Vk5PVkd6VHJEVGloc3NYREgycmdYUlVNLzMzdEtuNWJUNXZaaDNmell3Y3FJ?=
 =?utf-8?B?cGN0N2d5S2JXMDc2eitNdk56dGVPRGtSdTI4ekVSV2xGUnBmN0E1NW5PbU9B?=
 =?utf-8?B?ZEVJVk5JNTNOczNiWHhSVm91Z0cycjFEandFRFJoZ0l0WnJvemRIa2xzOHNK?=
 =?utf-8?B?aWFpSWtteHpJSnVsV0pxa255d2tRVElYUS9Jalo4RWU0SVBEbEFmdGt4enlP?=
 =?utf-8?B?VEdrRTJ4VS93YS93UXZtYzdZdHIxb1h4YTFjSTZvK1NrblJ6b1ZwWngvOXUr?=
 =?utf-8?B?ZnJaTzh4K1JDNEtUTjRoQ3NwbExhbHpGb3pUdlF3OWFPNlduM3ZiOFc3YjZR?=
 =?utf-8?B?cytEOUVpMjlTckduUUVoaEcvbmwrU0VpWWt2R1piMHphTG5hVFhOQW10R3lC?=
 =?utf-8?B?MUlkSFNOb3FxK2t1aEJRZFBBWFhQYmZuVnpZRG1HWkJ4QTFPUWtNOVJ5cWVR?=
 =?utf-8?B?ekp0TmtUQ0pnS0dpczlaZmU0TzlDNitUK291N3FqZzRucU1rT001SkdYMURa?=
 =?utf-8?B?ODlmMHM5cm5FM0s5cHVTN1hhRnBNaEVoS1ZYempEdjFxSXFoWmdLcFdRZUE2?=
 =?utf-8?B?d2V1VkNOODJqaXpmeFJmakNrbi8wSnBMZFlRK1QyYmZYcEpETzQyeVhSLy9p?=
 =?utf-8?B?eXhrVERoOUlJYldLOTBoRC8xSDlNc0hoQzNzb21tdFppOSt4Ym9aUmdkYUpC?=
 =?utf-8?B?S1R2UnRjZ2xSWTdKanhmeWdCM2ZDYnZyR0xzeEIxT2NrejRjSktSWEdOZVJy?=
 =?utf-8?B?eVZsbmMxMC9xRmFIRTA5ak5xMTlvQy84Ujl1RFExNWw2RlA4MUVLeVJmTDlM?=
 =?utf-8?B?TFFPWU0zSWpiNlowQms2T2pOVkVJWXc4UWFDVVgvTndhb0dTUWNOam13YzFp?=
 =?utf-8?B?RG5hUnN5MllaTlhiUlMvTXllbnAva3N4clEyclpNbFg1ZVRuOTErQ3VzYVBL?=
 =?utf-8?B?eDNiUCtqRjQwT0RkdmxhL2lWdjhPVDZacVcvVmdBREZHQTgyRVhhOFc4N1BT?=
 =?utf-8?B?TW1nb0ZsZW1TVUNTdmpsWmVFQmVDZ0wyUVZFZEttNjFGZ2JLRGVPSEtWZFpt?=
 =?utf-8?B?dlFSV1E2NmFhN0RQT3ByamRQc21XUWVNQXU3Vmo2d3JzN0tiNGNna1haeEI3?=
 =?utf-8?B?eG5jMzFhUlRKQldXOEVDWVo0ZVpYMWM2OHpjUURLenB2ZUpnbk82T2hsYmht?=
 =?utf-8?B?Z0NHSFU5SWZHbWE5b1k2eHlpQUJDQ2VMNTFzR2lNa0dKRWZFUEtFbDdQWE44?=
 =?utf-8?B?NktGWnVoTlJFYWsyemtUVEdPWDVBdWpqdUVORUZjOXgwK3BydVhON3dXSEdU?=
 =?utf-8?B?eStObEc5S1Z6aHNTUWY0UTBVRlJKWWVMdVZZbjJUNUJvdXpLbHp2U3FEVHk2?=
 =?utf-8?B?Mmg5OHlwaTVibmtQa242RGNPeDdLSHNHaWVsVnBLVXJLcDNLTEMwcEIzSWs3?=
 =?utf-8?Q?CK5zubmmGk7AtkvtDc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpNdHJjMzc3NWdWejNDaXpuSHY3VjB6dzU0a2FIZ0RWby85RGU3S0ZwZDlQ?=
 =?utf-8?B?VG0yYW1WSE1KL01WWjE1T2hEcEI3eThNemJhdEhXdk9HSDA2SWtBWFZrYy8x?=
 =?utf-8?B?b0NqaDRSSjVNWGc4dXZYaDFVYXhSOVhjRWJjMExzOVhSZzJqMko0RXBFSXFu?=
 =?utf-8?B?OVUwb3BvSk9WMlpwckFtOWF6eXlWUmpJa3BpbXJQcHpkMTZPc3MwVDJkUEVt?=
 =?utf-8?B?UkpzdnhGSmNzQ1NMSDRndUJsTDlKOCtEZzZsWkJZZ2M4RmJ2TStzaVZOejBm?=
 =?utf-8?B?bUVWRUx6cmpxNEc1U0FqOTBkeCt6QkUyRk9Tb0hJRlZCV2ZtMURWVkY3R1ds?=
 =?utf-8?B?T2NsbGVkOUVSQ1A1UmxGRVZEYmlOeXkxSit4dGdZMWd0VFFIN3F4eHZSQk5z?=
 =?utf-8?B?ODVtQmJlM3N6aUdpYWNNU1V3cXFzYWNBT1NTaHpSMFpIY1V4MmRZNkROemV5?=
 =?utf-8?B?OHlkQkt6R1dxQkt0ekJ3clNXTHRzYVR4TzNrazV3SDZLdkFKMVh5RENYcnJw?=
 =?utf-8?B?S3VxMCtKeVViSzdSYjlrRnRaVStka1o2Z3ZHMklneFJ5NjI3amg2TXRvTXF2?=
 =?utf-8?B?Szh5NkxCVG5icjg2MEN0OFJWanJ1aVdEVGw1aFVFSE5kVURVNFVkVlBOblFJ?=
 =?utf-8?B?Zk5pTm14SmszMG9RZVNJZEsxdFJFMCtRQklFWnVqM1I1czROYUt4QjJFbzdr?=
 =?utf-8?B?VnJsVXFnSjBSbjU0ekRsT2kwV25vcEY0RXlvQ1EzTW5WOTNhMWVaZzdPRUJ3?=
 =?utf-8?B?YmlwOEg1SUVNcU1hRE9WT0VldURzUDJiM1RQZ0grTk9oTmtFamQxZGwyMkl4?=
 =?utf-8?B?cHBsV1ExNldYWmxlZnNlVTF1L0IxZVgycjdPci9wZ2F4U2cxWklMLzdkTERy?=
 =?utf-8?B?N1pXT2k2ZXRsM3BqVUR4MFMzczR6T0JIRlkzdjFQZ3hzTU04NDdabVE0NGwr?=
 =?utf-8?B?a21ZRmdGMGM0cXJqdmNFOU1BeERQRWFBc0hDc1BROXJVc2hVM01pejE1U3or?=
 =?utf-8?B?SUJYVlZUZS9YQ3VmNnFLckVxQ3ViRkpuNWpncG9pZzZNanFTVUFsNW95S2Iz?=
 =?utf-8?B?MEdVN1VabmxpN0VuOUxlcHFKRDBBQi9vdDN4NGljMHlNc0ZWKzR1bEx4M0tH?=
 =?utf-8?B?c3hCYi9HMmFlRTU1T2RwV2xMWFRTcVU3TnRFdFZnazNHc1pxVEtsUk1sSmdT?=
 =?utf-8?B?cmRVdVpVblp5TkE4TGs2bkgxRlByRlV4bHpMNG96RUVkdThSbkRrbE1KaG8y?=
 =?utf-8?B?eGtxMkdBbHlreXRCeVRjc1JIajB3aHZwSWtSVTRyZzhQT1NGd2JITXNWaXZs?=
 =?utf-8?B?U0dWKzZEQ1YycHJFZWkzcVlYa0ZSY2ZPejR3S1VZdDVwSmFQZ3l2NndCYmJm?=
 =?utf-8?B?ODBZQk0xS21QM1dKdjg5QmY5OVhtREFuM1UyWmJPWGtML1ZZZHdlUUd4eWR3?=
 =?utf-8?B?VHZMV1lQZnhCRU51QzBGbytGK1ZmZ2hwQ1FxYkt3NDRRVzlFTkI1UWtDTTgx?=
 =?utf-8?B?d29hU09lYmVzcUMvNm54aWFuSHUxZjBxSHNiTHVFVUFDcnVhOEFzMFlEc1hN?=
 =?utf-8?B?WnlOcXNpNExxUWtRZXhsUzllSUszWE9NVnFhb3BiVnVUMGtneW8xRm9IMHhz?=
 =?utf-8?B?aDdjVmpxaDZxdTQyWTg0OEVvWHJnVWtKNmFtOEhvVjY3QUtRZlo2ZUlKdEp2?=
 =?utf-8?B?T3dhdGphNWptRU5tbUFOS2hsTHBpaHFoNnhpSElyNWZSZGZVdnlFR2JoL053?=
 =?utf-8?B?NndKVk5KVXlWVUFzdE1YeFZKNUpkL0dLdk1IYXRqNExnaDlId21QL0YyeFVJ?=
 =?utf-8?B?K1NDZVRUT1FPZURVOENNY1JoSjV0aitranFrdHVvclB2MWN0QUxYUC9OeE5z?=
 =?utf-8?B?RUFBQWg1alVkdG9oelVWWEp1SDV5WkpPVU9mcXJ4VjdHaGhDTmRRcnlGNjBr?=
 =?utf-8?B?UDd1UHhXVHNKQ0twaFE2MjFzVDUrOWVpeDZRRlZzWUpMSkNCamhIeTAxby9r?=
 =?utf-8?B?QTZjeVhFOGtSWWpudjZvVnpYbWhMd1V6R0lwTFl1K2dMT1lMWHZzWXdFZHJR?=
 =?utf-8?B?eUZRbEZMVnZINnp5NklRRHdYeHpoT3hyNkorUFkrL1RwQVh3ZnBYM3cwWUpv?=
 =?utf-8?Q?Zl5YCGs4WJ41dHLXQLAGZx1WP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ebaa97-cb59-4f7b-296a-08dc91d3d234
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:23:33.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwehfjhBqX0N8XwTr/NU50G9vyJZfE21GfxX8fCxjAGAVEVozAxn9p7o11f3OWRKutWBqeW07mDK4eMj8Ac8/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
Received-SPF: permerror client-ip=2a01:111:f400:7e88::628;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 20, 2024 at 04:11:37PM +0530, Sai Pavan Boddu wrote:
> boot-mode property sets user values into BOOT_MODE register, on hardware
> these are derived from board switches.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/misc/zynq_slcr.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index 3412ff099ea..ad814c3a79b 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -24,6 +24,8 @@
>  #include "hw/registerfields.h"
>  #include "hw/qdev-clock.h"
>  #include "qom/object.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
>  
>  #ifndef ZYNQ_SLCR_ERR_DEBUG
>  #define ZYNQ_SLCR_ERR_DEBUG 0
> @@ -121,6 +123,7 @@ REG32(RST_REASON, 0x250)
>  
>  REG32(REBOOT_STATUS, 0x258)
>  REG32(BOOT_MODE, 0x25c)
> +    FIELD(BOOT_MODE, BOOT_MODE, 0, 4)
>  
>  REG32(APU_CTRL, 0x300)
>  REG32(WDT_CLK_SEL, 0x304)
> @@ -195,6 +198,7 @@ struct ZynqSLCRState {
>      Clock *ps_clk;
>      Clock *uart0_ref_clk;
>      Clock *uart1_ref_clk;
> +    uint8_t boot_mode;
>  };
>  
>  /*
> @@ -371,7 +375,7 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
>      s->regs[R_FPGA_RST_CTRL]  = 0x01F33F0F;
>      s->regs[R_RST_REASON]     = 0x00000040;
>  
> -    s->regs[R_BOOT_MODE]      = 0x00000001;
> +    s->regs[R_BOOT_MODE]      = s->boot_mode & R_BOOT_MODE_BOOT_MODE_MASK;
>  
>      /* 0x700 - 0x7D4 */
>      for (i = 0; i < 54; i++) {
> @@ -588,6 +592,15 @@ static const ClockPortInitArray zynq_slcr_clocks = {
>      QDEV_CLOCK_END
>  };
>  
> +static void zynq_slcr_realize(DeviceState *dev, Error **errp)
> +{
> +    ZynqSLCRState *s = ZYNQ_SLCR(dev);
> +
> +    if (s->boot_mode > 0xF) {
> +        error_setg(errp, "Invalid boot mode %d specified", s->boot_mode);
> +    }
> +}
> +
>  static void zynq_slcr_init(Object *obj)
>  {
>      ZynqSLCRState *s = ZYNQ_SLCR(obj);
> @@ -610,15 +623,22 @@ static const VMStateDescription vmstate_zynq_slcr = {
>      }
>  };
>  
> +static Property zynq_slcr_props[] = {
> +    DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void zynq_slcr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      dc->vmsd = &vmstate_zynq_slcr;
> +    dc->realize = zynq_slcr_realize;
>      rc->phases.enter = zynq_slcr_reset_init;
>      rc->phases.hold  = zynq_slcr_reset_hold;
>      rc->phases.exit  = zynq_slcr_reset_exit;
> +    device_class_set_props(dc, zynq_slcr_props);
>  }
>  
>  static const TypeInfo zynq_slcr_info = {
> -- 
> 2.34.1
> 

