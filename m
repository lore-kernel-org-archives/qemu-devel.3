Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB43DC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Fs-0004nn-Ry; Fri, 11 Sep 2026 12:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x54Em-0004dQ-Mb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:36:33 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x54Ee-0005dp-7d
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdPBIj+T/ugA+Py37dVZtL5Yiu1PHl+CTIu8iKrXXg5RJiN0Xy7xCeeh2e1hkxecryX6ItLZxEKUiLCPISfaPypJ+dTNoRN6CyMthPUBBkf//CAqty8eEDMRG1g6niIq74K7LOMKBMtkmKLeC3CAbIl27U+OWg2dJFI4GdRohY9xugN4sobMBA9AxSk2mxZAnIDMUyId6SNOs23OyD6LpV6OzHvbdGWFJUjjNCtmWX4aM7WgHZPGQ/f5sLIDfgowzi1MdF1c30MydlQ1vAt1j9bEgkfzJHaWcJvCAZ4i1Bp/OUMOFeqmvNFop9s42W9TG2WQS1VUK6Mss2WbWPHGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U82naXSRZ2EYEr07qS4/duwmOcf311PWS8+q8hBV0vo=;
 b=xz9+WXJNh6JS0+A3oQS02cW+zgP/GOW3mdFrvl3q9merBBZEqXGSEVb1LlMP3UlyCu7+8L+rtfcxuWwMwm2efueWRA950fR/it/ywxB+euiAezSFo+OJvrPiee2YhQLo+2FCnSud9dR4hSGich8P5HdqE9RSt0Yq3gkgE1cXEwDAfYuRhAmlGoVVfDyCdEoIgLR6C2EDT3y9cc8+OXC8bXOgdk7Nej2olnxhVtwhsp/fD1NvD7XlGXu9gtpok3DGG/y0Og7+fPhG3oMYcaRbe826Md0z5WXTE2nA7Dh+YjR1rZjOEjWmo+YUNx/X4/4HQftGB3ejwm2gVVBepheusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U82naXSRZ2EYEr07qS4/duwmOcf311PWS8+q8hBV0vo=;
 b=UqxvSM7cH68X+0AbkPNIQ4S+xqNQCKg5mdKPm2Vo4EdBJq9RvX6DeLcHO4OwO81+4cAr6Z6SgxfyV4HhrC18cjGKxBhUBcmBxMW4c1n5b/JBEvYbZO0/ibCWLI1W6g7zRTK4f7K8VysspW1Q885VwSUuYOBtaEusaQjzoOJ8toMb4w7iMUOdbI1nZp6A2pi54j9kHYdquAoX3y1dPgYiFOuhssxvTBeYkUH/dRWYnNb0Ye3wbSHV32t7H/PMFafcFynoMIgeMdvvZsm+acr6aBwg8ricypfudKsr/8EJomCXgmgliZg8ttEznHgHlzzMKIijROvuinAwWzh2m04I8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB11254.eurprd08.prod.outlook.com
 (2603:10a6:150:2f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 16:35:44 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 16:35:44 +0000
Message-ID: <62183555-7b0a-4c80-8f73-5b489d8d37f3@virtuozzo.com>
Date: Fri, 11 Sep 2026 19:35:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
 <ap7Lma3zpbr6QDb0@sgarzare-redhat>
 <6e1b82d9-b2c8-4c10-bebd-9d500c14b1de@virtuozzo.com>
 <aqOv_Cmxjlk4lQVe@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqOv_Cmxjlk4lQVe@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0720daed-2b89-4572-8d2d-08df1022b9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: rnex+lnp7pgxlNks1FJo4TxpWiP4yBKbj9TFxtakH4LHa6vHrm+4kGVQkhuxoV5pfqD6ErfX6RC6euQcyyzNVMoS5uznUUbHiFSNfdRNIVCJw/gL7X8dYx2b06Kc79A4I4c6nqViiBUMiOcL70hjzec6jQ+E+miVm9OWqghvlbSiGhw74RdbSltqSBcls1s2ERor06srqSUExwt9raIHTjIPzC3Bkd4PX2f88iLPTLfhmLdgcE/WM2SXYZZqj6gww6i6YNSn4YhomzbyqEZ+TfXehmg3QlFaeNyB6+595kGw+rkEjvOTFr3eR5M3uz5Md8KhsZF8tuk0RFXjLeS2U8DBzrgR8rUKXFWpCbBlMCmQu6wIYk3d0zNennXN+OehrEssHvvgOU6GNElO7JNnEfSxMRqKSpBGCNwAlO5lQJyotd2uRzhw+Uk7Q2gEhvv0IX4yI3UaGyi6n3Uc5geNVw2XvBTzqnZ8Om8Gz3tlyPFEqb/y88TiRY76ZTbSW+bmmBxU9kGw+Ka16mHpyGqIdSv1TKgqKhegOjzcXU/f2n8gdrBUOQhR5fckx2qFqwRwhAnmxZOHXUiqEhHysiOFogd4A8CG/vAuv/M49F1qiRs6xSoqYHEDU57++w7i9mOF+sTo8qzxSIFGVhhzCgJtwx/ESRIJoaAzReR6glL8U5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dVTkUrcy9MTjBURy9FODc0TjhyOXhTU1pJTmxKc04wN09FVUFtRmZkQzFt?=
 =?utf-8?B?MThNQ1B4TnZCTC9SNFR0d2l1Y3FISnUxbDlHcnlrbXNEQ1U4cDU3dnlTNnU3?=
 =?utf-8?B?MHA0NkRzaU1NWlNMWGl0YnQyN0tKYzNWb0paWG5qbUErS1BDWTRsUmVZOURx?=
 =?utf-8?B?dVdncWdHTGV0SWRrVXR0cmR1UDZMeUdjaUJzc1h0YUdkWWVnaEJCelRSL0xt?=
 =?utf-8?B?MHppdFFUdkkxb2xiVzJJVmVOSVlzRGRwV2xDbmI1UHd5RThqNi91QlBlTTZt?=
 =?utf-8?B?T3NIbXFOTDhtaGdOZHd5dGpLWGFZL2MzWTVpV1MrUDRMSzg0MmorSlpKdWdi?=
 =?utf-8?B?eDZrajZQWUU4YVAyOExUUWVrbGxYaGh4ajBUWndrVHhkRG1sbXY3OUJMSm5w?=
 =?utf-8?B?SkdmSDFMRmRGbSt3SklqZGROMmxVNmROOGtJQ0FjN2NDMnI1ZStlWGYwNXdn?=
 =?utf-8?B?dzV5SmVjVlpOL2l3azh2c2pRUE9HNDNvMGNnUGpXZ09mbmV0VDlzNk1lS1JS?=
 =?utf-8?B?WXZEa2FsaHk0WWRJdm5aaTJuZjNWQ284K2hBR29zSlB3SlNTZC80SWRNcHYv?=
 =?utf-8?B?WWZiSmZsNm1BTlpmeUNMSk9ZSlFYMU1MekFiVEw0U3p3b2dkQ2NqOXA4bm9w?=
 =?utf-8?B?WWQwYnQrcWxBd2tqODRMeDBIa0MyM2xDUFVhcVRmUXAwcXRMTmRyUTFqL29S?=
 =?utf-8?B?OEFCYzRmSXpTajNMME9VUmJweTgwR1YvMDRLOWZWNUt0emJVcHM5Mkx1MCtQ?=
 =?utf-8?B?bWlCZ1VscnNBMTVUOTFxVERGR3hIelptd1pvUkF4d3B0Yy95U00xMDBQYWNh?=
 =?utf-8?B?bEFEbVF6SVhXQ1FnU0JMQTNVV2pHcTRxdFEwRlBTalJsQUlEa3I1UkVvT0Qr?=
 =?utf-8?B?MWV2em14QVdGblJSMW9SRnV4eFVYTHNwTklJT3dnSkJIcHhBUHErZm9GRkcz?=
 =?utf-8?B?WEdnOFdXN210eEtJcDlsSzJXTW5OMFJrWnZHUkVnNEN5RGJyYUI4VDJkSjRp?=
 =?utf-8?B?SGIxNlpSSURhM0tncm13THI1aU9YZHZpbVhrN1pqci9mbWhNaEdZRi9DVEEy?=
 =?utf-8?B?Q3QwTU1idmlPdEQ2bkpremdIbXZ3d3pJckp6RE9VR29oTHA5M3FjVE1uQnVG?=
 =?utf-8?B?VTBnQmFiVVJleUpibmExOGRHWjc1M1BUWWFlbFJuRnZPM2haNDVBdVdUeitr?=
 =?utf-8?B?OVRxUTB5cC9mektJZ0FzTUZzQkVHZ1JreTZkRlNQWk9KQUsyeFc3WlRhS1VX?=
 =?utf-8?B?SzZHUS9MK3EzYjRYcm5IMUFYR2RiclFqQTQ1dFQxS0JjeXI2VVdSNVFQNDhG?=
 =?utf-8?B?L0hEMlRaU3pkSFdwSWROMndBODNOUERsTm9rTEZ1ekhBQWN5aHVxdjR6U0lx?=
 =?utf-8?B?a0RqYWZtVXY4UndFcjBwanduNGV1NWNadU9aL3ZGUWxBeElmaDVnVzhBMjNC?=
 =?utf-8?B?Rnppbm5vNS82WU1kL1VMYzY0OFFDaGsyQUFwMi9jUEs1NWVNMktpTWhTbTNv?=
 =?utf-8?B?RDFWbndvRXR6NjJKY2MvWXFqMUVlR3Zrbm5hcjB0d0ZsYzhiR3pSbWdHTFh2?=
 =?utf-8?B?VkFUMWNBS3JzaU45Z1h5Q0preVpQMDFpWU14V3p0MjlQQjFDbE1JZi8xZlpI?=
 =?utf-8?B?TmZ6ZFh0cVpzTXJ4aThnZURrc2V6UUJmUEE3UHRHWWdkWiswVnNwSXVWTTFO?=
 =?utf-8?B?WTBNakJ6clZTMHN0aEUyTEkrSk1jbTZ3SUVxVXYxRGZCMmxINlZqWm1SeWta?=
 =?utf-8?B?a1FpeEdlMHFZSkFHY2g3b1lIc2hFZjhCa2ZMTGMvcGZmVFFJUEJ3K0NNYU9C?=
 =?utf-8?B?Wk5WVWMrUWlxdjdiSGwyVXJTaFBpVG1sL0VkdWFId1haT1d1RnE4UjVNbXB3?=
 =?utf-8?B?bWlBRjE3RUh2ZE5DM3liM0pDWWpUUWk1M1dIeDNsZmk4emUzUjFiOGFjVzl3?=
 =?utf-8?B?Rm5GR3QxOFhwWkRsbGczdWg1azhka2RvZ1h1NnJEVWx0blBCNjl6bXZIYU5O?=
 =?utf-8?B?WXZ4QlZNWEhaL1RVYzBVb1AvbWZVeUQ2a1VsdVJMc1UxT3BxcG03anpzb1RT?=
 =?utf-8?B?a3dsYjhpTW0yUnNpWXQ1THludERtU080bVdtcjdMZmx1R0lFcUp3Y2FnM0hv?=
 =?utf-8?B?TWx2N0pBdkFWcGZGWndXMzZVS0ZIV0VSbG9mVnJ3Rko1a1VaNC82YXExN0k2?=
 =?utf-8?B?Q050MTdDUFUrT1lyekJEakFIN3VoL1ZhWVh5cHBSdmZOaE5WclBlV1pWK3Bm?=
 =?utf-8?B?SGpnY2psbEplcDNSQjBkSjVjTnJaT2tRZVQ4N3VQcEZab05FMTFKVjFlNTU5?=
 =?utf-8?B?aXlObDVTek9jQmJieXpGOW92VjArSGRMUnhHU0R4RFl4MHF4MzU1K2NUWEFr?=
 =?utf-8?Q?ea/3yk5KqXiPlaUw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0720daed-2b89-4572-8d2d-08df1022b9f6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:35:44.5994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWFkzrobCn/48SYxsx1V4HD5WyQ+4FZ6uITWgSysaIhvmKNC0eGoRPLemM1C4W9Qi4OPT4B11qLp85ssFh6u6s1Y9kIbW4EvKiSQgEYqq8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11254
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 9/11/26 10:45 AM, Stefano Garzarella wrote:
> On Wed, Sep 09, 2026 at 08:45:22PM +0300, Andrey Drobyshev wrote:
>> On 9/7/26 6:13 PM, Stefano Garzarella wrote:
>>> On Thu, Aug 20, 2026 at 02:39:55PM +0300, Andrey Drobyshev wrote:
>>>> The previous patches reuse the source vhost FD on the destination,
>>>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>>>> in realize().  For cpr-transfer the destination realizes while the source
>>>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>>>> handed over explicitly.
>>>>
>>>> Do this through the device's CPR vmstate hooks.  Namely, release device
>>>> ownership in pre_save, reclaim in post_load, re-acquire on failure:
>>>>
>>>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>>>    cpr-exec).
>>>>
>>>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>>>    queries the backend features by calling vhost_dev_init_backend().
>>>>    It doesn't take device ownership and doesn't touch the VQs which
>>>>    still-running source might use.  The full init is deferred to
>>>>    .post_load().
>>>>
>>>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>>>    the device is started at vm_start.
>>>>
>>>>  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
>>>>    fails after pre_save released it and the source VM is resumed.
>>>>
>>>>  - .set_status() refuses to start a device whose handoff hasn't
>>>>    completed: not fully initialized yet, or left ownerless after a
>>>>    failed CPR.
>>>>
>>>> With the handoff in place, lift the CPR blocker: only ID-less devices,
>>>> which can't preserve their FDs, remain blocked.
>>>>
>>>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>> hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
>>>> include/hw/virtio/vhost-vsock.h |   5 +-
>>>> 2 files changed, 152 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>>> index cec2c31f0ca..e25e5350905 100644
>>>> --- a/hw/virtio/vhost-vsock.c
>>>> +++ b/hw/virtio/vhost-vsock.c
>>>> @@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>>>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>>> {
>>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>>>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>>>     bool should_start = virtio_device_should_start(vdev, status);
>>>> +    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
>>>>     int ret;
>>>>
>>>> +    /*
>>>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>>>> +     * post_load.  On source the device is left without an owner if a
>>>> +     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
>>>> +     * rather than issue vhost ioctls on a half-initialised or ownerless
>>>> +     * device.
>>>> +     */
>>>> +    if (should_start && (!initialized || vsock->owner_reset)) {
>>>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>>>> +        return 0;
>>>
>>> Why returning 0?
>>
>> That's just what every other error path does here, because return value
>> for vhost_vsock_set_status() goes nowhere.  The only thing it'd
>> influence is having one more line in the QEMU log when we're called from
>> virtio_set_status().
> 
> Ah okay, thanks for pointing out :-)
> 
>>>> +    }
>>>> +
>>>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>>>         return 0;
>>>>     }
>>>> @@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>>> }
>>>>
>>>> +/*
>>>> + * Re-acquire device ownership if a CPR migration that released it (in
>>>> + * vhost_vsock_pre_save()) failed and the source VM is about to resume.
>>>> + * This runs before vm_start(), so the device is owned again before it is
>>>> + * restarted.
>>>> + */
>>>> +static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
>>>> +                                    MigrationEvent *e, Error **errp)
>>>> +{
>>>> +    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
>>>> +    int ret;
>>>> +
>>>> +    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
>>>
>>> IIUC MIG_EVENT_FAILED only covers the source failing. If the source
>>> completes it successfully and something goes wrong afterwards (e.g. in
>>> the destination), what will happen?
>>
>> Hmm that indeed might be a problem for cpr-transfer.  E.g. target fails,
>> management (libvirt) sends qmp-cont to source, and we bail out with
>> error in vhost_vsock_set_status().
>>> Thinking if we can try to call vhost_dev_set_owner() in
>>> vhost_vsock_set_status(), expecting also -EBUSY, instead of relying on
>>> `vsock->owner_reset`.
>>
>> Moving .set_owner() to .set_status() actually looks promising, I'll try
>> it out and see how that works.  Although I'd still keep the flag and
>> restrain from tolerating -EBUSY - we shouldn't proceed to realize the
>> device if we don't own it.
> 
> Yeah, agree.
> 
>>
>>
>>>> +        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>>>> +        if (ret < 0) {
>>>> +            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
>>>
>>> Is it okay to return 0 also in this case?
>>
>> As of now it's mandatory cause migration_call_notifiers() asserts on
>> type == MIG_EVENT_SETUP whenever notifier returns non-null.
> 
> I see, thanks.
> 
>>>> +        } else {
>>>> +            vsock->owner_reset = false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vhost_vsock_pre_save(void *opaque)
>>>> +{
>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>>> +    int ret;
>>>> +
>>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Release the device ownership now for CPR migration.  The device is
>>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>>> +     * VHOST_SET_OWNER in post_load.
>>>> +     */
>>>> +    if (cpr_incoming_needed(NULL)) {
>>>
>>> Am I missing something that keeps pre_save from running outside an
>>> actual CPR migration (savevm, or any save path taken while mode is still
>>> set from an earlier attempt), or should the condition be tied to a CPR
>>> migration actually being in flight rather than to the mode parameter
>>> alone?
>>
>> You're right, that's a real bug.  Should probably guard it with
>> cpr_incoming_needed(NULL) && migration_is_running().
> 
> Yeah, that looks better to me too.

Actually I checked, and this is not enough:

  qemu_savevm_state() ->
    migrate_init() ->
      migrate_set_state(MIGRATION_STATUS_SETUP)

And migration_is_running() returns true when in MIGRATION_STATUS_SETUP.
So on savevm we still encounter the same bug.

Now, the savevm/loadvm operation doesn't make any sense at all in
cpr-exec or cpr-transfer mode.  That's because savevm/loadvm suggests
saving VM state, which implies saving its RAM entirely.  And the whole
point ot CPR is avoiding saving entire RAM (see migrate_ram_is_ignored()
in migration/ram.c).

So I'm guessing the proper fix would be patching migrate_can_snapshot(),
which guards 'save/load-snapshot' and 'savevm'/'loadvm' commands, to
make sure they can never fire with any of CPR modes set.  I'll add this
as a separate patch.

migration_is_running() should probably be kept here to guard from things
like qemu_save_device_state().
>>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>>> +        if (ret < 0) {
>>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
>>>
>>> vhost-vsock devices that don't support `reset_owner` will fail here,
>>> right? Is that what we expect?
>>
>> Which devices you mean?  No other vhost-vsock devices should ever end up
>> here, e.g. vhost-user-vsock has .unmigratable = 1 set, so .pre_save() is
>> never run for it.  If you mean the kernels which don't support
>> RESET_OWNER - then yes, we'll fail here.
> 
> Yep, I meant the kernel.
> 
> I'd like to better understand what happens when we perform CPR with a 
> vhost-vsock device and a kernel that doesn't support RESET_OWNER. Both 
> before and after this series.

Before the series obviously nobody was issuing RESET_OWNER.  And without
the RESET_OWNER, AFAICT, cpr-transfer fails on the target at
SET_GUEST_CID with EADDRINUSE because the source still holds the CID.

After the series, whenever RESET_OWNER operation fails, and it fails on
the migration source in .pre_save(), we get:

  - 'migrate' command itself returns success;
  - 'query-migrate' reports status=failed with "pre-save failed...";
  - QEMU's stderr ot log contains "vhost-vsock: vhost_reset_owner
    failed: %d".

That's what happens on source.  If it's cpr-transfer - target dies
reading a truncated stream.
>>>> +            return ret;
>>>> +        }
>>>> +        vsock->owner_reset = true;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>>> {
>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>>> +    Error *local_err = NULL;
>>>> +    int vhostfd, ret;
>>>> +
>>>>     /*
>>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>>      * guest cid is unchanged, and the cid-change reset would otherwise
>>>> @@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>>>         return vhost_vsock_common_post_load(opaque, version_id);
>>>>     }
>>>>
>>>> +    /*
>>>> +     * CPR restore case.  The source released device ownership in its
>>>> +     * pre_save.  Complete the handoff here, before the device is started
>>>> +     * at vm_start.  Init vhost device on preserved FD, issue
>>>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>>>> +     */
>>>> +    vhostfd = cpr_find_fd(proxy->id, 0);
>>>> +    if (vhostfd < 0) {
>>>> +        error_report("vhost-vsock: could not find restored vhost FD");
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>>>> +    if (ret < 0) {
>>>> +        error_report_err(local_err);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    ret = vhost_vsock_set_guest_cid(vdev);
>>>> +    if (ret < 0) {
>>>> +        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>>>> +        vhost_dev_cleanup(&vvc->vhost_dev);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>     return 0;
>>>> }
>>>>
>>>> @@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>>>         VMSTATE_VIRTIO_DEVICE,
>>>>         VMSTATE_END_OF_LIST()
>>>>     },
>>>> -    .pre_save = vhost_vsock_common_pre_save,
>>>> +    .pre_save = vhost_vsock_pre_save,
>>>>     .post_load = vhost_vsock_post_load,
>>>> };
>>>>
>>>> @@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>>>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>>> +    bool cpr_incoming = cpr_is_incoming();
>>>>     int vhostfd;
>>>>     int ret;
>>>>
>>>> @@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>     }
>>>>
>>>>     /*
>>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>>> -     * device ownership is not handed over, so the target fails to set
>>>> -     * up its device.  Fail the migration early and gracefully instead.
>>>> +     * With the ownership handoff in place CPR migration is now supported.
>>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>>> +     * we only keep the migration blocker for the ID-less case.
>>>>      */
>>>> -    error_setg(&vsock->migration_blocker,
>>>> -               "vhost-vsock: CPR migration is not supported");
>>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>> -        return;
>>>> +    if (!proxy->id) {
>>>> +        error_setg(&vsock->migration_blocker,
>>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>> +            return;
>>>> +        }
>>>>     }
>>>>
>>>> -    if (cpr_is_incoming()) {
>>>> +    /*
>>>> +     * Re-acquire ownership if a CPR migration releases it (in 
>>>> pre_save) but
>>>> +     * then fails.
>>>> +     */
>>>> +    migration_add_notifier_modes(&vsock->cpr_notifier,
>>>> +                                 vhost_vsock_cpr_notifier,
>>>> +                                 BIT(MIG_MODE_CPR_TRANSFER) |
>>>> +                                 BIT(MIG_MODE_CPR_EXEC));
>>>> +
>>>> +    if (cpr_incoming) {
>>>>         /* Reuse the fd handed over from the source QEMU. */
>>>>         if (!proxy->id) {
>>>>             error_setg(errp, "vhost-vsock: device ID is required for "
>>>> @@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>
>>>>     vhost_vsock_common_realize(vdev);
>>>>
>>>> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>>> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>>>> -    if (ret < 0) {
>>>> +    if (!cpr_incoming) {
>>>> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>>> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>>>> +        if (ret < 0) {
>>>> +            /*
>>>> +             * vhostfd is closed by vhost_dev_cleanup, which is called
>>>> +             * by vhost_dev_init on initialization error.
>>>> +             */
>>>> +            goto err_virtio;
>>>> +        }
>>>> +    } else {
>>>>         /*
>>>> -         * vhostfd is closed by vhost_dev_cleanup, which is called
>>>> -         * by vhost_dev_init on initialization error.
>>>> +         * CPR restore case: only learn the backend feature set now, but
>>>> +         * defer taking ownership or touching VQs (the still-running source
>>>> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>>>> +         * is done later in post_load.
>>>>          */
>>>> -        goto err_virtio;
>>>> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>>>> +                                     (void *)(uintptr_t)vhostfd,
>>>> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>>>> +        if (ret < 0) {
>>>> +            /* vhost_dev_init_backend() does not close the fd on error */
>>>
>>> Okay, but IIUC this is returned by cpr_find_fd(), is that funtion
>>> passing the ownership of the fd, even that the fd is not removed from
>>> the hash table?
>>>
>>> Should we call cpr_delete_fd() when we take it?
>>
>> You're right, that should be a proper cleanup.  Every path that closes
>> the fd after a successful cpr_find_fd() should also drop the entry.
>> Will add this.
> 
> I don't know how CPR works, but if we don't close the FD here, will it 
> be closed later? I mean, if we leave it on the map, will someone else 
> close it?

CPR code doesn't close any FDs on its own.  Those FDs are owned by the
devices and we only account them so that they stay opened and their
numbers get transfered to the CPR target - that's it.  If the caller
doesn't close them on a failed .realize(), they get leaked.  Or, if we
close them but keep the entry in CPR registry - target gets a stale FD
number.
> That way, we don't have a different situation here.
> 
> That said, I'm fine also with your solution.

Yes, closing fds on the caller side still looks ultimately better.

Andrey
> Thanks,
> Stefano
> 


