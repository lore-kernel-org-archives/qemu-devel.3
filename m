Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A0CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZJj-0002KV-8d; Tue, 16 Sep 2025 13:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyZJh-0002K7-Qn; Tue, 16 Sep 2025 13:18:09 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1uyZJf-0002qg-68; Tue, 16 Sep 2025 13:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaUoGEXS9Kgktq5wIIR2RSvy4tbjHq1KgDsTdK71q4CP4lTWsP8EhrbbxmAlIZm53P4CnKkkmzNC2a6QY6iWANcyQqZeSkcTHVakj5S6wHeN40pDDIMWHMOhEOlCjEEQgucHeRv1KWBygjdr7Qt2wfG4RzopMgjugcpbsXAUZsZ4o0FxFFF34MF+uuqzyjIJrRWfMZmloQ0Ti/rzifgmo4PH7pBXOnNYmyDMcQQ6n9frOQeNl5+7fky3aXblWsjHK7L+X89fFdE2fByXjsjfbZ/wPBG+eUTSxsiu9JceupntQyUcDgF3+udKBCczxXn5HS7R39mwkNiiY2AeB2DSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyBPzv/JSlgQMThFNp2m9L46A3lGBYbf3pQ29w/pJwA=;
 b=Kw76sSK/Az/PadWwu6ceThkyZWELI9vO2gzkOPZ3Nf50zEVXJZb5/E+PO2OxzH4acUJtv729ZnuDT3kNMhnXq6SsdojZCKHU60zrkUjc2dC6oP/Ec55Y1/x2X51JefIpKa4YFjeQ9lKJlQNbgAuiHXnkLs+scTUG/PTnLhZJKkpLGvnwbxeTUnJnNuEz+rDlc0MmPplcT8tfvWwOJE9O/fYT7aph0QhVBPcWJunXezWIp7X5FMZZQoY5BalXXixHU3rZ4aJoM9m2dxdrmIPpC39Pq6aWO8YmxNmOCE7k5JgXTe4n9V2nxfrgI/OpBg+WWxO1a97A+2ETn3wgVCuneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyBPzv/JSlgQMThFNp2m9L46A3lGBYbf3pQ29w/pJwA=;
 b=qLW03c63zs2zsrJ9sqrsAUBbOFxPz+rFynStnv0Jue/9Fks0FA0KMDJpcaIw/r48o2iljir+m4LGwKdRmz5NF2onMmLngkluqzDXtdPjcCDN/cWplmQnXd6OZ+Nm+nUOv+ZcatP8fKgjGNugRsS0wJC/0pXgMQ4pbhjh4JqFl9Jr1KuP54NFEUxFFMX3I9xPGXtKQ7ECIZxBdH8ZoQBNFgib0k5P2g1DgSBPidoe4Laool7ni8tlj3A+QnQObyC+jkgMFGHY0MdoY9894uhOrw97roaAlJtsSePV4qCZnaITNIJNV9aXxgOjwisRkPKU5voeoUmkbCVinqHPzTx/uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 17:18:02 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 17:18:02 +0000
