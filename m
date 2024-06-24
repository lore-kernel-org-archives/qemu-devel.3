Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24511C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 07:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLeKt-00079b-Gt; Mon, 24 Jun 2024 03:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sLeKr-00078d-7O; Mon, 24 Jun 2024 03:41:57 -0400
Received: from mail-vi1eur04on2072d.outbound.protection.outlook.com
 ([2a01:111:f403:2611::72d]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sLeKm-0003PH-9S; Mon, 24 Jun 2024 03:41:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSy5LQ825HMB+rBmuR+uWXKalSICvGZXE5P5SN3x4wg4GI5g3qDulCvxp2D9BoFtJVtWPPuoFDGco4pa475GmGdANsKBhonAmY7G2ywk/lXt8ouOAyRO0nU39wKSK2bGzbXSuhyQfbIcOhRvgk6d8n+M9p9daaEPuoz89oGB0ZamOOV5ONadRjYkW38pswWBnNT+HK5FVIdvK3nsKZK59y/O3sw028Wzg3RU0+eybJYkyfm8hhbtA1zRxX+vcTXv1MwBDLV1R0v+UUx3BxF1gwoYaXBQao4OJT30ZCbC2aLCSzgbi59O2dckz5McI//Ehsfp/0moQ05PFXSrA0WhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWiHaZfUWw3kW6rzD9VEtBt2OxP5hsHOot+bttUY0vw=;
 b=M1c0ZwkOqv6xC1Dng7YCV01FcKqElQPie+JGONCw5KBjbDBDEu8DpbRLIpoWDsSUnnyxYFCQ4Oi0cA05YAv27nzrm6upg3lBBIu7cM6FdJBukchSJFqs0myKU6TBkFPjffg7S6g9Zq+Z6Nypxt5LnAGYCUV2lWCIDcJhzeaaDWZjT2NVcjDGUpowL1tIh8kgkdAjHoKQjI4f0fJsBlbkQusJrfryaW2eVNBXLlCPPAgd7w9iyeC6ADQRbpEfq5pKoJCk+YNV82B73i25wWLjfJZG9hlQfNX0VWK/QHRHDMoHyu3RBuQ36MkKLHLQeVCtJ5uB63dha6Iq0eFU/ahktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWiHaZfUWw3kW6rzD9VEtBt2OxP5hsHOot+bttUY0vw=;
 b=YYQze6InUk/Tn39dBZWfvlc3ocSEAPU4f9eHO8GGu77m0uZPYpJmUP29L5+KYOIK1bU4SZNTJvUsLCrenru1kAdzLm8V7XLaXzcTpywaFtCjcxzN0aOv0pD8GhckZg52wDeLXN1s8wb1Y/1fk79qWOFTigXhFoG3FWHtz5pel8jh+uJdNCI83ipBuHVyprEf+lSiffscKsQeRTBvbf8Ao/YNzNTf/5gig4YwliZn26dTlivAUO2MzmRIJX7PxnhxwHj4ckWffOydHPttXNLThmuazLOJU6dM7qXDXJe6Eq+52zkcQvZG46etxFIkI+pqxyJE/WPILybUuylZvnhZQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6377.eurprd08.prod.outlook.com
 (2603:10a6:10:259::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 07:41:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 07:41:41 +0000
Message-ID: <f73e386f-643e-4776-8d16-2a43ee1b56aa@virtuozzo.com>
Date: Mon, 24 Jun 2024 10:43:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qcow2: make subclusters discardable
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
 <e3bc4070-4b24-420e-9e98-376eee3659bc@virtuozzo.com>
 <126aefc2-de33-4b37-bd58-9d1079914ae6@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <126aefc2-de33-4b37-bd58-9d1079914ae6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8f1138-18a3-4319-062f-08dc942116ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmVwQXA2Lzd1TDBPYVNsdUsxeFhIYTVWcjhTdHA1NkFlNWZBSHJnNmUySC9F?=
 =?utf-8?B?THhqVjhsd0tHREFaLzVUY2VlWnovSkpRZis2bWlKY0hHeVlTbFk1UUdkN2kz?=
 =?utf-8?B?bVBRU3VsaXNxN2pucFBUUkNvL0lPTVRJdzU0cWdhOU94U2pRRytyYkFDc3Av?=
 =?utf-8?B?VGFIUDJVWTRtMlUwZmNXd1R5SzIxUkwvOHdWZDV4RDc1NXVlTHBWUzBueEFv?=
 =?utf-8?B?eGUxczJ6WWJ1VE1vdGFpcnhqZERsWU5ZR0dndmdaalVzZXoyaGJoMG1KMnFV?=
 =?utf-8?B?L00zem5IcERFbXhLUUdMVnRYTnp1dzIvNEtaRk1WYXpESHRNZ1oxelBqWHVW?=
 =?utf-8?B?RDRlOWZLNCtWU1drdEVCWEI3eHBvODFUNTExak5TUTEvWkd2Q2pxZ3hxV2h2?=
 =?utf-8?B?ZjdXZ3pWRXpLbHBna3AxOXV6Sm96R0hnYnByVkJEdmU1aXhNcFhuQmpJbzFj?=
 =?utf-8?B?MWJ1bmpxOGoxRE1kcE5qazBZU1J0eE92MVNHSk5iVy8zdXBYbysrVXprMlMr?=
 =?utf-8?B?MGdqYmFXL25xMnV6Z2lhR04yWHYzWHFFcG4zaE5PVXRuR09LN3IyVHVIeVlS?=
 =?utf-8?B?ZExwVmZZUTF4dG1wb3FNbjdpYkFicHY1ZlVEcmZOTHRrS05tMmZwanFxc2lp?=
 =?utf-8?B?VThSQXpMSmFaeWs5cmdSUnVqOHBDUVlzcERjQi9wbUVURzZhc0xLajZIZnVm?=
 =?utf-8?B?bEF4UnY5c05yeHBmYWpxMjJhb1hoQ1BCK0xTcENqTVMvM2xZZ3FoUDZiYkFZ?=
 =?utf-8?B?RWo4MkdyaDUwNmwxbUhrT1A1MUpMS1paUVhTcExnaWx3YlV1Vld5ejlBSFpz?=
 =?utf-8?B?MVNNdko1VlJmbWlYbUNQdjRRN3BWN3VCcUc0TnBYcytjME5HUnI5bFh4V2dk?=
 =?utf-8?B?M0tjVEVrdDVFM2lnMWtuSE4xcmVPN3lNaXFVQ3c2NXIyNThNbDRPVlVOT3k2?=
 =?utf-8?B?RmV3a0Q3TXVsdzl4MXhmOWVBdWQyZU42NUZBSVdGZkN4dDN0ZkFtY1RJL01m?=
 =?utf-8?B?c21NVWtGT1ZGZmJXZ1JwYXl3WjF6ZGJSSmtwR1ZuM2lQanZJK3NSUXduMzBQ?=
 =?utf-8?B?TlJBN3ZCSmhXdG85d2daMC9HSVRYWlpaZjVBaE5meUNBZHN5T0lvUit4VmdW?=
 =?utf-8?B?ZVNkQzJhSG1kTkc0ZUozQzdUdHMyQ29OMEZCVXYxNmdNdWNsb2c4U3NITVYw?=
 =?utf-8?B?d3U4Rk11d0hFa0RzeisyQmErdXAvMS9sc3V2UHhlZms1SndGYXRqZ0Z6bCts?=
 =?utf-8?B?L2VmbjlYb1hZY3FOUGU1U1NVeC9zUk43TGV4WmMyNEEvTVVpZFFpZ0k5U1NC?=
 =?utf-8?B?NnBJeUtRTXhmYXpXdnRUcWp3NEgvZGFNbmwwRXczZGFiN3hBUkcrVHoxb0tV?=
 =?utf-8?B?eW9YcWdpbElZK0c2b0xPU0d1OEs2dXQ1Y1ZRTUQ3Nitpc3FDL1F3SDFoQWxs?=
 =?utf-8?B?S1duaGhIOTZHdzRSb3NJSFZPWlRkSHJ4SUlybXV6WHNQTWpNNU9TMVhZNE5a?=
 =?utf-8?B?NHBxb3AyTHBYOEp6bWhCQkorT2g2em5LcVVTZEtjQ0JVdEd2UnNqL2E2NitZ?=
 =?utf-8?B?MlRmOG8yV0lBcmNzYnBFNkVXREFqQ2ZVb3pHTjJhcWhKZENxOXMyMDgyblBB?=
 =?utf-8?B?TzN1NkdtNnlnTlNVZ3ErNGk4VmY1aVNlNktnTnVXbUVWOG5saU9MK1lRcnNZ?=
 =?utf-8?Q?y5ZpY6cZgxfoXRVO3Z5q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RXeTRqR205QVFpaStNVm1RcW13TExYM0l5Ukh3aGIvV2tsMlF5M0xHM3Zk?=
 =?utf-8?B?aVd4OGFrRXkxZTdRUDZOQm1pcERNcGZobWtWU0pSckxqNDNFVXIxazNTOEpa?=
 =?utf-8?B?QzJFMXdsT2pKMkFJSm9UMW1pMWdEcUEwWWV6aWpyb2txME1obzZ4NnhkYnlS?=
 =?utf-8?B?ck1kZGVXRUhuSVVpNVpLTytya09GWnF4UXU1MFJLMVJIYUo2N295N2Z3aEdz?=
 =?utf-8?B?aVRNTDBLK3BvWGRYUHhIV0JZaWNkMVAzeDFTWmhTS2JnakZLUlUrSFJOc2lq?=
 =?utf-8?B?aS9CejJzd3FIcVJkZ0pGSDF3aTNFRUFTU1AxeC9TdzRUWkpMK1J3UVdqdVZp?=
 =?utf-8?B?NDZuWklxUHNqN214Um9YQ3R4QWpFRFphZ01INFB3ekt2Rjk4UnlmUk5oZFYv?=
 =?utf-8?B?RGpzOUVCdlRuSHJtcEpjM0pXbGJXanI0ODNwWEhoWTdHeHUrOWRiZEJoQWZj?=
 =?utf-8?B?QTh2L0Q5dTErbzVQSDEvYk5qYXFmeldrVXlUaTFsZ2FTZzBHc2VpUGNRYmRB?=
 =?utf-8?B?dndIOXRpVXVPd2owSmx2RmlYUTY4dFpSWFNtblR1NUFUdzVDQlJFazBmeldy?=
 =?utf-8?B?bXVjcnBpb0l2ZVMzSXNCYjRtL1BwWCtxcFJ1VXVyWEZxOG1JcFhVd1owM1pP?=
 =?utf-8?B?R3VRMlkvVzBWdTkrajFFYk1sQk1KQjRQcFdHTU9LT0ErbkNwRVFCMW1BYTR4?=
 =?utf-8?B?L21yNEM3aFdxNUp4U3JibmN4d2hQZlR3RE1kRjlVdW9YdWNaWGErVHUrbWRD?=
 =?utf-8?B?V1lRNHJISWIwTVRCMGlad0JtU2JQcTNTaXFvMTlBVXB5cXE4NUxQdFVwT1c5?=
 =?utf-8?B?NXJCaWV1VE1FTGozVmRXVmR2TVBWa2dEVEdwdm5NSHY4RnNhcFJHenhvQzIw?=
 =?utf-8?B?RTdnV3VtZFg3UlcxbWkyaEdOakFUVElnaU5GZjZDY1RSNjByVHZqZlpmYVlt?=
 =?utf-8?B?bFpZL1cvcGs1VGVzRkhabGd2V1huVEs5L2Z0Rkk5VHdOSEs3WkFYWWsreXBM?=
 =?utf-8?B?RWFNRHFrVGVENU13YU15RVRGeDYzQ2xYTVcrcnVBenlBZlV5WU5vODR5S2pS?=
 =?utf-8?B?cFFNRit5WnZOaURhdjQ1MnJyandqMkxWTk9yVWRDZDFpaUpWVmp4WGtheThM?=
 =?utf-8?B?dTVkMVdGbmdBVkR2ZUFRT0NtNUw4cTVNcTNWTlJZY3ZFTDBmY29uVmM0NjY2?=
 =?utf-8?B?M1lXa3hDM1ZVV0kwaHc3eW9xdEpTdUdya1ErbFlIakVidkRGQVlMMnpyNFZw?=
 =?utf-8?B?d3FhdmFWRnpJYm1valgrZTVnY3VHdWRCeDlZWU5pRXUzMy9zQnBnOVpvTEFn?=
 =?utf-8?B?cktNTDhYYllhQ3NKRmd5eWxKSHd5Y1ozN2pZdDBZblR6MUJDK2VzaXRMNWZk?=
 =?utf-8?B?SEtFZVg5Q1VsclZHenJ0bGhoUEZvdWUzcUkrT2hDTlBpVE1SNUZQUXBCdnMw?=
 =?utf-8?B?Wm5WRGFjcW9SV0xUdHdJeFIyeVFLb1ptbGRVQTVxL0c5a2ZaUWZWRmxOQ1Ax?=
 =?utf-8?B?ZENuRjd1aDMyRTlMcEh1SFV2NWpvN3lmaC9pSE1UcUlGSDYybENBSDZteVpi?=
 =?utf-8?B?RVFWd1hiMWRQUjhmWG41RkZKaXlMQTJqSmpoZUY0Y0VxMFI0ZW5BbExSR25v?=
 =?utf-8?B?dzhDRDJNNFFiNXlyMFcvM3ZIUjBreEo4ZFliSG1yeGVMeDhQbHlXcTZWS3lM?=
 =?utf-8?B?TmhoTFI3ZzRUOXRqNG4vcDJKeituWnJHZVRQM2NhZHRlT25MYTFzRTV5Y0Vz?=
 =?utf-8?B?TlZtTVVQeXNneUh3TnkrNlhSVURqTk8vQUFQRFVrMEgxZXhkZjFNZUlyNVFv?=
 =?utf-8?B?OGMyZG9YSVVyTWQ3K0RuSFA5SFZSTHd1UTRVU2g5UjhZN1RxT1prSmU4M3Vm?=
 =?utf-8?B?ckdxcTFOMm1XR3BJUlBPYWZZZlUvUXhRUDFWZ3RUSmdGTzFzbzJ4UWkxbzhU?=
 =?utf-8?B?VXNQTzREZGNRREtoVVlYV2FheTdvY3JnZWVHSmNxV1JsQVdWQ1lYSUduQ3hV?=
 =?utf-8?B?Q29JUGM0UUEwbkVvQjhCZ01iWW0zODJIVWZQelIreUJWUFBEdFpkM0tKc3FF?=
 =?utf-8?B?RGZzZ1QwYkorN3RxMU5DYzVyOUhVZEZGbEJyc2l6V1J3dW1xMmtndWp3S09I?=
 =?utf-8?B?cjJ4d2wva3g3dW5nSzdHcVB5THh1ZVNBbU5pZm5lUHZMT25ZYmtYQjRNZFdp?=
 =?utf-8?Q?uKOBzkfJ1AHfFA484m6jAxE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8f1138-18a3-4319-062f-08dc942116ad
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:41:41.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hc153ktRFrXCbJaj4JS5NcunOZBhbrxspPcnYppPI5+KyYpMMCfIeK1fyVSe3+4UaJNHnCIpm4Mq3yd0xpDB+7Sklrr+/MqCPUIgJh1KYUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6377
Received-SPF: pass client-ip=2a01:111:f403:2611::72d;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 6/17/24 9:39 AM, Andrey Drobyshev wrote:
> On 6/10/24 11:53 AM, Andrey Drobyshev wrote:
>> On 6/3/24 12:19 PM, Andrey Drobyshev wrote:
>>> On 5/13/24 9:31 AM, Andrey Drobyshev wrote:
>>>> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg07223.html
>>>>
>>>> Andrey Drobyshev (11):
>>>>   qcow2: make function update_refcount_discard() global
>>>>   qcow2: simplify L2 entries accounting for discard-no-unref
>>>>   qcow2: put discard requests in the common queue when discard-no-unref
>>>>     enabled
>>>>   block/file-posix: add trace event for fallocate() calls
>>>>   iotests/common.rc: add disk_usage function
>>>>   iotests/290: add test case to check 'discard-no-unref' option behavior
>>>>   qcow2: add get_sc_range_info() helper for working with subcluster
>>>>     ranges
>>>>   qcow2: zeroize the entire cluster when there're no non-zero
>>>>     subclusters
>>>>   qcow2: make subclusters discardable
>>>>   qcow2: zero_l2_subclusters: fall through to discard operation when
>>>>     requested
>>>>   iotests/271: add test cases for subcluster-based discard/unmap
>>>>
>>>>  block/file-posix.c           |   1 +
>>>>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>>>>  block/qcow2-refcount.c       |   8 +-
>>>>  block/qcow2-snapshot.c       |   6 +-
>>>>  block/qcow2.c                |  25 +--
>>>>  block/qcow2.h                |   6 +-
>>>>  block/trace-events           |   1 +
>>>>  tests/qemu-iotests/250       |   5 -
>>>>  tests/qemu-iotests/271       |  72 ++++++--
>>>>  tests/qemu-iotests/271.out   |  69 ++++++-
>>>>  tests/qemu-iotests/290       |  34 ++++
>>>>  tests/qemu-iotests/290.out   |  28 +++
>>>>  tests/qemu-iotests/common.rc |   6 +
>>>>  13 files changed, 490 insertions(+), 117 deletions(-)
>>>>
>>>
>>> Friendly ping
>>
>> Ping
> 
> Friendly ping

Yet another one

