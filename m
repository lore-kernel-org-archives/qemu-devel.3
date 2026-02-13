Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB584EDF174
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqv62-0002OI-Lh; Fri, 13 Feb 2026 10:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqv5x-0002NO-8x
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:28:38 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqv5s-0003Ty-UL
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:28:37 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DA6BAt3534639; Fri, 13 Feb 2026 07:28:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=idFFIKJt3g4dsy90KnW1+1mkSFkuwuVKyhcFuMF1p
 64=; b=Xv9k69vkuhMMt3M6h6iJ+SMlhTKw+g61spQJfnOPrXyx1Z2E0bv7qtZTl
 flILtl6bogbLSZ3EpL8NBZECueEXEj64u7FkTwqzwgrr1KI7Ik3NVtYE8F9gmVLn
 Qd4PujVHBsqQw8BZh1PxvrUjuSYpAooXwHN7LakwtudcdeG15RgrGjx+q+WVU21Q
 K5bNhZP76xrGgoQpDCoQx9xIBiolMlZ7faRBpErH/fNuCE/obNEU70vnxDL5t4D9
 2peKx0HSAcub05lqNiVUs0vjeoYlAOzkrXKzvP5ShT7gYwPoy42J9Fys/p4osQp7
 sWiDhrPvtiePFGA+SjiPOb+xRC9yQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022103.outbound.protection.outlook.com
 [40.107.200.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d7q8g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzdHjBCfFL5oOC5SbZnRxoGlXUKttXj79yN+Cf7JwfaG44dJj4gBBmNHROlBoW6D7zcAEw8QKKwD/ICIso3/uou6zd3G3OQJAFgTCCb05g48EQea5lMHw3HIvbv0aVjd5lRcdSjWre/QVM7aWlzuMiYR9HcljaCoX9RmKXRELc8KPLLrOVXx5XXP1+FSG4BvlA/GP4rpYh3MGVVHC1Ek+qGfZH4kbhBpuaJYsUy1NzVIrjAtkLDPVbmFECZRCrEKfB6YAO4uXTbH+imbBgTiOnXf4IlmFDXis5IEwL9fZ2YlZjShYF5sUDKiy0hROmHApD8PO9t8sd406rot0bmcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idFFIKJt3g4dsy90KnW1+1mkSFkuwuVKyhcFuMF1p64=;
 b=I8TAG8bC5uhcO+Mz/Lew/dYZnoV6bI1oL9GtaOBs4Qt2Nyi1GfblZEeUm3RcBI1A9HEXz6myzNkTpKqozZNRlH9Pta58JxvAnMPcdh8GhnkSLdKFTPW3QsOEfGZyVnwzCJUx669vAx9pfeH9pzYDn0RR4YTn7PDN1PjzhKxC16KCpBghdSgaQyQxTEvG2KbB4A5Ejr5CNB24TmDMcB0TGzukG9ZTVFsdZfYo17CObYL7RQsMjV8qwA0OeFW7izVpHD64SVCR6jGtevMluBv0BKw8n3OeD6gbtVGIMjU1/3HzBMyQqT04/DAYUsxI59ArwuouHnjHPJF414YAAJ93xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idFFIKJt3g4dsy90KnW1+1mkSFkuwuVKyhcFuMF1p64=;
 b=DjOtDqzQGtbvjedbvEbjlNdb3qkdL6mg9Kaee+V+sOis3vSvrv+8HnMyY2AIExYV2xj4ESTGcG3ZX1vd100whoiXmEOzEUHsKciZwh4eqAZyHiW0xlmTPF3Zgn5Q8mne5oZaK+58EPoLO45JP2VJZn9iN4lnDWhiMzKb3+5LrBKEbqUOS6iNOPnL5ttzzTZVHZtv9nrdlzcQYjBxB6FtW+MWw6eiq/nyVNJwdudU+aIqP9rwGnEwCLXPS4TeBOPtR5mlLsXMqirZsFAV0OzH1+FqJFWfzvosylZXlBmfQhkqTeIvjWgLg9/gEo+iIAPsDpml+ijplKv8fDrMOiZGYw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9594.namprd02.prod.outlook.com (2603:10b6:930:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Fri, 13 Feb
 2026 15:28:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:28:17 +0000
Message-ID: <6f204d62-f14b-479c-ab37-1dcca6b5bd30@nutanix.com>
Date: Fri, 13 Feb 2026 15:28:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/43] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-32-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-32-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:610:b3::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d60c34-d455-4b39-97b2-08de6b1482e0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UklnbFhKeDNZYk0wdHFzUkhrbHlpcWJNd3R6WVRQcFRpQ0c3aWVLcnlMNEh0?=
 =?utf-8?B?aGJVSXVlcGNqVGpJUjNQWGtkdXBTS3VLbG56UkhYQ09selBVSWlLQkxTbm5K?=
 =?utf-8?B?Z1VTQ2JHdEdLano0My9lemZFdVZXRVc4Tkd4d29SWUZJU0ozQnJjMFNiMnhm?=
 =?utf-8?B?aVcwWGtRclpzek1mSUpxREpzb3poN2hvaS9tbjgyZnN6REJkcUNEWk9kVk5R?=
 =?utf-8?B?YUwvOUlLNEF2bHhBQ04vYlhkdk1wVWdGckRKMWZvYzVuS2FwaDB2bUM0djVi?=
 =?utf-8?B?bTBlYzc4LzRYYkxOODlPRHhGOTlSUEVqYnk0WEZNZWZuajE1T2xXTTZ1OHdE?=
 =?utf-8?B?Ykp0V0QzS1JJZU41eUp6MGRxcFB3RDAvTXBoNnFRelk1L1FyUGhoZlVVZXhC?=
 =?utf-8?B?MS9MbGsydGNpcERqNmhSaERDbk5WOGpqaW5CVVc1cjJscWRuNkhHUlJqbHFs?=
 =?utf-8?B?NlY0NnE3czUvRjNvdjk0aFF4elRnbHdxdk5aYU5NQ3BaQXZ6RXlaSGpUblQ5?=
 =?utf-8?B?eXRLU3VtL0tlTVdGS3lOUVIwZEwyMHNxR0pucDc5SldncUxUaGxMQVRMWlpn?=
 =?utf-8?B?NjhIb3BvY3Z5NjB1TCt6NWNUOWxzWFBid0F0Mk81UjVYSjZpdVJxenlUalZF?=
 =?utf-8?B?UDZNN1hQMXVlWVRsNy82TXZxOXI1cFozbVFGd3NTK3oyR3QzVGNhK1dNWUY0?=
 =?utf-8?B?anRzTmtjVTBYaWZJdGo2VU9nTWFqZFVUVGJucUhkVXFabjRIeWJHZllZVlNn?=
 =?utf-8?B?K0R4U1BBWDhZcGJLWEo4bENvU0Rid3VEMERLODRFWTA5Uy9sNkdoWUdGdElG?=
 =?utf-8?B?SFZNWkQrUGM5c1RJNTd0TFMvS1puaHY0K2ZZR0JqZkQ3VGFMQm9wNUExU3FR?=
 =?utf-8?B?QVlFZUlmU1BzQTRQYWNnMHlJRUQxOFFmaGRGM0tQUHRrZitzOU5GMWpuNlhX?=
 =?utf-8?B?R09vSEhEamZBWUJoWWlodnVQc2pzMjZHVUJ0VDJsQVE1UFVmeHhKbi9qem5N?=
 =?utf-8?B?ZFZZOFFBQm1wUFZMaXE5TUxmdksya1V3RmpuWlc2WXdYNTNLQ2xvQUhUaTNa?=
 =?utf-8?B?T3NGSWxudXRFRmdOaHJpZ1krVmNiZ2RDNC9ta3VEZHBHQWpId1Y0eWkwd213?=
 =?utf-8?B?NkVCRFkwWkxMcHEzMytxaXIyTk1Da0tBRndFZWJpbkJDQzZhQmVrTlZpSHM4?=
 =?utf-8?B?c25TQlI3UEtKNWRUSkY0RXdQenlkWVBYcHRpTzZmd2pWVEJ4azI3Y1JnYS9n?=
 =?utf-8?B?MHh6aXROWkdDZ0ozNklGOFRqWEkxT1RRdWcvMWtmREQ0OXVZMFdHcDUzdUtT?=
 =?utf-8?B?YklTcXBKSEJTN28xZmdkRHF1M0Q3L3pDUVFMV283dVJzaHpLQ3gwOW1SQXVo?=
 =?utf-8?B?YVpXUWIxcmpzOUNacnExZGpPTXdESTdhZGVlRE94WGR6UmVnUGRDZUZuL0Jr?=
 =?utf-8?B?MmJPbkRucEh1Tms5aVEycG5USkwxSkdPcWhwaHkrV3RWUTNTZjlKczhpU0Ev?=
 =?utf-8?B?MnlOQVlYelBoNzZiWjYwTWJ6dlB1UWZ3VUR4bkxJSS8zRktKNmRoT25oT1Fo?=
 =?utf-8?B?SnFEME9IeUxETlFvNmtqZXc1MXNrNGVoekZaUXdLd0JaR3lIekZpU2I5VWk5?=
 =?utf-8?B?a1FvcXFQWFNzU05uWkt0Ti9RL1hzREJGamc5c3dKZGpWWFRvbytQL3RWT0dH?=
 =?utf-8?B?NWJnKzAvUmMxQU1OVktzbGlPbXJQNDhoQnJsWHlCVExPbkZTM3IrVUtrc2ds?=
 =?utf-8?B?Sit2SE9VeDdzdjhxWk1DbDB2SDRkRVAzbE1yYXFJSklwc0dQOVFWT0ZGQ0x5?=
 =?utf-8?B?d0JvZWdKa0lMY2xxVFNwS3AyMjVWTnI2WVlKanpXUUJjbXVmYlI0a3o2Q0hW?=
 =?utf-8?B?ZGpSVnpOSVRPNlJjeHh5OE9NMUl3R3lvcVljZ2M2azdEbFo1SHY4ZHRuTmVm?=
 =?utf-8?B?Z0Z0UXRzb2NtVWxnR0NpRFR0V0NxTjNDaDc4alJpMmdCTys1VWtpdit3RFk4?=
 =?utf-8?B?dTlQMCtEYW0wVUtwbU4zRDJDdnlabTY4TjJsdm1vQnFBM2RWc2FVKzdBWGF4?=
 =?utf-8?B?dmxJbkh4K0N4TUxBa0tQWTFvQmcveDVtNTJDblRFUkpkWGRyaHEvRy9nWXpm?=
 =?utf-8?Q?+6NU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmh4U3kxT01BUWhGZzNCNEUxd2dzeU0wQlhzS0xCNXRzNUJBc1kxVzNScTJD?=
 =?utf-8?B?UUtYaFZaZDZYWnZOMFFuUGNzTnJXbUhZYWwwL0xOeEJCK1Via0h5MnhVNXVQ?=
 =?utf-8?B?dkczdHhoSmphSXhLZSsvNmRHaFl0UU56Rk5TOFRCSGI2cFozN252RzQwQVBt?=
 =?utf-8?B?b25sQ094bEp1MkJ2VnJFU29NN0RSRGtGRFA3RTNrSFByNzZkOWhZL1NZQ284?=
 =?utf-8?B?dEs5aUx4a3JOdTRoYmRCNUJvcjJsM1RuaVpUSWsyVFF1R3JUd3ltOHJTRkVv?=
 =?utf-8?B?K2ozbkltb3RqSGNhZHh1U0NaZDJ5eEFaY3oyd0orM1RhYnJpbWFGLzcydEcr?=
 =?utf-8?B?b3pueDlELzAyY1M0QkhiMDU5VEZhMzB3SW1ONXhybVNFNWJubFpjZ2kxZTZ1?=
 =?utf-8?B?bUxuTUgvRmUyUTlqUThiZVFMU094UDBGNXduai9hK3I3NG14NFU0cDRqVnB2?=
 =?utf-8?B?NFpKSnU2SzFBa3AyRm5XaFdzcjRzVjltL0tXdHNlVEdWNFludXZ4STYrYU5r?=
 =?utf-8?B?ci80N1dadUdzYVYzL2ZkeUMrY0JMdkZ2VXEycy9rdDl1ODNLSloveTJoU3po?=
 =?utf-8?B?K3N0cTBWSUEvK3p1L1hUUm5HYXhsOG9MV0FBN1NXaUVDbTE3TGJzYVhkWi8z?=
 =?utf-8?B?V0pSY1FiYUkvVnYxQnZXN3ZTT3pHN0srcDZiaFlXNUdTZlEzMDM4WElZZ21B?=
 =?utf-8?B?L290K2lxTnY0cXBLNkNCNmpXQ3dkeEd0TUMzY0lsRkN0Nk9ZZjl1WVFYZ08x?=
 =?utf-8?B?cEl0RmhjaE1NQTdqc2VkMUlPNVBHbkNqZmpsYkc4SE5hN2E4bUNnWVpVS1dx?=
 =?utf-8?B?UG4rWnB5ZUttZzJtRC9SZnNZOGJYdWczWCthK2pISGR5Q2RQQ3l0bC9BWEV1?=
 =?utf-8?B?RXNFKzg4VE55dTZqUUFzYTd1elRjbXVLb1I1ckg3Ym5VQWpXMW1JbTF0bFhS?=
 =?utf-8?B?QXZHd1ExYi9OQVp6ejNVcExHWHA1Z0Y0Wk51Z2RJckxFMDJzemZKMFhqNG1I?=
 =?utf-8?B?L0RuejZoL0ZyVTFZQ1dWR3dsMlF6V3dKc0RJKzVBdGV1RjVYa3lpRGxEeEJ1?=
 =?utf-8?B?V3lFdlBSNU5tcWo2Y3gzOGR6OEVTQ1I0NlVTVFBFYzNmOUdFbUxuSXhqOFox?=
 =?utf-8?B?YXBYU21UWURTUWtHdzd4bG9ZVW9mWFV3Z3MzTE9kc3hVNEMxT0hHNmdqYm9P?=
 =?utf-8?B?M2NuTCsrbnU1ZE9QVGMyVVZOVDFOQXJEdUsreW94dU1PWC9JbEhYeGlnTFlY?=
 =?utf-8?B?ZDYweklDSnFSM1QzZllJVTcyRzh1S2Y2bEFZVUZmZEpLOVhlbjNjeWZNZlFY?=
 =?utf-8?B?blpNUUVVcG1kNmU4WDBCSXlpeURubTY0L3ZWU0QrTjArck5Dd2kwN3JOeXBK?=
 =?utf-8?B?M2w3YzZFeloweDVDMysyY1lnbUcvSWtjSDMzVUFCdC9pYWxFUmhsVXlEczFK?=
 =?utf-8?B?MjNxOXJqZFV3bzJMWXBSWVBpSGFEc0RMNlhzT3VUK0ZJSG5KNXNqOUVNR3pG?=
 =?utf-8?B?ZForR0FHL1lUOWMzS0dzRm1Bc0dHYW9lVWowYzgwdVpBdmFrVnVWZTNOajYy?=
 =?utf-8?B?VEowWk9xeWVDRm9hNnNpQ2VhRmhxZHp5MnJhZ1hrV005aTJ1MUFsWEpCNm41?=
 =?utf-8?B?aTVySHRlbUsyTTdTcHo5WEg4N2RDR0haQ0FzSUYzSW4yUVhrbTYxK1l4ZEs5?=
 =?utf-8?B?czFFbmdrMTBzS2lYS2pwRXBsMVRNRnRUYVVtM3daUFpBUVJwYzdVNGtIdDBF?=
 =?utf-8?B?bTVHUGQ2VjhoeWxRdG1ZT09oRjlwSVdLcEt5RFJqUVNLaW5FeXp5bW5YQW53?=
 =?utf-8?B?VVc4QndhZDZ0Q3VPcWVLWk5rQWVUVmdnRXRPSDR6QlRkSGFtdXVMOFJHa0ww?=
 =?utf-8?B?b3JURG9HNytubGE0WFpPb0toVDEyOUdsRjg2bWNyS1FKd25keWNCbm5tS3VO?=
 =?utf-8?B?Q081bDNydlZETmorQ00rMVY0N282SFVJN0NNMXRJaWZOM2d1YVk0MWxBK1c2?=
 =?utf-8?B?RWlHajJSNlpVQXVyWUY1TGM4ais5eW9ueEJyTGRBNWRHM1ZET0c5ZU9lWEZT?=
 =?utf-8?B?bStVUmVUTCtlNmZXbThkMTRxZlVudHdwa0NjZGo5cWZNT0M1bjhmNk5IbEdw?=
 =?utf-8?B?cUxvWUN1ZFVySkhVRFVBS2FNMEt5aDlCRWp4RlZlSEJzcHhyZUNYaDBFTzNJ?=
 =?utf-8?B?elIzTFhQSWVwckExWTB1aVNJejkyYzBiQUZXanhLeDQ2NytsZDNLZkpEWnVl?=
 =?utf-8?B?SVBjb1luWmRFV1BWMzBoUU9xOVpVK3lUakhxTkszYXdxbVBLdUFUQzZHZUp3?=
 =?utf-8?B?VzdpNDliUjJoUFRFVU8wc3J4cXEwK0t4TzNjUnl1R0ZPYUlSZXgzWndDS3BN?=
 =?utf-8?Q?fKlBLPjAtYeR7FWw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d60c34-d455-4b39-97b2-08de6b1482e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:28:17.5161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19BNi7BU2BObZ9fCISEODBt8or2KVCP9wU0wFgC6fJnnX2Ojmma0OBbbVai22yGfQ3jpahokil8zumhQ0Zy+4hYhmjoCX9cRiitEDtcsY44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9594
X-Proofpoint-ORIG-GUID: YE-jJ5hTENxrwm7XFbUZbTGmbfRsnmdB
X-Proofpoint-GUID: YE-jJ5hTENxrwm7XFbUZbTGmbfRsnmdB
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f4319 cx=c_pps
 a=K7AEBdpZSLD1v8U6HgG+qg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=NxGvE-Osspci3RS__kcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMCBTYWx0ZWRfXz7IFIaOt1OZM
 OiC59Jm8T9BEk4Wdcrm9jubYdfzWbS/11DgICkPKnbF1o8y14v6mpkV6I/2m/6ovn+0YVNsCZGT
 4/dIUQisJi25R623Cp9X/44xNFBtWQyGNaDQ+WwxsJSc5xuVgeveaFicfjonjFAa/chsdBM4v9J
 szkTfXSO+hL+lwx4HAdKug9zwiZ4edJeu6pHgilVIUvRYmdblnHQLwFejZ6rpt+52kQIzmHXGtR
 TpQmd7v5V2THZxFi9RLnhDIXfKRN6iXyy7Z93vfoy/lsXrsOddoWPb6zZs0bPQRP0M6G9cNrmYI
 I2zv6+RXS2C+7dstxp1b+freeHLr3cTb93RHwCyH6CBwjR/ad6b2ZgqhIInOE1JVpVHqu3lE7S0
 3CULPD2vt4x6Q7tfyoK57DpFYI31xk/oiMbMGaX/7spVJUwm/A3bJ+0bcpiqlBrTUm7hD/8vN0w
 duIN851irWRwuLI0oTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The audio_pcm_info structure stored three fields (bits, is_signed,
> is_float) that were always derived from the AudioFormat enum. This
> redundancy meant the same information was represented twice, with no
> type-level guarantee that they stayed in sync.
> 
> Replace these fields with a single AudioFormat field, and add helper
> functions to extract the derived properties when needed:
> - audio_format_bits()
> - audio_format_is_signed()
> - audio_format_is_float()
> 
> This improves type safety by making AudioFormat the single source of
> truth, eliminating the possibility of inconsistent state between the
> format enum and its derived boolean/integer representations.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h       |   4 +-
>   audio/audio_template.h  |  12 +--
>   include/qemu/audio.h    |  49 +++++++++
>   audio/audio-mixeng-be.c | 218 ++++++++++++----------------------------
>   audio/dbusaudio.c       |  12 +--
>   audio/coreaudio.m       |   2 +-
>   6 files changed, 126 insertions(+), 171 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 5334c4baad2..dd5f2220d75 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -45,9 +45,7 @@ struct audio_callback {
>   };
>   
>   struct audio_pcm_info {
> -    int bits;
> -    bool is_signed;
> -    bool is_float;
> +    AudioFormat af;
>       int freq;
>       int nchannels;
>       int bytes_per_frame;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 08d60422589..3da91a4782c 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -173,7 +173,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>       sw->empty = true;
>   #endif
>   
> -    if (sw->info.is_float) {
> +    if (audio_format_is_float(hw->info.af)) {
>   #ifdef DAC
>           sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
>               [sw->info.swap_endianness];
> @@ -188,9 +188,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>           sw->clip = mixeng_clip
>   #endif
>               [sw->info.nchannels == 2]
> -            [sw->info.is_signed]
> +            [audio_format_is_signed(hw->info.af)]
>               [sw->info.swap_endianness]
> -            [audio_bits_to_index(sw->info.bits)];
> +            [audio_format_to_index(hw->info.af)];
>       }
>   
>       sw->name = g_strdup (name);
> @@ -300,7 +300,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>           goto err1;
>       }
>   
> -    if (hw->info.is_float) {
> +    if (audio_format_is_float(hw->info.af)) {
>   #ifdef DAC
>           hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>               [hw->info.swap_endianness];
> @@ -315,9 +315,9 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>           hw->conv = mixeng_conv
>   #endif
>               [hw->info.nchannels == 2]
> -            [hw->info.is_signed]
> +            [audio_format_is_signed(hw->info.af)]
>               [hw->info.swap_endianness]
> -            [audio_bits_to_index(hw->info.bits)];
> +            [audio_format_to_index(hw->info.af)];
>       }
>   
>       glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index b6b6ee9b560..a2fbc286eb1 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -185,6 +185,55 @@ bool audio_be_set_dbus_server(AudioBackend *be,
>   
>   const char *audio_application_name(void);
>   
> +static inline int audio_format_bits(AudioFormat fmt)

Does the inline make a difference here? My understanding is that the 
compiler treats this as a weak hint these days, and generally does the 
right thing by itself.

> +{
> +    switch (fmt) {
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_U8:
> +        return 8;
> +
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_U16:
> +        return 16;
> +
> +    case AUDIO_FORMAT_F32:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_U32:
> +        return 32;
> +
> +    case AUDIO_FORMAT__MAX:
> +	break;
> +    }

I'm not sure that AUDIO_FORMAT__MAX is a valid choice here - can you 
drop the explicit case for AUDIO_FORMAT__MAX and then simply have a 
default that calls g_assert_not_reached() instead?

> +    g_assert_not_reached();
> +}
> +
> +static inline bool audio_format_is_float(AudioFormat fmt)

Same comment here re: inline.

> +{
> +    return fmt == AUDIO_FORMAT_F32;
> +}
> +
> +static inline bool audio_format_is_signed(AudioFormat fmt)

And here.

> +{
> +    switch (fmt) {
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_F32:
> +        return true;
> +
> +    case AUDIO_FORMAT_U8:
> +    case AUDIO_FORMAT_U16:
> +    case AUDIO_FORMAT_U32:
> +        return false;
> +
> +    case AUDIO_FORMAT__MAX:

Same comment here re: AUDIO_FORMAT__MAX.

> +	break;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
>   #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>       DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>   
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index a0e542754e5..146026d0b39 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -62,23 +62,28 @@ int audio_bug (const char *funcname, int cond)
>       return cond;
>   }
>   
> -static inline int audio_bits_to_index (int bits)
> +/*
> + * Convert audio format to mixeng_clip index. Used by audio_pcm_sw_init_ and
> + * audio_mixeng_backend_add_capture()
> + */
> +static int audio_format_to_index(AudioFormat af)
>   {
> -    switch (bits) {
> -    case 8:
> +    switch (af) {
> +    case AUDIO_FORMAT_U8:
> +    case AUDIO_FORMAT_S8:
>           return 0;
> -
> -    case 16:
> +    case AUDIO_FORMAT_U16:
> +    case AUDIO_FORMAT_S16:
>           return 1;
> -
> -    case 32:
> +    case AUDIO_FORMAT_U32:
> +    case AUDIO_FORMAT_S32:
>           return 2;
> -
> -    default:
> -        audio_bug ("bits_to_index", 1);
> -        AUD_log (NULL, "invalid bits %d\n", bits);
> -        return 0;
> +    case AUDIO_FORMAT_F32:
> +    case AUDIO_FORMAT__MAX:

Same comment re: AUDIO_FORMAT__MAX.

> +        break;
>       }
> +
> +    g_assert_not_reached();
>   }
>   
>   void AUD_vlog (const char *cap, const char *fmt, va_list ap)
> @@ -172,141 +177,68 @@ static int audio_validate_settings (const struct audsettings *as)
>   
>   static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
>   {
> -    int bits = 8;
> -    bool is_signed = false, is_float = false;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U8:
> -        break;
> -
> -    case AUDIO_FORMAT_S16:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U16:
> -        bits = 16;
> -        break;
> -
> -    case AUDIO_FORMAT_F32:
> -        is_float = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_S32:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U32:
> -        bits = 32;
> -        break;
> -
> -    default:
> -        abort();
> -    }
> -    return info->freq == as->freq
> +    return info->af == as->fmt
> +        && info->freq == as->freq
>           && info->nchannels == as->nchannels
> -        && info->is_signed == is_signed
> -        && info->is_float == is_float
> -        && info->bits == bits
>           && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
>   }
>   
>   void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
>   {
> -    int bits = 8, mul;
> -    bool is_signed = false, is_float = false;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U8:
> -        mul = 1;
> -        break;
> -
> -    case AUDIO_FORMAT_S16:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U16:
> -        bits = 16;
> -        mul = 2;
> -        break;
> -
> -    case AUDIO_FORMAT_F32:
> -        is_float = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_S32:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U32:
> -        bits = 32;
> -        mul = 4;
> -        break;
> -
> -    default:
> -        abort();
> -    }
> -
> +    info->af = as->fmt;
>       info->freq = as->freq;
> -    info->bits = bits;
> -    info->is_signed = is_signed;
> -    info->is_float = is_float;
>       info->nchannels = as->nchannels;
> -    info->bytes_per_frame = as->nchannels * mul;
> +    info->bytes_per_frame = as->nchannels * audio_format_bits(as->fmt) / 8;
>       info->bytes_per_second = info->freq * info->bytes_per_frame;
>       info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
>   }
>   
> -void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
> +void audio_pcm_info_clear_buf(struct audio_pcm_info *info, void *buf, int len)
>   {
>       if (!len) {
>           return;
>       }
>   
> -    if (info->is_signed || info->is_float) {
> -        memset(buf, 0x00, len * info->bytes_per_frame);
> -    } else {
> -        switch (info->bits) {
> -        case 8:
> -            memset(buf, 0x80, len * info->bytes_per_frame);
> -            break;
> -
> -        case 16:
> -            {
> -                int i;
> -                uint16_t *p = buf;
> -                short s = INT16_MAX;
> -
> -                if (info->swap_endianness) {
> -                    s = bswap16 (s);
> -                }
> -
> -                for (i = 0; i < len * info->nchannels; i++) {
> -                    p[i] = s;
> -                }
> -            }
> -            break;
> +    switch (info->af) {
> +    case AUDIO_FORMAT_U8:
> +        memset(buf, 0x80, len * info->bytes_per_frame);

This doesn't look right - isn't this the signed version?

> +        break;
> +    case AUDIO_FORMAT_U16: {
> +        int i;
> +        uint16_t *p = buf;
> +        short s = INT16_MAX;
>   
> -        case 32:
> -            {
> -                int i;
> -                uint32_t *p = buf;
> -                int32_t s = INT32_MAX;
> +        if (info->swap_endianness) {
> +            s = bswap16(s);
> +        }
>   
> -                if (info->swap_endianness) {
> -                    s = bswap32 (s);
> -                }
> +        for (i = 0; i < len * info->nchannels; i++) {
> +            p[i] = s;
> +        }

I think this is signed too?

> +        break;
> +    }
> +    case AUDIO_FORMAT_U32: {
> +        int i;
> +        uint32_t *p = buf;
> +        int32_t s = INT32_MAX;
>   
> -                for (i = 0; i < len * info->nchannels; i++) {
> -                    p[i] = s;
> -                }
> -            }
> -            break;
> +        if (info->swap_endianness) {
> +            s = bswap32(s);
> +        }
>   
> -        default:
> -            AUD_log (NULL, "audio_pcm_info_clear_buf: invalid bits %d\n",
> -                     info->bits);
> -            break;
> +        for (i = 0; i < len * info->nchannels; i++) {
> +            p[i] = s;
>           }

And also here.

> +        break;
> +    }
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_F32:
> +        memset(buf, 0x00, len * info->bytes_per_frame);

... and this the unsigned version? I think they've been swapped.

> +        break;
> +    case AUDIO_FORMAT__MAX:
> +        g_assert_not_reached();

This looks more like I would expect, although possibly replace the case 
with a default? I expect that another assert() would have tripped by now 
with real usage if AUDIO_FORMAT__MAX were specified, but I think it 
would be good to be consistent.

>       }
>   }
>   
> @@ -719,8 +651,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>   #ifdef DEBUG_AUDIO
>   static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
>   {
> -    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
> -          cap, info->bits, info->is_signed, info->is_float, info->freq,
> +    dolog("%s: %s, freq %d, nchan %d\n",
> +          cap, AudioFormat_str(info->af), info->freq,
>             info->nchannels);

More dolog. Presumably this gets converted to error_report() later?

>   }
>   #endif
> @@ -1759,15 +1691,15 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>   
>           cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
>   
> -        if (hw->info.is_float) {
> +        if (audio_format_is_float(hw->info.af)) {
>               hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>                   [hw->info.swap_endianness];
>           } else {
>               hw->clip = mixeng_clip
>                   [hw->info.nchannels == 2]
> -                [hw->info.is_signed]
> +                [audio_format_is_signed(hw->info.af)]
>                   [hw->info.swap_endianness]
> -                [audio_bits_to_index(hw->info.bits)];
> +                [audio_format_to_index(hw->info.af)];
>           }
>   
>           QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
> @@ -1869,29 +1801,6 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
>       };
>   }
>   
> -int audioformat_bytes_per_sample(AudioFormat fmt)
> -{
> -    switch (fmt) {
> -    case AUDIO_FORMAT_U8:
> -    case AUDIO_FORMAT_S8:
> -        return 1;
> -
> -    case AUDIO_FORMAT_U16:
> -    case AUDIO_FORMAT_S16:
> -        return 2;
> -
> -    case AUDIO_FORMAT_U32:
> -    case AUDIO_FORMAT_S32:
> -    case AUDIO_FORMAT_F32:
> -        return 4;
> -
> -    case AUDIO_FORMAT__MAX:
> -        ;
> -    }
> -    abort();
> -}
> -
> -
>   /* frames = freq * usec / 1e6 */
>   int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
>                           audsettings *as, int def_usecs)
> @@ -1914,8 +1823,7 @@ int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
>   int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
>                          audsettings *as, int def_usecs)
>   {
> -    return audio_buffer_samples(pdo, as, def_usecs) *
> -        audioformat_bytes_per_sample(as->fmt);
> +    return audio_buffer_samples(pdo, as, def_usecs) * audio_format_bits(as->fmt) / 8;
>   }
>   
>   void audio_rate_start(RateCtl *rate)
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index e284542b2dd..72d6194033b 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -147,9 +147,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
>       qemu_dbus_display1_audio_out_listener_call_init(
>           listener,
>           (uintptr_t)hw,
> -        hw->info.bits,
> -        hw->info.is_signed,
> -        hw->info.is_float,
> +        audio_format_bits(hw->info.af),
> +        audio_format_is_signed(hw->info.af),
> +        audio_format_is_float(hw->info.af),
>           hw->info.freq,
>           hw->info.nchannels,
>           hw->info.bytes_per_frame,
> @@ -273,9 +273,9 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
>       qemu_dbus_display1_audio_in_listener_call_init(
>           listener,
>           (uintptr_t)hw,
> -        hw->info.bits,
> -        hw->info.is_signed,
> -        hw->info.is_float,
> +        audio_format_bits(hw->info.af),
> +        audio_format_is_signed(hw->info.af),
> +        audio_format_is_float(hw->info.af),
>           hw->info.freq,
>           hw->info.nchannels,
>           hw->info.bytes_per_frame,
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 40d7986b1d7..08bab353831 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -359,7 +359,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>       AudioValueRange frameRange;
>   
>       AudioStreamBasicDescription streamBasicDescription = {
> -        .mBitsPerChannel = core->hw.info.bits,
> +        .mBitsPerChannel = audio_format_bits(core->hw.info.af),
>           .mBytesPerFrame = core->hw.info.bytes_per_frame,
>           .mBytesPerPacket = core->hw.info.bytes_per_frame,
>           .mChannelsPerFrame = core->hw.info.nchannels,


ATB,

Mark.


