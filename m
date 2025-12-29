Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFC8D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 09:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va9Jm-0005Eo-FP; Mon, 29 Dec 2025 04:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1va9Je-0005Dr-7Q
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 04:13:26 -0500
Received: from mail-norwayeastazon11023101.outbound.protection.outlook.com
 ([40.107.159.101] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1va9Jc-000297-DW
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 04:13:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhsoXOm7gNaEAjHhyLhW/fl3IDZEf2rOy+O28JMVykkEkZBML7GckoeRoPEZ0ORT8Kwpyqte0A8+cWzzmBb+ekoHiwVQ+DyI1Bdi2S7IIYk/muCZpKo4AMNW76bSIPwrCahJqGvgo2ozJrI0E3oYkgKtIs/fxHnya7pG0QtSEs/4EghsaD8qEiRBefh9Ni2vfYtSxUkODQmJyTx7BZq87qju3Xt0jPINbL9g6R12M8NgP2cpcCcqdR+IOM2gKyd4AOvrvsZ++ncAzRRSJOsAS3VBCXKZXYrsMuRkaAXmilSMOnRwMDVMMc8TA2+Vle9827JwQsVBY7WpWuEewhdXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h82+73vlSTLl3DsqwVCa/vuEL8YtDp1Hmho8R2qc5lE=;
 b=aiIYukFjn5oIIFrQGL5o/jAlP78McONDDQiV4HZAkj8IGL/2U8icChXwmP5xFa8oKySL8p/zmj8QKsIo3U0xIayyPXdBATF4R3IjMBU9+O+/VbZRGOtu7DG6M6IvS6PkSG54cMIq704juUXyW5K2c3vUg4qFD77FDXi3om+KPuAXC7SlWjn4Ue9TEhX0MK7gNCOlFJeVD4FB/S0acJDIzmET+AeIV2X7Ia6eJhKqgFZZSBZQxkb46mXIBshF2Bk82b7vIkd4PzQxHawMhv6gu28mc+rM645/520zwIAD1JzjnD5PSp8LQ63s+JlkjR3yYXjPxBsDVnFqkH6jkGNfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h82+73vlSTLl3DsqwVCa/vuEL8YtDp1Hmho8R2qc5lE=;
 b=gABo2zyukLIh9ZR7aYJ2V6jd7M/TmY1ilovQIB36J+aWuNwgRqt811x0/00IEgm5Lxc9Y6QlG1jxtD/xyQYvV4Itz4KiybwSQj9ffSE0MTeh3vCu06M/z+69PWlYLNf9BvPPxXSM+gxmK8v5RxDUDZWDLghn2vseC2SKAnmDZ4czRhB+w3UCYKtAKKr9Zag0bVTC0+ta5Gf6L8YTU90T2txGSn2Z56JOU0Jjjb8zmv1BXeaNxSl+QoJKY5UWwcUXoST5xnPaIbkZOp0rAtOo5GtuxRt6sS6NwKMJgXYnLA5+spW3EiplcAa5D/2VgXN3nKP30vw5FahCgS6XLwi0Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9586.eurprd08.prod.outlook.com
 (2603:10a6:10:454::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 09:08:18 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 09:08:18 +0000
Message-ID: <f259cbb0-74f7-4cb0-b30a-4476dfb70c40@virtuozzo.com>
Date: Mon, 29 Dec 2025 11:05:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Fixes and improvements for scripts/qemugdb commands
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0007.eurprd08.prod.outlook.com
 (2603:10a6:803:104::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: d75d834c-ee95-4a3b-9e33-08de46b9ce4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2EvSTF3ZEl0NFIyRWpJQ2pCY0xJeUVVOW9yMHY5ZVdoYW9lM1ovcncxQ0t4?=
 =?utf-8?B?SHFRZll6Nnpmd2JBWWhwS3dXVE5zWXduQW5zeHR2Y3J5cFVQK04ydHhNRTFZ?=
 =?utf-8?B?dklQZ0pCQXB6eVpUbm5EdVdaRFV0SlNMUVNOMXJZa0FMN2czcVdtRFAydHdi?=
 =?utf-8?B?SFpHNEUvRys0a3dzN0QvS1ByUTVXTUpXUWdpaDdIMlNpYVRhYWpKcFo4Tk5h?=
 =?utf-8?B?cFc2ZmFydkVPeU5ZNmlOc3FwYmZka1BETFo1NzlER0Z4dDIzYjMxYlNxYVox?=
 =?utf-8?B?Y1JkTGgwNWpkcEhwTHlNeEo1OEZVY1VzbkxQNVNRMlZsOFNnNVNnTEVnVVVv?=
 =?utf-8?B?dEFKRUZhWUV1RDZ4MUExUGY4eUk4MHhWTnkxMUZOdXZCTk9hUFlldEZ4VlFM?=
 =?utf-8?B?VGZNTDVZeW9JMHFTcHVZZGFLSXJ0U3U3UVNlWld4Ry9QU0Y0ejd2Rk5qM2Jj?=
 =?utf-8?B?NUYyMDJ1Yk5veGlPbVNXSlg1VEFIU3krUlNHNmIrbERScmgxRDJRZmMyN1N4?=
 =?utf-8?B?dDQ0UVJxSkVNOW1wcDVuVTJYVkkrWEgzc1dyWERLNUI3cHhSRnVEcTZPMWkw?=
 =?utf-8?B?T2F6WlJ5dmJCQVVLWFhwTjlBdEd0QTcwL0FqOG05eUprU3JIb1NxWFJSM29k?=
 =?utf-8?B?M1UrQnloekxKcWR2T0lnUjBqMDh1a1dCNmh6eEdmSlFvZHNiekpFbnFuRzBp?=
 =?utf-8?B?ZW1XK2dUSE95QXRwNU9MbEpXRHp6NUdxTHg0M1NIV0ovSjY4VVNrK0NBN1Jr?=
 =?utf-8?B?THhRcVVTWExEZFBIM0U1eTJ6QmNFSnI3VnJmdnkrdFVhMm16dVZJbUZaNlVL?=
 =?utf-8?B?SG0yM3kyWUFHRzlBQUNaczRCNG42QlI1OFp3RGZvSi9UR1VmY2pJdGtXbTFm?=
 =?utf-8?B?ZXVVU1ZpeDhMTlpTMkY5eTkrTFFORXcycU9hd3NKV0Rsd1J4eGw4d25EOUJl?=
 =?utf-8?B?dUVvbUNHWWF6ejB3MlI5aGZYVkFJSWM5SURXb0VhTjJWSjRKeVJSY1RTN1NL?=
 =?utf-8?B?UVJyd3pMWlIvMkZqc05pS3hWMCtIdW8rVFNobnRDWVpvd0sySTF0cFYwaEdw?=
 =?utf-8?B?WVp0V1pNRFpGQ3lPM1NFTjdlWkNOcFE3alJUbUNJU1dqemFuYW84WGx4MG52?=
 =?utf-8?B?bVd2a3VYdVMxaytzV3ZMc2JXaXZtZWsycG1mdG1PRmZEaDFERG9vaWJwQ0Q5?=
 =?utf-8?B?ang0VmJIT2cwbG9tdDhQeHczT3hKZXVtRWQxajJyNFM5YmNQOWRvZzN5M2th?=
 =?utf-8?B?OXpSVnBmVGJJTkQxWjJ3NlhGcjFKaDdTVTZBS3NUcnl1K044c1k5aTNyRFRi?=
 =?utf-8?B?QWRwdTEyTTZ3dFNHNDFjaHNNenVWbzlIOFRSd3RkU1h5NUJVK254emsxbWZm?=
 =?utf-8?B?enVPejFOcTJaMDVYckNVQUVZbkZJVmJ0R0RteWl4YTdkOENuR1dTRWtHRHEz?=
 =?utf-8?B?clZ0OW4wK0pIODRlMVhLWjR2YXRub0JXUldtcnpkYlEwVzhxVW1nQWdHWU96?=
 =?utf-8?B?dEhMK2twZk5NeDBiZnVYbkpLc1VlTW14V2hsaXdLa0phNkFCRHdTWTJ1UnBZ?=
 =?utf-8?B?Nml5b0laSFdlcWFvdG95aHdwYmlVYVNlOTdUNWhQMHd2eGhDRWpRSU15bkhs?=
 =?utf-8?B?Q2tFQk54ZjRhQXZSdFo1bWZhZTlXVUwvUWMrU0o2Nm1aaDdJUnBWdkpXQWxV?=
 =?utf-8?B?NlcxMG8yd0lySndrMkZ1RG1iNUdITSs3RkdZbElSaUNPS0h2UHhsdlpMSTNi?=
 =?utf-8?B?TjNKejRiSzVsQVRzQUExOTY3QkVMK1N6d2V6em4yVDJyYjNhb284TVcweWJz?=
 =?utf-8?B?VklCcVJBSTdXYit5ZFdJL3hlSklLRTFCYUw1RmFGZk1CTkxONDQ0ODNjRTRp?=
 =?utf-8?B?ZmtGMkFvbnNHTXcrRmxHS0s2MCsrSGZPUTdHZ2FBL1prNW1PWm4yemNHY3B3?=
 =?utf-8?B?WnRhWS9FcnVkREluNkZxTk5CaklNN2MzdlBCVzJVcmJmQ3FaZCs5cjZSMlV1?=
 =?utf-8?B?S28yTmd4Y1BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3BueGRScS9Wa0c1SHpJWUFFZEtYSXErZXpYdlB3VS96UjhEUGN1dGovTE02?=
 =?utf-8?B?OTcwd1lkUis3cE9xTmxNS0xtSTFCalNPZHdZY3B2UjN5b0FlVnErRzE4MkZO?=
 =?utf-8?B?VzA1dlg4WEovdmFyUFp3MGRUZmRKN0Y3RUlSU0ZLNVFwZ0tTOUNpc1RsenNp?=
 =?utf-8?B?dkxobGF5blFYY1dWbko1SjlOMyt1NUoyZFRjd1l1V0NsNEF1RVBXR3ZYcGxU?=
 =?utf-8?B?MldWZFUyYzJKVTJrL0ZUb2V3UzB2VTJkMzFpZWw0Z3dkS3NveldzREJkVzRS?=
 =?utf-8?B?SUIzT3RqbXdQaUc5ZkM5VUR6L0NvbzJ5Q3YvM0NoMmRmWW4yYlBmM2dNL0JL?=
 =?utf-8?B?VEIzcU5tRVEzREZHZlFMVGllSmM3SXVyMjFreGg4SWFtdnlLdjcxVnhGS3Vz?=
 =?utf-8?B?UFBNN1pwcXRRTmUwZmtWeWtZS0llKzdya2NocHJ3RHZNUi9pSnpUbk9aVGE2?=
 =?utf-8?B?WC9EaTVtQjRCaGNjQjk2QVp3UkVXS05sdVM4c1JCN3pQcjRWRDY2b0xZR3JR?=
 =?utf-8?B?cklqUTNMWW51WmNHMy9qQXd3VGhTUERITU9YaVkxOFh0S2h2YitBLzFPY2hG?=
 =?utf-8?B?alN5Wi9EMXNPYTdzd21wOXJ1RTlPSG15NVVzZ1JrclZvREYvckNDWmc1eHJr?=
 =?utf-8?B?M3ZoLzh6a3dvclpIZ3FIYWkxYi82dE9Cb2pSS0lyVys1N3Q3S2ZwMWs3T2l1?=
 =?utf-8?B?RDl1M2EwVDYxUU5lU09CVkh3cEI0M0psS3F6eXhnTTRLbkhxSUFhQnlrL2Nz?=
 =?utf-8?B?dHQrOTliemRKMFFmTThaLzRTR2JhbHlDVFhLbVZwaytHeTBMNGZpMTVCYjhM?=
 =?utf-8?B?N3kwREhpZXhZK1BMZkEvQ2g0Y0JNdXE5bDlkNDNmb1Znc250OGRPV1dkVzZO?=
 =?utf-8?B?SGJnaVUwVkN1dkZQcUkxczN2UjdGMm45ZDNTTTVIdzhMUng4Szk0eVZwUGdD?=
 =?utf-8?B?ZTBQZ1JpWEJ2T0J5RXh1Qk5PTU5VNVdtMjJLRy85dU9TZ2s4bHVHeXNKK21D?=
 =?utf-8?B?ekNnREtUdU5mN2REcnRnRW5FVWVUL081RnhUc2NqUUtYRmd4cXYwU1NmWm9H?=
 =?utf-8?B?U083ZVIrTnl2bEZPczVQWXVCU1NmUTRCNTFtRFFDYytPcmt6eG1PVDZjbE13?=
 =?utf-8?B?ZVEvclZSbGFhcVp5NWdhYlFxbUVBZ2YyWjBpSkx5SUFDb3hIL2k1aDVYNHF1?=
 =?utf-8?B?RlJ3cUtkbk9Sb1IzVjJuMVc5c0RFM2kraE5KRG5lZGhIRzVwam1pd1c5eERm?=
 =?utf-8?B?cnFBMmxwODRFMG0yQk9GVHhGYkpBeTdCRG00N1NrQ1dZN2dFT0RrQllQZlNI?=
 =?utf-8?B?NWNiTU55Sjg1U1VralJwdkJPbXBtN2RPcDcwWjJVTHRYZ2FzWlg4WnJPekxm?=
 =?utf-8?B?NkVibXlGQlBHY2VHbTRBbS9RMGhjNEhpUW93dDlVNm15RVJCNUxxWGUwSkxY?=
 =?utf-8?B?TjQrZTZpRWpjL3FYbE90bTU3bWIvVU5uQkExVlFRTmpEV2wrNEtWVVEvdEJZ?=
 =?utf-8?B?MFFJUEt0ZG9YL25UR1dMM09BQ3c5ZXF5M3gwT052ZHQ5VnJJaGNmcGZnRzkr?=
 =?utf-8?B?MGVjckpWbit4VFRDNW5BU1FGS1RMb0xDdDlyYjRaaW50aUI2ZHVPUXVGMTBm?=
 =?utf-8?B?YlQ2MXpKc1NMd1NTZ1UrRUpqM0pTb0paeldrcnZOdVpZaW9VNzMwRzNOM2lS?=
 =?utf-8?B?VHFYdFB3Nk9lVWZhU1BseHpHZ2h3S1hiUlpDcXNYaFVlZTVCU2dFOUUyanQz?=
 =?utf-8?B?YW1NdGJ5Z2VhTlJicnhxMnVUWXdROHpwb3RvQkFzVTVPcUREVFJJTGxXWlVC?=
 =?utf-8?B?VGRIL0lXNlBwN1VvZ0NiZjNiZWlhLzZtcy9LaGlxV1c0V2tQUHRFSXgzVHU1?=
 =?utf-8?B?MVZuYzc2UXhDdGpLZ1c3Z1dMRzBGYkRzbEdTcW4xUHYxZjNpRW1YdjBwcDRY?=
 =?utf-8?B?dFY1SHYxNXFlaFpXQVRtdXpGbGVFMVJwYTNKWmk1R2NaY08zSjVWYXpyZE5t?=
 =?utf-8?B?U25Bem8yL1FUMmtHTzR5RWNkSUw0UWo3a1MvVndncGIvVFhXakhFMkdTUmtE?=
 =?utf-8?B?MFFCeXJzWmlYTFMwcXJVc09WZXhiL3AwQ0F6QUFmU2tSS0p6dWpTV3pqVWt2?=
 =?utf-8?B?MnZoR3I0bFVZWmlIM1lkc3VlK1FlMDVtcWZyV1duWWQ0RWh0cUdHbTBGRTV5?=
 =?utf-8?B?Tk1uMklLTWFaV0VwM2FLdjJiMDNEWmlUc3Q0TjF1Y0laVDFCWENJcXlkdHNL?=
 =?utf-8?B?bEY0RDFxVlQyM3ZENGZpcE1lS2ZySDNSU3BDbERncXpMcUo0N3Q5YmpXeGpH?=
 =?utf-8?B?RCtNaHU1dW1LTWJmT3ozZEtGTEx1UDQ4ME8zS2IzR0ptZ3lQN01iekl5RHZB?=
 =?utf-8?Q?VDwVTsT8263ld4io=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75d834c-ee95-4a3b-9e33-08de46b9ce4b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 09:08:18.0861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gouTAe2LmLxgOokg2vX4lWiLyN2eYurAujPUP5JWxOGq0RUfsKvIr2wfDBh0GIMAUS4qAH0DLAqUbdSJsRvAX3bV1Lcg3FRhQuAv9xrleCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9586
Received-SPF: pass client-ip=40.107.159.101;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 12/4/25 12:50 PM, Andrey Drobyshev wrote:
> v2 -> v3:
> 
>   * Use atexit.register() instead of gdb.events.exited.connect() for
>     registering a cleanup callback.  That way it's called upon both
>     normal and abnormal exit;
>   * Wrap code in invoke() methods in try-finally block, so that
>     restore_regs() is called unconditionally even we caught an exception;
>   * Restore registers in cleanup;
>   * Set dirty flag early on in patch_regs() to make sure registers get
>     restored if we failed while patching.
> 
> v1 -> v2:
> 
>   * Use pty module instead of script(1) for producing colored output;
>   * Patch coredump file in place instead of full copy;
>   * Save and restore original pt_regs values in a separate file;
>   * Wrap this logic in a separate class.
> 
> v2: https://lore.kernel.org/qemu-devel/20251202163119.363969-1-andrey.drobyshev@virtuozzo.com/
> v1: https://lore.kernel.org/qemu-devel/20251125142105.448289-1-andrey.drobyshev@virtuozzo.com/
> 
> Andrey Drobyshev (4):
>   scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
>     addresses
>   scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
>   scripts/qemugdb: timers: Improve 'qemu timers' command readability
>   scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
>     coredump
> 
>  scripts/qemugdb/coroutine.py | 257 +++++++++++++++++++++++++++++++++--
>  scripts/qemugdb/mtree.py     |   2 +-
>  scripts/qemugdb/timers.py    |  54 ++++++--
>  3 files changed, 289 insertions(+), 24 deletions(-)
> 

Kind reminder.

AFAICT we've managed to cover all the issues with the last commit, so if
there're any others - please let me know.

Andrey

