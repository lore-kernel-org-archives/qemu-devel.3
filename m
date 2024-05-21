Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81932C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 09:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Lci-0001yR-Ik; Tue, 21 May 2024 05:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9Lcg-0001xu-HY; Tue, 21 May 2024 05:17:30 -0400
Received: from mail-dbaeur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260d::701]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9Lcd-0006NR-LB; Tue, 21 May 2024 05:17:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esgmu/O4jeFKYnvfAjWpYcp0J0oOyPAlfgl8PZ4+X2Dpioz9l2j6uRJWJJYScUMUm104l9D+2qwROg59Qf90nnhEN2bQmguXEzQH2OL7mur7YrvE1j1QDJiDdM06XKBCBdjsh/UH2vXRtKkwclyJFQlRN4sWNKfl/Lab92/sYZmDIz98n6gkCtiqwgwgWkY5d+bYEsxOAYvhL0rcBMRPbp+BP9+p1/tBk5fLfOAmobiizGpf/sif97uKc3/k6QggHwTO7SR5gS5HgHyAjJDcNySecRLXEcxUtotTXgaa07oWPGYsbTa6X3fu7a1rXRD4+t8VzARy/QHkhDr/6vvyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+70XV7mm8zplmOFagVRs4OCPOYGDhzciynZLoLPd3s=;
 b=b511xnPnqWPnGsVkU0246hyHz5aQkvW3Log2Py+VoZASJqE//uYEdi7F9oY9PZMUk85bVeaUFvYv/Z4SQFnwrHCLo2Jr2uk5i26lCYFxQuWs0dDRvF0ktl4t1hV+oI4TIxEZJ/167hdQ6ouICf/xr2w5BmutUy7vlusaDAgwsRuobtgDxVCYcqVLY3jUxzOvD9gARSQEL/XUsLvknJBVw/OrRZoLc7ENvX2Wt3EvfbuAGS6l+GdeYtilJ6NGqq8xxZk9G6pBQe+WeOwqUVJ6uYi3L1Q158pT0ggwIwFq+QLvtRYIA4RL5ewc7xi9lFwwG1nJvWww2nzHFR5eqL/62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+70XV7mm8zplmOFagVRs4OCPOYGDhzciynZLoLPd3s=;
 b=mDkp+PfVTi8Sdus9Wj59YlDpwO2MBou9qshBxfu6k3MJB5UBnELz00pJqa3ad7GWcQmUJRUqRasGvjfJJTT2Ts20dSG2eH6BKiWyMzs9XjxAO9Z82+0XvK5MZHSWE2Dc60dXKeqjW3jsCKntxywtCX0f7y5bWg410ZNBFJALKNCeE7aebaxszUa38a2hqaK7INihJMXAuFn1oHXBwJrJgua5r9utjZDye+H0Kt17OM+0WAM1/GzyQpj9cLxz3pL6VGLVcC4HG9vcGSIj6InJ9Hwez/Ic6DojtHVZUGL4kSq93QBVAGpF/Gm70g3PAsIbqEZ3I+KT2PRG1qc+HbCW2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GV1PR08MB11004.eurprd08.prod.outlook.com
 (2603:10a6:150:1f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 09:17:19 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:17:19 +0000
Message-ID: <c7845e67-de3e-4d88-93fa-00cd82e514ca@virtuozzo.com>
Date: Tue, 21 May 2024 11:17:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] qcow2: add get_sc_range_info() helper for
 working with subcluster ranges
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-8-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-8-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GV1PR08MB11004:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f659154-907f-4ebb-1622-08dc7976d09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3RRbzV0L3IzdGxCZEl0UmNVUmlUeUJNNVprU1hxMGlKZFBrQXJGdjNXeE04?=
 =?utf-8?B?cGNrdlRFVElSWVk4K2t1R1B2QkluNGpyWUc5Rytuc0U1akhUZy8ycEFXU2ZD?=
 =?utf-8?B?WHB0MzlnMG5XdTcvWUZhcFd4VFdnMXE5Mng5Ymx2NVNubGYvSmNEdWJUZUtJ?=
 =?utf-8?B?Y3NTeVVnL0JjSVNPNmMwRG5FSU4wNjAzT2o5VUNEb3RaeXV0a2szclRMMG9K?=
 =?utf-8?B?bnRSZ0ZNNEIyWVRCcGNraURFN0psYkljcURJeHNWN0hDYUhvYmtPR1k4aFpS?=
 =?utf-8?B?ZDk4c3BxNlQyR2x6MVBJUm1sa1lMazRJSVRkVXFYWkE0cDQ0eHB2QnpOZkVR?=
 =?utf-8?B?MkNJSFI2ZVRMajlhTDNsbEl4b1F5VFBNejRLVzBMR3M2V2I5Z3FNZ3NaWnJX?=
 =?utf-8?B?cjB2OTRybkU1T05BSFRrL0liendQQ0Z2ZFBmM2tVQVg2aFBDd3A1TTJHUjFW?=
 =?utf-8?B?K0QrNDhGbEhlSVV1aE5zVUFWcExFMWNsVHNNajJGUkhPRm9zdzhIN0VQTGRa?=
 =?utf-8?B?SHBVYkhMTjhyQjkwMTNTbWNwMFgzeWZlS3p0ZkQrK2t3WHY4SDJ3OEVNL1dV?=
 =?utf-8?B?YzhhcUkvaWQ3ZjJvQU1kUEZJb3ZLcnpmc0lHcGdXMU5yN0JyU0ZhYVZ3UzBp?=
 =?utf-8?B?SzAyb0o4RU9Td0hodk5jbGhza1J4cGRXRXRVN3JRcm5iL2NhL1lXRGlLbVFD?=
 =?utf-8?B?emVoWlV6Yy92cm1xbFR6dXZGM2ZzN2NyM1N2bW53WUFxWTl6UURFZEcrUERr?=
 =?utf-8?B?V2FoNlBnVmEvalBuVkNSWFBPUk4rNzV3ZU0xSjAwcjVqbFZ3NXlTVzRCSlhx?=
 =?utf-8?B?TTdzQVVYbWpNN294MDJDRUEwSUZaUkdINEVsVzNLa1p2eE9ZRmFva0pKT3Nn?=
 =?utf-8?B?U094MlVHN2lONFZUbVVKc3VzVFZRWDNUY1FkNFRyWWxFNVI0RDdBcklLck9u?=
 =?utf-8?B?NEZWeGlFOWRickp5MWo5alRLaURYV0F2cFo2UVBBb1dBK0tBZ3NWM0lzclgr?=
 =?utf-8?B?WkVSam42d2pkODlFb0I2T2hQVHJLUEljNDJHU2Z4ZW41NnY3ajJPNklwYkcv?=
 =?utf-8?B?OTRvS0pmZkY5WHJ4QVE3a05xQzdKeW9WYUsvYjVTMGlWNkNsU1YwdnB6TjF4?=
 =?utf-8?B?V1gva0VIN1h3MnRwUGVRdEZhelN5cWxVWUpOdjRvYzc1eEpUZ0owUWJGcUYr?=
 =?utf-8?B?YkwyYzg5RmhXQ0hsWXR3SkxzbUhKd3ZlNjlBSlhTVExaOGtsVndBV0dYb3Ju?=
 =?utf-8?B?MUdFUytzUWhWZElWTDVMdEt5NkJxOG1JUzA4cklqZTlnWnZUTTMxc2JCb1dj?=
 =?utf-8?B?dlZTcE9RZGRDSng5d1dkby9SbkxFWE1iNFdOS3k2WU5nQi9nN0tBc3Biajh2?=
 =?utf-8?B?RWdXdVg4WkF3MDlOMFJCZFVYV2VHYjhYMEZBNkwzbi83ZWJ4TVZYMEdtSG5x?=
 =?utf-8?B?Z0l4UTA2b3VWMERsV1ZWNU9iMktHaTFsOXBiem5zT0wyTTBNTmp2WDJiNDZh?=
 =?utf-8?B?SFhQWlhtd0taQ0QwRmdRTDF3MTV1LytTWDB0M0tjS1dtN0FYWDhMYVdId3cx?=
 =?utf-8?B?dzlPc3ptQXdjQVgvOXNLOFJnaktvRGpOZ2orK3UrRTQwTTN6MkRid0JPdmM2?=
 =?utf-8?B?cFNjU2tNZTY5czA5ci95VnZsNHFKZW1aSTk5dDVYVGtoZ1IzejZYK3hWSTZC?=
 =?utf-8?B?Tkt1RFRiSFA0ZlpYVnNyWXNmYlVzSWM2SzZLZU9UWHdJUU44aVo4TkRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhRWC9vQ0NybUJJVTFXMTFxQ2tuMnA5ZGRkS0FncllhR1R0ZkVlWlRhNmFI?=
 =?utf-8?B?amJCbmNIbUl4eDdRUXBKWExJckN2U3BtK0o1dmptUFdMSVdmUHU5N210cmZZ?=
 =?utf-8?B?bWI2Nmh1WG8zRWlRcDlCNTJjN0NxcVVnNExldFRsQ04wbGQ0WEluNW1XOGph?=
 =?utf-8?B?NUdZM3VUeDRLUTJBQmlDbFhjMFJQcDVYb0VrQkxqdlc4dlZGMUJDeUhQa05n?=
 =?utf-8?B?TllxLzZCSEVXZ1p0Sm9jMmFOektxRjZaZitJWVZXYzdwbzUvakR5KzJDYnZW?=
 =?utf-8?B?RkcycWVCbVZUNTNmQXY1ME1NZkgrR1hmRlltTldSVDB2ejBQUlkvdU5zZ3pZ?=
 =?utf-8?B?T1dtZXlROXVML0s1TGFsSXc3YU5FRFpEd2c4enZLbkFuekhyYit3bm44V1ZG?=
 =?utf-8?B?MEpXalNXNXpmTkw1SVhobWtqTWc0N1JKdnk0RDFKVm5yZGhLVVZ4VWhnaHJ6?=
 =?utf-8?B?aHpRN3p6MTFQd3VQeko1QklwODM2cUpaeDlLQ0x4NmdwUFd0K2ZDSW5KbVEy?=
 =?utf-8?B?MWVsb2Y4VlhHclFrOHBKaUc3QVh6clJ1bUdhdGpWc2NNWVNBYys1aFkxcTZQ?=
 =?utf-8?B?NTlVZnIxMVIrTmVPOVVkdlE2d25XZS9vcGNSOG5jaFhVNHhSbmd1TTRId3RH?=
 =?utf-8?B?VFRpQkwxeWRoZVdYMGJtQThoV0pJbUtKMCtVTm5vVWpWVU5aZDgvbDlPS1Vv?=
 =?utf-8?B?ckFzNDBqbFVEdHU0UUJUYnBheld6SnEvVC9yOWtuRUxJV0RYUVAzNUg1b2Ux?=
 =?utf-8?B?aHA3eDlsTGZxU2w2TXMycDNaeXRJS2tmOXJYaU5ncHZXd1FDOHlzOHdLM1V5?=
 =?utf-8?B?aXExenhIOUx5dlpKV25kcVcrd1NSTTQxZEdILzVYQldUVWl1YzVOdkNZZTU3?=
 =?utf-8?B?eS9MTlV5bkdSRk43UFlGMkM3dXNQbDdwbUhhcmlFZWhyM3k1SS9jc0VodkNB?=
 =?utf-8?B?c2FXaFFrc2E4ZzR1NjkwSm52T0JEMVhjb3dSUTlFVDJMVEdXRmxyNGUzWkwr?=
 =?utf-8?B?OWxnemtRUFF6KytQT2YrT1IrWnNHbSthRjYrL0w5d0E1NDMralQ5Z0tSTys2?=
 =?utf-8?B?Qnlra2Z4a1IrK2s1dVBVNnQvYm02bS8wa3UySUZaWVhKL2Y1WUpJazJBaHlI?=
 =?utf-8?B?V1F4dldZNE5KQ0FaUmZFWCtiQi8rNUMrVExTK2VVcENydWRWajBWS3I4Mnhi?=
 =?utf-8?B?U2lqZ1N0T1RwdU91NTRnU0RjeTgvRFRWTzdHNnYweHNTUGhtTGY5V2M4ZkZE?=
 =?utf-8?B?N3g1RmhTbldlSlNYaklUMm94OCsxL1F6V2w0eEpFYk9mL29tREExOFZ0L1h6?=
 =?utf-8?B?TzU3ZFRKc29TSWthVXJPTnA4OW5iTEcwNmZWc3hRaUoxcGRtWHY0QWFralgv?=
 =?utf-8?B?YTVhYTJ4T0RTMk9wbk5KUGtabmxPN1dpYjNOY2VaWDMzRXVFaGdmanErb0dI?=
 =?utf-8?B?endrNnRUVUFEeE80QVRDekdtd1JmTCtVd2pFeEJ3cHRlcGZCbEE4Ykh0L0c0?=
 =?utf-8?B?d1pzd25ZNUtHcnRRMTU0MWpuS3JybGxPclBDdWxVd0Qzei9vRjJwWDVSSzZ2?=
 =?utf-8?B?cE1vVXk5WG5XL1lBN1I1OGR5M1Q0UHlZSkhkcE1nelFhRVZ2WUlkZDJHRjMw?=
 =?utf-8?B?ZzIzdWRPRVBUdW9QTWR6S1dhaFpEVlBwWXdaVmlVa3FHczR4TkNLM2pQRlVx?=
 =?utf-8?B?TkMyeVBjdFJlN3Y5NzNzbWJBRWRLeHBQb2Nuc2w5VHhrOWVhNk1JZWVSUXBl?=
 =?utf-8?B?Wm1Hdkk1bFU5bEZmWFYydzc0M0RGMGRoMkczd0hzWTBaU1gzZjFUNVU2Qzl3?=
 =?utf-8?B?Q1VqVzU0WmNHODVsR1U0eDhNdFI5WTlCTTJqb1J4T0ZWdTQ2YkZybitWcEV0?=
 =?utf-8?B?UWtaQ3dqUzJVUWNtNXduZmJldU4vSDNhOVVuR1YxdHUrVXVxY2dOeFhYNlhi?=
 =?utf-8?B?UE5oUHRzUHFpR2hIaGVubDJQN251dlBPd0o1NnE2MUNTMVdMREdkdGhLRlhx?=
 =?utf-8?B?QnBITzNaWlpXN0w4enZ4R29FVWkvWUpiMVJ5eU5rSmM4dGdyYVlyNGRvN0Zr?=
 =?utf-8?B?cjYyZC81bTk3alNWMldYSTRqeEpuMzVtcVJhK1lBNUlwRVRZRVdoSmhNUzRX?=
 =?utf-8?B?b3lVZnBITC9xdlJUeHJ4QmtnQnFKWncyNlJlR0JGY29oUVhUSWsxRkFWQmk4?=
 =?utf-8?Q?U4z7tgefKkbOW8H42xcyn1g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f659154-907f-4ebb-1622-08dc7976d09b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:17:19.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARBPN4BxtMpIfx44RjFNQEvDSKDox1OH4wDivd0MU8QWcalS0Zv0WtVVW8O8w3IH5aW0drRh5yGrbn+A/xWqjSPQ7m+9SdLhgJV8BHJfVn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11004
