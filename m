Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D5C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NbZ-0000S7-64; Fri, 10 May 2024 06:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s5Nb8-0000KX-0o; Fri, 10 May 2024 06:35:35 -0400
Received: from mail-vi1eur04on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2611::700]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s5Nax-0005CI-NI; Fri, 10 May 2024 06:35:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRlxaMJIIK9KSW/A0luYYa015zHOUMrroAnIg+UdL++0ng2bHIxt/M6aca+aUyl6/FPl+eGjV0d1OTzsCoOZLYAhiVXQYYMP2ilMQr6bR6DioLFmjX/BTehBW0s9XOFFNtl185ouvWA4CQZBjKHbKwoh/Pmz+ZwCsrPlcNeaQKcIE4q1OdsmXJs70O0hkRdBAbg2Lw6ixmX/qPUz+lp5rCdrF3qw2TxNmZYwjgh5R5d4vYI28XGngjXvT7fMycshYqDqiHEz4pKZ4x5jrh3GssQ/mbXBtBxHSo0K9ExF+/yUdmkf2glHeBzR6M8aFO8Rv7fNdRanEIi1UYn3qf+DEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqCtIuGPSfw23YyhZXvVPEvHKn2yS66rPTiSlhP/e+c=;
 b=FVFvqvFfcq2/qRlRkGp55BcQSHbFZBsxI9aQqvV4PaMwvtoe+2SM/yijI1GcYtzvlGQDfimP2eQ9jw/Z3ZarqDSdcWv605XMKnp5dL/LG4pdu+NoOlANdGhvDfA3Bbdoji2vid3y9teHONDggKdBrOlsOh5tKv4mXHswMpO8tIFXuXeePAGee7mtGJXEWIvhHXwXYk3tMJ6OSGu7m73nxH9MbmTlC1J9LnHCzpITLJolwVrxE/gisQZL0vSrfgvaw5fLgS4KjGxY2VmLE3AnpVh4HdP+00mFatK7q2lCXswKfpV4+LWK5W09E5OMyEqofEXA3UDiAwIH/9J+6/RSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqCtIuGPSfw23YyhZXvVPEvHKn2yS66rPTiSlhP/e+c=;
 b=xylO182HlSduPnpj4kpnQU3eC4nUKgT1yghVWvB+175Xc9ItrmhZ4+JRs7eGJ5RAsN/Wb0nw78eiXfYwkcYkT1rGdYhJ3yYvlr3ZZFokdO9AOg2dhz2rWofQNePj/WZtW0/OaaMfbpYYzu3tg2nTucdhEnQ7a6RfNbAHpuEVxyKc/D++uI+NGNxP6nCeLM+BFRb/8wPwb7UfeVAE5OsJmd20F+nEs42yTk0iXzv8Jxh/Af1UQfaITFdlK6ps5qlVJ/a1VY66YI+VphLExC5q+tJTnsBCkZ6lg+v3nyWd4AFxCCBmdFv+06L5YpEvdbbhsP/v+ssWnGn3ybzuv+0Fjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAWPR08MB9993.eurprd08.prod.outlook.com
 (2603:10a6:102:359::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 10:35:07 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::2a5e:391e:bafa:2d99]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::2a5e:391e:bafa:2d99%5]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 10:35:06 +0000
