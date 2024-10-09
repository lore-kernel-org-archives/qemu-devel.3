Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21919CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syY8x-0006Br-Lz; Wed, 09 Oct 2024 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1syY8t-0006BT-DQ; Wed, 09 Oct 2024 10:58:23 -0400
Received: from mail-db8eur05on2114.outbound.protection.outlook.com
 ([40.107.20.114] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1syY8r-0006ki-Rm; Wed, 09 Oct 2024 10:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZMs2wU4yIb/gYo0qbXPo++gvRJ9GcGcdrMGuFthwA/bZF8VqHoWx2hb3mTGD7SIyQGN5DmG/75mCyzW6ZefWiy3fedhFVGkH1NsQMVfNddpZRJGX75hrS/XwfvslAYqDnRagm7g+kEc2nbp4Ye1dzYwieDR+zbOP4rXJhJFtfjOTiIEM9A2Ymw9g+jeWsmBWaFFGOCGZZpvw924es+Gzv0V0VxGPKSurkB/GwyjBekCam2BE5MPiApNDFClPnXbRh0dsBIneRlxmB+Gag1rqpn3WWv18B8xelFYOjw1iJ9NC/MpWT3gZpJSxzg1yqpQpz3mP0ighc747CWPZsfh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l0fNVRlEW1eWz7WiP0HXSNKwgaj2vnN0N24g2dKgBw=;
 b=VfyL8bsgQEnP1r7/VhXYem+e0rDRahSSqLyWsCIQ/aMwMeGmVCwnDa5GzvZK9UeyLBOTpp6x6VU+UMdNEi1krWCaONbZTzJsnfCrOdIbk5jLF8eI0vaBi7NT6LLqe6f9PoQRA59sRfY8h6V1a71/MldFKdgHzU4mrHZ2ctAivoT24eUzjWLrwtUk39etbSuORqwWSbNT3m1BStsxc/eCAi6VCQe4tu90gSTWT6rdJrF48EkC3xCH0V542RQZu6lu8mvTvWnGm0Mc6XZAwOg3VTfS+AXXYKG+yl/RUICYIE+/zjB6rXd+VoafzGS6fUUZC41HE8bIdpr07uPe8yr3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l0fNVRlEW1eWz7WiP0HXSNKwgaj2vnN0N24g2dKgBw=;
 b=ddyVdKdmZQM9NN+n/HqgHoleYXnbjVd8bHuYRBsJ+ILTDLI6fevIDxPc7XVwZ9Qn+loFJJBCs4ut7j/MNgb2K658fSdUecYKJ8Gwzlwg2/9eZsgM2wBgiyvDU/YOLW81LDEmF71DLXxaCXs1I+vmltnWiYCcLWpX/ThEPhnoub9JMjelYvOCrw3/Jq/QTLJBAHe77f5DDkLfySV4r5VLj8ufFc7h+MVDRLsncv6KRgr3l02iCyPkYSO9d9+QrpVlQmU1h26fB7zBzXxrKFnvcXUzlM57ZgoDQW769Fmqc3SiLkoB/vKpZnjppKY42U8OjiorOqAFX/sdHE2VuKUCOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAVPR08MB9882.eurprd08.prod.outlook.com
 (2603:10a6:102:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:53:14 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:53:14 +0000
Message-ID: <8a5a14a0-365e-4854-a39f-2de5134ab0cb@virtuozzo.com>
Date: Wed, 9 Oct 2024 17:54:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] preallocate: do not allow to change BDS permission
 improperly
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
References: <20241009140051.771660-1-den@openvz.org>
 <20241009140051.771660-2-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20241009140051.771660-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAVPR08MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd33036-c2e5-4d15-9919-08dce87219dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlJoUHRiQ2N4b2lmZVdyR3RzUm5Wa3gvUGRjaWpjVVE3YTE2dWNNL0VjYjl0?=
 =?utf-8?B?RGRkV1Roc3BvcEZNbCt2dkdkUWtQMS9Kc3dqckdqeHlwUk1zSTNmb2Y2Q2tS?=
 =?utf-8?B?c1MyS2pmUkZZYXpWMDZybGFyVEtJa2xZWTk1TEo5SjFhdDRwRTIxUHg5dHRk?=
 =?utf-8?B?SDRxUzE4Qk13RjN5WmxDbTV1Wkt1aGEzMmp0NU5XQTNhTTF6L2tUMnVhR0JQ?=
 =?utf-8?B?aFRNNmFzRkpWM2owV09GUEFzWldycUY0M2NJNTFwbFhBYlZxK2trQmM0dk9l?=
 =?utf-8?B?aG04Y2Nya3dJa1VINEFHYjUrSEorbUUwT3VQWEVvN2dyNHkzeTEvM3BlQWZK?=
 =?utf-8?B?b1NDbU1XdUpTT0xCS1VSYUN6S2tBK2VXbHFuelJ0aUJhK2VxVGJrR2JydnIr?=
 =?utf-8?B?d0lyanoyTzlZZlBEUkVsV09NVkNpYitlVzBzRHRKQ0hVZ3J0TjJxYk5uQkRT?=
 =?utf-8?B?cSt1UmI2enZzVTRZazIyTm8rZklRZzJuMlVMWDJ0NTFjVWlJdHAvTzdEQjJP?=
 =?utf-8?B?TG1rdXJaUVRadUpyb3pqL203NW5QOVFCMkFHRGoxZEZKMjh6YUhhN29Cekkw?=
 =?utf-8?B?QXFIZXo5N3Q0Zmp3SkZJZEQ3aFZiWXJuUXNDRU4zQWR2ckVUVXEzTVF2c3Vt?=
 =?utf-8?B?N2ZFeldGS2tjMEdWby9TeE1PZmZXbmFEcWtaR29uOGJwQ1BmTld1MWtDTWp4?=
 =?utf-8?B?R0tZcGdjMVplVDBLWDFoU1JoSHM5cTRjV3hJL2VSVE0xL3M4YXpiV2I5aE1I?=
 =?utf-8?B?MVdOcDRyZmhIRll0Ym03R3p4eXBsZzF5SzRMZncxRVdYMk00Ukd2UlRyVkhC?=
 =?utf-8?B?SU5ROGhPa2JuazliZWJSSm1KMnUyRG14YWJMdk9CUXg4SFI2cUthcXdDNG43?=
 =?utf-8?B?QzZUSVgvRXo5Zk9kVGZ4bWJNUEF2RVRsdFdrbEZTWnNxSnV0a0l2QUtUZWNN?=
 =?utf-8?B?RC9SOVdEWFFiUXZtQ056UjlqMGsrd0JWR2VheFJJZ0o4YVdLZlcxWTQ1SzBq?=
 =?utf-8?B?T0tOTngvTkVBN2NkSlpzWExUT3hBSXg3bDk5MlBqcW5HK25qN29tNnZZYWJn?=
 =?utf-8?B?bmZ2eDE1VTZiV3M0aCtZK3pLZEtPcmJoTWdDRDIyNTN3R0UwVW9xMG1FZmo5?=
 =?utf-8?B?THR1TEVDZmZpekk3TUl6Wkh5YnVrWHhNR0hHdld4RmY1RG9CRGk4OVphcURt?=
 =?utf-8?B?VTI4MzFLdTNoTFp1ZlljNGZ1VTZTaGRvUGdhY3U0SjRkZGg0ZHplRDluWkVk?=
 =?utf-8?B?UUo3SVlzb0hNZEVmeVNrZUNQUUJQcUp1MnFGbEIyd2ZDSkNRYk05S1VOZUY2?=
 =?utf-8?B?RzhCTGJPcmpxVUNPcmYwc29ReXU1dTRGc29keGQxN0psdStxNFZkUWl1OGlv?=
 =?utf-8?B?TDRRcmN3amovUXVvKzVtSzFvOTRXTkVSQ3JnRTczdStBS0NkTFZrZXFiT3E0?=
 =?utf-8?B?RzVlM1AxKzhOMGpYbW5Wd0RwWFpSS21HQ2NxSnlvNUtZTVZYMnp5MW9hTWtK?=
 =?utf-8?B?aHM2R2VMSXp3dzBwTkZBTmlBOGRtcnMrQWVxdGlSdGFST2lGVUh4T2k2dndM?=
 =?utf-8?B?aHN0N2VOYTNiT0JORkdwU2F2Vm5oQlV2SFNqd2gvOW1Va1hHRHROL21KMHll?=
 =?utf-8?B?UjdrK0svSDYzekdkRHRCSTlDcFdKaDJxODRXck9lVXg5SWR2YmZOMkc2UlZn?=
 =?utf-8?B?NTIyNHhocWptallYU01TZmpiL3habWZMWXI1b01KVWZvTWtFSGNGN1FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b012MFBSR0FiVkVwWDB6bVpHMnpjZjMwSzJaa01TbUl6dmRnT0UydFpkdFh6?=
 =?utf-8?B?WG91NkxOUDhPYU5pUGVubVl5dDBKcEFzUHFKRTNVU0gzZmlSSkxVUGFyYk1u?=
 =?utf-8?B?RWl5aDE5TDFGaW1acS9LNUk2NFczMEQ1cXhMVEx1UFRaQkdiVVVHeEUxemVy?=
 =?utf-8?B?dDRjODJXZHhQT09kZnNyMytyL29BY0ZuTng4K1BIUkNvcTQxY1I5QkppMUdQ?=
 =?utf-8?B?eEZpOTUvQS9FZXRyNHYraGplQjhaNTA4RjBxaXpXWHNNZWxnM05ZVy8xYVI0?=
 =?utf-8?B?QlNHMlpZTmsvd3h6alBkZlpLTndlTGFMVzYwb1VUSUtucGtJb0QydC9TYlNx?=
 =?utf-8?B?RmkvL2ZieUN2dU9OdzZkUnBGSDdTU1dFWmR3b1R3MFBLQ3IwcjV1UnZINzgr?=
 =?utf-8?B?MlFGVUdBZ0JMdkhiS3piNjB6V1BEMHlOYnI0WWprUHo0NmhSZWJTcnRnVFIr?=
 =?utf-8?B?aGVndUdQaGVtZUc1RkRoRkdtbHV3d2pGYkZucTl2TDBLbWhZQStra0JuZXZm?=
 =?utf-8?B?Q3NTeTZpS1ljNWlOK3E4amZ1OU45YjF2R29yOVpZV0ZaQ1FSZkJKZkZJTXJn?=
 =?utf-8?B?bGUxVnkxemF4ODlTcm5wekZrOW4rSWRQYXJkQndFb09wSms4SjVFV3ZSZWdi?=
 =?utf-8?B?UW5yZlFhT2c1S0dTdG5iSUlUeG5jak1sZy93NGZQRGZraU1NMHFacG1xU0do?=
 =?utf-8?B?WitQNjFUQ3V3UUhmd1JUb0pkd0F0dFJsTUV1S1VTNFNKT3Z5Y1kxd0ZoZm1V?=
 =?utf-8?B?RWdTK0gvNlZ4QlpzWFdlTDR1Mm82cS9QazR3dXd5WlJUTVhvOS9veG52Y3FL?=
 =?utf-8?B?dnpZWjJXRFNwUUoyUlk1NElKR0xxRzhIVmV3SC9SZXozL05GcjlaNDl6NHps?=
 =?utf-8?B?UEpDY25FL1ZsQXk1WjNnc2NqdTIyMUNZeTk1aXZseVhjY1NBL1lGM3lIOXZM?=
 =?utf-8?B?OUJxcWdmTitJWG1LbHdhUys3UFkvMFVhVUcwUk50S0N1ODV6SEZxR0s5L3Q0?=
 =?utf-8?B?c1lNRUNaVFk1VVk1YndsL044c0FwZlJ4MXhvRnZhZmlSYUNJSWZPeDVJNEp2?=
 =?utf-8?B?SThKRTRQeUNiSzJpemJNYnlVSElYNjBxeWdqcTJ6aHo5RGVwdmo3alV1RHVx?=
 =?utf-8?B?ZnBZUXV1cHdtV1dIdXExZTlxaWdYcVlvK1VvaGlKaFNRci9EVVdpN2JYUGJK?=
 =?utf-8?B?Y1hoQ3QzUE5VaENwaDhIRTRNeDhxRTB6eis1QU93cmFzc2J5U0lObHZaNTdV?=
 =?utf-8?B?NjVKYlJFMXA0ajBLcnk2K0hkL2RIWmxEU3Via2hFMG5COVEybVBWUHJORU9j?=
 =?utf-8?B?OUtOZC81SlVXV1hYaVNVaW80MTVFWVFnUnhXci90SlRpYWw4aDJtQkUxUnB0?=
 =?utf-8?B?eTE0d3NyNVRvWDJlajBMd25BUnY2WGN3dEhoa2V0eUFTcWFMRUxiRzZLeUVt?=
 =?utf-8?B?RnhGbVJDSmg5QzdWS2w0aGs4RTkydVAvY2F2dTAxbFlkUlBEYjZUMDg1V01M?=
 =?utf-8?B?ZWdBak9KcmJOVWd4bmdtS2JocUF0czRPNnNaM05rSDdpckxsUm13eTFCK2Er?=
 =?utf-8?B?SXR1RmtIRTRPTkp6R1Z5SzgzSVBZOVlVeFpIbjRKM3dOWWNraDZZTHh6WmRr?=
 =?utf-8?B?S2l2MlVMb3paZ0tZRzRvbnBSMGhpWTU0NTNpS3lmVTZSMmthb1VTS2NIQWlq?=
 =?utf-8?B?K2FpN1hVL0FaQ1QxZXZycW04QzdnTUFIczNONmo2NjJuY0x1L2NmTm51ZDRv?=
 =?utf-8?B?ckxxTUxxTHFtRU54L1M3OG9CTEMwNG5jWjhldjVyTFEvd2QzZDVoays4ME90?=
 =?utf-8?B?Q1F4YVB4VGkxRUNJRXg4Um4xSUdwWFdOeGoxQW54aDNIMElUVDZVbGp6eGJU?=
 =?utf-8?B?cE1DYlNqZFB4QnZ6OGl1WHNvRjBtakVVai9aUHA1WUpvY09qY0VuL0J1Z0Ni?=
 =?utf-8?B?akcya0drYmc0TlptMWNDV1pidFNNZnpGb0ltS0s3TG5VWmdLUFczNmpUTStv?=
 =?utf-8?B?U25oT0Z2NlhsSEFoaUpxdGlkK01IaDV5ckRJVytseGtzWURxUTlocWxSaWZm?=
 =?utf-8?B?MStMUEVLWGwrZ284Y0Z1djJ6SmYrbmxKRUw1TTMxTWtWSHFxZ3ZrWnJ3Mnpw?=
 =?utf-8?B?Z0lBNWZWTkpvcEkya1hCZEt6ZERUbG10TnFjR2VCMU5iaUN4ak8rVnBMYmVV?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd33036-c2e5-4d15-9919-08dce87219dc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:53:13.9091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u92fcH16axMC3p8dHo4aWbJ32Y+LnBHviA+8TCy23XojQxlyXXbTBvCvRppR8+3a8LXQ6N94EoaL+NrUYI7R1DY6l2Cr5BXiC1dvORcym9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9882
Received-SPF: pass client-ip=40.107.20.114;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 10/9/24 4:58 PM, Denis V. Lunev wrote:
> RW permissions could not be lifted from the preallocation filter if
> truncate operation has not been finished. In the other case this would
> mean WRITE operation (image truncate) called after the return from
> inactivate call. This is definitely a contract violation.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/preallocate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index bfb638d8b1..1cf854966c 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -581,6 +581,17 @@ static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
>      }
>  }
>  
> +static int preallocate_check_perm(BlockDriverState *bs, uint64_t perm,
> +                                  uint64_t shared, Error **errp)
> +{
> +    BDRVPreallocateState *s = bs->opaque;
> +    if (!can_write_resize(perm) && s->data_end != -EINVAL) {
> +        error_setg_errno(errp, EPERM, "Write access is required for truncate");
> +        return -EPERM;
> +    }
> +    return 0;
> +}
> +
>  static BlockDriver bdrv_preallocate_filter = {
>      .format_name = "preallocate",
>      .instance_size = sizeof(BDRVPreallocateState),
> @@ -602,6 +613,7 @@ static BlockDriver bdrv_preallocate_filter = {
>  
>      .bdrv_set_perm = preallocate_set_perm,
>      .bdrv_child_perm = preallocate_child_perm,
> +    .bdrv_check_perm = preallocate_check_perm,
>  
>      .is_filter = true,
>  };

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

