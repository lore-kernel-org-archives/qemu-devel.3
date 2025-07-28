Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4824C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRQ4-0002TR-9i; Mon, 28 Jul 2025 13:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugRPz-0002Oi-BC; Mon, 28 Jul 2025 13:13:47 -0400
Received: from mail-bn8nam12on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2418::629]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugRPw-0003xD-FY; Mon, 28 Jul 2025 13:13:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL4JOpEJJg86Ui2crosRbFhZ+LCaDNYHVtPxwj/gxIX1AEcOvh5zSHQn/aFVhUFIaHPag1vss8+LzLkgToxc5x+9oVscEXyVWtIu4mUmmFQM4sWY/BmZHlaqW7Ksz+1Mgo1yxd1iyc/K9yW10ifEaDbnjI6iWuqFW4vHNc+XQVQWHkQXAWVnhIhQ/Vxg0+f5dUGLB1D9OZGAt8iXtd0RxHtG07N1/xAGenzKYAufkrA1ocbVfhmcJr7NFcxNudnVpVmX9/14MsVPPrnDWm5sjYNhyM/whqFfF+JABZt1964GkLgmF1Rb7bNp3OMNdn9QxVHhokudOrMvDIlIC52B9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM2LV5s1gn67R9svTXc8c9aKYRJQ9M4iNlz5TBHITSI=;
 b=Lmp9AWrbUfhJWahXt/VkAoN+B7EuPvrpnh3T7ZCaGpwD3HD14hG6Why+Grt6+RpmiMbdI6OnlIJ3JJUNBzPQy2tZEzuF8bxKAuR1Z15wBPGxSK95xU9fkJ1gA34HXiyWO2lcV7cWJePdENM52RuwWhwdLGI8TkcT/6al7eQeSqbHqgf2MdC+aEq9YZorjxqHltLv63S8dILSRajlvlgA3a25e7kbhRGDriwB0MNJr/21b4rJbHQoQ1kB9tMrPbKnOHC+IobSTa9+XaVXdXSrMfIaO/sTVnIioZSWwcVyR/40/YGEh1WtmAlkzYs1HzGj0zp37MoFclq3n8P48ji19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM2LV5s1gn67R9svTXc8c9aKYRJQ9M4iNlz5TBHITSI=;
 b=4CxBVyFp0sLa9KKxFDVNM2qlABf8/Nmxm4NCSnyoZQAeqf3VhI8EsbVGRLw+I7IR8GQhFpGuuDZwE0baOAc+to9z1gIV5G7k/qMZ5BEIsHQFjwodebjO4xU7PGcsLvzClnZXekGvFRCEtFHhtMVYo6l6XpM5yFLrqH0Hi47rzsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 17:13:34 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 17:13:34 +0000
