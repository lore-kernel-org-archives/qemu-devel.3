Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C98CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyTHq-0003VY-5G; Tue, 16 Sep 2025 06:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyTHm-0003S6-L0; Tue, 16 Sep 2025 06:51:47 -0400
Received: from mail-norwayeastazon11013016.outbound.protection.outlook.com
 ([40.107.159.16] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyTHi-0004SB-6s; Tue, 16 Sep 2025 06:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYhlYVMlynnYEBML0X0f+Slj+YtpWm/CJWUcnY7bliyY1rQSwqBX2uXLcM+uYWNfnJ5u1mm42x81Uub3Q+M9uzxwBMRQ4RBgL1Gtbzq/tZOwegk8rk7UgzvGOzBFBzWGNT+7yE/4odUJnkSuIP+Yen4zyPd6TJWzZcaOQpswrShoSmmncuPB37xvsq+zmq42E9UKyzhrJp/GXR5PJ+QnYGZ0elXz4wJUidA7NAzT+VZMOHZGMxm9W/WCvgrqhbiBLGtHfPknV0eovCdRIqyUnpmcoMVvwa0jIo+Ol0WswDGAzoGGTsN1IKCBHFGZ/5T136fkRfHwD1LQKo5FJrfOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8acyzxWVEDd5nv3UlMeydb2fHSKXw4BDEEkErVvhDY0=;
 b=L2tqb3fFcQTCqUbsVFAAOo3WoXwdrKaXXgwzC20m5T0SudDPMVYFWWXMErKcfBLdbV3pGoPnA3vhKJGJQT88M3e5sOjSNx1HOEp2wMkJlwLb6S+vvkUuLd/tLTbOuvX/FITsabaOmYdS5mPM+kmP2kLKDu4rbJqplw48aMXE0a4KVjxrtI0kmZFIPlTQjMAXK6Zq6Q1jJtgNkNJjuAzUC8jfvXD+gcGanZL7Z7X/+pgZDiF3zmwWvPn2sCtpeG/UFh/ZXWM0Qr+B37C4chpuR72hRsjXvvLnjmgAAnHz5B6GAeYkcWFIfeY5PfCi4aJ0Sj+ERn/J6U/eRXASs78ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8acyzxWVEDd5nv3UlMeydb2fHSKXw4BDEEkErVvhDY0=;
 b=o9Tdg98MZoki8mOlPXSlg6f2GZRKf11c3YCMmcFCMnyHQgFe94QdjjY4DUXRXfFhozu/ohTlOdVZJd5v77uYtrwyHq7UngRrQVIpY+RenogK3YtXb7mPpoGrnfJMSvarbDuoFX+aw9BGA9Os+Li7yh6XU/tZDbA3L88tpfsMR50zNgKP7SP9XcELOF3MnOQOCzO22W71i0GOe8seAtbL85iUqCPn6jQ9GnLXLsDPjpBFx8Z+SRDFo6q5/D1zGvyu1NMk78gDTT4IM2vF7d6ETby5l2FiKcl1FO+CcXT98PLK09KibZ+Mqsvzo15BP7lwPXsUvIOFtvnUQFzvTAByhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM0PR10MB3492.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 10:46:30 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 10:46:30 +0000
Message-ID: <c594553e-b9b2-40aa-9e76-cefba0c3891e@siemens.com>
Date: Tue, 16 Sep 2025 12:46:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] docs: Add eMMC device model description
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <bf2b2d675264fd41fbe55ad3fb2e528e6d72ad97.1757854006.git.jan.kiszka@siemens.com>
 <e718145e-f39b-4af8-997a-cc4c8972049a@kaod.org>
 <ee929dcc-f83c-489f-8a1c-f74398cbaa57@siemens.com>
 <805d6be9-f511-4393-aedb-3faf2b56daec@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <805d6be9-f511-4393-aedb-3faf2b56daec@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM0PR10MB3492:EE_
