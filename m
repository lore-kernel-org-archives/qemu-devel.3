Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3332CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hGy-00010L-3G; Tue, 14 Oct 2025 11:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v8hGv-0000zW-Ch; Tue, 14 Oct 2025 11:49:09 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v8hGs-0002tU-7i; Tue, 14 Oct 2025 11:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcxz9RYXfDi4aP0pjCKBzgq86Kxcl4Vojocyfawb+yZ3M/rgu6Pf1xoPLliIDmz8NUaoZD6ZE8l5ZpVFp7xa97QSHW1hhrnSrYUn1bG8l5IQpx+zkiL3fBZgEyIIMT7xIQEqwzyDKgNcYAtwQV4AdJP50aTKphTf8syY2/RpOzrFubVZ0LCLuWOj2yvrrYLcSy7YVBhUYwGDhViU5/cnq/XOvbbq5OWew2imOsv+QqPf6ytiZOP6sElC4PN9/WLT4FLjYegJCujMba+qBwqp5q++NcbrrPi1CMKPkY6+ij4fCiNxTPLVlqXNBSAu1alQtikI+rxLvPKjMLjw2724oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riVfwUx4hismUaheCk8IF4jkx3AvT9Ee2zSVnrbr45Q=;
 b=J0r3K43EhcFeKbz6F3eyiWL6ZoKaW52OSjcFbnbcuY2i/NSS/JEEW4Ggy4Kkw56yBAoPLlxllNiJQG8kx641BCI54erb7Ovn7bvi84kBhIp117y0r4SS3K1pj+wimMPo8+rlKzJEYK2AIBvTOrr3Od4vThms0r1a5A4IK+PJFT02SqWfVVszYS+Ccc02pXvcSNMFCR+P45eiLpucm72KWLdDg2xLI+kRtwJIpZkgYB0rzXlO3XSps7DmKrMGlRYfjrZ26DYsSGy/fent8tuFRZoNYJlSrxHTgiQvmL3ueIpat2eGVBww6PLzuRVaGmh5BqBg196N9j9Jj3z86AeDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riVfwUx4hismUaheCk8IF4jkx3AvT9Ee2zSVnrbr45Q=;
 b=W3Jj+1lj3AsEcHo866tO8ttD0+ryZBDeWC2IkTXVOzzBzYvgyS9qOHZ1ohtlFlQuiXI/Nk0SbY8ig0lfc7Gio6MyubG7k3Z2yd21ml8ibDkWSP/50pWOK80w1e8vVvOJLTERTOFFBBvIxBDSpo4EvxV9923bMpoRd42ZzROtO+hHGILpNYzhme3zKoK/yq/z+qRA+5q0PdTPoe0WyJgf3gLVKxSa1Td57ybV4zNp4mq3u3mAr9MylwuhuLU9GJ5P9DLnQNutKCmFuw99xS+svkRYzozf3qtBXJlOblLaqhc+lS+LZ9Hj597QxFanKnB8AslAb7Po8Wm7lBcyKP+ePg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 15:48:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 15:48:57 +0000
