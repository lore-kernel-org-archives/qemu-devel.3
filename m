Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B6CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckfk-0003js-4j; Thu, 25 Jun 2026 10:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wckfi-0003j9-0t
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:03:14 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wckff-0006Dn-Qe
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0gBk4+svmSiJWeAv878IvXvXR7fNy0HmnxP8yiR95oWCymyDfjRsv2ibHcXqj9qwrTY+z5cwZdCDc2/QZEtuORCtt7c78u1wHGgzGFlADtvS4zDruRWB5SQz0JDWXRD310gmnQ6nsfy48mUQWXKnQg67eDk0GnLx4gkIqirKVXS6NKwVyKff0a14fxUO4qphh0LryW3ZfWdbKe6xjKV9DukAUYyhdKZ5HjMGkwnncglW4ijcAgI1QOuAoQYXWGp8V/XWyHnwxhOUqtYNsS/ihqOWboNpokdA9HTDELa+mvoDrlK1dk+UPVA1zofTkzhQfH8eOGGRmoKTHkU+sSUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm3ifAQDCxfUxq6ZbOUPCjCqiS+7c2VgrkP5xMWnFwI=;
 b=rvePVF3uQLzpEpb/N2lGbsR1EbV6NhuxXqFV/90TdT85B3YJ7e7lcQfDBmZiKEHQHISPSqXtw15cRYTeYo8SJqvyX+1qqe6palSa4Hm3DROE1YmDyvhjmqQtx9PtqArMmDuIsmh5rZJMOAzIsqjIO5OZXXanNuE86YHk2KWykUjJgKavgMFxPvZQGdLpnFwpctcRUWfgKuOLm06maHIomLSd31QpAw2Cy0JDvtHr2XvcukDE6XmdJgovFiPsAQ71Tye+24iSdPtdtgFhu2W0iDS2GVpOVmI4mL/sJQ+Wn4nKLL0RDJZiByWJy7XdkPoAU/SuYd9k7KDHKFNuDduzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm3ifAQDCxfUxq6ZbOUPCjCqiS+7c2VgrkP5xMWnFwI=;
 b=nvrvW6q7MBOf4RMZ52AJHcHlLVbo0sWjBYqHTyRa2Dp5KDU77nUfJ8nhJrNZD/IvVUBZdgZ7aGPLHRyQFHbuUbK91amnHESyRhkgdcslW2tqNzUe1skF1rknbFyOeWXWcyNE0TfHpEc1/1fYa4+yKVU+Q+3WBriNTjwKlkfDq0qpW38ELIGplUTad5pDUARUhi5i/x6zXyufEDQBjRRE3cyQ7UHqJUdzTQ8q3qn6DGUoz/lY7rKkO1f7846nUne+3afe44DcHxK80LlH0eFWmMnWQNcUmjCWgq88ZHu7wpLaR43TJ1/Xv7WqIeW5a6nGzyqE5ETT0JS50prdzGf5lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRZPR08MB11220.eurprd08.prod.outlook.com
 (2603:10a6:d10:136::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 14:03:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 14:03:06 +0000
Message-ID: <57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com>
Date: Thu, 25 Jun 2026 17:03:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] migration/cpr: support vhost-vsock devices
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
 <0c78c4f9-6a83-4e1b-92c2-ca7af9f595ec@oracle.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <0c78c4f9-6a83-4e1b-92c2-ca7af9f595ec@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRZPR08MB11220:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ff2ab0-8d62-4b59-5b37-08ded2c27b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|4133799003|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ISIayfDnXkeMA6Gi+LqFeBEGDhwrJzz+op6rje2aUzzomHQvy9WpDEMtFiwDzo7GEr6mJmZZzhaMc8VzDGy3tyalcVsgoY0qgOs4FXl/00mJphrurPnHSyWisANRHts7QGAEk/4exoqGSgQZbaC5eY2JyMncRAuIqYqonvZcpAKAQE+KMC9EHRANOJqrc64xysGnLb7pEJhLEmb4/4OzMnVgMQBbOD9YKPJG8StlgjcgGxKA8MEgaLh/gneNG9ycPosIsGS69u3qdDpMU5V/orIEfWCCRV1vljGA4JEr4DdpSR6K7wpbYUpKdO0L3I7kXypxV+/8HNcQgJD5bD35GDp+FAp3EUTWaqzNrceZb8Sxzw17sM6bChuX2nFxscV9pNr9odDvE1l5x5KOQlJHRkvp9s5CaoJis3G/K356mevKotyDjE2sK+0eMbFOgtSzEGJHWGyKeVWsk+66eEE9M2IIvkFWiFT4lHiYM58u/wbYrAnEr6RTNCGf5o9+dB4Ph6hNVRa7ZbKs2RSAvbAjrLBXwWYJDZiqmwflqFF1859BB8tPguo9ZidEMSArsvOsLdYT+91flviso0YSC5+Q7YUo89lmWMIxYRwTCZjr8z/VBNn5yjhp0cBoYJ6XV01vj0xbyPefj74I8/aEOx87/2nuVIKI0Y8JsQQc+Bz9jrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4133799003)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUR5VmJFeEFqL3hGcGw4anROVE9TWGkwM1EvRFZOWHdLcG9zTnZXWldMQ1RQ?=
 =?utf-8?B?aGRiQkZ5MWV0b3YwRGwvbCtQSjdKY00zOXRHdnRxdm1UOXVTRjRXUURqdUtu?=
 =?utf-8?B?WWtDaGcwMGs0K3JkVmxFYjlUQXM3U2F4cHg2Ti9pUnFDR1RnVzlHK0FBeHps?=
 =?utf-8?B?b1Bpb0d2YW5vSitKRVJWcFJYOTJSSUFCZ2VWcTExRWFFcFVtQ0hxUENkeDRL?=
 =?utf-8?B?REpMRDRJdngzeTM1Qm5HV0pUMHZES2luRW45VVF0WG5yUWJwbEhVMk53bGFU?=
 =?utf-8?B?VmMvYjh4cExEWlpGTzZGT1dYSFJoSEVWckdGOUw2dW4wL0lSVmx5eXpHQUJk?=
 =?utf-8?B?akY2eTE1eC9GTStOUm9sWkU4eC9hNUhTMXFEN3lhYUNVUVNNaGdVN2pYYmNx?=
 =?utf-8?B?T0x4dU9zRm4zR3EvcTRIeFFvOFY0VVJRZld0SVJUVFB0M2pUdHpCUk5CampL?=
 =?utf-8?B?T2xsN2dHYmlscVZGZ0JYQ01WUjhGM0JaSFNjTE5CT0ZQMlhoOUhmU3JpaHJD?=
 =?utf-8?B?SWJGbTFvOXY3b3IrcXZ2dGRTOTJlV3ppTS9yMFZmSzU4L3JtR0o1azl5Y1ZN?=
 =?utf-8?B?VW82SnJ1bG9BUVpjSWRKSEtWRDcyL0ZjZG1ydVhwZk4ySkFFUUM4SUNIS0Uz?=
 =?utf-8?B?UDZVWjlsUDdmSE5CY01OamhoYzRFL0lTUEhDUkt4RUVJa1QvdUFCNHJjaHJ0?=
 =?utf-8?B?N1JvRzlBU21vQ2x1dlRJZ1d5eTlUZkVqMng3TEZRbnQyT2M0aXV5VWV0WWo3?=
 =?utf-8?B?S1ZxSU1ZNjJWWmh0N3FwT3JQTkV6N01LNGNmaVR4SDFTTXJ4TVN3VjVtSzdu?=
 =?utf-8?B?UzV6eFRKSFowZFdqZlRiS2k2ZFRGSzgwbkdmeGV2T2xNRGRJSHNyYjBDcG41?=
 =?utf-8?B?TXFKbTFSQnJOZW55eGI3c0Erc1lWV1FrcUc4WWVtVXBRYlQvVlJwcUl0NHIx?=
 =?utf-8?B?N0M4c2Fhb0p1ZDZYb2tiTCtMYXI2NVdvOFV3cHB6QmJxSk85RGtnaWFGdEVH?=
 =?utf-8?B?VGlHZnZBaHdTeTE2bHhxcTRWeEpRN2d1K2R2UUtIMERZdmx5bjViUzhPMHJl?=
 =?utf-8?B?bjZubVllOFhENXM5SzVZcDA3aDJKNnpsVmFQd01RdnBWNjkzaWk4bFhyZ29D?=
 =?utf-8?B?alJJSWswK2hwdUxKa29LdmhyV09sSkRCVXhZOHVIempHRzhFemcvRVQzSExU?=
 =?utf-8?B?N1MveDFjd1NSQmJBeVhEZGppL3drRHlYMXdOcllWYkg5U2h2bTc2Z1k3Q0FQ?=
 =?utf-8?B?Z0plOXRhc2VDSkJ6OGR5bjlCU0x1a0tlejdlVTIxNEtIMkx0U3VUZ2NRaE5T?=
 =?utf-8?B?L0VWMG1XKzZGT1RWbmdhU2p3OHM3cWQ0bzA0czhsdndwcFFVY2dMb2N1WW1D?=
 =?utf-8?B?Y1ZUdndVNnFFMWNuNllXR2pUbllhamFGT01kdmlsbjFBSm13cHhwM3FhWnUz?=
 =?utf-8?B?M3B0YWZzU1Zqb1VueHl6UTdkRStwcUdBUUowRkV2ZFdseTJhVEdvbExWMENy?=
 =?utf-8?B?aG8vSW1qcTJOT2dYZFpxT3V1dWRITU9QSmg5L2xwaHlNanZIOVdtSklYN0NN?=
 =?utf-8?B?KzZUeDdwZGhMUGVVb2lsSkpaZ1ViRDB0bDBHK09vU29pVjV2cWZaREZmUHZi?=
 =?utf-8?B?N0VTU3FIVGFkOThxUCtVa1RoUWNhUGFIYUtlVmtZT2U1YWFFdXFhdHNvU2pD?=
 =?utf-8?B?Q1BmOTl5a0x1dzN4NDl0VGVCRXczRlNyN2VDSVZXenNycTRFWlB1emhkMTE5?=
 =?utf-8?B?bCtSazVjNW5RWXluT2s3OVB3MjRES1ZiZ0hTZG5wV1FHenY0azNTNmtVOU9B?=
 =?utf-8?B?UlFsWWVpdGVxSVpncGphNTZwcFRiRjM5MTNUcFp5ZngzZUZ3NmhGWjIxUURx?=
 =?utf-8?B?SENpalpEdGlBSmQ1SDZsWG9TczE3LzlhK2c1L1RVQUovZXg3Uzd1ZVR2cmpU?=
 =?utf-8?B?NGVzRFFRUlNJU2VwMDkwTWpiUXRmZkZ4c0V5VEhSZWM3RzRXK3NFck96c0Ir?=
 =?utf-8?B?Mlk1eTZ5NjNlWmVueDg0Q0RnTlFjQkpLL3YyN1YwSllQMkpPZW9lbmVZalJo?=
 =?utf-8?B?VTdsbVdJaFJuVXZ0MG0vTXlCMEVVeDlaaFd5MzNST1NNdXNlb01XRDBRcTVQ?=
 =?utf-8?B?am5DTDI0R1pSS25CRU9yVFJGMUpSVGdJcFJvUEx3SlJCMXpvVEM5ZHRyanpP?=
 =?utf-8?B?QmV1am5yaWNpUmFENnhlV0lIZmRITzRucWtvaE5lZldYOU5aOEhyUXhaejB6?=
 =?utf-8?B?WFhPNjlTc2U0bTRjSUlhTk5tUTM3OGFaYndZUmQxS0JpTEQ2S3p0dm92THg4?=
 =?utf-8?B?VndIMEVzMEV6dURWamlKdnFBNFdUZFV3aHg3cldJNWtmak1QczJid3ZNOE9x?=
 =?utf-8?Q?SZonAkTb08tcoa7M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ff2ab0-8d62-4b59-5b37-08ded2c27b2c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:03:06.6986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thBFVMMV36ec19xeCyEbzvwergmKpH4BbB3PPebMaxsfmJeW2pgQChnTLHcrOQBBcSh1tESyFhrudiz+rFgBAeWJAMWacL1qIOZQcy1miEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11220
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 6/25/26 2:38 AM, Dongli Zhang wrote:
> I was trying to understand the error paths and why these calls need to move here
> and there. I think I now see where most of the complications come from :)
> 
> My understanding is that the current design relies *very heavily on
> vhost_cpr_notifier()* as the mechanism for releasing vhost ownership before the
> CPR fd handoff.  Since the target may receive the vhost fd from cpr_state_save()
> and call VHOST_SET_OWNER before the main migration thread is started,
> MIG_EVENT_SETUP is moved before cpr_state_save(). Once SETUP performs
> RESET_OWNER, migration_stop_vm() also has to move before SETUP. Otherwise the
> source VM could keep running after the vhost owner has been released.
> 
> This is reason to make the fix migration(cpr)-wide rather than
> vhost-vsock-local: it changes the SETUP/stop timing for all CPR notifiers, which
> may affect other devices such as VFIO.
> 
> How about to borrow the idea from VFIO? That said, transfer the fd early, but
> defer the ownership handoff until the source is stopped and the target is
> loading the final device state?
> 
> 1. cpr_state_save() transfers only the CPR fd state.
> 2. The target receives the fd in cpr_state_load().
> 3. During target realize, vhost-vsock restores the fd and initializes only the
> parts that do not require VHOST_SET_OWNER.
> 4. After the source VM is stopped, source vhost-vsock releases ownership from
> pre_save with VHOST_RESET_OWNER.
> 5. During target post_load, vhost-vsock completes the handoff with
> VHOST_SET_OWNER and the owner-dependent initialization.
> 
> Of course, the decision is left to the maintainers :)
> 
> Thank you very much!
> 
> Dongli Zhang
>

