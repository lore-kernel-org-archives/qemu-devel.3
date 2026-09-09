Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7A1C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4LkF-00027E-C1; Wed, 09 Sep 2026 13:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4LkC-000271-0E
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:05:56 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Lk9-00041u-Km
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPrxoWSvZWPvPlxcK4yOek4CR/jPdAzXIrVTtTR3bxZWCHC77d47ko5HCJcUOS28yXKoX8y60u+w2NFB5pmaCfUEdvm60Fvi0pF8EVEe2pCrR1493zisoakVC4k6GsjLaxmUfmM7Dq890WwvC4z0fL3WoCjIj1BCPO7ZA7I6nYt/5jLuuNGBi5aO28XNDYm2OXpTDtktrpMKiDOGkiTMNHxlSrBj80sh5mQ4jNYLYQCSGwF6hlxX41FN7LLyUUsLjQcqqnLf22f48nvKrrkukmE4NP5+excd9eUWpc0ZvhB+drqt6XorBzsmKnT1PkP+g+d24tOajTMtguquvqT8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc+8In3bkV/A2dXS/I7Af60DsCGTINW97M3t7kwaSI8=;
 b=BzXRpoqe0QM8VxgxFipUyiiciZZBk6Y/D26eUy5+RMya31YtdNWjl/4rmZcdPKHBHnWkNJ6txTgMm3Ny8jEjDAcic/Z1sLdF3PDSc5/oQjzfczUg9kVAwD0RnCwFJss7wslEuZ1HoXUntZhGufJDJKS6YKtQRe6z9jFRjQiZLkK9MzXspkWrv+H5T45VYnogCf7y6K/rlts5x6mbKtnIvLQLDwfTUnl8pYMAGV2T/BOiI0FQg08FxO/xJ1iLJcIzwxhA+eUST62NtPnFXSU97GIFIPbNQKefQQ4dEIxksOadMELSPiuNhRUjhaqgKayvwRUe1YiaPH9hFmAkULDLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc+8In3bkV/A2dXS/I7Af60DsCGTINW97M3t7kwaSI8=;
 b=y+vh9xUXF9qf0P1wSUpkI6ylnRG7B7q8v0efBNdkOnoxn3UTZQDvgOH6+y+lk74UJT0Nx7HKbAZ1xb0cYVjknfb4pTK+iROwmLaCbkT5XuERqk1F+qL1N/nmu2DRkNPGGRkT57NvvNfArc6Cf0Djump5J89F+86RDIXK6KNOU7bvqm11M0zu2DUPCRDsrK8/bM1u8QYRHAiaU0LlCzwtZmRLcdjsgiCP2CCSSkH35W+AFe8zA0oW0cjyZnXaXpB7FrpMKaK/Oy/H5ob/7VvT+kjqfS6rU9RTpOmwqSXNu6rKWzqy3PGcJqwddcEMJzWuN4+vTs/m0MIxXOqcwdoxGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5976.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 17:05:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 17:05:50 +0000
