Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6A6CD5854
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRgM-0001Bt-OB; Wed, 07 Jan 2026 06:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vdRg8-000121-No
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:26:18 -0500
Received: from
 mail-switzerlandnorthazon11022143.outbound.protection.outlook.com
 ([40.107.168.143] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vdRg3-00022O-Pq
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:26:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvpNOWJAQ2BM9bEdRVcupOZX6C2JtZZRzPNfiV94uAw82k1x57LbePSWivh89zg6N5gYQci+wq/xoo1Njdl81aGrX3UyzM1H4k/sGWFrVGD3VrJ61nkdZosr081J8wVKDH9RmBdqGW1cKFCif0bxKUVaOtqWrPj660PX6SZf0+uB46zCZE2N3uAe9NtfMh7d0frblt1G12YiYZyKlxg68+7XAWfeMbTpIw/GDdkFOfnboH1Oc51WKYh4eQTGl4bBRi2E8mXZeclpV3U0GGaOY5kPpoyOQUpvudZcvdoJ0LI3I0bkWczp+HA9/OnJz3yMQJD7K54/LLojbgraufXuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXDT/h8a0ksgVL+DRMd/Eq39HUqGhESztJpQS6jKY9Q=;
 b=Bg4Zjt5MKyzpj3WQPyAV+HNt7MFeyBNdcXDlwcsgy2bpE5pn+QNx6C7gyDJNbImQF1o/3mMX7Nuzj4mNaM5n0mvlUWML89uEw/Te11mZ7teoLyxbfKDHGv+CUUporoHhgDAAmqIcxcoem2bPSPJQi9cXqfqGyh7e4E8J28cB4iMcZds2WDBeUNw23vVvicsZHaIXg7IPlv6Rvspvp0ci8JsLYpjSZMPPT+8DWrMGPtejyvoUJ5e4eaBtdPVRruC7u1bTwkWrcl+eSwvI2Dz4yZb4mkw8ResVwwhL3mQnpC6AwyoMFhy6xIRqghT/FE5mIGAOzriqpYnDUrQhnshwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXDT/h8a0ksgVL+DRMd/Eq39HUqGhESztJpQS6jKY9Q=;
 b=NR1dXcFhUpFG97FCjna+VEv4oDk3Fpe4Sd6DdTtIrdELzS13G9HsQFfGAfoVbFknafz4Mww+kdpd4qsU+G0+ZGdEu8vetz9ztd/LqdlyEL2AndZ6+VOJhnTfkIQr8L9CVpXiWynGwiiUdvCGIKXRgc7tFz+ZQJ0X9GtkP9ND5gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GVAP278MB0881.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 11:21:00 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccdc:4b69:a4c:e1c1%2]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 11:21:00 +0000
Message-ID: <8c07a111-f543-4d32-af9e-4907c113d108@epfl.ch>
Date: Wed, 7 Jan 2026 12:20:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] plugins: Add PC diversion API function
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
 <b461feb8-4ad5-481d-a497-dcb10b12ee79@epfl.ch>
 <87cy4jubc9.fsf@draig.linaro.org>
 <341e0334-7bc3-4186-94c7-fba1c92cfc9d@epfl.ch>
 <01a56a53-ef95-4c63-8f4d-21458bbc3668@epfl.ch>
 <87ms3i2w04.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <87ms3i2w04.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::12) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GVAP278MB0881:EE_
