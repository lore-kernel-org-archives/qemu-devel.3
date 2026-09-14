Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA372C88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62jP-0007vT-Lw; Mon, 14 Sep 2026 05:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62jN-0007vG-Of
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:12:05 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62jL-0005Jn-Ff
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:12:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2PLo9yE1HU3dYwYInNgEJxHxHozmwkPaQ375CKV0zpNAeDaeMnUiei39DPsqJplyzOOg5zIdlEb+Uc0u6LvYWJ6JvHgo1oo5iA7+yg9IpLPR+E54oUnYNbv4tL1KkA2RJadCcGFQemaYHjb2mMU/solUlgnL/MZGO0E4++m3hMtGhUPGOHfpXzzuysFqwhwCXH3PWnlggAdLh7TAlTQumM8VSyvMA46lYueQWHuiE3TnV9duQNY1MwaxduJc/xCU4mfrNkmEMFEUAlnEO9CJ9cKxwV+10TWKrHMQ2emP82kpUeZ/q2CdBMJ8udtKbBFaEvlG4MqCWu7NtC7DOLIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMH3PdvkFo9OrCJ33njZ7y6Q5e2Aqbsoty3b+cmJm0Q=;
 b=LjuOao7kNXjqFNNvVtuAzOb/06/jCeYDmiyQk7tqffKsaiQZD4cR1nzWC+Z/Z8RWJD9xZFLs+DGP4eB6y/05QUShX6c1jtDNX077tq7G8XJFi/NZaeAuLuNvPVjDTxhe01Y4mw9Q4Q9w3JhQrwsg1045t/U/kplGJ5g/3Xyo77G9r/8Bc1srNUcqB4oqFJjMqdtTIOMgWxPkIiHBubT5BD2nxS/dfFnz0Gsm4R+ELEb+RG7AZl0I0Q1+22ogYI8q0vxX8jlBWtG1mKa7xge4+zxzYFmsAR7c71pGMxLjKBR3NbyI59aEXjO5fKhhiZnNOZKlPG5MFCWO81ZAETosrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMH3PdvkFo9OrCJ33njZ7y6Q5e2Aqbsoty3b+cmJm0Q=;
 b=jddMn2uNde5m630CM2SZdmrYZknPcGNHbKOhIIZyNVE1LCqq8APC453v1n6iyiW2jFk2NfYSP9KPJ7IVDn6+K0rd2S9CxEfkzWdWgabFGGWXNFve/HzK6vuRdd6Two7J8wM5HrhsJfUjS/Ujte2Ft0/4+dGd1il9jB9hfHHlJkS+566e6/OFfeQz7GP7DRen6G7JrnyZmSVfgmozYCWwxj+AVrul/9n6JLjDWinhYja5Ls4EHlTVLyo2RGqwKgJDCpMwzEwlX6XMdbQ1nMrYNm6EwJEGhqgnOFql8KsDkPGkDfxySDYHaSFPO97PXFRihX5CVKjLSNvzpg3JzYnYFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRZPR08MB11097.eurprd08.prod.outlook.com
 (2603:10a6:d10:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 09:11:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 09:11:52 +0000
Message-ID: <eb001835-0bda-4ae7-9bb7-2008fcb0d147@virtuozzo.com>
Date: Mon, 14 Sep 2026 12:11:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] vhost-vsock: preserve vhost FD during CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
 <ap7Gc_L0gYkAaZiV@sgarzare-redhat>
 <fc5bf943-68d3-4768-bf9e-cef14c81a0e4@virtuozzo.com>
 <aqOu-wrcPrqSpHl0@sgarzare-redhat>
 <1d7c8444-a566-48ae-8c62-4a5e1adf3528@virtuozzo.com>
 <aqe3npSbJDwkeng9@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqe3npSbJDwkeng9@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRZPR08MB11097:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a91a06-e971-49f4-4fd1-08df12403726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|22082099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: W4Q+qvhgHpRR08iy6WVmqM9VVxVPOAG38f1yh6SnBw0/yodtsMOGUnBZMQk3+vMj6P59GK4pjktmxco6aNqhYQvkePKO0brUeMsrHkhRQItdJ4rLlMIepY6Acu6c+Prgka6MLJuHn4mdbYF83pINGu5rsC6QtPXT2hO+SLONuuJuw+OLfHXx06MeEmvmEiHmPUjhDFI1D/9CI+seYirOTcMiFAezPaYsY8N3wSGBszRNGtO0z/OMS6HeFpddm5jhyWX1VFq9avaJKNbrp1X4sDU0PA6cXV08XIWO+W1pejaMojUoVlQVVkuUt00bCknmzkctdE5FAkDrVtmRizCZiv4e5cFJHmPKjbaNobPlkNLYwD8ABOv0x79xBFEjHn8S8pYJ0W+PlCoM/dMrVWgCaVzT7Mw4MOlgdySqn4ZlRBYeKz8hlwGKgWHoCDCxm7kaJyMrjnPSTKOWrguJ6LAofK530eNwOdA2xQQbS6R0aS7CvF982UnA19pAQ7yMSW+dVMBv+1LnwkLr5nZJ0nqOUOJ1S1DJxNVoMtK2wrDoKJnqJIGRhYcEfWYLDmqvK/ddN6EHcAX8a4e/VTbFVgUMH40wg7+8ADifjjprwOF++PVWKeOhMAmpZpczs7a/jtdJbUkFIARYCcxt+cTRj7e9a92grFVamwIR6MniVAX4Z2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9uK3doN25lZEFvOHdQVko0ZUlqenR2SytWR2FsU09tb3ZlZzAzWFNjb2Zn?=
 =?utf-8?B?TlVCcjFhNVIvUlh1Ukc4NG9xV3pjM04yMzZua3BIcC9IOE02L3RxL0wwa3dn?=
 =?utf-8?B?RG1ycHY1TmpYUVNEWVNjclZFdEpjb01vWGlQUy9acDU1WGV0VllENWNJcEt6?=
 =?utf-8?B?cmp6cGlyTFMzY25iNldUNG1HWGxRc2ZnY3hpUDF0OHZSSWFDZkNOVE16T0Iy?=
 =?utf-8?B?U1V3R0FPejlwMlAwZnR3dEpVUWFmWTBsL3hpUTkvVW1QQy93V2dKVjBJUEt1?=
 =?utf-8?B?VEFEbCtqNlFJWjJzZnpKazdXUElTRURYZW1JMWo4KzJZbWlGV0RxSUhlc0F3?=
 =?utf-8?B?bXZLQWlVV1E4Unh0RmhaaGFMZDF1dGtQampJS1A4eGIxeGZqZHdKb0hjQ0Er?=
 =?utf-8?B?cVZ0cHRXWHJPRGh5TmorV2NMUFUzc0xJZmNCOExQcFRDSEdQV1Y3aUF6VmtV?=
 =?utf-8?B?YXlnTENmdXFaa1V6N3MxMUNTOW5RWm16VitXU1pRNFM3L0gydk5CZzc2MFdu?=
 =?utf-8?B?WWpZaEd1T3JTdCtiV29vR1JQUTNjRUtzVVkyaTFDMHAwdXdyUXpQV3BkV0JT?=
 =?utf-8?B?V2Znd3lTYlplOXhNeHM4QlJtUzgvakVoSVUwZHNSNEJ4aE10bFhEc1FIY01M?=
 =?utf-8?B?VVlNUWV3dU1WeE1NQmxxdmxMME05emJUV2ZhZmxNclgxVWdVMFlqNmdVU3Ry?=
 =?utf-8?B?dk1YMDJoMWNERjE0SXAxWDNMOFdLV25mZC92aU9XVThoanZXdWZNNkwrcXl6?=
 =?utf-8?B?Z2JQaENSWXlNMlF6SkJOeCtpbmZrOFByQlJuY2xGaUlJV0pheVIzbDR3eXA2?=
 =?utf-8?B?MlhJTjJJMHViOWpXcWE2VmR4NE8xWFA2dG16em54VG5PZnpRd0JidGwwRjM3?=
 =?utf-8?B?WC93T2xGUEs2dnBJeDhDaTdkMy81ditDdktJb0lyNFR2SHpOQmR5QzZmK2pB?=
 =?utf-8?B?RUxtTUJSTnBlbjVOcnJ4L1BxZ1owZU41ZFFEa3RrMTdPZ0ZQREpnbjlTeVpI?=
 =?utf-8?B?eDFZRlk4QUx2K001OVRaNDdpd0RLV2hETy9YK21ra29pakNHVGFKcTJEMzJv?=
 =?utf-8?B?Ryt1aHJGTGtpaElHYnltbFpJRWh5OFdBR0tGZENjWTdybGNnOFBCU0VFOEp3?=
 =?utf-8?B?UFBqYUhmWG1oNGl0MUtzYnZGWmxkakk3aDlRYjZWR1d1U0x2ZUhEVEl4VDAz?=
 =?utf-8?B?L1BSbGNUcTRQenFYMnl1b0RzcWNXbFpMVG9SbC9hSHlyelRKWTFmNnplbSt4?=
 =?utf-8?B?aE1vdndJZ2xFUW5MVHdMdXVMc2h4dVAvckpvQTFiKzFJbzRhazJWbk1aOXJD?=
 =?utf-8?B?RWtpM284eFBIcFdtMHMxME1Bbk12ZDZxZXVCYmR3MTZMcG1ZaDRDMEVqQThF?=
 =?utf-8?B?WGFHaVBJWEVRbkJpU1RwY3lpM0JhQjN2M1hSd3ZHa2Njbk5mV2lLMU45aFR2?=
 =?utf-8?B?cnVCWU1Sa0VRMEVVRzg5WUV2UytPZlVYM3k3Z1l2L1ZoaEVqbWlWaFk3cjZM?=
 =?utf-8?B?ZnZkTkVnQ0c3eGZqZHhLcERuOEFhSURkVU9Tb3Q1ZDZlVGY1aHlpTmhvNFcr?=
 =?utf-8?B?S0N4Mk5TRUE3LzErdWtJdXRGVEI3K3MzTTIxcHEvZktEN1pxYXFIYy9qa2cr?=
 =?utf-8?B?VlJGTlBYa0JJZ2g0Tk5wem9XMVJ2azAwT01OM1hyaG1JNm5TMlpKOUlodFRW?=
 =?utf-8?B?Ym8vc09zWTM5SlBNSUZiZVEyRUQycTNkMnBSY1I3WkYzQkZydlRZcGxuL1lZ?=
 =?utf-8?B?cmNGQzlNd2hyMHg4dHdPK2cwUXBRbEc2UEt2TjB4ckVrWWs2dGhlL1p4WlJX?=
 =?utf-8?B?QXJ5Q3VJUXM0SHltWGl3ZEU3UWlnenBxcmVjajZZcWEyT2MwUHM2bmpZVGhz?=
 =?utf-8?B?bnR2T2NTOTJPV2tiVWJla040SDVibC9lME00OXlZa2pOUUJRNmZZYjA5dEcr?=
 =?utf-8?B?MzBCTCswZUVlU2NXdk1wZWVpdGFJbTQ5VXQ1QWljL0hYVDZNeGdVbmVkT3My?=
 =?utf-8?B?V0Ewa2dmNDdPQ3VkNVVEQXcwdSs3Vm1tRHd3dVh4Rkp4SkFtZ1duU2Q4NUlK?=
 =?utf-8?B?TTIxbHd6TGE1cE5JbUtzdERHQXpoUmdsUC9PWDdiUjg1VU5Md1R4eEdzNFRY?=
 =?utf-8?B?TVRlVjh1c1lldC9OTFRRdElSZmhDMGhFWEc1VWZXSzk1bVNrYzhnVm4rMXRy?=
 =?utf-8?B?bkJQNTl6TnhjRXEzeGNYOFIrNlYrTnNRUThnK0xvblR4YUc0T1hGUUtwOVRL?=
 =?utf-8?B?LzhmZ3JTajRuRXN6WFFScHBhYTRjaWZOSEZCdUJvaEoxRjFsQlQrMDRrdTMx?=
 =?utf-8?B?VlJKVXBFdi9ZQ1RLR0p3QTdUWVhrMnQ2czRMSnpzSEIxYWwzTUF3NG54QWk1?=
 =?utf-8?Q?WAHvIV9bmEr+Q5hY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a91a06-e971-49f4-4fd1-08df12403726
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:11:52.3509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RmJjR8YrAHJ2rU9F+cigqW00gTHL1K48YRFh3D76NMQzYOtOMEgJQ6h8OPL/pcGAJ1yQhBGffPV0vfJSkoQK+xgY0sk01EGgzVqYNeier0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11097
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 9/14/26 12:03 PM, Stefano Garzarella wrote:
> On Fri, Sep 11, 2026 at 07:35:31PM +0300, Andrey Drobyshev wrote:
>> On 9/11/26 10:37 AM, Stefano Garzarella wrote:
>>> On Wed, Sep 09, 2026 at 07:59:55PM +0300, Andrey Drobyshev wrote:
>>>> On 9/7/26 5:55 PM, Stefano Garzarella wrote:
>>>>> On Thu, Aug 20, 2026 at 02:39:50PM +0300, Andrey Drobyshev wrote:
>>>>>> During CPR (checkpoint-restore) migration the guest keeps running on the
>>>>>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>>>>>> we should reuse the FD from the source.  The FD is saved in the CPR
>>>>>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>>>>>> target via cpr_find_fd().
>>>>>>
>>>>>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
>>>>>
>>>>> mm, are we sure the device ID is unique?
>>>>>
>>>>> I just tried this whitout receiving any error:
>>>>> qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=vsock0 \
>>>>>      -object memory-backend-memfd,id=vsock0,size=512M \
>>>>>      -device vhost-vsock-pci,id=vsock0,guest-cid=3
>>>>>
>>>>> Stefano
>>>> You're right, that seems to be the a real issue.  In fact there's even a
>>>> UAF bug IIUC, stemming from the fact that we: 1) provide key destroy
>>>> function when creating the CPR hash table; 2) use same CprFd for both
>>>> key and value.
>>>>
>>>> That means that when we have several devices supporting CPR with
>>>> repeating IDs, we do:
>>>>
>>>>  g_hash_table_insert(table, fd1, fd1);    // table has fd1 -> fd1
>>>>  g_hash_table_insert(table, fd2, fd2);    // table has fd1 -> fd2
>>>>
>>>> Here fd1 and fd2 have same hash of course. According to GLib docs [1],
>>>> value is renewed in this case, but the new key is destroyed and the 
>>>> old
>>>> one is used.  As a result, fd2 is freed.
>>>>
>>>> And, mind you, this all happens long before actual CPR, cause the
>>>> devices with CPR support usually call cpr_save_fd() somewhere in
>>>> .realize().  Thus we get memory corruption right at boot time, plus
>>>> subsequent CPR will likely crash.
>>>>
>>>> In these circumstances I'd personally prefer just asserting on repeating
>>>> key somewhere in cpr_fd_hash_insert().  The only downside is that it'll
>>>> crash when booting 2 CPR supporting devices having identical IDs, even
>>>> if the user isn't going to perform CPR.  I'd say it's acceptable, what
>>>> do you think?
>>>
>>> I'd prefer an error if possible.
>>>
>>> That said, can we append a prefix to the key (e.g. `vhost-vsock`)?
>>> In this way we reduce the chance to have a conflict. Of course the user
>>> can still assign `vhost-vsock-something` to the memory backend and
>>> `something` to the vhost-vsock device, but yeah xD
>>>
>>> Thanks,
>>> Stefano
>>>
>>
>> If you mean erroring out directly at startup whenever we encounter a
>> duplicate CPR key, with a clear error message instead of abort/crash - I
>> agree that it's a better solution.
> 
> Yep.
> 
>> That'll likely require changing the
>> CPR FD saving API, but shouldn't be too intrusive.  As for the prefix -
>> once we forbid duplicate keys entirely, there's no need for it.
> 
> Agree, but not sure if this break some user that re-use the same id for 
> devices in different "namespaces" that will boot, but collide when doing 
> CPR. That said, no strong opinion here, maybe I'm overthinking.
> 
> Stefano
> 

I ended up following your advice and adding the prefix (see v5 I just
sent).  We still error out on startup in case of collision, which is the
right thing to do, but minimize the chances of such collision.

Andrey

