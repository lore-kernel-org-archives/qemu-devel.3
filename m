Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6DECA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 19:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqzgl-0003jz-Tc; Tue, 26 Aug 2025 15:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uqzgj-0003iN-AQ; Tue, 26 Aug 2025 15:50:37 -0400
Received: from mail-dm6nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2417::612]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uqzgf-0000gi-OI; Tue, 26 Aug 2025 15:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQWb4PB9KuKjSsEKV0gFf6A+HgJxJcPUM0iDKp/vzG62abiR2MFpTWE/xCxPzTAE9FxxehaNsrMfNxovQojAgzUrlZMXL0Dj48vkmPCQHNa0nMGsBAvPg/dGcL1tH02JZACg9klSxPqYh1FAjOzcjif5v08B/qRSDJ5Dd2gBgPLVn2j1BkRhZ2oV25855w0FazoQB4d2QS0PscSSF807Q6sAR7EfzhQEXvc7reDNRzKCtFUfvK9Bc69uVRt//qmaSyydAjt2hgClk64cyC1+lSwn86TvJ46tiNrTPkoXmAxV9F3ppc6slfI8hqfhFxI5Xq/gNISCxV30MbAS5HRixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWbxbHmqOgR/MtWf3XJlARdKoZrg+sxQjtdTd7sNUwE=;
 b=cqWbHmcNJR3hp2wbISeGwG0JRLQu+BDQcfjLOwpi9zEwOm4HaoxR51BN2UPpEMYm+BHqoiIZ2f2smBnlh7T5URWVSTIM+atOJ5QLYPv5zgGVyOk46MdyjmWxn4W+bWrX9ZCqpvzYxY/H0gVUTRr/skSgggyiRug2ONElfzkOy6cOMowDed+Kks7x7h8ms9jkFzORI/ONkza51f6YPYW0y3+0HJrr1/JvFKBmaDbxyXQbYbzMvX5Oq5UM7gwAZ5TwkKXq+vQ3Z5dRhZ8lRAfTlNQTw/CJFQonAc1spX2WdkukzndI+T91lolLUuJ8ckG1A4S5kaB+l3I4ZkTINA8xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWbxbHmqOgR/MtWf3XJlARdKoZrg+sxQjtdTd7sNUwE=;
 b=GBkwSnAf8xL81yKeEh+NHFhVXz+AHT6lfqCX3ygq048qcMivyMm+dn5VAi5uzjcOm8h8yP8Sc6fj7SaTQpPlJRDprvVuu+lbo/lE2jI2+XAqgfOSsDLuWQ7MoRfVVTRGXBbbl9Nm18rVN13DtpcgB6ooNGeL3Bcv2Eku9fTevRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 19:50:20 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 19:50:20 +0000
Date: Tue, 26 Aug 2025 21:50:14 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 2/2] hw/display/xlnx_dp: Don't leak dpcd and edid objects
Message-ID: <aK4P9gJCbbp1NgY/@xse-figlesia-l2.amd.com>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
 <20250826174956.3010274-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826174956.3010274-3-peter.maydell@linaro.org>
