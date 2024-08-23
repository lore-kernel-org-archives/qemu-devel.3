Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6FAC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 16:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shX6c-0002wB-Pj; Fri, 23 Aug 2024 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX6X-0002br-6V; Fri, 23 Aug 2024 12:25:37 -0400
Received: from mail-mw2nam10on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61c]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX6T-0006FW-SG; Fri, 23 Aug 2024 12:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0IMbAR+7/0qS505IPmQj40cogjsSns3BX71Llu4haLVTz4yJtreSzV9NDAerxuaSQs9B1cJXbTSPJNsb2ks2MZCAM4LpAcXZq6/DE7xS42Y61gbRiBmybrvFhSKViQ/RGPhs5cnDyMJuKJ1ZFJtKwoJW84qeRuuZyNWaD+rRI9ZuuwH1yLq21ewCQUqtwKRugNSiEdvTmPNNYEWiFD2AhJH4rNKM0/mKvYVbj/u9e3PW4suZKXpyOLfS26UBOySyaiVpU0z28E6TuAYUVFLyiEY9NP+1H3J/vTz30YescRMWUIZ/8dWIgi8u7bU8AyecrpSEBfcEV+7ZDqy0NTDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7uZBmqYJwhkrHQramnYjcXYfQYU/WQB9d7Fos51KSg=;
 b=DzfTRkUimQC9lFR7skKk7uPOrnhzowZZKBSxO2oPlMpgq5/yBOwDv1zPUFIMco5rH25mAcdsqOdFfRic1Gc90Il0GjWAP2azY28ilcMiNLtFB57gvb+gC+8RSqAZ1MzkXY+QmmlP8CtTTKmccbB0n3cr4D6ewOTKS7xQPlbzT+9FOJfS4eWNz7YVvqJFjQEbaLOdVJpvOUREfcJXVRiAA2hLhAILlqIKszC7MY/l/FgIq9+rkyKS2dK82VtNIx2Wr4IhboX3zsC9XTarqjgWHYKWm7SZyyIYfpvCuaPQnEIyXRiHsJgUmoNUYCOr5ago2V0EgX5Rhe761xu7PGlj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7uZBmqYJwhkrHQramnYjcXYfQYU/WQB9d7Fos51KSg=;
 b=E1vOBoe6vxSJndRe+1dgP27dhUcu/sXv1+s/2Lf+NsEwVVcHK/v2SZ3+ZcN1eJqQhRnniLKrXBCWl53l44pyn9JNC6vLvQPBQo7VT3GAYAwvAMWCygDSzkRtx4YEvtHP2emnsC3fS7Akk3eGBBMrbgeJri86DrjbMjgykJpzk0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 16:25:24 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:25:23 +0000
Date: Fri, 23 Aug 2024 18:25:16 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH for-9.2 6/6] hm/nvram/xlnx-versal-efuse-ctrl: Call
 register_finalize_block