X-MS-Office365-Filtering-Correlation-Id: d08e48a7-0a9b-43aa-0a28-08de4dded615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|786006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjI3WG13aCtrdDNNKzdGbVJyTVZ3cUt6dSs1VmYya3BNcndSK2E3TTVWWlJy?=
 =?utf-8?B?S2x6Z1A4UWhuQ3BiRHJFVEhRa1dWc3F0RmxaVnA5TE93ZUpISk1LVUkzYmFN?=
 =?utf-8?B?amcybmVGSFlhUGFXT281Ym1TbHJPYzJCTHNrbWlLYStCYVBhQ2h6ODVLN2ZT?=
 =?utf-8?B?SFV5TWNRbHliazBRV0M3S3VDOGR4aUdDWjY4bDY4dmp2Z2E4Uzh6bEZYMUhU?=
 =?utf-8?B?TUY2MkZrV3gxRUJyeWNlY29HWUxHOGkrRTEySnRQeXNNWjg3M3pUL1B2S3o1?=
 =?utf-8?B?M2J1UXlZQmdJRHZtTlB6NUJnRDM2UnBiK09ibTNZeG1QVXluN3VnSTIrWmxZ?=
 =?utf-8?B?TlpoNk85Y3BDRk4vK2UySERsdm5rSS8yek1MeisvWTg1dUcwcStJVzE4ZTNI?=
 =?utf-8?B?V0RhakQrNHp3eHZhS0FGVmQybng4T2xOWDVvaWhZdHVvaXhNaTI3cGdEUGxS?=
 =?utf-8?B?cWxIdVJQQ2p1VGhTK3ZmcUc4cStwL3kvRHJoYUVCY09QRHRCTVNLODBxN3Qx?=
 =?utf-8?B?cUdCaVVtbjh6T1ArcllkWGptclJhNWFzbDNJVXppdVZRRTl4WGJibUgvL2Nz?=
 =?utf-8?B?SGV0b0ZkblpYbUZoVTB5eXR4Y2dUYkVuQXYzQXQ2UG1vTXFBM0JJdk9hQjRE?=
 =?utf-8?B?L29nZjFaeFdybWtsNmdXdFluMTlhV1hreThQandMQWZ3ZHZZOE9iUnUvaWNu?=
 =?utf-8?B?V1VoNXF2Skl4ekZpdjFYaFJLTVNZSXlKRXozcTZvOGFMaUhxY1d2R281Q1Bz?=
 =?utf-8?B?TG1XcGFUTUxPOWo4MFY0bmRMeEFaeWZrNTBaZWVtbEdRWVErRGZ3MTN5dW1Y?=
 =?utf-8?B?eFhOQ2k2Z3NpaXJUUEl6cmpldTV2dVRFa0k1cnZQa2ppSTZSV01DV1RjbmtY?=
 =?utf-8?B?TDE4TkE1Z05UcFZoeitUNUlaSjhNUW8vS1BEekFTbTdQOTlJSExPRTk4YzY0?=
 =?utf-8?B?b2VibzZEcFBOZ01rYTBiMjU5NUNwNXZJSWhmbmxZWU5vb25uWklxV2o2MjBk?=
 =?utf-8?B?YlR3dU50WE5WWStBeDNxTjIwN1F3UjBKSWJ1VHRUdmx5a0xGQmRobkJmbkw5?=
 =?utf-8?B?Y1dMZkxOZWY0bjFmbDNBTHNnUVkvMmZLYUFWR05HeWF2WGxDclUvME9sem15?=
 =?utf-8?B?cFpYTEhxTmxDTkdEcld6Um8zK1RYczUxS0ZHTUc4RnVKclk5MS8wcUN6dm1O?=
 =?utf-8?B?dUNCVlMwaDdmd1EyTUZvR1NmMklacXZSd3lPaitHS3NSbkFaYkMzTUI0eXE1?=
 =?utf-8?B?bC9GYzNzcVN4QWlQQXNDMUlCeHBIcTkzVjJlemtBaVZxc2NYdnd5aWhNb25B?=
 =?utf-8?B?ZzI4SVJpZkN6VWkrK09wdFUrMUhjWDJrOEx4Ri9tMGkxYWVwSkxndVl0WVNu?=
 =?utf-8?B?cEFJWVdTZUQ4N3dNVGI4M0ZYV0NmelpraWk0MWg0ODNLOS9IdXdVckV2S3l1?=
 =?utf-8?B?VVB0UWxoajhYMzFERHJTTEdiOVJLUGN5Q052cHRTQTRVeUwxUjU0YW9wdFJ0?=
 =?utf-8?B?TUF2QUMxZTN2bFNBNTYwZS8wNng3elhmUTdhVVJSeTd6ZXRsTzBuQ3dlQm0r?=
 =?utf-8?B?UGRwcGNkbGtrOS9rWjhFaWlrN0lrUXpmMTRCN001UWloQ05mb0llbzBERnpY?=
 =?utf-8?B?aVN3VzFwanZkUTNJcUoyTHY3T3c3TS9lZld2bllLNXQ1dTA3dHo5d2pHcVZN?=
 =?utf-8?B?Y2locmFTWXFCU2VpQkFIclk5VmpFVFA1b1lIR28xYjYzOXplSnRpV0hBTGVs?=
 =?utf-8?B?ZzB3dkc4WEhoOEd4bDNrV1l4bUQxaEFpdUJBUXdrdmUvVU1WQ0hKM1g0S2xM?=
 =?utf-8?B?N2lKZkdVVm5jMy84UWFoMXI0eGJkZHV5TFcxNWtrWURXVnFVN2R2YlFEZW4r?=
 =?utf-8?B?enNCQUNZOUoydTVMQ0pJVlF0RUdzRmdNT2JxZi9nSXArYXFkV1dzV2pYQnkv?=
 =?utf-8?Q?ExIH7DUn5Q6Dx5/cegt5nVS7KqnCiUTz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(786006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUV3Z094S2RlVkRWczU5STl6Z3NmWHlIbUNybDd3Unk4ak9FeU9jZ0dzd3Ny?=
 =?utf-8?B?cDYvQXdhRHlwRTN1em83V3A3VElhRzdrdVJKc0tHN0xiNVhKQ1FlWkh2S2hJ?=
 =?utf-8?B?SzNMNWRzaUo4aUlNYmRWUHFqT01Kc0VobktiODc2OVJqWnZqSmVNM3FJNzY5?=
 =?utf-8?B?aEg2bDdrNVlHSmZnb2lqKzQvRkFHa2RJanlOOGVFMThEbWtHeGhFVjJ0RzRy?=
 =?utf-8?B?TGFCSjY5aVNvTjNVRkZhcnB0QzhaRythSnEwQlRmdWZSTFJjNXVPN0YxRTFo?=
 =?utf-8?B?cklMb0E2VE5aS2xHYUtPUk9UR0RaUGZpWEFVUnBjZVVqeXZnRVRoTVR6MkZO?=
 =?utf-8?B?UmE5NGJuZ0hNN2ZhbWNxWGFzQ2pwcUFBUkhBR2Rac3ppUEhRVlRKVWw5aU9n?=
 =?utf-8?B?TXRXam1jNG42S2lHMUdXRDdnYjZOVitEemVhc0IweTdodmF0M1VZOHhLMlJE?=
 =?utf-8?B?bXdURFFEaGc4aS9ER0lKUGtOM0tCYkRXbzVTaFRKcjY1YjJHKy9CK2c5NHdW?=
 =?utf-8?B?ZXZKVGdhaUFNM3NGdTRFVmVHQlFDS2w3VEFnRWNnTHN2WG5zNXY5elVmbnds?=
 =?utf-8?B?WGRsUW9TWFRIbzEwQkxQSnVMMytLZXBPZFYydDVOU0d5VXdlUUtNR1JFaUFR?=
 =?utf-8?B?ejgzU2RDYmx4L0NTK2hiNUpMaEZ1WWViOCsyMy9qNW12ajNMb0hFR0FibUR3?=
 =?utf-8?B?YU4yYktMdWNHbEpzWEp6S3JOYmxkK2dNNk40c0F5NmxGOWVJWVpVVWxZdkRa?=
 =?utf-8?B?UHo2MllPcWp6eEFkWHpJVzFwd0tqQzU3SU4yRVRheDRVeHRhOGNVWEp3SVgr?=
 =?utf-8?B?OGx0Nm1NRG9taXJpcW1TQjJPTGM4bWRwNWk4dUVYeGNNQkdLK2ZTUmhISEhC?=
 =?utf-8?B?U0JEakpPWEJYeHE2ZkF6dEE3ZzVvTmJmWkpyWm5lcVJ4Wm84WkdYanFEKzFN?=
 =?utf-8?B?VlNBcUZxcDRWaWZuQTN1VUlXTi9lQ0xlL3E1d3ZMN1NzbFM4YWRuUE5ZM1lT?=
 =?utf-8?B?SEFoMmJjZk9Hb0ROQm1ZbWJUNVZGbklXNm91ZUVvTjNNZzhJUUpja3JWc2Jn?=
 =?utf-8?B?SUkxaGZ5Ykdqa0JtNU5Wd3FnNFloZkpOeWZZOU9jNDdIM09keTQ2L0V0TDRj?=
 =?utf-8?B?bHNoSzM4VHA3R1MzczQ4cU1mUitFWXdLYktQVFI0aUUzRXhlMmk0dHo5eE9v?=
 =?utf-8?B?S3ZnTStMaXRWOCsxTjV6NFowUEFUUmk3Ti9lZ0x6YzJpa0hscE84UlRyRmRv?=
 =?utf-8?B?Qks3U2NqUEw4c1FnVEdtd3NFcFozbUtEb0wvRXZ6N0VwUmsvMjNMVUlrRHRx?=
 =?utf-8?B?OVNYOEppbG8rS1JUc0dMSWR0UlovSThnR2FzeWhOcU5uK1kyZmZoUWJMK3Rq?=
 =?utf-8?B?YXJ5UzF4WUY5WVN5RjNDMVdMY0U2b3lrRFdwVllzZGl1azRXTnJYWWUrbGNL?=
 =?utf-8?B?N0NFa1lNZGg5Wkw4bXcvbFl0ckFScWtPTGQzUDIvQ0F0Tm9kczRna2tYWE94?=
 =?utf-8?B?SGNkY1dvQlVmank1UUptZ0xPS2hRN1NhclFQek5GTWJGY01STzdiWUQrd05r?=
 =?utf-8?B?bWpUdUdJSjVVaXhVUTYyY0xJVWNFNzB1cnc4WnRFdFVOLzd6UUx2cFVFNFgy?=
 =?utf-8?B?ZG9iNXFkRUs2aVBneno1MVdUWnQyUDdzQzZUeXNSWHJNOUUyazRYZTJqRG8w?=
 =?utf-8?B?WCs0WVRVc0xmWmdlWFZCU1BPbGhLaWtpTlIrRE9Iemg0b2crRTBkQUc5cHRh?=
 =?utf-8?B?MThrT0oxNnk0MFNIRlBpdnZjK2pCakQ1TkdoN3g5L3JjbElJenM3c0drYzVw?=
 =?utf-8?B?Z2FBdEg4NllBRG9abG4ydjUyVURON2JxOSs3T0wyS0RGVnZPNVBCMEduL09V?=
 =?utf-8?B?YjlNcXhPQTZmOHBjeUhJQnVxZk11VURBakliUS95VzVxTmdUZEg2VTRFUUlI?=
 =?utf-8?B?amZZZ2drb2lpUUhwaUdNZTBCVm9hMnBkN01Jd2lKWFZlQ2t6aHdhbkVMa2hI?=
 =?utf-8?B?ckJWRk1FRmlueFhWa05CeHJzLzhOM0NRbHNTdWtHY2ZoM3dtaGFUcWFmTGIv?=
 =?utf-8?B?UEhBUVNNcklZcDI3NTJyaGZqUW5xRkRXVTE0ckV0azkrUU93SktTMVI0UUVp?=
 =?utf-8?B?aGdNM0hvUy9pMnl5RnBiSy9sT3ppL0RpWGNTSnBCZGN4WGJYMjAwa1ZyTFpu?=
 =?utf-8?B?V00xclg5ZndFR0J4cVJnVXVySU53dWVTTnZDOGg5b3cxaDZaNGQ4OWNYYXl1?=
 =?utf-8?B?a2RFd3lwTU9RbkIzMGtOdzlkRE5zVUpTUzdGSGV6SmN4MjBRZDVGdVE0c3F6?=
 =?utf-8?B?TGRGOENuUUhYK2RMaXBGTisyQ3ZiTEt5b2xHRW1JeEdrZ1F4Yk5uenhDTHh2?=
 =?utf-8?Q?U/LY9P0NjIQoN9yw=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: d08e48a7-0a9b-43aa-0a28-08de4dded615
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 11:21:00.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFOplRA3tdFwNe0EnO3EDzXdCXKpzPxuui1McK5tK5GWjZ09xkY/6IMaonxYl+VSwp4Xt1A5gej1ABtWUGeJlpSU2bg371GSRGqICXn+UVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0881
Received-SPF: pass client-ip=40.107.168.143;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16/12/2025 18:10, Alex Bennée wrote:
>>> The qemu_plugin_write_register API silently swallows writes to the PC
>>> even though such a write doesn't actually have an effect, so excluding
>>> the PC here might make sense and I'm happy to update the patch
>>> accordingly.
>>> Are there other registers that should be excluded as well?
>>> General-purpose register writes are visible to the guest immediately,
>>> but what about special registers? Do writes to those actually always
>>> have the intended effect or should they also be excluded here?
>>
>> Actually, after looking into this for a bit, I don't think it's easily
>> feasible without a big revamp (but please correct me if I'm wrong or
>> simply missing something).
>>
>> The problem is that the opaque handle passed to the plugin API only
>> encodes a register offset, not its name or type. So to exclude the PC,
>> we'd need to expose the register name to the API (which would
>> likely require either duplication of the name in both `struct
>> qemu_plugin_reg_descriptor` and `struct qemu_plugin_register` or
>> changing the API) and then filter in the API based on the register name
>> ("pc", "rip", "eip", ...). This seems rather hacky and fragile to me.
> 
> I agree - although I don't think there are too many more variations.
> Most of the other arches use pc.

