Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8552DC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 20:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugUuI-0004qV-2q; Mon, 28 Jul 2025 16:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugUuD-0004oS-2e; Mon, 28 Jul 2025 16:57:10 -0400
Received: from mail-mw2nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2412::629]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugUu9-0000Bz-Pv; Mon, 28 Jul 2025 16:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIGRWqjSud3rLPQkfOl09vsP4z4tR2LbH3vDidKobTSq17giOxdp3L3nQ2z4pOBt0oX+zvm5Uh9abhXcJRLd4gL3kcaX+S9TMtOg1ZOLF8Ke8Ndu+ckm4v8FeLJd551P87B6FubdGCez5d0OGLBv9seHXFY4GCJrKNis3aQ9SFGFFkzfchrnemMhW73JYxpdtCphUfM/fBQjw1JFjJbmXZ23ybCflwZPmZJIz5CFEZzgyv1ezguB9adwIIRtQqYpSTAtbQQ5Le6uvlB0mhFwvZ/5vpPO8I70vtaUTzRYh+VQkYE3/7QK40iXm6LFfOfIMy+F+ryX5WNR8Jjt7e208g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5LVHphMRZH3dmj4T/NlL7R+/QY21sRxDoMBV9o+KqQ=;
 b=pPeNTPQ6yuoh7FVWesADJUt6aG96MXOZHg/ajnCkBYGPQaggWU+rJC/UxuVhIcQFniIRLIkG1NFld2Zvl3qHSvd/isccLEiU+BEx8IyN6DFSFKGKRrKj+T3teqLA/Wwzjzc0IN/BYji3Eds5zwAA2d0vFyJMGPrmyaTOdi4mpLcsHCMOsunUAIdEiIYo/1nVlzjT5JNKW7R5ucJG9QgyLdCBfgV/qHkcH7ieu9mst4boH3qXK+zBC3MmHYvvrsKMj0EnYO62HOZwnfG/mdCVkUwh5FN0sjNGx5jNyomfe8BiMi01j2MRh48sXal/EkZK34ZdAJd1AlsAgMHmadacww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5LVHphMRZH3dmj4T/NlL7R+/QY21sRxDoMBV9o+KqQ=;
 b=m11BUZvm9OyFTc2iAhVA1mJ2hGSFU5IViLa4HcaxfJ3GrlMNPNc3ATm5KW6mHzU61yY9rbC4eOkZH3lfUuoYRWEqRkn6kZS2rtLhoBAawdMfojgI1vfyQNVepDDdlXngk6Fd0gFIDICfMf6QlbtHB1tsZtcGukaKK31hH4yrQrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8de) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 28 Jul
 2025 20:57:00 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 20:57:00 +0000
