Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FC2EE645F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sof4V-0005xh-MX; Thu, 12 Sep 2024 04:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sof4T-0005qc-OV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:20:58 -0400
Received: from mail-mw2nam04on20620.outbound.protection.outlook.com
 ([2a01:111:f403:240a::620]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sof4Q-0005zZ-CE
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h71ImSF6Mr4BNjH/37AK2PVbVfIFeXR6fh8jT3v8+fHDnDfeiH0zpxyMoJqqa9iY3nga8TtUhAfFOWvokvCWiSCtOXcEGtkcwrKoV12MeuBEQ90wrNS8nmZvf8DP+jHv/m5Ik1P4O5ZI1ZbkNJdWgwctGXX86LuCx5GYEit0u9TAv8+mx9qZsoIjZZU/lO6ftJ3O8adNdWwHvwHBvjwFR2PREtKHpFwdcu7FXZvAHG4AyLnjagNTyzWbjVf2GNw1rGgfozg12X72e3GLEl+6i3+h4mZRFDyVwEvdaAYZLS2I/Zi75g6saNC3Nwql8UPHmjoG2mrem/bHr+mvyqiG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/+BYWs3wrrF8ivuj4hx8vslvttn4Q5EkH9QRawbfd0=;
 b=Y6eHgtao2nTSOTI7jRgkSeqfDlwmuKakP1DLKsTUjMMTQzKKOCupTdJosayxrbDPbMk0txe6EytnF45qtucxDqAYlvUDEzKQ28i9cY+hx3sUEMqqw50IOgb++G6xMaku8q2HvsSfm919TgGVLT1002iuag1nfJVi696R3xXMeWNqWeMWA7J4Q4QNAeVfQV+bT6FXinfBYlFxrX9VB7h0+Cy2Hv7f2JHut3oBa4I4RnAnYA2XmGrS10VbBkiPy/zEiu4s9eE/uoNtkzdECdW7O02SycogPBW+Ea0D8pNj+GvDpCrH4LTwSdDi+cSZPJyzKgkVQTDgp882/wJWA2VX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/+BYWs3wrrF8ivuj4hx8vslvttn4Q5EkH9QRawbfd0=;
 b=dt+hrRlJhe+uoRbkpxkK4XVDlvHMSge3GtqGypyQ2DLl9zgC6g5YEMwkeoU2gfxLmclDYqSU5uve96HEbL/Bq3TcbFWIuGsBcOgsbpgOQhdzgdkqKa6j4uwDidaj1GZGEPc2MxXJtbXMVhUaefzVl7TTVe3R8b8EB2e4BkSdstqm8fE4ODIcsbEYXoNUdRIhx0hXTI0wvN6H2+ABC47XBdEE603ciPF6a1/AwkdQkryNoO9VP3Z2cRjYwJydKp0edW0HeC/KpRlk9xYjFf/8bhy2YMhnDZmv3Jsz7/59CK7vTaEk8RaJdfDTpaBEnwB8G7bskFjZt6pTBpASkPX6lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 08:20:47 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 08:20:46 +0000
Message-ID: <5a9dba27-96e5-4404-b429-c36d9b1c5707@nvidia.com>
Date: Thu, 12 Sep 2024 11:20:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] vfio/migration: Multifd device state transfer
 support - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <4133ce80174fa3b81070adaeeb068554beba2854.1724701542.git.maciej.szmigiero@oracle.com>
 <12ebbb56-c2a7-42d0-8dad-9b459a490c39@nvidia.com>
 <ad637771-3eff-4492-b3a8-e72bb1e91551@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ad637771-3eff-4492-b3a8-e72bb1e91551@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd1c4ec-32f3-42a0-cd17-08dcd303cd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTFyQjNPS3pST3ZMY2R6ZWRIRjluYU8vWDBlcWJnellRUUQ4aU5KM2F5d3g1?=
 =?utf-8?B?YWRXRE5Jc0tEVEV1RWwya2dVaSsyZUNDM05kakdnV2k1Z2xLaU1tY0dpZGRY?=
 =?utf-8?B?S241aldlSElaZVlmSWNVSzNraVRlQlo5a1ZEM1lxVUpIbUxCd0xpdXpnUjFM?=
 =?utf-8?B?VXZXcVRDQ2YxMG9Lc3hoS1ordk44T29Uc3hnSzQ1bXFyUkdmY2d4UW1MUkdu?=
 =?utf-8?B?SXl4SmdHOXFJRk1EMjRocGFMMVo3VTluVjhhQlE5Qi93NmhINUFoS3FEQmtZ?=
 =?utf-8?B?dU9JdTVWMXdRYjMwTnpseURtV1hlU0tvYkJDUnNjVnQ3UzAvcnJ0YlJJaHhE?=
 =?utf-8?B?cStBWktFMjAyd2NobytSMjk2bFhXUk9TdW9ybTRVaDlQdWp2YmdMMjByTVlt?=
 =?utf-8?B?RGpaRnRhditudlRxRkVqd1dDdXVzek5YdU9CRjY5Tjkxd1N3QkN2cGM2Vzhm?=
 =?utf-8?B?MXJwQW1TSE5VWGh5VmRha3krNSt5UmdPZ2dIUUtGOVNYakJzbWRMQkdYNFFm?=
 =?utf-8?B?bDV0bFY5Ukl4NGJQSGhDZzduVFNiT04rZVZoRXdNVWJRRzJxZ0MzY1Q3Qkpx?=
 =?utf-8?B?WnRDa1A5YWpqTmhwem5KY1lPM1hGU2N5MC9MY2MwZTJmMmtLTXJUandsaWp0?=
 =?utf-8?B?UmcxZ2ovNzQxR0xRSWpYL1dITWMzUFBVT2lLVXJLSUY3M1dWMTY5K2Y3VlRm?=
 =?utf-8?B?WVBIakhncFhvblpyMEpZN2t0ZFgyRUpuNXlRMUxFaHJYTnJqVlZvUEJOQ0hH?=
 =?utf-8?B?N1BZU2UzUnVqbXV5ZjI0T0dKSkVqcnozVXR4TFY3SlFudHVFZVlIaUNqRkg3?=
 =?utf-8?B?QzAwbUsxK0pDQVFSS1VYN2VqREFMWFVxVnEwMkNnb01ibFp2dWt4OExsam5C?=
 =?utf-8?B?UmRvelpVdXlpZFJ5RmhFN1hHK1g2TlVkWm5rQ2dYSmd6SmtQak5vRG1Wd3Va?=
 =?utf-8?B?WnZ4ODFybjNiN25aUzVKZ1hjQ3EwcWVHQWU0dExmQmM3RGppdGVwOEFRVWlU?=
 =?utf-8?B?UzRhL3ZEOVpKVEVyY3M3QTM2VE90WVM4azRWUWRPajBFYWlvTWU4NHdqWHFP?=
 =?utf-8?B?UmNVVHVDQWQzcWlvQVpxck9wbjZLZUxYNzVPM2JpY25kWEU4WGpvaWFtdnFV?=
 =?utf-8?B?UUtOSU4vQzF4K1FRa0VpeUx6YWlHZHgxVE42RWd0MVhyUEhRL3EvU2ZwODAz?=
 =?utf-8?B?MmQvd284S1BkNHN5Y1RkY0pkUjlXbG85WDg4T0tndm9qblo4c21qZzFYVGM3?=
 =?utf-8?B?VmZMdXpZaExwZUROb0hIMlZnS1Vtd1JjenYySCtkNmpubUozazU1OWljVENq?=
 =?utf-8?B?TkZ1LzRIOGE0NWJVb1MyNkdsemlXTXVNaGFnbThLQklEQ3NuRVEvenFjL0Yw?=
 =?utf-8?B?UkUxd0praTNOSzZ5Mnl6cUdmSGZrS2gxbzROOXQvRXBjSEdEbGh5cm9UUHhQ?=
 =?utf-8?B?Wm1FUUM4OFFCWDhWTmUxTmtVcENORnErWDNZa29OM3JDZi9zdFU4UVZBRnZN?=
 =?utf-8?B?Z0hhcVdaNDRrN2JoNFdwa1pxSUUwV3kwai9xNUE3TGJxbEdUZXEvaUxhYUxQ?=
 =?utf-8?B?SGI5RmF5eHlDQ3RaVEdUdDcvUTZRVEFXMmdqTFFRS3M0dVdrM0l5Ukx6d3E4?=
 =?utf-8?B?VzBBSlJlT2xyMU9Ea1lzdHl5M2wyd25jVUxRaVM0K1dadVZPNlMwMDV3VEdp?=
 =?utf-8?B?RUx4cjlKb25iT2QwT2M3QUpCa2I1V1ROSFVhODF5Q1JZWkU5TVl3elUxNjEr?=
 =?utf-8?B?Z2xnVzBvdC9SODZ4S1NWaFNSbnNJTVlsVDRnbWRMNVp3RTI3ZGFPd2tNazVY?=
 =?utf-8?B?TlJDTmdYeDN4M3dhcUE5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBkcURtRjFXcm1pZk1FbjBYdHdpeitmUVRIY0JVT2ZjN1VpQVVZY0g1ZkdG?=
 =?utf-8?B?d1R2bDFyU2Ixdk5UYUE2NUhDT1FvWDlNL2QrblRha2xTeWc0WDkvNmFZRzBi?=
 =?utf-8?B?VEdJMUk1UGNGb2VudTZOU21NZDRzTGp3azg3aUk1eGd0NEpLalBmYXQ4bG4y?=
 =?utf-8?B?dUhmR3FVbVR2SVlucDkrZllzS2pQL1gzenhuWFd0MlNiN1h5RjVIYnFwaVNN?=
 =?utf-8?B?VzZMVERBN001dFZsbVFnakFQOE94ZUFYSXVqOExOMEh2UkNvdkRVOG5rZ21q?=
 =?utf-8?B?RHJrbHg1MTd2SGh2YXNRNkZLS1VwWWJrMXFBQkMxOGZxSXJZTnd3cVErWHRy?=
 =?utf-8?B?ZGRUdjlyZFR1bWtLS3ZnVkZRVFRpTWs5dGZvUGtlcTZIeFJTU0NNSmdmb3lI?=
 =?utf-8?B?YkN1VXVKZTBOdzUxTFFGTWIzNUFFTmNZc1NiVHpzUzk5MDFmMEVLWWIvYlpV?=
 =?utf-8?B?eEtPcGJuVmluc3pmcytrb1VEQXlLN0duTENqZDBtWm4reE5scmNKVG1YQVJC?=
 =?utf-8?B?ejNWQS9Scjcxc1RHK1pjS2kxN1NhR0dhRG93RVR0eXFEUmhMaWxlZGg3SS82?=
 =?utf-8?B?YVR4R2tyQVk5OVpZNnlnMDFSWk9nbEtSSWlqZ05qbU5rZ0pHU25OdDlweGpS?=
 =?utf-8?B?MWQxTjd5WHZxekxhVHc2cktGVXY3REJuandscStucG5HK0RpNmd2S2FpT1Jn?=
 =?utf-8?B?VXBxQXRTV3JYQUNkYWd4TmZLanZkc3Q0RzJCdmxsdkJuQmJsUkMxVUJHUEZ1?=
 =?utf-8?B?T1AzeUpkUVNVY0JMZEtoR1EwTU81RHFOTjZzcXEzempkbHFEL0svem9lL29M?=
 =?utf-8?B?RnZwYlVZd3hxcWhFaTRlL1VucUFENS8wczkwSGNzYm1tc2hTaWcyV242OUcw?=
 =?utf-8?B?alJDbkJTbGVxaFRDYXdYdkorNEcrUk1lZVkybTIrMkhDMVVzdlRyd3ZiR0VT?=
 =?utf-8?B?aW1GNDZJTER5OXBsZlJZYzVpQzA5dEdWZStoeHpBRVd0RWZnTzBCNEVKQzhK?=
 =?utf-8?B?eU9IOGIxaEZ3dWtoMmgwUElHOGIxRmdwenNJMGFIQmVjM2plTzFPWTJaV2Zl?=
 =?utf-8?B?R3IwMlpBSkdhbzZ2Tmo0amgzSWRib0lYSm41TVQ1RFp5RXhENXZxTEhEV1VF?=
 =?utf-8?B?Zi9ndFpBcUdIdVl3Wjk3b2d3aHp2bFB5ZGZaSGhrZmozcjdIR2tZc3R6YmlO?=
 =?utf-8?B?TjlCSHdMK2ZCWVp5UExaREkva1dUWTQ5dXRBQlA3ZFFhM1NkaGtQRjltUi9l?=
 =?utf-8?B?KzNONEFMd2IzbkNBN1huM1kxaUxDNjV5c09uUjdlVUQ2REs5OWdoMWZGVHpv?=
 =?utf-8?B?TVl0VWVRcUk2bEgyUE42RmtwRHFzS3JybllUU0p5SmRDaHdIWjh2UVhCbW45?=
 =?utf-8?B?MkVvOWVDMzExYnVRSzEydFBaMmRLeUtuU0tkWS9PODhtb21HV3U1dDNHVEQx?=
 =?utf-8?B?aWRJMmFNc3VzNmNzTk1sZ1cwRkduakxxS3ZWM2p5b3czZ2lVUURzenMrUjFY?=
 =?utf-8?B?R1ZTeHFSNGZ2eEVtbWdHWUh2bXIyNGhjb1NTbzN6bjlaUXA3dk15SVBDVlVv?=
 =?utf-8?B?eXJUcVk3SGNOZ1ZsR0JHbHkzS1NJUldwV0d4aGFyM3BreFVCcUJPU0REdGE2?=
 =?utf-8?B?dGxxaG41dVpBYm9LdkFvWEdqa0xOVzNCNTVJb0o1c2QxSkFQanFab2JET0lE?=
 =?utf-8?B?UE83VDk1eDNwd1JKcTZUdWhPcWVQZXNVTjNTVkxJaXlTOGVHa0ZuWWxQbk96?=
 =?utf-8?B?Y01WdklZYzZkYjhXMHR1MUxkRjdFZG5nOFJVRVQ3MFZ4cUxWUmM2eWxYekdQ?=
 =?utf-8?B?Ym1LR3F5dmw3ODVxNGlzdWw0d09xWWtnbUhmSTZ2SEtScy9CWUgxQWowRWVM?=
 =?utf-8?B?c2N3QlcwczdHc3AxZHd6UlhlMkRoS0dMWFpPTng2aVIzNm9PTnVGV0NJbUo1?=
 =?utf-8?B?dmZQMU8vRTg5R0ttdXhpdVJSUlR6TTh0TVNweWkrbHhtMnkvclhsNnVwclNT?=
 =?utf-8?B?WHpyRG5Pd3Mvb2UvdkcrbGxnZk12clpaRk1ML0E5dm91ckZNSUdJZDJSTHdp?=
 =?utf-8?B?enVIL1dtZEFPd3NrTTZrMUJrdFc2QjkwM09yOE1QYmpZZFlUZTlVb2dVaW5x?=
 =?utf-8?Q?yqkqXVpXKFQ4Usjsu2q+ArXhv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1c4ec-32f3-42a0-cd17-08dcd303cd9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:20:46.9409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSkmp6chGQA9sDLdncjkzsDvdTGTnQtkv6ZIuyyJS1lT7snXABxmN59FeERf4dn/GLzIuRQCgqFwXqxWX2X0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