X-MS-Office365-Filtering-Correlation-Id: cb090da1-e4e6-49e5-42ed-08ddf50e4bb0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3RVZmttSG81RndJQnpKaS93Y3JySzhBM3hRcktQN2dBQkpUcEQ1azhHVHBN?=
 =?utf-8?B?UDhodFhBT2dKMnNRZy9wWCtJSkxmdUpKcXM0S3NQU0pWOHBWQzJHODlHTHVE?=
 =?utf-8?B?aHhCb0k3ejQrbnhFM0Vyc2wwZSswNWljcnVHVjhKMzkrWU14dXRXa1NMcXdO?=
 =?utf-8?B?UXBIQ1h6MFg0ZHE0cE1sZWh1STdaVHRDM01Rbjhacm1YMFFiQ1RpL2Zoa2Zv?=
 =?utf-8?B?UnhLUEhNcHdJUWNQMk95MitZVUdoZGFzYlBKbUsvV0U2L1RGMDZ2MVkyclVX?=
 =?utf-8?B?SmJ2V3JML2EyOERaWFNSSWpZOEIzZzFRdHBnNG16N0dLUFcxTEJGV3dVWGJJ?=
 =?utf-8?B?ZkRCMkdUTUpzeEQ5QjQrQVowZkNVWW50OWF6NHdYa2JCM0lQazVVOHBqVmZa?=
 =?utf-8?B?cEpoSkQ3clBqVFJiMVcyRURnaXpveG9reE9hRitvUlhYL2tjWW9xcmJsUXlW?=
 =?utf-8?B?Q3NjOThlRWU5TnFOc2pDeitNZ3AzTW5YTFcwMndDcytwT0hZWFZHMlFmZmFH?=
 =?utf-8?B?NkRvTHpaSGJPeHhFRE5LTjQ2cmYvZmhod29KZjhvc2tZVjFBdkFQdW56U2VC?=
 =?utf-8?B?OWFuN2FOWDFqT2FYVDZ5Q01uczBYa2t1dy9OMStpQ2tsMURpUC9tV25ZQUxX?=
 =?utf-8?B?RnpwQmJJeldsNVB1cFAvK2JDbTRxWWF0UXR3NVF1QXNFTk9OaTRTaHcydnQ2?=
 =?utf-8?B?ZjlQaTQyZDNwaU16aThyRjJuY3VSM0JrWlRGdlRSbm5VS3pPNHNxYThXRllK?=
 =?utf-8?B?WkE0cHN6TWRqVEdwNWs4NEJORDlRVjc2STR4dW1LMGVnSFQ5TjdTVmFta0F3?=
 =?utf-8?B?Z0dHR28wdFlRaU1kSlZVdHJ4NWFiTU1jUnJqYUtjU1UyTTZuZ1JxdTJlZU1j?=
 =?utf-8?B?WTA0U3FrcHY3TkhvbGFvQW5hVTZlZjR1RGRCcC9XMVNRSDVmNUtOc0pmalRD?=
 =?utf-8?B?N2tuL3hSNytHYlNLMTlpNXJFSDFwT3ZEemwwUXE5QWNoSDFBRHpMZEVMSU4z?=
 =?utf-8?B?eWc0aWVUeXVFNnhnWm1DMUR0U3RLU2xFK2lzT2VUTjRPeDg5VElQaDYrNWxN?=
 =?utf-8?B?MXU1MVU1WkdDZkhsQnJiZWpaVi84STZLRmxhWmlwRGVuZG50a1g4c3NvK0Z4?=
 =?utf-8?B?cGFBMkpoVVpXMGFnMWYrVEl6ZWxEUXhZQnRVYkp3cmtrTXRLN08wRGNUOStS?=
 =?utf-8?B?YlAxeGtBN01XQnhKNi8zejhETzRMMHlobmNyaFozZHBqVzlWcEFEbk9Zckc0?=
 =?utf-8?B?NGV5VjZjTExqcGZKWC9VME45R1dHQ01ralNxajRvUFlBbWJtSkdMY0VNd2x4?=
 =?utf-8?B?VzhEOGJqYUdOTDJqVVZlL2VuWUtCdEtYUGpXWHByM01MZVo0MEJLUUx2ZTNL?=
 =?utf-8?B?RWtjb2swWmxEV3p1WkNZT09QMjFxTEs5R016T2d2Um1tekZlNXpIaTMvNUdB?=
 =?utf-8?B?dVJaZVhBSWpNYXhKN0NOZ0daeWxMbWsrNVVTRWlEZFdoTHFWKzhaNFVGdEcv?=
 =?utf-8?B?Y1BaMlkyZnJSdWdybTA2blkzV0M5bUpQaHNTQjlxTkFhUGNSNTZHVkI2N0x5?=
 =?utf-8?B?NXVxYXN6WU9aK0VMcmd2c3piUTlKVkN0Qzk5OVpxS003YitQNDFMWlZqb0JR?=
 =?utf-8?B?QzB0OFBWU202Um1vdHY2NklnMWJUYTBvM1Q4UHIyU0tBdlF1WVpHZlhmbW55?=
 =?utf-8?B?QXIwNm9jWWhRZ0dMMkFCOFBNenZ5MUIvMmtTbmNTcFkzdjlPN2ZBQVZDQ1d0?=
 =?utf-8?B?UkRHck9Vekt5elY4Ymd3WDNkeXFlRDVsYmZQSEFmaHhnQTIvdXoyTVN0RW1N?=
 =?utf-8?Q?rFgH/D97WJ13XneDzhqS49MqCRF380sA0j2Yc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBKQ29qdk1UU3NoaTZGUlM5dXhOc2xRakpIMDVIVFhBOHZ4Wnlva01nckor?=
 =?utf-8?B?YVlkWjdqN05FSmQ2ZXpHaXp2VGZLWFlsVU0vSWtDVnhsYXBaaHVQWkk1ZWZn?=
 =?utf-8?B?K2h0OFJmc1hWbE9GUGg0bUEyOXpjYy9QVmtFbEVVeC90Z0Zva2g4cU1yMVVh?=
 =?utf-8?B?WmpzMnlBai9Zcm15QWR6ZS9vU2FBUXorVnU4TC9PSlFkdkVrYjR5bW1DckM3?=
 =?utf-8?B?OTl5YkJ5REFBZ201OGpvN0lNWDhLTzFTOVlFSzJqQVZ2TFY4YUxZMVpMMXlF?=
 =?utf-8?B?UkMvcTZGTmxIaVRjM1AyVmxNOVJnUjQ1UXROZmJZdmZrTVI0YXpPK0NoWTJE?=
 =?utf-8?B?WTNRNkN1d1ZXNlkrU3VaNmZyK0RHZVRsOVVTSURXcjhBRlZaODl1akNvYUtF?=
 =?utf-8?B?eC9NS0RKN2FRbWxlTEEyVWdhUElxdnNQMkhCOWRuc051SCtXakdieDlRU1FY?=
 =?utf-8?B?MUo3bWdmaWpKa3hUU2pIekJqK01GY3dBT0crRnNCV1VNSnV2STUvM2MzZEl3?=
 =?utf-8?B?RWlWdkt5T3g2ckNWN2JQdW9Wb2VkV0ZhVTVheEczc2lJd2owVzVxTlZ2R0U2?=
 =?utf-8?B?dnFZMEViSDFWK1dKajVrbncxaXFsSDVFSmJXVm0vanhUV3JWQndCM0hsRWlj?=
 =?utf-8?B?a2hESzVKTkw3aFhJU2ZmaDU3V3dCTjI2cUdIMWorV2VBcVlzMWdlSjZxdjZU?=
 =?utf-8?B?Uzh6cFB2elg1ZnZhVm9rRUM1NS9wQ1BGZHVMQXROaHBtaHI1VWZTT0Mwd2hK?=
 =?utf-8?B?dHUza1RUbzB3WE1IS29PbDdkamxOQkRvdjRTQitNYzg2VjkxKzg4RkpMa2pa?=
 =?utf-8?B?VlFJdlgvQ256RmtSaGkxRnZ4dUhPNDZrR0hFdUQvN3daVGFlRjhwb2N3L2lQ?=
 =?utf-8?B?ZHE2WldZU2xpM0I2clg1YlVKMG5TTnltUCs4UTk1QTFXdVZhdHBweXo4TWhM?=
 =?utf-8?B?RGIza056YnFqdStRQmtib0V2dmpJdUo4RXpmU0FJZHZydmgxbysrYk9MdHBy?=
 =?utf-8?B?MVJwU3A1TTJuNjkxV3k2S2JSejZIaSsvbGhrVE1UcGIzbmt3SklMNmgyL1Bk?=
 =?utf-8?B?V2FqV2JDVEhPb2trS1Rjd1dGRkgwUllYaTB3S08ydUtsNlVaTFZMd0RCUUdh?=
 =?utf-8?B?Nzk2T2xjcUppcmdCM04yRVBRdnI3OTVCUFFqcWNUWjljSGw4OFFYOXpSSHEv?=
 =?utf-8?B?RFcxRlRhSjdCdGo2dTlTODhBNUkxMFlPQXdoRzVMbGVwaVh2MGNhZ3VrVEtU?=
 =?utf-8?B?cVllTE43Z1BqWndIUEZkYWFrc3hMZnkxZTZRc203RGZpREZGV3cwWEF2bmhn?=
 =?utf-8?B?RU1CTTlOb3JEcElxNnl5SGc2Z0Y0Y1VlQ2tscXYvRGt6Tit0M3RMUFJ0cVcv?=
 =?utf-8?B?d2dVVnpyT3pRMDl1NXpRT0UzSFFCZmRlMlh1ZUU1N0hMV3VsaHREYWFVajY3?=
 =?utf-8?B?UlNRUHNBcDl4YkRCSzZhTEhNUVNMMGM0OVJjY01LenNHSFF6S1JrQjJWWitS?=
 =?utf-8?B?RnNjbkFtVFlhTGpNSzc5bUVQbHFNQ3laMU1nTzJNVFdFeUdyaDRxY1dpMnps?=
 =?utf-8?B?WTh1cGxoQ1ZFT2hEMzNpQXR5YWdUQW5DNmZnelZsUHA5UzExc3pJRDAzY2d1?=
 =?utf-8?B?Zjk4b2hTdWxLdlpTS3NsQVo5OTRGNmZMNWNYV0RxT1NYbk42OHRyQlVla01P?=
 =?utf-8?B?enplbUpwRnZmdVViV3VOa1BPbXF3NUNWdExtdndBVENxOG5JTnd0NTFhUW9n?=
 =?utf-8?B?RFlPbFlOKzFsVVk1cHJVK3gvd2tvYlhaTjlnUy9RQnlYTzNLOUhsSU1uZlR5?=
 =?utf-8?B?M2RoWTQ0LzBmM2pWWDVwMmczNjQ1M2c4OW1kd29vblRXL1o4T09Pbk1VRlNa?=
 =?utf-8?B?S21RRGpIb1ZVZkt1MkQ2cjlta3djdEswKzRRcm9iR2FJQXRKdk5uNE5NeGFH?=
 =?utf-8?B?cnJWOWV5MysxUUthMkRtUFdGSGJGdkh1ZHc0TTRneXRPNUgwaHlpMDRjWW1m?=
 =?utf-8?B?MEZXc2h3dnBIeVludlQya0toaGVGSjVNSW41Tmw1dktvd3lkT05UV1FsUS9t?=
 =?utf-8?B?aFpoQTdsZ3FxUU9ORVY0QXE5Nmk5M251ako4SFA3SXNxMGFZclprZkJERkdl?=
 =?utf-8?B?TnNEc0xGdkpZMGZZbk1FR1htUHdSSTF4eFQyTmRmMFFqeFp3Q0xMZUFhYVo1?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb090da1-e4e6-49e5-42ed-08ddf50e4bb0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:46:30.7117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KXfk3rNPtNPPWf0j2nIfR5Zu2vSu1nf2Si/TXFTeZPVIJDJ3GJeB+NTVCO6tfRIaGHnLXCmOgV//z5Z2YZtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3492