Date: Mon, 28 Jul 2025 19:13:23 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 03/48] hw/arm/xlnx-versal: prepare for FDT creation
Message-ID: <aIevs4V/LPPHq99C@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-4-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-4-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: a88ab06d-66b0-4a8a-b82f-08ddcdfa158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RU1icUJvVEdNOHNIU1l3UGVPaDlkZ2MzV0JYR0MwcFNOSEFPWDArS2ZRdkdX?=
 =?utf-8?B?dkUvNmFUcW01ZnpncnBHVmU4VWhMQ1p6M0dDY1h3MTc3bUFCNmtjMjNITU9v?=
 =?utf-8?B?YkIzQ01QWTkxY0pyMkFGd1BaN2U4UnZ0bDdkeU5NMWtFV0FkeW4rWkNLcHor?=
 =?utf-8?B?ajRGTDdkL3A0YjhuenE4WEFXWnZLeHAvSFA2WDV3K2VvZkYxQ3hWd2FMUGNw?=
 =?utf-8?B?YjVtUHJFR0V5MklSdDdTbVV6VEloSDBnS3NaNVdjdVVrNHBYK0FMUWExOCtJ?=
 =?utf-8?B?SlFrRm0rSUZpS0lQcjNtbXdNd3BNQjdtMXRzUy9xWFRTOTBXdXNHaDFXbVo3?=
 =?utf-8?B?d1NBZkIvWFN4WjZ3enh1dXBTWmUrZ2M4cE5OcVRJYUJWdjhVbGozVWZrWEhL?=
 =?utf-8?B?aDVWNkNKbDUwQ0FwQW16S0Q5MXh0U284TVhuU25MLzluaEp3eEFSNUxLNEw3?=
 =?utf-8?B?aGtGZGJreFQ0US9yZUsyN05SaFVVcThKd1A0TUp4V2hhenk1Q052d005cVB4?=
 =?utf-8?B?a2JCS0NJSzUyb3ZIbHZFQ3loQ0dYemczS280cXhsMVpvRWs4OVdyb2R0bDY4?=
 =?utf-8?B?eFRxajVzN2xXenlVZW0xbzlHMksrZGRCN1k5ZGNoUkR3RVpCNW9NQXQzL0RV?=
 =?utf-8?B?S2x4UFBueVV0RTV3N01Qb0VqUEN2NjV0U0VTWHMxZXZpaThsYTNvTW42c3Qw?=
 =?utf-8?B?MUVsbTc2UGZzS0tDaURRRW1wR2NjaHJjOHRqQW1IMDRXUldKWkxvQXBidW1J?=
 =?utf-8?B?bVNVcjZtMDRDQytrR0xJQVBCMDlaMk9oQXVYQUJwcjVwb29qa2ppMThUdjJ6?=
 =?utf-8?B?MGE5M25QUU5QQXRvaUlmaEpjallVQTN5QXZsNTB0aTVxcDl4S20yVXlENTNr?=
 =?utf-8?B?N3k0c1FIMmRpaWo0WnZyY2ZkU1F0RUdDbjZUU2JQQkVzanZzWjhkWlhDdi9Q?=
 =?utf-8?B?Y2pOWEJINDc2emZhbmU0ZnBJWFNEdTRhdzRKTVZnOG9xWlVqVGZmTmtmbVhL?=
 =?utf-8?B?ME50K0txN1ZOTURNdlpkZkxrNHpGZFQyVEV2ejR2MzlhN0lOWVRnT0FDQkhS?=
 =?utf-8?B?QnEvaHVTaExaWEMvUk9veXQvRjFKcXBjVmU0bHhjcDJmVTY1Z1BsQnh1VHlM?=
 =?utf-8?B?aWRhOHNOMUIwVzAxYWs0YU83YTY5OFM4U2pPVUt4VmNacmVFZjhEOFlkSTRj?=
 =?utf-8?B?TkFmK2RaRnJDZHRmZ0hlMXE5Q0ducUZtclJaeis2Y0ZWSjBoVE5vOVhVWE4w?=
 =?utf-8?B?dncvVkxFNUhtenFiSE9tWGJYNjVPeDAyR3ZCQ2J2b2pQempJYVJ2MHJYbEha?=
 =?utf-8?B?RXhld0dVYmJOVWdSRTUzSisxSEk0OFBmV1pNVzRBS3lSVCtkbWNoc01aQXQ2?=
 =?utf-8?B?cTJsb2E5cjhSRlRLZE4wR1E4eTZaNGQ0ZzUwRUNHRlhpV1czQ29tWXZzenJt?=
 =?utf-8?B?ZmYreFRiY0haOW5XZWFtTWtvb2YxY0tjL05qd3FUdG1wN0tSaDdicG5jTHhD?=
 =?utf-8?B?MTBXYlQwbEFHYzZEZXJJS2NkaStrR3VtOUpnL0RjaExyTXZZSWlpc0UyUlRr?=
 =?utf-8?B?cG1rampZdUJrV0tOY1hLTHc1Z0U4OEpSWDkvdHRCTk45UkhyN3VzcFV6Yzdu?=
 =?utf-8?B?cFNRcGdhNHoyWVZXTyt2U2N3eXNINEtkMlo0OVdkMnp0YXEwMlVQYmJUaGRz?=
 =?utf-8?B?aGZLNzJwYzEwOWxKajJ6NmY0VzlCWUVGTUsyV2xkNVRQcGdBbGdHNm0wRVg5?=
 =?utf-8?B?dVpmZ1lubnA3UHppSldWWnkrWU5jT2dxUjVsd1VsK2VSMEQ3TUorTFZmYjQ2?=
 =?utf-8?B?MEpjazR3ck5jSEtLN25jd0tlU210RUcrSUJTNndIRUdXSk9DeUxiUXo2eHI1?=
 =?utf-8?B?QnAxVzVkSjFlK2tSdFFsU0lXUzFOeXFJUXdWVFhXOGpXY0hDMFk1TllzL3VG?=
 =?utf-8?Q?oSJMwMfrYs4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE9BSC9IbzFKWlpxTGZKWUVOTUZuMFRHb0lhTnlvYUtuUGFFZEFzay80aTJH?=
 =?utf-8?B?L01MOHRZNFpoTjh2ME0yc092UGdOYTJ1K3htc3B2TEZLWFE1NHFkc24rb2Ri?=
 =?utf-8?B?OWpoNGd2clp4VUFHdFI0RzVFRElJd0crRnhoZFBMaFU1b080L0hoMUFUeS8v?=
 =?utf-8?B?OXhwRDlTcXVQTm5uL3duTmphTmo5b3lFVGlxbWlQYVI3cmRUVGNYbEg4Rkww?=
 =?utf-8?B?aGY0UHF0UmlwcUZJSzV4aW03amZZRFcrWituZFU1RU9FdmxoSkxKaG1TcTcw?=
 =?utf-8?B?c3E5K2VtY0dNclFOVjU5OXJadU0zSDA0V1hLTzN5dGNVVy9MWWdTSzZGU1lV?=
 =?utf-8?B?R2xBb0tHYnN2cGxaRmFrUVdUalFRU3F1WDJUQkE0aFJQSXE3Y1dUWDI2MS9E?=
 =?utf-8?B?bmNUTjNDWFFQT2xkRm9ESllyNjZzNlU4eUNtSXdjWWN1aE9YU0h3YjRmdElv?=
 =?utf-8?B?R09mUzQ5RWVSUkdEQVNaNFRQRDdUcVJUZTVRdGpqRTJJaC9vMEpkNmdwMVQ0?=
 =?utf-8?B?TFNIeVZBaE1FNVFSRGcyaHFsT2c1NHpFRUhQYzZZS3BwZjQwSUhnbEtiam5h?=
 =?utf-8?B?eWdrQkI3L1VYSzVNZUxwSFVEZXdPRExCUjFFcERjQ2FSTWQxK1hJN0h6b0hM?=
 =?utf-8?B?R3kyZlNwcGUydThKam9MQXdheUYrOFJsa0FHbDRta2ZXdUk1dWZzd1ZYeW16?=
 =?utf-8?B?OFJHZHFoNGhmRVk1RWJtREZrY2lJR3pQME9sQk03dzlxNmZ0L3NQVkpmZDNU?=
 =?utf-8?B?Y2RYbXhKRjRWTmJ4d2sxek1xa21HZHZpTHY1K0g3UFo5ZmlSTjJqbVJONk1s?=
 =?utf-8?B?RU1ueS9UdWVrUmJGZ1BVMHZ2eW9wRmwzTVVXQXFRSDFwVEF0ZHNhWk9qbHdQ?=
 =?utf-8?B?Y0NPYTBtMnkrVGlLUFdZejJ3eFVZak94djVjNVkvVUNTTVpxaVRoM2NJRm5C?=
 =?utf-8?B?KzFJSWw1c2NJUzIrNFdKNmhCYm9mcDM0Rm4wZ1pjTllYSFdtKzNuRFpuQ21R?=
 =?utf-8?B?dTlheVF1WmFIelU4bW9xc2R6UnRURGk0ekNibnRLRDljSU8vQkRFWWFGeTdU?=
 =?utf-8?B?QlV3L3hML2EvVWQ0cytDenJGL0pjUC9vNnI3RXQ4R2luZjZPVzdDcGFRVUln?=
 =?utf-8?B?ZXVIVk8zeGU0S0tPV0ZXdnVVMnZ2UVN5Y0t6dUoyeW81WVJra2wzdFdwN3pj?=
 =?utf-8?B?MUVENjJzVUxiRTJRMGpBS2UzTDRqT2NFdk1NUlMzVlFiL2k5bTY1Q055WVI2?=
 =?utf-8?B?V3FRcjgwVEx0ZWduYUcvWXJQbDFwd1FkRnRHYUpFUlZocHU5dG1TZHk2c05N?=
 =?utf-8?B?VittbkNJMFB2cy9qY3p4b29tdWlmZi9QdmdFbjFXYTF1Y1ZTaFAzWEdpY240?=
 =?utf-8?B?dlprcU5xRVJIKy9JeklpWkxuVHd1ckdXRUtTNDJDZUlERjVwempaR0t2MFZo?=
 =?utf-8?B?akw1UkRjanNXM0tkV3Q3diszTGhYUTNHSkRnbjZpWU12RHBTNzVoV1dlYlhy?=
 =?utf-8?B?YmlWbk1tVWNpamtsOUZFRzBvT1VqNzNpNERzVW9XMHBneUswdG9EbVF1SVlV?=
 =?utf-8?B?aUJKd0FwY1RpVU1WcGgyTmVFN0JOc3NDc1p5SEE3dGJzbHJrZkFYY1NIR091?=
 =?utf-8?B?QUZZNWpqaVI1eDdVRkg0SHB4MVQ0M3p4NW1QcGovSVRqczZlMjFCb3V1MWdi?=
 =?utf-8?B?MVhzVkM4SDA1bVh0Q1BnclFUU0xDUGhtcUZpWURuN0JvVWthZXBsbndvZjNY?=
 =?utf-8?B?RW5NTjRYcmlORk15aHFGQ0FVUjdzdnNrRWswRG4wK0ttOHdkS0M0MUdzdHdT?=
 =?utf-8?B?akd6Wkx2V2R3TmhOWTNwYmhQOFNkQUMxSEYydUtLVm1yK2hST0F1Ym1zNlhL?=
 =?utf-8?B?WnRUaERoN3N3YlhtaGRHMVhoaFlRRENvYUpzUnNXeE5jcFZlblc5MGYzNEo5?=
 =?utf-8?B?dVBsbHdQeEFqRW5BL0NoUkh0akd2aWYrbDdNaitqbUo3MWFkSjRPM3NiNzVI?=
 =?utf-8?B?c3U0UjZCOGh6T0lkN3lYS3ZoQ2ZDTU9teFZWYUpSd1FPd2NkT1REL01vQjNk?=
 =?utf-8?B?YzQyVjJ4UTYwR0VvZ1ZaVlBRb3owdURPUXhBb0J4SWVZakcrRmV2OGJMYWRj?=
 =?utf-8?Q?47W1/T0BEmTvgAHbyjh0YcsRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88ab06d-66b0-4a8a-b82f-08ddcdfa158f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:13:34.6542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug1VXYkr7ahITNIDiJAqS5sHfRH0OacbqvHkTWMK3DDYquUEEdbTwzSLjfDzSAO7+/fLO/BthQY8ytdooiApoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
