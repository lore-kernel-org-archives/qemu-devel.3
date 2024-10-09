Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A882CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syY5k-0004CF-81; Wed, 09 Oct 2024 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1syY5h-00048p-Mj; Wed, 09 Oct 2024 10:55:05 -0400
Received: from mail-db8eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2614::700]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1syY5f-0006Qp-Qx; Wed, 09 Oct 2024 10:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP5ME8i053sx+2ND/oTvRGUXZByZLKha2af1QGrLPAJhCjlGEk14WLntNC0vTX3yC7FEKGeT8CIFJN+hOOkUBR8YnPxMWjn+fAQisBDTyGdDGaBOYSKiAMAnNO/QxllPidULXflak3Pcu/5n+Oie5pWHCnNiX1nH6h0URjWocddekEiaFpqVn2+828W7ImmF+SuogG6PLcb8oADukhf91MqwYqChcar8h2cPG8pJ/6FDXO3KnKRsAVBh3abtN4JP3L+rgRBO4n6sZm8ZIOCokJcamwQdtrAXodxy3Fmo6z76Qc/KfoQCJErA8y48uKAGjdJRQRorq3tlCuwgM1TnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37wnOOdrI1DBKRT8Q5xhCB4eGRvVkwmlTg2dLrFZwzA=;
 b=bS3oI+R7BaOyftvKZ4LHQPMNihRp8s900dYyhKFbF890XsReOdNzD3TWIeSzGkOJMkXGQOgeOiwC/OOyD7jju3RBAwawKWjCJXxHpkrmTAeE55Ugaevc7HecEYZX1W/vv4HcryGHw/M4DeBT3mkaq6TP5gdMcKC3nKRX1iOHgrICoDtZuOzK+diKrLO5URM6pZX07RQS2pJM7YzUYIeguIw3+E84RyecVVk2EnWp0QEMjS32heZYdwuT8xukRU1b4ROpNHv4INDYHA0vvf4JpbLJgsr+Lc1o0Cf7I91K+F275Y3LVlUQS7aWtVe8ElejWK1d9DBado1t2nPxSQlIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37wnOOdrI1DBKRT8Q5xhCB4eGRvVkwmlTg2dLrFZwzA=;
 b=avaUAJQRWqk6Oz+1a/btVC4QCaOS+y0kmGYpmn7wKK3GHshzpqDmTI4wDSacM/Q0KdrDByJWlQBXXH7t/CzCfBSLtYmYvlDpDmhMS1K5jweqyT6+Ire87IkClGVWdxWqSOKXXVGN4sTtPabfxtCcKLip8dg3cRuRwHhCZKHTZ9m2m2jkJE1hus42om3TlnwDHBjWm4bf/6/Qecf/+c95YWs5pAJhk1cc+orSbJYnUs6OnkK7h5/saLPw0A/3PvfYBxY1uyiU/AtWHjK/OjWVZ3yfZsV3DAoffaiEid3jlmSGYchwdg32NgGCcmMeh1KvIVCcow9db5XACh6F1Qa19A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAVPR08MB9882.eurprd08.prod.outlook.com
 (2603:10a6:102:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:54:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:54:30 +0000
Message-ID: <2053462d-985e-4767-9ace-88d0bc0ea232@virtuozzo.com>
Date: Wed, 9 Oct 2024 17:55:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] qcow2: make subclusters discardable
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com, den@virtuozzo.com,
 vsementsov@yandex-team.ru
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
 <3b8d6cd6-95ff-4eff-8d67-2c4505c456c1@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <3b8d6cd6-95ff-4eff-8d67-2c4505c456c1@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAVPR08MB9882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c22c679-c853-4cf5-2a8c-08dce872473d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WENiYkNZS2g2MEJJVHRSVytaUXI0Qk1pTnN5T0tqRTluNlc2LzMxV0w1SEkz?=
 =?utf-8?B?ZXo4M3BmbnUzWGtZcHY2bG5Qa2x0OStPYzZLT1NhTTZxUHZJVVgrUTB2WDhI?=
 =?utf-8?B?QllSM2ltUEUzdm5YcklQMi80RGhJYzFGeEQ1b0hobFJrNmcxSHh2dmNEN3FG?=
 =?utf-8?B?ek54b05kdHVVQW11SVRyVVA3Zkg4VFlPd0ZFcGV6UnRGVWphMDEvNGF1d0F2?=
 =?utf-8?B?QnBkcXBybmNnSzV6Sy9FL0JGL1ZNWWRXUytxV0VRZG83cG5lVENSTklnRzF6?=
 =?utf-8?B?ZGtoRFE2TmNhNWtkd3Mxa2t2eUZMc1N1Q2xucWYzZ0I0anEzblliUC9STzlL?=
 =?utf-8?B?cUNkbVVHQndDck05TmJVbFJ2TzRHbUdZdTY4aFA2N1lRZ294VFBhNkV4WDlT?=
 =?utf-8?B?MHdQRGNxTkNvSHdGSVBaWXlNQks2OWFnYWxnbHNlTExzVUV0VzFzaGpRd0ZB?=
 =?utf-8?B?emEwdHRYemdoTVVEdDVybmlXei9pbXRGbldiTFBZVzVBQ2VGWDNqSVpNUEVz?=
 =?utf-8?B?R0xYREpENXNlRytRTGU1YXErY0x4ZkREbDQ5RFhSRFYxWlZTclJPanNXZGNY?=
 =?utf-8?B?aWprWm1GbWdXaFl1UDZRQXVmenJBRU5nemZQSW4yN2p6eVlnK2pZQUlxMEVF?=
 =?utf-8?B?c0RBa0FMNFF4aEszWjg0eDNFOE9QdFRGbW5wY1JnY05aaUZ4N0ozM3QzSTZl?=
 =?utf-8?B?Z1pOU2EveWUvVnhNZytKMEcraU0yVU5sck9qb3c3MFY5Y05Sb0g5S25Nbmd5?=
 =?utf-8?B?Uk9HZmtieFZFdmtQNU9KZkdHNTZrYlI5eEx5ZS9nbW41RmNkNHdOYldESEpQ?=
 =?utf-8?B?bWRXeWRDczI3ZjhFWjhkMWxWNkFiOWcvZzNTdzIvR0RsMTN0aVpVb2VqMC91?=
 =?utf-8?B?ME9GV0FWV1VnL091VkxMdDJzWEJEd2xxSmVlOW1sdGZvamQ5WlVBSUJaUVhH?=
 =?utf-8?B?bGkxVmQ2VWVXYWl3d1A4bXY0cDFjakhIZHkwb3h5cXVYRFFGSnp3YmZGRGZk?=
 =?utf-8?B?TjliMHJvS1p0NVZDRVNMRUpJaHBPQzhoeU9IVm1OUGpXdVAwUWVjL1A4anEv?=
 =?utf-8?B?QXdYOGlNNFR4UkJlVHFOZzZBV3RPcVAzdG9YYXE0bkNGcVJUQlVCRWMwZlBw?=
 =?utf-8?B?bGU0dWhQbUlyaitjNnk4RGdRTUJIYTBXTXBSMG50S2d3ZGd5ZmtUUlhoZVFt?=
 =?utf-8?B?MVJ6eE1WQmxZakNyNXJaYjk0SEdEcEZiOUdkdXRRMm1vSCtTR3ZOZ3lBcjlU?=
 =?utf-8?B?YWRLbWhkb0RXeUFHNHhpS0tMZ3ZPSU4xais5bW0vckRqTkVQdXRLSjJmR3FD?=
 =?utf-8?B?d0ltSEl4TG5RaFQrTWNaaUdmTlYwS3EwLzF4dHRVQUJWT004a21HeTZ2eTdC?=
 =?utf-8?B?T2FrQVcxWDdKc2xZM0xCaVBDeXk3Wm1aR0hRdkw4UG9tdStxT040UWQxalIv?=
 =?utf-8?B?L1oyUStNSXBQKzBQYzQwTGtaeWxHc2lwZVNFcDdocWdaV2pSM3JQTlNpNUxk?=
 =?utf-8?B?cE5QK3pKUEtjQW8zNWJxaU9nTEJVbUZSc1lFbm91REgvQ0h2MTJJcjJVTG9X?=
 =?utf-8?B?U012cDlhajJ4bEc5cnEySjE5NVZGazI2bWozaU5JamlIN1RaZk1vbng5ZWdK?=
 =?utf-8?B?eXpabVpnc0RZVHp6WUh0Qm8yYUZra1VkejVlNXJGQmNQY2hCSEMzNGFHb2tm?=
 =?utf-8?B?K0VoWGFGZkkzZFVFSHJpUUNzTWRpNnFCNURlbHYxQVpGTUZHc2FETDB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5OeTBmb2o5NG9XVHptK1hDZDJNbUJ0MEcwS0llVk14Nmtzc2hlbW5hVS9v?=
 =?utf-8?B?SHNoQ0JKYXBGR2pUZURyVmljN0I1eDlYUFZ5SC9HTEZNNUlpVm54V3NJQS80?=
 =?utf-8?B?VkdmMW5DRlpTb0IwYk0rc09teXRXK2p2T1BybG9yS0tUaDErME9ZQXJXQmE2?=
 =?utf-8?B?eUw1eG5Wamx2MFVwVUVaV1lreW4zZ21iYzJYdTd0aUJjNlduTFRiYXJqV0M0?=
 =?utf-8?B?SEtPOHRKbWVVOFA2VEoyWUg1MEo5bVF4SCtZL24vMjVycFdvQXhMbmZpOU5K?=
 =?utf-8?B?M3orY0lpdWYvU2dZYXJwUDJzVHhCQUpMUUVWNXpKRjFzM2ZMNTBXMnAxVytU?=
 =?utf-8?B?MTRtUEhtWGFEdnM0ZFd2QTlTWW93aVo3WU4xaHlZVmxDY3QzdEJnSUNvQzVw?=
 =?utf-8?B?MzRxQnhvYzJya1c5SlpiRE9VWldMbTdmV0k4dnFNMEw1T2tISkxoclQ0WGtU?=
 =?utf-8?B?enJRMjlYNDhTSjJFM1JvY0lmZGhsMkNoZGpXYnBlelpZd3NDZS8zeGpBYUZO?=
 =?utf-8?B?TEZwTGRrczRRejdWdmwzNEV2TFpRZ1doNFlZSXJRdWdJWXJyeWN0NkJ3U2NP?=
 =?utf-8?B?YVJMNElrTVZEaGNJM3IyanBRN0VMb2gwQ203T3BjTUp2TVY0cW5uamdhREJT?=
 =?utf-8?B?ODZNMXQ3ZURrTXhHQjVVTEp5VFhTZGZUQnprVzRBblh4M09LYU1vS2JEYUp4?=
 =?utf-8?B?cXZDM2xrR3Z3T1JkbFBKN3JNaFhUZExQYml5N21wbGxxeEdrRWdtRVFQbGhR?=
 =?utf-8?B?ajd3YWlqTllzWms1bXFRL204RDJaTXdNLzVINnRMLzlUd1oxSEJ5ODZXVFFC?=
 =?utf-8?B?aSsrNFg3WmtHSzhTQ1ZPLzZzU242MUIrNm10NjJuaytKaWwzMlNPaTdPRkw4?=
 =?utf-8?B?bEtrSllqK1BPekRFNDVNUTYzamIrbE02eHZYWlE1ekhRSXRYOVNuM1hDaUVt?=
 =?utf-8?B?UDl2QzgvakZRRk9iQjg3MFNUUTNhZjAyMUFoaHYycmEyRlJxL0RRTkJqa1pE?=
 =?utf-8?B?TXFjQ3hrc2NxNmxsZ2hTanNoUTN5emIxRE5JV1M1N0xoYWNSMGUxMnE1S1Fa?=
 =?utf-8?B?aWU2M2lJeHlPMTg3dENQSE13MUJpaWpEdTdlWFdFSnc4UnQrVytFOEdtT3dH?=
 =?utf-8?B?Mm8xSTYweWpPSXVsb1hhd3FrU0M2ZWhqeDYxVmpaQWpRaW9iOEJ3UUFYOVIy?=
 =?utf-8?B?c2Y4dzl0b25iUXhScDNoZTU4eGhJeFVIQzh6QUgrZFNESldlbjNVNTN3b3Q2?=
 =?utf-8?B?M1Z3SEdWU0hGMzMyZzEwblQ0RFRoL0pkVkJxZUZjRndqL2lFQnFDcVBPc2hN?=
 =?utf-8?B?RUNxd1gzUTRZdkFVYlhJZnAxazBOK0p4cWtOd0Evc1czM0RBbWFGUkpCN05O?=
 =?utf-8?B?djB0b3JvajFKMTAyaTFoMVZvdkNUa0ZiWEVmSkxKRGF6SlMvYVlka3JCVWlZ?=
 =?utf-8?B?T2lIKzBQM3FxclFBalBDc1puQjdVMVkzVHhycHNwaCtIQmxXYWFTUTNaZzl2?=
 =?utf-8?B?RWE3Ym5nc1B3OFZmSFQ5dDZMWG00NHkxeExHbVRRbSs1MTlUQXNEanJCM05z?=
 =?utf-8?B?K0xvUGprUFloMnorREowSk1lQ2J3UlI0M0xlNjd5SEtIcUZlTGJaaWR0Um4z?=
 =?utf-8?B?c2xPU2FOMEE2c3RqSFpKNDdQdXpBQS9iYUhxeDhjeUhHNEhIYmMvZWlBOUJx?=
 =?utf-8?B?NHRXMDlKTGlEN0NEazFVSjdUSE1RRDNBTU9sMWcvc1hYWllsRTB5T0QwOWds?=
 =?utf-8?B?VzI2RUQ2cVpBOXNNSmpvb3l6SFg0V3ptMVdWSTh2Nkp0b2JKclVudTJ2RjFj?=
 =?utf-8?B?cEllYXQ2MlVCN1ltSXQ0UVZBU3Z2bEUwanZHZ3JYQkRjMVdXZlhhM25scUk5?=
 =?utf-8?B?ME9ITXR6M1RSbzV2L3lyajRTYjR1Mm8rL3pCYS9nYm1waElhaWRqNmpyc3R5?=
 =?utf-8?B?dVJlMC90OGFqbmxDQ3AxZC9Lc3hTQXpuZkc5ZitDYVFPWFI2ckdwN2x5STdp?=
 =?utf-8?B?aVpJZ3JsRHRyTG1xTTh6c3YrMDFqcVM0N2RuYnFTUEVsQTllNjhlUFFJMzdQ?=
 =?utf-8?B?emVKWUNrSDRvbzQ1eTN0YkNWeEpBRDkxTkNSUXVGd1J3OG9vSCtyR04rcXBh?=
 =?utf-8?B?cnhvZ2NGeDFGdE1yc3d1NnlXR2lDQjh2SXVGU3RWUFpJbUhnaEZsWUpsdldH?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c22c679-c853-4cf5-2a8c-08dce872473d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:54:30.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU8GRrgjw5AmK8RCi4rMXXVJA2tTZrbRJNVFUNyMAZuyaHZULVpVdycKWyZF+BWUPFEdNa2gv+TcBzNlQd9h6oBW3VpXj8ybO/RrfjDel0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9882
