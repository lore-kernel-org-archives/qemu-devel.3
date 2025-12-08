Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D0D3B7E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSl9f-0006d1-A8; Mon, 08 Dec 2025 19:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1vSl9U-0006by-VL
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:00:25 -0500
Received: from mail-northeuropeazon11020140.outbound.protection.outlook.com
 ([52.101.84.140] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1vSl9S-00072o-DK
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:00:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/lU46zaF1XLrw35LHijvQ0yBx1mDg5y+HvWbxH1N3HDCaEqUfSdWupied3oIM4dizgkGQW4VyMGsNjMgG/XrLImrrNvAHTv2JjQzgzYOVg8YQq+Hwq/3GJzyMEWugz6hWax72st067R9hSLaqpdhKiggkOxy9BioYyLb8M2NfZZxyd+SLqbRJFDAquXJbI8G1e/7VM11P+nMfKXLitnnKvXolTo8MAL1vGtI6KSxkUxnB8dNZt4kErV0EyjCavlPptnhZDC38ygveqSusvQzEnU4sqHDzGLolYDoydsNKNqjhaI+1B1AguYqSyXvBg96QVyP2cYXsNLw/+j4fow+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adxmez//tlOvhtsiXlTlVuPvMRjWYapiVGNZP3FQW0E=;
 b=knzSbFrpZf0nXnDoz5DJtx/EME4o+0ANQyDE4gZevX3iQ7PzH/j7arKQouYT9ysVG7yDrdRzJFQ7KjS5aTSOekVPlEjsct+TtHB4+4JbW0vAtsr2lwLVWvwYbMqnejefy9htZxAlEqPB4TqUzGUpIOE4SoQFMecErZPJU6zG0+34b1Yr6efV2hTSnJSvqv4nRUDabnsPoRrIhG2OJM4qIr2p5WGcIWndHOHBA3/HJNvLqS0Ja/QnQ5a6z5Lljs6webTG+VrW58WQMKeqpOtSATB01N1lDhr5wb2uwC9MqAh3S6EpaOiwYKUh7QOpY+NyqpSbDYVCj4XfC1SB+SCjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adxmez//tlOvhtsiXlTlVuPvMRjWYapiVGNZP3FQW0E=;
 b=viY26BIm9CSWh2IZy3fYlOKKiMuQdPh3pBR4xWdY0FK2+0/Fw6pCOyVv+F8LlN0RYd98bTbFs4ryKk40ehYahdNEkRONZCVTqoIxtVYeO3QhX31BrLT0b4quEg4Z/RRnnMx3ayRcFmP+/ZntuBd97w2M6fCi3IJHxSahJozie9LuB01lx3reEG7tE/CgGkpe+vC0NMiGUWMnj4qU4xVA13f+draloZPrb41FYyQ5zijVyv/1e8QOlETzKDIjTsJT085ALoAtjXdSLarJHAhp0z4AbCR5yjmGr+7Ovoh6xf4Y+0j675SR94IM8brf9Qr866XyDjt7qrI/gNOtrtXJrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV2PR08MB9877.eurprd08.prod.outlook.com (2603:10a6:150:dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 23:55:15 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%7]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 23:55:15 +0000
Message-ID: <d71fbe60-202c-4d1d-9f1d-14af5af00312@virtuozzo.com>
Date: Tue, 9 Dec 2025 00:55:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: fix broken error path in modinfo-collect.py
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20251203220138.159656-1-den@openvz.org>
 <e0b91a24-70e7-4cf4-b2bb-30b9b3401714@linaro.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <e0b91a24-70e7-4cf4-b2bb-30b9b3401714@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::18) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV2PR08MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d4e9be-d338-4476-18d6-08de36b53aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWtDM00vTzZDdmpCNWNlN2FXU3p4bFJNNEhkWFRSdzA2anlBNkpOMGRSdkd2?=
 =?utf-8?B?c1Y5UlQwZ0kyZzBwZ1dHcG12UnBTbS9vUXpHalYvc2dNKzYrZ25jQzlFeUhy?=
 =?utf-8?B?UkIwQzdQWnpVN1hoaFBXeVJaaXA5V3lqTER3VU9aYlIxNkwyNGx2aklpb3ZS?=
 =?utf-8?B?UEhEaUtNNjdhV0RrNC9FeUlJSlQyRHAya0d3SGlrQTZNN0pCbTZ6Z1lWekpK?=
 =?utf-8?B?SEoxWXdGem1YeEhnSVhrVVN2ZFQrcFZ1aWdSMEZybzFZZ0RZQ2RvbDZTdW9o?=
 =?utf-8?B?OEtRclZibEFaOE9GQzUvRzJEVUY5WUhjeFZzMGhpMWdSQlJMSFU1SmgwelVW?=
 =?utf-8?B?SUdTN0pTbDRMRjI1MnBJYklHZHJjbU45ZU1UVHdKWGVVc0dQTnZFaVZNY2Fx?=
 =?utf-8?B?NFhnbHBCbnRyN3BxS3NQeFh2NTBMd2VzeExEVkZTamJBRzgvYkQwVEc1dnRY?=
 =?utf-8?B?QU0zaWJiSEZpeERrVGNjaUVSTHp2YmxENUVoaEhhaTZHWldnVFkzZkdaeFQx?=
 =?utf-8?B?ZDZOSVdnMWhabDZCVWRHSkFqd0FiNzJ4ZzV1dnZYWVRuRnEvaGhDa1dWaW9u?=
 =?utf-8?B?MGxrTUx5dStJRFB0RW82QVpCbk9DR2I5bENMRXoyNzVyNkVYdmNoWVBHT1Vm?=
 =?utf-8?B?WnR2bzJ5U0s1dkEraHM4Y1Z3RGZ6WE9jTGtnMTVzeENEUzNaS3ZsaXU1d1Z4?=
 =?utf-8?B?N0N6T24wMlAvdEtmUUhEWk8zNnJtZVowNlBxeGRrK1JyOUNsZjM1UzF5NCtN?=
 =?utf-8?B?R2VGTm4rd1lsWGo2bFlPSllqbkpwSUFvOTFlZWYyTUQrWjI0cUJtYWdjYnRr?=
 =?utf-8?B?OHNaYWFlcENVWWhTa0JGYzNCK1VYRTZmMDVPczJ4bjBwN3pEYTA0S295UWJC?=
 =?utf-8?B?eU5iYTNEdTg4SEdnYitOUFNoY2xUaWRkejVUc0NvNmNtYnk1L1RZUkV0UWRT?=
 =?utf-8?B?TlBweUZLZXRlZUR5aXp5Z2IweGE1eXBjZ1ErZ3V1VHQxS1ZKb1VrMHRCT3FI?=
 =?utf-8?B?cW5DZkxQWERpM2RvVFJJTTI2WEZXR2hTRDArcHk4MDZab3Q4TTU2dFltbVNj?=
 =?utf-8?B?SjhyNHh1VGlDcnM4YkV1QVdGcU8yVmp1UzUydk9TY25MVVRxZEFFaVI1MFZ3?=
 =?utf-8?B?SXdKRlYvMmxaYlFiQzFzQ2JzRzZlb0RVbURFY0x4UkhleGNGdFhMRzNwN3Bk?=
 =?utf-8?B?dXVWZGx2L1RFcmhyUmtUbWtvRThjTkFIa0VCNVJLTzQ2MTBnRHFoNVVSRGky?=
 =?utf-8?B?RURvRGdvbHVGSk5kZ25UWnF3K1BaeUQwdkRBeFdXcUtvcHA0MDRxNjV1TzRr?=
 =?utf-8?B?TCt0TkVXMzIwQTJpbzBFeWUwMFlmZ3ViZ3h0Rk5aWWx5cXd4alhTLytBajY0?=
 =?utf-8?B?dGtEUkp1Y2hOamJvOUt3SXk4UUdRZUh3elJDVTBKUDdrWFV5ejF5cmlIVkcw?=
 =?utf-8?B?WUttKzIzanVMZ2hua0J6QVNoR1NqdnVoMXNHdDZRalVCYzFjc2wwVFlpcWRU?=
 =?utf-8?B?b3NwcjV4WlROYkV3OEJQNEJLUmU4cW5vOHREZkV0VDcvTFlOMVhjSWRIcjh1?=
 =?utf-8?B?UHpQSEdEeXpSVXRQdVVNVFhDRTNjVzl0SDdreldXRzBDdy9oTDZDSnIxcXhH?=
 =?utf-8?B?TWhWR0UrT0xMNnpQZklrYTZybEkxUzFnZnFRckhIUUZrUytQTXUzdS9pbWNn?=
 =?utf-8?B?dmJWZHlUOENNRFh6WlRFVDJqSXAvMllOSnlCTEVjYkVVNU1JWnFJUDZpQXdL?=
 =?utf-8?B?Yy91aE8zN1I0cHpNTEIrTUF3bk5VRFJVNXd2OFhtQ0JpUzdVbWsydVV1WUZz?=
 =?utf-8?B?U1doSTd6dUFKZW80OE9rU3Fud1VxbWdQTmdBZWRUWENwZERxOVVnTndHeFhP?=
 =?utf-8?B?eXlKRHpzOEc1OExweFNobEdEOUdWU09jaDR1ZE9nbEVZbS8xeE9JTlJsRjJj?=
 =?utf-8?Q?hn0Nomr5EpOWkuxXtYMtXqTAuKgb210k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFTTjRWMEpLNXJ2Nmc0ODUxQmNTVjF3VFhBVThybXFLVHk0VVZyWVNESzBo?=
 =?utf-8?B?bi8xN0p5R1h5T3FvcmpvaG9NN0Z2NWFyV1RFUVZBSm9lKzJNOU1mM08zQmdt?=
 =?utf-8?B?TTJPdU5sT0tIRXRRSFd2Nno0djlpbzZvV0Q5Q09neTk0WVBrUUVZRUVaVHRq?=
 =?utf-8?B?ZFRFbWRpNUt0ZEIzZ1FnWm9sVTNWVE1Yd3NDbHA3bE9vUEM1a2RFSWJRUFh1?=
 =?utf-8?B?TmlTWHNPY0NWSEJoODZSbGpHNmV3dE5WTTRKUzQwYjdKRm5wdHVvOTk4VkJW?=
 =?utf-8?B?OXk4dURzR3FnUDNUeENPTUxXN0svOCtrdFl0TnF4eWd6QUdwOGNuVlFaeWhY?=
 =?utf-8?B?cjRzYkNxTWJEa0p6akpUbGxlTys0NXJ1K0dLN3pyNVBhR2JDMlVtRVYwdmcz?=
 =?utf-8?B?MGF5Yi9Nc01VRC9PSGRMVWppSXRtZ1FsdnQraFdRV3pKZG8yWFpLeUgxTkNr?=
 =?utf-8?B?RW9CbVpzSlJMZGhjSnhBWkNPSTBDSU9uZkEwNUh4MHdyZllGQUowT0NPOG5N?=
 =?utf-8?B?eE9weHhLc3dFckVDd1FtWjdzNUR3UXJ1TGNJaGZrZ2lqSFJwancyNGRJeHc1?=
 =?utf-8?B?UzNnQjFwZ0ljbjBIRjdlWjZLdkFSbWRkNUtOZ05ZU0l0TEZZa3hwUkMxOXNu?=
 =?utf-8?B?cWU5OFJaRWtDTlNCN0czTFkxNm80QXhJZEE3d2FjZ0QzUDl2djJGY0I1NlZt?=
 =?utf-8?B?bE1PVFVaMGsxRVozR0V0VU5vTGJnYjJZVFhkZm1veWNhb3JjaGtrbUphY2VD?=
 =?utf-8?B?eU9penZPdXJuS3RTMzYyT1NscUhtNGhPU2FEY0xlMGdxdWVOdjh5anBONUVL?=
 =?utf-8?B?aFBIRi9BS2NaemVyQXpScmdURjBEbnd0YTVrT25aN05jQVJ0dTNDQWZDZWNN?=
 =?utf-8?B?NjFJVFlSTFo4SDVEVVhSb1ZOdzloOFhoSlJNUitpc2ovRUlFdnJQTkh3T1N5?=
 =?utf-8?B?S3RHb2E0MUE0aENwWjUwbEIwZnFkSnUzYi9YQlk4VnJ2UlFrSWszT1NkOHlF?=
 =?utf-8?B?eFNYSmNEQ2MxQkN0Q0xMQ1A4dHRXRDJPY20xL0pLeEJlUmMrSXFnN2xBR0NV?=
 =?utf-8?B?SFJQdEt0R1ZOZ0daK2NOMUV5eHhzT2k5MEprZWlVQzV1TVN3SmkxNFhaYXZm?=
 =?utf-8?B?cy9hMzlvNytNUE1Ud2I3cHNqTDg2RzNxYkFueldOc3BDR2VPeHQ0eGNlU2Vy?=
 =?utf-8?B?aTJ4UG1uUHpxeThXSE9tYS94SXVzeVl6SGFlemVlQVNpcVJibENkMEx5YVl5?=
 =?utf-8?B?UW83ZWUwWmx3RmIwV01HcHlQL3A0U1R3TzJxRzlOdlpaL0t0Nkk5SGVTaWNT?=
 =?utf-8?B?Rkw0ZjBuTGcvUjhsOU94U2x0OWx3NzhLNlNUMVJ6M00vTU9xRzNRVDhIMW1o?=
 =?utf-8?B?UEdmbGVVRWsxc1owbkEwOG1YM2k5ZmNCQmJOdDJkMXpTblhVUjdHRkhiaUpZ?=
 =?utf-8?B?Qmp1dXg4TkpSOVlodDFTK1BqTm11UkR1a2NqZG5PYmV1d1Rielc3dmQ2Rms4?=
 =?utf-8?B?c3RlMUFmbU85dFJNS0d2M0tOYkxHY1dYdGcrWEhQdTZ4bjJubEV3RCtuVWlB?=
 =?utf-8?B?Qm1QS3lxemJqbU5pdGVlNnREN0hlNHVYbEFGblNTaVFwdGtqNmV1ZFdpa3NV?=
 =?utf-8?B?UlBUM0R0OUJpT1FQYmVGWS96Q3ltRWJlbGZFL2IvRm1DM3ByWG0xMld0MTMv?=
 =?utf-8?B?TGVtRW5Cdjl6bzMwWFRETDZOSzV1VTByZGJMQmpOcTNCY2N3L01GSkFiUERM?=
 =?utf-8?B?QjRJZzVUWDJ4NWVoK0xxMWVWRW9aQkliZTcxYkxHZ0RsUWpwRXVMQ2JHeXZI?=
 =?utf-8?B?NFo1VGpsYTVzTFZJOUd3Zjh0TURLeVdFMm1iMlZpMXcxNkh2aXp0bG5QT0d6?=
 =?utf-8?B?VWIvWG15MDFMTmlmR05yakZlKy9vTS9nNUl5SnBYSnNqUkFwckVReUdQWmNS?=
 =?utf-8?B?Z2pkMXFheDE0aE9aajBQcU5uSnBiRVFXR2RUL0lNdGNlYTZQcXZlemFZRU5a?=
 =?utf-8?B?Q2RVWVhpL1dxbTZWbWtaMG1RV0pMQTRIcC9KVWxCYXh2TjhueUY0L1V2blZl?=
 =?utf-8?B?SHpjVjZWWStkKzIyQTZ6NExKWHJaQ2ZqcmVjQU9OWGFQT241QURYenRQY1RC?=
 =?utf-8?Q?hA+YabUFEUYwybVclIS8TpxhR?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d4e9be-d338-4476-18d6-08de36b53aec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 23:55:14.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CMhl601kAtsARI8GT3+T5mCJzRu6Ic8/4NOk9a9z//z7pnbYpWEDQ757HHcQ1g7v1sxsWNrgdmXFq/CUOUqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9877
