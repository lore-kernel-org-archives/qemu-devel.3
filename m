Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055A0CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVdT-0002Xu-O7; Tue, 02 Sep 2025 14:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utVdM-0002Vz-V0; Tue, 02 Sep 2025 14:21:36 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1utVdJ-0008Jy-57; Tue, 02 Sep 2025 14:21:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ9DdRyik7J72KtuKp3aHbu9Yifd8u2Wfp8GtHArr3fKpgc0+4Wa8XdYk3TdoRCD7xVmX1Vt9AwEXakrLrEMzN2utJRRH4r09sKXc3JY/m9JCSvI3jbXdEq/rLjbcE1ZgsmiAfYqSUJyxadqeLCL8EHuK/Qj49Gk0n4mOgef2HwN7JFyEOEgjidGfgzsXgTKmtIsI4iHWs6T/JuvJbT09/QO0RQqGqIz5ryMYJc0edKJ72UYUFQtv95aEuVB7mVYR+R+ByCoEVXnVZtEnUVeQN9RClklM486k7QXCYORU4g5xYYVEuoXMchfNji0Ehw/8eU+wpCVqKkpccJS7hRPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFrK+U6yF0tfCvKN2lCpO3ocOlp0Ok7Ew3t3iIwBdoE=;
 b=bQ1qiXr8WO0cJ1eSCCqvMPDMBAdxRjJrPNqp91qynV+RsTEtrrHoC2Nc1+q8yFc8KybAt4OIw0RJ2AZJ47DwcwXx+gdho3uk27iroK2gUdfNKmD+myZYZOJXgRM5CFxFTQdmPdBvIHWVsFdyae3O+tg1H+29fYEspy0+zer+2c5hpOdb4T+V0qTdU9nMRzyGN9VEtsdhy2HP2DNl7H6Y4F13zxWtQVzuOl/DjZatz1+4psYTEWothFOOyuOzCXHFKxGc3ViOzmlBuddNqRWyBvbx5sy7MtqUKQk370gRBRnoNzY1Lx+jBNArVL1n+yDozDGkjakO8zeiGsdVkBSqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFrK+U6yF0tfCvKN2lCpO3ocOlp0Ok7Ew3t3iIwBdoE=;
 b=S+pEzfOR39OBhK7Ct2R/QbXDC/fOnuJ6NCvrA/ToFx5tG0V2eechLFRgCyEtfFVAeY7NtAYUtxhmNq5lYuY7ziPGY0Rq21Q97U4QZs/SjqT4V+qcjlWbEYGtLxJozRX/qpfBlqunYyKDmG+Ip0DvNZFh24j7ZkAjuuayQU4GG6G/9IAa2Jcvtbtq7OGAaw21wTo5yOKUKnKPG7MWAPmDp42310pTB2Qa9pXA4s2ggQwpNPtmNIRLHMtaxbUfLCryuShJJoBX+MiDPp3wACcv4/8uMHOQjLPs7Z4/KN1mS7esNTdpRIgFBSwIxxMKBjSNlVvVcj7fqGn2NoKg4SnFbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB3358.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:136::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 18:21:22 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 18:21:22 +0000
Message-ID: <8d063b06-7cc6-4069-bd17-73985d60b507@siemens.com>
Date: Tue, 2 Sep 2025 20:21:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Fix size check for backing block image,
 part II
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Jan_L=C3=BCbbe?=
 <jlu@pengutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