Message-ID: <b09cd869-39e7-4a62-b452-4ea39ccf4df0@siemens.com>
Date: Tue, 16 Sep 2025 19:17:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov
 <alxndr@bu.edu>, 'Jamin Lin' <jamin_lin@aspeedtech.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
 <c144202b-0d99-4507-8a57-35df1ece3cc0@siemens.com>
 <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:610:119::21) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 9763bda8-6d06-4e45-edca-08ddf544fda9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3Rta2F4OXVHNnBHN241N0l0Q1hjVkp0RTFRMDRhemVjZlRrVW9MS1djdXJM?=
 =?utf-8?B?WUhSVUdGcVpZWlYySytyUi9NMU4ya21Sbm8yREh6RzRib0taVUFJS2xtcEc2?=
 =?utf-8?B?UnZOQ1B2WTN0U2tSU0xRQUhFOEk2QVpUcWFOOFp2VkM0dnE0SUF0Nm82UThP?=
 =?utf-8?B?c1dQMnFUYTJXVndDVXYwREZ3S2Zxazc3R2V2Mk5UazRkblRHQkpxZzdPTWQ5?=
 =?utf-8?B?UmpXT1VPbTJ4b2xVQ0dGdVRqZS9kZ3h3SEl0SzJ6TjNCNGg0RVZjNkYwTFBL?=
 =?utf-8?B?MHFnNENTWk4vYzlIcU8vM292Qno2aklOYWhINXFTTE52VGFPU011bVV5dFhv?=
 =?utf-8?B?cUQzSDZrTjk0LzAwNFczS1hxOXlnY2JJa01TcjB4cmVVeEFqQWRYL29QWkFw?=
 =?utf-8?B?aDIxaklzeTlCSS9FejlSL1dsck0rWVVCTXFhUVlqK0NkQjZNSGg1SWF6MzJV?=
 =?utf-8?B?eTg3M3RrZmx2V2JpMzRNeTI5bzJxL29lSENZTHFNUmV2TE5LTGgvOFJCRzZp?=
 =?utf-8?B?MTVraGM3bzVNRUVJVHlzdEJpSnhSSThjcXFlS1cxdlNrU2ozTk5jLysxVWFs?=
 =?utf-8?B?OWUyc0creWlGVXF2QjIzQ1VPbFpSa1VEa2t5Ym1lQm44VGphd3Zoa1dybDJF?=
 =?utf-8?B?MzZ3dFBNanJacHpWZGJpSzJ4ckJCcG80RU9LR3RKU2pHUFdhVWxISnRqTjkx?=
 =?utf-8?B?YTBua3NHcGdQejlGdStUR0g2dlBhSUdCTDU4SDFlQVdmKzU1bkk4RXlGZlBN?=
 =?utf-8?B?S2p1bHJncHNRMFB2eThwSlkrQ0R4a2xjcWtqS2VscHdkQzhTSDNzc1k0L1BM?=
 =?utf-8?B?QUE3RzBDWGxnNWZEdmNKVUZkSnFvYU5mSXQzdE1ZcnZLRitMVmM2TTdDSnZM?=
 =?utf-8?B?d2JtcjJlQXA2LzByTGw2cWdIOFJKRU1pVCtSaVhXZlJaUUFETXZSWTEwaEo3?=
 =?utf-8?B?ZGZQYStDVkRjcFBUMHZMbDk1d2NkUjZFM2J2emZhQ0w0dnpvelhmQXI2TFVU?=
 =?utf-8?B?clFid2hTMm9TVTBpRDBYdGxlK3BCUmNVQkVTMCtZMFRpUTk4ZXFUdy9EUDk4?=
 =?utf-8?B?VjVSQWdxVFRacTQyOVpCUHpJbmpzUXBKdmlHaVdteW5LeVZ2cnpDZ0JzV2w0?=
 =?utf-8?B?b1NBMnYrQXhUeWZiMXNiY3NNTFZWVkhESC9RVmFjQ1dsc3ppSGpJdHJtcGhJ?=
 =?utf-8?B?eXhtU1ZUNWlxT09iTmFLNlUvc2I3d0ZNam9hSk8xK014RzdaWDhYcHZDSnF4?=
 =?utf-8?B?NVRxUHQ4M1NyRXdlOUVVYWdNVFUvTGtVbDN5RUhqOGg1RjY4RGxVUkZ1Qzcz?=
 =?utf-8?B?a2prY1BLSTJhK1RSUitZOFZ4blI2a2wyMHJFWWxWUGo2eXdPQzFvczg5ZWJ0?=
 =?utf-8?B?b1Rhd01SSTd1T0J2K2U4bzBTQW5sdWovYS9aNjFQZTI4Q3E1TDdWSFFSUW9L?=
 =?utf-8?B?WnM3RWFzeHZZV3RGUlhFcFArTzRLTy9LWXp4QXIyc3BXVWRQcE5wcVp6MmlN?=
 =?utf-8?B?Y05rMTNwY0lyUEQyc3B5TGFMQmU5akg1cW00RFdNOVhiUnBGSFlKbzVGSE51?=
 =?utf-8?B?R2VsaXF3QW5ScXJaajZFbGJtRmNpem9BWjBxa2p2ZW1SUjJUaUYwcTlHMVFy?=
 =?utf-8?B?ckZRU05DVG9VVkw0SkNhaW9pa0Z6dmZyTTNCL3VwL0JHVTRWOFErTTA3cHNr?=
 =?utf-8?B?ZW9PSHdoK0VmbUpOWmZTRUV1TGdUTHFuYzdleFpvRSt0T0lvbmYwU0RUWW1p?=
 =?utf-8?B?L1BlaUMrdHNrWExhNjg4UVdsOGRZYnZPSjh1QWJWelpGdHYwbFJFM2dWb3Rl?=
 =?utf-8?B?Ly8yZDRzNk1jQUpXQ2xkblNQUVZDWUtpY2N4R2FYWi8zUis0MTdsZWl1MmVW?=
 =?utf-8?B?bXdMYUxUYlRqTWoxL2NDQks3UUhVSVhoVjlZZTZtVVAweEdqY1pUMlIxcDRa?=
 =?utf-8?Q?/QgoCEpuI3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d280QWEzTTdkaVVwNC82cG5iMHg5VlVaMGNTWFlOOFBZYXVDQWZINGs1Unkr?=
 =?utf-8?B?aGNLVzRDd0FpNitPUFJKS1FFdkl0djhRMi8zNnRTYi82K21vd2xGUEpSaEN2?=
 =?utf-8?B?UnJvQUVpd25HWTRIa0VTM1NVTktWVWlXTzNYdDNpaG9SOGxaUHlrQkREMFQz?=
 =?utf-8?B?RkNsc0dmRzN1elJjOEd6RXdQUHlqaCttQTNkZnBrL3VsVDZTTGYrcngzMmZ0?=
 =?utf-8?B?Q1RkZ296TEtJajJ2anZhZHVpZ0owcWdOTUdScDJYREE3Y0NNZXFWU0xUR2c5?=
 =?utf-8?B?ZWIyTjFvRFBXQW0wNUFDSGdLNm5TTWFYZ1I1OGs3OGtrTlV2QlFSaXczYXEz?=
 =?utf-8?B?em81Wm44dTVjTnRKZXB1L0llNGk2ZUMzS05iMWsvVGlFMXUvd2EzeXF6TTA2?=
 =?utf-8?B?ZjZMOTYzcEs1UGFMZU9iVFpZMDRTdStjN2hzQjduUG5OK1dpOHdINEJnNUI2?=
 =?utf-8?B?c0ljZ1QyOGs3dnhsUmpDQ0IrSVUzQUFIdUN0NDZVRXI4dGs2SUN3M1NxNmh6?=
 =?utf-8?B?ZU8rVHBoWUQ0b2s5SGI4bnpqWEMyM1ZucnBGSzNkNmt6bzUrbFRhRjhEa2hp?=
 =?utf-8?B?V2RNbitET1BYYVRNQVhySFp2bTZCbVVLQXVIVXpjcHdkZmZhOFIwWW8vY1hs?=
 =?utf-8?B?NnVZSUhvYlVScFU4V2RXZi9iaHdyOWJLRTNrYW4xYWFUMC9vSG9SNFllc3Ru?=
 =?utf-8?B?VytxZTFNazNPODFqL3VQODlyenJ6dWMyeVl0cXUyeHB5enZvR3J6TFpyUndI?=
 =?utf-8?B?c2QvSUJVU2psWWs1cll2MnZxamxDYUxFaUpzMWwxdTBNN01QdjNDNXovSlk4?=
 =?utf-8?B?SENSVDVnbGlyVDk4OGtJenFDVWxYeDN2TUh1Y1MyL0draHkrNVNzUkdUbVE2?=
 =?utf-8?B?dGVyLy9jWXJrd1pPZmh2Vmt2Z3pudHBrdXo3a1BRejlVSVV5T0dkQ1htUzV2?=
 =?utf-8?B?aTRFNi9iVlp2T0VJbTVHUzN3Ynp5R3JNaHV6UHNQd0JMNHNJQ2NkbVlXQ3ky?=
 =?utf-8?B?YjkzZnV6Z1NnRjIxR21NYkI0eFd4VXpqUGNQSHlvZG9EeGE3SmFoTHh1MFpP?=
 =?utf-8?B?ZnhUSHJQajZnV1JNZkhpZWF1M1FYUGZjRFlhRW4xZE1XS2F1akQyczRQR0JT?=
 =?utf-8?B?QkpBUUJIM0FiVlMxdjNoMGxZNHhmOENqVFVNQXdJVG5jbXNJQkZxSG1qalZt?=
 =?utf-8?B?VWtZTko5eERqdFBOR2dqYjdRU1pJREcvU3RucjRLVUQ2d2dNL01FeHRESmUz?=
 =?utf-8?B?dG5JUkFlenE3dmV0UmdLaStGcmNGU0xqWHNwU1pHTDhFYzdSN1FEY21sb25k?=
 =?utf-8?B?N3NNTjhCOFRxUlphYk45czBpTjFQclhEVjJBUVlaSWxjQ21vZE1wUHRpbUZy?=
 =?utf-8?B?cE5mRTQ5b29PM1NTQ1M4VjFBVWZxNzBMRzNPSVVEYXlIOFRhR1NHUkpPaHc2?=
 =?utf-8?B?NGYrWmFIa3NHRFJGbFpDcWJ4NXFrNit4ZVM1MCtZTnZWU1htZjM4RjAxWUdP?=
 =?utf-8?B?R1kxTENCL3VUY2NYNEdQekRDK1IvckFLUHl3S0dWUHFhMGIwWXJqOGRxd1R2?=
 =?utf-8?B?OE5uVHNPSUJIc3BHK0FkZUJXcENtUU12QXg2RmcwcXJlczJZWk9DVnhvSWZO?=
 =?utf-8?B?a2lKeFBTSzUvTG8zUS90KzNOdVhzUmZyanhCU1Nva25wdDJIdXJnOFFubnIv?=
 =?utf-8?B?emtnRWZxakVvYWNINDN4MEEzZVU0MVlNZGJ0YWoyWnR1NzV4K3p1QWQ5Qkta?=
 =?utf-8?B?amNwWHNWdGdDOTVDNWN4R2o2Ri9ZTTdWQmhXYU9kMi9GelVmR1J0NmhuRVIz?=
 =?utf-8?B?Y3ZqeTdWOFRlc1N6bjJEdng0NHNNWXgwaC9aRUFCWkNSbWpEOTJsWHN2Vklt?=
 =?utf-8?B?bmQwZ3RWYyt6WnVXK3lodm9qUXBVc2FEN1llYVUxT1h0bWdncFZiUFB1dUdv?=
 =?utf-8?B?dm4wVzQxQy9uc3Rac1VEYzdvSXdlVFRMZ3gzaW95aVBydHZiY1FZUGZ4RGNj?=
 =?utf-8?B?ckl3OTJPMTRDNGRKUGlta0dkdWgzdEpDc0p5QmhBNCtWTU1Xc3FnU3V6VWRP?=
 =?utf-8?B?VkF2TWpxRDk3K2ZWL3lsWnM1ZER4UTFnelpRU0Q5cWgwTWN6SDlDbVI4aWpT?=
 =?utf-8?B?Q3p5U0FXamduT2t0ZUV5cFhaenNnZ3FEK1huWkxZems5R0EvbmRvZ3JxK0F5?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9763bda8-6d06-4e45-edca-08ddf544fda9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:18:02.5967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I3qujY2uQXAJP9dk6LPNRfSbvOW7mu0Jg0RYQMi440Oin1bMGn2rdUeb1dW5tarT5NW1ChMF9cQiwGid+HO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 16.09.25 18:14, Cédric Le Goater wrote:
> + Jamin
> 
> On 9/16/25 13:39, Jan Kiszka wrote:
>> On 14.09.25 14:46, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Alignment rules apply the the individual partitions (user, boot, later
>>> on also RPMB) and depend both on the size of the image and the type of
>>> the device. Up to and including 2GB, the power-of-2 rule applies to the
>>> user data area. For larger images, multiples of 512 sectors must be used
>>> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
>>> and also detect if the image is too small to even hold the boot
>>> partitions.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> Reviewed-by: Warner Losh <imp@bsdimp.com>
>>> ---
>>> CC: Warner Losh <imp@bsdimp.com>
>>> CC: Cédric Le Goater <clg@kaod.org>
>>> CC: Joel Stanley <joel@jms.id.au>
>>> CC: Alistair Francis <alistair@alistair23.me>
>>> CC: Alexander Bulekov <alxndr@bu.edu>
>>> ---
>>>   hw/sd/sd.c | 61 +++++++++++++++++++++++++++++++++++++-----------------
>>>   1 file changed, 42 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index d7a496d77c..b42cd01d1f 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
>>>       timer_free(sd->ocr_power_timer);
>>>   }
>>>   +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
>>> +                              int64_t blk_size_aligned, const char
>>> *rule,
>>> +                              Error **errp)
>>> +{
>>> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
>>> +    char *blk_size_str;
>>> +
>>> +    blk_size_str = size_to_str(blk_size);
>>> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
>>> +    g_free(blk_size_str);
>>> +
>>> +    blk_size_str = size_to_str(blk_size_aligned);
>>> +    error_append_hint(errp,
>>> +                      "%s size has to be %s, e.g. %s.\n"
>>> +                      "You can resize disk images with"
>>> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
>>> +                      "(note that this will lose data if you make the"
>>> +                      " image smaller than it currently is).\n",
>>> +                      dev_type, rule, blk_size_str);
>>> +    g_free(blk_size_str);
>>> +}
>>> +
>>>   static void sd_realize(DeviceState *dev, Error **errp)
>>>   {
>>>       SDState *sd = SDMMC_COMMON(dev);
>>> @@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev,
>>> Error **errp)
>>>               return;
>>>           }
>>>   -        blk_size = blk_getlength(sd->blk);
>>> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>> -            int64_t blk_size_aligned = pow2ceil(blk_size);
>>> -            char *blk_size_str;
>>> -
>>> -            blk_size_str = size_to_str(blk_size);
>>> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
>>> -            g_free(blk_size_str);
>>> -
>>> -            blk_size_str = size_to_str(blk_size_aligned);
>>> -            error_append_hint(errp,
>>> -                              "SD card size has to be a power of 2,
>>> e.g. %s.\n"
>>> -                              "You can resize disk images with"
>>> -                              " 'qemu-img resize <imagefile> <new-
>>> size>'\n"
>>> -                              "(note that this will lose data if you
>>> make the"
>>> -                              " image smaller than it currently is).
>>> \n",
>>> -                              blk_size_str);
>>> -            g_free(blk_size_str);
>>> -
>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>> +        if (blk_size > SDSC_MAX_CAPACITY) {
>>> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) !=
>>> 0) {
>>> +                int64_t blk_size_aligned =
>>> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>> +                                  "multiples of 512", errp);
>>> +                return;
>>> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
>>> +                int64_t blk_size_aligned = ((blk_size >> 19) + 1) <<
>>> 19;
>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>> +                                  "multiples of 512K", errp);
>>> +                return;
>>> +            }
>>> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a
>>> power of 2",
>>> +                              errp);
>>> +            return;
>>> +        } else if (blk_size < 0) {
>>> +            error_setg(errp, "eMMC image smaller than boot
>>> partitions");
>>
>> Cedric, I just played with some ast* machines and noticed that they now
>> trigger that error above when no eMMC disk image is specified
>> ("qemu-system-aarch64 -M ast2700a1-evb"). Is that a valid error, i.e. we
>> shouldn't have tried to boot without an eMMC at all so far, or would
>> this be a regression?
> 
> Only the ast2600-evb and the rainier-bmc have eMMC support.
> I don't think the ast2700a1-evb has eMMC support. Jamin ?
> 
> 
> 
> The rainier-bmc boots by default from eMMC. Nothing really
> special about the image, the first boot partition includes
> the u-boot-spl.bin and u-boot.bin images at expected offset.
> The machine model loads the u-boot-spl.bin contents as a ROM.
> 
> The ast2600-evb machine boots from flash. To add an eMMC drive
> (needs to be the 3rd 'sd' drive), use this command line  :
> 
>     $ qemu-system-arm -M ast2600-evb -net nic,netdev=net0 -netdev
> user,id=net0 \
>       -drive file=./v09.07/ast2600-default/image-bmc,format=raw,if=mtd -
> serial mon:stdio \
>       -drive file=mmc-ast2600-evb-
> noboot.qcow2,format=qcow2,if=sd,id=sd2,index=2
>       ....
>     U-Boot 2019.04-v00.04.22 (Jun 17 2025 - 08:57:39 +0000)
>         SOC: AST2600-A3
>     eSPI Mode: SIO:Enable : SuperIO-2e
>     Eth: MAC0: RGMII, MAC1: RGMII, MAC2: RGMII, MAC3: RGMII
>     Model: AST2600 EVB
>     DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64 MiB,
> ECC:off)
>     RC Bridge phy@1e6ed200 : Link up
>     MMC:   sdhci_slot0@100: 1, sdhci_slot1@200: 2, emmc_slot0@100: 0
>         ....
>     [    4.209117] mmc0: new high speed MMC card at address 0001
>     [    4.211765] mmcblk0: mmc0:0001 QEMU!! 16.0 GiB
>     [    4.233637] GPT:Primary header thinks Alt. header is not at the
> end of the disk.
>     [    4.233995] GPT:29624393 != 33554431
>     [    4.234161] GPT:Alternate GPT header not at the end of the disk.
>     [    4.234399] GPT:29624393 != 33554431
>     [    4.234549] GPT: Use GNU Parted to correct GPT errors.
>     [    4.235223]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>    

$ ./qemu-system-arm -M ast2600-evb
qemu-system-arm: eMMC image smaller than boot partitions
$ ./qemu-system-arm -M ast2600-evb -drive file=disk.image,if=sd
<works if disk.image is large enough>

Is that ok?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

