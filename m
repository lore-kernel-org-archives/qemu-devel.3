Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53363C87FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsHR-0000mV-5y; Tue, 29 Jul 2025 17:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqDS-0006o4-DP; Tue, 29 Jul 2025 15:42:35 -0400
Received: from mail-sn1nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2406::601]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqDN-0004pX-Mn; Tue, 29 Jul 2025 15:42:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXWtKNzdwN48ATiqHOfu6AHfLXDaz7mfnNrsFErri4ZiQ8Yf88O8cUXTSUKiqKddVx0St4xZhculMtIuyp5yLo7X2itj5TNN6SIdC23fot3Il9IpSs9a114DnnnpztnAG3sJQkocaU7UslSXemyNtz8ZTo+PJap2E1EIwzyi+SQG6+pkAtzLV01NbQx7NbKBECzkbKMWw0TfckavWxwnWzXyHf7Ko935OmCkUX4GR6kSblgynq6IuxLkDeJqfyYdA9O0KK81RZCBKj6TZNy8HWdL0cUp8Jz66QceacyVxQ0U1iL18nczsFVQJXXXpfyeSLlJfGCLbnkD5hkMHdx38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz/sJN43+ETTIrdVv3FplaHKHsH+PkHeushS2uhPksE=;
 b=HvHQPNnAljjZve9INXuJt+rqd2gFPhnZA6/xLpO683oic7bomm9ppjvzuSqVl71qEBI7eakIC/8wYvh0SEyWCwJZjYSJKzmmoThljRJ5dqw8Hg0y1GCba5/1Z0VXb2oLfAj/mJwQ7Wei6BflM8yhUY3B4IaFqslsMSZB0D1ilj5qHN+L14H7UWr3BOAFBCZhCgYEwGx4Dw/FkkwCdJG2z9HHIqxFEjeUV7/YCkWYbSfy8xp1HSYgxbMd2N37IfIWZQaz9gEXOyHfZZo96ZaplKdVHca2YDeqsnTwirScv97WR4S94hsNQ2FDU4C+CFgGFOp8p8iU+yGQ3pAa8Ub20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz/sJN43+ETTIrdVv3FplaHKHsH+PkHeushS2uhPksE=;
 b=TyCdjvraRite0zRoQWhYKd3SS4z1BKtxHsmgcTCeAVRjB5qIWlw6/OHLKFdWBPiBijHSWn7JqCDnErrLNCTnfbivzSQDvTktWquk2BNzi3/iJBqlPUrMa+e2m1NjMGh3N1dlm+l2+MrsEHgE+fugkkbKvY7DhWBHq5u5+La1o0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 29 Jul
 2025 19:42:07 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 19:42:07 +0000