X-ClientProxiedBy: LO6P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::11) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cc671c-6d64-4b1a-a64e-08dde4d9c996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck5BcXpBSmxMSmRyTU4zeE1USGlNRlZ2STJrWnpraGZzaHVjVC9ueHhIUC9p?=
 =?utf-8?B?SzFrdlZVTlgxNkw3aThZMDY3VklCNENNTkZVNVZmWktBOTUrZWZZdXg4QWVH?=
 =?utf-8?B?K2JvWFRYa3JyYzQxdjdsOUpMM0g2bHgwZ3JTaFpQQjBHODMweXU0V0loL0x6?=
 =?utf-8?B?eGNIckNoVVRzQkdyVXU2dFFzOGVqOVY1ME4weHRDdUhMQWdDbXVDa1lDMmpM?=
 =?utf-8?B?VkZ3WEFMaUZBVm9GbWxQTGVPbXYyUlZXRWEzRG01STJjZjFXSktGcFlMbzF1?=
 =?utf-8?B?NVlLQzZBa1hmVjBxVUt6NzY1WmRRa1ZlR0p2djRPZGJnY1V1MFd6bzZyU1h0?=
 =?utf-8?B?UTJiOGxFWGVucEFKVlQ4b05XQlgxMTZ6Q3I1MG9DK3R5U1N2emhaVngwNmJa?=
 =?utf-8?B?VjJHUXFOajBkRlA4aUFnUHBYaHVLTVNnNHhrKzhha1ZlMHpDd2EzYmtzcUly?=
 =?utf-8?B?OU84ZUJGMXdFK2tCSFZ1clZXTnRYeTFYZG02MzFYTHlwaUlCNmhLZTh5djJ3?=
 =?utf-8?B?SlIyVUxBSXN5NzBxaUs5K0hocjRURzllU21ua21DcUFESnVWWE5rZVFtajRq?=
 =?utf-8?B?Um5FZWlRYUJVeGU0cDdsOTB2bzl4QWVTcjJ1R1gxUjdnKy91aFQ2YVB3N2xC?=
 =?utf-8?B?Y2wzVmVyUGc3MmUvTXQrWmRGb2pkU3FDQ1ZPM1VGeEFTanF5Nlk4Q252WGZC?=
 =?utf-8?B?enJUZ1FSTzU1VmxtNUFhM1J6QXhlOEIwSG4wQWNQUE52ZUhzdWZ2YnQ3WWhj?=
 =?utf-8?B?d05OZk9VRjFiNHN5L2dSYTFUWmE5NzNJYnJZSFVDcnlseEM5OVJMZ0hTaG5H?=
 =?utf-8?B?eUhFNlp4V2lpWHhlZzgzaS9jVTVUaElMOVZlVk1ieHcxci9qTWIwZGFhTWhF?=
 =?utf-8?B?ZjFyQmx0WmpxWk9ReWtTTXV3ZUYyVHI3YWdpbklUSTR4SmVoWVJmQ20yZEJ6?=
 =?utf-8?B?UW9qYnRJSkdPRzFVOTdXbjJzNHpjVnJOZlhSeFgwcHJxT2JkZXVQLytZK1o3?=
 =?utf-8?B?VWJoVXIzWVRWWlBFMHo1MlhNY0xwdExicTU1cjB6TGhSQ3FvTGFQSWwvZTdq?=
 =?utf-8?B?WEs4aHNZVWxBRUNwWDBBc1V4Q2o1RllzaXFXbDJQdm8zRGlkWXJJRGlMZVRT?=
 =?utf-8?B?dFd0N0ZQK2ZNQWRxbks5UHFLRDcwdzdzSGs5aGQ0SG9DQVJkd0llZ3BxSjIz?=
 =?utf-8?B?N2FibDJKSUNBbGl2MnFkM1FrUEFyZnpGWk1MRTlyVjlKU3BrU3ZzMlRXaWpu?=
 =?utf-8?B?N2oxNVR5TVZuakJ5Z0gxdGRmcnlxck0xZTRaUUNRY0t0c05acW84WXcyOUZr?=
 =?utf-8?B?K0tJWDVFQTlIcG14eW9Mak90Z1dOTGE5MGIxaHhRTktqQ3NxMUF5REx3aUZX?=
 =?utf-8?B?R2pGMEdPRjFSRFNMaVNFSGtNR2g1N1UybGFZODFKc2VVNXdKZ3Uxd3lBTWo3?=
 =?utf-8?B?aHg2RTF4cUdWc2xzTHpVSXRDaUE1cllMWDNpQlZRQVBKaXVFd2NJMGZmdXNP?=
 =?utf-8?B?QzVXd0pFc0hpWThUZWtHVENNMUtLOVB2U0N0R2U4YTNMcDc3MzNJeEtRZjBu?=
 =?utf-8?B?dDVVSkNmTjZZeG42MS9mS1pjdlJoem5jdFBKVVcwQy9lTFZCdXdGb1Z0VE1R?=
 =?utf-8?B?ZnJRd1VKRlYwWUNoSjRXL2JoNFkwc3hXTExiZFNFdzJVSG00eFZGc2tqeWcv?=
 =?utf-8?B?MVN5cEJuMEV6MUlNWStWdjVtZFlKUTRLNjlsbnRua3VNRFNoWnF3S3NiVEdO?=
 =?utf-8?B?Y0tFOHFzRE5HS1N5cDFQQ2xzeUdUb0xEMmY3REhzRmtxOU5hUjg2RjZPczZ4?=
 =?utf-8?B?cFBHZ1ZoNEc3QklHcHBDSVlyVEl2RFA5QlFCMW9FWUZjZGVLRWl4V1hKREZm?=
 =?utf-8?B?M1NPNDBvRUNrOW1SWXlqb2JIK0h3NTNueWdPaitSajQzamFTMUtLRkliamcx?=
 =?utf-8?Q?IzxTntQkp0s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJoVTRKQkdkdGowajdXVFUwQzEzdHFmS1pJOGdDNHphWlkvQ041UDNEOVBr?=
 =?utf-8?B?ZTI3TkhPdWxNZGxkWHVCUFpxV2xZUEg2dWR1bk9VTEpSaER4c3VGWlNFRGUx?=
 =?utf-8?B?aUthYjFRUUNpZWhFV3JRTnJwMlloMU1SQTJ0TVIxK2NjSGF6dWJsVzdjUTV2?=
 =?utf-8?B?ejUvcTZmWDlTNTZjbGR6dTN6ZEpvWkg4ZGJ0OFNFbmtEdG1PQWJZZEJ2elkx?=
 =?utf-8?B?Uy9EYkVOcEdkWmNIVjBvNkE4RnZSSW8yd04xZlcySHlsRURLT2xDWm9VcXF1?=
 =?utf-8?B?REVHNU5HRngxNDFyZjBURmxOVEtZQXNJaUpkcm9tcDlwekdQRWdKVzVKdVBK?=
 =?utf-8?B?YWx2a2duRzE3NHYyUFJUdnUyVm90Ti9zZUhFWkZ3RG5wb2pXQlFtMDVGMXRh?=
 =?utf-8?B?QXFseHFrS2Y0SDBBL05mMGlKTGk2WkNIK29WbDlhVjBuRVVkMGJWU1VtNXBp?=
 =?utf-8?B?Z2Fld0V6MGoxY2IwQlYzT29sNVBPRzVmbSttTWZJN0plSlNOUndON1FaM2Nt?=
 =?utf-8?B?MUwxMVZHNjlBdXpqTTRXOHZrQ2F2YlAxMEI2ZWEveE9HNGVoWE9QMEhVcVFx?=
 =?utf-8?B?bGxMSTAzZEVFbzRRUXh6UUJGMWJJK01xUHJKa0FiNU5LOTk1VjMva2JCbm16?=
 =?utf-8?B?NUh6d1phVzdYN2VkcitIUTZXUzZTcGdYUUQraFdSbVRqc3puMEhsaThCMGtF?=
 =?utf-8?B?RjVjSGVYVzc2c1Jsa1lJMUwyejE2RFJMME9SSjZtQ0xTeTZuWGlndkxyTENZ?=
 =?utf-8?B?YzlrbFJtNGJwaFJtbW1uTjVyUUxQY2prZHlYSUZWU25rN1NGUVROcWFPZFNO?=
 =?utf-8?B?L1FjcWN4L0pCeVJQVzNCdXRvZnpwUUpiM2ZtSkJrUmhQaFV1a000SUwxRzg5?=
 =?utf-8?B?aWlNeWtDdmk4RVd5d2huNFY1RmdSZmthOUUyZFNhOWJDV1RFWGZTWTVPNnpa?=
 =?utf-8?B?SHJ6YlFQb1lodkk1NVY1TWxGQ01CdXJ3aU5OK0VUR2ZuUlMzdWF5M3pvNTdX?=
 =?utf-8?B?SS9xMWdoZmZsWFdJaVpsU3BDVCtCN0luemRrZklaVkQzNStwdG4xZk5zSDZT?=
 =?utf-8?B?Q0dPMGdTNGl3d2RjOVpQRVR5cnByWHdHTkFDQnBOUmdBV3huMWpJK3ZSRHMx?=
 =?utf-8?B?dk5RZ3hUdDFhMGgzVTRndnU4b3NlVFhTdHV0K3I5TTB2NStQOWRKaDV3dEND?=
 =?utf-8?B?VXB2OHRkRmVSOFhSYlorWS9PL1IxaVprSWFrYXlrZ1BzM0dWai9meXdXaG9K?=
 =?utf-8?B?djFLbGxtMFRZWmpNQzFWU0lyc0dWYzFjRmI5akVWTDYzc1VlSkJsMmZSS1hL?=
 =?utf-8?B?WmcyRGgzUHBoblgwZldEQVJabXJoNlJmcVVkajc3M2xNUE1FMko4WGNhQzNm?=
 =?utf-8?B?NVdGZVNxQmlKbVA0d1BieGZpZGdGSEZBNUNOekVJTE1TZ0ZPT0NuQ1NlQ2ty?=
 =?utf-8?B?aDkxWTkycHRNdG1UNldvdm1vdEpUbUdUMHVwQldkZE55eDFUU0EzK2E2Sm1S?=
 =?utf-8?B?b0c1aDlPek8vemV6T1A2MGQxR2ppbjlnL1ZGWC9GeVRFdi9uU3dEWEZXNHBN?=
 =?utf-8?B?a2kvdmxaS3FGU2JiSEhYbm5BNU5LczN3cWFHTnhsY3hGRzhzcTZPODJWamkw?=
 =?utf-8?B?Q2tBeTFlNCtNakJRRUJaQXd1L0JsYWlBVFVuNnR3RFR5STRlM1hFcXg2ZFFU?=
 =?utf-8?B?WEx0U1J1Y0tzK3pxQUM5MDN1QzRkR3ltV2RvMUVPZThFSTk4WHJ0YU1JMVNv?=
 =?utf-8?B?Z3pTc1YzRjY5OGN5TXMwZTJocDJPUktESkhLc3hDaTdIMHJyaUVyUGljVWJl?=
 =?utf-8?B?QjhMMHU1TmNHMUVPczh2OFg3dXFpelFsY2x4ZC91TjlINkI4NjZvWkduMnZS?=
 =?utf-8?B?N2ViSDA4VHEyS0E3NlFUWWNXbjJXWEkrMldyUm94YU1ReXVOYmpxcEpEV3hB?=
 =?utf-8?B?TldiaTZYM2NWZ1hRaEtoT1R3OFhuSmhqYjdpQnlVWDJ5UkowUXdhUmRJbE5h?=
 =?utf-8?B?ZzFNOWExZ0o2ZW9oVzRobnJJNnVnSHlzS3hmbkJ3cE9Rem9zL2JvOTZEQjdW?=
 =?utf-8?B?bkFyY1pBTjNkb1hEcTdGWlBPWTdyczNOS2tGMzhqSzczQndwUHNOU1NjY0dB?=
 =?utf-8?Q?p3mSGJOImiFa70vY5Y61oIFC3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cc671c-6d64-4b1a-a64e-08dde4d9c996
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:50:20.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU3Rhugh1NR97jppL9ERoJBGyDttV05aHp6ZJHvSQrj73WDJKtGwmJO3btVmFt1iSRiI/8KB51MAKe7uEZXz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
Received-SPF: permerror client-ip=2a01:111:f403:2417::612;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Tue, Aug 26, 2025 at 06:49:56PM +0100, Peter Maydell wrote:
> In the xnlx_dp_init() function we create the s->dpcd and
> s->edid objects with qdev_new(); then in xlnx_dp_realize()
> we realize the dpcd with qdev_realize() and the edid with
> qdev_realize_and_unref().
> 
> This is inconsistent, and both ways result in a memory
> leak for the instance_init -> deinit lifecycle tested
> by device-introspect-test:
> 
> Indirect leak of 1968 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
> 3fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
>     #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
>     #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
>     #5 0x5aded54458be in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1272:20
> 
> Direct leak of 344 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
>     #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
>     #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
>     #5 0x5aded5445a56 in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1275:22
> 
> Instead, explicitly object_unref() after we have added the objects as
> child properties of the device.  This means they will automatically
> be freed when this device is deinited.  When we do this,
> qdev_realize() is the correct way to realize them in
> xlnx_dp_realize().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/display/xlnx_dp.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 7c980ee6423..ef73e1815fc 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1267,14 +1267,18 @@ static void xlnx_dp_init(Object *obj)
>      s->aux_bus = aux_bus_init(DEVICE(obj), "aux");
>  
>      /*
> -     * Initialize DPCD and EDID..
> +     * Initialize DPCD and EDID. Once we have added the objects as
> +     * child properties of this device, we can drop the reference we
> +     * hold to them, leaving the child-property as the only reference.
>       */
>      s->dpcd = DPCD(qdev_new("dpcd"));
>      object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
> +    object_unref(s->dpcd);
>  
>      s->edid = I2CDDC(qdev_new("i2c-ddc"));
>      i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
>      object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
> +    object_unref(s->edid);
>  
>      fifo8_create(&s->rx_fifo, 16);
>      fifo8_create(&s->tx_fifo, 16);
> @@ -1311,8 +1315,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>  
> -    qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
> -                           &error_fatal);
> +    qdev_realize(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
> +                 &error_fatal);
>  
>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface = qemu_console_surface(s->console);
> -- 
> 2.43.0
> 