Date: Mon, 28 Jul 2025 22:56:52 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 07/48] hw/arm/xlnx-versal: gem: refactor creation
Message-ID: <aIfkFP02tza/IGth@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-8-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-8-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::6) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 811b708b-cc64-4259-264b-08ddce194bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkF5QjI0MjNkZ1JZYXdHL1p4Zng2aWFMYkxHOTVjaGVSODNXYnNidlJGVHp1?=
 =?utf-8?B?SXdFVmw0U3BVWUcxVk9MUlAyMHltbG1YMmI5WHpCTVBlaTNHVzJtU3ZSd2No?=
 =?utf-8?B?R2FOUytlL2VqV1dBclBCQ1hXSVVzMGZ3cnBoekZRbkNKdmFrMEFHbXBscERK?=
 =?utf-8?B?Zm5tNGR2ODNzazZRc0ZlL0c5R3NoQVVJaGVIVThpbEJtUklBWjMzQWIvcUll?=
 =?utf-8?B?SHlraDBTcjZ1dUpZQkVTZE1FRUdvbnlYTHpSNHR5ZnRGd0dkRXJqbCtoaFZt?=
 =?utf-8?B?L0JEZTFldXBmZ3dJNWs2Vm9XQjdCOWticlo4bTZjaG5lV05mb200aW9tT1Vl?=
 =?utf-8?B?RG8zWjIzUWtHUmtrUURvTjE3MTE4c2RUM1FwbzBoSi8vNDREYk1qZnJUQ0kx?=
 =?utf-8?B?eHJvVDNkVU5FdVpGMHEyUkttV3F1aVpYWlArWEkrNUFTa2V3c2Mwc25RRnFi?=
 =?utf-8?B?ckk5MTBsbEw5YjFIV1BGdXdPd0hsaUlsZHlTTGk3OC8rUlBlMlBjQW8yOG1x?=
 =?utf-8?B?MWJ4QnpCNXRnckliZ0FmbUxpL3hSWkhNbUU2Nkl6M0w3MWFuVE9CWVNEaW45?=
 =?utf-8?B?YWtGdDVmR2xsaFVzTTJwZXlCREJzNTlheU1OK0JkL0FPVE9rSFZMaW5zTllp?=
 =?utf-8?B?cVluSnNkM0NoS01mcjFPRGpsSW5ySURNSUpQRmMwTVBGTE4zMkkrQlRnbXlI?=
 =?utf-8?B?cE4zVVJBWUp0Qmc1aGZMZ1BEcnhscFRlQVFiYmVoWW9haUR1Z3J0WllMT3Ey?=
 =?utf-8?B?WTdzcVlPMUdIVU9ndDk3MGU1YTBCY29zMDR6MjVrVEpOTkR5b3ZBajdyRlI2?=
 =?utf-8?B?SnRqRFlick55MllxcVBEVk9oWGYvVTVvU3BCMnJHWkE5b2tMR2FIZDV2Y0J6?=
 =?utf-8?B?VVduK215ZFgzeXMvbVYzd1FOeDIyM080K0VFLzJRUDZtWDVRZFk5N1FxV1c2?=
 =?utf-8?B?Y2tGQVhWT0Z5bGY2NWx6RTFzdEN5NEhHVXIvL3NoSFVTaXE0cVpNM3JGcHAz?=
 =?utf-8?B?SGFjWEhtZmthOTg5R2grVzZ4ZFJiMWFJek1tQmRoM0tJVkVYa2FCQmRrbnJ1?=
 =?utf-8?B?bEVTUDgrVzhCRVJlS05ncVpRTTBpd1R4Z2ZKZFpDOHo5WWd6Qm5lZklTeVBl?=
 =?utf-8?B?US9wVTFVc0RtWGJSa1MvNU9jU0VxdWdkVnJYSnNQODI2aWJJTngralYxdk13?=
 =?utf-8?B?RWxmVWJucmV2RkdtTEhFanZKUG93cjBCZGRNWlFPMlJ2TXNzblFNTDlYa282?=
 =?utf-8?B?RFRSbzRHeUFHeWlqSG1vVGhMN3JnVVY1RjR4dE81R1VONzhibEV3ZUlLckZK?=
 =?utf-8?B?QzhmTXFLamFXejZCZ0VaMVhHMk1sSDJYZmdxM3lhb0tjSjJDWUxxTTJ5b3ZR?=
 =?utf-8?B?azVrVjJiaUorYnptSmZiWk93T2IvUU4za2dWUEdIeGluTmRudnk2Sml5Tksr?=
 =?utf-8?B?djRxZnFKUHlZOG5jSk1wZ2lRUVlBcXZUdFE3bGZDdHpjdStIR0dJcVZFaTVr?=
 =?utf-8?B?Q3p3WUhjTkdtSEhQekhlYVpaQmxqKyt2elRWV3pEbXRHbEIxRE1RamRmZmR2?=
 =?utf-8?B?ejFUNHk4bzNPRWh3R0hlNXVaa3ZMZ3JneUtCRllFbjh4MEtMaEF4VjF4TFJo?=
 =?utf-8?B?REVBK1dCYUNkbHByTFhXUG1yYU0rTUZxQ2sxWDlJdE1TOG05QVJrMk1HcXBW?=
 =?utf-8?B?QnpnTmtmWngyTGUrajZoRXR3dGR5bjV6NzRYWlB5endaZWF2UnZuTUV0bjUr?=
 =?utf-8?B?cTh5WktzNUJQM21lcWtySGxrMDJ5azdqcE5FdTJxcE9PdVlhU3NaM3BRS0Zs?=
 =?utf-8?B?UE1YUmtac2dkdnY5VUwyNlhpUE9GMnljUDNLUUFEZENiUkdYTmFoNzBFUi9E?=
 =?utf-8?B?WmdKZlJyZWNEZnJjRGwva3p2b29WalpwUTVpZU0yR1dGcm1ZUEdQa0R1Q3RW?=
 =?utf-8?Q?DZN1XTxEQT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amkyY2IrY0JZSlVTSGN0SkQwUG9YclFYc0xuMy8yWFpoR2trcGFFQ3Y3REJt?=
 =?utf-8?B?YmZHcXpmVzY2Um81UytvTStSdHBRMDdRUVFiWEhKMW12bENWUkJJd2w2YlZM?=
 =?utf-8?B?ZSsvMFZmV214cnN4YjBpZ2hYVEF2eHd6YlVWQWNTOWVVY3g4ZUpsVlB3OG1t?=
 =?utf-8?B?TFlkZU9xUG1ud0JxRTFLeW02eEVGWEhZbUY2TzJCdGxaUTNQaVYxelBlcnhB?=
 =?utf-8?B?V241eEpEZHdGMDFFYXRLeGwvQTBOemdEQ2ZKQTQ0NHR1RmNkVE1MSldQSVk4?=
 =?utf-8?B?OENHZ0lqMkZnNzduVG8xcC8xTExORlNxNzRQQ1ZxWm8vV1duZHlyR09yY2dH?=
 =?utf-8?B?UVFrc2F2eUxJakpvTm1QZVVub1JseUxWa1ptQVByanFjc2hRb2ppQXJ1aHlJ?=
 =?utf-8?B?cE5ZQVJiZkZ4T1I0bVJjUEtNNkp5UC9ZeUZOVHhOOTVvNDc5T1dqSjRxbnEy?=
 =?utf-8?B?SERZenpnUC9oanlkOGdBSEUzaXNCc3Y0ZFhBODRKT3p0cStCM0NXSnAvQVFK?=
 =?utf-8?B?SGNZYWxidDNNNmFJRFA3M0U2bFVuSDQrejI5bjNndWNacEx4SEppdFlMSXRJ?=
 =?utf-8?B?NkRuQW9YYTU4M2pOYkVXSEtCMTF6VjM3dDZwUklzL0lkUWFjc3VKU2FoWDRo?=
 =?utf-8?B?K29wcHFwb2d3UWdDbHYxb3B2QUJieC9SVmFEelBKZmdqTVFyUVd1QmNSVndJ?=
 =?utf-8?B?L1pzR21TZ0d5clNLL2RSZ2IwcTdPWFlTSFFHc3hEdXNmdityM3YxSXM4b3A4?=
 =?utf-8?B?cmt4cm5kT3VuclNVQXdjZmhCYjhjeG1XYVZHM3VmZUN5Q0JObmgvYkpNdVZ0?=
 =?utf-8?B?Y0ZabkxlbURIUVBmUmFuN09ld2JrelNBYnNDVEIxeHRPaDZvOVRzWHNNMzg1?=
 =?utf-8?B?Y1ZSZVdlTUJQOHlDWHlnMzRXRTNhMnFMS3RCRnNEZU9EdDVUR1FYRVd0eXBp?=
 =?utf-8?B?cFRDcjRMRWJaWDg5U0VkVGdlWHJsamk0VlVwa05TU0VEa2I3cFFOemlJTE1N?=
 =?utf-8?B?c0luenpIakVqb3hZU1FvNW0xUi8xUFlGd3UyRlRHUlpTQ0RFUEZ3WGZuMUNK?=
 =?utf-8?B?U2VJbklFMTB5OEszMEtPNjBtWWZ2K2svN2VOT05KU1c0MVhMN3hHV0hhVU1O?=
 =?utf-8?B?TkcwYTM1QmtMdjJpbmxSSURPdjN6RTFaM3FUOTE0Y2Y3djlIY0hFdk5XUEsv?=
 =?utf-8?B?NUU1ZisyaGErQ1lmb0t1QTRHWDViMVphRCtPUUx1VElrSlFxYk1pZEw0Si9E?=
 =?utf-8?B?dGJwVHJtY0lCRXVzOEpBb3FmcEhkKzlGN0o3UlhiZHp2K1pmYWxIUU1lczhZ?=
 =?utf-8?B?UGJBYVRwVnNkY1ZpTlk1MTk4UldYQUl6U1oremFaWUFKam1rUEtlYzBNaXpw?=
 =?utf-8?B?SkV0ZzR2aTBjMlhWQkVtWUtmcnM2Rkg2dUtRQlhTS2c2MUp0K2hlc0tSU2hS?=
 =?utf-8?B?SjJCMzY5OVpSQ0NlanlJMHlmeGZUK1Vrc2g3MnA2c0RNcEg1Yk5IN1ZpcnY3?=
 =?utf-8?B?dXZHazVDWko4MXRRNDlhM1NvRnpZNERSc2pyRnZSL1kvMFNBbXNocVhZVHdU?=
 =?utf-8?B?S2JMSVV0UERXa3N1ZEpZOGptZFFWREdoK1NnNHNRbzdOM1lXejJCNTJ2amVB?=
 =?utf-8?B?dUlTRnpTVDA4Z1V3SFZneXM4NnhUUTZqdldiQUZLdWVla0hPbTNuWm9mTEpi?=
 =?utf-8?B?VVRDTjNsaE9nYXdLRmthdExwMHNrQzRyd1ZhQm93RTZNa2l6dmJmcGxCakU3?=
 =?utf-8?B?VVp5aklKdVd5NWM4ZmN2b1QrTkZ3WEkyVEUwcCtITDdGWGpxbDVqbWtXdW42?=
 =?utf-8?B?a3RXUDRlYjIydHk4eElHbG9wTFpQSXZFTWhQcENWU1oyYmw0SURvVmQwN0Mx?=
 =?utf-8?B?aEhxMFphRmhpS3dFaHBGa1RFcjNKOGNBWDcvSVdKZHJOMlM2My84RlU0MHZV?=
 =?utf-8?B?RnQzajRVbHk2SE1ncEZyckd4WUI4NmNDMkF0aG94WlN2d2VOK25vU3dOUW9S?=
 =?utf-8?B?SDN5b1hsV3hGVmpWVFlHeDdCQUdtU1BWZUZQUTFGM2djSExOK0NRYnhhOWZU?=
 =?utf-8?B?K0pxdjhZQlhJNWtTLy9NbFJLVktEOStyRGNIT1ZheDJDWm1tbExXcVAvTDN4?=
 =?utf-8?Q?ZKe/dEoTnip0agPtu2zArxLJv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811b708b-cc64-4259-264b-08ddce194bbc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 20:56:59.9518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tv2YhjM2HwRUKiu20PN9c1qeZRrSsrWQRBIlHSAxTKU8tWpdeXKqRjDLhcm7EGnmfuAGIfPzrxnz/gbtjzTqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0