Message-ID: <3591281a-c508-4f8b-a4d0-f18055255778@virtuozzo.com>
Date: Fri, 10 May 2024 12:35:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Use LVM tools for LV block device truncation
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAWPR08MB9993:EE_
X-MS-Office365-Filtering-Correlation-Id: b15889f4-0dbc-420d-6298-08dc70dcdc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHNoQzh1YXArK1h3ZTIwWHA5MTRZSElINU0zSlNpcWpML3BnZVdpSXN0NkNT?=
 =?utf-8?B?SnNMbzBDMHI5T2pUd09nNXVLdDducWFYSW1FeGVlNjZxS0pnUE1RMVVvWVhF?=
 =?utf-8?B?dmsvV1MyelJIYVpKdGQyaXBDQXg3U3gwSE9WaFlOaXpmeWxSVHF1bFBBOW9N?=
 =?utf-8?B?SnFnRjJxdnp5emxOSnJoaThncGZubHhpSHNacnUzNXJYSlpOdHVVUzg2MlJ0?=
 =?utf-8?B?MlZiSzcvcGFkTVRuelhYU1NQNXpCSjFMMy9UUFFKSStxQ2dsRHJsTExpMkph?=
 =?utf-8?B?VmhOWGQrZjRHZUF1RE5UcE5vVWdxR1VLYjdTZmk4R2RxbEo0Q0FBSVZnTnFj?=
 =?utf-8?B?SS9KdVY0TktrcFo1SnFUbFQ4TW5aMHhEWWpLVzUvMG5vZVV6aWdxUkdsV1lD?=
 =?utf-8?B?cnArYjQxbWxnWHY0R0VVVDFZNjQxK3ZTemR3SFFnMnBzMG9vTjBFTkV5YzZS?=
 =?utf-8?B?OVRlSkhSRlpJWG5UR3cyZWhkWVpMYmliMG9xUXZ0UUJOdWZBN2dHc0o5aDFO?=
 =?utf-8?B?NXpmbTFBYVlrZU5NbStNeDBHQlhjc3lXcnFVQmNyVWU1V0s2M3hDMkVudlNz?=
 =?utf-8?B?TkJ3TjZSZlRCbXlJcjBpWjBnRncvd0NZaGVjT0c4d0QzaDN5Q0ZRdkQ2d3pE?=
 =?utf-8?B?bDNFclhjNHZqZ1dCTFJabzdtT0NBYVdiVGE5OHZUZ2hWbnpMVFFIMlhhenJI?=
 =?utf-8?B?VmhpQ3ZjdnMrOUkxcVFpQnFncFJoUFlreXRoK2tuOE5sY1VGQmNtUCtFcnNC?=
 =?utf-8?B?dWw3VDY4bWVSTEdrVXdlWkZSR21SYWxlTmZ2cnh6TDZ0TG1oVWlZQlRiVGZk?=
 =?utf-8?B?STFCbGVNMHpFS0xtc2NwUzcwWWdWcmdUR01FS1lrQjdTd2ZwWEJwTUM1eFVx?=
 =?utf-8?B?OW10WVJ5QWQrVXdmeFZodFJkZ3ZBUkh6SExHQldKMEluLzU1dzRCUDU0V09s?=
 =?utf-8?B?UndkMHozZjUzMkx4NE9Tb2NaOG5VZE50blVoN1hDVWFpcXdzdlY1QUhhbEFn?=
 =?utf-8?B?ZFRIWFRnNGpIdEdadjJ4VklNUkN4cEVUUHUzSVRuS050TDY0SXI2UFhhMjVL?=
 =?utf-8?B?QlNjL1lTelovMWFIYkNvdG1UdFk2VGFZRE4wZ3VBQ3E3MCs1aDFBVEhMNnQ4?=
 =?utf-8?B?UHBTdnVOZ1FlMUxOcTU5cnpCK1VJOWZHVzdUeXJKMmJWQ2RaYjBYSVF4T1M4?=
 =?utf-8?B?cVRyeTdQckpva2FpN0xBaEtWMldOVXEyVWpPY1NCRVFSNFduV1RsNXBOMG1D?=
 =?utf-8?B?SytnUkN0VyttVEVWOFFwTm85cjVTQ3NCZmZNMjZoREd0eTdycTE3cTYybnhI?=
 =?utf-8?B?cU5Fa1FPNzV5NGkxU0tFcnNIM2xnQXhQZFMzSXlESUlHcmhHZHRnNXRud3F3?=
 =?utf-8?B?anY0enFQNTkwdmg4SUJxTXZYdWhCa0llOWlkd3NKTlBKcC9rY1FrZVVmRjMz?=
 =?utf-8?B?ZEJNU0xLRWg3UUNUU2VhTVJ5MnBFMjJ3dUM5RlJGd2FNV1ZQaEhkQUxiQmhp?=
 =?utf-8?B?bHdSWEhLTHhwbkh4R1ZmR25QOW1rUFBvZzVoZHhaYlVjdXllVFduMW5zNlJO?=
 =?utf-8?B?NUUzT0J2c00rUTRid2dNUW92SUlyeGJJVHdIVjUvRzkzaUxwaVN2WDdpNHk3?=
 =?utf-8?B?SllSNWZYNXBySVJwRnp6ZUY5bHN3UVBrdWxXMHREd0NnOXl0ejR4QjNHWXRW?=
 =?utf-8?B?WXpSVitxdEtLSUUyWlFNU2Uxcm1qUEc2TEhrcnhMaFpzZnhvclBvbEhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hlZU5kdEFOSXVIckJXTExpSGJkbDlHQ2tFUzV4MkVyTUtkeW1PNjVHREhL?=
 =?utf-8?B?dE9mTmZ6MFNROEdiWm4rbWFQNFRXclNUeE1IV1BQeHJrRkx6REZPMUFqRE0y?=
 =?utf-8?B?MFBKUjhlTkVOYnMwd0EyaTFEdUNxV1VYN1hidUN5dlgveW1oK0F3Q29pRXJj?=
 =?utf-8?B?QlloVWN0aUdiUlY1UlJoYis0QUtBV3ljcHIwN2xUOU41UGsvRFhYSkpGU09t?=
 =?utf-8?B?UFJydkxTUitibGdnQmY0b1dva2NnUWd5NkhRNFZMTVBSWklHVTNEL2JXY3dm?=
 =?utf-8?B?c0pQMEZjejk0T2hXbGZ2TXo4YTRoWWpDSFpCSjFlV25xQXRkek1LL3FGZWt6?=
 =?utf-8?B?SHlVR0RQOG9JYm9JSzg0SldaN0lncGFrUFNJdHJnQmVYc1g2QWdHZTBickVv?=
 =?utf-8?B?OSt5c0t6cGI4aUtjM2c4aXZuSDl5UCtKMllCN1I2S3RQb3JVdjNEeTAwNzhE?=
 =?utf-8?B?dk9vbmpuQ29KcFFGME9yeHNWMjVrMU1uNDBXanFuTkFVYTJoaVFOcFBTQ3Qx?=
 =?utf-8?B?L0FSRmNXSzZhSnNENFlpWmxQc204RDIxYis3UXUxZWkvQWViWXRoNnp6N2Vl?=
 =?utf-8?B?SWFtSkFDK2h0WVVoVUtzaDVVMDAzaGNBdXhrWm5TTzZGSyt6T0g5T1V2R3NJ?=
 =?utf-8?B?U0l5ZXp1aDUwdUlZTmIwUGNUamYzbzlTU291aFFhRkQ1c2REUGtGQkpiNFhu?=
 =?utf-8?B?YzJ5ejdBaWEvZXh5bTI5VVBwcEgrS3FvOFhwY1JGbDZNSFdkY0hES3pCbGFs?=
 =?utf-8?B?c2xHd1RWMGV5WDFFY3FEaHl2d1Awc0RPVVA2QkFzN3dWcEpyaHAybnZHM0ln?=
 =?utf-8?B?bmc0bE1KMHZscVY5TzBaNlo5ZDBSQnVkWnZUYVhBSEdnaUF6Unpwa01HUnhX?=
 =?utf-8?B?L3BONzhXVXdQVlBkd1kwRVo5QzlmVEZibjBDQjlHV2dmZzVaTFRwOVY5M2Q1?=
 =?utf-8?B?clpVVEY1ekFyengrdVMwR1ZIdERRMGNlQ3FpVkV2T09veTZ4L0JjdVZ4ODRH?=
 =?utf-8?B?NlNHNHlPTlJrWmFvWkZUUzhYZDMrbzZlWFUvSnZ1eHdDR2dCS29aeURTcFBw?=
 =?utf-8?B?Sk9wSyt4a2pTS3lqMDlic3N6Rlp0UkthMTFtZ2QzRTlodXVRWTZKa3cyUmI1?=
 =?utf-8?B?dnc5MTFEYzYrTlEyUm10MktiQlgwZjcraFRWMXRlWjIrNDZhaGlZWjFLWXB1?=
 =?utf-8?B?V0gyVlU0UDl3QXJPTmZWUGVSK2dIdlR3RXVwcm82TncyQ0U5SDliL3AveHpp?=
 =?utf-8?B?MThrUkp0TEhUeXE2elljeCtaU3lzTk9DaWJtcTg4VklDdW0zcHJ0YjVBaW8w?=
 =?utf-8?B?NEFXTEtIS2lFTzlGQUI4SFM3dEFqYkMxWVFnd3Iva2ZZM0NpeHhkRE84RVUv?=
 =?utf-8?B?QnJaTlo5VERHUlpNMTFvbDlQcEttWHh3QmY1SlNPTElvTmhpNi9MMnd1aDJF?=
 =?utf-8?B?TGYybXVoYUQ1aThNVS9wWCt5Z3JBM0l5dGhKZ0FRS3FaVEZjS2JienZLbG5N?=
 =?utf-8?B?Y3QzZldJbmpNblhQR2FkSndycTFwYlpUbldOakN2SFpBQmpSdGVkakVPYTZ2?=
 =?utf-8?B?WG9Ud29KN0dHS3NjazBMWDByd1hpWkk0eVZ4Q1RiT3UzZnpzMm9Nb2JwNHU3?=
 =?utf-8?B?d0RzVDlrSGk0OGFjaUFZanRKYlNwOGFnN2x2cXBIREJLQ0RJTjE0OXdXRDJD?=
 =?utf-8?B?aUkweWFLTVlaeTJNcldVMDZCeWNYeUlCYlRTZ0hJSHZtYm5CSzM4bm9uZ2pM?=
 =?utf-8?B?a0RDd0kyU0dsU0JlWVVNRWpSbzRoeWdWUXFySW11OWhqRFNSTnlxSU1FQUVx?=
 =?utf-8?B?TFU2amVMaTJHaWZnUnVlUWNtNy9MU1o1V1d1ZHUyV3FqUTV2TzBENk80NlVz?=
 =?utf-8?B?d29NbVZpdWZNSFNZbTlqTWJ0aHphK1JhR2pzbmY5NHdTY2kvZGJmbW9sN0Zp?=
 =?utf-8?B?ZlkwWnJUcjVKV0hQbDkzcUNqZVVidC9rcTFYeFFoaWdwNnVDZDJ0U1NNVDRP?=
 =?utf-8?B?OUEyRGwyb1FVRFJ0Y285NThTdi92VEVIQnJaZVJlRU1YNGZvNHNzblg2L3NX?=
 =?utf-8?B?eE9CdCtiOTlyUjMvcSs0cUlMZzFRQVFnU2ZvZkZOaml0RERkTHlMUUo5V2du?=
 =?utf-8?B?bEJTaThscEVhYm1XM2kvY3JDenYvazZERloxWDd3N0J4U08wNGtZWGtNSnJ1?=
 =?utf-8?Q?V4Rrb68wNihY1bbpFUS4zhs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15889f4-0dbc-420d-6298-08dc70dcdc00
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 10:35:06.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNyxv4CwF/+i1bWxpw2QEp9HUp1JObjMHWjdeu4QvKmTGZtQlEWpum/eqHLyYmV182Nr+XWaPezkN6hfMij8WUPMVq/4Vcyzyf4v3RNeXsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9993
Received-SPF: pass client-ip=2a01:111:f403:2611::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