Date: Tue, 29 Jul 2025 21:41:57 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 14/48] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Message-ID: <aIkkBdIN3i69OHni@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-15-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-15-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 5639ab43-cd02-4519-5027-08ddced8001d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHVOQVV5SllVRDNlNDNYVUJlMjd6RWJIK2c5SFRKU0NUT2E3K2NwVFVNWnNn?=
 =?utf-8?B?eFY4K2ZSL2s3ay83YWZLZWczN09zRjBJZ0g4NndxaTBjUlQybllmclYxR1oy?=
 =?utf-8?B?SUxZbWJTTkk4NmNaLzZuempQMUZFVFJ4V0dPTzBVSDIxZHQyUlBVT01tY1lS?=
 =?utf-8?B?VjAvVU03MTUzR3lldUhLUnkyL0piSThKajViZWFuNDhZOXVzVXk4WHBwdmE5?=
 =?utf-8?B?UTdKWkpjR3hvYzhhS1cwbDdGb0V4R3BxeUtzNWlhcHAvQVFxVFlPNmx2ajU1?=
 =?utf-8?B?SEdGb2d1cGRpdmZKcElhK3BySUVOclNqOWFsS292N05qV0RqRGx1alQzWXdH?=
 =?utf-8?B?bTRkZWRXUlF6QTQ2d3hmbG5WWGRGUm41Um9OU1JIM0l6RDVmUCtLeW1sSzNY?=
 =?utf-8?B?YmhtQWVqUDZPYVJvN2FaV3BmQm1kMXRXYXh1UGVlOWVBSFNXbEpVSk1TMUpB?=
 =?utf-8?B?TWVzaGJrUEZEam5KdnRxOVp4QUI1a3A0bG9BT1dPWEhtaEx4dnBtaytvVmcy?=
 =?utf-8?B?K0JaVEpjN3pRRExvWHR5SjF4ZTlHQllFOEZWZXJ5YmNkaUdmR04vVHZDU3l3?=
 =?utf-8?B?azJVNkI2RXpJbHdWTkVya1FMZnlrdyszaitPMEdnckRkOHR5SWZGRmxXbHF0?=
 =?utf-8?B?aTNZajRVVWhZaGJ0T2VFeloySUJxMFNDNW5GRGFPejdNeml1U1h6Qi9ORUV6?=
 =?utf-8?B?UW02UDgzclNRUnlhOWs2OGV0V3U5YU42dFpRNUdYYlZMVU1oN3NVNk5ZQmhC?=
 =?utf-8?B?N09RaGd2bmNQOWtkN0RXOHRPR1VXbEp2WHdrVEZoTXE0OFJhQVU0amVpaHYw?=
 =?utf-8?B?WUl6b1BqVDFXUHZTd0JLV3MzY1o4WW13ZytwODdxamdndjk4WE5qdUJQUm1n?=
 =?utf-8?B?NS9HUUU4OEdTK2NpamRxM3ppSkpPSC9BV0I4RVd3TzhrRksyajdncTNIa0NS?=
 =?utf-8?B?cE1GUHYzNERGeUNPajY0Rko1eWhHTFBqVWJNT3F0UTFlRndpK0FLMEcrUmln?=
 =?utf-8?B?OWIvdHJMK2NZK0t6OGdOVmNNbHZGb1drck5vMGFwZ3ZTNHlKVzUrV2d2UHN2?=
 =?utf-8?B?cWM2cW5STHYrV2hCWnpyZ2Fndkd1VWtVaFIzZUpyQlg1eTUxS3hDRDdrL3o5?=
 =?utf-8?B?UGpvbmVyYk1leXI3Z1RlcjRTYm5xZnVzRzhjdjU2Y1M5UVp5SVJjS2RxZXB2?=
 =?utf-8?B?YW55YlkwNnJOeFRrTFVwMTZKTThkNXN2Z3lnTE9CaEh3M1Rub212T3RrOUpD?=
 =?utf-8?B?OE52a2sxc3BDUnVlVXBUUUttUDVzcUxBNzg2dmJObUJTMnN6SmxqY3MzZkhP?=
 =?utf-8?B?NWdYVE02aXlWdXlybk1yeUpPNWhHSGt1bTFEeThtRHBXMUZDcFRaZEpJZEwr?=
 =?utf-8?B?RzhuWVFXMlVvYXhwTHpwNThHaHh4ekU1Y2RmQU40bEJ4WEJWQklBcGZJbVd4?=
 =?utf-8?B?bFJNUjdzb0pCTUhKV1oxQW1WbVBnOWg2VjRWa2RwNlNZSFltMVdpVWE3R3Zq?=
 =?utf-8?B?aUZhbHZTaHpTbTRwSTdZMUFYUGxyWUI5TE5GWGp4M1Z5SjNGQjM2OVlSS1ow?=
 =?utf-8?B?aWk0LzVlN2ZNVWMySkdFbUFFRDdZVXFIanR4eDhzSk5nVGJyKy9udmltcXFC?=
 =?utf-8?B?U2hhdkNFN01CSDFlMkI4d1pEWE5nU3ZDN2tXMk1oWFBGWlJ5N1ZNazU5cnQ5?=
 =?utf-8?B?eFAwSkZKY3I3NVNBR2hQR013aitUemFDdjBOLzQxZlZvTFEzRFJ3WmQxS2Rr?=
 =?utf-8?B?UkpaL0VWYWd2VDZETHVsNEs1WXhLaUtaQzFpcE9GRWhlQkZCUm1GOEdibytQ?=
 =?utf-8?B?OUROZVp2T1VpSXI1TEVUUkJ2NkJBOXNReFFQN1hKTHI5SlVidVh6T3FEaDZa?=
 =?utf-8?B?OGpWdkNHSkFUU0UwcjZZY053UlNVOGZVMGFuVlhTcytZRUlpV2lvZUJZUnFo?=
 =?utf-8?Q?UMejoW5hbe4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFZKQk5YK0dSNUVZQVdUc0liODcvSW5INmtuUXhtZW9JVXVoaUZENjhtRVJJ?=
 =?utf-8?B?aENDeVdmQXB3NmR2S2FOdnNMNlVINkcycjJ2ZU1wWm45SlRMd1AyUDMzSFRk?=
 =?utf-8?B?T0h2UEN1T2tod3loS2dlQTNTd3BaSVJ2ZitnZ0JubmVMcW9USTBWbFlLNEFH?=
 =?utf-8?B?ZHoyTnNWWUM0dzB2eTJ2WXI4cXUxb2NieS9yTjVhQUF5QnEyUnoyWWhHVlpX?=
 =?utf-8?B?cXlJVm5ETkNCMTJXekM3dVFnbE1MWXFJNnQ2YXBUSXp0U3E1UGlGZ3Vickt0?=
 =?utf-8?B?MFNDSytVeGpralhoYVh5NlhiUXd4aFQ4UGxHOG5Yelh4aFdvaGtodXNjLzRO?=
 =?utf-8?B?TWdnZUN5ZHZ5YkJkVHhIV0Rta1JJcGp2UXFZZzVFdnRIcmtPMFFxUmdVWitD?=
 =?utf-8?B?MUcybDIzbmxVSkw4QndBeHhmbFVmUXBKU25wemZlVVNnd2dkWnlXa1ZDdnJG?=
 =?utf-8?B?OHB0bDFjQlphNDNnVnBCQ2RVVnp0eG4xOXE5SEJibTdCYzg1Y3VQUXdKYXls?=
 =?utf-8?B?bUhBSTlZRkRTNkVaN1I0THJRTmhzUzdiVklyaHZqb2xObXhHcndpSHBac1pa?=
 =?utf-8?B?NzVsN09QT1VZaHgzOFloTDUxd2lLYUhIV2MycXdvMy85amp4TmlMcjRrKzB6?=
 =?utf-8?B?Mm80MWJHaVlWMVQxYVZOa25Ca3hKcEVhanNnUjJWMUoxOWxYbmdsV3ZvSUN6?=
 =?utf-8?B?VVhpakpTQ2lyUDZZNDRGSGp3M08zM1dudkxJR3JhK0VjWWw0TmJHNmUxeElO?=
 =?utf-8?B?NUxRQTE0dzVJdmtTTEhtTkZRZnVGS1BCTkU0Tmh0bUoxMTBzbEl4T3BlQnov?=
 =?utf-8?B?Nis0VkZTbi9qYjk1Uk8rd2FIbUVQZlBBNUF3V0owK01heDdUQUZzUlNrRVMy?=
 =?utf-8?B?dzYyYzBGa2FRQ1BBMFl5clRKYkhRckk4U2M2b0tEQW9DQThHdWxreUxMazJn?=
 =?utf-8?B?ZTVTczU2MDFJeGNTZWV3VDVPbmtSYVR0MkdCVWtqdEdlQWs4UTdvc2dZelBk?=
 =?utf-8?B?UzZLcVVrbXZ2MXBPM1Z1VkNFK2JYTVE0ZG9sL1Z6dHJYVWlIWTVRM3NPYnMy?=
 =?utf-8?B?QlErMXdkbjRoYnh0aEV0VnBGRDF3Q28vMjR4SkpKM1FZWTErVUlldkFib3ZU?=
 =?utf-8?B?T3FKb0pQQy9UN0tsRE04WVFwR3FWSy8yekJzREF6czRuUjJFdlpwYk92SEJw?=
 =?utf-8?B?VzlGSmNITUtjdnk3K1Y3WkZTcHlvZmFjTStaTzZ1bkJPVkVqWmV1V1FZTThX?=
 =?utf-8?B?RlNhZTcrWThyVXRwMUlMMlNKbDVIS24yOGlDaWR2bHYxandMcGpyamlVTWty?=
 =?utf-8?B?c016NWlsNWVQb05TNEQ4b1g3TiszSFF4VjB6SkMycDVxenZBamY1SVB0dWM3?=
 =?utf-8?B?UjhUWlFIQU5vUiszWHpva05xNUtlblpWM3BoR1NSaWVpbGhJUVdBbm5mendS?=
 =?utf-8?B?SlZ3R1c4QmFjVDhKek9tRjR3bk03Z2tzYVFsanR4ZGFQS1VTS1NwcmNsQjFW?=
 =?utf-8?B?eFNkd3VxcmIrN0tWQW1lUHZ0a2JkYy9wa0NTQ3BVdVR0QW1iN202cXhkNDdN?=
 =?utf-8?B?Mm1iQlhZK0lTRTViZm5oeHJST3pwckFCSUVPMUlYZ2FMWTVVbnNSYkgyWjdP?=
 =?utf-8?B?SFRpQjE1cS9QSnBQTFZmNEhHSnpKU3BmWkV0K29aanFoT0YzT1RuWGZCTnhs?=
 =?utf-8?B?N0JmOG55VStIZEhDVUcvU080NytQNWRkU3hGZnpyMGxMWVdrUCt3em1IYWJU?=
 =?utf-8?B?QWEzbkdvN2hScStaalVKVkRuZjNYSk12Y2IrWElpNldnZG9pSEJIMzBkUC9w?=
 =?utf-8?B?RTZmM2dyWkgyR2s0Nk9Fb1RJQlZxVFhYQ0ZBT2JyZ0RsRjRrRWM0d2J4NTRR?=
 =?utf-8?B?NEV2V2pyREJidEdjMXF5Y2V5VDB2dzlJWEI4MjJGUlFXVXRvUFVkQVM0Si9X?=
 =?utf-8?B?ME5vUkZmNXdCMkhneEU4MVNLalNTNE5iQ1RMQnZnTUZZUXVrZWcrUnkxQU85?=
 =?utf-8?B?U1RHc3J2UkN4Ykd4QktzZGU3TlkxOWZJUmtjUGRtcThNd05sSngzZzNWVUZh?=
 =?utf-8?B?alVnSnk3c3Q2cEJnRXBDZjlTbWRXN2ttV3puSEgzNUY1UmFZR3FFc2tqR2lv?=
 =?utf-8?Q?/ZQOOk5Ij75/rULF97cOfTgsm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5639ab43-cd02-4519-5027-08ddced8001d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 19:42:07.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcH9zyeQk+rHfR44iUDa2yhzFtgoyIbGTve4ucJ+ptJ39qV8/1NNa0Jo3pQ0i5YWIPx/p8DfJFSLI3cyLBSbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