Received-SPF: softfail client-ip=2a01:111:f403:240a::620;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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


On 09/09/2024 21:06, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 9.09.2024 10:55, Avihai Horon wrote:
>>
>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> The multifd received data needs to be reassembled since device state
>>> packets sent via different multifd channels can arrive out-of-order.
>>>
>>> Therefore, each VFIO device state packet carries a header indicating
>>> its position in the stream.
>>>
>>> The last such VFIO device state packet should have
>>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config
>>> state.
>>>
>>> Since it's important to finish loading device state transferred via
>>> the main migration channel (via save_live_iterate handler) before
>>> starting loading the data asynchronously transferred via multifd
>>> a new VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE flag is introduced to
>>> mark the end of the main migration channel data.
>>>
>>> The device state loading process waits until that flag is seen before
>>> commencing loading of the multifd-transferred device state.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 338 
>>> +++++++++++++++++++++++++++++++++-
>>>   hw/vfio/pci.c                 |   2 +
>>>   hw/vfio/trace-events          |   9 +-
>>>   include/hw/vfio/vfio-common.h |  17 ++
>>>   4 files changed, 362 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 24679d8c5034..57c1542528dc 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -15,6 +15,7 @@
>>>   #include <linux/vfio.h>
>>>   #include <sys/ioctl.h>
>>>
>>> +#include "io/channel-buffer.h"
>>>   #include "sysemu/runstate.h"
>>>   #include "hw/vfio/vfio-common.h"
>>>   #include "migration/misc.h"
>>> @@ -47,6 +48,7 @@
>>>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE (0xffffffffef100003ULL)
>>>   #define VFIO_MIG_FLAG_DEV_DATA_STATE (0xffffffffef100004ULL)
>>>   #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE (0xffffffffef100006ULL)
>>>
>>>   /*
>>>    * This is an arbitrary size based on migration of mlx5 devices, 
>>> where typically
>>> @@ -55,6 +57,15 @@
>>>    */
>>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>>
>>> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
>>> +
>>> +typedef struct VFIODeviceStatePacket {
>>> +    uint32_t version;
>>> +    uint32_t idx;
>>> +    uint32_t flags;
>>> +    uint8_t data[0];
>>> +} QEMU_PACKED VFIODeviceStatePacket;
>>> +
>>>   static int64_t bytes_transferred;
>>>
>>>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>> @@ -254,6 +265,188 @@ static int vfio_load_buffer(QEMUFile *f, 
>>> VFIODevice *vbasedev,
>>>       return ret;
>>>   }
>>>
>>> +typedef struct LoadedBuffer {
>>> +    bool is_present;
>>> +    char *data;
>>> +    size_t len;
>>> +} LoadedBuffer;
>>
>> Maybe rename LoadedBuffer to a more specific name, like VFIOStateBuffer?
>
> Will do.
>
>> I also feel like LoadedBuffer deserves a separate commit.
>> Plus, I think it will be good to add a full API for this, that wraps 
>> the g_array_* calls and holds the extra members.
>> E.g, VFIOStateBuffer, VFIOStateArray (will hold load_buf_idx, 
>> load_buf_idx_last, etc.), vfio_state_array_destroy(), 
>> vfio_state_array_alloc(), vfio_state_array_get(), etc...
>> IMHO, this will make it clearer.
>
> Will think about wrapping GArray accesses in separate methods,
> however wrapping a single line GArray call in a separate function
> normally would seem a bit excessive.