References: <9f7fc688-7676-49ff-8f86-fac347f70f05@siemens.com>
 <b672f2c8-8298-45ba-8989-fc830914e61b@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b672f2c8-8298-45ba-8989-fc830914e61b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB3358:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a7c1fd-a6aa-4703-dc07-08ddea4d852b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTk3SnJSUmlHWHRPY0lCdzlPUTFXUmxWL1JKcnJwUHlrcXZuZWVPWlIwdkpL?=
 =?utf-8?B?MVBzYUZONnM5cFVLVWl1YTZzbzVIWE5SYWpWWTE0ZVJjcGJTdDBHTnloQ255?=
 =?utf-8?B?Z2oyYVVZcWRXZ1ZURGh6a2hqZ01jYmxTTUs2eW9sQWJYV3Z0MVNOUkUzYUhh?=
 =?utf-8?B?WWxMZmZWOVk0MTlnOU1MVGw3UW1rdEc1OFFGZnFsSXVZRkkvTWQrQVZUSXAw?=
 =?utf-8?B?T2U3anRYQmlNOVk3elE3RkcycVRFVmxoaUIyelAxaGhSOENKT05aaTEyNjJG?=
 =?utf-8?B?UWlQa0tHdmZLN3FYMnh5aVdwcnVSTnYwaStvaGhZNEhOcXFNanRYSnI1T0Zm?=
 =?utf-8?B?dTYxMEtla1ZBRkFpQ3Vjdzh3S1FmMk00UFQyaHh0M1FqeHFuR1lRQVVTN2po?=
 =?utf-8?B?V21abWZ2azVEK1hvUENaNXFOVDlMSkcvQSt5RWhtcmJTcGZycFlmK0NtM1Fj?=
 =?utf-8?B?Z2E5a3htcmNxVjlNdWI1ZmFySElPaUV2cDNyUHc1S2xsQk5VUVZCS1hrWVJh?=
 =?utf-8?B?ci9xSkRyOUhnbWhBOS9NUkxCTGMvWlBUck5ZQmdwdkRPRnF6RUZsakxta0NU?=
 =?utf-8?B?US9SbWI1bFlMWk45U0RndmluWDBKVzZneFd1WVJXUmNRaXI4cS92UG0zRUhj?=
 =?utf-8?B?RkpzMHNWZDdpN1FpNStHZFAyS0RodFJzNThYZnhRSHpBc2Ztdk8wejloSnpN?=
 =?utf-8?B?UU1yVWN1WFNEUTQ3SWkvZGdtWVFFMDM1b0hpL2krQUZtemNTTi80b25HRlY1?=
 =?utf-8?B?OHdkM1o5QUxSTHJnektuaGZpK2xBT0ErV2dZZUdzeWZOK1dOUUR6anNoSjkr?=
 =?utf-8?B?YndlWXRPektpZURIeWtTY01SWENGNk9ZNW5KTHZrR1o4d2F3M2djdW5MbTdU?=
 =?utf-8?B?QURvK0JHRTMvWHgwdEpaZ0xFRndaSnpKRWZFQmxkWUZJVTNWdEg3TnpPeUU2?=
 =?utf-8?B?Z2pEMTN6VHZRcEFtZXBBYXdtbU5tZWlHNExnUEs4a0FqenpEeWs0TGlTL1li?=
 =?utf-8?B?WHd4aDY0U09PM203RVA3aFY2ZFBrcWNaUWRXY0JKMHN5OEkwcnJyNjZlMVVl?=
 =?utf-8?B?dHdEZUFudkdkanE0M2VhOHkwWUlzU1dFVHFWUkpRVlhtdjRqYWdUOWpSemlu?=
 =?utf-8?B?THBJVFJLYWRnSlVaOWNVMzdFUXpVb3dVRE1Ia2o5a1pHMWxRNjNxbTEyMUNk?=
 =?utf-8?B?aGxsbGFXYThTVUV0MVY2UVBmQjR3SXpOeEhHbzcyOEgrS1pzeThCQ0Q4TXkv?=
 =?utf-8?B?bmxkVmdRbDdNVmNyY216WEU0L2dwTUtiUmEzU1dHN09iUlBUMGtsM3ZTV0pR?=
 =?utf-8?B?UnBxdklhQ2VtNjZpQU5rZG14SHNLbUwwaTM3MDZaWGp6bWFqaUx0Sk9XYTQ3?=
 =?utf-8?B?dkNwYkNsbllMOWRZWEJvZGNQeVJRZVhYUEVBOG5lbGc4V0tjVHM0cVZIbDVC?=
 =?utf-8?B?U2s1SFVSQlk4YXNqTjAxemY4N1VPRjMwcnloVXZIWmM1QU5VRjcxRVFBMVB4?=
 =?utf-8?B?djNTT1VpN3RMbVRYMG9ST2ZQRnBqVnl5RndBZTAxS04yTFBxdGpDWlBrYVov?=
 =?utf-8?B?MEZReVZCYU5Ybmg2SkpDMG9xSjRpa1U2OGlVT2FYYTV5azg2Zk15dWc5cEJI?=
 =?utf-8?B?Q0VIR05RYVlyNVprUHlXbnIvNUd1TUpVYTJ0c3Y5elRFVXN2MzhlK0ErUkZL?=
 =?utf-8?B?MDR0YStSbmNpTVBja0NubkJjczRsN0pTeDF0eW51Wk9KWkk2T1czckxQMUtV?=
 =?utf-8?B?RWltcEtnY0paRDVveGpaeGk0N3lFM09UWHYxSFJZdWpzUFk1cjN4Y0dVRHI5?=
 =?utf-8?Q?LqyzUDU+urh+h+xuYNb6VvKnnDUCwU947pREI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE93VTAxK3M1NDRKSWc1WDEwNW5CNDJWODlhZkRvQk8yaVhyZnZmaTFBUWp1?=
 =?utf-8?B?MVk5SU01WXEyRjNmdVBPN1JVeDl5WEdyejNVWWtqdytDREViN2FSd3Z6Yzly?=
 =?utf-8?B?UWtvZVc0SE1pK2hJT0ovZExZdmhoWXJRSE5PTHVXSDZMelh3c0Y2VTNIc0dT?=
 =?utf-8?B?RTFxQjRYbmVUOTZlTStOVnk0Qmhvc29iajlZYkQ0Y2QrQ0ZYUE5KbnQ0NGFF?=
 =?utf-8?B?eHpDQ0dYK0daclB3WWpqY0lvQVgvdUtWdm55RHhhRGRFdHJEdnRlaGtuckd3?=
 =?utf-8?B?RmczVWNOMTNFL2h4Zjd3OU9DZklVY0VUM3dLaEFOK3hDb2hOc1piTktZUjhC?=
 =?utf-8?B?WEx1VWxnM0xzUTE2T084cnovK1lrNFVZbHZnaVV4TG9TQjUzaG95R2J1a2VT?=
 =?utf-8?B?cy9xRjNYUmIwandzTHVJdy9XM1NDbHE0WGVGZmt5WHdaYk43UjkzM2dFZ1pC?=
 =?utf-8?B?blRNcEVVazFsSVBGb21uYkZSTDBsd3lIRmNXWjQzeVIvY3ZsV05TbEJIMnJB?=
 =?utf-8?B?ZHF6Yk9LWjB5bmt2Mll5SjVtZUswUXdrL3BOMW83aDFQNUs0Tmczck9MeFhT?=
 =?utf-8?B?a0QzNFlNejlZZ2l4ZUhaYTdWRXdiOHZwOHB5b2hsaFhOZFc4RHk3TXBXdFhZ?=
 =?utf-8?B?VU1sWmRVWkR4WVM4SWs4bnNTeFVMalRWKy94ZEgvQndjQ2d2L1FWWG5USFor?=
 =?utf-8?B?RVVHUlViNktJOHg0K25HajN1T3N4emp6aS9yM2ZuTXdzQ3B1N254MWlsN0pW?=
 =?utf-8?B?dm96d3ZzU1RCNXZKMnVDRlVIUitTWTlSaDZqdWlDRkYxa2hKVjFSUURZNG9T?=
 =?utf-8?B?WUZWTFVSOFZZcWNYdGtoTFIvNnhxamVsemZtd0Fxclhhb1hWN0JkQTRDbjRZ?=
 =?utf-8?B?T1ErVHlpQTdRaFRyOHh6K211ZTRlci8wYzl0Vm1hZ2VGSmhhMjhoVDdXbjhm?=
 =?utf-8?B?ZUUvNEFmK2NDQ1JSSkpLWTNOREJCb25GR1hGTDVnUkhnREliV1BlRGtlSmdp?=
 =?utf-8?B?YndKZWxPakN0d2hjWDZNcW1XWW9RYksvUldHVU9aU2ZqT052ZnlzT3FlbmxZ?=
 =?utf-8?B?ZDdhbEFKbFU2WUdQL1hma0pTUTl3VlBqYWtOWkhkUEs5YjE2SC9YQWtqQnBq?=
 =?utf-8?B?cGVoMkJMYVZaQnUwckluaU5MZHVsZnZEV0JtNTFjVGpNTmpiM3JiOVlGU1px?=
 =?utf-8?B?ZjJGRWVsMmJmWlh2MEZmOXIxbnZlOGJ5QytyS3c5dTVMNnpRTkRMdW9FbGlt?=
 =?utf-8?B?Smk5N0xRZGxnQitOSzJ5VWZUbFBKQzMxUEl2MDMwMGRlNVprOHBBUmRJVEho?=
 =?utf-8?B?cWw2MjZRL1VsM1hNR25qUWRTT0dtalBHOG5lM0FGSnBLbURmWFdlSFBxZnhC?=
 =?utf-8?B?dnlTdVF4L1FNNER2cGI2UUVLcGlkNUFRKzMxS0tNYjlkRmFGY0xGQ1JhWktl?=
 =?utf-8?B?ZWk5VkJxM1pqZVM0aUlleUJhN3pRYTFFQ2sxZnhWcUFDQ213NEtrdmNPVlZl?=
 =?utf-8?B?WEJUbFBJRFRiUDdveURNL0JCVHVuc0llSS9ERE9Wc2YwZ1QxNlMrZ2RKSHhq?=
 =?utf-8?B?ak5NZzVZUWdiUmxNUXRtMU15MEl5TlQwUFo2TkNrR2pqTGJJNXNYWjczWjhn?=
 =?utf-8?B?K3JTaXBjdVZ5TjBORkVEMWNqTXFNbVdQQ3hzVTNWOVlRVWZVVzYrelA0K1N2?=
 =?utf-8?B?d0wyaElTODVUY2plVlpMK3plc05kd25CekFiSHJRQXZpWXo2dWRoSTRuQlpl?=
 =?utf-8?B?YVVWTFFtcTZJZDVPQjlOZXJQeFdzcllqL2VUTGRaUzJKSTUweGNUczlsZmhL?=
 =?utf-8?B?ZEZLS2hnSFNYdGRYRFhqS1hPalNjOEZ4QUc1TElNSVUzZE1lUEw3ZkVLdWJO?=
 =?utf-8?B?MmxMb0ZkekxjeVJPMVRUYndLclNLcGtTdWQzb1ZXODU2YlRxMzFwVEtYSWxr?=
 =?utf-8?B?OHgwZUw1UDdwdmZEVWViRlJBc2FnL3kydzhzd2E1QUtYOWRqUFAwR2x2bTZJ?=
 =?utf-8?B?UFBxQ1ByUjRJU1F2NnV4Rk1MaHJpN0YrdHJMMjd4dEJUSHUwV0ltWE1ESEt6?=
 =?utf-8?B?NFYrRlJLNEZsaWtKbzhHOHN4VWM2Tys2aFBKUUlPbi84V1VnajZLL2ZncnY3?=
 =?utf-8?B?WTlYbzF6c1hlc1hXUUd0Z3JBUjI4UVI3aFRSM05Ua0hxUnpuVHl3VUlIVEo3?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a7c1fd-a6aa-4703-dc07-08ddea4d852b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 18:21:22.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drDgX8g2m0MZoQiORSj/kc+mcL5I1KZHxdZCEirUz93M10w0966UW06YWe8i9PG9PV+kKGuvWN9uisfNIbkvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3358
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 02.09.25 20:09, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 2/9/25 19:47, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There was another mistake in the size check which 8c81d38ea5ae now
>> revealed: alignment rules depend on the size of the image. Up to and
>> include 2GB, the power-of-2 rule applies. For larger images, multiples
>> of 512 sectors must be used. Fix the check accordingly.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Not fully tested yet, but as staging is broken right now, I wanted to
>> provide this already for early feedback.
>>
>>   hw/sd/sd.c | 48 ++++++++++++++++++++++++++++++------------------
>>   1 file changed, 30 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 2d34781fe4..0f33784bd0 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2759,6 +2759,26 @@ static void sd_instance_finalize(Object *obj)
>>       timer_free(sd->ocr_power_timer);
>>   }
>>   +static void blk_size_error(int64_t blk_size, int64_t blk_size_aligned,
>> +                           const char *rule, Error **errp)
>> +{
>> +    char *blk_size_str;
>> +
>> +    blk_size_str = size_to_str(blk_size);
>> +    error_setg(errp, "Invalid SD card size: %s", blk_size_str);
>> +    g_free(blk_size_str);
>> +
>> +    blk_size_str = size_to_str(blk_size_aligned);
>> +    error_append_hint(errp,
>> +                      "SD card size has to be %s, e.g. %s.\n"
>> +                      "You can resize disk images with"
>> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
>> +                      "(note that this will lose data if you make the"
>> +                      " image smaller than it currently is).\n",
>> +                      rule, blk_size_str);
>> +    g_free(blk_size_str);
>> +}
>> +
>>   static void sd_realize(DeviceState *dev, Error **errp)
>>   {
>>       SDState *sd = SDMMC_COMMON(dev);
>> @@ -2782,24 +2802,16 @@ static void sd_realize(DeviceState *dev, Error
>> **errp)
>>           }
>>             blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>> -            int64_t blk_size_aligned = pow2ceil(blk_size);
>> -            char *blk_size_str;
>> -
>> -            blk_size_str = size_to_str(blk_size);
>> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
>> -            g_free(blk_size_str);
>> -
>> -            blk_size_str = size_to_str(blk_size_aligned);
>> -            error_append_hint(errp,
>> -                              "SD card size has to be a power of 2,
>> e.g. %s.\n"
>> -                              "You can resize disk images with"
>> -                              " 'qemu-img resize <imagefile> <new-
>> size>'\n"
>> -                              "(note that this will lose data if you
>> make the"
>> -                              " image smaller than it currently is).\n",
>> -                              blk_size_str);
> 
> First, no rush, your previous patch didn't make it to master
> (CI failing) ;)
> 
> Again, this painful restriction is due to CVE-2020-13253. Per
> merge commit 3a9163af4e3:
> 
>     Fix CVE-2020-13253
> 
>     By using invalidated address, guest can do out-of-bounds accesses.
>     These patches fix the issue by only allowing SD card image sizes
>     power of 2, and not switching to SEND_DATA state when the address
>     is invalid (out of range).
> 
>     This issue was found using QEMU fuzzing mode (using
>     --enable-fuzzing, see docs/devel/fuzzing.txt) and reported by
>     Alexander Bulekov.
> 
>     Reproducer:
>       https://bugs.launchpad.net/qemu/+bug/1880822/comments/1
> 
> 
> Reproducer being:
> 
> ---
> #!/bin/sh
> 
> cat << EOF > inp
> outl 0xcf8 0x80001810
> outl 0xcfc 0xe1068000
> outl 0xcf8 0x80001814
> outl 0xcf8 0x80001804
> outw 0xcfc 0x7
> outl 0xcf8 0x8000fa20
> write 0xe106802c 0x1 0x6d
> write 0xe106800f 0x1 0xf7
> write 0xe106800a 0x6 0x9b4b9b5a9b69
> write 0xe1068028 0x3 0x6d6d6d
> write 0xe106800f 0x1 0x02
> write 0xe1068005 0xb 0x055cfbffffff000000ff03
> write 0xe106800c 0x1d
> 0x050bc6c6c6c6c6c6c6c6762e4c5e0bc603040000000000e10200110000
> write 0xe1068003 0xd 0x2b6de02c3a6de02c496de02c58
> EOF
> 
> ../bin/qemu-system-x86_64 -qtest stdio -enable-kvm -monitor none \
>      -serial none -M pc-q35-5.0 -device sdhci-pci,sd-spec-version=3 \
>      -device sd-card,drive=mydrive -nographic \
>      -drive if=sd,index=0,file=null-co://,format=raw,id=mydrive < inp
> ---
> 
> I guess remembering we fixed this one then another path was fuzzed,
> so we audited and realized restricting to ^2 was the safest option.
> 
> I'm not against unrestricting the model, but I don't want we raise new
> CVEs. Users adapted truncating their images to pow2 and accepted the
> downside.

Problem is that this was completely wrong once boot partition support
was added. I agree that we must not expose more disk than there is
backing for (which was to my current understanding the background of the
CVE), but we need to use the correct rules for that.

But we probably also need to check if the backing disk minus boot and
rpmb partitions is not smaller than 0...

Jan

> 
> I'll run some tests, but it might take some time.
> 
> Thanks for working on this fix so quickly,
> 
> Phil.
> 
>> -            g_free(blk_size_str);
>> -
>> +        if (blk_size > 0 && blk_size <= SDSC_MAX_CAPACITY &&
>> +            !is_power_of_2(blk_size)) {
>> +            blk_size_error(blk_size, pow2ceil(blk_size), "a power of
>> 2", errp);
>> +            return;
>> +        } else if (blk_size > SDSC_MAX_CAPACITY &&
>> +            blk_size % (1 << HWBLOCK_SHIFT) != 0) {
>> +            int64_t blk_size_aligned =
>> +                ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
>> +            blk_size_error(blk_size, blk_size_aligned, "multiples of
>> 512",
>> +                           errp);
>>               return;
>>           }
>>   
-- 
Siemens AG, Foundational Technologies
Linux Expert Center