Received-SPF: permerror client-ip=2a01:111:f403:2406::601;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:56AM +0200, Luc Michel wrote:
> Refactor the PMC IOU SLCR device creation using the VersalMap structure.
> This is the first user of a shared IRQ using an OR gate. The OSPI
> controller is reconnected to the SLCR.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  5 ----
>  hw/arm/xlnx-versal.c         | 48 +++++++++++++++++++++---------------
>  2 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index b7ef255d6fd..78442e6c2c5 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -19,11 +19,10 @@
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/nvram/xlnx-bbram.h"
>  #include "hw/misc/xlnx-versal-crl.h"
> -#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "net/can_emu.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "target/arm/cpu.h"
> @@ -82,14 +81,10 @@ struct Versal {
>          XlnxVersalCRL crl;
>      } lpd;
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
> -        struct {
> -            XlnxVersalPmcIouSlcr slcr;
> -        } iou;
> -
>          XlnxZynqMPRTC rtc;
>          XlnxVersalTRng trng;
>          XlnxBBRam bbram;
>          XlnxVersalCFUAPB cfu_apb;
>          XlnxVersalCFUFDRO cfu_fdro;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 89c93278336..d34a36e18aa 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -33,10 +33,11 @@
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
>  #include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
> +#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -114,10 +115,12 @@ typedef struct VersalMap {
>          uint64_t dac_sz;
>          uint64_t dma_src;
>          uint64_t dma_dst;
>          int irq;
>      } ospi;
> +
> +    VersalSimplePeriphMap pmc_iou_slcr;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -154,10 +157,12 @@ static const VersalMap VERSAL_MAP = {
>          .ctrl = 0xf1010000,
>          .dac = 0xc0000000, .dac_sz = 0x20000000,
>          .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
>          .irq = 124,
>      },
> +
> +    .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -861,25 +866,28 @@ static void versal_create_efuse(Versal *s,
>                                  sysbus_mmio_get_region(SYS_BUS_DEVICE(cache),
>                                                         0));
>      versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(ctrl), 0, map->irq);
>  }
>  
> -static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
> +static DeviceState *versal_create_pmc_iou_slcr(Versal *s,
> +                                               const VersalSimplePeriphMap *map)
>  {
>      SysBusDevice *sbd;
> +    DeviceState *dev;
>  
> -    object_initialize_child(OBJECT(s), "versal-pmc-iou-slcr", &s->pmc.iou.slcr,
> -                            TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
> +    dev = qdev_new(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
> +    object_property_add_child(OBJECT(s), "pmc-iou-slcr", OBJECT(dev));
>  
> -    sbd = SYS_BUS_DEVICE(&s->pmc.iou.slcr);
> -    sysbus_realize(sbd, &error_fatal);
> +    sbd = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
>  
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_PMC_IOU_SLCR,
> +    memory_region_add_subregion(&s->mr_ps, map->addr,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
> -    sysbus_connect_irq(sbd, 0,
> -                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
> +    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
> +
> +    return dev;
>  }
>  
>  static DeviceState *versal_create_ospi(Versal *s,
>                                         const struct VersalOspiMap *map)
>  {
> @@ -1201,10 +1209,11 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
>                    "is not yet implemented\n");
>  }
>  
>  static void versal_unimp(Versal *s)
>  {
> +    DeviceState *slcr;
>      qemu_irq gpio_in;
>  
>      versal_unimp_area(s, "psm", &s->mr_ps,
>                          MM_PSM_START, MM_PSM_END - MM_PSM_START);
>      versal_unimp_area(s, "crf", &s->mr_ps,
> @@ -1223,27 +1232,22 @@ static void versal_unimp(Versal *s)
>      qdev_init_gpio_in_named(DEVICE(s), versal_unimp_qspi_ospi_mux_sel,
>                              "qspi-ospi-mux-sel-dummy", 1);
>      qdev_init_gpio_in_named(DEVICE(s), versal_unimp_irq_parity_imr,
>                              "irq-parity-imr-dummy", 1);
>  
> +    slcr = DEVICE(versal_get_child(s, "pmc-iou-slcr"));
>      gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 0);
> -    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 0,
> -                                gpio_in);
> +    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 0, gpio_in);
>  
>      gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 1);
> -    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 1,
> -                                gpio_in);
> +    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 1, gpio_in);
>  
>      gpio_in = qdev_get_gpio_in_named(DEVICE(s), "qspi-ospi-mux-sel-dummy", 0);
> -    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
> -                                "qspi-ospi-mux-sel", 0,
> -                                gpio_in);
> +    qdev_connect_gpio_out_named(slcr, "qspi-ospi-mux-sel", 0, gpio_in);
>  
>      gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
> -    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
> -                                SYSBUS_DEVICE_GPIO_IRQ, 0,
> -                                gpio_in);
> +    qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
>  }
>  
>  static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>                                   unsigned int freq_hz)
>  {
> @@ -1262,10 +1266,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>  }
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
> +    DeviceState *slcr, *ospi;
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
>      Object *container;
>      const VersalMap *map = versal_get_map(s);
>      size_t i;
>  
> @@ -1312,17 +1317,20 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      for (i = 0; i < map->num_usb; i++) {
>          versal_create_usb(s, &map->usb[i]);
>      }
>  
>      versal_create_efuse(s, &map->efuse);
> -    versal_create_ospi(s, &map->ospi);
> +    ospi = versal_create_ospi(s, &map->ospi);
> +    slcr = versal_create_pmc_iou_slcr(s, &map->pmc_iou_slcr);
>  
> +    qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
> +                                qdev_get_gpio_in_named(ospi,
> +                                                       "ospi-mux-sel", 0));
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_bbram(s, pic);
> -    versal_create_pmc_iou_slcr(s, pic);
>      versal_create_crl(s, pic);
>      versal_create_cfu(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
> -- 
> 2.50.0
> 

