Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88504C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3pN-0008H5-5O; Mon, 03 Jun 2024 05:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sE3pL-0008GO-13; Mon, 03 Jun 2024 05:18:03 -0400
Received: from mail-vi1eur04on20722.outbound.protection.outlook.com
 ([2a01:111:f403:2611::722]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sE3pI-0008Fw-Gm; Mon, 03 Jun 2024 05:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkL8SQmwkIi+HEZCDTobxt2CacNi8mpCk99FGIVEU3ldlzMJvhygkqOyFDELe07rvBLTO8tFHuk/2wHlbWb5pP6QF4TjArZ30of/VLQBfutEsTcFOcq/uo3WjnV6798xEAC/BxAp2zKizLyC11AJuLccw4hHErDdv2/1u2RyI+qcP5giS9Nk/MY1/jc2JxphSOJAWcPbJP10rVzFDdbhTIkzFhXw55NwIu4KuWoj7aKAbTpJlXGW9qX5cYskSKyQtDpg63LWF1eS3lOZ9pYnLRUXr17R9gwwhC1XlaQrgRZs8TdMKQFdYzcQz0hrmaJ5zF2toKmF++Hr5Dp1r4y7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2q6J62ISNx62Vvf6Tq3ChSmMtA0VCD0mezqiVd5yI=;
 b=HjgpGCj0DgTrT6xbeARg76OniVUKkSid7eP3d+jpkKZbJvs2/xWmsYBswYaCx8UsmBH1/f8vOi2Clw4DJCY/aFQCks1exjmV/Eo4yexbqx/V5jLSimuw/LiHXwONqS97jcdKIO8avURwl9reuQF2J72EsDUe4Gdtd1qjFst2KlOM6cmGDeDsGg89HxrBg75U3rTGcx4uvvcdTFhtLh0jj9JZKKNKxK4gY64oUoR6teJF1/MahEASFUSk5s5B9xoKbnIljU62bgmiAgt5G4JactRHouPuiadLqg5PnJsbNdMBDeH7RLTgLKfpbqlwStPZCDekIgdIUieMq0sGXuVaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2q6J62ISNx62Vvf6Tq3ChSmMtA0VCD0mezqiVd5yI=;
 b=N3M3b0WeR3jLpIZ1WQ4AyoPKbuB02DkqhGoneZ+3ryv5/1jUuMmJ6RirphrM1JQ7t7orvzjN2j0KGGQ/glB47pv/e2rYDPkX4/BuiQJelXrt7w5yhiiIV4Y8Dc5MlKjYSVRRWaPo7ei0/7Pvx64IoZxdOLOJ81FwvV0CKO24ESNAG/EvyCnlEysM9YT18HfttLm9j5bG07GL7T1HHHiuAn+NYqz0XCUY5uVi4O8M/KtP5FIOBn+X/7kha7O4Nk0ZGIUQY5kuvhhteZ+bbd53QYTqWkuvt1zDuGNanmqrJKUmJXkvqCn4x2B0Shv5M3cp9hft2ISQBTtM2WpRI9JeHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6177.eurprd08.prod.outlook.com
 (2603:10a6:20b:283::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 09:17:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.7611.025; Mon, 3 Jun 2024
 09:17:53 +0000
Message-ID: <cbcee281-fdfb-4a7a-b33f-b71d90368059@virtuozzo.com>
Date: Mon, 3 Jun 2024 12:19:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] qcow2: make subclusters discardable
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: f04a390c-efc1-4a18-830c-08dc83ae0c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjlKdTBZUGdYeHNzSWF1dFYrbUJJYjBVT0hlTmR6TURaZ05HaitHbDliNm1q?=
 =?utf-8?B?ckJQU3g0aDJESVYxTkkxZE1NblRwdzhpczlVUkc5cUVzRlQwWTlTaUJpYzZ4?=
 =?utf-8?B?YTdLVHowYjNvUzZDRlR6QWdranZjNjFsU3RSN1FmQmlHRzd4dkVTdUdSclVj?=
 =?utf-8?B?bkNodDN4d01IblFtZ0ZQR0ZkUjNqS0xuYW1rY1o3SWtsSGdCZ284SXJ2RzZF?=
 =?utf-8?B?UVdCK1d3aDNFL2hnWWxlejVCMmVlZWJNaUJ4WUN2RkRUWWdneStONStYZFJa?=
 =?utf-8?B?d0U0V2x0RnpUc2hveTJ3OTJMQ1dxVW5YZFcvbEJQNUEzK3RZRTBVUVlqeUVX?=
 =?utf-8?B?aGVWdXQwWllDYW54UXh2UERUeUNaZXpoc3EvS3k0N3p4UWFrbURrOFRwM1hD?=
 =?utf-8?B?dTJIVHZKakdiTzJGdm9BWmszOHI1bGhNUThSMS9GNjVWUkhJb2JoV0JaN0k5?=
 =?utf-8?B?cUl2aThHU2FCaU9GSG1YQXRoZE8rL2UwUnpPZ0J1YlpaMHVCSDdKM0RkL3g3?=
 =?utf-8?B?cGpMZWhzTVE5VHNoc0lOYlRVS1ZEd2JmU1oycnNsQjZBYVdCS2tOdDhyYkY2?=
 =?utf-8?B?ajFnZVBDL3Z0RlU1ZHZxM1g0a1pGVTc0SEt4OUtKVE1VY0lIcytVeGdCWVBE?=
 =?utf-8?B?b3RCaGNoWDg3WjU0bkRBQlpFZkN2dUNhVm5Cc0lMQTArR1Y2SDlzU2I4RGxV?=
 =?utf-8?B?SVUzWkswVGczMmZXU2NjdGxXWFNyRUdCM3dhWDBrNDVBR2ZUTE43NVl1dGlS?=
 =?utf-8?B?VXVmTm1BbmxTMWJRQlo5Vk44WXhtaWRYaGM4VGZqU1RwSUhEMmZsYklDZU5E?=
 =?utf-8?B?ZVkvQjJrVXQ5cTEvaXRIM2kyRDFPcHJFMzUxdWhkZUZoNVQ0TWVQMXFVVVBv?=
 =?utf-8?B?NW1ucFlwWGxHcFVxdmZtTkZpWmtlVGgyL2lhaGRHTHRsN0dIR1ltVlMrRXRO?=
 =?utf-8?B?Sm82SkN3NHFicVk5UW5yTzlLeEh1cmJvNVZybHZjM1Q0eW5mekxLM2FjOHgx?=
 =?utf-8?B?a2dJN09PbndIK2RLSzVwNFg5cTB4MW1qV1JVMWN3ZDVTMFhleS9YUm9Ka3hl?=
 =?utf-8?B?bEtOb3FpSWNLWkRxQ1kydEhxNTZRYnpOZlNOTnYyTko2KzJGeEc3V1l3am9G?=
 =?utf-8?B?M2k0SUdxY1k0TGgrS2ZRYmFTdUNQMTlnalZCbEFOekFBUW1hK2tHY3JuK1BM?=
 =?utf-8?B?MWp0K0lDbndNUU56Z0lkOTY3dWZvcHlmS2JXNWk5cjczR2M0amdFZGZ5eWhM?=
 =?utf-8?B?UnhMMTIweTdscVFhczlBbHVtYXJMam4wQVBRcWVGUDBRSHNHVHp0R2NWT0tC?=
 =?utf-8?B?NG5xTGZMRDVVcDc5cEhJeHF6dERzc1R6alBlVXNhR0NteFJmZ0d4VXQ1R2xn?=
 =?utf-8?B?andkTmltT2xrK0pSRDJZUzNzLy9NSXl6ZTlxSjQyVThUYWkvMjdLZHdaOHpP?=
 =?utf-8?B?ZnlrRDVLUUQyY2MxZHl4Y0o5Wm9lTlVTQXd1RWpJZG5nbHRHY1RnWjBOdU43?=
 =?utf-8?B?T2h3QU53YS9VR2JmMWFMVGxsRFI1eS9idE0vTTFNY1BmK0RzbGt4SzQyaUFw?=
 =?utf-8?B?U1R5WW82L0hMN0VmbG0vN2IrUjlLaEU0YXU0Y2pqZEc4V2RyNVkreHVqTlBl?=
 =?utf-8?B?NlBWZWFVYVM4WllHTXV6N1hpcnM4TlU1OW1aa2pNdU43M25YeWlFVmprbkQ0?=
 =?utf-8?B?K2J6aGRWUlFTRlhQblg4YjhqTXFCQUdxeEhzR0ZFeWJDZ0RQakF5SDNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFhXZmRtYkxQMkV1emhIbXZqSllCUEtML3kvN3dreG55KzVaN3dMVVlZK1FD?=
 =?utf-8?B?eVFOU3IyYzdEU3Axb0lJQVNoVTZKWVVDRGw5TlN1Q0laUXNsVEtiMndlMHNL?=
 =?utf-8?B?RWZ4c1ZENTd6UG1VNE01bFA3ZStObm9LRkF4aTdKZ3VIRkJ2T3ZpQXpQOGNn?=
 =?utf-8?B?YXgzbHJ3dEF2UkF2R2tDRU1QSDZFQ3NQbmZ4cTg1U1R4emU0UkhjSCtlK0NL?=
 =?utf-8?B?RFl6OU9HaTlKd2xESnppams1VkREbFhOYmlmZnNhVnQ3U0xWZWxONUlrdU9F?=
 =?utf-8?B?SFQ1eUZCa3BzZW9XMWo4NGMrY3JhR1lROEptZVRkLyswOUhBd2RBV1N1T3Vq?=
 =?utf-8?B?SGFEVGJiZnl0SGphTGVEajVOY2xxQkJqUzYrcGNkZWk3c0ZHWlJLazBydERx?=
 =?utf-8?B?eWV1cXp1RFBObXU5a0xzdCs1REtnanY0OVUwUjk4LzlmaEt0US9abHRvTUZR?=
 =?utf-8?B?TnpQUlVTOTBuSkRubjFhd3JqdVZBR1VvQVVHTlhYOUVROStLWUwvd3A5Q29H?=
 =?utf-8?B?bXoweURBTS9DQXVFK1UvTXR5cVRHMHl5NEJlMlpSL0YweWRLZVp6Z3k1Rllz?=
 =?utf-8?B?Q29oRElqVUMwS0tLNTVHV1BuTGRwZzRvU1B0SGR6SDQrWDJnMVlVNGpRZXhF?=
 =?utf-8?B?dGd4bkJhL1BESU9lcnZ0RHhYMjRPdkY2cEszZDVvWEErZGxzU2lOWEhIc3pY?=
 =?utf-8?B?ek1FcTVrNWRFcFNvaEVZSHREOEZYYWlyWTZwb09UV3FqT2FOdldyRzd5Z3Nh?=
 =?utf-8?B?eDE5eFp5MXRDM0M2N09SaW5HR01wcm12eWNZZHFLUEgzNjlTblAwMkdOaksx?=
 =?utf-8?B?K3dRRlRFejcvbSttRmpQSUtQbFk1bTJVblNDWkZHeWVkNmNvclNoWWNDY0Zn?=
 =?utf-8?B?RS93K09OZURBNzFraTBDbUdYY05oTzJ4Qjk2UEo2dHI5dTVYNThmZVZGSG5H?=
 =?utf-8?B?ME0zaGdCYzBVV3lDNFh1blFxUkl1RTBCZjJxN3ZoL2k1Z2xpYm5BM2lncXRE?=
 =?utf-8?B?N2ZHNGc2QUlWdytTci9SMnBLcjZ2SERiRWtvaE5uK0xYRUQ0ZjBoWmNZVHFu?=
 =?utf-8?B?ZkNrMWlEVnlOcThpUU55WDFJMTVUdGhGRWZmQlVSUUpyTmZ0Y0RWNGNvQURo?=
 =?utf-8?B?RlJvbTNPL0Rqcmo3dUNNWXh2NWNVYlh6SXE5WFdRajhlc3Y3STVuMlRjaHk2?=
 =?utf-8?B?akpMd1ZsaHIvTktXREY5bUIxM0N4aDVZbTJMd1BmTWhOdHdTZEZSQXZKY3Vr?=
 =?utf-8?B?dnIwOGpZUlJUQ3lqTHQrMC9QL0tBRHQ4SjcySnRiRHk1QU5TMWUyTWN0WEpu?=
 =?utf-8?B?TVgyY3BhbUJERGtmY0U5Y1pMUVNKWWx0bW5vcFYyZjZMazltVlJEM1pmcTkz?=
 =?utf-8?B?bGNFVGtMS0dSeVhHUXN1UVQrL044NWVieWVIK2p6T1NITm5abFlKeC8xVElk?=
 =?utf-8?B?U3hFRjAvWUlVMmJNVmlsZkd2T1VOaHdzc0ZNQ1dZdk5KTVF6Z0F1OGNVeW1Y?=
 =?utf-8?B?M2t4M3NlREtubHRJOVN6SnJ5QW40Q2o4eVN4ODNxWWZsbHEvdE1zMWVmWEFT?=
 =?utf-8?B?SDBJM2txQnJ2YmFBeUN2Qm0zTHBoMUdXQlBDdDlteW1DZXFpbDN1M0hZQzJ4?=
 =?utf-8?B?ZXZmUHIxU2hsaHdIL0lSNEJGYzZTWTlSUjdnT0NESDRtZmN1TVJRcm9NNnBB?=
 =?utf-8?B?V2ZKSjdkUEgxMG9xbGRiVnlBZEpjTHFJUkxnVGZhVUVlZ2JRWG8wckE4TkpX?=
 =?utf-8?B?TDBtdUkrRitDT25pZEFPRFBGbmJjQnA5UU50OHRUZlAvSHc0OXBkUjRwN0hX?=
 =?utf-8?B?V0RXZmtOWE15d2ppcm5xbGNlMEF1RlEwMmFUblRVaUo3T1drL2VIb0JmbFdx?=
 =?utf-8?B?dG1EbEp4UjdRUk8rTTJrVHM3ei9JN3V1NTBEZDJWWTNDNWZUaGJ0N0x5MDFK?=
 =?utf-8?B?eWpEZzBiZzI5VU9HakpHd0hjNkgrd3JqL0dRekRjTjArZVplVzczMHpsdVdS?=
 =?utf-8?B?ZXI2TjU4NW45R09qdm5oS05CbHNGT1FGOHp0Yjdya3RCcmtxYVdZT2lQOTRR?=
 =?utf-8?B?VEtuUkJadVZKR0ttNU9CV0VBQnZzWHRXeFozajFuN2tQMlBtaHJlUE04VmNp?=
 =?utf-8?B?cXVQZmxQTXFsckI4ZTh1T0ZGelR4eFRxMlpZRUVyOHNTclFuTWVRZklMS2k0?=
 =?utf-8?Q?SHOsik6h+En0AmzyX6v3WZc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04a390c-efc1-4a18-830c-08dc83ae0c22
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:17:53.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ3eCZfDPjxZmVSVjiZQ5El4x5mG6hM7tBbl8eF4yb5VKbnmIuZi5d32LaNWUYhlusUtzII9sEmzMozpELKL/Gvg3c5ErjXe9VLeWFrBkPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6177
Received-SPF: pass client-ip=2a01:111:f403:2611::722;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

On 5/13/24 9:31 AM, Andrey Drobyshev wrote:
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg07223.html
> 
> Andrey Drobyshev (11):
>   qcow2: make function update_refcount_discard() global
>   qcow2: simplify L2 entries accounting for discard-no-unref
>   qcow2: put discard requests in the common queue when discard-no-unref
>     enabled
>   block/file-posix: add trace event for fallocate() calls
>   iotests/common.rc: add disk_usage function
>   iotests/290: add test case to check 'discard-no-unref' option behavior
>   qcow2: add get_sc_range_info() helper for working with subcluster
>     ranges
>   qcow2: zeroize the entire cluster when there're no non-zero
>     subclusters
>   qcow2: make subclusters discardable
>   qcow2: zero_l2_subclusters: fall through to discard operation when
>     requested
>   iotests/271: add test cases for subcluster-based discard/unmap
> 
>  block/file-posix.c           |   1 +
>  block/qcow2-cluster.c        | 346 ++++++++++++++++++++++++++++-------
>  block/qcow2-refcount.c       |   8 +-
>  block/qcow2-snapshot.c       |   6 +-
>  block/qcow2.c                |  25 +--
>  block/qcow2.h                |   6 +-
>  block/trace-events           |   1 +
>  tests/qemu-iotests/250       |   5 -
>  tests/qemu-iotests/271       |  72 ++++++--
>  tests/qemu-iotests/271.out   |  69 ++++++-
>  tests/qemu-iotests/290       |  34 ++++
>  tests/qemu-iotests/290.out   |  28 +++
>  tests/qemu-iotests/common.rc |   6 +
>  13 files changed, 490 insertions(+), 117 deletions(-)
> 

Friendly ping