Message-ID: <2c028368-b840-4f22-bb5f-a9ffcfec26c8@siemens.com>
Date: Tue, 14 Oct 2025 17:48:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
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
 <b09cd869-39e7-4a62-b452-4ea39ccf4df0@siemens.com>
 <e992011b-ac3f-4770-97e8-3c0321410e72@kaod.org>
 <aa63efc6-8edc-4db4-9221-a1a54fc1cdce@siemens.com>
 <8b14bde0-2ca8-4b45-a41a-f1459a7710fe@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8b14bde0-2ca8-4b45-a41a-f1459a7710fe@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: ff10a134-1abf-427b-0e23-08de0b392f54
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1IxeVdaeXZJbjlzdTc0SzA2cmlWNG1HdlRSTXVsVUZpcVhBS2xjNWJ0d0xp?=
 =?utf-8?B?WUZqWmpWUkJzdi9icnRUTFEvOGdQYUw3WVpWN1N0TjU4WS9LRHM1dDkzRXpl?=
 =?utf-8?B?U0dEM08yV1ZXSHQ3M3JFRjJNVGFEZTBYcU5malhJdXBWUkg0OGsxYm52aXox?=
 =?utf-8?B?WnZzbzVHVGREdWhDSjFQRytBcGwvQitNdm9uSXQ2anMxTjYzdWZFdkZqemU1?=
 =?utf-8?B?RlBoMTd6OEZJa2RJR3hpUDdQaXdobjFUajN5ay90eVFTQzZOZEx6WTlGTHkx?=
 =?utf-8?B?Nm1uVCs3Z0VwTU04bWhYYlZhZE5xRmZyUFJLVjBFN3FUT1k1VkVpNkI1d2px?=
 =?utf-8?B?dUhsOGtzd2NPZ2lQOFNIekpIRGZ0VGtnN1ZGRDVPMkhDMk9iSXJEb1RVS1hz?=
 =?utf-8?B?aFR0VG5nbXBuZGdmb2tBOHoySTFxbUlXWnRubkdNZFBiY1JONENoS0w2RDhk?=
 =?utf-8?B?cFdhUFMzQkRLeTVSN3FQTFZlQ0cvam5KZS82c01Sc3hRZk1CM3krMXhBbjVT?=
 =?utf-8?B?bkdydG1lNTgxRElwTlA4T2VXRkhhV1RVWFE4VWlnM0ZxVzgwRU1XbXBmcWV4?=
 =?utf-8?B?YmQyZXIyck0yRi92VnlvdUJTKzJIeFA3cnp3NUJRT0Zib08vTW10c2xSYXVW?=
 =?utf-8?B?WkxwVSsvWkF0ekViaHI0OUJZYXNKUmNjMWxFbVNBZDlRMjBkbFpuOWNJUUti?=
 =?utf-8?B?NDhRZm1xN1htMmQ0ano1N04rek5yM3lHdmQwa0lxc1A0NjJoRnpwL3NSVWtR?=
 =?utf-8?B?OGhtUDBwT3VWdE0xSENIM0s2VTV3eVJJSTNPSk5ybTZzbncrdFBEUURac0Qv?=
 =?utf-8?B?MmJyY3d4dWlVeTVYZlJWN0pvRGxIVTNQckVMY3ZUNlcrT1RGc2lYcWg0UnlE?=
 =?utf-8?B?YWNtZVBxcnc3QkxTOEd6aU5vS0QvQjJzSThwK1lKdW4wREo5Tkt4V2VDbjYz?=
 =?utf-8?B?MThTN2R3cDlRYjZGVnUrc1phcVlHQTBYMjd5eTJvanNiVkVIeTJMOUJpdjFH?=
 =?utf-8?B?M1o1c2wxOGRFdFp3NHlCZ2c0TnpwemhUWlFSMTRrMTVYQTBiOUEvbTk5Y21q?=
 =?utf-8?B?bm5lSW43QVZ2L2IzcW4zVk9QbSt0VnFqeFJzZEJ3UW1CWSt0bUR5Mkpqc0ZO?=
 =?utf-8?B?aUFTMGViM08ySklidXpmRjNvN0NWRlR3QU94SGhjVzZITzdTR0pjSFlQNUhJ?=
 =?utf-8?B?SEFlZDZNeTQ1TEpZV3lUZTlDVnBCVXR0QlJncE0wRnBOVXE2bmZhTW5wcmc0?=
 =?utf-8?B?TzZCRk5UTmErRFJUdWRhYVl5NDB2TDc2bnpRRVlvcjAwbGVTcnp2TWx3cDZs?=
 =?utf-8?B?TnhPUy9FNHNuUENMZVFYVTNJRW95TDZvM28zS1NXOHF5bVBDRFBLY3FMYzlI?=
 =?utf-8?B?L0hhb0t1elRlUzlXTEMzVldIbkptd1dCLzZUaXlOWEhhajZNRlJ1Qjh0YjU2?=
 =?utf-8?B?U0tZaERvY0QyR0FBbnZuS1dKZm4rRG0wSWxZUjNlT0xBZTFSN2o4RFdrUEMx?=
 =?utf-8?B?TlhuUFNLNm5MY2ZzWU1GYXZhM0NURnZjSG5wYVk0dkdoQ3lEOUlkWUVDUi8x?=
 =?utf-8?B?TmhFRDVCSklvTTVyOWt0VENLTURvVVdaajRZcC9tRE8wcWszK1R3Wk53cTE1?=
 =?utf-8?B?dXhmTnMwMytINXp1aEJFdGZLdlFNTUZGTXNKZHliZ08rT1pRY1E2K01oaGYr?=
 =?utf-8?B?SWFxMHBWc1RFUGkzSEg4YStIenUxZ2tTZDE2ZFJ0Vm8xRFdCejhhOVQ5V1pT?=
 =?utf-8?B?SDdKMC81VDZncDd5MTcrNVFKZHNaUmJzZzRpdjZEVDE4MWY2YjdYOXJYYStY?=
 =?utf-8?B?RnBRdklDa2xNMmxUN3drVXZjaXFMZzY5Z3lWRWdXTXpCaWtoNWZkS094bnVQ?=
 =?utf-8?B?M1hIK3dXb0psWVU3ZU1TMmlNME41UjR6ZWNoMVpRNlRydWdWdE5sZlMxWDRX?=
 =?utf-8?B?L1V4UjlzRThaaytLQk1NNkVpRVl4UktkVXdWTGh2aTBUeXQyMStWZnUwZFRV?=
 =?utf-8?B?cTBhSEVFcjd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG8xNzBZVDY1NllMRlJpc0lja0FsQ2x3czBMb1FMTWdyRk1Lb29SM2N1T2pQ?=
 =?utf-8?B?NDJYQXR0L1pWVzV2VDJQOEhTeWxtNEZSZ0VUaXZ5QWowa0I3Qi92cG5FQnVS?=
 =?utf-8?B?bUFHWTdsVkJxZnJKYVFEV3ovb2ZJdG5KS0dXSHY5VWp5djRpYmtGTlhKaUNa?=
 =?utf-8?B?Y2ZxdXRMOTJNM0xDTm1vbnlsQWNQTXBrS2xrSzBadllRU0xkRWtXbkZRelhP?=
 =?utf-8?B?aWxnWG9mSWpYSFVWVG9FSWFzbHdyY2ExZlV2QW5PbEdjYmRkT1ZFOVlaK05B?=
 =?utf-8?B?V2g4VjJWaHZhTnpSaUJJbHljUS84bmI2dUNJS0hGeWRWYlQzQmFrbmZLUnRZ?=
 =?utf-8?B?RGdTNmExT0FwaVdBc3hqdTN4K2txWGVoM29TNGtSNC9tSWVINGpoNHM3ZmJK?=
 =?utf-8?B?TzZOUU9QWGJZc29SZ1hBalduSGdZSW0zdTREWlhhZDVUQk13QXlaczRRVXRO?=
 =?utf-8?B?SFpNQWpQTXk0Q3paUEQrY283OS9Wa2RGSUJPMjRTSVhrOG5CVmFvd0ZTbDRS?=
 =?utf-8?B?MmtDekhGa2FlbC9vZmNFcFpwSkwraUdaWDBCMkxEWjEvSEM4S1RHeDR0VDI4?=
 =?utf-8?B?OVkzck5PQ0J5M2cvbU9XWVpVQi8wNmNzVTFXa25XeHpad1EvUk53REFzUzlJ?=
 =?utf-8?B?Nloyd3ZieC9HckpKOVJtTVFVUnFlZXdnMkw5MVBtS0w3L21aWGVYcU44OHh4?=
 =?utf-8?B?cVdGRWx1cGZSTXpFRjRYZW0ydlNLM1NtMXV6STRXQmVmTlBQeXhvYTdkdlcr?=
 =?utf-8?B?aFRWeUtUM3JUeVFHUGFRRWZOY0VYSEJpdlIrYWllTjErRGs4bWxQNjFYODhK?=
 =?utf-8?B?MUd2U2V3Zys5bUdwV1hqcE1nZEJNclU1aTRpTTIxTmV4TklrYlU1UmFNRUp2?=
 =?utf-8?B?MlBRWk5yS0dGU3g0SWNCYjZRUzNTTVJQeC9vNjV0S2xYUlQ2V2poUVl4Sjk0?=
 =?utf-8?B?QytVcDFHRFByT1U1UFFlYTdRdnEyU2s2eFBKLzNiOVNvTjdlWUxKeHhIeWJY?=
 =?utf-8?B?bWxNWWkwOUJmU25nZ1B4RXpIZUJzY2pXRE1vc0ZUTDcwR0FmSk9OcUFTanYv?=
 =?utf-8?B?NXpGYlFmcmNwRUczVU4veHJaclJZeVRGUllMdkloNHVZUnd3V1doR2NFZ0RV?=
 =?utf-8?B?aGJWais2UVN6TEJtSFZQeGVuMlpHU0RsM2hneTd3eTFoZU04T0hxR0hhSy9Y?=
 =?utf-8?B?eVNXYXZqbi9nZzQzQTJ3NCtJcW1sNVNvYWQ0L3I3SFZoL1g5dUdmRzFncVRv?=
 =?utf-8?B?M0N0Ni8vdmNTN2xKUkFtK2p4MVJUWmo0UVRrNVZlRHFSQUprVzNCQ1BvWWF2?=
 =?utf-8?B?V2VXZHpZTkNYOVhjVFR5UGtpRC9IOEFQK0VneXFuUnpRSzB3L3lIVmF6NXFu?=
 =?utf-8?B?QzdLZnpmTTI4WGF1TEptY0x1L1ZzMU41T0RyNENUWUd4Yys5aXhzMVdBQ0xL?=
 =?utf-8?B?NHRWb2JBaXFNbVdTT1dCa215amY4SWt4K2FxRGZ3WGhkY3RTcmsvTXFwdDB3?=
 =?utf-8?B?NTEzUDY0WEpXdE0vNkUwYmMxeTdLcE0rQ2wvUzNiU2svWlZoVmh1YytFTkNR?=
 =?utf-8?B?SUVxWHRoZlVqK0t5cmhRSTNlYi9sQUI1YTlLZGQwWWxLQWNWM0g3eGkxWVdS?=
 =?utf-8?B?RGFMMGIwYUJ6T3loam1nalJXK1NvdkhsNHdwRmVFZkR3NXhBMmYzaHVlN0ZI?=
 =?utf-8?B?UjBBaUs2NmlZV3hqWHM2YjJzdDVyVjdIaVlwOGE3SzJtcnV6TEpoSDdKV3Ir?=
 =?utf-8?B?LzhnNjRzazg3dXhieVdnKzhDOGlCZlRrdmI5RHg4Y1ZpSmZKSmdoQ2lIYk1R?=
 =?utf-8?B?Ylo1blVGUVArWTA0dWxCZFF6OVBXVXR2Y2xkSkVHaGxTbE13VzZ4U09aTnVU?=
 =?utf-8?B?dUsvVEE0ZFVpSENyMVVqSG9kUTBObXlHZmhnQ1VSL1BBK1F6bitLb2t3UlBj?=
 =?utf-8?B?VExEcloxdDZ4NzVWdThQQlUrMGFmTE1lRThJRnYwNEY2Nng3Ujl0REdod0Zx?=
 =?utf-8?B?Qy8rTXp2bVp5R2hSNHd1ZTZEY2NzcThQR1VKMklnNzRXOEs0djI2cGxMTzN5?=
 =?utf-8?B?czh2VG15cXBtVmdyeDRJSUhmVGJ6anc2eG4xNmt4bzBSOHJoRzJ0N1ZvM2Nl?=
 =?utf-8?Q?x1W91u1QleoLB1OWyp6pKyrUw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff10a134-1abf-427b-0e23-08de0b392f54
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:48:57.0529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hdTZHw/7H/MJvGGrcZqA4xcKQ1csQwd2yPk0qd4gimOgMED8aOwv1rLY5X+OG3wtvglFL7DAv6RODQQwOoWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5668
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=jan.kiszka@siemens.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.269,
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