Is there any update of the patch status?

Thank you.

On 3/15/24 09:58, Alexander Ivanov wrote:
> If a block device is an LVM logical volume we can resize it using
> standard LVM tools.
>
> Add a helper to detect if a device is a DM device. In raw_co_truncate()
> check if the block device is DM and resize it executing lvresize.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..af17a43fe9 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
>       return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
>   }
>   
> +static bool device_is_dm(struct stat *st)
> +{
> +    unsigned int maj, maj2;
> +    char line[32], devname[16];
> +    bool ret = false;
> +    FILE *f;
> +
> +    if (!S_ISBLK(st->st_mode)) {
> +        return false;
> +    }
> +
> +    f = fopen("/proc/devices", "r");
> +    if (!f) {
> +        return false;
> +    }
> +
> +    maj = major(st->st_rdev);
> +
> +    while (fgets(line, sizeof(line), f)) {
> +        if (sscanf(line, "%u %15s", &maj2, devname) != 2) {
> +            continue;
> +        }
> +        if (strcmp(devname, "device-mapper") == 0) {
> +            ret = (maj == maj2);
> +            break;
> +        }
> +    }
> +
> +    fclose(f);
> +    return ret;
> +}
> +
>   static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>                                           bool exact, PreallocMode prealloc,
>                                           BdrvRequestFlags flags, Error **errp)
> @@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>       if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>           int64_t cur_length = raw_getlength(bs);
>   
> +        /*
> +         * Try to resize an LVM device using LVM tools.
> +         */
> +        if (device_is_dm(&st) && offset > 0) {
> +            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
> +            int status;
> +            bool success;
> +            char *err;
> +            GError *gerr = NULL, *gerr_exit = NULL;
> +            g_autofree char *size_str = g_strdup_printf("%" PRId64 "B", offset);
> +            const char *cmd[] = {"lvresize", "-f", "-L",
> +                                 size_str, bs->filename, NULL};
> +
> +            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
> +                                   NULL, NULL, NULL, &err, &status, &gerr);
> +
> +            if (success && g_spawn_check_exit_status(status, &gerr_exit)) {
> +                return 0;
> +            }
> +
> +            if (success) {
> +                error_setg(errp, "%s: %s", gerr_exit->message, err);
> +            } else {
> +                error_setg(errp, "lvresize execution error: %s", gerr->message);
> +            }
> +
> +            return -EINVAL;
> +        }
> +
>           if (offset != cur_length && exact) {
>               error_setg(errp, "Cannot resize device files");
>               return -ENOTSUP;

-- 
Best regards,
Alexander Ivanov