Sure, let's do it only if it makes the code cleaner.

>
>>> +
>>> +static void loaded_buffer_clear(gpointer data)
>>> +{
>>> +    LoadedBuffer *lb = data;
>>> +
>>> +    if (!lb->is_present) {
>>> +        return;
>>> +    }
>>> +
>>> +    g_clear_pointer(&lb->data, g_free);
>>> +    lb->is_present = false;
>>> +}
>>> +
>>> +static int vfio_load_state_buffer(void *opaque, char *data, size_t 
>>> data_size,
>>> +                                  Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>>
>> Move lock to where it's needed? I.e., after 
>> trace_vfio_load_state_device_buffer_incoming(vbasedev->name, 
>> packet->idx)
>
> It's a declaration of a new variable so I guess it should always be
> at the top of the code block in the kernel / QEMU code style?

Yes, but it's opaque to the user.
Looking at other QEMU_LOCK_GUARD call sites in the code and it seems 
like people are using it in the middle of code blocks as well.

>
> Also, these checks below are very unlikely to fail and even if they do,
> I doubt a failed migration due to bit stream corruption is a scenario
> worth optimizing run time performance for.

IMO, in this case it's more for readability, but we can go either way 
and let the maintainer decide.

>
>>> +    LoadedBuffer *lb;
>>> +
>>> +    if (data_size < sizeof(*packet)) {
>>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>>> +                   data_size, sizeof(*packet));
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (packet->version != 0) {
>>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>>> +                   packet->version);
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (packet->idx == UINT32_MAX) {
>>> +        error_setg(errp, "packet has too high idx %" PRIu32,
>>> +                   packet->idx);
>>> +        return -1;
>>> +    }
>>> +
>>> + trace_vfio_load_state_device_buffer_incoming(vbasedev->name, 
>>> packet->idx);
>>> +
>>> +    /* config state packet should be the last one in the stream */
>>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>>> +        migration->load_buf_idx_last = packet->idx;
>>> +    }
>>> +
>>> +    assert(migration->load_bufs);
>>> +    if (packet->idx >= migration->load_bufs->len) {
>>> +        g_array_set_size(migration->load_bufs, packet->idx + 1);
>>> +    }
>>> +
>>> +    lb = &g_array_index(migration->load_bufs, typeof(*lb), 
>>> packet->idx);
>>> +    if (lb->is_present) {
>>> +        error_setg(errp, "state buffer %" PRIu32 " already filled", 
>>> packet->idx);
>>> +        return -1;
>>> +    }
>>> +
>>> +    assert(packet->idx >= migration->load_buf_idx);
>>> +
>>> +    migration->load_buf_queued_pending_buffers++;
>>> +    if (migration->load_buf_queued_pending_buffers >
>>> +        vbasedev->migration_max_queued_buffers) {
>>> +        error_setg(errp,
>>> +                   "queuing state buffer %" PRIu32 " would exceed 
>>> the max of %" PRIu64,
>>> +                   packet->idx, 
>>> vbasedev->migration_max_queued_buffers);
>>> +        return -1;
>>> +    }
>>
>> I feel like max_queued_buffers accounting/checking/configuration 
>> should be split to a separate patch that will come after this patch.
>> Also, should we count bytes instead of buffers? Current buffer size 
>> is 1MB but this could change, and the normal user should not care or 
>> know what is the buffer size.
>> So maybe rename to migration_max_pending_bytes or such?
>
> Since it's Peter that asked for this limit to be introduced in the 
> first place
> I would like to ask him what his preference here.
>
> @Peter: max queued buffers or bytes?
>
>>> +
>>> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>>> +    lb->len = data_size - sizeof(*packet);
>>> +    lb->is_present = true;
>>> +
>>> + qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
>>
>> There is only one thread waiting, shouldn't signal be enough?
>
> Will change this to _signal() since it clearly doesn't
> make sense to have a future-proof API here - it's an
> implementation detail.
>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void *vfio_load_bufs_thread(void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    Error **errp = &migration->load_bufs_thread_errp;
>>> +    g_autoptr(QemuLockable) locker = qemu_lockable_auto_lock(
>>> + QEMU_MAKE_LOCKABLE(&migration->load_bufs_mutex));
>>
>> Any special reason to use QemuLockable?
>
> I prefer automatic lock management (RAII-like) for the same reason
> I prefer automatic memory management: it makes it much harder to
> forget to unlock the lock (or free memory) in some error path.
>
> That's the reason these primitives were introduced in QEMU in the
> first place (apparently modeled after its Glib equivalents) and
> why these are being (slowly) introduced to Linux kernel too.

Agree, I guess what I really meant is why not use QEMU_LOCK_GUARD()?

>
>>> +    LoadedBuffer *lb;
>>> +
>>> +    while (!migration->load_bufs_device_ready &&
>>> +           !migration->load_bufs_thread_want_exit) {
>>> + qemu_cond_wait(&migration->load_bufs_device_ready_cond, 
>>> &migration->load_bufs_mutex);
>>> +    }
>>> +
>>> +    while (!migration->load_bufs_thread_want_exit) {
>>> +        bool starved;
>>> +        ssize_t ret;
>>> +
>>> +        assert(migration->load_buf_idx <= 
>>> migration->load_buf_idx_last);
>>> +
>>> +        if (migration->load_buf_idx >= migration->load_bufs->len) {
>>> +            assert(migration->load_buf_idx == 
>>> migration->load_bufs->len);
>>> +            starved = true;
>>> +        } else {
>>> +            lb = &g_array_index(migration->load_bufs, typeof(*lb), 
>>> migration->load_buf_idx);
>>> +            starved = !lb->is_present;
>>> +        }
>>> +
>>> +        if (starved) {
>>> + trace_vfio_load_state_device_buffer_starved(vbasedev->name, 
>>> migration->load_buf_idx);
>>> + qemu_cond_wait(&migration->load_bufs_buffer_ready_cond, 
>>> &migration->load_bufs_mutex);
>>> +            continue;
>>> +        }
>>> +
>>> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
>>> +            break;
>>> +        }
>>> +
>>> +        if (migration->load_buf_idx == 0) {
>>> + trace_vfio_load_state_device_buffer_start(vbasedev->name);
>>> +        }
>>> +
>>> +        if (lb->len) {
>>> +            g_autofree char *buf = NULL;
>>> +            size_t buf_len;
>>> +            int errno_save;
>>> +
>>> + trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>>> + migration->load_buf_idx);
>>> +
>>> +            /* lb might become re-allocated when we drop the lock */
>>> +            buf = g_steal_pointer(&lb->data);
>>> +            buf_len = lb->len;
>>> +
>>> +            /* Loading data to the device takes a while, drop the 
>>> lock during this process */
>>> + qemu_mutex_unlock(&migration->load_bufs_mutex);
>>> +            ret = write(migration->data_fd, buf, buf_len);
>>> +            errno_save = errno;
>>> + qemu_mutex_lock(&migration->load_bufs_mutex);
>>> +
>>> +            if (ret < 0) {
>>> +                error_setg(errp, "write to state buffer %" PRIu32 " 
>>> failed with %d",
>>> +                           migration->load_buf_idx, errno_save);
>>> +                break;
>>> +            } else if (ret < buf_len) {
>>> +                error_setg(errp, "write to state buffer %" PRIu32 " 
>>> incomplete %zd / %zu",
>>> +                           migration->load_buf_idx, ret, buf_len);
>>> +                break;
>>> +            }
>>> +
>>> + trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>>> + migration->load_buf_idx);
>>> +        }
>>> +
>>> +        assert(migration->load_buf_queued_pending_buffers > 0);
>>> +        migration->load_buf_queued_pending_buffers--;
>>> +
>>> +        if (migration->load_buf_idx == migration->load_buf_idx_last 
>>> - 1) {
>>> + trace_vfio_load_state_device_buffer_end(vbasedev->name);
>>> +        }
>>> +
>>> +        migration->load_buf_idx++;
>>> +    }
>>> +
>>> +    if (migration->load_bufs_thread_want_exit &&
>>> +        !*errp) {
>>> +        error_setg(errp, "load bufs thread asked to quit");
>>> +    }
>>> +
>>> +    g_clear_pointer(&locker, qemu_lockable_auto_unlock);
>>> +
>>> +    qemu_loadvm_load_finish_ready_lock();
>>> +    migration->load_bufs_thread_finished = true;
>>> +    qemu_loadvm_load_finish_ready_broadcast();
>>> +    qemu_loadvm_load_finish_ready_unlock();
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>>>                                            Error **errp)
>>>   {
>>> @@ -285,6 +478,8 @@ static int 
>>> vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>>       VFIODevice *vbasedev = opaque;
>>>       uint64_t data;
>>>
>>> + trace_vfio_load_device_config_state_start(vbasedev->name);
>>
>> Maybe split this and below trace_vfio_load_device_config_state_end to 
>> a separate patch?
>
> I guess you mean to add these trace points in a separate patch?
> Can do.
>
>>> +
>>>       if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
>>>           int ret;
>>>
>>> @@ -303,7 +498,7 @@ static int 
>>> vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>>           return -EINVAL;
>>>       }
>>>
>>> -    trace_vfio_load_device_config_state(vbasedev->name);
>>> + trace_vfio_load_device_config_state_end(vbasedev->name);
>>>       return qemu_file_get_error(f);
>>>   }
>>>
>>> @@ -687,16 +882,70 @@ static void vfio_save_state(QEMUFile *f, void 
>>> *opaque)
>>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    int ret;
>>> +
>>> +    ret = vfio_migration_set_state(vbasedev, 
>>> VFIO_DEVICE_STATE_RESUMING,
>>> + vbasedev->migration->device_state, errp);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    assert(!migration->load_bufs);
>>> +    migration->load_bufs = g_array_new(FALSE, TRUE, 
>>> sizeof(LoadedBuffer));
>>> +    g_array_set_clear_func(migration->load_bufs, loaded_buffer_clear);
>>> +
>>> +    qemu_mutex_init(&migration->load_bufs_mutex);
>>> +
>>> +    migration->load_bufs_device_ready = false;
>>> + qemu_cond_init(&migration->load_bufs_device_ready_cond);
>>> +
>>> +    migration->load_buf_idx = 0;
>>> +    migration->load_buf_idx_last = UINT32_MAX;
>>> +    migration->load_buf_queued_pending_buffers = 0;
>>> + qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
>>> +
>>> +    migration->config_state_loaded_to_dev = false;
>>> +
>>> +    assert(!migration->load_bufs_thread_started);
>>
>> Maybe do all these allocations (and de-allocations) only if multifd 
>> device state is supported and enabled?
>> Extracting this to its own function could also be good.
>
> Sure, will try to avoid unnecessarily allocating multifd device state
> related things if this functionality is unavailable anyway.
>
>>>
>>> -    return vfio_migration_set_state(vbasedev, 
>>> VFIO_DEVICE_STATE_RESUMING,
>>> - vbasedev->migration->device_state, errp);
>>> +    migration->load_bufs_thread_finished = false;
>>> +    migration->load_bufs_thread_want_exit = false;
>>> +    qemu_thread_create(&migration->load_bufs_thread, "vfio-load-bufs",
>>> +                       vfio_load_bufs_thread, opaque, 
>>> QEMU_THREAD_JOINABLE);
>>
>> The device state save threads are manged by migration core thread 
>> pool. Don't we want to apply the same thread management scheme for 
>> the load flow as well?
>
> I think that (in contrast with the device state saving threads)
> the buffer loading / reordering thread is an implementation detail
> of the VFIO driver, so I don't think it really makes sense for multifd 
> code
> to manage it.

Hmm, yes I understand.

Thanks.