Message-ID: <616de53c-ef58-4ec9-8112-4955aa0ac4a0@virtuozzo.com>
Date: Wed, 9 Sep 2026 20:05:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-9-andrey.drobyshev@virtuozzo.com>
 <ap7I31Lch-pyql9J@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ap7I31Lch-pyql9J@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fee12ff-17ed-43e0-c963-08df0e9499bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RF3cz1eFVyJRqxYKg3+9PQ9f/jUszaLoC2tBtsa5QCxru/2lm06RJugSakbmlVxfvYJvi4P8imbCYHTly6ypMY3PjnMxqucFRXkqDdQDFNNhU4rohMdbZTrcGz80lF/9BwVTbAX3tOqS8nNpEJidfPXJf9OTCh5nd70FgUz/792VSkkqFBurQDDG/Vnvn0q/tmWcEcNfm1o/KAGp/eu5WQ84O+PzR/lyhT1U+rpKVAy2v9BlwXu6R+egfj/WJmB1ol+x8K40VdXsf+D/kfTwvM3U57afRsiyItA3QbifWcgJXuwFp+Hy4nBos+0SNNFfbvECWwWLsZzHtG0wrRwAUb1LsdUx/ZEXBPXxaU4sSU46TTQpH7ahI6l8HhvWLrm3A3Xe4P8ZSWtaD8BcbCN8WjZug6gCSrOYL9RdhQN/sG8vIaL1+ROcoxxfJJvT1gFzmPUXFO/NVtNl8lYAyZsjkv2LNQLBJQtUwCfJSyhbuwX4HPFGiZC+Y2KWZyF/L8P+hif96WVJQu4IipS4TO2K9NWRWV9rfFVyu21Kwc/wz9TiKWBQLYe9x2vUCF92IdYG8+pz4fLCqUkdrLIajNRrOiQNIC45O3pBcH3EB2/zqN5NgNHlm+OxjynYR9/ZUe5omOz9QyOE1SbtQBkUFkbhL0FVt7QVczapuPq+ERRxBZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhHaXlrNnpPdGlUOVh5TGlTckZxOWdSTUJHZzQxOGpUUWNTdVdFbldGdENu?=
 =?utf-8?B?UDNqWFJYVGpEdFBSb0JWL1AzMForM1hkTmlwK0IzbEx3elRRUUpWSEdhODB6?=
 =?utf-8?B?U291VUFLaTRhYVZzb2ttS2puL1NBYjhORUtadjFYczFSdzAvTW1ja1d2R3Yy?=
 =?utf-8?B?VHI3SnJJUG8zdGk1QXJYTW1hY2ZzSjZHbVVNZS9xTFBuMnZoUGxRaGUvWW5L?=
 =?utf-8?B?ckllV2h5MDlDZlc4SStEbnhpdkRiNHA4SmNlM1VGV0kvQ3JndGZaaitmMHQ0?=
 =?utf-8?B?R2N2amNNWWZJME56TkVXaWJPenl4a3l2b09pWlREV2tBSzNvTWRETHZDc3F5?=
 =?utf-8?B?dllEWU1FY1dyZ3d0cFk5MmgxUCtod3pyN2tUcTFHNHFMVkQ3NTdzeUtPMjcw?=
 =?utf-8?B?cXhmV05Ob1pGLzh0UDZ0QkpQSVNKdXVCSUVUUUx0aFJxc0VzenlSUFk4bklq?=
 =?utf-8?B?alBCSklwWThDVFErdGllcUtWV01KTEIzMzJ5V1Bma3Byc1M1eDhjOVFocjdQ?=
 =?utf-8?B?V1JielpRUXFqU3dFYUdIZ3RJMjFPbDlRbWdKaEZicE13Z1lOTU55ME1RQ05L?=
 =?utf-8?B?aGJBSCswYkdUZkF1dTVGNTBEbkZ2Ky91cEFIYTllem8wTmNsZWRjdWY1bm1u?=
 =?utf-8?B?QnJqa1V0SXZxNkluYlRQN0NkSG1HVGljYnBjbFRTdTFDK3hCa1p1NFZHT3A2?=
 =?utf-8?B?UXBTWWZhV3ZWSmZYbVNlcWhPTEJQUWJFQUJJU1ptWk81cXVWcjlpZ2NCY0xF?=
 =?utf-8?B?Z1N5eUhMcmhTSlNOdktDQnFnajhMNHhCTE50RDRDMGsrdlRZcEtCN3I3aWdG?=
 =?utf-8?B?bXBLbmRmSXJTV2R1TXBTalhxYVFrMFFnWWpPb29qcFk0R1Z0cVI2RTMyY0xi?=
 =?utf-8?B?Vis2Z0xiMHEycGpWVGlHSjA3WEgrOHdTYmFQR1RrenRrUmdiaFN6WU1NUG1x?=
 =?utf-8?B?RjBLUVZEUi9NRk9YRHJqRkZ5dUpUUHJWT00wWHg2VGJMbmg4UTBLcnM5TXJY?=
 =?utf-8?B?R2l6L0M5MXN1cWJIbEd1RlB4aWtwZDYyY0kvSmlNdzdCenRRWWtGTUh5Z2dR?=
 =?utf-8?B?UUwwZ2VsRzBFd2NjZnBLTDZUdzdLeXU1UVd6ZE83ZFlqQ0NhL0NFcTlHcDhy?=
 =?utf-8?B?UVdZQXZSeGVkbG9nVlNCbEpMamFlQ1VSMVFKT3U5MHAydEVIS1dhRUptWnBG?=
 =?utf-8?B?YjFpWmI1U2d3OGZnd1RZQWFsWm9renNKTjEvT2RuNWUxSXJ4aU9uNldlbnla?=
 =?utf-8?B?ay8zZkZFNG80NnRjZVF0c3RCbzBPTGw1R2R5bHp2WWs1WGZ1UGF6NzIyczEz?=
 =?utf-8?B?S3QwNVRjb0gvM0lrK3hJSjFnNGJGT2plVWNQYVNkOFJxNUpGY1N2Z0JFcmlV?=
 =?utf-8?B?RWVyWkl0cUR3dG9mdGNjckk5TENrQ1dzWmo3V1BRMmNGK01wdTE0enBRZ2hW?=
 =?utf-8?B?Vm9xL0hVK2VqUzMwaUtiVW81QU92NncydFFrUXJBdDNMK2RkK0JYQ3R0TDBN?=
 =?utf-8?B?UXUwSHk3bm1wa0VPQ1ZTYTNNZFUyb1VDdEZ3U1FXRVBCclgzeXNLdDdYSzk1?=
 =?utf-8?B?SWZDRXpOaEowempUNmxrZUVtWEt6bkYwSlRZdG02RStiV05ZeW1ueGx1b2V1?=
 =?utf-8?B?Y1F0RlBIazBxbFg0NFV6YTJ5enVsMCtkR3p3VUJtVVVOb1dqdUtTN245Y21U?=
 =?utf-8?B?a1A1dmNHeFRKem8rQWJ2eEFhQVBJNkFqb0FUWGdWSWpZWWRIMzlGcG9PVCtr?=
 =?utf-8?B?SUdjYktWTzltSVFVTUpKM2NtQUZxcmNET3lTb1RCbFRrZzdJam5ZZWNpd3ZS?=
 =?utf-8?B?bi9WY2lKSm1wUVl5YkNiakZFQTJ5dk5HNWJvRVhoNE5pQmUyR05YbmpGVXQz?=
 =?utf-8?B?QUsyLy9UWDFmMGEwT2xtK05GaDh4MUZ4R3BKcVhuY3NkR0ZNZDR5Rm5nczIw?=
 =?utf-8?B?bU9kaDBQeUhIQWhOWnVoQ2hxV3NRNnBmc2FKYk9QYzYyZ080UHorRTN1Wm9I?=
 =?utf-8?B?b0tTNUVBWVJoU3pVdUtNRWJXU2xsOHBiMXNBQUR0NnRKZ1Y0OFlSRUVMZzFK?=
 =?utf-8?B?bmo1KzUwNGZ4a2JPeGRaQTAxOU1KU1lRRGdFNlI1ZzdtOTVOYlMxRVM2ZWxJ?=
 =?utf-8?B?MERTbWZSMHV5eHkvUHM2TmNEOVhEc2lkWTNldDhZUUI5WjhvaWl4MWkvWURq?=
 =?utf-8?B?Z2JQNUZkRW1XZkRhTnZSSGx1V0tLUmZmbW1kczZvbzhXWWZnNDB4K0NaVk5h?=
 =?utf-8?B?a2dGYkI5WTJVbVFOUHd6OXVPTUZISHN3bXNwc203TU9YcXJHUFliQXpNNGY2?=
 =?utf-8?B?T1dWazIyRThwcXVUaXgvWXZUMUdhQmluNWlpY052Rkt3dzJpUTJvK3FJaG0z?=
 =?utf-8?Q?uGqtMiaxDQ0P04h8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fee12ff-17ed-43e0-c963-08df0e9499bb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 17:05:50.8302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSzrNY4Qdp6vMrisUO+faG6Ng2tJq3S6SSNbbaOVqXM8ZakLwo4flmpPspfci0GdUTl0pIe1+0YK+5ucHOH8lL3qlbLD4/mJAMu+nWAiZP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

