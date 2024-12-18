Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D18BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuVN-0000yn-Uc; Wed, 18 Dec 2024 08:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tNqFv-0001Bd-3x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:22:11 -0500
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tNqFs-0004IS-Gh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:22:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHzwprReN9Wum8wRpDn8nf+0GVRTePBRJn0IBbi6Qs5SS1NMJgN0qslgTSJx6FvVPkocrt9UN6HTXFdeI/VH6eegHyKUk+9Bs0d8Sg1w21z7+0mjtpGaSTZE8K3fSXa1oD850VvxtonjXk/YmxC0Ecm9jIZnghjkkMmg0ntxKXfJ8hiCN6DomAm8lXpYBN0lPjSvLJ6QawhR7OfVDJWVo6rcZ+hjMcjS8N7HGZpTtDE1OXPusBBs1DpLq7bfgJ+8FQ0DDf2ooRIq7sfklBo1wX9RVWyu7A4ibX+QbYTcrmgjUVGPuXZx/gM6SD44Wjp75pO2NFPjyI6KUDxi8mFwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On/P+I3f3H9TwgstfTzW5nyswZNeZIhkxkrherOcTJY=;
 b=NQgwFGxS9TbzAI7bPuDnIkpswFGlur/xuyD5TNit/dBm1GtaBRP70gUmG9pHppvuVIrfmwcNph4UW2YyzLpn1SY/E0OEM1qlVg0PAgJctmVgx2u36xauWhyVLtrfZ7HvsjNyarfF1UuT7Fz/VB0LhiqDizIBzGgGhRkBYcD3zpDx74/XdKP/NL05KcZ6dQyO9EiD/qGsJL43hRmaC7D/GB8/SMKaKyCyOzoXtfwGo9RjlyQx12iwh3UhX+6XZ1mr+fPP3BLOEgsc1SWVuSVZ9eC2ykUXJFGk1ni7e/Xi0KgYdmtE0yl09i9Zv9IRPmWS2gu5mK3tTWPF8jlOgWdf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On/P+I3f3H9TwgstfTzW5nyswZNeZIhkxkrherOcTJY=;
 b=dw6hVaCQtUlG6RXtEYEivLZvBYcPL7Bla1RX36kgndNu2fPhd9FmOICdHsXGRNJeFUBfn8HsigQj7xDlCs7ZCCzCk2q0OwHLCRqSxV7npqjVYfTNxSqIRWYcmUiGF+tz3+0mdclFdsgkqWi/RFWv20Tiyg2xvziSjPSPkRZ1wGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 09:16:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 09:16:59 +0000