Received-SPF: permerror client-ip=2a01:111:f403:2418::629;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Hi Luc,

On Wed, Jul 16, 2025 at 11:53:45AM +0200, Luc Michel wrote:
> The following commits will move FDT creation logic from the
> xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
> passing the FDT handle to the SoC before it is realized. If no FDT is
> passed, a dummy one is created internally as a stub to the fdt function
> calls.
> 
> For now the SoC only creates the two clock nodes. The ones from the
> xlnx-versal virt machine are renamed with a `old-' prefix and will be
> removed once they are not referenced anymore.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  include/hw/arm/xlnx-versal.h | 12 ++++++++++++
>  hw/arm/xlnx-versal-virt.c    | 11 +++++++----
>  hw/arm/xlnx-versal.c         | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 1f92e314d6c..f2a62b43552 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -134,21 +134,33 @@ struct Versal {
>          XlnxVersalCFrameBcastReg cframe_bcast;
>  
>          OrIRQState apb_irq_orgate;
>      } pmc;
>  
> +    struct {
> +        uint32_t clk_25mhz;
> +        uint32_t clk_125mhz;
> +    } phandle;
> +
>      struct {
>          MemoryRegion *mr_ddr;
> +        void *fdt;
>      } cfg;
>  };
>  
>  struct VersalClass {
>      SysBusDeviceClass parent;
>  
>      VersalVersion version;
>  };
>  
> +static inline void versal_set_fdt(Versal *s, void *fdt)
> +{
> +    g_assert(!qdev_is_realized(DEVICE(s)));
> +    s->cfg.fdt = fdt;
> +}
> +
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
>  
>  #define VERSAL_GIC_MAINT_IRQ        9
>  #define VERSAL_TIMER_VIRT_IRQ       11
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index adadbb72902..c30dcca424c 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -1,9 +1,10 @@
>  /*
>   * Xilinx Versal Virtual board.
>   *
>   * Copyright (c) 2018 Xilinx Inc.
> + * Copyright (c) 2025, Advanced Micro Devices, Inc.

s/2025,/2025/

Otherwise:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

>   * Written by Edgar E. Iglesias
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 or
>   * (at your option) any later version.
> @@ -695,14 +696,13 @@ static void versal_virt_init(MachineState *machine)
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
>                               &error_abort);
>      object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
>                               &error_abort);
> -    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>  
>      fdt_create(s);
> -    create_virtio_regions(s);
> +    versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gem_nodes(s);
>      fdt_add_uart_nodes(s);
>      fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> @@ -712,12 +712,15 @@ static void versal_virt_init(MachineState *machine)
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
>      fdt_add_efuse_ctrl_node(s);
>      fdt_add_efuse_cache_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
> -    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
> -    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
> +    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
> +    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> +    create_virtio_regions(s);
>  
>      /* Make the APU cpu address space visible to virtio and other
>       * modules unaware of multiple address-spaces.  */
>      memory_region_add_subregion_overlap(get_system_memory(),
>                                          0, &s->soc.fpd.apu.mr, 0);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 4da656318f6..7bb55751e5c 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -22,10 +22,12 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/arm/xlnx-versal.h"
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
> +#include "system/device_tree.h"
> +#include "hw/arm/fdt.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -917,14 +919,42 @@ static void versal_unimp(Versal *s)
>      qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
>                                  SYSBUS_DEVICE_GPIO_IRQ, 0,
>                                  gpio_in);
>  }
>  
> +static uint32_t fdt_add_clk_node(Versal *s, const char *name,
> +                                 unsigned int freq_hz)
> +{
> +    uint32_t phandle;
> +
> +    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
> +
> +    qemu_fdt_add_subnode(s->cfg.fdt, name);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
> +    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
> +    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
> +    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> +
> +    return phandle;
> +}
> +
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> +    const VersalMap *map = versal_get_map(s);
> +    size_t i;
> +
> +    if (s->cfg.fdt == NULL) {
> +        int fdt_size;
> +
> +        s->cfg.fdt = create_device_tree(&fdt_size);
> +    }
> +
> +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
>      versal_create_uarts(s, pic);
> -- 
> 2.50.0
> 