Received-SPF: pass client-ip=2a01:111:f403:2614::700;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/30/24 5:24 PM, Andrey Drobyshev wrote:
> On 9/13/24 7:39 PM, Andrey Drobyshev wrote:
>> v2: https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg02396.html
>>
>> v2 -> v3:
>>   * Added patch 12/12 "qcow2: add discard-subclusters option" which
>>     makes subcluster-based discards optional;
>>   * Added a bunch of R-b's.
>>
>> Andrey Drobyshev (12):
>>   qcow2: make function update_refcount_discard() global
>>   qcow2: simplify L2 entries accounting for discard-no-unref
>>   qcow2: put discard requests in the common queue when discard-no-unref
>>     enabled
>>   block/file-posix: add trace event for fallocate() calls
>>   iotests/common.rc: add disk_usage function
>>   iotests/290: add test case to check 'discard-no-unref' option behavior
>>   qcow2: add get_sc_range_info() helper for working with subcluster
>>     ranges
>>   qcow2: zeroize the entire cluster when there're no non-zero
>>     subclusters
>>   qcow2: make subclusters discardable
>>   qcow2: zero_l2_subclusters: fall through to discard operation when
>>     requested
>>   iotests/271: add test cases for subcluster-based discard/unmap
>>   qcow2: add discard-subclusters option
>>
>>  block/file-posix.c           |   1 +
>>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>>  block/qcow2-refcount.c       |   8 +-
>>  block/qcow2-snapshot.c       |   6 +-
>>  block/qcow2.c                |  44 +++--
>>  block/qcow2.h                |   8 +-
>>  block/trace-events           |   1 +
>>  tests/qemu-iotests/250       |   5 -
>>  tests/qemu-iotests/271       |  74 ++++++--
>>  tests/qemu-iotests/271.out   |  69 ++++++-
>>  tests/qemu-iotests/290       |  34 ++++
>>  tests/qemu-iotests/290.out   |  28 +++
>>  tests/qemu-iotests/common.rc |   6 +
>>  13 files changed, 513 insertions(+), 117 deletions(-)
>>
> 
> Friendly ping

Yet another ping

