Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF4CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxM8-0001em-KH; Mon, 05 Aug 2024 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1saxM6-0001bX-6b; Mon, 05 Aug 2024 09:02:30 -0400
Received: from mail-db8eur05on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1saxM3-0008W5-3D; Mon, 05 Aug 2024 09:02:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elfUElcc8JdvHbqHJm4sEnwWezfSAY+aTtcVdlx7n4VSmTXQU6dSi94jHmP3XUXIy/Ol0moTuFiI9OlT+fMtUCnszdLdhTPuCRSF1tdRI5SVaP8Lr8kLznKbxJX3EShDhjauIWPqBT46nUREywVcjZXtxU7m1OobNjGLqzG7yKPmxgEqxLbDqq/DiLk+2igflVHB3bkc7QdrEzKCp3O0AAWe9QlgUc9oqHcdcnzLmzjUx4lpgDM92FeFRsv3BX21B2Ojr/5N8UjiY48StmmKA/M+/dGX3eLPxPffdK8/eWnC/S27+7/DbGmbIEBsT4+yATrq9S5iPVxcSG4pA9Pejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAIMDCsXWbPRuNOAAFdlximoz1EcKq3YtBGtRC1PmFI=;
 b=r/TOOtFCwCahTiEaelbfHGNcawGfE97dVzboO3D9a4s0iwwZQjZh44bRGMNOToLFYiwe2/scTnA4ToJy9hT49BVQEdjudWeI7jP4O1DjLDxPZw2laGXslT2sRNrlHIuoJKZEVpgw2EIpf27SuqvdNmXv7ABS67lQ8elFiqKs4eOIHZ4R7+4qgcRKb2lDfOjIoIZb6oBcf++GjSqjReDB1+nlh8XXm7mXYO53fOlpJAK+T8BsDHVqM5JkeyPtH5zisudaanyEEXLUSnTun4k/7bzEFKoxm3u4YwYLQ90Ulh27kXfcZ8Q17NA2HoBmIbWma6L5eNqKToU3uw8qzm06yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAIMDCsXWbPRuNOAAFdlximoz1EcKq3YtBGtRC1PmFI=;
 b=oVfL9kVvGtffu4908Guc0TdHm8beozyVarfGi+O00QKi3UHta9bw9u9kQcJLjGgGMxTkSFC3ypnfqjpNtYTQqFRv72KoDIJ+JVeLMVm7K8jXU0JODamjJjV+tQfgz7PgGH3OxEGM6F7+KxCrYE8I4T4aamtY0GIDdtvLjvM2Ub7Hmwi0LRstpw5LNg+ADvAYdVC7TwVTtVVyg/+gp/87Ef0PIz6S/FK9mAJzThr19EfJII+aqOpU2AGbZjldaXdCe2zZMrq0trxwxvmSo/hwLo8HDmel+h80eo/gdPuPpdU+ZB8uYEcrudiBoyxExVOymvCDNAk6dCadHc7pVimN0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6391.eurprd08.prod.outlook.com
 (2603:10a6:20b:31d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 13:02:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 13:02:20 +0000
Message-ID: <7eadeafa-3bae-4878-a1c8-becb9a73be96@virtuozzo.com>
Date: Mon, 5 Aug 2024 16:02:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] scripts: add filev2p.py script for mapping virtual
 file offsets mapping
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 den@virtuozzo.com
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-4-andrey.drobyshev@virtuozzo.com>
 <ZrDFri3ydbPwuPKM@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZrDFri3ydbPwuPKM@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dad0973-a11c-4a62-25bd-08dcb54ed765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmtXK0Uxem1PVDExR3U1bDF6M2VGQk9Lb0FVZHQzdFRjVm5wUzdhZHBYMXdl?=
 =?utf-8?B?VlBlNlQ1dFNPMkpla0YwUVAyWHY1YnYrOG54UW84MDNMVW5BcXRjQzM0UDVn?=
 =?utf-8?B?N0swQm4xYmJPMjNoYzV5TzBPY2ZLMFVmZ0NQbWdaY1czYk5Zc3RCTnp1cTln?=
 =?utf-8?B?YkJsWnhlZmNYSFBVT1ZlUlZBQzhEQVo0M3daNkhLYW5SOFEvcXlVRENZT0Z5?=
 =?utf-8?B?TE5leXJ4L1IzNnNOdWVHOFVhQjk0ZEMyQ253QkZNSitGY2ZYVTBOdndQQjVP?=
 =?utf-8?B?Ui9qTnA2cjltaUh4cHVDQlN6aEtPUlQ2REZGaWl4Vi9ncjdFK2JDdVp1Rksx?=
 =?utf-8?B?Qmp1MEZ0WVdmbG1qbExaVUg4bW1lbWlvQkloK3FVYmhGTGJsOFFpVVNrSUQ5?=
 =?utf-8?B?RDVqUXFEYXkxOTRVV1dMd3BwUm1HbzhkaE9JQWZrK084cjNiQmprZDU5THJK?=
 =?utf-8?B?ZUQ2VFBHVWl4S2lYNGxiVklJTXZ5QjRFdVVIcFplN3NOMFI3cEVKcXEwL0xy?=
 =?utf-8?B?SVB0R2tWM3A2Vzk3VlNEeVlPQytxanl6amdsZ1I1MHhSNDdNdy93TUp5Qmg3?=
 =?utf-8?B?RVkrM29HUVQxWllOTWRVNDM4eFhpSU53WHdZSGhldklsSlcrQ2Y4OWRXYU9V?=
 =?utf-8?B?cXhwaE0xaVVQaVB6ZTdVL0ZTUjM4b2tFTDJvRXRLeDU3djBLeHZBVXBQZkw1?=
 =?utf-8?B?N2Z5N3ByMzB0cGJyUUpXc3Y5NHhuMlc4RjlkbXFvcW1HQ2w1V3pnZVNrZjlV?=
 =?utf-8?B?UnZtUG00bzdBVXFnNnZhY2IrYnNZbmpyREVQRjd4MWNjRkhKSU5xUVZ4WDkz?=
 =?utf-8?B?VDBWRVNJYndYUHBNdU4vV0drbGluR3pNdkpOZHZkZERwbjRBeHNZZGhkcXdT?=
 =?utf-8?B?cDdtT0duTHBweEx5ZXBGQnhnU1d5RTRZTTF6cFJRa1YxR1F0YUErdjlPaHFw?=
 =?utf-8?B?cHBRSFA2NkdDbURLbHJ6UWRWdEVCMkRHVnVCS2hGcDdxY0FWUnQ3K0JHR0VL?=
 =?utf-8?B?N2xuTjJ5YkJlOWtQWkNMVUs4K1JiMHJST2NLYk5xbU1vbG5KOGxmWElWUEN5?=
 =?utf-8?B?L0JrdmN3YUhBbDJzbVVzdU1qQTVOdTR0WW5kZWlNYkc0YjUwTGh3QTVxMGN5?=
 =?utf-8?B?ZUdJcy9kVkRtZnk1SU9xcDJqc0FUbUdpRU4vQWJicXZmS0Z2MFpZY0FPT256?=
 =?utf-8?B?UU84Umd2S0JmdDlyUURUNHk0M1JIUEZaL3hvQU0rZ0dSTHJHS1ZVeVlQdmlE?=
 =?utf-8?B?RklDK3RCcWYwbnZkcnNkOEI1Ulg4WUl3TVM1MmVXWG52VFFUWWFsM3BVYXNh?=
 =?utf-8?B?YU4wUEJycmRXVnQweE5kSVYzdTYwWXVDczkxZHQzSG1mTU5rS1NoTTRTOElK?=
 =?utf-8?B?SlREV0FBaWlaOEJBYVhJZ1FrMkhIbTR6b2tkZWRoWmMyb244NCtsUUdXRSsw?=
 =?utf-8?B?RWtmQTg3bTRjU0x3RVlWMUg2ODJEbi90ajROYjZDL3BvWEV5Y3pKZy82cGJz?=
 =?utf-8?B?SEJHbEZ1UlRmZy95dkppTlEwTyt6OTVFRUhnL29aSWtPQ3RRRGxPZW9sZ2Jl?=
 =?utf-8?B?UTVFNlExQU4vUU9XM1NtQUNYY3doMDduT0NoUkdjS1k0WmdDL3laWS9sK2NB?=
 =?utf-8?B?THJ1YnRseUZBSjMxTG9XcWtTRDFkYUtmOGZmVUZJY1NtbEFaMWNGVGRpR3Zm?=
 =?utf-8?B?U1FlQkhEWW5mMXJsWStjSG8rQzJteHMrbThvVk5lZGMya2hwVVFCejljS1Jr?=
 =?utf-8?Q?TlYDS8f/XKfCl7S8Qk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGo2YzM3U2QyaDRFRGdZa2pKNlZHY09nTTc2V3UzVGFtRUhEelp0N2h0NUNT?=
 =?utf-8?B?WmViLyswdUNtV1BJQ1JEMkJhazRCdFZLRWlKUC9qK29peTlSNzJpWm1naXdP?=
 =?utf-8?B?WFdKVzZBdXpNemcybFF2U3NGblZ3SUdBdURTSmRFWEpFWkFWakh0WnFLV2Rl?=
 =?utf-8?B?d3ZRQ1htUFNoMG9CZTV0VVJabDVHWkEvckdaYTVBZXB6ZHNucGpsY1hzSnpN?=
 =?utf-8?B?QloyanNHREZTSGpLeHA3Z2ZqQUF3b0hBTFhVTis5VjcrMGdxYjR1R2krckVB?=
 =?utf-8?B?TE0zOS9md2pYVk1wNE5uKzk3WTNHNENrdzg3WmpNblUrMnZqMmtuSC9IS3FK?=
 =?utf-8?B?NGJwYjlkWDBGNG1qK2w2R0ZYL3pWa0pBd2pNenkxWGl2djFpdFNJNTBRUi9x?=
 =?utf-8?B?QVFuSi9OVHNqQ3dvcytIdGRSTjZnVmF2RmduUHBQQ2Y0eXFOMW5xaERGZmsy?=
 =?utf-8?B?V1FSWTFOUmFGa2d6ZkRQS2plUGtqL0tKN3JhSTkwdEhnb2dWb2dYTE11STZN?=
 =?utf-8?B?YmY1UEM0YnJ0WWpVYkdpMHZLOHEzTlhiRVRHYmZjOUlKSkdtTTNTaDJ6UHpz?=
 =?utf-8?B?dkpZZnpFZjErajQ0cWx0QURCdk51ZnA1cUZtdXhLenRsWk4vT25UUytURWll?=
 =?utf-8?B?YUNJamZhUHZ6RW5XcDFndzFiTllHaEpWS2FQRWF6R1lWajlSeXRsU0psZWQv?=
 =?utf-8?B?V0dtZVhEUklyLzk0VTVOcFNhOG1UWVBrSXFYajNwajllV3NZTVo1MlZRRlRQ?=
 =?utf-8?B?OU1oa3RPU3FOdVFTSGgvd3JVOGpEdkgzSUhnL0pneUw0SEVvY3R0dFdoR1U2?=
 =?utf-8?B?ZVlDZHAvelBzVTh6dkpDbDU0VEg2ZWc2ZGl1WGI1REE2eEVSK254aWtqL2Q2?=
 =?utf-8?B?NDhqNzB4Zkk3TlhhOHVkZDFLZXpkZk5FbFVsdWtEQ0tWUFF2dW1yTDZidnVG?=
 =?utf-8?B?ZDFKdjBvcFJuamhpMWZrUE9LS202UzF2dVVzeUlyUmZhN3VWUXZaNW1mRHRJ?=
 =?utf-8?B?OVlKNkFodVI0RjBxczdNaUFWSnhhdHRXL1ptOG90a0VhMktKanFNeHUyK2lT?=
 =?utf-8?B?MGk5ek9maGRkSWQyRjBGR3FoU1FEQmd3emYzUWFuMzFRVnR6ZzVMVXd2alNx?=
 =?utf-8?B?bUhqRHZtU2taTVNXWEFWK0NPZWkzYjVrRnRpNEVXYURSNEdDYlZROGdEVU01?=
 =?utf-8?B?T2hWNTlsNDNrVU1jempjb1luMERZMVRkVnBxRFVQL1ZzYkpWdnRkNDhXUFFX?=
 =?utf-8?B?bG1CVGhyT01mZTlOTlhWZlVXU2hlM1R3RjkxQ3FBZ0w4S3BmUG5OaWhXNUVU?=
 =?utf-8?B?Yldhak45UlVudHJnY3RVT0NqSHJuN3NBUGV0eU16Q2g4SjRiN2FBZnJmN1My?=
 =?utf-8?B?d2xXR1lkSVRHcHVDNHYycjk5SnpxK1o4TDI0Ni96cFdiSGV3Zm1SUTR1NzVV?=
 =?utf-8?B?cTd1WXIwQzBnUHVaMVV3dEEvY1NnalQ1UFJhcmptYjdtNVhxRlFDaHk3NE5m?=
 =?utf-8?B?OTNhZzRoc1RpZU0xKzJldU8zSC9KOVJ0YnAzL1gzS3ZBUUVVN0Fibm40c3N5?=
 =?utf-8?B?V28ycjR0Tk1LRHFWWEZJRmtTSCtmWVFjczJJbDR5bWpCeEtIQ0szSnY3UnBB?=
 =?utf-8?B?eFVpRzB5Vzkvc3NWZnlmY2lvMklPRVJYaDl1NnhaL3Jia0hBTGZuZFdldG1n?=
 =?utf-8?B?VDhIeE5PS1p0b3VMR09ockF3YWJ6a0JLNmZlbGZCMGlwa2JrM2JiemN4T0VZ?=
 =?utf-8?B?RHVKNW4wV0huVzcrbWdmRjNieUR6UlFuQzhPS3U0aUp5Mnk2R2VWR0pCd25F?=
 =?utf-8?B?MzN0cy95dC9JbEh0YmdDWTNPemF6b1pKZzB2VjhuaHFyUXlEUktyQzJ5clRU?=
 =?utf-8?B?Snlwa1h2KzBWbUUzTFhLMkZVdStPalMxcEVla2I2WVU4Tjg3ait5T2N0Wko0?=
 =?utf-8?B?c3RvLzM3eWpyS3RMYXJVS1hQSlk2NUFndEMvUFlSaVJKUXk5eGlKdkhYS1Nn?=
 =?utf-8?B?d3ZMU2MwUGNRcWM1QU5Cb0svY3hITFFVNTJhOFI1RzA2QmJPdWkvRGZqY3g3?=
 =?utf-8?B?L2ZaU2NlT0Myb0NhMmt0RWoyTXk1cUcwbkd0Z3A5Vk1ZdWVER0tvRmhmeEFv?=
 =?utf-8?B?eEpwK3dPSzNpMytOcXpaL08wQmFhQWcyY3hIQ3JoLzdlZ3Z0K3FkNEU5TWxV?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dad0973-a11c-4a62-25bd-08dcb54ed765
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 13:02:20.6509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYn3Vt4mvY6gthCEHEy7kDmtVaMP210kuCsZVzXud/Hw1r/jwvud9+aPjjJtqXdlgJVX0WDObG+y4Q6SKZ6M6gDu3UDzl2q7CgLLOMDxnHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6391
Received-SPF: pass client-ip=2a01:111:f400:7e1a::70c;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On 8/5/24 3:29 PM, Kevin Wolf wrote:
> Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
>> The script is basically a wrapper around "filefrag" utility.  This might
>> be used to map virtual offsets within the file to the underlying block
>> device offsets.  In addition, a chunk size might be specified, in which
>> case a list of such mappings will be obtained:
>>
>> $ scripts/filev2p.py -s 100M /sparsefile 1768M
>> 1853882368..1895825407 (file)  ->  16332619776..16374562815 (/dev/sda4)  ->  84492156928..84534099967 (/dev/sda)
>> 1895825408..1958739967 (file)  ->  17213591552..17276506111 (/dev/sda4)  ->  85373128704..85436043263 (/dev/sda)
>>
>> This could come in handy when we need to map a certain piece of data
>> within a file inside VM to the same data within the image on the host
>> (e.g. physical offset on VM's /dev/sda would be the virtual offset
>> within QCOW2 image).
>>
>> Note: as of now the script only works with the files located on plain
>> partitions, i.e. it doesn't work with partitions built on top of LVM.
>> Partitions on LVM would require another level of mapping.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  scripts/filev2p.py | 311 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 311 insertions(+)
>>  create mode 100755 scripts/filev2p.py
>>
>> diff --git a/scripts/filev2p.py b/scripts/filev2p.py
>> new file mode 100755
>> index 0000000000..3bd7d18b5e
>> --- /dev/null
>> +++ b/scripts/filev2p.py
>> @@ -0,0 +1,311 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Map file virtual offset to the offset on the underlying block device.
>> +# Works by parsing 'filefrag' output.
>> +#
>> +# Copyright (c) 2024 Virtuozzo International GmbH.
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +import argparse
>> +import os
>> +import subprocess
>> +import re
>> +import sys
>> +
>> +from bisect import bisect_right
>> +from collections import namedtuple
>> +from dataclasses import dataclass
>> +from shutil import which
>> +from stat import S_ISBLK
>> +
>> +
>> +Partition = namedtuple('Partition', ['partpath', 'diskpath', 'part_offt'])
>> +
>> +
>> +@dataclass
>> +class Extent:
>> +    '''Class representing an individual file extent.
>> +
>> +    This is basically a piece of data within the file which is located
>> +    consecutively (i.e. not sparsely) on the underlying block device.
>> +    '''
> 
> Python docstrings should always be triple double quotes """...""" as per
> PEP 257.
> 
> Some functions below even use a single single quote because they are on
> a single line. They should still use the same convention.
> 
>> +
>> +    log_start:  int
>> +    log_end:    int
>> +    phys_start: int
>> +    phys_end:   int
>> +    length:     int
>> +    partition:  Partition
>> +
>> +    @property
>> +    def disk_start(self):
>> +        'Number of the first byte of this extent on the whole disk (/dev/sda)'
>> +        return self.partition.part_offt + self.phys_start
>> +
>> +    @property
>> +    def disk_end(self):
>> +        'Number of the last byte of this extent on the whole disk (/dev/sda)'
>> +        return self.partition.part_offt + self.phys_end
>> +
>> +    def __str__(self):
>> +        ischunk = self.log_end > self.log_start
>> +        maybe_end = lambda s: f'..{s}' if ischunk else ''
>> +        return '%s%s (file)  ->  %s%s (%s)  ->  %s%s (%s)' % (
>> +            self.log_start, maybe_end(self.log_end),
>> +            self.phys_start, maybe_end(self.phys_end), self.partition.partpath,
>> +            self.disk_start, maybe_end(self.disk_end), self.partition.diskpath
>> +        )
>> +
>> +    @classmethod
>> +    def ext_slice(cls, bigger_ext, start, end):
>> +        '''Constructor for the Extent class from a bigger extent.
>> +
>> +        Return Extent instance which is a slice of @bigger_ext contained
>> +        within the range [start, end].
>> +        '''
>> +
>> +        assert start >= bigger_ext.log_start
>> +        assert end <= bigger_ext.log_end
>> +
>> +        if start == bigger_ext.log_start and end == bigger_ext.log_end:
>> +            return bigger_ext
>> +
>> +        phys_start = bigger_ext.phys_start + (start - bigger_ext.log_start)
>> +        phys_end = bigger_ext.phys_end - (bigger_ext.log_end - end)
>> +        length = end - start + 1
>> +
>> +        return cls(start, end, phys_start, phys_end, length,
>> +                   bigger_ext.partition)
>> +
>> +
>> +def run_cmd(cmd: str) -> str:
>> +    '''Wrapper around subprocess.run.
>> +
>> +    Returns stdout in case of success, emits en error and exits in case
>> +    of failure.
>> +    '''
>> +
>> +    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
>> +                          check=False, shell=True)
>> +    if proc.stderr is not None:
>> +        stderr = f'\n{proc.stderr.decode().strip()}'
>> +    else:
>> +        stderr = ''
>> +
>> +    if proc.returncode:
>> +        sys.exit(f'Error: Command "{cmd}" returned {proc.returncode}:{stderr}')
>> +
>> +    return proc.stdout.decode().strip()
>> +
>> +
>> +def parse_size(offset: str) -> int:
>> +    'Convert human readable size to bytes'
>> +
>> +    suffixes = {
>> +        **dict.fromkeys(['k', 'K', 'Kb', 'KB', 'KiB'], 2 ** 10),
>> +        **dict.fromkeys(['m', 'M', 'Mb', 'MB', 'MiB'], 2 ** 20),
>> +        **dict.fromkeys(['g', 'G', 'Gb', 'GB', 'GiB'], 2 ** 30),
>> +        **dict.fromkeys(     ['T', 'Tb', 'TB', 'TiB'], 2 ** 40),
>> +        **dict.fromkeys([''],                          1)
>> +    }
>> +
>> +    sizematch = re.match(r'^([0-9]+)\s*([a-zA-Z]*)$', offset)
>> +    if not bool(sizematch):
>> +        sys.exit(f'Error: Couldn\'t parse size "{offset}". Pass offset '
>> +                  'either in bytes or in format 1K, 2M, 3G')
>> +
>> +    num, suff = sizematch.groups()
>> +    num = int(num)
>> +
>> +    mult = suffixes.get(suff)
>> +    if mult is None:
>> +        sys.exit(f'Error: Couldn\'t parse size "{offset}": '
>> +                 f'unknown suffix {suff}')
>> +
>> +    return num * mult
>> +
>> +
>> +def fpath2part(filename: str) -> str:
>> +    'Get partition on which @filename is located (i.e. /dev/sda1).'
>> +
>> +    partpath = run_cmd(f'df --output=source {filename} | tail -n+2')
> 
> Anything passed to a shell (like {filename}) certainly must have proper
> quoting applied to avoid shell injections?
> 
>> +    if not os.path.exists(partpath) or not S_ISBLK(os.stat(partpath).st_mode):
>> +        sys.exit(f'Error: file {filename} is located on {partpath} which '
>> +                 'isn\'t a block device')
>> +    return partpath
>> +
>> +
>> +def part2dev(partpath: str, filename: str) -> str:
>> +    'Get block device on which @partpath is located (i.e. /dev/sda).'
>> +    dev = run_cmd(f'lsblk -no PKNAME {partpath}')
> 
> Missing quoting here, too.
> 
>> +    diskpath = f'/dev/{dev}'
>> +    if not os.path.exists(diskpath) or not S_ISBLK(os.stat(diskpath).st_mode):
>> +        sys.exit(f'Error: file {filename} is located on {diskpath} which '
>> +                 'isn\'t a block device')
>> +    return diskpath
>> +
>> +
>> +def part2disktype(partpath: str) -> str:
>> +    'Parse /proc/devices and get block device type for @partpath'
>> +
>> +    major = os.major(os.stat(partpath).st_rdev)
>> +    assert major
>> +    with open('/proc/devices', encoding='utf-8') as devf:
>> +        for line in reversed(list(devf)):
>> +            # Our major cannot be absent among block devs
>> +            if line.startswith('Block'):
>> +                break
>> +            devmajor, devtype = line.strip().split()
>> +            if int(devmajor) == major:
>> +                return devtype
>> +
>> +    sys.exit('Error: We haven\'t found major {major} in /proc/devices, '
>> +             'and that can\'t be')
>> +
>> +
>> +def get_part_offset(part: str, disk: str) -> int:
>> +    'Get offset in bytes of the partition @part on the block device @disk.'
>> +
>> +    lines = run_cmd(f'fdisk -l {disk} | egrep "^(Units|{part})"').splitlines()
> 
> And here.
> 
> We should probably also match a space after {part} to avoid selecting
> other partitions that have {part} as a prefix (like partition 10 when we
> want partition 1). I think we would actually always get the wanted one
> first, but it would be cleaner to not even have the others in the
> output.
> 
>> +
>> +    unitmatch = re.match('^.* = ([0-9]+) bytes$', lines[0])
>> +    if not bool(unitmatch):
>> +        sys.exit(f'Error: Couldn\'t parse "fdisk -l" output:\n{lines[0]}')
>> +    secsize = int(unitmatch.group(1))
>> +
>> +    part_offt = int(lines[1].split()[1])
>> +    return part_offt * secsize
>> +
>> +
>> +def parse_frag_line(line: str, partition: Partition) -> Extent:
>> +    'Construct Extent instance from a "filefrag" output line.'
>> +
>> +    nums = [int(n) for n in re.findall(r'[0-9]+', line)]
>> +
>> +    log_start  = nums[1]
>> +    log_end    = nums[2]
>> +    phys_start = nums[3]
>> +    phys_end   = nums[4]
>> +    length     = nums[5]
>> +
>> +    assert log_start < log_end
>> +    assert phys_start < phys_end
>> +    assert (log_end - log_start + 1) == (phys_end - phys_start + 1) == length
>> +
>> +    return Extent(log_start, log_end, phys_start, phys_end, length, partition)
>> +
>> +
>> +def preliminary_checks(args: argparse.Namespace) -> None:
>> +    'A bunch of checks to emit an error and exit at the earlier stage.'
>> +
>> +    if which('filefrag') is None:
>> +        sys.exit('Error: Program "filefrag" doesn\'t exist')
>> +
>> +    if not os.path.exists(args.filename):
>> +        sys.exit(f'Error: File {args.filename} doesn\'t exist')
>> +
>> +    args.filesize = os.path.getsize(args.filename)
>> +    if args.offset >= args.filesize:
>> +        sys.exit(f'Error: Specified offset {args.offset} exceeds '
>> +                 f'file size {args.filesize}')
>> +    if args.size and (args.offset + args.size > args.filesize):
>> +        sys.exit(f'Error: Chunk of size {args.size} at offset '
>> +                 f'{args.offset} exceeds file size {args.filesize}')
>> +
>> +    args.partpath = fpath2part(args.filename)
>> +    args.disktype = part2disktype(args.partpath)
>> +    if args.disktype not in ('sd', 'virtblk'):
>> +        sys.exit(f'Error: Cannot analyze files on {args.disktype} disks')
>> +    args.diskpath = part2dev(args.partpath, args.filename)
>> +    args.part_offt = get_part_offset(args.partpath, args.diskpath)
>> +
>> +
>> +def get_extent_maps(args: argparse.Namespace) -> list[Extent]:
>> +    'Run "filefrag", parse its output and return a list of Extent instances.'
>> +
>> +    lines = run_cmd(f'filefrag -b1 -v {args.filename}').splitlines()
> 
> And the final missing quoting.
> 
>> +
>> +    ffinfo_re = re.compile('.* is ([0-9]+) .*of ([0-9]+) bytes')
>> +    ff_size, ff_block = re.match(ffinfo_re, lines[1]).groups()
>> +
>> +    # Paranoia checks
>> +    if int(ff_size) != args.filesize:
>> +        sys.exit('Error: filefrag and os.path.getsize() report different '
>> +                 f'sizes: {ff_size} and {args.filesize}')
>> +    if int(ff_block) != 1:
>> +        sys.exit(f'Error: "filefrag -b1" invoked, but block size is {ff_block}')
>> +
>> +    partition = Partition(args.partpath, args.diskpath, args.part_offt)
>> +
>> +    # Fill extents list from the output
>> +    extents = []
>> +    for line in lines:
>> +        if not re.match(r'^\s*[0-9]+:', line):
>> +            continue
>> +        extents += [parse_frag_line(line, partition)]
>> +
>> +    chunk_start = args.offset
>> +    chunk_end = args.offset + args.size - 1
>> +    ext_offsets = [ext.log_start for ext in extents]
>> +    start_ind = bisect_right(ext_offsets, chunk_start) - 1
>> +    end_ind = bisect_right(ext_offsets, chunk_end) - 1
>> +
>> +    res_extents = extents[start_ind : end_ind + 1]
>> +    for i, ext in enumerate(res_extents):
>> +        start = max(chunk_start, ext.log_start)
>> +        end = min(chunk_end, ext.log_end)
>> +        res_extents[i] = Extent.ext_slice(ext, start, end)
>> +
>> +    return res_extents
>> +
>> +
>> +def parse_args() -> argparse.Namespace:
>> +    'Define program arguments and parse user input.'
>> +
>> +    parser = argparse.ArgumentParser(description='''
>> +Map file offset to physical offset on the block device
>> +
>> +With --size provided get a list of mappings for the chunk''',
>> +    formatter_class=argparse.RawTextHelpFormatter)
>> +
>> +    parser.add_argument('filename', type=str, help='filename to process')
>> +    parser.add_argument('offset', type=str,
>> +                        help='logical offset inside the file')
>> +    parser.add_argument('-s', '--size', required=False, type=str,
>> +                        help='size of the file chunk to get offsets for')
>> +    args = parser.parse_args()
>> +
>> +    args.offset = parse_size(args.offset)
>> +    if args.size:
>> +        args.size = parse_size(args.size)
>> +    else:
>> +        # When no chunk size is provided (only offset), it's equivalent to
>> +        # chunk size == 1
>> +        args.size = 1
>> +
>> +    return args
>> +
>> +
>> +def main() -> int:
>> +    args = parse_args()
>> +    preliminary_checks(args)
>> +    extents = get_extent_maps(args)
>> +    for ext in extents:
>> +        print(ext)
>> +
>> +
>> +if __name__ == '__main__':
>> +    sys.exit(main())
> 
> Kevin
> 

Agreed on all the above comments, thank you.