Received-SPF: pass client-ip=52.101.84.140; envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

On 12/4/25 09:37, Philippe Mathieu-Daudé wrote:
> On 3/12/25 23:01, Denis V. Lunev via wrote:
>> sys.stderr.print is dropped long ago and should not be used. Official
>> replacement is sys.stderr.write
>>
>> The problem has been found debugging building on some fancy platform
>> derived from Debian.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Cleber Rosa <crosa@redhat.com>
>> ---
>>   scripts/modinfo-collect.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
>> index 6ebaea989d..db78b16c1f 100644
>> --- a/scripts/modinfo-collect.py
>> +++ b/scripts/modinfo-collect.py
>> @@ -41,7 +41,7 @@ def main(args):
>>       for obj in args:
>>           entry = compile_commands.get(obj, None)
>>           if not entry:
>> -            sys.stderr.print('modinfo: Could not find object file', 
>> obj)
>> +            sys.stderr.write(f'modinfo: Could not find object file 
>> {obj}')
>
> Missing trailing '\n'? Otherwise,
Nope. Double checked using the following:

iris ~/src/qemu $ git diff
diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
index 980956c660..737700d5fb 100644
--- a/scripts/modinfo-collect.py
+++ b/scripts/modinfo-collect.py
@@ -40,8 +40,8 @@ def main(args):

      for obj in args:
          entry = compile_commands.get(obj, None)
-        if not entry:
-            sys.stderr.write(f'modinfo: Could not find object file {obj}')
+        if True:
+            sys.stderr.write(f'modinfo: Could not find object file {obj}')
              sys.exit(1)
          src = entry['file']
          if not src.endswith('.c'):
iris ~/src/qemu $

In order to trigger the build we should command
     ./configure --target-list=x86_64-softmmu --enable-modules
and with the original patch the output is like the following:

--- stderr ---
modinfo: Could not find object file libmodule-common.a.p/module-common.c.o
[73/2396] Generating audio-spice.modinfo with a custom command (wrapped 
by meson to capture output)
FAILED: audio-spice.modinfo
/home/den/src/qemu/build/pyvenv/bin/meson --internal exe --capture 
audio-spice.modinfo -- /home/den/src/qemu/build/pyvenv/bin/python3 
/home/den/src/qemu/scripts/modinfo-collect.py 
libmodule-common.a.p/module-common.c.o 
libaudio-spice.a.p/audio_spiceaudio.c.o
--- stderr ---
modinfo: Could not find object file libmodule-common.a.p/module-common.c.o
[74/2396] Generating audio-pa.modinfo with a custom command (wrapped by 
meson to capture output)
FAILED: audio-pa.modinfo
/home/den/src/qemu/build/pyvenv/bin/meson --internal exe --capture 
audio-pa.modinfo -- /home/den/src/qemu/build/pyvenv/bin/python3 
/home/den/src/qemu/scripts/modinfo-collect.py 
libmodule-common.a.p/module-common.c.o libaudio-pa.a.p/audio_paaudio.c.o

which I believe is great :-)

Additional line is inserted with \n added.

>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>>               sys.exit(1)
>>           src = entry['file']
>>           if not src.endswith('.c'):
>

Den

