Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A91C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawb8-0002Ze-1S; Mon, 05 Aug 2024 08:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sawb6-0002Yc-0C; Mon, 05 Aug 2024 08:13:56 -0400
Received: from mail-am0eur02on20715.outbound.protection.outlook.com
 ([2a01:111:f403:2606::715]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sawb3-0000gu-6T; Mon, 05 Aug 2024 08:13:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULqf8psgbNGiRYoknZRBsg+bjWZutYDyNHHUoXJYTERuXK93BnAI/0O80lDyUOlcHreAPZBIEsaBRiZcWa5ut4HKuXDxaJvnrD2zPWhFHSRUOYC8sT169SJMsZyqdebCCEn05iW8gVcn5brMemHootpujdsKGPAB1jFCi9bt2yIP57DVPLw3RecG5TSuVg7WbbAG4PaxkE8caZJZ9lLNn45VEuCMRQsfHMIUGxdiLp5Nxz9P+RJQALleTPFnbPZHoaj7SXH/cAv1dgOw3Oqa/sPqu43iyJ9vo89JmA1JNzq54yiGYanqhez4OIvp85vWYzqZAB+wIblMe/RHxuBf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGCOv6aNVbuVn1pOZbOqRe/B6Ypayd+sX1D/WT81CQI=;
 b=dInsgpNXxNoznnTgi1L+U7MXRo3TRGkRehjwFcU8AMOiquxWERvPSH47MiyaVnnZhT+r/2GiedHWAKByWZCOXamqPrEohgEU7gRn++6yfoFlr6H4/+Qu26FSSshx26vM7HgYIg3yAPelGkQ9Gj7sUyqcD98PAs6ns5/hJEw0fPSITN8gDhHwdERpocIcXw0X4EboPLj03/L/nj/j9fXQZ4v1pfPl0snTAg3v4gFPcxC8OhkA5QevxKJAoPj5v+juN1GfNlI7d3NmyoFj1sVGmLHuTHpsKHdqfaeCsmoEEynnGKve9shPTbPx8ldY0rhGzfeWugJgmaaAAq1T/Ecmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGCOv6aNVbuVn1pOZbOqRe/B6Ypayd+sX1D/WT81CQI=;
 b=lP4+Ly23OKD1pFTkwiP3cZSpcm0AZt21tpzDZCiECTF/IG8kTnAqAqRRIk+fe9MDsWhtd7V564Z76+sF96iwX4byLD1giJXAqVKrrfW0rDQxTJL3Rtw/8U4cwQ8IUETiqapMdMZL5TcO171f/X69io10EU3vMdp6kJ1mHYsSc5qs8mFVI8D60mT+wnnOEohAWc0RmNRZq/dH3BjmD41zuxoHA9bGVzQDV0PCSmxoXkGQQjn+VOZMc8mceIpkONUofsZ0FUBysTfRHuEosoWtkBZ9kqph4+1sPtZIUUAUmBRnIkTx8/td3BmQQox8cqKchyDra+lfglQIib0dNGtR/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS4PR08MB8167.eurprd08.prod.outlook.com (2603:10a6:20b:58e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 12:13:45 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 12:13:45 +0000
Message-ID: <19c69ed8-7788-474f-93fc-8a4568d2c32f@virtuozzo.com>
Date: Mon, 5 Aug 2024 14:13:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] block: zero data data corruption using
 prealloc-filter
To: Kevin Wolf <kwolf@redhat.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, hreitz@redhat.com, vsementsov@yandex-team.ru,
 pbonzini@redhat.com, eesposit@redhat.com
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
 <Zpk5-GDaqmD4c-EF@redhat.com>
 <03492477-fe98-4a3d-a892-7c6a143ee048@virtuozzo.com>
 <ZrC-liyd3CL0LXlq@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ZrC-liyd3CL0LXlq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:118::40) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS4PR08MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 799a3142-ae7c-421f-1cac-08dcb5480df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3FiazVsd3dFMTR5WnpjYkNyYmVCdFRWUEVnSTA3cmJtSHZtVGZPMmZqOFJQ?=
 =?utf-8?B?QytnNTVsem9Zd0dtNU9QOFY5ekZBQUtHK3g2UjJHbWdNZzgxTmlJanVPYTNE?=
 =?utf-8?B?YmVqNXhWUEVUV0ZvbjJhdGRHaUdjd2NZekVJYkZlZXVWdUY2T3FvbWtHU2pG?=
 =?utf-8?B?T0hGZEhqVEhUaGZrc3l2dnd3MjZUSkp2cThqeGd5U3FjdUJXMDExVjZFblM4?=
 =?utf-8?B?L3ZIUGU1c2N6OHNZYUZyMzFlTi9GNGE4bDNKdnYzcDlYZGZpMFRPVlFCRjRn?=
 =?utf-8?B?bGhoNHVTZStZMlp5cWo1c3kzM1d2TE1vZjJQVW8yczYxeGRucXVWU0JPZFJE?=
 =?utf-8?B?RTNFY0duVHdsOCtMWmhiQkVWYWZleFhKbWRJdURGL3BZNittbHc3OHp3dFFK?=
 =?utf-8?B?eHI4Y3pJLzZ6S1orTm5lRXZwOGIxZGdwWTJHMUFVNDV1OUd6VzV0VkZXTkF5?=
 =?utf-8?B?MVEzOXk1am9LWmFRTzh2OC9iNXZNcUU3VEgwdlZKQXJHcnJhRnFraGczbDlR?=
 =?utf-8?B?OW5zYmZRK211OTd3UTM4QlBpNytQekJUNkN2WUhTOEhLbUJsejdwNTE4Tk5L?=
 =?utf-8?B?VHl4OHRzTVB5V3BmVE5kRzBCMlZqUDJURWkzclBacDF5NHhPRjVqRS9SVXov?=
 =?utf-8?B?ZEFZdk1IbnN1b290RlE3eFlKeDYrYlUyNVdSUXFrSFFaTnVMaFBKS08xMm5k?=
 =?utf-8?B?SWpLWUR1MXdzWlFUVDd5dXdBSE8vYjBWTnlHVHVna0M2MmtvK2o0eEM5T01a?=
 =?utf-8?B?cmc0Tngwa1Bsckg4WlRZMmpJZzRiVjRUdDk1VkZ5N2dFQWxJZGNxblhZandW?=
 =?utf-8?B?bXJ0WG9pV0NnRmdicUI3SGVBWWNHRU9leFdzOGF6ZERQd0liS2dVeU9FQjRD?=
 =?utf-8?B?L2FDSmtrUjNSNkpXVzVCMEpvaHFMQXJrTGFtclpRb3lLSGtrQlVqbGdwTE9w?=
 =?utf-8?B?Snd6aXhQL1BPcmcrSlRlaXVjZUh6NXZ5R0NndUZpcjFHWmtIT3ZJSlJwWDBC?=
 =?utf-8?B?KzZiN1VvdDFkWW1JcWEvMXg1QkRwbldudnBhWSttdEV3RlkxNGdvV1F4VitY?=
 =?utf-8?B?U2VpOENxVEtnQkZTMnJwYjM4TCs3ejl4OHdya3NOeXlDU1VxNVVoKzRQKzBL?=
 =?utf-8?B?dlpSSHZ3TkhhcFZFNHFiZlRObVpXYThncXNrYmpOb0JjYTVHcTRvRVo1VDJE?=
 =?utf-8?B?WlVnWk9rcGlZMExtKy95YU9UcXVld0loYlRVcG03MFVXSHVuQ0Z6TFJiWmtW?=
 =?utf-8?B?M3FVaHplUFdEVE9JYVNFU0VEWHVuTDFCR2liS0t2cUxFSDFBbUVERkhzQnpl?=
 =?utf-8?B?MDBXc2w5eUcvbVYxZTVPWXJHNXdYeUtiUE5wakJIcVhBOWhkTXV1eEV6MGZs?=
 =?utf-8?B?Z2c3SlNONC9kWHRoRmdtWHVRRHRqSGpCZVFkOUZiTkdvaVhHN0toV2tQcnJN?=
 =?utf-8?B?WVZycytVMWtpK3VOMXZqaG5POXNkb09XSXdXK0hHSUt6eWczQi9iWS9lTVJm?=
 =?utf-8?B?MEkxdVJJRFgxZndIMkdwRXp2bEZiUGhsZ05NV3JzWURSY0VuYnBzdElvby9h?=
 =?utf-8?B?UGlDeWZUOXY4SC8vOVQxNmdVYTFaa2tnNVd5QTFkdlhzbk5hb253bUFMTWlS?=
 =?utf-8?B?YXBrVG9STmVRWFR6WmIwcW0zNXZXbUMwMWcyMTVmbkx0eit3cHNiSkJWbkRC?=
 =?utf-8?B?WHQrVUhsYU9MbUlHbUd3T0pHdGpZaUJpT1FiMUxTWmJYUDA4MTVwbjQyYWlU?=
 =?utf-8?B?bUovSHRTcWJZQVA5bVFnRWtwbFFQWmsxT1duQ3FlYjE5RXBJL1RZQTdDOHF6?=
 =?utf-8?B?NWRoWTRLNjI0WHhIUjlpdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdSUzBidjlNVE44VVZ0THBZZzJTZk8xZVZKZUsrcTFzNWVUdjdPdlB3c3Fq?=
 =?utf-8?B?YldSckZvT2VMSDNwMTJoV3FtNEdwRTZnZHcvcHNrZFJINXJJb0F0SEZkZG1I?=
 =?utf-8?B?RU1nOWNZdytyWmZpem52c0ZobWd3ak5QMWMxcXR5TmVaenZuYitERENiZTc3?=
 =?utf-8?B?RjRvZVNEYS83WHV6WEVVT3JxT2hFRXBUenBRd0FMTTVhN0NNT3JiUFMrYUlP?=
 =?utf-8?B?NTViUWhjcTUyc3h6SEVlVURpR0dUQW1kbkFrdTdJdUt0eUgwbUdNNnVmTjVN?=
 =?utf-8?B?T2hLRW9CVHYzZG9jdzRVUVduUUNJbEdaOE1MTWtjMUpIZW4wN3pRZXQ1RHdN?=
 =?utf-8?B?enI1elAwSTFjOUpRUTdjWkpUd1U0SDFwdk9CdzlnWkZYN3NWYUJqSCs1MXVX?=
 =?utf-8?B?bkUxY2V5VzliQkNSbmNQYlV3K1JEVFp1bzFnbUozVG5UUTJ0S05qdmJ4VkxO?=
 =?utf-8?B?K3o4bXk1QkxROVdwVG9wTWw0eGdDV0ZGcE1zOGtZZTdQaVh2Vi95dUZkQ29a?=
 =?utf-8?B?Z3VUSjJPZlUxaWhpa0JBNUFFZkxOUlBWMFdBWFZWL0RwK3dweC9ZUmh5MlNU?=
 =?utf-8?B?K0RDRGdkQ0JyS1l4ZFNPcWFzYk5QWVRzb3E2T0ZwYmpaQmsyNzA1N0ZadEJV?=
 =?utf-8?B?YTF6aVN6K3JNdFdaMncyM1FlS281aGp0Y3MwUGs2dzZiSUFWanBBVFoyTHlI?=
 =?utf-8?B?ZE12R2pZYlJPZUh2ZjVQWm43UnNqZFR1T0VMYzV5SGRkK3c0Z0thcXhZQ09r?=
 =?utf-8?B?QmxQZDl1MzBvcXJrdnhwYkFXbTNaWXhOVzJQYkJRVG9XU2lBdk5uQ01YRktR?=
 =?utf-8?B?VGVZV3NaaFZtc3Z1bmYwM3lmMXNUeUdidnZXeDQvWGMxUmYxRGpON0dEUDNx?=
 =?utf-8?B?ZEVyQm9KdDExank0YUt2cW1yVG5zRWhHQmZQc1Z5ZU14WVp6NUE4ZHZqQnFC?=
 =?utf-8?B?SVYxVkRuRStFYU1odjMxbnV4eEpPVEFJOVMzQ05PM1hTeVFQWlpmb3RjM01F?=
 =?utf-8?B?RG1tM1UyTkN6ckMwUytVWG53MWxxNnpYWkp2dDdPaEtBMHAyTlB5WDhDelZB?=
 =?utf-8?B?bnhndWhqYlNzcmo4a3VUZUFob25SZi95a0szNEhGb0ExUFBpeEYvcDNGQi9Z?=
 =?utf-8?B?dmtnNmhKSUhqUlhOdm54OFF5VzF5QmJLNys1QVNFamJycy9ZUEJLd09ONDQ3?=
 =?utf-8?B?T01UOTdCVmp4UHVzRUFScnlPMEJ4c1Y0S3htOWc2UHZBejcyZ3piaEsya3da?=
 =?utf-8?B?aW03WmJDSnE4RFdMb3lVT1ErVFhvVVVoalJxYm1wbmhpckxIVjFaN0xRTE4x?=
 =?utf-8?B?QkwwREQvWjA4ODFGWHRzTUdzL2twVWhRY2hmQ1IzcmFXVy9nUGdlKzFUZHhE?=
 =?utf-8?B?TSs0VGFyeFAxZithSzBpR29KQ3JCVGl4bVB2VjRTMUYwUGliREZqYkVyQjd3?=
 =?utf-8?B?OGVuSVh2UDFOMG5VQmZQaEZaVWJoTW9xSjl2Q2hwMkkwM0VYaTJUQVgxRE10?=
 =?utf-8?B?SlFpNmhEcUgxNi9tMHpyZmEzdU1LajdLVjl6Tk84KzNramhrbDJCd2VpeTFN?=
 =?utf-8?B?WHRCaTRCekJlWmI5SnprRjduZnA0NkhOa3A5UUdYWDlnUnl5ZWtSV2d3c3dN?=
 =?utf-8?B?dmo2NVBVVEE2MmcvWms5OG1pSS8rT2tIZXRNalp3Q0EwUENBL1NzK0h2YlVI?=
 =?utf-8?B?NldJMlN4eGdhOE8wOWt2QzlzdUplV1R4b21INHZMV3loQUZLSW5LS3hibWFS?=
 =?utf-8?B?d3NYa0NyZnVMSFZVV3R0RTFvZ2h3Y2Q2OU9CMFVuMi9HaXhkakJkb3pEbVJl?=
 =?utf-8?B?Y0hDS09SQTYzWU8rSDNReC9UVWpRaW01UTJHdFBRVWxvd20zenM0S3pSZG9K?=
 =?utf-8?B?KzMvd29wUTRyTG5SRzFVNXhIZlJONEM4TEhscU9ZRXdRV0ZocExwanh2VkQ5?=
 =?utf-8?B?OFpCdDRtSURvZkZiTjNLbEhCcVR0M2MxOVcybTJKd2dqRjhiSmNWalVISFlL?=
 =?utf-8?B?SERMd1hQNWROVGxIdXNzUWR5bXB6NjQ3VTRtOHQxbHhrcm1KN1BscWpuNUFB?=
 =?utf-8?B?SjVtSFJCNXhvemYxNjIvUDRxWTRSNUI1Y3NlOW1mWUFsODZ2REhqWW9wdTJ0?=
 =?utf-8?Q?FS3Lh/xGZDabZaDexLzlFioLq?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a3142-ae7c-421f-1cac-08dcb5480df0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:13:45.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC9zGmzmIOmAhUzqLIf2B6ICnx5Efw1w3q4m48ZP1TJO5OCZghShNeGP5jumruoFxtfpyh01rPur2oFcNR3XHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8167