From what I can tell, the only exceptions are x86 (eip/rip), microblaze
(rpc), and s390 (pswa). We could special-case those in the API but this
would need to be considered when adding or removing support for new
architectures.
As I said, it seems hacky but I think it's not too bad, as the behavior
when forgetting to change the corresponding code when adding or removing
architectures would not be disastrous: when adding an architecture that
doesn't use "pc" as the program counter register name, writes to the PC
would be silently swallowed, just like it is the case now. When removing
an architecture that uses a different name for the PC, forgetting to
remove the special case would just mean that there's an unecessary check
(but that's just a few instructions and shouldn't be in the critical
path).

>> Alternatively, we could encode whether a register is to be filtered out
>> or not in the opaque handle itself (e.g., by setting the topmost bit).
>> This still requires getting this information from somewhere, though.
>> Currently, registers are created by parsing the target XML in `gdb-xml/`
>> at compile time. The PC is generally marked as `type="code_ptr"` in the
>> XML, so we could expose this type information to the code and adjust the
>> register handle if it's a code pointer. The problem here is that it's
>> not just the PC that is marked as `code_ptr` in the XML; there may be
>> other registers as well (e.g., `lr` or `ra` for Arm and RISC-V).
> 
> Hmm thats interesting. Looking at the gdb docs:
> 
>   code_ptr
>   data_ptr
> 
>       Pointers to unspecified code and data. The program counter and any
>       dedicated return address register may be marked as code pointers;
>       printing a code pointer converts it into a symbolic address. The
>       stack pointer and any dedicated address registers may be marked as
>       data pointers.
> 
> I'm not sure we can necessarily infer PC like behaviour based on that.
>  *snip*
> We could extend the XML itself but that makes things tricky when we sync
> with gdb.

I agree, maybe the above "hacky" approach is easier in that regard.
Maybe adding a custom attribute to the XML would be an option, and that
should in theory be easy to rebase when syncing with gdb. The custom
attribute would never be exposed to gdb or just be ignored by gdb when
parsing the XML, so it shouldn't cause any issues (again, in theory :)).

I'll implement the custom attribute and see whether this holds up in
practice!

Best regards,
Florian