Received-SPF: pass client-ip=2a01:111:f403:260d::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 5/13/24 08:31, Andrey Drobyshev wrote:
> This helper simply obtains the l2 table parameters of the cluster which
> contains the given subclusters range.  Right now this info is being
> obtained and used by zero_l2_subclusters().  As we're about to introduce
> the subclusters discard operation, this helper would let us avoid code
> duplication.
>
> Also introduce struct SubClusterRangeInfo, which would contain all the
> needed params.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 140 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 108 insertions(+), 32 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 7dff0bd5a1..475f167035 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1915,6 +1915,103 @@ discard_no_unref_any_file(BlockDriverState *bs, uint64_t offset,
>       }
>   }
>   
> +/*
> + * Structure containing info about the subclusters range within one cluster.
> + *
> + * Since @l2_slice is a strong reference to the l2 table slice containing
> + * the corresponding l2 entry, it must be explicitly released by
> + * qcow2_cache_put().  Thus the user must either declare it with g_auto()
> + * (in which case sc_range_info_cleanup() is called automatically) or do
> + * the cleanup themselves.
> + */
> +typedef struct SubClusterRangeInfo {
> +    uint64_t *l2_slice;
> +    int l2_index;
> +    uint64_t l2_entry;
> +    uint64_t l2_bitmap;
> +    QCow2ClusterType ctype;
> +    Qcow2Cache *l2_table_cache;
> +} SubClusterRangeInfo;
> +
> +static void sc_range_info_cleanup(SubClusterRangeInfo *scri)
> +{
> +    if (scri->l2_table_cache && scri->l2_slice) {
> +        qcow2_cache_put(scri->l2_table_cache, (void **) &scri->l2_slice);
> +    }
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(SubClusterRangeInfo, sc_range_info_cleanup);
> +
> +/*
> + * For a given @offset and @nb_subclusters, fill out the SubClusterRangeInfo
> + * structure describing the subclusters range and referred to by @scri.
> + * Only the subclusters which can be independently discarded/zeroized
> + * (i.e. not compressed or invalid) are considered to be valid here.
> + *
> + * The subclusters range is denoted by @offset and @nb_subclusters and must
> + * not cross the cluster boundary.  @offset must be aligned to the subcluster
> + * size.
> + *
> + * Return: 0 if the SubClusterRangeInfo is successfully filled out and the
> + * subclusters within the given range might be discarded/zeroized;
> + * -EINVAL if any of the subclusters within the range is invalid;
> + * -ENOTSUP if the range is contained within a compressed cluster.
> + */
> +static int GRAPH_RDLOCK
> +get_sc_range_info(BlockDriverState *bs, uint64_t offset,
> +                  unsigned nb_subclusters, SubClusterRangeInfo *scri)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret, sc_cleared, sc_index = offset_to_sc_index(s, offset);
> +    QCow2SubclusterType sctype;
> +
> +    /* Here we only work with the subclusters within single cluster. */
> +    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
> +    assert(sc_index + nb_subclusters <= s->subclusters_per_cluster);
> +    assert(offset_into_subcluster(s, offset) == 0);
> +
> +    scri->l2_table_cache = s->l2_table_cache;
> +
> +    ret = get_cluster_table(bs, offset, &scri->l2_slice, &scri->l2_index);
> +    if (ret < 0) {
> +        goto cleanup;
> +    }
> +
> +    scri->l2_entry = get_l2_entry(s, scri->l2_slice, scri->l2_index);
> +    scri->l2_bitmap = get_l2_bitmap(s, scri->l2_slice, scri->l2_index);
> +    scri->ctype = qcow2_get_cluster_type(bs, scri->l2_entry);
> +
> +    sc_cleared = 0;
> +    do {
> +        ret = qcow2_get_subcluster_range_type(
> +            bs, scri->l2_entry, scri->l2_bitmap, sc_index + sc_cleared,
> +            &sctype);
> +        if (ret < 0) {
> +            goto cleanup;
> +        }
> +
> +        switch (sctype) {
> +        case QCOW2_SUBCLUSTER_COMPRESSED:
> +            /* We cannot partially zeroize/discard compressed clusters. */
> +            ret = -ENOTSUP;
> +            goto cleanup;
> +        case QCOW2_SUBCLUSTER_INVALID:
> +            ret = -EINVAL;
> +            goto cleanup;
> +        default:
> +            break;
> +        }
> +
> +        sc_cleared += ret;
> +    } while (sc_cleared < nb_subclusters);
> +
> +    return 0;
> +
> +cleanup:
> +    sc_range_info_cleanup(scri);
> +    return ret;
> +}
> +
>   /*
>    * This discards as many clusters of nb_clusters as possible at once (i.e.
>    * all clusters in the same L2 slice) and returns the number of discarded
> @@ -2127,46 +2224,25 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>                       unsigned nb_subclusters)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    uint64_t *l2_slice;
> -    uint64_t old_l2_bitmap, l2_bitmap;
> -    int l2_index, ret, sc = offset_to_sc_index(s, offset);
> -
> -    /* For full clusters use zero_in_l2_slice() instead */
> -    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
> -    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
> -    assert(offset_into_subcluster(s, offset) == 0);
> +    uint64_t new_l2_bitmap;
> +    int ret, sc = offset_to_sc_index(s, offset);
> +    g_auto(SubClusterRangeInfo) scri = { 0 };
>   
> -    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
> +    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
>       if (ret < 0) {
>           return ret;
>       }
>   
> -    switch (qcow2_get_cluster_type(bs, get_l2_entry(s, l2_slice, l2_index))) {
> -    case QCOW2_CLUSTER_COMPRESSED:
> -        ret = -ENOTSUP; /* We cannot partially zeroize compressed clusters */
> -        goto out;
> -    case QCOW2_CLUSTER_NORMAL:
> -    case QCOW2_CLUSTER_UNALLOCATED:
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
> -    old_l2_bitmap = l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
> -
> -    l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> -    l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap = scri.l2_bitmap;
> +    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
> +    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
>   
> -    if (old_l2_bitmap != l2_bitmap) {
> -        set_l2_bitmap(s, l2_slice, l2_index, l2_bitmap);
> -        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
> +    if (new_l2_bitmap != scri.l2_bitmap) {
> +        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
> +        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
>       }
>   
> -    ret = 0;
> -out:
> -    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> -
> -    return ret;
> +    return 0;
>   }
>   
>   int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