Message-ID: <5a917008-95d4-4adb-99fb-37e626c38fbc@amd.com>
Date: Wed, 18 Dec 2024 14:46:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2] hw/i386/amd_iommu: Simplify non-KVM checks on
 XTSup feature
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Santosh Shukla <santosh.shukla@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Daniel Hoffman <dhoff749@gmail.com>
References: <20241129155802.35534-1-philmd@linaro.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241129155802.35534-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d583ca-09b1-49e6-1f7b-08dd1f44b99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R05YL2VLelFudXVKYVZsVnRNbURTRW01eTIyR1VTVFY5ejFJT0hSR3I1L0pF?=
 =?utf-8?B?cGVtVTFWWFZMVlRnNnZlZDdQRzJFVldaQWhqMTh6V3ZzSmo1aFZyOTJsdlZw?=
 =?utf-8?B?UTNMWGI4YmpCR3Q4YWhUaG5KaDZqd01JU2tOT1lLWXU5NkVtYUhEUjlqQ21L?=
 =?utf-8?B?S1pKcVh5NDkzaXBCb01mOFJOb1VFMGwrNGl2UFpxaG9laVF3cUVUMENsUVMv?=
 =?utf-8?B?S05hVEErdE5YMHp2NUhUc2k5MjgxdTFraGdwTE4vc2xyY2ZqNGwrMWgyKzFG?=
 =?utf-8?B?Ulg1Y1UwQVBpTTlKM0lsYS84WHFmL1hNZENFeVppR2Rpc0NVWnl0MEo1V2E5?=
 =?utf-8?B?Y2FXTnRLZDZWcm5ZZWh6c0tOWkJZM2l5elNBZ0hvNHR5V3Y3SGZSWkFpc3Fx?=
 =?utf-8?B?UTAvL1NqYTF1cEgxUkNiNUR3c2FVYnVpcVZKLzdZOGx2TmVDSW16dzhJZ3dL?=
 =?utf-8?B?UThJT1pIZk5vdTZZRUxrVTB4cXpjQlVKb0IwWTFsM09Na2ppbWV1Ri83VVlx?=
 =?utf-8?B?NnB1WnlaVStEWmJWMFh5aXJvakxIMjBuOXJtZ0psN0tjQlpKNm5Vc1Zvb1cw?=
 =?utf-8?B?RWFYTHJ4V0lTTW40K3dtVVJtbGN0cmQ3YWVSV01LVm5pVG9RSVRmODduTXhq?=
 =?utf-8?B?aGp5dkhhSkVhSHJRdUtMWWttUm5rT3Z0SlJjVjNWdSt5TzBTWXJGc2YrNmxh?=
 =?utf-8?B?NzYxVFdubWZKcXpSdXBBOHYwbmFJL0lWaWZIeHlHRDlkV1NpcWdua3NtUVpx?=
 =?utf-8?B?UGZPdDM2TFViV2RTNTZBY0tISW81clpLRFZzaEMySElqcTlYOVhNOXpjcmpQ?=
 =?utf-8?B?SXdvSHpKcUpJR3o1ODdZRHFaQWZtbXp1NmJjbHdTSjFFTEE0TkdLYXF5NHlv?=
 =?utf-8?B?SlFEQzFtV1ZIaUNnTVMycGxHTVNMNldNVHBnWExOcFhkS2I2ZUlWdWd2Y1dB?=
 =?utf-8?B?eEd5VFMyd0lTTTNocE5UUE9KRzRGNVZnZmthNWZVTzVyR1loTkhRSGpzNGJR?=
 =?utf-8?B?bHExMFVwdStiZHR2eXVDUGdhckg1eGhmTmsyKzA2ZDJsaWJFNXlYVG1scW1X?=
 =?utf-8?B?SExIb1JtbXNYbUptYStFOWY4aGd3bkVrbzh0cm1RYVBrZnhodXh1NVZoMVhW?=
 =?utf-8?B?ck1RT3JCVWtkb0dlMTE0di9mK2V6a2lpL0E5cWdlSjZVeDA3L3VzN011dUZJ?=
 =?utf-8?B?dzdUaHJRSnRhb1NvL2ozRWNUUmR0MUwyU2NPc0cxM2V5bm5CM2NlQVIvZExI?=
 =?utf-8?B?SEY0Wm5LZmE0aEtibXpmakNFVWJTcUhEQTE0YitrMXhTT3BQc3Boak1XU3Vw?=
 =?utf-8?B?YTNiV0xMN3lYTjRtcHBFVDBWY2JtN2cvbS9OR2xrbnBKU05JQVFlVlNoeVFW?=
 =?utf-8?B?ajJVVGNmVFlPdVJzVy9OTXdIL1VWeGJvZGFZS0lRMTE0VlBrVlh4MG00Wk1P?=
 =?utf-8?B?c2c1YWFIcFBxc1JOdGFISHFGWndYemN4aFdrYlFzcGxFdnJEVjJHdm1ITjdD?=
 =?utf-8?B?N3NLeFd5dEZqTnNST05Fd3JHaFpjZS9yQW1QdGpNT1N1c2JFZ3VyT2I0UXBn?=
 =?utf-8?B?cW9YMWlDUGVMZHJvUmNVdy9qekwyR2FkczI0bVFuYVBVbDdJbXgyZ0dqU1k4?=
 =?utf-8?B?QmxOZ1VXTFhpMnNOUlpSQ2x1VmJtbVVWMjUrU3hNVGVvaGFnWitRd1ZuODE0?=
 =?utf-8?B?WXhmQ3JkWUF2L2M3KzRSY25NanVkSExLVUc1ekdOOVJacVNCaHlGRGs1VWc0?=
 =?utf-8?B?MmE5dENLYmhZWHZybjNLTXExbEttT1AxUEVwdmpLcDdhZnBTRlI3ZTN2MlhP?=
 =?utf-8?B?K29RR3hYT2Y2WjlOM09DS0hFVW5nRGx2YmQ0Ym5wb25SMnpxcjFCOVFDV1VP?=
 =?utf-8?Q?v42cDGYrMRKwQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJXdTJDd3VtSzkyUHpYcngrQ2h6TE85elhtekVqakQwalgza000L2d0aWVW?=
 =?utf-8?B?Z0Y2K2s2ZndKWGRCaDNLTzNHZ2llOGN4cjJ4NXJtOXhBaTRQVFM1MEgrWHRQ?=
 =?utf-8?B?MlpPRmlkNkFlcXNocEQ5QlZkQWh6OWQ0THlYaWFoMmVodHJPUy9WNVM4UDg1?=
 =?utf-8?B?ZWZ2NncwTWJOSDVVR2xGdEc2a09tQzdPMkpHamErMCtnN1pETnM4c3pXaVVB?=
 =?utf-8?B?Q1luM29BU0FCclpMZURxT2RkcjZxWDVCQ1FKUXEweTdudWlaWXQrQlk1eWt6?=
 =?utf-8?B?d1RHa1VGRGdZODE0UElSelJLUzJvV2NhL2MxMUlka3lIUzN0WW9nb2daWFkw?=
 =?utf-8?B?SjdxNGNhbE5lamdLcVZJaExUYXp4QWhKVEZuWHNsaXlFNDE2WnpQT0p1SE96?=
 =?utf-8?B?bm5pQ3FTUWxWc05iK3dBUW9OY0YrOW9hNlZYalZJQ2F6OHpmaDRKL3JURDhq?=
 =?utf-8?B?cHVFL3hNelZyRitPRlpFZ3laL1FkNks0dTdtb3ZFM09TYU1YVTJNN25oVzdt?=
 =?utf-8?B?Q0MrWHJqVU5mZitUbW1ueEZjeHdkM0dxU3doVDdpZ3h0QnJvUUdBYlV6eWcz?=
 =?utf-8?B?eDJXbytrMFEycVVhWldUUzMwb3hCcFdib2hORDNWc0pEcTEwd1BtckZvcXBI?=
 =?utf-8?B?WVBsL1A2UXdycnZ4TWxmNUl6Q2w1dkY0RUlsWXIyY2xIbXdnZ2NCWGNYWGd0?=
 =?utf-8?B?OS9PZ1dtUVN3Z2JRNzdwVWxyQ0l2QUNmU0J2TThYYXdCRmFKQ3MwZEcrb2Ex?=
 =?utf-8?B?QWhZNEhldjIwV29hOThHTDJFTjhKaVpDanhGbG5obE14TjlaSFUyYmtOdEJM?=
 =?utf-8?B?VWhsZnZBNmk0ZklkRU5INjdNQTFNUDVDS3pYYnJ3WGljeWZlZng2V1k5Vm9s?=
 =?utf-8?B?OXlmZTBXNDFIeFN2YkkzK3BPejRKc2tQTWJzSGJPZUpoUUJ3WURLTmZyY09n?=
 =?utf-8?B?ZjJJckNZYXRmdnYyODNsT01HRmIzT01CNXgwNUpsbzBpR3JKYlNHRXZqNU5J?=
 =?utf-8?B?NW5qbWxMbGJRYlJxMTBNTmdZVnQ0ajhwS0VBYUlUdGZmaDBvSlBRT0ptanlC?=
 =?utf-8?B?QjgvcytSZEtRZklEbG5QbEdFNTlVUENOdnNOREFDWlAvd3RXeHRRanFLWkhM?=
 =?utf-8?B?a29JeittclBYU3pXZ0RuaGNJNmF3THRuZnkvQmlGQlZlblU4d1ZqZytFUktk?=
 =?utf-8?B?UEIzdXZlN1VyU3N5NzdOOUZtS1F5WEhSRG1mUTZxazdYTFVCN2M1Ui9FMGhY?=
 =?utf-8?B?OWZpaWYzenRyZ1VtT25WWGVhYzM4UkFJZGxpMjAyZUlqcnYxQjQ2TmNvZzdh?=
 =?utf-8?B?R25QOTlFK2RqTEgvTmdSTWxkMVB6NVRQd3FaZHhLU1pvYnhQMlJOVnBUWG5G?=
 =?utf-8?B?TFhBaFNjUjY0S21wNXM4ZkhJR0ZRem1SRmR0dm4zVFpjYjFDbkw4UGsxejB5?=
 =?utf-8?B?VGJCOHFRWmxScDhhcUFyU2ZiVHJUSUxpdEhxYmdnTFVXT2NNenhzakE2VHdW?=
 =?utf-8?B?SlZkLzZheCtQQjkrTjYvVTNFTGhTcFhoaU13alp5amcwajhwZ1lRZCtWM0Rt?=
 =?utf-8?B?bTVTRjVKdjVib1BmYVdUWXNuMWU4NXcxelpRRFZ6YnRoYkhHclFuOFc3c1Rt?=
 =?utf-8?B?TEJVOGVkc1FGT0NPeUhFR2pvQit5OUpRTmwxUmMrN0dmM2dGWDJFKzNDbiti?=
 =?utf-8?B?WnRYd1Z2OGE3WmpMQkN3aG9VQmpZdEp4V1hwYTd6dDArUmhIZStacmZ3SXpZ?=
 =?utf-8?B?U29aWExBNGJnaDB6NThFWjBnR0JZYUNuZU1EZGx4Z3pQcE5iVkl3bHltby93?=
 =?utf-8?B?MWY3aCtHeDZ4bjFHb09DNjRoNkJHcEtDOUV6RTYrdG9pc0E3ZGNDcytTanlL?=
 =?utf-8?B?bnAxdStiR1BDYzdabGQzcUhoRkgxSG5rVG9hOWNzd1J6d2g3Y3dLUDl3bDlx?=
 =?utf-8?B?MnVSamxTWmxLTUhwUHlTUXBPMkFFZkFtUHA2eHd1cVRpMGgySnR0UFE4UStV?=
 =?utf-8?B?MUFwY0FlSngzNkxUUmlYaDNKZkV4bFRqbUllNG1RZ2JFVjFEVTcwVDFOOVpy?=
 =?utf-8?B?WnVOenh6UVhBUjVsVkgzdUtMNzJZcmxmclFGM3hibTRWNDI5TjUvODJna050?=
 =?utf-8?Q?OUDnasdAevYB5liP7kCRQifsj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d583ca-09b1-49e6-1f7b-08dd1f44b99a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 09:16:59.1935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pYS45B+Tdf37HhxIltEDvGBS4dQjJpyQ0URu20mzTL44HpuqDWTT4aX290j8IPZTNuW9YryI81Z13XugRW1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704
Received-SPF: permerror client-ip=40.107.93.85;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Dec 2024 08:54:23 -0500
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



On 11/29/2024 9:28 PM, Philippe Mathieu-Daudé wrote:
> Generic code wanting to access KVM specific methods should
> do so being protected by the 'kvm_enabled()' helper.
> 
> Doing so avoid link failures when optimization is disabled
> (using --enable-debug), see for example commits c04cfb4596a
> ("hw/i386: fix short-circuit logic with non-optimizing builds")
> and 0266aef8cd6 ("amd_iommu: Fix kvm_enable_x2apic link error
> with clang in non-KVM builds").
> 
> XTSup feature depends on KVM, so protect the whole block
> checking the XTSup feature with a check on whether KVM is
> enabled.
> 
> Since x86_cpus_init() already checks APIC ID > 255 imply
> kernel support for irqchip and X2APIC, remove the confuse
> and unlikely reachable "AMD IOMMU xtsup=on requires support
> on the KVM side" message.
> 
> Fix a type in "configuration" in error message.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for the fix. Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



