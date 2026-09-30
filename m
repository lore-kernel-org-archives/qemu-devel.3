Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944EBCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqOD-0006mW-Oj; Wed, 30 Sep 2026 05:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBqOB-0006mF-MA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:14:11 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBqO9-0004hS-CM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 05:14:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq0Pp1E+S6XGFRB4BnH3+qvzdyaB2xrNWlBDzTqiKl9wS6vq8VP0Ke+QnPXhlYmNjsFkr/VjQ5y/KJjMUWCQeRn3omrBMjwb+AuQaIXIom4GKxzb3z69oiWXvkz8shkddadt3rKuyrzYdDL84KOFOycPq5x7BI6CQiy/5ur0g5CENARl6FI51KHeLnXqDnfINC1FOTjgGyoX+YFtINGSkV66E/JnB8RUaiccaaDmcOxb5Q91Oz7ZWdzeNWiwRDxgaCHBF+QOtG/xZStiw5qyLTI1EqPqQ9+fKwj9hrJsb2g0Lnr3vfDcyfnsTlVp0jI0/8SQHOO8GWTD5qKcUAJcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN+JRLx6oVoIrpTZpVOjND39msytgbuZLZF84FlpK6M=;
 b=ctq1X1FbHadM+QewkwLxSOJZbLIJLbyFGI912KIZtznwtbLV0+BoUueGuutDC0cw4utcJNToeZqTYt193m1X7SYB1s669QWu44iiuc0z2SaxqE5RCCgPmcIMl41FlxVy/xDieuWv0T5naKoQQYQfm4FheScqav1G2XAo2UH5yrc4OBfsHDBANxJ8wCfzUd7KPxXVFUo8MnO5zrDo87yZJTaC8zov/xodKYu3ZlorfdhLL1L39IkOTQUZArjuj1BShukJwi03TZsmqF03vwT3nZgnlcmopiMYaLCG3wjjkGynktPBekTCbR6ElXAXSJlaXeZzUr3CRlI7jgGpKwFHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN+JRLx6oVoIrpTZpVOjND39msytgbuZLZF84FlpK6M=;
 b=BM4kmi50Kdw73PfyyIDl+W1vgMQcaABwPZtRYJ/KCPmCCkOKW+l3cBxCuaRyeew48yxRQs2QJmrFHHEPQn2qUYvx5jtIr7nfiLHkxSd6jgBN8plUUrftMzAaRZBiKa/V3JBSWNvOj0MilEDNlGxi8DCtsxxBUFR7KLMrPrOs7fbdCCEdmtffCU6l2xUi0AWNfYsIZ5E513PWvC/6pnZEooZxS/G/UCuovaSDFDVPSEBDYGF3z1yKN7Up01rQMA3xVkwY5dCQXtFpw2Axehm63+44OmS7Y7rKLwERI5Q85qj2RSjYDPWIQv5ZAXhMTFG7vc6eI7NdNi1LJHkQXjQitg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MI3PR08MB11878.eurprd08.prod.outlook.com
 (2603:10a6:290:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Wed, 30 Sep
 2026 09:14:05 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 09:14:04 +0000
Message-ID: <8a6aa38c-8fe6-477f-8faa-e7a17a41b4c3@virtuozzo.com>
Date: Wed, 30 Sep 2026 12:14:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/17] vhost-vsock: hand off device ownership across CPR
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com,
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-15-12bcf1c0b84a@virtuozzo.com>
 <85a83a6a-a697-4fda-86d1-1a2a0796f5d8@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <85a83a6a-a697-4fda-86d1-1a2a0796f5d8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR1PEPF000077B9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::478) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MI3PR08MB11878:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5596c2-9a6b-4467-a71f-08df1ed32cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|56012099006|6133799003|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6InUMuU64/klwHNp0IyGTs4IGozbcEOfPBuNupF541C1jJWKuTkH+dPmxfdhG8FoYGQQl6KvxwtVNygdhOmaF5LVY3ArLM09dWrewa6So6WCEXcW6r22C4+f5EnusXeVWpyAtx5sCMdauDGmPeM57wD2dLahCTbPB6Lhhu0qjj4RO/3HXbamh0SOKZjKAHpx2D+UtILucZ0bVPLLSbGrZIB8tDGUAhZrLLRUHLyy/DwFlLwmIiT9X0peJgKp+ApA553XZzJsTJJYRaOsq11KabL3jSpbvCy3uKvqZfTXvxhn0LU68tcCjLT3+kNgoi8KJeSm9br9jmv9VH+3cfLy+ek+p8PEnuvj22UYcA85so96932LjnQRuBrOesHpNNPNLtrlvbEYYX5i/ydvND7gi4E+wj4Qbk3J/5kV3miCBffDlhuKvWfKlhRjVsPQ2w/oBPfgnWYqsWEzn8qdoR7DI/sOMC4505hoQ0y7X2a7IkCJYAe4v3+hw97ExZCzsbA29ZxHvADum9vg6Kqg2+zMlAmW4n2/cFfpV7X8NoZbCPblX6mqTGPkrKOlSJbb4uY4YL4VTPIX/4wbqIbID7/Ov93cxQwQWWFL231UbjzQxRca+MGFJF5p9ivDMg3EhNjwz7jV8kfh8rOgwUjp8FJwxwnCuTZsRx2cs9+ylwIfEeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(56012099006)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThqZS8weHN2bG1lem9PcWt1SGxEM0dCeGhtemFnVHBiTlNBZW1WbTJQMXFF?=
 =?utf-8?B?V2pDZE1zcnFDODV0MjRDVllwdnZlRFE0b3NLOHI5WmFaVTN3QTFVZmxHeVk2?=
 =?utf-8?B?UlN4WThpaXl3Z0U1dWRzcDF6ZC9jL1krczh3dTJ1WUh5NHkwdTNYcjBlOHhV?=
 =?utf-8?B?ZzBnaGRIdVNrbzVpSUhGQXNyZkxRWkFFQlBPNFRBNzdqYkpnbEV3d0E5MEhF?=
 =?utf-8?B?Zk9uZHUyWWNBQWRUelZSbnRTV3I1VVpQOFVRaGZzamYyYStxWnBpeURVVnRB?=
 =?utf-8?B?WG1EcDk3QnUzeE5VRVJHU2FLUjduV2VzczkxVmFSMFpjNWE0WHJLR05MSUR1?=
 =?utf-8?B?YUI4QW5sSGsveXBrKy9jUXg1RmIrcGhFSlozb3VUaU95Vmg4SXZzWHlkbzgx?=
 =?utf-8?B?cExuN2RrRWhrSktib3p0NnFDVS8xYUlJcGhCZVpMcmRzT1k5Z2lOTkxJRitS?=
 =?utf-8?B?ZnlPcDFiaEUwWDhzb1BCelpndStYQWtPaVk0aEg0V09nV1g1N2o1bmozZ3hC?=
 =?utf-8?B?aWdmQWQ1cWhmV3ZWalVWeCtOQXRKa3pqa2FsWEVRKzBUaEVsTGtJY2d6Ri9t?=
 =?utf-8?B?cGtDNDMxZGtmcEpOa2tYRUl0eHRoeWJWYnpOT2NUcjY2TERUUWNZTllZWDN1?=
 =?utf-8?B?WDB3R0hEazJDTSs4OWJ5Y2VBOW1ycTNKaVhhUFZxbnJxQXV0dysweGpDSmVi?=
 =?utf-8?B?dTIzYUpGcVdMVXNBMnhvZGVPaXIvK1N0c25rYk5vYjZhbUpyVG4wR0NXQTl5?=
 =?utf-8?B?b3VqZ3hkdEc1Z016QmdnczlmdzNLZXpXRlo1Sno0WHpXRzJObVhwTHY2ZlhY?=
 =?utf-8?B?ZGZTODRLZ1ZSSnVRMENOa2YyRzk3eUhVWU9sbmlkblFTbEwyODBJdU5wWWp5?=
 =?utf-8?B?R0s2SnJvTEFHNmZBU2tvUFZ5dHBLbzV1Mkd4UTJzTDhRYXhTa2hkd3hYVWVs?=
 =?utf-8?B?SHB0WHZtUUpoa2k5TUovZ2NOb29SNkRCTkFoY1F3TG1qRCtjWGVhYmtZVHJk?=
 =?utf-8?B?YS9wd2dqTGxFYUhDSm1xRjg2MWhjRzhhL2hvNmlRbmVjenVtaW9KdlpJKzhN?=
 =?utf-8?B?Y1VtUCtya2JBaXAwWlAwNWRCQUVMNEdGQlhQb1ozVjZlY0pMRjdxUUlPc3dD?=
 =?utf-8?B?b1lUbFBYY2hkZS8vS1N6N2lUb2RUVzl6ZHFDYjdRamhvYkdQczBqYjNzRnZQ?=
 =?utf-8?B?TisyY3loVk5ySXZKL2U0cEUySTdBOG8xSkJDOTlQOU9GUXdKUkk4TUMrdmpr?=
 =?utf-8?B?ZDRmNUNNRXN4QjZWZ1ZleWROZVY5d3Y5RzkyQ1VoQUVtdlBiKzhlYWFrK2FU?=
 =?utf-8?B?VmY2TVA3YUFnTGxYZnhQc0VnSkdpMnZuaHlCdHppVjdLZjFhMDNNcTd6VHlM?=
 =?utf-8?B?NHVyckxwaWxMY1cwMmRTWGQxc2Z4V2V1eHl4RDIxV3ovL2p2QjZNUnNMeVUz?=
 =?utf-8?B?MlNzWEpyY0s3QjN5eHcvUHRBYzBYSXdIZUw5ay9pTVVTV1RNVjREWmxwenpk?=
 =?utf-8?B?cUwyamRLOFhuSkQrRWU4cW1sNitNajlqZ0F1UmVydlo5Y2VWa293ZzB2d3hJ?=
 =?utf-8?B?VGJnZm83QnFPN3VmRk9JZWh3T3dWVmlOM3ozOUtmNnlyZG9mbFB2RGxOWHRz?=
 =?utf-8?B?SFZMTG5lS2hXV1RRcTBiMDE2NG5rUWN0dS9xS3hkN2VVTllzWWR1NkpwVFYw?=
 =?utf-8?B?RDE2YXRleTBMZC9acVZyMUVFdEJsT0lKdlB4UHo2dnl5ZERLWVZJZVhOQnlV?=
 =?utf-8?B?L0ZjY2U5aWxVUEcwc3FLZkJZSXlXOHRodVh5MkxjbEhGVnprS1B3eEo4aGht?=
 =?utf-8?B?aTAzcjcwMW1jelZzMDkyZVJGVXI1NlFqdEhkMUhYeEQ2Q1BhOUVycnhNRnQv?=
 =?utf-8?B?SkhzYThhYlhrWVRMVEdzNWxwdktLL2dBZ2pFSU5PMDJnWkJYUTM0ZHNPMGVB?=
 =?utf-8?B?aXltNXJBcXA0MHRPbDV1TFFFT2dLTEp3enp6TXF6dVN5UzArd0Z1c0Z1bUpJ?=
 =?utf-8?B?a3dQQWFpSFliaU5SejRVcytLZGxrZXNpWVdFcjd4Z0d2bDdFR2JaamtZOWIz?=
 =?utf-8?B?cklJZ00xMC93d2RBOFg0enh5dXdMemlmOWQwUWhkT1A4TmpndjdudU9TcGRF?=
 =?utf-8?B?TVIrcjBiVzQyUWE0MEhNbHQ2Y0VITGdEcStYd1RDSlFvWTZTck5tSVRZUEJJ?=
 =?utf-8?B?cXFSWXdUOXg1ME16MFpDS2VkZjIxMVBlbm1xSlM4TG9uR2hBRSsxUzFEK2dw?=
 =?utf-8?B?RDNhVUhHTThPdmhiTUxYMmd2dCsvbElCRXZWVTN5ckxEZWxObkRsamFOa2ZH?=
 =?utf-8?B?N2Y5andQMHByaE12Y2Q3eFJDbmlBMTBDZUxqQnF0cXJjRnJhNkRpNGxrcnNJ?=
 =?utf-8?Q?wn+3WZNpzQ1Duek0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5596c2-9a6b-4467-a71f-08df1ed32cb1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:14:04.8464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKzuzVNDTmAb8CN0ilG4MipoxsTzQm9lMC7TGyGxbgWFGLBNB0tiaJx3r9Ai46loIG82RVd6jq5Atn20yvodey6NIVXcy4ItmD+dWd2iTAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR08MB11878
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/30/26 8:55 AM, Akihiko Odaki wrote:
> On 2026/09/30 2:23, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>
>>    - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>      the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>      cpr-exec).
>>
>>    - .realize(), for an incoming CPR, only sets up the virtio device and
>>      queries the backend features by calling vhost_dev_init_backend().
>>      It doesn't take device ownership and doesn't touch the VQs which
>>      still-running source might use.  The full init is deferred to
>>      .post_load().
>>
>>    - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>      (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>      the device is started at vm_start.
>>
>>    - .set_status() refuses to start a device whose init hasn't completed
>>      yet (incoming CPR before post_load).
>>
>>    - .set_status() re-acquires ownership before starting the device if
>>      pre_save released it and this QEMU is about to run the guest again:
>>      the migration failed, or it completed and the management resumed the
>>      source (e.g. cpr-transfer target died).
>>
>> With the handoff in place, lift the CPR blocker.
>>
>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
>>   include/hw/virtio/vhost-vsock.h |   2 +-
>>   2 files changed, 128 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 6e89007b2ce..65ba573da4d 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -21,7 +21,6 @@
>>   #include "hw/virtio/vhost-vsock.h"
>>   #include "monitor/monitor.h"
>>   #include "migration/cpr.h"
>> -#include "migration/blocker.h"
>>   #include "migration/misc.h"
>>   
>>   static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>> @@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
>>   static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>   {
>>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>       bool should_start = virtio_device_should_start(vdev, status);
>>       int ret;
>>   
>> +    /*
>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>> +     * post_load.  Refuse to start a half-initialised device rather than
>> +     * issue vhost ioctls on it.
>> +     */
>> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
>> +    }
>> +
>>       if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>           return 0;
>>       }
>>   
>>       if (should_start) {
>> +        /*
>> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
>> +         * source, after a successful RESET_OWNER op.  If we end up here
>> +         * with this flag set - that means that either CPR migration failed,
>> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>> +         * target died).  In either case, we need to re-acquire device
>> +         * ownership.
>> +         *
>> +         * On failure leave the device stopped.  The next start attempt
>> +         * (guest driver reset, VM stop/cont) retries.
>> +         */
>> +        if (vsock->owner_reset) {
>> +            ret = vhost_dev_set_owner(&vvc->vhost_dev);
>> +            if (ret < 0) {
>> +                error_report("vhost-vsock: cannot re-acquire device "
>> +                             "ownership: %s", strerror(-ret));
>> +                return 0;
>> +            }
>> +            vsock->owner_reset = false;
>> +        }
>> +
>>           ret = vhost_vsock_common_start(vdev);
>>           if (ret < 0) {
>>               return 0;
>> @@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>       return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>   }
>>   
>> +static int vhost_vsock_pre_save(void *opaque)
>> +{
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>> +    int ret;
>> +
>> +    ret = vhost_vsock_common_pre_save(opaque);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Release the device ownership now for CPR migration.  The device is
>> +     * already stopped at pre_save, and destination reclaims it by calling
>> +     * VHOST_SET_OWNER in post_load.
>> +     */
>> +    if (cpr_incoming_needed(NULL) && migration_is_running() &&
>> +        !vsock->owner_reset) {
>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>> +                         strerror(-ret));
>> +            return ret;
>> +        }
>> +        vsock->owner_reset = true;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_vsock_post_load(void *opaque, int version_id)
>>   {
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
>> +    Error *local_err = NULL;
>> +    int vhostfd, ret;
>> +
>>       /*
>>        * Only reset vsock connections for non-CPR migration.  For CPR the
>>        * guest cid is unchanged, and the cid-change reset would otherwise
>> @@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>           return vhost_vsock_common_post_load(opaque, version_id);
>>       }
>>   
>> +    /*
>> +     * CPR restore case.  The source released device ownership in its
>> +     * pre_save.  Complete the handoff here, before the device is started
>> +     * at vm_start.  Init vhost device on preserved FD, issue
>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>> +     */
>> +    vhostfd = cpr_find_fd(cpr_name, 0);
>> +    if (vhostfd < 0) {
>> +        error_report("vhost-vsock: could not find restored vhost FD");
>> +        return -1;
>> +    }
>> +
>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
> 
> vhost_dev_init() can successfully issue SET_OWNER and then fail during 
> virtqueue initialization or memory-slot validation. Its cleanup only 
> closes the destination FD; the source still holds the same underlying 
> file, so the kernel retains the destination owner. Resuming the source 
> then makes vhost_vsock_set_status() repeatedly fail SET_OWNER with 
> EBUSY, leaving vsock unusable.

That's indeed a real bug.  I suppose the fix should be calling
RESET_OWNER from vhost_dev_init() on the cleanup path.  And it deserves
a separate commit predating this one.  Thanks for noticing!

> I also suggest using GINT_TO_POINTER().

I'd prefer sticking to plain cast here - only for the sake of
consistency.  GINT_TO_POINTER() can be done later in a separate commit
for all such occurrences.

Thanks,
Andrey
> Regards,
> Akihiko Odaki