On 9/7/26 5:56 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2026 at 02:39:53PM +0300, Andrey Drobyshev wrote:
>> Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
>> other vhost_dev_* wrappers, so device code can take or release ownership
>> without reaching into vhost_ops directly.  vhost_dev_init() now uses
>> vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.
>>
>> No functional change.  These are used by the following vhost-vsock patch to
>> hand a device between owners during CPR.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost.c         | 20 +++++++++++++++++++-
>> include/hw/virtio/vhost.h | 13 +++++++++++++
>> 2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 2bb9a23fee4..ea17bf01080 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1690,6 +1690,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>>     return 0;
>> }
>>
>> +int vhost_dev_set_owner(struct vhost_dev *hdev)
>> +{
>> +    assert(hdev->vhost_ops);
>> +    if (!hdev->vhost_ops->vhost_set_owner) {
>> +        return -ENOSYS;
>> +    }
>> +    return hdev->vhost_ops->vhost_set_owner(hdev);
>> +}
>> +
>> +int vhost_dev_reset_owner(struct vhost_dev *hdev)
>> +{
>> +    assert(hdev->vhost_ops);
>> +    if (!hdev->vhost_ops->vhost_reset_owner) {
>> +        return -ENOSYS;
>> +    }
>> +    return hdev->vhost_ops->vhost_reset_owner(hdev);
>> +}
>> +
>> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                    VhostBackendType backend_type, uint32_t busyloop_timeout,
>>                    Error **errp)
>> @@ -1707,7 +1725,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>         goto fail;
>>     }
>>
>> -    r = hdev->vhost_ops->vhost_set_owner(hdev);
>> +    r = vhost_dev_set_owner(hdev);
>>     if (r < 0) {
>>         error_setg_errno(errp, -r, "vhost_set_owner failed");
>>         goto fail;
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index 9b98d34dd04..44e65968d9b 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -178,6 +178,19 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>> int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>>                            VhostBackendType backend_type, Error **errp);
>>
>> +/**
>> + * vhost_dev_set_owner() / vhost_dev_reset_owner() - take / release ownership
> 
> I'm not sure this is a common practice in kernel-doc format.
> I think we should add 2 differnt blocks, one for each function.
> 
> Stefano

Agreed, will do.

Andrey
>> + * @hdev: the common vhost_dev structure
>> + *
>> + * Take (VHOST_SET_OWNER) or release (VHOST_RESET_OWNER) ownership of a
>> + * device that has already been set up.  Used to hand a device over during
>> + * CPR.  Returns -ENOSYS if the backend has no such op.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +int vhost_dev_set_owner(struct vhost_dev *hdev);
>> +int vhost_dev_reset_owner(struct vhost_dev *hdev);
>> +
>> /**
>>  * vhost_dev_cleanup() - tear down and cleanup vhost interface
>>  * @hdev: the common vhost_dev structure
>> -- 
>> 2.47.1
>>
> 