Received-SPF: pass client-ip=2a01:111:f403:2606::715;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

On 8/5/24 13:59, Kevin Wolf wrote:
> Am 18.07.2024 um 21:46 hat Denis V. Lunev geschrieben:
>> On 7/18/24 17:51, Kevin Wolf wrote:
>>> Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
>>>> From: "Denis V. Lunev" <den@openvz.org>
>>>>
>>>> We have observed that some clusters in the QCOW2 files are zeroed
>>>> while preallocation filter is used.
>>>>
>>>> We are able to trace down the following sequence when prealloc-filter
>>>> is used:
>>>>       co=0x55e7cbed7680 qcow2_co_pwritev_task()
>>>>       co=0x55e7cbed7680 preallocate_co_pwritev_part()
>>>>       co=0x55e7cbed7680 handle_write()
>>>>       co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>>>>       co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>>>>       co=0x7f9edb7fe500 do_fallocate()
>>>>
>>>> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
>>>> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
>>>> time to handle next coroutine, which
>>>>       co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>>>>       co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>>>>       co=0x55e7cbee91b0 handle_write()
>>>>       co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>>>>       co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>>>>       co=0x7f9edb7deb00 do_fallocate()
>>>>
>>>> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
>>>> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
>>>> the same area. This means that if (once fallocate is started inside
>>>> 0x7f9edb7deb00) original fallocate could end and the real write will
>>>> be executed. In that case write() request is handled at the same time
>>>> as fallocate().
>>>>
>>>> The patch moves s->file_lock assignment before fallocate and that is
>>> s/file_lock/file_end/?
>>>
>>>> crucial. The idea is that all subsequent requests into the area
>>>> being preallocation will be issued as just writes without fallocate
>>>> to this area and they will not proceed thanks to overlapping
>>>> requests mechanics. If preallocation will fail, we will just switch
>>>> to the normal expand-by-write behavior and that is not a problem
>>>> except performance.
>>>>
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>>    block/preallocate.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>>> index d215bc5d6d..ecf0aa4baa 100644
>>>> --- a/block/preallocate.c
>>>> +++ b/block/preallocate.c
>>>> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>>>        want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>>>> +    /*
>>>> +     * Assign file_end before making actual preallocation. This will ensure
>>>> +     * that next request performed while preallocation is in progress will
>>>> +     * be passed without preallocation.
>>>> +     */
>>>> +    s->file_end = prealloc_end;
>>>> +
>>>>        ret = bdrv_co_pwrite_zeroes(
>>>>                bs->file, prealloc_start, prealloc_end - prealloc_start,
>>>>                BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
>>>> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>>>            return false;
>>>>        }
>>>> -    s->file_end = prealloc_end;
>>>>        return want_merge_zero;
>>>>    }
>>> Until bdrv_co_pwrite_zeroes() completes successfully, the file size is
>>> unchanged. In other words, if anything calls preallocate_co_getlength()
>>> in the meantime, don't we run into...
>>>
>>>       ret = bdrv_co_getlength(bs->file->bs);
>>>
>>>       if (has_prealloc_perms(bs)) {
>>>           s->file_end = s->zero_start = s->data_end = ret;
>>>       }
>>>
>>> ...and reset s->file_end back to the old value, re-enabling the bug
>>> you're trying to fix here?
>>>
>>> Or do we know that no such code path can be called concurrently for some
>>> reason?
>>>
>>> Kevin
>>>
>> After more detailed thinking I tend to disagree.
>> Normally we would not hit the problem. Though
>> this was not obvious at the beginning :)
>>
>> The point in handle_write() where we move
>> file_end assignment is reachable only if the
>> following code has been executed
>>
>>      if (s->data_end < 0) {
>>          s->data_end = bdrv_co_getlength(bs->file->bs);
>>          if (s->data_end < 0) {
>>              return false;
>>          }
>>
>>          if (s->file_end < 0) {
>>              s->file_end = s->data_end;
>>          }
>>      }
>>
>>      if (end <= s->data_end) {
>>          return false;
>>      }
>>
>> which means that s->data_end > 0.
>>
>> Thus
>>
>> static int64_t coroutine_fn GRAPH_RDLOCK
>> preallocate_co_getlength(BlockDriverState *bs)
>> {
>>      int64_t ret;
>>      BDRVPreallocateState *s = bs->opaque;
>>
>>      if (s->data_end >= 0) {
>>          return s->data_end; <--- we will return here
>>      }
>>
>>      ret = bdrv_co_getlength(bs->file->bs);
>>
>>      if (has_prealloc_perms(bs)) {
>>          s->file_end = s->zero_start = s->data_end = ret;
>>      }
>>
>>      return ret;
>> }
> I think you're right there. And the other places that update s->file_end
> should probably be okay because of the request serialisation.
>
> I'm okay with applying this patch as it seems to fix a corruption, but
> the way this whole block driver operates doesn't feel very robust to me.
> There seem to be a lot of implicit assumptions that make the code hard
> to understand even though it's quite short.
>
> Kevin
>
There are a lot of things to make a change. I'll definitely
have to address this later. Working on that.

For now the patch is working in downstream and it seems OK.

Thank you in advance,
     Den

