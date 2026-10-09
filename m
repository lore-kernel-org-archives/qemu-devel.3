Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D78CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7hO-0000sv-Mf; Fri, 09 Oct 2026 06:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xF7hM-0000se-QM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:19:33 -0400
Received: from mail-westeuropeazon11023118.outbound.protection.outlook.com
 ([52.101.72.118] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xF7hK-0007Cn-5U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:19:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrLsg9b8v7crrFzxm/e8NSkvxNKK8t86C/sdsnYRH7q5RVnXnl+k0tSbog0ClBioGknNQ+Xwdqi7GrRElrobPD02qQiR8w9fYtGYxDODtjOpb27zhSIwVg/Mr1HQCegsvNt1PkkufRL2Xye/+r1WFK6hVJNVTmtP+EOKvY0MnhqvOiTH2gROvlgDlab76axrb4kOpOCEvqOV5/GDDsszo1J7s5ESysy+jX3q+T94Z6qMheYyeueEE0WZYLVX+e6aoh+tLd9tymPEOJ/BRwIpwVdNvbnNJVsKcVlEAYCRgDB3a8pfMvdGZpsejKE3F2ogUJPCvaAMPIgzuDlp/oIX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYxW4btNDHjaEdPmX/xAiRXCZf/7Bvn2KUMN3XYgGFM=;
 b=RHK0CluGW4yLqBDQ3s/4BYL9jcQWmQbGpnV6j26oSNxbZQ+K9437gxU7timQX4QpbQQLnlo0sdRQpQ8PS0fnTqO/wBK+cugSsIEFkmiwPBETRzfMRY+40cuAQoiYf739/fB6DdtZRl2eiBInvL2GqTS7ltlM5S7sz4GrRGUqnz6HNnNu7spWuO4vrYEScedBhEpviY3RNJEeXgcQBwPXgnmQdlnY/WYKuWjQYB7odyhGESsoquX/xuWFFL3ig6h2fY98Tf/gFK+KW5yavglV14bkVztWNcFOpci6oq0ewAojkFWCSdGXhJrILSFqNhc6EYkmjJcPBCOMk2kHRY+F1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYxW4btNDHjaEdPmX/xAiRXCZf/7Bvn2KUMN3XYgGFM=;
 b=vs2aRt+ybAfbvXIt/celujmWwepFhyWGRUkWakGNsQy/IL4zlXZ5LPcU9zgvJ+N7v8VJn47h5R4e6E9Sxnn64/as5cj+Z6Qd0+8h0/PlXT+Goj6cmdjNNqfJudW7P58EK9v3cfhRP6ynjdWKEHuQNxFASK6Urd8fCnNCMUIItSebx6beBnUlVrYRfv5dAe3AS17ukRptIU5/bmYauzma6D+B17mE3ZpaouBmr1GG8La8ofqcvY0WXAk1FqfHU3T0psEb0H7ycusMcuuhYSezCVtU0RS1poo+A63WPlyVMNywwzcuu/rCA00ULbCJye9W8nT0/G9nVsiEWDyEIqzKEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8254.eurprd08.prod.outlook.com
 (2603:10a6:10:412::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 10:14:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 10:14:23 +0000
Message-ID: <ddee71f6-4f07-4b12-9b83-a1b606ab5146@virtuozzo.com>
Date: Fri, 9 Oct 2026 13:14:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/22] vhost: release ownership in vhost_dev_cleanup()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru,
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org,
 mark.kanda@oracle.com, sgarzare@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
 <20261007-up-vsock-vhost-v5-v14-15-e16de9962df0@virtuozzo.com>
 <ca73056c-cde7-4835-b62f-48d9b498eb74@rsg.ci.i.u-tokyo.ac.jp>
 <26d93613-15db-468d-9845-9f47d93610ff@virtuozzo.com>
 <401f2593-6492-4923-a29a-0161108ce1cc@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <401f2593-6492-4923-a29a-0161108ce1cc@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0107.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::22) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: f3153a64-8472-4636-23a5-08df25ee171f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: CXQACF7z8/LjYlHfnkc52zTY8hhXlrUhqIS9EUby7MpOwfMy6UV+Fk6opqFQlxbM1CTCm/RQEP0eUd1/oWg83azE7MVDPJq0Pma4lI8fDEWxmsvUHx/sgQkipIwkOLfiYU6UA5WdZOChSpiYGggAwJq5mXeAG2Cq5GMohRcnMwmRhhIMGHDtUJD6xr5ge0tdhXCtopXWglGez8zJgXHaQFDU3AhIX7r+LgjuoM5Mcr99XYQt6VyMiWUpkcpwOoJMmVB0BKBYYlMA6k1R8XZfV1YQnZq4KP8CR3/zdIOQF5tNbOQ1gKy5I8hqcd6SR3OgIeBqek4yinGZQjvxv8gGwWMrnoBLRL8N0H+Alo/QZ3EOe6yAKZBzqyXbajdauGhAFTZ3cYtwQYVOrJaE6hDwRCUmf9XOMth/wC0rzMJcFmRJ4VW7vCUq+CSPh0WWSAX96aQu1wkbJzBhXK0AsePGXlFCdLmcru93qWA+A0Eb6x3gDfCy3R84w3paZbWbzzUr+fRWYuVUMVkxQzR8siJ8bPZdsfbuPmKtB+mtx8Xsimha8hay4u63VwYL5utjtF25RRBNYiF4Ik8yTsM+C81o2ecT9RP4LR2OieGWpF00/7EsSphikyu+F3bBEpi1WJ3qbMJPr3apeeMXdqKT3BYegFb3RLlChJHBaQ13nY9+KTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25FMUE1ejR2SmxBNjVvWXp2RklEM3Y1TVE4WE5vSlFMVitHYTk0U3IrT0RB?=
 =?utf-8?B?bDRmQ3F4MzIrdHNQSlBpWGN5M3pCTjJWOExaSmlyOGpOaCtpYngxODR1UGVv?=
 =?utf-8?B?blM4ZVRjTFltRHJ3WHUrMDBoZFZBRTk3VDdaVDFUaU5WTmsyUUllNkhIak9n?=
 =?utf-8?B?VHhmVGNpbjkrRUFIaXBWSXcxZ0pmZDI5cUdpcDhrT0R0d0p3K3hLekY0Y096?=
 =?utf-8?B?RlJmQXk3cDBmcnZNL3NZWFpOaXQva1l3SVR3R0JhYkhxSWxCUzJPU1ZiWkky?=
 =?utf-8?B?T1dvR0tGdXgvbWJoaHA1U0kxaUc3SG9ETTlaWjVHdE92Qmt3cGUzYlQ2dU9l?=
 =?utf-8?B?VnpFTll2cGtJakRyWEdkbDl1YUdaTU9ZSVRhZXg1S0VpU3pRVlA0citGSE5X?=
 =?utf-8?B?TVJ2bEhEMDk0Vk5KcjdaYjlTOUpTcUtMT2ZYQ2FVejd2REFyU0lrZ2J5ZWZC?=
 =?utf-8?B?ZEdRZm5aOVVUbUhYWUp3N0xOaHIzbnROSUhNMjR4VUxrcUxwVTJWOENRUmZE?=
 =?utf-8?B?NEVOS3pCeEIxMEJyYm1yV21rbGpndDVJWm1PY1VwT2pkWXYwSFkwSWVvZjB1?=
 =?utf-8?B?L3VqeUlmLzMwbHBha1VRTXBUVi85Z3hHeDFhSC9JYmdXc2RQWmdWNEpscHFH?=
 =?utf-8?B?WHp5NHFJK3VtQlZUUmk3R0YybkpKbEEvQ0NNTVJTOWxkdXFHMDRuNGVBcTNl?=
 =?utf-8?B?OFk5Z1ZSVHB6UDFVVCs2TFZFblRuNGtvdlpIWWxiUlRwSXFDVCtuTzRtYStm?=
 =?utf-8?B?K1BQeVhJU1pRZTJnQm4yVEtpYTBMdUV4cTgyMGwzVzd6U3FmT285d2J3Q3ZM?=
 =?utf-8?B?ZlBpei9PVDBCdEFrQ0phaVExcTdXckhCcTRxSjZKVnA4N2E5Q3d1dGRKYVdv?=
 =?utf-8?B?RTUxcE55UGRwaEhrZktsZXlPWHlUY2VPcVBOeERuQzdNeGNDMXpQeEhEQTN1?=
 =?utf-8?B?T2ErV3FFSG5aM3RSbTJBU0c4RnNnZ2RuRTl0MnpSQ3pHbE5Ma3lZQkxvQVN3?=
 =?utf-8?B?Q3J3MjRFT3lrVmdzODllelcycG1NL2RvYjFVcU9QcU9FWCtwek5ZdGtaT1FX?=
 =?utf-8?B?eFpTQzd1Vk1Tbms4UmE1bklBLzlZbmFzTEZaTUhLelZ3bWJHcDVMUWZlVm5H?=
 =?utf-8?B?RlZ4WTN2UmErVEpTVlVaSHB6cFU3VWZWeFVpcGtMTTZldFk5OWpOV25URVhF?=
 =?utf-8?B?bjlzaVdnMFdJbHhndnd2bXZheEh1a1BUZzV1ZUVrMC9FZUE5UmxVTUp2V3NV?=
 =?utf-8?B?RVV4UzJ1N1lwQlhUbmJsbDMvSXdzVnZKVlJTQjZRWkFUVlcvR014ajRQZU5C?=
 =?utf-8?B?RmV0eHpsb1NPWEk4a3lLek5TaXBmUDJzVWxFSWErUkFHRkdibWlaaFltL2xo?=
 =?utf-8?B?WG5aeEN2TXZuWmRPRlF5TzJqVEYyQ2ppRUNnM01aSjNHWVlsNHZkY2Y3cXg1?=
 =?utf-8?B?L2cyVHU3MG9BaE45VkNvTzJaUG9HYzFMYVA5b283UkhKRDV3TCtPVVE2eGlx?=
 =?utf-8?B?REIzUUI0QU5IWUlLc09YeDYzMWMwSENZUUQrR1F0LzJBZ3lrUzl5VHUvSUZy?=
 =?utf-8?B?aDBWM1B0UmdYNzNHUVdNRm04SVBDZ0ptRWlocW52cEFQS0RvQmk2OGdrbkFq?=
 =?utf-8?B?QmlKNnprMENkT3BDalczMnJzSHlnMEFFN011SEExcW4vejkzZTVtZVhqRVVZ?=
 =?utf-8?B?RHNsanFOOEZrUkRYR1NFNlgrcDBLRUlyV1Z2cEtmZzhycldHbTBsWXVZRmZL?=
 =?utf-8?B?b2lSVkw0Q3VmQkl0WXpXd2ZkQTF3WVR0bEhRbkhvZk1xd3FUUXQ2VzgzdEVz?=
 =?utf-8?B?UkdMLzJHbEZBZkZBZU5iRGpRdlhXUDhoMkpSRW82cktCOVlTWVI4VUdKN0M2?=
 =?utf-8?B?bzJzY2pvQmlldjd1dStBQ3JHY0IvdlUzSE5MYWV0R1dMSlVYV082aVRoWGFk?=
 =?utf-8?B?Um1qc1NCdnNITjF3Z0lubENWdUZmcmd0NEZBWTlJaUdBa3lnUVExaE1xUUl3?=
 =?utf-8?B?WEZUVzhuTU5mOHNXcExMUkVwbFBZMVcxQUx3OFppNElMVDNJOFhaS25xOURj?=
 =?utf-8?B?REhrdEVFLzBKYi9xcTNIcFdXdGg3Uzg4U0dLdEpndS9KdGtUVzk4bUdHZjZT?=
 =?utf-8?B?S2Z4Sk1ZTTFRZ3ZvU1hreEFMTWlzZUdBUytPamVMQ3l4WWZpKzNqTExPcDd0?=
 =?utf-8?B?cWVUZzhKRnJUMm9SVVM3MlFtOUJMZVVzM1hCZThta3oycFI5UytFNmNUY3J1?=
 =?utf-8?B?Sk94ZlBUbDhBeEQ4bWxUeFM4MzhYRmU0TW1QRWVNd1FxdEdaRW5oV0RzWm80?=
 =?utf-8?B?Z1daK0htVGlhcmRBUEhuSVlMU2JUV2pTUlkvQU4vQ3FlOEt6MEZ2OUtKZUIz?=
 =?utf-8?Q?N2oJ8Z/zt4MqYUzY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3153a64-8472-4636-23a5-08df25ee171f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 10:14:23.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB9BekCzuRT0bzxXv+AmaJx9QmeorJpC2sy1YNPTulEFijFZXhm5q9ilYXkV33VMkdRFSHNIdk3JY1IIAuECR2l0ICIWGGyRrbvM6mDVFyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8254
