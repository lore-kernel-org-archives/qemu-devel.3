Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382A9CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVXML-00066D-31; Fri, 05 Jun 2026 12:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wVXMG-00065W-CD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:25:21 -0400
Received: from mail-francecentralazon11023130.outbound.protection.outlook.com
 ([40.107.162.130] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wVXME-0002xa-6W
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvx1f1qeuJ3HCv1BdRpEzS8M8FOClb4ce8Aeclr/PExdsMGFfco20j5lyILdiLAndZNPpIXgFvcFq8el/L/1MQ4COhft5iNW0z1/2LhxiA7JuD7yYfl8MFjijEXrKKnKeMGn4SOOQFHlBYz8rv3SO0xjyqeuBIjZaZtMVgSYxoPjGF+LXSpSBvymjU1iwwgLSNcw8GXYVWsXKVTJG37CcbnMfzNT7o0pFA2Jqu+ZT3pJ9s58t6l8Rl5f+9nsoHT4UMQVAIx7qvHBjBxBZS5VFSeZqkQOTHhgdb763VDVeOam9L1otvsOjqzTasJzJVVMWM78razC9BvqS79I0TypJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sIfaXEBQvASIMgDRqQB5QT7XHriL5vRMDhhdKEETtk=;
 b=dxerFgMRn3QQMrilT55xeaEIeWxEos9W4lUJeo6ZfH6SxS7gel9jJzw4PpF0EH9tc9PQVl5ywZ4fNP9GGy66DmAcNQ4LAGHVxoWwEyrVdmL+Ow6ZlCbkytNj97QJUdZ6CHDpFOeVCUrGT1FV7uhjJ0brBhRhTtTZGVe/1Gb0AFH1aL5vucUuozkE+VocsO7DgvqUU61nTq9RXpGG8e1+YSUAiqTNfk8m0JkDrmAOf1/pTB7COY1sGMnjlBjGsrFvs8OGglbhUbuh/V3YQ7THBkU331inz3LwIEajV+D0tS8bsyF8zJZ/OFwVjtOt8QhpXNNOBVvhzGFgwRM2/rny6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sIfaXEBQvASIMgDRqQB5QT7XHriL5vRMDhhdKEETtk=;
 b=btMUPHRtyqEWVmSsMZcoeNU1Po2y7Af8YWUoOMrXfrMgI8gTfZQIb0CbptqSoTIq9LzVXJ62FGyuVyehKlNbDVjLcDDvdjO/1KCwZLsRf2ceE+e5Q/D5LboIzow/5r3lm84lmMp1bakvWtp6zOryEr/PPfhFJ51YiR6p7LZ4SvSLh13mg8Qpij+nqRtXhHrA1v/OpLbPYKzJeNhStejcoXlaH7nNqhLKbibA+uK0SsoEDcartK0cnLaxxc5UxEZGieM6bMLDyD7fmEtA6AiYP5t1fJpNzZ5m9PM3v1+EGAiB+lid24KHCeeg9YpUAlrPhqxRz5TXAp0nC7l4RqojcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB10271.eurprd08.prod.outlook.com (2603:10a6:20b:629::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:20:12 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:20:12 +0000
Message-ID: <0258de00-a7d8-43e7-bbf8-ee2c200446d9@virtuozzo.com>
Date: Fri, 5 Jun 2026 18:20:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dump: enhance win_dump_available to report properly
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
 <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
 <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
 <CAJ+F1C+sYiFKRHKz7Zzqe+=K-_aOa6ZzT4=buo3jTV+f714SqA@mail.gmail.com>
 <9bef9acb-3153-4ef8-b3c6-6ff6303336f5@virtuozzo.com>
 <aiL07TJlvZM8-ZAk@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aiL07TJlvZM8-ZAk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB10271:EE_
X-MS-Office365-Filtering-Correlation-Id: 735177bf-f06c-43b5-1e00-08dec31e518a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: rXiCXrQowyWBZ7/ZXgnUYvwcvxwFSLTEba5c6dn5eIGuFpO5BmtxBj66KEsrXTk3dvq4gBugYNwbaMlzPfYtFHLpKxhoZZh4L9Fq6l1t2jZGYOVrVW71mLxtHjWXtRbDAxc+x8lt+2QEQ44Iz8VozwicCCYBhnWbZYoGGg4esQhogcFVPaupikQeO7ZeXHJ6lmo+54rMHXvGjVxXkbMuQl80GPdkOaVhiYMdTtF3GuDQ9XC02sHQ9VKn/rF2C2d0wcXLHMWXZ2/B+usY0g++ACXxPRauHR6jZAI92Ki54WXBMCiV2Okp14F6oI/L27eYEcOX48NYQ6DAkga6KEgJWXjFZUGvstBCP/Bz62q70LR0sTPgAuZ5Rz95WzOy4r3e9cIQ32PN2yYARCZFERexTaVYNyW2LAnKwg1znWN5dGQr3lYZlWCcikSDnC6gCm4YAi9A5cpCBcdgCZHR9uSwAbazU/LePmkbKOsik4/FrYo/ndyoeg08k1uRxIl4jdPOEK8Iqk8JZRKHa+OWsCYJI19dOmEvYc/3AlLassV8CzWmeZ4A+39cZQuV4dWlespXMvxD7+7GENlPgCmu2r2r+j9b3JamPSGkyR4gWp+7oAJc/6MQ1lEI++q/FiZcC51JYwewyYysKyRZ2B8JH/K4pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJNaHVGeUZZWWhvNWpaeE5xdDRGOHdKV1RyZ0FUams4c08rY1djVFZxRVk0?=
 =?utf-8?B?WkJIc09vblh6L3d2MG90WkpyVTJ3bUhsL0MrSG1GZXBRSEhTMlM2NjZTOUFr?=
 =?utf-8?B?RmM0cHIrYm1VSnFkOHV3VEVnQlRkT3NiSGwrR3lnZEN4akJFVzczVWJ5UXFq?=
 =?utf-8?B?Y1FmSFZMcVhvV2c4YWIyMEtSYkhWTzJNeWNLTGdRNnRMRmw0Z3Z5WFo4NjJI?=
 =?utf-8?B?elMzclh6SFBpSFZXSHBlMC9DcVBBdit2Snpub2tUQTdUblFsTThRVGt5VzNZ?=
 =?utf-8?B?STNhQlZha0pBQUhDZnFja0FrK0VvaXlSYTlhZCs5SC91WWVzRkNGL2hNZXlP?=
 =?utf-8?B?NGY1d2szb2RDTFhhMnZicCtIVzhuYzVjTEtBUEJaSFdpd3ZubGtWMGdYdXdU?=
 =?utf-8?B?NU5WWWlJM1lEVEN1aDZXa0tHNkZQR2JmQnJ4RjFhN3hMWFdYYkdqVk1QQXdR?=
 =?utf-8?B?dXN5RUxBM1ZseFY3b2FZUDZQQThJYTVWT3k2SVpueG9OWW9tZ2FsMzRnTUdF?=
 =?utf-8?B?NDZpTDY0VHV6bUFRcU1aU2NvRkc0OVd5RWRBSXVsMHFuWDlDWXQzNVdObkhB?=
 =?utf-8?B?VFdTdVA1bm80bllQd2VpUmhhMkZCc3BKbHNtMUtzbWkvMHdKanF6VTZkb1dy?=
 =?utf-8?B?WXBtUzA4blZJdmp1UlhSSjBkUDV2UUhaanVQYSthRnFPS2hhczVYdVhCOXBO?=
 =?utf-8?B?NXlDWm84aDZLeHJxa1lIdi9GV1pDMlVJUWZyYkhyVVBRS05EazFBcGpDUmpK?=
 =?utf-8?B?MnBUdVJHRmN5UjIxM1BiUVhFYjgzZ0lLdFBFYnJqcS84eHF0d3liMnFYK0dF?=
 =?utf-8?B?a3B2cDdqQjd3enUxUjBDL0J3RXM4M21MelBGY1hIREtFVTRZa0tlc0VkRVRa?=
 =?utf-8?B?L0NMY1ZpY1RrMEJLeTBuOC9OZ3FKWWlhZ3lGd3M0Rkx4TVJ3cFdRYmlIcTE5?=
 =?utf-8?B?LzhCcWI0R3YwRTZVMEI1ZG13dzgwM3R2R25MdXZXa1RKRm5QdUcwYUJYMlVx?=
 =?utf-8?B?ZU50VDN2QTdtbWRUS0JrR1dmZ1BhcWppNVJFWlIvWlhqTGIyTStiQVN1eXR0?=
 =?utf-8?B?VTc3QUJtSUppODlsUmFzRlFMekJwaC9GOEk4dDJadEFuMEJOV1dLWlZEUlJO?=
 =?utf-8?B?a0RaNVJQaE01bjAzTHdVcmpSU0ttYlRMeGoxRko3STZRdm4vNlYrNldYazVM?=
 =?utf-8?B?b2ZxVnVNTEJvOHhxWWlMVG5DSlV5RC9PVmcwSTBLYzB0cVFwVk9ObGduczBq?=
 =?utf-8?B?dkQzUGFLYVM5OU1uQ2U4eUZ5UmxTMkU0bHZPWkVsOW5ZY3V0dHZETHR3bkhD?=
 =?utf-8?B?dGtrTS91QkdublFFZjNGNHpreFQydVpJN2ZCWkxCbWVCa3F6ZTB3dHlqd2Z6?=
 =?utf-8?B?MFZWL25vSUZDR2RkK2JGdzRTRWJKem1iOGlaaktDYVlIRVhidkJ0WDhIZTJx?=
 =?utf-8?B?VjBFVWptQXp4cUR5bHZtbXJ6MXdzelBPaGtVdWFTaUk1YURQcnRzUWFvVVd5?=
 =?utf-8?B?ZlFkY3N5RzdEeHo3YVRWbjNsamVQcDJVRFNITlhGRVFBTFNFUXVCT1B3U2E0?=
 =?utf-8?B?c3FZeGxoYkNYdms1VmVUdG1ZYkFNL0lUN0QwTFhucDVWUkNOdEJBdUNTdU8z?=
 =?utf-8?B?clZNTmIyZ0ZEMXZBSmlwalkzQlVwY3BKNVFhZk16ZHZXeEZZcGZXUEVlR0t3?=
 =?utf-8?B?VWsvblNjWjNZaStoTDd5Z1d3SWs0QkhuaXdzek5iSlNOWkxIUzdHK0hGLzcv?=
 =?utf-8?B?djB3a29ON3U5NVVsVFA1dVBJay8vUFNzWmxiLzI3MTVBSjFiQlBmeFVpZVRS?=
 =?utf-8?B?VFJCMXNadlBSdFZaN1VNWS9Ubmh5NFNzMXU2aEgya3hpU2V3ZzlyNDlLKzdw?=
 =?utf-8?B?NjNPN1h2bjlnUDdURWJKSHllT052WlJ2cjlSNUVQT09ZVnJmd1E5VTJ4UDJM?=
 =?utf-8?B?M0FxT0t6K25OYmsxdGxzeW1LNG1VS1VQS0kram9HQXd1Z0tTWXIweElmdWl1?=
 =?utf-8?B?UjJNbHdRVXNCdlVBYW5lNWxub0JDdlVNSm9OeFFpRi9aTzBJaU54NFFuaDV0?=
 =?utf-8?B?eTdtVDJ1T0lOUXduQlJRazQrbTFxeGlzWENYN2dBbDh0Mm1GWFVxaUZPZ0hs?=
 =?utf-8?B?R3FLcThicWZLTDJ1cW9ReDJwczdqK0h0MFBSWnN6THNhbU1NRTMwd3k1b0Yr?=
 =?utf-8?B?UDA5MEJZckdYNEtQTzFlbm5tT2xhM3hzZVUrdmtYVlloZFp0bHBTMVdtaXV1?=
 =?utf-8?B?dUdCKzIzaHBFMlp6bGtwRFVEbGx2dDc5alNXWkE1UXN0YXBadVRybmdMdE5L?=
 =?utf-8?B?Q1B4amxOSUk3QjZTUWRwYjY2bCt0K2txaTAwWkNmWks4Y3J3Ti91ZjZUNWM5?=
 =?utf-8?Q?rtZZe1X+0dIQvgZNehV0NuAGGnjTNlzeflem+MF0ku8aj?=
X-MS-Exchange-AntiSpam-MessageData-1: psaUVTFzMVw8KA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735177bf-f06c-43b5-1e00-08dec31e518a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:20:11.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOxFJ27vmlZwPtTdBbnts3GkxQY96xGt3ree1UGJ2bhSeF0LaR4wo99cEZGFBbQL03iikAhWpWdr8bTrNot3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10271
Received-SPF: pass client-ip=40.107.162.130; envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 6/5/26 18:10, Daniel P. Berrangé wrote:
> On Thu, Jan 08, 2026 at 10:30:29AM +0100, Denis V. Lunev wrote:
>> On 1/8/26 09:11, Marc-André Lureau wrote:
>>> Hi Nikolai
>>>
>>> On Wed, Sep 24, 2025 at 12:30 PM Marc-André Lureau
>>> <marcandre.lureau@redhat.com> wrote:
>>>> Hi
>>>>
>>>> On Thu, Sep 11, 2025 at 4:37 PM Nikolai Barybin <nikolai.barybin@virtuozzo.com> wrote:
>>>>> QMP query-dump-guest-memory-capability reports win dump as available for
>>>>> any x86 VM, which is false.
>>>>>
>>>>> This patch implements proper query of vmcoreinfo and calculation of
>>>>> guest note size. Based on that we can surely report whether win dump
>>>>> available or not.
>>>>>
>>>>> To perform this I suggest to split dump_init() into dump_preinit() and
>>>>> dump_init_complete() to avoid exausting copypaste in
>>>>> win_dump_available().
>>>>>
>>>>> For further reference one may review this libvirt discussion:
>>>>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
>>>>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>>>>>
>>>>> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Have you looked at my review & updated the patches? thanks
>> I will send updated version next week after vacation. Nikolai has
>> left Virtuozzo.
>>
>> Thank you for the reminder and best regards,
> I don't recall seeing a followup v5 for this ? Were you still
> interested in progressing this work ?

Nikolay has left the team and that piece falls on me.
This is still in my list and I have motivation to
finish but need some breath.

I home to come back again soon.

Den