On 01.10.25 08:24, Cédric Le Goater wrote:
> On 9/30/25 11:06, Jan Kiszka wrote:
>> On 17.09.25 07:53, Cédric Le Goater wrote:
>>> On 9/16/25 19:17, Jan Kiszka wrote:
>>>> On 16.09.25 18:14, Cédric Le Goater wrote:
>>>>> + Jamin
>>>>>
>>>>> On 9/16/25 13:39, Jan Kiszka wrote:
>>>>>> On 14.09.25 14:46, Jan Kiszka wrote:
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> Alignment rules apply the the individual partitions (user, boot,
>>>>>>> later
>>>>>>> on also RPMB) and depend both on the size of the image and the
>>>>>>> type of
>>>>>>> the device. Up to and including 2GB, the power-of-2 rule applies to
>>>>>>> the
>>>>>>> user data area. For larger images, multiples of 512 sectors must be
>>>>>>> used
>>>>>>> for eMMC and multiples of 512K for SD-cards. Fix the check
>>>>>>> accordingly
>>>>>>> and also detect if the image is too small to even hold the boot
>>>>>>> partitions.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> Reviewed-by: Warner Losh <imp@bsdimp.com>
>>>>>>> ---
>>>>>>> CC: Warner Losh <imp@bsdimp.com>
>>>>>>> CC: Cédric Le Goater <clg@kaod.org>
>>>>>>> CC: Joel Stanley <joel@jms.id.au>
>>>>>>> CC: Alistair Francis <alistair@alistair23.me>
>>>>>>> CC: Alexander Bulekov <alxndr@bu.edu>
>>>>>>> ---
>>>>>>>     hw/sd/sd.c | 61 ++++++++++++++++++++++++++++++++++++
>>>>>>> +-----------------
>>>>>>>     1 file changed, 42 insertions(+), 19 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>>> index d7a496d77c..b42cd01d1f 100644
>>>>>>> --- a/hw/sd/sd.c
>>>>>>> +++ b/hw/sd/sd.c
>>>>>>> @@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
>>>>>>>         timer_free(sd->ocr_power_timer);
>>>>>>>     }
>>>>>>>     +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
>>>>>>> +                              int64_t blk_size_aligned, const char
>>>>>>> *rule,
>>>>>>> +                              Error **errp)
>>>>>>> +{
>>>>>>> +    const char *dev_type = sd_is_emmc(sd) ? "eMMC" : "SD card";
>>>>>>> +    char *blk_size_str;
>>>>>>> +
>>>>>>> +    blk_size_str = size_to_str(blk_size);
>>>>>>> +    error_setg(errp, "Invalid %s size: %s", dev_type,
>>>>>>> blk_size_str);
>>>>>>> +    g_free(blk_size_str);
>>>>>>> +
>>>>>>> +    blk_size_str = size_to_str(blk_size_aligned);
>>>>>>> +    error_append_hint(errp,
>>>>>>> +                      "%s size has to be %s, e.g. %s.\n"
>>>>>>> +                      "You can resize disk images with"
>>>>>>> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
>>>>>>> +                      "(note that this will lose data if you make
>>>>>>> the"
>>>>>>> +                      " image smaller than it currently is).\n",
>>>>>>> +                      dev_type, rule, blk_size_str);
>>>>>>> +    g_free(blk_size_str);
>>>>>>> +}
>>>>>>> +
>>>>>>>     static void sd_realize(DeviceState *dev, Error **errp)
>>>>>>>     {
>>>>>>>         SDState *sd = SDMMC_COMMON(dev);
>>>>>>> @@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev,
>>>>>>> Error **errp)
>>>>>>>                 return;
>>>>>>>             }
>>>>>>>     -        blk_size = blk_getlength(sd->blk);
>>>>>>> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>> -            int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>> -            char *blk_size_str;
>>>>>>> -
>>>>>>> -            blk_size_str = size_to_str(blk_size);
>>>>>>> -            error_setg(errp, "Invalid SD card size: %s",
>>>>>>> blk_size_str);
>>>>>>> -            g_free(blk_size_str);
>>>>>>> -
>>>>>>> -            blk_size_str = size_to_str(blk_size_aligned);
>>>>>>> -            error_append_hint(errp,
>>>>>>> -                              "SD card size has to be a power of 2,
>>>>>>> e.g. %s.\n"
>>>>>>> -                              "You can resize disk images with"
>>>>>>> -                              " 'qemu-img resize <imagefile> <new-
>>>>>>> size>'\n"
>>>>>>> -                              "(note that this will lose data if
>>>>>>> you
>>>>>>> make the"
>>>>>>> -                              " image smaller than it currently
>>>>>>> is).
>>>>>>> \n",
>>>>>>> -                              blk_size_str);
>>>>>>> -            g_free(blk_size_str);
>>>>>>> -
>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>>>>> +        if (blk_size > SDSC_MAX_CAPACITY) {
>>>>>>> +            if (sd_is_emmc(sd) && blk_size % (1 <<
>>>>>>> HWBLOCK_SHIFT) !=
>>>>>>> 0) {
>>>>>>> +                int64_t blk_size_aligned =
>>>>>>> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) <<
>>>>>>> HWBLOCK_SHIFT;
>>>>>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>>>>>> +                                  "multiples of 512", errp);
>>>>>>> +                return;
>>>>>>> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
>>>>>>> +                int64_t blk_size_aligned = ((blk_size >> 19) +
>>>>>>> 1) <<
>>>>>>> 19;
>>>>>>> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
>>>>>>> +                                  "multiples of 512K", errp);
>>>>>>> +                return;
>>>>>>> +            }
>>>>>>> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a
>>>>>>> power of 2",
>>>>>>> +                              errp);
>>>>>>> +            return;
>>>>>>> +        } else if (blk_size < 0) {
>>>>>>> +            error_setg(errp, "eMMC image smaller than boot
>>>>>>> partitions");
>>>>>>
>>>>>> Cedric, I just played with some ast* machines and noticed that
>>>>>> they now
>>>>>> trigger that error above when no eMMC disk image is specified
>>>>>> ("qemu-system-aarch64 -M ast2700a1-evb"). Is that a valid error,
>>>>>> i.e. we
>>>>>> shouldn't have tried to boot without an eMMC at all so far, or would
>>>>>> this be a regression?
>>>>>
>>>>> Only the ast2600-evb and the rainier-bmc have eMMC support.
>>>>> I don't think the ast2700a1-evb has eMMC support. Jamin ?
>>>>>
>>>>>
>>>>>
>>>>> The rainier-bmc boots by default from eMMC. Nothing really
>>>>> special about the image, the first boot partition includes
>>>>> the u-boot-spl.bin and u-boot.bin images at expected offset.
>>>>> The machine model loads the u-boot-spl.bin contents as a ROM.
>>>>>
>>>>> The ast2600-evb machine boots from flash. To add an eMMC drive
>>>>> (needs to be the 3rd 'sd' drive), use this command line  :
>>>>>
>>>>>       $ qemu-system-arm -M ast2600-evb -net nic,netdev=net0 -netdev
>>>>> user,id=net0 \
>>>>>         -drive file=./v09.07/ast2600-default/image-
>>>>> bmc,format=raw,if=mtd -
>>>>> serial mon:stdio \
>>>>>         -drive file=mmc-ast2600-evb-
>>>>> noboot.qcow2,format=qcow2,if=sd,id=sd2,index=2
>>>>>         ....
>>>>>       U-Boot 2019.04-v00.04.22 (Jun 17 2025 - 08:57:39 +0000)
>>>>>           SOC: AST2600-A3
>>>>>       eSPI Mode: SIO:Enable : SuperIO-2e
>>>>>       Eth: MAC0: RGMII, MAC1: RGMII, MAC2: RGMII, MAC3: RGMII
>>>>>       Model: AST2600 EVB
>>>>>       DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64
>>>>> MiB,
>>>>> ECC:off)
>>>>>       RC Bridge phy@1e6ed200 : Link up
>>>>>       MMC:   sdhci_slot0@100: 1, sdhci_slot1@200: 2, emmc_slot0@100: 0
>>>>>           ....
>>>>>       [    4.209117] mmc0: new high speed MMC card at address 0001
>>>>>       [    4.211765] mmcblk0: mmc0:0001 QEMU!! 16.0 GiB
>>>>>       [    4.233637] GPT:Primary header thinks Alt. header is not
>>>>> at the
>>>>> end of the disk.
>>>>>       [    4.233995] GPT:29624393 != 33554431
>>>>>       [    4.234161] GPT:Alternate GPT header not at the end of the
>>>>> disk.
>>>>>       [    4.234399] GPT:29624393 != 33554431
>>>>>       [    4.234549] GPT: Use GNU Parted to correct GPT errors.
>>>>>       [    4.235223]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
>>>>>      
>>>>
>>>> $ ./qemu-system-arm -M ast2600-evb
>>>> qemu-system-arm: eMMC image smaller than boot partitions
>>>> $ ./qemu-system-arm -M ast2600-evb -drive file=disk.image,if=sd
>>>> <works if disk.image is large enough>
>>>>
>>>> Is that ok?
>>>
>>> No. This is wrong.
>>>
>>> An sd card device is auto created at init time and a 'DriveInfo *'
>>> is always available for index 0. 'mc->auto_create_sdcard' should
>>> be set to false IMO.
>>>
>>> commit cdc8d7cadaac ("hw/boards: Rename no_sdcard ->
>>> auto_create_sdcard") seems to have changed the behavior of
>>> several machines.  See 'make check'.
>>>
>>
>> Just to avoid we are in deadlock: My understanding of this issue is that
>> it is not a fault of this series. Am I right? Or am I supposed to
>> address that as well?
> 
> Could you add to your series :
> 
>    https://lore.kernel.org/qemu-devel/20250930142448.1030476-1-
> clg@redhat.com/
> 
> and retry the aspeed machines ?

Yes, that patch resolves the issue above.

> 
> I am afraid more should be done to run 'make check' with your series.
> Maybe set 'mc->auto_create_sdcard' to false for all machines ?

Who should do that?

> 
> Thanks,
> 
> C.
> 
> 
> 
>>
>> Regarding the rest of the series, there was another comment on potential
>> improvements for the docs. I was waiting for further remarks before
>> creating a potential v5.
>>
>> So, what is needed now to move forward with my series?
>>

This question is still open for me.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