Received-SPF: pass client-ip=52.101.72.118;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 10/8/26 5:12 PM, Akihiko Odaki wrote:
> On 2026/10/08 17:37, Andrey Drobyshev wrote:
>> On 10/7/26 6:37 PM, Akihiko Odaki wrote:
>>> On 2026/10/07 17:40, Andrey Drobyshev wrote:
>>>> vhost_dev_cleanup() closes the backend FD, but that doesn't release the
>>>> device ownership taken with VHOST_SET_OWNER if the same file is open
>>>> elsewhere.  That's the case on a CPR target: the source keeps the FD,
>>>> so if the target fails after SET_OWNER, either inside vhost_dev_init()
>>>> or later in its caller, the ownership stays with the target.  Once the
>>>> source is resumed it can't take the device back, SET_OWNER fails with
>>>> EBUSY.
>>>>
>>>> Track the ownership with a new 'owner' flag in struct vhost_dev, set and
>>>> cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
>>>> VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
>>>> teardown for all those paths.  That should be safe in any case: the kernel
>>>> refuses it from a non-owner, and an owner is about to close the FD anyway.
>>>>
>>>> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>>    hw/virtio/vhost.c         | 24 ++++++++++++++++++++++--
>>>>    include/hw/virtio/vhost.h |  5 +++++
>>>>    2 files changed, 27 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>> index c01ccc800cb..3432b9a43c8 100644
>>>> --- a/hw/virtio/vhost.c
>>>> +++ b/hw/virtio/vhost.c
>>>> @@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>>>>    
>>>>    int vhost_dev_set_owner(struct vhost_dev *hdev)
>>>>    {
>>>> +    int r;
>>>> +
>>>>        assert(hdev->vhost_ops);
>>>>        if (!hdev->vhost_ops->vhost_set_owner) {
>>>>            return -ENOSYS;
>>>>        }
>>>> -    return hdev->vhost_ops->vhost_set_owner(hdev);
>>>> +    r = hdev->vhost_ops->vhost_set_owner(hdev);
>>>> +    if (!r) {
>>>> +        hdev->owner = true;
>>>> +    }
>>>> +    return r;
>>>>    }
>>>>    
>>>>    int vhost_dev_reset_owner(struct vhost_dev *hdev)
>>>>    {
>>>> +    int r;
>>>> +
>>>>        assert(hdev->vhost_ops);
>>>>        if (!hdev->vhost_ops->vhost_reset_owner) {
>>>>            return -ENOSYS;
>>>>        }
>>>> -    return hdev->vhost_ops->vhost_reset_owner(hdev);
>>>> +    r = hdev->vhost_ops->vhost_reset_owner(hdev);
>>>> +    if (!r) {
>>>> +        hdev->owner = false;
>>>> +    }
>>>> +    return r;
>>>>    }
>>>>    
>>>>    int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>>> @@ -1864,6 +1876,14 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>>>>        g_free(hdev->mem);
>>>>        g_free(hdev->mem_sections);
>>>>        if (hdev->vhost_ops) {
>>>> +        /*
>>>> +         * Release the device ownership if we hold it.  Needed e.g. for
>>>> +         * failing CPR target, so the source can re-acquire it.
>>>> +         */
>>>> +        if (hdev->owner && vhost_dev_reset_owner(hdev) < 0) {
>>>> +            error_report("vhost: cannot release device ownership on "
>>>> +                         "cleanup");
>>>
>>> Normal teardown produces a misleading ownership error. vhost-user and
>>> vDPA set owner=true but do not implement vhost_reset_owner, so the
>>> helper returns -ENOSYS. The new cleanup diagnostic therefore reports
>>> ordinary cleanup as a failure. I reproduced the message with the
>>> following test command even though it passes:
>>>
>>> meson test -C build --no-rebuild -v \
>>>     --suite qtest-x86_64 '*qos-test*' \
>>>     --test-args '-p
>>> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/read-guest-mem/memfd'
>>>
>>> Regards,
>>> Akihiko Odaki
>> Ah, looks you're right again.  I just noticed that the error goes silent
>> here and we better somehow flag it, even though we can't do anything
>> about it at this point.  I guess we can just ignore the cases where
>> either the backend doesn't have the reset_owner() callback (in this case
>> we get -ENOSYS) and when the kernel driver itself doesn't support
>> RESET_OWNER operation (in this case we get -ENOTTY).  So smth like:
>>
>>      r = vhost_dev_reset_owner(hdev);
>>      if (r < 0 && r != -ENOSYS && r != -ENOTTY) {
>>          error_report(...);
>>      }
>>
>> I'll post this if you don't have any objections.
> 
> The -ENOSYS filtering fixes what I reported, but this check misses a 
> kernel quirk: unsupported VHOST_RESET_OWNER can return -EFAULT.
> 
> For example, Linux v6.12’s vhost-vsock forwards unknown requests through
> vhost_dev_ioctl() to vhost_vring_ioctl(). The latter reads a queue
> index from the argument before checking the command. QEMU passes NULL,
> so that read fails with -EFAULT. QEMU already documents this quirk in 
> vhost_kernel_set_features().
> 
> I'm a bit concerned that this check may not be reliable enough and 
> result in false-positives/negatives or a behavioral change in the 
> future. Perhaps having a flag to tell that devices need explicit 
> ownership release for CPR may be an option. The source must have 
> successfully reset ownership on the same FD before the target acquires 
> it. A reset failure on the target therefore deserves reporting, 
> regardless of errno.
> 
> Regards,
> Akihiko Odaki

I think we might indeed get away with flags here.  However your remark
made me look into the code once more and I think 'vsock->owner_reset'
flag is currently redundant.  At each meaningful point in the code this
flag has the reverse value of 'vvc->vhost_dev.owner', i.e. base class
'owner' flag.

So I believe we should be fine with only 2 ownership flags instead of 3,
both in the base 'struct vhost_dev':

  * 'owner': explicitly set by set_owner() / reset_owner();
  * 'owner_handed_over': only ever set in .post_load(), on CPR target.

And then in try_release_owner() we guard by both flags (owner &&
owner_handed_over).  That way ownership release will only be attempted
by CPR target.  And this way reset failure will be reported regardless
of errno.

Do you think this'll be acceptable?

Thanks,
Andrey