Hello Dongli,

I think the design you suggested might actually work.  And I especially
like the fact that we don't have to touch the generic migration code at
all, moving around the SETUP event and VM stop for our convenience, with
potential unwanted side effects.

One note though: we can get rid of the SETUP notifier callback, but
pre_save will now have a side effect (RESET_OWNER), so in case we
couldn't complete CPR migration, we'll have to rely on the FAILED event
to do the SET_OWNER and restore the source VM.

The bulk of the work will have to be done in the vhost-vsock
initialization part, i.e. separating the owner-independent and
owner-dependent initialization, but that shouldn't be a big deal.

I'll try implementing it and will send in v3 if it works.

Andrey

> On 2026-06-19 3:55 AM, Andrey Drobyshev wrote:
>> v1 -> v2:
>>
>> Adjustments on the issues pointed out by Dongli:
>>
>>   * Patch 1: avoid emitting SETUP event in resume (postcopy recovery) case;
>>   * Patch 2:
>>     - gate vm_resume() op by checking that block graph is activated already;
>>     - reword commit message;
>>     - adjust the comment.
>>
>> Also:
>>
>>   * Patch 4: use more generic proxy object qdev_get_parent_bus()->parent
>>     instead of container_of(struct VHostVSockPCI)
>>
>> v1: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com/__;!!ACWV5N9M2RV99hQ!LRVJYpDrzTKttLBQmMWczpaOwMB-ftzvLd8PYJRzKs_s5bvmx0kTjHl6pR0yA5Mb0Nv6YSoWkXTzmwMbLepUOy0bHXFGVenJ7Q$ 
>>
>> Andrey Drobyshev (5):
>>   migration: emit SETUP notification before CPR
>>   migration: stop VM earlier for CPR
>>   vhost: reset vhost devices for CPR
>>   vhost-vsock: preserve vhost FD during CPR
>>   vhost-vsock: don't reset connections during CPR
>>
>>  hw/virtio/vhost-kernel.c          |  6 ++
>>  hw/virtio/vhost-vsock.c           | 40 +++++++++++--
>>  hw/virtio/vhost.c                 | 33 +++++++++++
>>  include/hw/virtio/vhost-backend.h |  1 +
>>  include/hw/virtio/vhost.h         |  1 +
>>  migration/migration.c             | 98 ++++++++++++++++++++++++-------
>>  6 files changed, 152 insertions(+), 27 deletions(-)
>>
>> --
>> 2.47.1
>>
> 


