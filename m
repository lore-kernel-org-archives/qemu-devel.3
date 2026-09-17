Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D5BC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BIJ-0001xV-QZ; Thu, 17 Sep 2026 08:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BIF-0001wf-IS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:32:47 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BIC-0000VD-L7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:32:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skdFyVdWRyOXG73IukhhsmBVPLLFzWopG0vvo9q7GpE3/NzKzsGxWZcch00atlvvvNACg9xjoP8RewX0jf+4WHivV3/891b6LX+0bKZYuB7oZY+8r6VO6w6ZpKfc5EtyzMAfYWoaLnfP6/zSWlGDh5DA1k01HhoGe4npEbVM3Se+tniCKQnLUfjTsEL/H2/AhxVYXnBig4tkSZLVnOSyBhKRskzc8/2yLvq0XWz9FP6mPCHBPeQpdcMXqvaIXkUbmp53N3ark3fkjw47evJQL8MSx7vCn1EayBvJdknGPxDrlOt7ljRovJzIOiHxpGvB+1fAmPstxvXlr/rBT2e85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dwk1zinAciLdF5fY3F1kKHd+uV9/jXyScxEFAaOtLZ4=;
 b=r4JyuTFSzRM4t6NhMoZ/A3q26hT/RTozdVoq4tJoJ3NL7AlETHl0qZhaSWvlyhuBJYep89kQYGFOh8qr9X2Unq9PpAgOU/d/vGeYqxUmxYLS87nsyt42eizg/+7BVkkU5ABAYl+k+S73tfy6kClkN/FYmurpumVnm831Xc8YNHfsIajyAhKCVzO+3qA4QywaW+xt0eBWV7tc9D4Z7pLFtbdeizJt2q5yJxwn4T97EMur3YRUrSBDVDU6paNAz0u6ptvDB3fzscUslE316NhZAFIvzK23NPKUKv4Xfi/hdtl13AYvK2Db6HKPTtvtXx51E0E/ErhoAYBW/qR3Uh+68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwk1zinAciLdF5fY3F1kKHd+uV9/jXyScxEFAaOtLZ4=;
 b=HdKiJfV9VrITH0/Zx0WUIGbKWdjb6LTRmbHvsrt4l3sVEftX7rN13B0swlaIdRt+yltCTpIdvbJ7HjlhGn4ge6DqO/ae+SY3jeeIcF/ne+mqAv2C6LfAhjLxPhRq/6XOSaklmmED8qxYZWlwgmqeEjyPben7dgVbRRF1niDLQHClN4/7EXPDTlx0l7fH9x1Q3Chhr8iLsjfvd4T5sz+AGdgdX441jejLweB7nE1DLql1KEUcOE0RCGIvPnkv14vD7dgLanZl6q4jpbLn/RWY9ltjaMkmKDj5IWhbN6ku1VH4CMeNkoH0mI1B4qKPt9o3gludX/Nw2p0WMHiwyGOpOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6599.eurprd08.prod.outlook.com
 (2603:10a6:20b:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 12:32:36 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 12:32:36 +0000
Message-ID: <3e908763-4088-4655-9d37-0d3e407a23d8@virtuozzo.com>
Date: Thu, 17 Sep 2026 15:32:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de,
 den@openvz.org, sgarzare@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-1-4d31b2dc6afd@virtuozzo.com>
 <8a44f72e-2d00-4663-b348-8ca174ab276e@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <8a44f72e-2d00-4663-b348-8ca174ab276e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: d48bf5e6-af96-4ac9-e6a9-08df14b7c14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kGSFgLRJ+9lRET7F08l399aa20FsBN7uXEiESn8O8p0aP1RviyzLP4/Fo4ycN33WEXhaVL3oHLVqHAK/Nv45TStHlGQZzwbXU84SkndRQvoNnpkcRXsZyS9Z7j300JXztxeQm7OqdFUIH1WTXw1iPBufTfhLhh33Dc3MQo7mTgQoSgsnXEzbDWWFyfxjp/kG0EWv6LWNX8sNrrQqEMTMcmmvyK3oskfTVhJmGgAV8FbBqJ7fyO68y+a9uWoCOKrc7lfI1wE/fg8cYA2Mr+KoWHAFXHk36ZPk8QQigRrRjE2owVzn4VsrbRBdf+QvSyU2l88BL8GC8XQbHW+AqOQnaJJViYIEjBst68WqK3Nf+z+MpVUdrQIZeJwZY02jhmcwq62WO01pWFjfYDystfy3HV3V5tqeCh6qQW6nkVVTOYvl/mf7TVv+D4fGT4ARHDuYPn1BIWj6Se/nS3Ck53JCrk9DwBfN12EBj2iseckrhZAmBC5FBQKD71sovgUuFZ4z2pWSMi/iz3swpkTbO4FeKI5WqtX/Lf/rSbWEtMboX5U8nZ7RsT82Z6KXlJf18J8CLLcfPFMyAOOEXluA1SlCIZ34DrB6PJzikk8gbwG/S1fzOtaqHOMg8KEqnMdnaX+w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdHSVVhdEZhVDB3MGtqU01rNUZ2MVlUamljTVgvbkMxb3AwOWtld2QxSWxG?=
 =?utf-8?B?Y01JUFZzb3lsMnRzQzg2amNweldvd1ZjenhBdUQ1Z0w5UG4ySU9CT0Vkd2F3?=
 =?utf-8?B?S1lYeGo1R2x1ZWlSdnc3cGpCa0ZlSk0vQ0t1RFFZMzc5d0RkeUFMaklsNVpu?=
 =?utf-8?B?VmV4YmlqNktvYjdadUt5VHZOUWVqVVltc0FUY0gwR1dGNHVBNVhyQm1ETUVN?=
 =?utf-8?B?allWODcrZXRLR1JjQ3NFSy9rZUZjTDZPT3JCNUdGMHduVWxZMnZTUzUwYVM3?=
 =?utf-8?B?aU5YMC9IR3ptWENETWIrUGVpR3dGSlhyNEhUWityNXVreWpob1lMM24yR0o0?=
 =?utf-8?B?MytHMjgxaHVBbUxwRTczZFRkajV4akl3L0hpbWJjbVRZWDRySGRoS0lETHkv?=
 =?utf-8?B?VUIrSXJ4UjdmcjhDT2RvTFdKcWNHL2l5TG5rV2thME9HN21BYVZlY21RVENW?=
 =?utf-8?B?b053WU5pR0RkU2IzdDVoN05UNURoWlNFVlRxVFlBcWJXT3NvR285VTB6dmND?=
 =?utf-8?B?RVlGMHVwZi9pREZEVkdUZU1Pdk5PRGgvbWV3S0ZWSVU0YU1IZEhheEVUdENv?=
 =?utf-8?B?RHVQUDZzQ2xyREgvQ3pjQUxHNE90aXp3T3dMSy9zY2hnVjI1dTdLcEY2OURq?=
 =?utf-8?B?VnJwRy9tdmRjRkNxczJtWHhNaXNBSHdzaFVLQzhWRkUySXNEZnNYRktOQWxl?=
 =?utf-8?B?QkROeEoxV0ZES3U1cU85VFZQVlhSZytRUmU2L2s0QUoxKzBLMEJGTGo1eGQ3?=
 =?utf-8?B?YmU4cUFjeFJoSjhoN1Zza0YxclgyV1REQ3pzRXhIYklhZzFYNE5DRDhrMmxQ?=
 =?utf-8?B?dXB5Y2ZiUHBSeURuSDdwZDkrbVd2ZEFuZm9PSFc3UjBkK2c1L3k2Q054R1ZQ?=
 =?utf-8?B?bHE3UUFJaDQvSGtzUzU1UHB5TExUVVFna3N2aFJnbm1mbHB3MGhXWXYraklT?=
 =?utf-8?B?RWZEaURReVYzYXk5Z1RieXhSNlhoY1AzeFhtbnRrVkt1N1pJcDNDM2FGaGRI?=
 =?utf-8?B?OVl4MUFGMHRuRk1RWk1rZ2Vua0duQVBrbnN2WnF4NjhpL1AwZ0ptbTBKSjBE?=
 =?utf-8?B?ZERtY3BsWVFpS1FaMUNnNm1sOFhLb1UzMGxqOFd2aWVHZ3Y2eG1QV2dBeGdw?=
 =?utf-8?B?MER6Sy8xZnJCRVFiZm1HYXZ4eVErM1phdHR2WWl1aFlaa3d3VGpKb0xuVXNi?=
 =?utf-8?B?M0JQY3FZYnNJdlVvUzltOVlDTGpKT1B0SU5QS2NyOHVqQWVHQ0l4WUp0VWdS?=
 =?utf-8?B?K2dzZFQ5OHlYNTBtZXl1QjlNanBxd3NPWXZIdGlicUhKcW5MMlZPaTN5S2FV?=
 =?utf-8?B?MnBXd3NCM1VrYXdhbWlTZEI3VUU2OE93U1VkMVNLN1BPVkdKcG5ob3VCT2pL?=
 =?utf-8?B?UG5YNW5YOGRCMkVoY0dNUVZCeVZIbHY1NEwzd3BhcE9VLzE1MEZjcDZ5YlAx?=
 =?utf-8?B?ZEQ2ejdhWkJheUdqd0tCNnQvd1VhcXRXL01JV3MxYzArWWxFYnRZcllsUHZW?=
 =?utf-8?B?OUQvajlybTlEbXZnekQ0MlFpZDM3SGl0bGw0aVRENDlkKys5bUhUeVlBaEl5?=
 =?utf-8?B?QUFpZW80cXVCcTdJYkRUcFpqQlVsMm1EQ2J5Y2gzZU1IQ1JLcWJrOUVtZUdn?=
 =?utf-8?B?UEgvbzFyenBpdjVJdXRObkJUT0puTVNMQmFDYVB2SHJxVU5yV1FXSFJpd0tn?=
 =?utf-8?B?M21vV2lHNmlXSVU5K0ZIa00yRGpETUsvejhxZXVNZDVGTitIVE0zdUdVM0xs?=
 =?utf-8?B?enJpSVl2SjUzRjVoL3llcTVBSTNDNjA3K1FxTXg0d2JTRW9GRWNMcU5LQmJK?=
 =?utf-8?B?NjNqdVBvS0h2L20rcHFMd1p1Zm9FZTF6UG5LVnlmS3NqRmVrbjdlS2F6TTln?=
 =?utf-8?B?bm9hOWIwc0FvRGZIdHptQ3BLbk1Vc0JRYlJKdVNDYWdUM2s0NWRZVzdIOXhq?=
 =?utf-8?B?RTBQbkp1MytzMCtIam9TSjNaejcweTZzdEQ5SXJuZnl0bHI3aldxY2kyMGda?=
 =?utf-8?B?bmk1c1hRY0Vqd2QwaWtGdGh1WjdKdG03MTdHQUkzWFBGTUdHTXFlZXJseHhx?=
 =?utf-8?B?RVQrWEdiTG1qOTVKNEdDZUZ6b3dzeVNPSGQrOUg4S0ZSVXJxZ0Q1YmFiVFh2?=
 =?utf-8?B?OE91NU1DL3MyM0J3YklmQkhjbkVCZEMyd3BNUUdFZG5mcjVkcXQ4NW5LZ08y?=
 =?utf-8?B?YlhydmY1OGt6RFJCOUZhdkl3dTNkN0lhSW94VzczUjB3b3R0cTFsdzU2R3Bz?=
 =?utf-8?B?T2dkT000dy9CRkdvTkZyRU11RVZvRHdTeXZxZ1dlckkra0ZzWDNRTzBGTkIz?=
 =?utf-8?B?WGFvWFlDZkR5R0daeFZiSFh0TUc2TFZvYjFjNnBDRVNSMG5sS2dIUWhjS1c2?=
 =?utf-8?Q?0qkjNffK6QdBBazM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48bf5e6-af96-4ac9-e6a9-08df14b7c14a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:32:36.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7VO/MJ+3gXa9vhY3W8fP2KQRm2/rEJT5O80OzYgzIDGIR+fXfbLfkN6YVF8YMecwXxc6U+xaoe9VIklG4WxnTrllSW7Ii02l9iJfHcNr70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6599
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 9/16/26 11:28 AM, Cédric Le Goater wrote:
> On 9/15/26 22:59, Andrey Drobyshev wrote:
>> In its current form, the mechanism for saving CPR FDs into hash table
>> has flaws.
>>
>> The CPR fd hash table uses the same CprFd for both key and value, and
>> is created with a key destroy function.  Inserting a second element
>> with the same (name, id) key leads to a use after free.  According to
>> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
>> value with the new element, and destroys the new key.  Thus when
>> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
>>
>>    g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>>    g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */
>>
>> Any subsequent cpr_find_fd() for that key then returns freed memory.
>>
>> This is reachable whenever two CPR-aware objects register fds under the
>> same name, and it happens long before an actual CPR, since cpr_save_fd()
>> is typically called from .realize(), i.e. at boot time.
>>
>> Apart from the UAF itself, when the user decides to perform CPR migration,
>> on CPR target we'd get corrupted FD from the hash table and fail somewhere
>> in .realize() for affected devices.
>>
>> As a solution, let's altogether prohibit adding CprFds with duplicate
>> keys.  Since FDs are being registered for a subsequent CPR right at the
>> startup in .realize(), that'll allow us to error out and exit QEMU (or
>> fail a device hotplug op) gracefully instead of delaying potential
>> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
>> instead of 'void' and provide an 'errp' argument to it.  That way caller
>> becomes responsible for checking the return value and propagating the
>> error.
>>
>> Also update all the callers to use the adjusted interface to keep things
>> compilable and bisectable.
>>
>> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
>>
>> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   backends/hostmem-memfd.c   |  5 ++++-
>>   backends/hostmem-shm.c     |  5 ++++-
>>   backends/iommufd.c         |  4 +++-
>>   hw/vfio/container-legacy.c | 17 +++++++++-----
>>   hw/vfio/cpr-legacy.c       | 10 +++++----
>>   hw/vfio/cpr.c              |  6 ++---
>>   hw/vfio/pci.c              |  5 ++++-
>>   include/hw/vfio/vfio-cpr.h |  6 ++---
>>   include/migration/cpr.h    |  2 +-
>>   migration/cpr.c            | 55 ++++++++++++++++++++++++++++++----------------
>>   system/physmem.c           |  5 +++--
>>   11 files changed, 78 insertions(+), 42 deletions(-)
>>
>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
>> index e21c5a3f2e2..a95a4368a9e 100644
>> --- a/backends/hostmem-memfd.c
>> +++ b/backends/hostmem-memfd.c
>> @@ -54,7 +54,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>       if (fd == -1) {
>>           return false;
>>       }
>> -    cpr_save_fd(name, 0, fd);
>> +    if (!cpr_save_fd(name, 0, fd, errp)) {
>> +        close(fd);
>> +        return false;
>> +    }
>>   
>>   have_fd:
>>       backend->aligned = true;
>> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
>> index 806e2670e03..2fa7b823a62 100644
>> --- a/backends/hostmem-shm.c
>> +++ b/backends/hostmem-shm.c
>> @@ -48,7 +48,10 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>       if (fd < 0) {
>>           return false;
>>       }
>> -    cpr_save_fd(backend_name, 0, fd);
>> +    if (!cpr_save_fd(backend_name, 0, fd, errp)) {
>> +        close(fd);
>> +        return false;
>> +    }
>>   
>>   have_fd:
>>       /* Let's do the same as memory-backend-ram,share=on would do. */
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 15f2a513501..45fd2e44c7f 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -85,7 +85,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>>           if (cpr_is_incoming()) {
>>               be->fd = cpr_find_fd(name, 0);
>>           } else {
>> -            cpr_save_fd(name, 0, be->fd);
>> +            if (!cpr_save_fd(name, 0, be->fd, errp)) {
>> +                return;
>> +            }
>>           }
>>       } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>>           error_setg(errp, "/dev/iommu does not exist"
>> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
>> index 7ac7b372145..1d2c8356189 100644
>> --- a/hw/vfio/container-legacy.c
>> +++ b/hw/vfio/container-legacy.c
>> @@ -844,16 +844,21 @@ static void vfio_group_put(VFIOGroup *group)
>>   static bool vfio_device_get(VFIOGroup *group, const char *name,
>>                               VFIODevice *vbasedev, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       g_autofree struct vfio_device_info *info = NULL;
>>       int fd;
>>   
>> -    fd = vfio_cpr_group_get_device_fd(group->fd, name);
>> +    fd = vfio_cpr_group_get_device_fd(group->fd, name, errp);
>>       if (fd < 0) {
>> -        error_setg_errno(errp, errno, "error getting device from group %d",
>> -                         group->groupid);
>> -        error_append_hint(errp,
>> -                      "Verify all devices in group %d are bound to vfio-<bus> "
>> -                      "or pci-stub and not already in use\n", group->groupid);
>> +        if (!*errp) {
>> +            error_setg_errno(errp, errno,
>> +                             "error getting device from group %d",
>> +                             group->groupid);
>> +            error_append_hint(errp,
>> +                              "Verify all devices in group %d are bound to "
>> +                              "vfio-<bus> or pci-stub and not already in use\n",
>> +                              group->groupid);
>> +        }
>>           return false;
>>       }
>>   
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index 2d40d8baeaf..14a06a1fa59 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -254,15 +254,16 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
>>                                                   &vrdl->listener) == 0;
>>   }
>>   
>> -int vfio_cpr_group_get_device_fd(int d, const char *name)
>> +int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp)
>>   {
>>       const int id = 0;
>>       int fd = cpr_find_fd(name, id);
>>   
>>       if (fd < 0) {
>>           fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
>> -        if (fd >= 0) {
>> -            cpr_save_fd(name, id, fd);
>> +        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
>> +            close(fd);
>> +            fd = -1;
>>           }
>>       }
>>       return fd;
>> @@ -291,6 +292,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
>>        */
>>       cpr_delete_fd("vfio_container_for_group", group->groupid);
>>       close(fd);
>> -    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd,
>> +                &error_abort);
>>       return true;
>>   }
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index ffa4f8e099d..6e1659dcddc 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -32,11 +32,11 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>   #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>>       g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>>   
>> -void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> -                             int fd)
>> +bool vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> +                             int fd, Error **errp)
>>   {
>>       g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> -    cpr_save_fd(fdname, nr, fd);
>> +    return cpr_save_fd(fdname, nr, fd, errp);
>>   }
>>   
>>   int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 428ab2f0698..ad13f2306f1 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>       }
>>   
>>       fd = event_notifier_get_fd(e);
>> -    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
>> +    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
>> +        event_notifier_cleanup(e);
>> +        return false;
>> +    }
>>       return true;
>>   }
>>   
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index ecabe0c747d..e57766e7e2b 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -60,7 +60,7 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>>   void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>>   void vfio_cpr_load_device(struct VFIODevice *vbasedev);
>>   
>> -int vfio_cpr_group_get_device_fd(int d, const char *name);
>> +int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp);
>>   
>>   bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
>>                                 struct VFIOGroup *group, int fd);
>> @@ -71,8 +71,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
>>   bool vfio_cpr_ram_discard_replay_populated(
>>       struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
>>   
>> -void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> -                             int nr, int fd);
>> +bool vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                             int nr, int fd, Error **errp);
>>   int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>>                               int nr);
>>   void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 56fb67e6b4d..3ad084d5bab 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -28,7 +28,7 @@ typedef struct CprState {
>>   
>>   extern CprState cpr_state;
>>   
>> -void cpr_save_fd(const char *name, int id, int fd);
>> +bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
>>   void cpr_delete_fd(const char *name, int id);
>>   int cpr_find_fd(const char *name, int id);
>>   void cpr_resave_fd(const char *name, int id, int fd);
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index bca43e9bf35..aeb9ad12392 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -82,10 +82,27 @@ static GHashTable *get_cpr_fds_hash(void)
>>       return cpr_fds_hash;
>>   }
>>   
>> +static CprFd *find_fd(const char *name, int id)
>> +{
>> +    CprFd key = {
>> +        .name = (char *)name,
>> +        .id = id,
>> +    };
>> +
>> +    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
>> +}
>> +
>>   static void cpr_fd_hash_insert(CprFd *elem)
>>   {
>> -    /* Use the same CprFd as key and value. */
>> -    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
>> +    GHashTable *hash = get_cpr_fds_hash();
>> +
>> +    /*
>> +     * The same CprFd is used as key and value, and the table owns the key.
>> +     * Inserting a duplicate would destroy the new element while keeping it
>> +     * as the value, so a duplicate key is a bug in the caller.
>> +     */
>> +    g_assert(!g_hash_table_contains(hash, elem));
>> +    g_hash_table_insert(hash, elem, elem);
>>   }
>>   
>>   static int cpr_fd_pre_save(void *opaque)
>> @@ -127,26 +144,24 @@ static int cpr_fd_post_load(void *opaque, int version_id)
>>       return 0;
>>   }
>>   
>> -void cpr_save_fd(const char *name, int id, int fd)
>> +bool cpr_save_fd(const char *name, int id, int fd, Error **errp)
>>   {
>> -    CprFd *elem = g_new0(CprFd, 1);
>> +    CprFd *elem;
>>   
>> +    if (find_fd(name, id)) {
>> +        error_setg(errp, "cpr fd '%s' id %d is already registered", name, id);
>> +        return false;
>> +    }
>> +
>> +    elem = g_new0(CprFd, 1);
>>       trace_cpr_save_fd(name, id, fd);
>>       elem->name = g_strdup(name);
>>       elem->namelen = strlen(name) + 1;
>>       elem->id = id;
>>       elem->fd = fd;
>>       cpr_fd_hash_insert(elem);
>> -}
>> -
>> -static CprFd *find_fd(const char *name, int id)
>> -{
>> -    CprFd key = {
>> -        .name = (char *)name,
>> -        .id = id,
>> -    };
>>   
>> -    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
>> +    return true;
>>   }
>>   
>>   void cpr_delete_fd(const char *name, int id)
>> @@ -176,7 +191,7 @@ void cpr_resave_fd(const char *name, int id, int fd)
>>       int old_fd = elem ? elem->fd : -1;
>>   
>>       if (old_fd < 0) {
>> -        cpr_save_fd(name, id, fd);
>> +        cpr_save_fd(name, id, fd, &error_abort);
>>       } else if (old_fd != fd) {
>>           error_report("internal error: cpr fd '%s' id %d value %d "
>>                        "already saved with a different value %d",
>> @@ -192,8 +207,9 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
>>   
>>       if (fd < 0) {
>>           fd = qemu_open(path, flags, errp);
>> -        if (fd >= 0) {
>> -            cpr_save_fd(name, id, fd);
>> +        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
>> +            close(fd);
>> +            fd = -1;
>>           }
>>       }
>>       return fd;
>> @@ -400,10 +416,11 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>           }
>>       } else {
>>           fd = monitor_fd_param(monitor_cur(), fdname, errp);
>> -        if (fd >= 0) {
>> -            cpr_save_fd(name, index, fd);
>> -        } else {
>> +        if (fd < 0) {
>>               error_prepend(errp, "Could not parse object fd %s:", fdname);
>> +        } else if (!cpr_save_fd(name, index, fd, errp)) {
>> +            close(fd);
>> +            fd = -1;
>>           }
>>       }
>>       return fd;
>> diff --git a/system/physmem.c b/system/physmem.c
>> index a4a6a4710c6..e94fe5d4a4a 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2445,8 +2445,9 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
>>           fd = qemu_shm_alloc(0, errp);
>>       }
>>   
>> -    if (fd >= 0) {
>> -        cpr_save_fd(name, 0, fd);
>> +    if (fd >= 0 && !cpr_save_fd(name, 0, fd, errp)) {
>> +        close(fd);
>> +        fd = -1;
> 
> May be return -1 directly ?

That'd leave 'reused' unassigned.  Currently that's not a problem as the
only caller never consumes the 'reused' flag until return value is
checked.  But I personally think the explicit assignment reads better,
so I'd leave it as-is IYDM.

Thanks,
Andrey
>>       }
>>       *reused = false;
>>       return fd;
>>
> 
> 
> Anyhow,
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 