Received-SPF: pass client-ip=40.107.159.16;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 16.09.25 09:10, Cédric Le Goater wrote:
> On 9/16/25 08:02, Jan Kiszka wrote:
>> On 15.09.25 19:37, Cédric Le Goater wrote:
>>> On 9/14/25 14:46, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>    docs/system/device-emulation.rst |  1 +
>>>>    docs/system/devices/emmc.rst     | 52 +++++++++++++++++++++++++++
>>>> +++++
>>>>    2 files changed, 53 insertions(+)
>>>>    create mode 100644 docs/system/devices/emmc.rst
>>>>
>>>> diff --git a/docs/system/device-emulation.rst b/docs/system/device-
>>>> emulation.rst
>>>> index 911381643f..36429b1d17 100644
>>>> --- a/docs/system/device-emulation.rst
>>>> +++ b/docs/system/device-emulation.rst
>>>> @@ -101,3 +101,4 @@ Emulated Devices
>>>>       devices/canokey.rst
>>>>       devices/usb-u2f.rst
>>>>       devices/igb.rst
>>>> +   devices/emmc.rst
>>>> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/
>>>> emmc.rst
>>>> new file mode 100644
>>>> index 0000000000..dbea6d6c7e
>>>> --- /dev/null
>>>> +++ b/docs/system/devices/emmc.rst
>>>> @@ -0,0 +1,52 @@
>>>> +==============
>>>> +eMMC Emulation
>>>> +==============
>>>> +
>>>> +Besides SD card emulation, QEMU also offers an eMMC model as found on
>>>> many
>>>> +embedded boards. An eMMC, just like an SD card, is connected to the
>>>> machine
>>>> +via an SDHCI controller.
>>>> +
>>>> +Create eMMC Images
>>>> +==================
>>>> +
>>>> +A recent eMMC consists of 4 partitions: 2 boot partitions, 1 Replay
>>>> protected
>>>> +Memory Block (RPMB), and the user data area. QEMU expects backing
>>>> images for
>>>> +the eMMC to contain those partitions concatenated in exactly that
>>>> order.
>>>> +However, the boot partitions as well as the RPMB might be absent if
>>>> their sizes
>>>> +are configured to zero.
>>>> +
>>>> +The eMMC specification defines alignment constraints for the
>>>> partitions. The
>>>> +two boot partitions must be of the same size. Furthermore, boot and
>>>> RPMB
>>>> +partitions must be multiples of 128 KB with a maximum of 32640 KB for
>>>> each
>>>> +boot partition and 16384K for the RPMB partition.
>>>> +
>>>> +The alignment constrain of the user data area depends on its size. Up
>>>> to 2
>>>> +GByte, the size must be a power of 2. From 2 GByte onward, the size
>>>> has to be
>>>> +multiples of 512 byte.
>>>> +
>>>> +QEMU is enforcing those alignment rules before instantiating the
>>>> device.
>>>> +Therefore, the provided image has to strictly follow them as well.
>>>> The helper
>>>> +script `scripts/mkemmc.sh` can be used to create compliant images,
>>>> with or
>>>
>>> the single backquote would interpret scripts/mkemmc.sh as a ref. I think
>>> you want ``scripts/mkemmc.sh``
>>>
>>>> +without pre-filled partitions. E.g., to create an eMMC image from a
>>>> firmware
>>>> +image and an OS image with an empty 2 MByte RPMB, use the following
>>>> command:
>>>> +
>>>> +.. code-block:: console
>>>> +
>>>> +    scripts/mkemmc.sh -b firmware.img -r /dev/zero:2MB os.img emmc.img
>>>> +
>>>> +This will take care of rounding up the partition sizes to the next
>>>> valid value
>>>> +and will leave the RPMB and the second boot partition empty (zeroed).
>>>> +
>>>> +Adding eMMC Devices
>>>> +===================
>>>> +
>>>> +An eMMC is either automatically created by a machine model (e.g.
>>>> Aspeed boards)
>>>> +or can be user-created when using a PCI-attached SDHCI controller. To
>>>> +instantiate the eMMC image from the example above while assuming that
>>>> the
>>>> +firmware needs a boot partitions of 1 MB, use the following options:
>>>> +
>>>> +.. code-block:: console
>>>> +
>>>> +    -drive file=emmc.img,if=none,format=raw,id=emmc-img
>>>> +    -device sdhci-pci
>>>> +    -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-
>>>> partition-size=2097152
>>>
>>> I will see if I can adjust the existing aspeed test with your proposal.
>>>
>>
>> Thanks in advance! Yeah, the existing alignment rules were incorrect
>> once you turned on boot partitions. So there is unfortunately no way
>> around fixing images that followed them.
> 
> Ideally we should generate the rainier emmc image with your script
> from the OpenBMC artifacts [1]. The current image is not broken by
> this series, so, we have time.
> 
> 
> However, regarding this command line :
> 
>     -drive file=emmc.img,if=none,format=raw,id=emmc-img
>     -device sdhci-pci
>     -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-
> size=2097152
> 
> a few assumptions are made.
> 
> Machines can have multiple sdhci controllers with several slots. In
> the, case above, the emmc device is "blindly" attached to slot 0 on
> a bus named "sd-bus".

If the machine has an sdhci controller already, the sdhci-pci device is
not needed. I can try to make the description clearer, and maybe you can
tell me what would be needed for the rainier boards, then we can have
both examples there.

> 
> Removing all QEMU internal references to "sd-bus" will require some work.
> 

Sure, this should rather document the current situation.

Jan

> 
> Philippe,
> 
> Should we allow automatic bus numbering  :
> 
> -    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s),
> "sd-bus");
> +    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s),
> NULL);
> 
> and replace all :
> 
> -        BusState *bus = qdev_get_child_bus(DEVICE(sdhci), "sd-bus");
> +        BusState *bus = BUS(&sdhci->sdbus);
> 
> 
> Thanks,
> 
> C.
> 
> 
> [1] https://jenkins.openbmc.org/job/ci-openbmc/
> distro=ubuntu,label=docker-builder,target=p10bmc/32112/artifact/openbmc/
> build/tmp/deploy/images/p10bmc/
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