Received-SPF: permerror client-ip=2a01:111:f403:2412::629;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:49AM +0200, Luc Michel wrote:
> Refactor the GEM ethernet controllers creation using the VersalMap
> structure.
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |   3 -
>  hw/arm/xlnx-versal-virt.c    |  54 -------------
>  hw/arm/xlnx-versal.c         | 151 +++++++++++++++++++++++++----------
>  3 files changed, 108 insertions(+), 100 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 4a7a2d85aac..1fcc2b623da 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,11 +16,10 @@
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/dma/xlnx-zdma.h"
> -#include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/nvram/xlnx-bbram.h"
> @@ -76,12 +75,10 @@ struct Versal {
>  
>      struct {
>          MemoryRegion mr_ocm;
>  
>          struct {
> -            CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
> -            OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
>          } iou;
>  
>          /* Real-time Processing Unit.  */
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 99ce84d5a46..09f87dc76dd 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -36,11 +36,10 @@ struct VersalVirt {
>  
>      void *fdt;
>      int fdt_size;
>      struct {
>          uint32_t gic;
> -        uint32_t ethernet_phy[2];
>          uint32_t clk_125Mhz;
>          uint32_t clk_25Mhz;
>          uint32_t usb;
>          uint32_t dwc;
>      } phandle;
> @@ -55,23 +54,19 @@ struct VersalVirt {
>  };
>  
>  static void fdt_create(VersalVirt *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(s);
> -    int i;
>  
>      s->fdt = create_device_tree(&s->fdt_size);
>      if (!s->fdt) {
>          error_report("create_device_tree() failed");
>          exit(1);
>      }
>  
>      /* Allocate all phandles.  */
>      s->phandle.gic = qemu_fdt_alloc_phandle(s->fdt);
> -    for (i = 0; i < ARRAY_SIZE(s->phandle.ethernet_phy); i++) {
> -        s->phandle.ethernet_phy[i] = qemu_fdt_alloc_phandle(s->fdt);
> -    }
>      s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
>  
>      s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
> @@ -207,58 +202,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
>      qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
>      qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
>      g_free(name);
>  }
>  
> -static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
> -                                     uint32_t phandle)
> -{
> -    char *name = g_strdup_printf("%s/fixed-link", gemname);
> -
> -    qemu_fdt_add_subnode(s->fdt, name);
> -    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
> -    qemu_fdt_setprop(s->fdt, name, "full-duplex", NULL, 0);
> -    qemu_fdt_setprop_cell(s->fdt, name, "speed", 1000);
> -    g_free(name);
> -}
> -
> -static void fdt_add_gem_nodes(VersalVirt *s)
> -{
> -    uint64_t addrs[] = { MM_GEM1, MM_GEM0 };
> -    unsigned int irqs[] = { VERSAL_GEM1_IRQ_0, VERSAL_GEM0_IRQ_0 };
> -    const char clocknames[] = "pclk\0hclk\0tx_clk\0rx_clk";
> -    const char compat_gem[] = "cdns,zynqmp-gem\0cdns,gem";
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> -        char *name = g_strdup_printf("/ethernet@%" PRIx64, addrs[i]);
> -        qemu_fdt_add_subnode(s->fdt, name);
> -
> -        fdt_add_fixed_link_nodes(s, name, s->phandle.ethernet_phy[i]);
> -        qemu_fdt_setprop_string(s->fdt, name, "phy-mode", "rgmii-id");
> -        qemu_fdt_setprop_cell(s->fdt, name, "phy-handle",
> -                              s->phandle.ethernet_phy[i]);
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz,
> -                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> -                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addrs[i], 2, 0x1000);
> -        qemu_fdt_setprop(s->fdt, name, "compatible",
> -                         compat_gem, sizeof(compat_gem));
> -        qemu_fdt_setprop_cell(s->fdt, name, "#address-cells", 1);
> -        qemu_fdt_setprop_cell(s->fdt, name, "#size-cells", 0);
> -        g_free(name);
> -    }
> -}
> -
>  static void fdt_add_zdma_nodes(VersalVirt *s)
>  {
>      const char clocknames[] = "clk_main\0clk_apb";
>      const char compat[] = "xlnx,zynqmp-dma-1.0";
>      int i;
> @@ -607,11 +554,10 @@ static void versal_virt_init(MachineState *machine)
>                                   &error_abort);
>      }
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
> -    fdt_add_gem_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
>      fdt_add_rtc_node(s);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index b963a05935b..062f9a91a6c 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -27,10 +27,11 @@
>  #include "system/device_tree.h"
>  #include "hw/arm/fdt.h"
>  #include "hw/char/pl011.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "hw/sd/sdhci.h"
> +#include "hw/net/cadence_gem.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -49,10 +50,18 @@ typedef struct VersalMap {
>      VersalSimplePeriphMap canfd[4];
>      size_t num_canfd;
>  
>      VersalSimplePeriphMap sdhci[2];
>      size_t num_sdhci;
> +
> +    struct VersalGemMap {
> +        VersalSimplePeriphMap map;
> +        size_t num_prio_queue;
> +        const char *phy_mode;
> +        const uint32_t speed;
> +    } gem[3];
> +    size_t num_gem;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -63,10 +72,14 @@ static const VersalMap VERSAL_MAP = {
>      .num_canfd = 2,
>  
>      .sdhci[0] = { 0xf1040000, 126 },
>      .sdhci[1] = { 0xf1050000, 128 },
>      .num_sdhci = 2,
> +
> +    .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
> +    .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
> +    .num_gem = 2,
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -109,10 +122,22 @@ static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
>      }
>  
>      sysbus_connect_irq(sbd, sbd_idx, irq);
>  }
>  
> +static void versal_qdev_connect_gpio_out(Versal *s, DeviceState *dev,
> +                                         int dev_idx, int irq_idx)
> +{
> +    qemu_irq irq = versal_get_irq(s, irq_idx);
> +
> +    if (irq == NULL) {
> +        return;
> +    }
> +
> +    qdev_connect_gpio_out(dev, dev_idx, irq);
> +}
> +
>  static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
>                                             uint64_t at, const char *compat,
>                                             size_t compat_sz)
>  {
>      char *p;
> @@ -138,10 +163,25 @@ static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
>  
>      qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
>      return p;
>  }
>  
> +static inline DeviceState *create_or_gate(Versal *s, Object *parent,
> +                                          const char *name, uint16_t num_lines,
> +                                          int irq_idx)
> +{
> +    DeviceState *or;
> +
> +    or = qdev_new(TYPE_OR_IRQ);
> +    qdev_prop_set_uint16(or, "num-lines", num_lines);
> +    object_property_add_child(parent, name, OBJECT(or));
> +    qdev_realize_and_unref(or, NULL, &error_abort);
> +    versal_qdev_connect_gpio_out(s, or, 0, irq_idx);
> +
> +    return or;
> +}
> +
>  static void versal_create_apu_cpus(Versal *s)
>  {
>      int i;
>  
>      object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
> @@ -375,50 +415,80 @@ static void versal_create_usbs(Versal *s, qemu_irq *pic)
>  
>      mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>      memory_region_add_subregion(&s->mr_ps, MM_USB2_CTRL_REGS, mr);
>  }
>  
> -static void versal_create_gems(Versal *s, qemu_irq *pic)
> +static void versal_create_gem(Versal *s,
> +                              const struct VersalGemMap *map)
>  {
> +    DeviceState *dev;
> +    MemoryRegion *mr;
> +    DeviceState *or;
>      int i;
> +    g_autofree char *node;
> +    g_autofree char *phy_node;
> +    int phy_phandle;
> +    const char compatible[] = "cdns,zynqmp-gem\0cdns,gem";
> +    const char clocknames[] = "pclk\0hclk\0tx_clk\0rx_clk";
> +    g_autofree uint32_t *irq_prop;
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
> -        static const int irqs[] = { VERSAL_GEM0_IRQ_0, VERSAL_GEM1_IRQ_0};
> -        static const uint64_t addrs[] = { MM_GEM0, MM_GEM1 };
> -        char *name = g_strdup_printf("gem%d", i);
> -        DeviceState *dev;
> -        MemoryRegion *mr;
> -        OrIRQState *or_irq;
> -
> -        object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
> -                                TYPE_CADENCE_GEM);
> -        or_irq = &s->lpd.iou.gem_irq_orgate[i];
> -        object_initialize_child(OBJECT(s), "gem-irq-orgate[*]",
> -                                or_irq, TYPE_OR_IRQ);
> -        dev = DEVICE(&s->lpd.iou.gem[i]);
> -        qemu_configure_nic_device(dev, true, NULL);
> -        object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
> -        object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
> -                                &error_abort);
> -        object_property_set_int(OBJECT(or_irq),
> -                                "num-lines", 2, &error_fatal);
> -        qdev_realize(DEVICE(or_irq), NULL, &error_fatal);
> -        qdev_connect_gpio_out(DEVICE(or_irq), 0, pic[irqs[i]]);
> -
> -        object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
> -                                 &error_abort);
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> -
> -        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> -
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(DEVICE(or_irq), 0));
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, qdev_get_gpio_in(DEVICE(or_irq), 1));
> -        g_free(name);
> +    dev = qdev_new(TYPE_CADENCE_GEM);
> +    object_property_add_child(OBJECT(s), "gem[*]", OBJECT(dev));
> +
> +    qemu_configure_nic_device(dev, true, NULL);
> +    object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
> +    object_property_set_int(OBJECT(dev), "num-priority-queues",
> +                            map->num_prio_queue, &error_abort);
> +
> +    object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
> +
> +    /*
> +     * The GEM controller exposes one IRQ line per priority queue. In Versal
> +     * family devices, those are OR'ed together.
> +     */
> +    or = create_or_gate(s, OBJECT(dev), "irq-orgate",
> +                        map->num_prio_queue, map->map.irq);
> +
> +    for (i = 0; i < map->num_prio_queue; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, qdev_get_gpio_in(or, i));
> +    }
> +
> +    node = versal_fdt_add_simple_subnode(s, "/ethernet", map->map.addr, 0x1000,
> +                                         compatible, sizeof(compatible));
> +    phy_node = g_strdup_printf("%s/fixed-link", node);
> +    phy_phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
> +
> +    /* Fixed link PHY node */
> +    qemu_fdt_add_subnode(s->cfg.fdt, phy_node);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, phy_node, "phandle", phy_phandle);
> +    qemu_fdt_setprop(s->cfg.fdt, phy_node, "full-duplex", NULL, 0);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, phy_node, "speed", map->speed);
> +
> +    qemu_fdt_setprop_string(s->cfg.fdt, node, "phy-mode", map->phy_mode);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "phy-handle", phy_phandle);
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                           s->phandle.clk_25mhz, s->phandle.clk_25mhz,
> +                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
> +                     clocknames, sizeof(clocknames));
> +
> +    irq_prop = g_new(uint32_t, map->num_prio_queue * 3);
> +    for (i = 0; i < map->num_prio_queue; i++) {
> +        irq_prop[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
> +        irq_prop[3 * i + 1] = cpu_to_be32(map->map.irq);
> +        irq_prop[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>      }
> +    qemu_fdt_setprop(s->cfg.fdt, node, "interrupts", irq_prop,
> +                     sizeof(uint32_t) * map->num_prio_queue * 3);
>  }
>  
> +
>  static void versal_create_admas(Versal *s, qemu_irq *pic)
>  {
>      int i;
>  
>      for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
> @@ -900,18 +970,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.rpu.cpu[i]),
>                                   &error_abort);
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
> -        g_autofree gchar *name = g_strdup_printf("gem[%d]", i);
> -
> -        object_property_set_link(OBJECT(&s->lpd.crl),
> -                                 name, OBJECT(&s->lpd.iou.gem[i]),
> -                                 &error_abort);
> -    }
> -
>      for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
>          g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
>  
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.iou.adma[i]),
> @@ -1095,12 +1157,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < map->num_sdhci; i++) {
>          versal_create_sdhci(s, &map->sdhci[i]);
>      }
>  
> +    for (i = 0; i < map->num_gem; i++) {
> +        versal_create_gem(s, &map->gem[i]);
> +    }
> +
>      versal_create_usbs(s, pic);
> -    versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_xrams(s, pic);
> -- 
> 2.50.0
> 

