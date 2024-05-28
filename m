Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AA7C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxrD-0005tN-Le; Tue, 28 May 2024 10:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sBxrC-0005sx-Ex; Tue, 28 May 2024 10:31:18 -0400
Received: from mail-am7eur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260e::700]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sBxr3-0002b5-FX; Tue, 28 May 2024 10:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoLYMA3tGiAmaC/psmW9As/ZpiAl9dgB3flZujJQjbJ4CE1AGCaYyUsvo1aqnO/E0gieU0q+7x40f76lCr2L8eDfDDVjnZPGQ503uUZjS+MonrAlvRymMll0Ol9+6BN7cpJZNeqidXFC+m9qgh7/gDrZ21AAfFtKZH75tmN9UqqLiwG3ARQ+g2nWluJGoMGvzFwVtlPuzR4JtwOFizTWE7hU89y10LqfkfOKkzZMIoQ3uT+GNZQiUKEVqp+XlP6wG6nrpc6hahVfblPGuwoS/g7LPqQhKmuk0GOgysnInvWhDXAq3sckx63sQp4+hsfiM0EaX3oOyGAjYy8i9xGc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63kyFGXgpJo+zXC8uUiiEcJJ6+QyCjzVl36Mr/W0asM=;
 b=B74foqPlqXait+K4i3cltn5WcpoPefO7uWQAigIgv8xnJrdcEkT2WRB8C7ks/+8fRuWBOyFNFxd9nABZUt8c6TXeFdY5x31BBQ/aJbtr8qZ+mEFBrquhjPA3gigR4UEdKO/9albc3DKg5idBm5KYKMH7NNo5XM97BTVgJaFhlRADmALryXFJfeovOAjuKQ+rCvp8sCXDkWJnhkBaPkw0TwcxpdNu4p//44dT7SrKBoHWwvBQ5NhKlc55Y4k+yGu7ASCaHqjelC1zBmRmAuStYxmf/hyLR88f3FjizsIJl4NonM47rAn4yqUWKGpORpU4+nJQmXSJBXVWrNic16WJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63kyFGXgpJo+zXC8uUiiEcJJ6+QyCjzVl36Mr/W0asM=;
 b=Y2P7lApme9tpCx5NqUJaNi9jc21mcHYFsdDdzCMpDuQEHjhFDgZXcVTYcmS196Hb2ha3M0MSOTuLGM+k5hD8l00jZB9BLAWPbAsQ9RORaL8b2mX/IA9chLWpsVRJ9CK6AcweCbCy+nfpjZcdEk6eI1Sry3LLUVd2f1kConCJxSiC06nyYTdEzt3v3bYSJrBCtrEiIEtSfN2+iK9IB6EzKAnUHQTfBrvrb/CmWOsoF3saHI5xeYr62L+FFG60Q0Xs2JTTvccFmPqtQsiCov6s2EfPhGwoA8S1BgLmQYfDF0mBdQkv38ZF50QROxOzlCTXbmFfAgnn/v1lerXm796+8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GVXPR08MB11183.eurprd08.prod.outlook.com (2603:10a6:150:1fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 28 May
 2024 14:31:03 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:31:03 +0000
Message-ID: <345bce72-ac21-49a8-a93f-f0450af4edb3@virtuozzo.com>
Date: Tue, 28 May 2024 16:31:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: drop force_dup parameter of
 raw_reconfigure_getfd()
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20240430170213.148558-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20240430170213.148558-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0026.eurprd02.prod.outlook.com
 (2603:10a6:803:14::39) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GVXPR08MB11183:EE_
X-MS-Office365-Filtering-Correlation-Id: e77117fc-f000-4d5f-a1df-08dc7f22cdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RENDTXROZFBwU29wSi92VnExOUxwYlhiZ3NRSVZHVkFZOGg5NVgvdGV3STQz?=
 =?utf-8?B?NGFqWnVDakw4UlFEZ3ByWVJTM0JYaHZkKzdQTHhoRG10MFoyL3o1SlRVRS8w?=
 =?utf-8?B?SE9IM2VpT1RNT0FqMllFdXc1OForazJKMS90OVdUalF1VDFqTURSOTZyY2xX?=
 =?utf-8?B?OXlLSnNTczZXemFPMU5xdFkzbzl3aks2RkZZY0pGd044Y0kzakVkMlFMRExN?=
 =?utf-8?B?ZkU2OFI2MTNqZ2J3SzE0UUxvclRaR3ROMHJaWGg1N05FT3FwaytZOERYVk5N?=
 =?utf-8?B?dmExWnZTamt6NXlBRWJEMnNtRlNaaUgwRTRGazQrTVFLaGQ3RUdTN24wMDRl?=
 =?utf-8?B?aElneW5iMXlnKzJsVnF3RjVYY2Y5d1VYVFpCUnBqUHZ3OU5hTGM2bFZoSGdH?=
 =?utf-8?B?cWNIN1VDd2liUk1ldU9ScjdvMmp5L2V0ajVNclhZWFo4QmsxU3dqUDIrVEcx?=
 =?utf-8?B?QWNOMlF5VGZ0cys4dDJnbzRrTGcrNmVFMENqa3ZPeHg0dEVrM3NsaHF4K3RK?=
 =?utf-8?B?TnV2OXdmU3VGRG1BSlJ4ZVdhVWtqcFhCRjVEcjZscGIyS0NGNVhSZmV2WVUv?=
 =?utf-8?B?TjR1cHpvRFVZa1N4NS9iZ2V0UVdDNG1rTEpQczhTSGRKS2pzYVJkTlJDQTJ4?=
 =?utf-8?B?NVZMRDJXaTd3Y1kzTzRYTkRrNnhpYnJSNkpCQ1g5bUo4RkF4c0JhUFIxSGta?=
 =?utf-8?B?K1JBNFhvMVpQQTFNNCtsWXQ1d2RDMk1lRlBhY3pyNHBPekJmWTFaMkZab3RL?=
 =?utf-8?B?NXZSaDA3aHlBWHRrcU12OXFzeVQ5Z0oyN09DMGovV3NMN0s4V2FZYkwxUVA1?=
 =?utf-8?B?eDQwc0F5NWw4b2dhTjFZRGxocWNXVzBXeG94UXNBSi9CWTRMak53aDUwZm1R?=
 =?utf-8?B?a3YwL0pGRmE3a1ByeXNNZStUbHdweTE1WDliaXM5S2oxMUdmcWJDMXpuaXFT?=
 =?utf-8?B?ZC9sajZaUTJWL2VabHB4by9ObVNENXpUWXJlUjk3SXpnVFpscStjc3BZVUtR?=
 =?utf-8?B?VTlhbHpmc3hNQUpZVUtScVFSb2pyVVVTbW5BMHBLL3ZjYjRTaG14U2RnbzE5?=
 =?utf-8?B?bjMzYUJuRnNsMTlDQjl2dCtDQXhzWFVVNnJMdWpYbzkrcU41K3RSckFOdEJN?=
 =?utf-8?B?MTg0RXhkcGh5WnhobnhETExoYzkvaHlwcjE1aTRzOTFTRWQwSzdodXJlYlZZ?=
 =?utf-8?B?RjJxQ3IrNGFBcDlSZENDUkpwaVBUc1NGck1xbDRzOURONVNGeUJ5YVNzeVVi?=
 =?utf-8?B?QXBPZ2o2eTFCMVNRd0hDNEJCSURsV1p4Zk1mbGxqM0NlUVBreHhWbnBUWW5v?=
 =?utf-8?B?VnhOcFpqOFhRR2ozQnAyQnJJTmZFc08veS8zOWlCcjN0Vkh2NHFSdjRNOEk5?=
 =?utf-8?B?UGlCYW5Gbzd1YTdFLzBOMUpEYXU4TmpkYlA4WmNKSHBZT1l3cDZYWFREb2wv?=
 =?utf-8?B?OTRMUlhUczAzRWFMcHhaZVNoVHpqcFlUVWx4WGVBcHNrbmJHSDRqRTNEbWE3?=
 =?utf-8?B?ZElxYWJveFZMcFVid0lBbjFrRkllbkZlZWx2UEtDU3A1Rkg2OU9tWXljb25K?=
 =?utf-8?B?TjFCMkdKaVZFL1VIdWJNVVg4TTMzMStER3FOVHVTdUVWc2p4TXBjL2VFT0Vi?=
 =?utf-8?B?WEhsL3VmSmw4T2FFT3M5UkVFSkVsSHVtN2hvajNZYURvQU16QndBKzRQdU43?=
 =?utf-8?B?QUs4eFhNdW1uL2JBYlJXNkVkOTJCeFFsSHg3cm5uN2FDM05qZlk5MGp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlUWHRVMjNDOFlCWUJaZUNFY0c5SG4rYWZ6NFU0YmlwdXBuekZXbzUxTk9P?=
 =?utf-8?B?UnNYVzF3R2tmZmR5NXluYVhmYzhlUjZlWVRTeVNQZWN2LzNFMmRTSll3ZkFD?=
 =?utf-8?B?aTIzbjREZURVeTVnSEVZYTNvbkdOQ2JMZGtRUDNRMzRvSy9wNzRrNENHOHJY?=
 =?utf-8?B?aXFsUDJIclNNSkU5OUZDVldPMzRXeXJkWTJnTVNuUWFSQndmTE5pTFRhajhQ?=
 =?utf-8?B?R1VLRHkwZzVWa3Y5TDBpUVpwVHhjNzE4TkNkdDFJWC90TFBXc1NRNGk0am9Z?=
 =?utf-8?B?M2wyQ0Z5Q2pQck5saXJob0tEQm44TlZaV24wajFINGlRaFlhVUErK2RpalpB?=
 =?utf-8?B?a2Y1SisrdXZuakJEMW02Snh4Q1BSN2daNXRkVmZjeUk1ZDZSVEFwcFlQU2Zp?=
 =?utf-8?B?UlNpNkQ2cmRyYUxadjRRcDNrVmVHQ296TjhIOGMxNU1iLzJhaXJDcG5Cc3h4?=
 =?utf-8?B?UnlKajZPN1RDR1BHb1ZHNjN4cjdoODE4aFhuS05nSkhla05xUTVmNkJ5c0xN?=
 =?utf-8?B?WDFVWk5CY25FbE95Y3lQc0FTc1NCZ3lHTWFkK3A4OENLV090WWJPYU9ScGlm?=
 =?utf-8?B?UUk4V1kySXNpV2o1emNsd1hFTFZIakZkRGV5SDJQQTJPZDVvYTRlTmdnalhI?=
 =?utf-8?B?Z09DamdoaXg2aXNQeE8ydUNWQzZZdjg1c2VmNklDV05vSFZnNjlTcTdlNEJ4?=
 =?utf-8?B?UkwzNDJnTUYrZTRJbDlpTDlrc1hOcDMra01QOWY4WlhMWUNuVnNUS0RCOHhI?=
 =?utf-8?B?ZnUwVVRveEN6WWFPVW54Z3Bhb0JCSzdFQWR0WlVmU1VOM2x2dGpudjJaMlJh?=
 =?utf-8?B?U3paaUtwb1ROVERpK0txNzhMM1lSMUlwZ0NUbUwrMTEyb3RyMmJocytLV1Fo?=
 =?utf-8?B?dDRQaTJxa0FSU1ZFNTRoSlgzOEhiRjB0dFRKWjN0NVpGQjhvL0VaL29NTE93?=
 =?utf-8?B?b0lHd0dpYzVUT3RKMlUxWEpVV2w5aGRMQjVyUjU3aUU2SFM4MXhBbUg1RkF3?=
 =?utf-8?B?aUJpd2FFaXdrYlNLRmU1bTBTWmtpekk5aUJpcHF0dGVtMSs5RnlHcmFobk5i?=
 =?utf-8?B?d3BSdG5VQTJndVZOQW9DWnp5K1M2eS9SWlh3bTZCbjFva1dYRGxSckt1VTNL?=
 =?utf-8?B?cHdhYkxxQ2dYdnZpeTJSQ0V0THVnblFBVzg0VG1sK0ovWVVHM3ZuZWJoVTZs?=
 =?utf-8?B?TkhnR0dQc0pBVnUveTNtc1lOeitoWWJ6K1FCMUYxRFFGaTN6T21VcUJ2VUx1?=
 =?utf-8?B?MnpvcFh3a2dVMG8yMDlPK2hZZDhjNHFzaUp6S3dOTkNaRnRSMWl6cVhpNGRr?=
 =?utf-8?B?RWV2RVVzdUhKRjlkNEFOZVUyTGpHUEpmb0k5eDRvTmlxN0hsUXg5Mm93TEU2?=
 =?utf-8?B?TC85RE1mdGNobGN6cGRqZ1FQVWhULzlNSXFEZUxCZ2JsclNnVzlJOGdsNm0r?=
 =?utf-8?B?Uk5jWUFJUXVwOURFYWxuQXplYUw2b1lQcXdKaG5HY0NmeWJGZUpwdUg5VEMv?=
 =?utf-8?B?eklTVmY0MEhMTnpzZCtEVlNRbWRpMkdKTVV6UWtwUUlvd0h3NGo4WEZMN0Vy?=
 =?utf-8?B?Mm0wVHpUaHl0NDF0MFpEbVdYMGNIUFBxcStTN2VGeGtaOXVwNFdWZW9iSzBK?=
 =?utf-8?B?RUhKNDRVa0FSWWF3dk51a0lSOUZjQVY0TkdWeGNzYnJrYkNYUHhOMmlEU1Q4?=
 =?utf-8?B?YjVqcC9La0JscFBPUDBjMnJnd0tjNk9yYTBlTUpjZUZobzBmSTd4UXV2enBn?=
 =?utf-8?B?RVN2Y3dORGZiWXZ6cHhuNU5kNzFFYzNvS0JNaytpOHFuUlhrd1Y5bTBTTUxF?=
 =?utf-8?B?cWpyV2ZXUUFDaGo1a3dYVXZtSDFwZHdHSkZyOHFYR3ovWUFmS29WbmFFMHFv?=
 =?utf-8?B?OU5tTW55cVBRdXlndm1BdEhoS0UvM2E3YktxZ0dpaTUyd0xjRlYzVFVadEpV?=
 =?utf-8?B?MmlSLytPS0VkZk5IUWV2S2xPcVM0Y0lFQmxDZCtOUUxSVVYyU1RFK3dRMnNJ?=
 =?utf-8?B?YTBFY0d6S3hiYktDLytjK2RUWEQ5SkZSRjNicTJzYXRiUVorTXNGTkxxb29Q?=
 =?utf-8?B?Yy9XWUY1a01rYmNQMDlSNEgrMDRiQzN0bzRIRUlXSGJ5dDJVbXpEWk5JWHhP?=
 =?utf-8?Q?vSU7CBAeZ0Ji6lwR8QY3EsUjN?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77117fc-f000-4d5f-a1df-08dc7f22cdac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:31:03.7295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6chhxfUz1V3IEsfcyMB+55t7z9rIwng0rSToTeYOhCCHQYlL5llSPN4wAjyrk8e8RlrEU/SWCzz1IofurTpYfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11183
Received-SPF: pass client-ip=2a01:111:f403:260e::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 4/30/24 19:02, Denis V. Lunev wrote:
> This parameter is always passed as 'false' from the caller.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   block/file-posix.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..5c46938936 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1039,8 +1039,7 @@ static int fcntl_setfl(int fd, int flag)
>   }
>   
>   static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
> -                                 int *open_flags, uint64_t perm, bool force_dup,
> -                                 Error **errp)
> +                                 int *open_flags, uint64_t perm, Error **errp)
>   {
>       BDRVRawState *s = bs->opaque;
>       int fd = -1;
> @@ -1068,7 +1067,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
>       assert((s->open_flags & O_ASYNC) == 0);
>   #endif
>   
> -    if (!force_dup && *open_flags == s->open_flags) {
> +    if (*open_flags == s->open_flags) {
>           /* We're lucky, the existing fd is fine */
>           return s->fd;
>       }
> @@ -3748,8 +3747,7 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
>       int ret;
>   
>       /* We may need a new fd if auto-read-only switches the mode */
> -    ret = raw_reconfigure_getfd(bs, input_flags, &open_flags, perm,
> -                                false, errp);
> +    ret = raw_reconfigure_getfd(bs, input_flags, &open_flags, perm, errp);
>       if (ret < 0) {
>           return ret;
>       } else if (ret != s->fd) {
ping v2