Message-ID: <Zsi37HIW1DMy9l3C@xse-figlesia-l2.amd.com>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822162127.705879-7-peter.maydell@linaro.org>
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: cf83bd28-94fd-4aba-d9ad-08dcc390300e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjRGVUs2UVRYRlYzSHRCOW5OaEljeW9SY3QxWXF0NVNxN1MzYVlmQmNRc240?=
 =?utf-8?B?V0NHOGY5Q0ZFN0hxK1FMdHd4WHlLZHYxSzVydFBHbHBHUWcxbnNNOUV4REVE?=
 =?utf-8?B?VEJTbTZPZlBwcnZxWXk1UjlFS3B3dEluTVZQUlFSMC9EWFZlZzFON3lrcjYv?=
 =?utf-8?B?RnFNR201K0t3TUUyUEo0cGROc21nWCtndWtmTCtZbDBmSDhUalhOWlFRSFE5?=
 =?utf-8?B?TXVPczVzRzM3WWxLbEV3eDRKRkNNNWd0NEZ6TTloNElERmM3VXJFdC9ybkUv?=
 =?utf-8?B?Z1VJdXhzZXRlSjdPTEx2aFJPKzc0MEFuN1ZKVlNhWEtzaFE1eE1rMmVxZy8r?=
 =?utf-8?B?ZHBKZTl1U0t0OG4yb0REVTZXdGtYUHp5d3d3b29EcGxPTVkraUFCdGZ0WXo1?=
 =?utf-8?B?MW5MM3dROVpGREJBTk0vSU0xUVpYcVJGYU52RjFaVlJHa0o5VFRrUFBsT1M3?=
 =?utf-8?B?YU1kWU13MldVU083d1hJSjg2ODdlaUFGeGRjMVJUT3lrYkJMeTdjQlBMTEZk?=
 =?utf-8?B?bE5JaG8zdm1qeE9wZ3hsWVFEWWpCdW9Fbm1TLzM1bnRndGhkNFZ0eDExSmFm?=
 =?utf-8?B?WncxK3NhalZQQzdwdURBTFBrNFB1SW43UlA3Y3J6VzY3YnpINm5pVTBwV09k?=
 =?utf-8?B?SnZ1YUZESVl1ZHA3M3pmZWo5M0dhZWtSczdUbVVKNGZPb09iQUpRM2ZUWita?=
 =?utf-8?B?V2dZVEhqdEs2VmliTjFuM29BM05sNGErYTNDZ0Jka0FnWXhpWFA4MmVaMmNW?=
 =?utf-8?B?RnhaTWYrNkdRdE1PU3ZleVVQQVQ2blIrNFllRlZwbjh0Z2hOQndMeE5MdUFl?=
 =?utf-8?B?NGNrMEgzbHBMUXZEbzNFMFdyaDc3ajRSNzdGRzIxSnZzKzZDcmQ4S01pNTN3?=
 =?utf-8?B?cUxIQlJCUVBtQzBUUjBvenEwb1FkUFY4U3ZKdkRmUlhKQnNRMFhVdzlVZG1Y?=
 =?utf-8?B?YnZrbjloMWxoRmxWS1BuMEdaNi9PNGRNdWVRSzI5bDdjaHFFVWlBV25SZzQr?=
 =?utf-8?B?OVpmWTBBY1N0Q0pXV2JVZS9waU1wS3pVUldoejQ2UGdkSjBpTyttcjF4dk52?=
 =?utf-8?B?RkFHT2ViR1FkM29QRXZSZzlkUHpVUElLd3JQM2VIdndrcTY0cjQ4RkE5aXhH?=
 =?utf-8?B?eFpLQ2Y4eDUrelhHMVkwdlp6ODhsWjFFZVphRFVIaVFOMGd5bU9pZ2FPWHdw?=
 =?utf-8?B?OEJDVmFJai9EMGZEait5WTMvUEZ0QUNQbTVWelVKVG83VEcvUUp2TUhyeStq?=
 =?utf-8?B?QngveldBbThJUjM0NWsyRkRXQjlqN1pBL0IvWmIyeitNaG1KZDN0bElsSnRC?=
 =?utf-8?B?NU5kUEdWZHU5YkhwcDc2TzFkRkh5cmlDaHpwYnBidXpiODVOQTIvRmNuaWNo?=
 =?utf-8?B?cmV4UGJDN2FxamM4UTI5aGJFMmptU1lSVWRiSzZid0dzRGpMZ2dKYnoyVlRs?=
 =?utf-8?B?RWlqS29NUGJJZ0tENWt3NEJYbEFjQXprRE9pR2l0aGYrWWJXdmlKZjB4TVkr?=
 =?utf-8?B?OXN6NFNMY0dxUG1qRDl3VFVOWGRwL2NTR3V2NzNISFFDZXl2c1N3NWxlUnNy?=
 =?utf-8?B?NWQ1WkV2eE0rai9GVm9xWlBJbHplbWVKTGJrb00rUjU5bTVDeEkrK1d6b0dY?=
 =?utf-8?B?aG1JdXBQazRBcjBJa0R3d25OSUNhd09iK20xU2J5OUtsK2VBZExhMDJFcS9U?=
 =?utf-8?B?TjBzbjEvOUQvalFPZjdpQTFDYTVVeG9XTFBPa3QwRnZuVDdsOGRDWW1kcE82?=
 =?utf-8?B?U2o1RGNYSklMd1pON3BDK0U0MEdndFBkZWR6RU5VRTkxeFRvc0t1OG5DU3lH?=
 =?utf-8?B?c1hxUHNxT0p5Smh6S3hydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2U2WXNSTU1QYUlmekE1STg5anBYbERPQW8yQUxRcnd6NEhqN1ErVEZrTDA0?=
 =?utf-8?B?ZFc0YVVzSGhOOTFzSEp1R3RFYW0xZ2VwOHpoLzcyMnZaQ1ZpOWxsTVllVGhv?=
 =?utf-8?B?ZUxIajZlTHJ5SjB2SUgxbUE1dktvWGxrQ2todU4rL3h6RUV6RElQcDZRWUdj?=
 =?utf-8?B?L0hHTWgyMTNaWFM5UmplRnZYenRGV0dHWHMzdFo1OHc5cEtnM0xidmZja3Uz?=
 =?utf-8?B?ZHFzTGhSWkljQzMvTGF2S28xd3ZtckUvUmlNOHpTVStFT1FqV0NvcFFDTGdx?=
 =?utf-8?B?Q21IRkpxVUkwYkpEcjdySVc4R0VIYm55SldzMzZFdFUxNks1cFMxb3kxdU1s?=
 =?utf-8?B?UVppNG4yNEYwNXBWWlptTEs5cFNZaWpMVDhsTFgvWUpkQUF6SHY4TWZYUzVu?=
 =?utf-8?B?czc1cjBqOGMrK2psbVJENVh5Uy9ONk42MHhUc3I3aENyRThuQmhEVEdzSzNr?=
 =?utf-8?B?bi84dTB3eDdlV3oxQkJPTEpxRENEczdiTndGWGNlK3lBUzl0eWxFbDZ3YkRZ?=
 =?utf-8?B?UnN0ZHFBSGsySnFEeGtKRDFvSWtQUnpFM1d2cndLZXlZcmdVbXBmcFA4anZZ?=
 =?utf-8?B?VWRpTU4rUzZYUTUvNXVISVkrK1hVbmRac3RhZk9ZQlNyYjRWV0VoU1FHU1lM?=
 =?utf-8?B?YndSUXkvRG4wa09FaG9nNVpnTnN4WnI1VHArV0dSV3QwaXlIZDZldkh6TWVX?=
 =?utf-8?B?VkN3Ulc1cUk5U00yajhyNFJhMGsvdVJmWjdxQThsVVpia0YvWld6Uk9WOUFq?=
 =?utf-8?B?aEZwVDJqNjlnVklEUGQ1UFhKWnBsUmR0cWp3VjZkMGROdjFFYmp1UFdYSG5P?=
 =?utf-8?B?eHRHbUUwNmNORG80a2IyRnMyUkRNQ1FYYXBKYkYwOGtBSTh1RFkzOE1pTFlD?=
 =?utf-8?B?WFdadTJncmI5Y0dsLzhHZTNWc0pWL3QrRTREamxJMjdPVi92ZVlmSHhBSmR5?=
 =?utf-8?B?Z2JKUU1BMDdVeGhDTXgrbXh5SVE2bS9aUHFTNzE4a2UxM0ZUakZwNmtYMHJO?=
 =?utf-8?B?Y0hDZzBpdTJuVDRNVFV4azJIcWppVFpITXBHOHl1bm54cUg3MGVGeDVOM3Nk?=
 =?utf-8?B?eTdja2VoZ0U5NXM4dVFCbHRJWE1SZkp4QVJsWTV3a1U0MEhrVENlT09ZSUVV?=
 =?utf-8?B?SnFBMnlHd3ZhZ3ZxaUJFWE1JY0p3eURzUGxRMzVkb0FUMmpiYk41SmN3dDVS?=
 =?utf-8?B?aDFSVWpTTHZJSndYT0FSd1lZMUJqZWZYWktEZ3VsOFFpNTJxQmI2dkJJb1Rq?=
 =?utf-8?B?QVd5alpJRHFabTcyOGlVNjlpbzZET2RHZGtqd2w3Y0hENGpoY0FBdUd4Z05H?=
 =?utf-8?B?OGhyZDJrdkNjUlBqZFd5VWZCSElSMUZiTm8yRnFjWkFUemlXMHlreDNjb2d1?=
 =?utf-8?B?L2RvaEJFMjlqMS82bkJQaGs1WVpDSkhBaU1RZmZ0aS9KUm13YzhuRG5QVlJN?=
 =?utf-8?B?UHVuamR5VFBHRnMvVzZEVGtNS0RQdDBnaVdVMWN4Nm1FcHJpZVdDbWNTOU1G?=
 =?utf-8?B?NHhiNFMrUjRJTElHbGhSNSt6N3V1WGQzYXhDdlJkb2o5SU1qQXVRMG1CV1F0?=
 =?utf-8?B?N08yVjMzdDF4VVFJelVmNjdmcWdVbGVKNzllc3N1cGdSMTlyckp4S3FhUUFn?=
 =?utf-8?B?Ky9uZ2RCSGorTmZSSzZZUlVBdUd3V0ZEbG9KK0t5S3NYVUdWZEVZTEwvdEtq?=
 =?utf-8?B?MmtZdkZUbDlSMVJvYnBobURJakpsdmtIeUVtVkptZzFJWTI1RHBtVTYrYkEv?=
 =?utf-8?B?ZWVTdXJnV2pDdTgzL3Nlc1NQS3FTT1VtWFlUSWozMFRRT083Yit0SEtPU0ZZ?=
 =?utf-8?B?UThmaHcvNjdkUEI4UjJrYVowQmVEVTcxaXUyaXJYMnoxODNWVE9RSVFrVjhX?=
 =?utf-8?B?S3JKdkRUbW91RU1HY0pqZldLZ2JmMXNHWU5GejhJZVVTWmU5WDNVOFNYeXlX?=
 =?utf-8?B?QlprTnk4SmtVaURUWnJXeFdDVFlLUzVvdkhQMmc2dUJvSnV3blMzaEJpTkJS?=
 =?utf-8?B?UWhDd095RG1MZzdQamxFYnZJVnF5R1VYVnNDUG1jN3Rpc2tPTW9aL21KWWFH?=
 =?utf-8?B?MldkNFhwU0E1d2NnTE9aSmxHbFl2ODJLZk9HM0RJQUo2dHd4aFVhQWlldUtn?=
 =?utf-8?Q?kj8861v10jmCSzKrL5v2VlqT0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf83bd28-94fd-4aba-d9ad-08dcc390300e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:25:23.0926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0z/by3QfYspsajIq1HwkPnUoLMPK1OdTTklFtX7WAEI+Htm/i728T5erTJfh3sk8cj/t96pzaZ/DsbUA6252w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
