Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E0BCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBrBw-00013a-Rp; Thu, 23 Oct 2025 05:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1vBrBu-00013O-Vv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:01:03 -0400
Received: from mail-westcentralusazon11013000.outbound.protection.outlook.com
 ([40.93.201.0] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1vBrBr-0003s9-Sf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1Vba8K+JVf5WGQnl3tUe90ozK8smNw20MzvyFNVbi+wR3K5p0vmSBqpTUwizTBVKwGygeZBK8xpCCHuXCFT0H7CWa4aGH4DGM+0r3ykLIF1Uvr5yELwm+z2yGFuFSQN2jQkFK2tk+u3jrAi8tdiN9Fe0Vct0fksuvXJokh76+KrELArKEpxIUgCEODTbMEpmDwynVmPjbdtTS2QjQNTPC+AkDsEmMhzs8qwWDFjw5mzg+0QfOkU5ZQaJS/WD+SMl72ZV/yM48nnwdpc7zZQGO19EibDIGzcS3AvShkWa52CL7tUYtKU38IwjXJ2fIpSx5OL1TBGhxFtv3+Y3tCmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzfwZCceF4wWOKQ3APZGG3TEWSaoZ0JykLg7ajLVIlo=;
 b=jQ+B2RmufF3+v/xucCM3gPwp6K1DsJopHO7GRkXVanOT1daODJpQ/Z7HWBUIaiWlQoxZk4ME/DFdM8r87ZusAAPkM59f0ac9AzLim5KLK28QVOLSZF77psfMAxuIgimvR2TG5Pto2QN9X1RDPro1mX15aFaUtAsEO/W42kBC02O9lvr/OmUp90BSZR7NBFK/4tkvNaf5OXRuYpLV2ZTO6KoIHZpPFOl0ZTFwxkYT6Cwq+dv5JSnibTo/THZpwBGxr2HOUf2D4VOOocWH9mrj+3jPWmmyRRdCTiahqwTpcPQRITrcBEoXS6jN56O0JSXyDonwMuZRfuIBuj7lxxA5xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzfwZCceF4wWOKQ3APZGG3TEWSaoZ0JykLg7ajLVIlo=;
 b=b1z1lEf11bEqSBGpXTrJzr/L7/v65haLPFWJTdU6qxOC2i16tJkYKE2qhfl8J29NoImfM3uYCajG+pdQL2dJgVAvCICULtmxk5tiV/snlIq98V7SkM49hT778CCvC6BxgmH+rdKx45ScZ9CvEx5VqFosgC0I/DXyvnnxNcCks2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DM6PR03MB5227.namprd03.prod.outlook.com (2603:10b6:5:247::22)
 by DS7PR03MB5445.namprd03.prod.outlook.com (2603:10b6:5:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 08:55:54 +0000
Received: from DM6PR03MB5227.namprd03.prod.outlook.com
 ([fe80::c9a0:563d:c344:aec2]) by DM6PR03MB5227.namprd03.prod.outlook.com
 ([fe80::c9a0:563d:c344:aec2%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:55:54 +0000
Date: Thu, 23 Oct 2025 10:55:49 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH] hw/xen: pass PCI domain to xc_physdev_map_pirq_msi()
Message-ID: <aPntlU6fPwU4jx_w@Mac.lan>
References: <20251017155136.16540-1-roger.pau@citrix.com>
 <d4bb9b02-5cdc-4da5-926b-7bb17f78bcfc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4bb9b02-5cdc-4da5-926b-7bb17f78bcfc@linaro.org>
X-ClientProxiedBy: PR0P264CA0175.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::19) To DM6PR03MB5227.namprd03.prod.outlook.com
 (2603:10b6:5:247::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5227:EE_|DS7PR03MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: a64ef638-322b-416c-6544-08de1211f922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFBmcmpheTBiRnI5Wk5iZ3doZXppRGNxd3g2S1pINEFvWmI1TEZJclpHdU9u?=
 =?utf-8?B?QkNvLzVYdFIrd3F2ZHpBTkZFSy9mOHNUeHFsNFZKNlNDeXNpN2NObzNBWU5D?=
 =?utf-8?B?Y0lqcWx6dFlMT2VoRlBHNElvYlUwUWx3WVM5Z0wvclpIcUFHWDFBOWpxK1RB?=
 =?utf-8?B?Si9DcG9ockl0MW9VNkkrUWZ2WUpSclpiVmx3OVVJdVpRV2RJRm9iWEQ3MU5W?=
 =?utf-8?B?R2xPYVZqRldJZ3dvM0o3MFpvTThwTzJESTBBS2lvWTYrbnU2YzRvekNOVzND?=
 =?utf-8?B?ci92S2JFWHloUWRaS01MajE3eUlrazRQTjZKdmNNb1lEV240dk9SaEFLQW4z?=
 =?utf-8?B?OUZDWVhTSENvNHJQS1Z3czlSckRMTXQvUC9yMm9qUk5mZG9SZURPSHJjejJZ?=
 =?utf-8?B?ZjQ1VVJhRFN6b1c2THZWMks2clFYVnlZWXB1T1B5ci9BTGcrMFBWRHY2cG80?=
 =?utf-8?B?OTJhZ0lLUVRHOERJcllCMDFSZEZodWNIUUxCL1VUeUJGMHk3ZUxKRjg0N2xn?=
 =?utf-8?B?UXpCL1NIclk2aHhweTRRT29kOVpudk1VakVTWlk3RUZVc2dFYzlaekhMYm5l?=
 =?utf-8?B?c3VYY0c1NGhOTkMzOHNIQ1BpVUpOeXJzamdJek90TUhZRExsbWVsbzNKcUsy?=
 =?utf-8?B?eGFlclBoTk9JdmpNdWx5Tit3RG0yQkJkUXR3bFowMmRHcTNKY1ZNcUhZajFG?=
 =?utf-8?B?V2RvRCtSUHRtTDZNcjkvR0hzWVpOTGc5aEtoRHY1TjllUW81L1h3K1E1THpu?=
 =?utf-8?B?NW13bzRqWVB0NkRuVjE2NVQ1eWNseFZrYXJBekhuaVlYVjJpK2JmVWxwb0dM?=
 =?utf-8?B?OEYzb2JwVjBySDFPMmVteEFUeGdxUC9aYVoxeGpyWFpDcE9PSUJoNzVieTgz?=
 =?utf-8?B?T29TY2VlMk9LNU5LZWZ3VnJBVkVNYVVJc2E5K0F5d2JkUnBvS0QvMVo2RGRl?=
 =?utf-8?B?NVI3Q1A3aEpVdk1JbXFFbDVtdEh5dFRzMXN3Y1J6MEpKWElmMVJUTm9PbzQv?=
 =?utf-8?B?YmhyVWV3S0QvUXJQenBXZkdIM0o0L2NTWjdoT0doM2l2bEF1em5oUERGTmZ4?=
 =?utf-8?B?Wk1GcVZ0TjV1b2xpbEdPYkFzY3BYYWNDczQ0K2plMlR6WldjUEE0QXdJZ1Z1?=
 =?utf-8?B?UDlOSXlXaE40bDN4azhGaVFQQ2Z5S0E1c1FDYnBsMkUvNnJpcjYwMUhMN1d2?=
 =?utf-8?B?aEVaNnYrV1JuQi9qZnlGalMzYStkc01QUExTREJHcjQ3a0wwSStEMG1INU9G?=
 =?utf-8?B?TDQyK1dVSmlGSGQrRVB3c21VYWNxWUNaSkhLVi9pbnpYMThzUm5IeEJjKzhR?=
 =?utf-8?B?R2wxZHZJUzlGSlJCSkZNejIzNG1QNEExd1k3RGxSUFF1aUVDQXA3K2RJQ0R0?=
 =?utf-8?B?enNHb29JMHF6a1dHd2VyTy9OckFQaXlhc2o1L2cwQjVReWQrY1BWU2dIWVEr?=
 =?utf-8?B?Y0RpRXpCZ3JzMm5SSWxMcjdrRjk0d3Vic2lDNHY0QXNqM2ZJMWZxYWNOb0xa?=
 =?utf-8?B?VUtEVUFGK1l6aU9Hd3JUdG9pbXRHd3p1a2ZENTNOd3BRcnpxUzRZNStLa3gw?=
 =?utf-8?B?WHpwY2h0c0kyTCtVdlBVN25JWllXT20yVUNlanRLdk1sQ1dvL1F1UWFJeTBi?=
 =?utf-8?B?THdxSG1mcDczN244b0tOdCt4YzlQZTNnQ1FzL0R4VnFFQVREQWN0MlBTdU5D?=
 =?utf-8?B?RllzbW5CWnZMWnllOS9jMkdzZ0EreW85NnFJZjlBN1dtUFJDWlp0bjMrajBR?=
 =?utf-8?B?SGpwMGhOaGN5TXF0OEsweFB4OVl6M0Y0Vjg4Z2hzd2h0QnlqUUF0Vlg2b0dC?=
 =?utf-8?B?a25POE1aS1ZaOU9SNm1pOEFwZFpObVNqU0pYYVV6bVRJT05HT1dxajBQUEx4?=
 =?utf-8?B?aUFaWExyRGZ3SWxIV1pRTVQzYmd6WitiMXBuYnNEMVRHOVhDRlhaRmdEclRp?=
 =?utf-8?Q?ldzNw3QjhUxodiQk45V/XXWmpnH05TyJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR03MB5227.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJRU1hHUGo1NHc2QkRsWnNDVHJSVUJpdjR0YmQ1UmpqcERBMFBBTG1VWWdY?=
 =?utf-8?B?cTRzODU0WGU3MzZ6d1lyUGl4ZmRZQ2cyVHlBY1hyWUVUdDRGdStuVEREV2RC?=
 =?utf-8?B?WVptSlY5UmFNRHV6N1hubFRiV2x4QnAzRW5QalVjMGp6SkxkSVFpbXJ5SUdH?=
 =?utf-8?B?djVXdGVWY3QxVEJEVDhlS28vQUpqd0c3OVN4NHpiWU4ySkZEOGVVQ1ZLQXdU?=
 =?utf-8?B?MVpTcnFSMjhjRUwyc0VZZ1AreERjOCtCa3gwSFYwZTRGSUhRS24rMmxsSVNx?=
 =?utf-8?B?WHhiNUFJeVhIQVFubU9RemlGanpPS1VscTVVc00yRDk4b2R6eTQwUmJXc1A5?=
 =?utf-8?B?Ni90K3JoWjA4RVY2MlBWZXBRWkRibTIvUTB0R01GMHRMNGEzY3F6YmYxdVJN?=
 =?utf-8?B?ajZPUHg1bnQweGZGbnBGalk4UVVEYzVkWFNNMlNtVEQ5S25xa1EyWnNqa2hN?=
 =?utf-8?B?M0lmcHdYUUpWbkMxU2pWRm5DWkxIQWdpYzJRQngveXY5aXNSMG1WUzlzLzFV?=
 =?utf-8?B?RFQyVVRYa2lGQ3IzZWZLenJGMDducW5WbFppT01INDRtNVZzUEFSUEt3MFNQ?=
 =?utf-8?B?N3BpZTJtQ2ZYQjZUNXFHaXhBZWEvZ2IxQjZUdnVwcTZZRVgrTXVMMDQvOGI5?=
 =?utf-8?B?bjl4UzhuYThjeGFEbTUzUHlBemZIVE9pTlJEMlNXait5LzhUbVExd0VmMFpT?=
 =?utf-8?B?a3MvWlFEK0w4L3laSEdoSjUyb1BwaDhjME9GMEI2YkljbGt2dE1ja2NGR3R1?=
 =?utf-8?B?UW90N3VMaFNYbFh6SEUrQWhjNDJ1OEZtbDNhV1lURnVwRzB6aisvNGxHOG9Q?=
 =?utf-8?B?KzhCdjJ4V2RVeWVYSWVRMExOUlo3WnpweXNCSjRrbU56NEFiM0ZoRnhOaFg4?=
 =?utf-8?B?YWlNM2c2RXRlbkpPU0lxUnhiYWszMzVZVVBxUi9Ob3pUM053VDArbTNyOG9V?=
 =?utf-8?B?TWtzdlRPZmpxWWxaU0xyZVNtMjJQZ3ROa3cxa2tOMEJwMnJKTXUxRG5uZU12?=
 =?utf-8?B?S1U5OE54ODg1WC9ad3R2SXJTUDJ2OVBET3hKMTRSS29BcTZCeWZLWW85SmZS?=
 =?utf-8?B?ZG04UkJBNTFhckZiWTRXK0gyTnRLdm84VFdJNU1xSGt4dFk3WnFRZVBDKzA5?=
 =?utf-8?B?VHZvOUZQVmhOL3JiRjhjSW1NNSt1NmQrWElkK251ZDZNR1JVL3hyTHNDNFBC?=
 =?utf-8?B?dVMyWFRNSzN0aDU5S2VONjNxOGRhclUvem5CNDRxV3h5ZnczMlRpVmo1a2M1?=
 =?utf-8?B?OUl3Rm95eExscjV5clEra1pteGh4YlFnS3NMSThWQytXYUhmOFFqWS9nQnFq?=
 =?utf-8?B?WDJPME9EMEhpK042aWI4byt3ZWdoNnBqTm1TdThwUEx3OTYxTXk5L1JnV05U?=
 =?utf-8?B?Y2pGbFVNWVF0TUFZUVJzem5XMkROUFJFU0o3bzBhSzhCODBDSXlUNGhCVVM0?=
 =?utf-8?B?NXM2WnhoQm9LWVIrSkpuSXhnc2dkQkJLWHhIbzFqZ3pNZjJBaW1ZUWNPTjN5?=
 =?utf-8?B?bWJJbm5GeDI1am9BQ0RIV0tKa0xUQUtVdnJ5N0p0dGhtdFZHUjdoQ2dEVXda?=
 =?utf-8?B?QVkwNWlyWGJyaW5TdGljd08xZjFvUzV5ODNxN3MxZGdpUnhROUVsOUVZWHpC?=
 =?utf-8?B?WGhxWXUvOU5SQUFsQnFJNFhxQlJhTlU0bEdhalNKNnVINm5odzFHNG44M0ZM?=
 =?utf-8?B?Ylc5VU5rUnlLbFNwSG5WalJCbnFiQkZ4RzN1SHJhamdXUENOMFNaR2thdmRZ?=
 =?utf-8?B?dUVRbEN3djRTZkV3c0t2amJSWTJNdndZanF2aXBjTytmSVdHcjBtM0x5VllZ?=
 =?utf-8?B?RGlIc1B0WnVMMUVnczBmVjArNTBuT1pBZEpQZFZ5aFVyenZEMDZHbDJNVlFv?=
 =?utf-8?B?RlpUVjdlNmlrMGQxMmVZbGpIak5DTzNtUjNGUk94NXVJSzlPWWtUM1lBOUtp?=
 =?utf-8?B?Q2hIUUczbWxXWVZxc21JaWVFcEhBalNJZGRMVzlvcmlsUUtlbWVJTjByd05S?=
 =?utf-8?B?VzFKRTN2aWNjWjZQVU01dDRaV2JvaW96OC9tUThwVFY5eDNGa0dGUFlmME1F?=
 =?utf-8?B?UStNOGs0TUhPNDBRUWtTUTQ2U0RabmRtc1VCdGpvcXRURVdSS3FlOEhLd09C?=
 =?utf-8?Q?4x5il0UsgZ5XzBpbVT03KQkm/?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ef638-322b-416c-6544-08de1211f922
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5227.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:55:53.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH4bLRXQrUNFa2Es/srlXGKqcjGUOZKe/pbRb6Zsuo+HfQNiEAHUs1R0Gq9+YR+nUqoMaNERFhrt5achv6QVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5445
Received-SPF: pass client-ip=40.93.201.0; envelope-from=roger.pau@citrix.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 21, 2025 at 08:17:37PM +0200, Philippe Mathieu-Daudé wrote:
> On 17/10/25 17:51, Roger Pau Monne wrote:
> > It's currently impossible for passthrough devices on segment different than
> > 0 to work correctly, as the PCI domain is not provided to
> > xc_physdev_map_pirq_msi(), and hence it's unconditionally assumed that all
> > devices are on segment 0.
> > 
> > Adjust the call to xc_physdev_map_pirq_msi() to pass the PCI domain in the
> > high 16bits of the bus parameter.  On versions of Xen where this is not
> > supported the passed segment will be ignored and assume to be 0, no worse
> > than the current state.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony PERARD <anthony@xenproject.org>
> > Cc: Paul Durrant <paul@xen.org>
> > Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> > Cc: xen-devel@lists.xenproject.org
> > ---
> >   hw/xen/xen_pt_msi.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> > index e9ba17317aba..df15ccf0d030 100644
> > --- a/hw/xen/xen_pt_msi.c
> > +++ b/hw/xen/xen_pt_msi.c
> > @@ -138,6 +138,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
> >           rc = xc_physdev_map_pirq_msi(xen_xc, xen_domid, XEN_PT_AUTO_ASSIGN,
> >                                        ppirq, PCI_DEVFN(s->real_device.dev,
> >                                                         s->real_device.func),
> > +                                     ((uint32_t)s->real_device.domain << 16) |
> >                                        s->real_device.bus,
> 
> Alternatively:
> 
>   deposit32(s->real_device.bus, 16, 16, s->real_device.domain)

Oh, I have to admit I'm not that well versed in QEMU, so didn't even
knew this existed.

Thanks for picking it up.