Received-SPF: permerror client-ip=2a01:111:f403:2412::61c;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Aug 22, 2024 at 05:21:27PM +0100, Peter Maydell wrote:
> The TYPE_XLNX_VERSAL_EFUSE_CTRL device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
> 
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55f222b5b9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 420
> 43d49e1139e3f3071b1f22fac1e3e7249c9a6)
>     #1 0x7fbb10669c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x55f222f90c5d in register_init_block hw/core/register.c:248:34
>     #3 0x55f222f916be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55f223bbdd15 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.c:718:9
>     #5 0x55f225b23391 in object_init_with_type qom/object.c:420:9
>     #6 0x55f225b0a66b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55f225b0bf0d in object_new_with_type qom/object.c:782:5
>     #8 0x55f225b0bfe1 in object_new qom/object.c:797:12
>     #9 0x55f226309e0d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/nvram/xlnx-versal-efuse.h | 1 +
>  hw/nvram/xlnx-versal-efuse-ctrl.c    | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
> index 86e2261b9a3..afa4f4f9960 100644
> --- a/include/hw/nvram/xlnx-versal-efuse.h
> +++ b/include/hw/nvram/xlnx-versal-efuse.h
> @@ -44,6 +44,7 @@ struct XlnxVersalEFuseCtrl {
>      void *extra_pg0_lock_spec;      /* Opaque property */
>      uint32_t extra_pg0_lock_n16;
>  
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
>      RegisterInfo regs_info[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
>  };
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
> index def6fe3302b..8252a5cabe0 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -712,9 +712,8 @@ static void efuse_ctrl_init(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>  
> -    reg_array =
> +    s->reg_array =
>          register_init_block32(DEVICE(obj), efuse_ctrl_regs_info,
>                                ARRAY_SIZE(efuse_ctrl_regs_info),
>                                s->regs_info, s->regs,
> @@ -722,7 +721,7 @@ static void efuse_ctrl_init(Object *obj)
>                                XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG,
>                                R_MAX * 4);
>  
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_efuse_imr);
>  }
>  
> @@ -730,6 +729,7 @@ static void efuse_ctrl_finalize(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
>  
> +    register_finalize_block(s->reg_array);
>      g_free(s->extra_pg0_lock_spec);
>  }
>  
> -- 
> 2.34.1
> 

