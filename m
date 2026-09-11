Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0341C88E5A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54J6-0006ft-KI; Fri, 11 Sep 2026 12:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x54Is-0006cw-9S
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:43 -0400
Received: from mail-westeuropeazon11020121.outbound.protection.outlook.com
 ([52.101.69.121] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x54Iq-00079b-42
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgWsS6drbvePnmQk/MsJLMtKOxpPk3TC4fXf7vKriT5o7Rh3cRJBFjWmd0TXDKvVtMAWrPRwyuFepLVQhBLx03jliVVPbn3rkRJX2+W/n9B698Ibu7TgjYbDiWtKxLUe1301QWTMEc0Fsi09+YyUy6469qCDflFilEc31ZCw6olG7PEt10FFO35bs1PpkPw/yXOlsJjGGgd1AQt2UChM4xVfiA9JHvmptpOzNskrmgmqM0epcKd7rW8/2qRKay1nIjaT3O5d5OXwFz8R30On+zpmzEkROmuy47Oq6e1T3T81Wv6JQJV1o2KfvIZYSJaOusilCDg1k4ZDXcINAYQSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXUej32JaKXhfWSN7IEpeqQeFRcGxbOHO6gLmT0xkxM=;
 b=EvRlB/7lGxVrLlqo6JlBs2qqsqoGmmPABv07OO43rK9wx0v91zverZFAiPKzorwwcCCbmfBvozsxRom3Ee8J2BzKO/v7MPnN+VGD0OgILRSC5mmOIc4UI+ewy+nGh45PjsDMNsHP5mQCnWoRZtOXrDdhweNTMCLPaO4DOogP3DM0xBLOI6ef7pIF6sqPCEgtbRBJU4iHz380fGlEIsGkoKKafihXWnL2Vfin2tv56XphNFJJGkj6V3jp86Qluwh1UDcRT7sgh9WN2sRKKdLw3gKnBKfF901Hiz9UyjQJmugoP1CJkz+MTfkN21MMZ+umssMar+iLTNNwqBzPjr2XqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXUej32JaKXhfWSN7IEpeqQeFRcGxbOHO6gLmT0xkxM=;
 b=JBIE8448Hgrd+F3MZ6uUJ9I/5kuDI+Fb3QioY0MPYZ5UxC5D87lQRHTwFEjqkOC5Nps/gMZFxlZk/oEfYF/Ndne3iry4ZueQE6jjikNhhvYoBrQo/qoVBWXWN1xGRjJ4wsNMdl6QtTKdWOdk/z4lmzX6oGKfFxy68jf9ikJ3Mk5nLHQAb1gs7dZU+LT9RdoTvYK4oT6aYYD5WNPRNVIXMQ/hXf11mT81a3Lbo5RIHsHi23LyxvYhXAkXaJnW8Sz11S+TvMGuMu7DKecaZqY4ROVIjmAdkUBrp5fyyECsTcNellvxujlky6FCOYhVv1A/Ss1NozFo8OXZxj7GZ0lt5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB11254.eurprd08.prod.outlook.com
 (2603:10a6:150:2f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 16:35:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 16:35:33 +0000
Message-ID: <1d7c8444-a566-48ae-8c62-4a5e1adf3528@virtuozzo.com>
Date: Fri, 11 Sep 2026 19:35:31 +0300
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
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqOu-wrcPrqSpHl0@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: 198d5053-b459-47a1-4956-08df1022b31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4MToaLP6HpTMhneHSF582ier4Zb0yiJ54gOcWAmv7aldJHiz/grRTvmxplVbImdfy/c4MrQr9Z7/9exUqTYHJ9UsXELY0Xfu4LXMyTqBJDB5ZrkQKQCImrTGWrqFPlUv/mpFOS2q71GEN6LeAiqXGwTIgghA3a1RbO7N/0qLuqeIFPsZIa/ajmEVgB/mGtckOAUDbKotqcVy40QGrItZzwwHjx2giCsBPoKZOibvPiDzgMO+gUsMefr80Si6CQF9EswQI9B8XTPFXZUPLVTJS13a2h5I6CZyaX1ECqmHqeigtsS41gkgX4omdxW6UxFzmYlrg88ctNbN3yQU8td2nJnDzLEMSe2o0Nk7birR2o06BZoPXqU5wuE8WfY3alz6vC75/32K1quF1D8XC46Kvfpr5XA++X0GQk6idw3ghQcMeR44QXNlhMRWbZ0gzcmahT9Rah13onCmNGQoaHo4qzhzTT70X/VA0/M+haaqdYewpgZ6qXarbYbqkkNmHvDsNbqT2hngGt3Sz6r/eSoTQ2O0aQfd7n6E2WKPUTwK1Uf5Ljngr4J7N7hyA/GxYQpl7hVUSp0lDm7P9TfPWEkn7L5KHZuUTAYm5fGPQutyZjSD7NKyPLF9elLOA58mC7mOQzr2qL5I6Dwy47s/EZ5w/ptySdntfgiOrRsbW0L8EMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHI1QVM3c1F0Tkt0YzlyUTBGRTYvUEd5bEg4V2QrOHliVm5JTXd0WFoybGtO?=
 =?utf-8?B?V2RGME5FRTVENWdvWDNwRzRGS09ZWHEzV0JubWN1eDh3MTRXcWdoQnFYMU9t?=
 =?utf-8?B?Q0Zvc0NOWWJvb2daWUMydGxEbjBXcWtVSCsrZWtUWHlvbEVoeit1Q2w5SWhp?=
 =?utf-8?B?Q1kvdEVsNTZXTWhvNktxOFJ3UjJTTTdhUHJyL1FKYUZkekdXeVNyeW5XYUQ3?=
 =?utf-8?B?c0ZQcmpRdzExTUgybHZIc3NsN25kUHJFY2pMMDhadllWQkNybXIwSzNHQ2M3?=
 =?utf-8?B?MVZTMnp2bjNialZIemFrZUQ0TmF5d3I5UjZYZUZpemkwbU85U1l1RWFtRnFa?=
 =?utf-8?B?bEhJQnpiS09GWmluZmwxVmR4d3pOQndRNy9kM0pkSzFpOE5NK01zb0ZUcFdV?=
 =?utf-8?B?VVQ0bGN4SDVCTTdJNUsrR0ZwSlRxVytrNFdBTE9WM2EwMTB6QkVORFBpemlu?=
 =?utf-8?B?MGM1VXBmYWdhaS9lY0Z2dGlmZWQ5NmhqWFR2cEZVLzBVSUlLN2c1S0pnYWJD?=
 =?utf-8?B?ajFlazFqZjdjRG9QU1hsbkhTUWsvRHNpY1pVcm1Ed2lPMWZOWGF5dEZ5Q2Vh?=
 =?utf-8?B?dmxzYTJXWVhJUmlRQ3lHckRFeitDQmNDdFpNM253WUUvcTh2L0tJTFdrUm5p?=
 =?utf-8?B?MkFEcklZS3lVMHVrK3k1WnV6cENMbWVqQjhjVXd0bEtyNXFtS0JFczZBN1FW?=
 =?utf-8?B?Vk84cGViV1RMMFpqeHBBMnpGUHhpOFYxSmE4R0hmbkc1Z3cyeFZodG9pb2ph?=
 =?utf-8?B?Rnd6VXVsRmdjVTRIbmg1bGsvRTlQL3BiKzM1Q3lXcmw5UzVSSnExWTU5ZUhv?=
 =?utf-8?B?cXgvTjh5NThiMWRrZGNzNE8ySkMyeFdQN3BHdmJpMzFUc0hhSGFhOElSS2Nx?=
 =?utf-8?B?WlRzcjl2ZGdrQnpob2c4TWx5b2IwTVc1VVlEQWRYdFZ2SncxZDJYUkxKV3pt?=
 =?utf-8?B?cVlqcGNYZHppMHhWZ0dnZ25iclMwOVlRVGlyOTdsTnFTOHVCbVM1c082MEhX?=
 =?utf-8?B?ODVpNWhkQ0RuY2RVdWRtckVwVGl3eHkxc04zSVk4VDNETWdpSk5xTDNDSmg1?=
 =?utf-8?B?cDlRM3ErVlo3cWxNdVdISE5kN0dNbGRwTWNsRjJqR3hOYTVXZFhKcjh3Z0pv?=
 =?utf-8?B?NllIOGw2UnhyMlNtdDlrR0lzTnRXVlFsTlVZNW14Q0RZUlZUL1dGZWM0ZVdj?=
 =?utf-8?B?S28vazNFZ0o3MC95cW05emVoNXU4OGg1SzZHOU1HRlpxNjlJOXc0OWpnS2ts?=
 =?utf-8?B?RVY0Qi9RNjQzUEs4NEFNWkVSQmpNcUl1ZkhEV0I2M3ZYVmMva2p4OEJxUXox?=
 =?utf-8?B?UWN0TkdBZkR6WFk2bjRoZFlqZjY5bWl1eTduUExkUWJHcmI0SExrZ2U0V2NJ?=
 =?utf-8?B?YzVLWTZHTFFrK3hSVkRNSVlORCsxaE05NXpnU240dGJYQk1vWGMxQ280KzJL?=
 =?utf-8?B?ek0vb29pUVRqZW41UXVNOUxXbDNIanNSVkpSd1dRdGhIR2N0dkpzU2pZMjlo?=
 =?utf-8?B?aFBLUFFrdXF4WEhjVnVML09VMERGZVcyTXdOR2poSXZUcDZDSW5YVmNTV2JC?=
 =?utf-8?B?OFloNUxRMmxPTGVTMHlQdkNTbUdsMDNnaGhLdDE1VlZXTUFKSmNBc1lIMExG?=
 =?utf-8?B?Z0I2bXRBUTRGaWdVQTdPY2xXbEQyYjU1K1kxUk1DOFczdHlYZ2VlUmRiU2dS?=
 =?utf-8?B?YU5xVS9MUk1sTXMzeFQzdWRSSDZOdUZlMmsyMktqL1k1eE5FNVNxQ0hFS0xo?=
 =?utf-8?B?V1dXQm04YnRTVlh2bzBVR1NUcnhGZ0g4RGl6RWFlYytnejUrTzIxRlNyYStw?=
 =?utf-8?B?c2phQk1BK1pNMUhFdU02YldhUjVkUzRVcGdOZSt6clo0Yld6T05qSE9RVEp4?=
 =?utf-8?B?Q3RTSVlTRHVoaTZKekNabjdLWWVjZ0FkbStzMnlYSGRxNjEwU05Lc3pnTUp2?=
 =?utf-8?B?KzdBNS9Xb3ZUYVdXakFJelhncGF0VVhrbzNLSWhUZ1h0VUJlWlRhZVQzVTQw?=
 =?utf-8?B?d3lkUzcreWN5OTRqSXF0dFZ1TkJNaWVWU1BzZVJLUklFRDNqWEI0QWs4dnIv?=
 =?utf-8?B?K3UzRWkybE1GWkFOaGNqVGlYNUdNM25yRFNJa0FZOERwVmtPWktGN3VleTBT?=
 =?utf-8?B?QVFWSzVDZzJOT05HRERINXBaRlZZd1NDeXdqL01yNUVjaWRtNmFELy9CbG8y?=
 =?utf-8?B?WXVjSU01STBzZ0pvM0YwclowRGVmbDJocWVaZ2E2bkU1dllGdjIvSzUrTnFN?=
 =?utf-8?B?VDlwbEM2Z0ltZUVCeFQweitHdjFCRG4xYzBWYklHRW11TWRzYXlxay9MSzBW?=
 =?utf-8?B?em1rN0VhalV0dzRQcmY3ZSt2djIzQlh5VUlrbWRudE5aM3hOeWlnUlMydk5w?=
 =?utf-8?Q?bg3zVHEF84i9Jor4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198d5053-b459-47a1-4956-08df1022b31e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:35:33.1231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGQRuSY93Iu/5wyin5pTi1+HqL9YuwXaV74GixFba82jPq1PyX/m3BJ/LYdG6hSKIKDqv+ugOz76JC9KUFloKSpOAQwsg2nnhqOpc5MNaDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11254
Received-SPF: pass client-ip=52.101.69.121;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 9/11/26 10:37 AM, Stefano Garzarella wrote:
> On Wed, Sep 09, 2026 at 07:59:55PM +0300, Andrey Drobyshev wrote:
>> On 9/7/26 5:55 PM, Stefano Garzarella wrote:
>>> On Thu, Aug 20, 2026 at 02:39:50PM +0300, Andrey Drobyshev wrote:
>>>> During CPR (checkpoint-restore) migration the guest keeps running on the
>>>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>>>> we should reuse the FD from the source.  The FD is saved in the CPR
>>>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>>>> target via cpr_find_fd().
>>>>
>>>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
>>>
>>> mm, are we sure the device ID is unique?
>>>
>>> I just tried this whitout receiving any error:
>>> qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=vsock0 \
>>>      -object memory-backend-memfd,id=vsock0,size=512M \
>>>      -device vhost-vsock-pci,id=vsock0,guest-cid=3
>>>
>>> Stefano
>> You're right, that seems to be the a real issue.  In fact there's even a
>> UAF bug IIUC, stemming from the fact that we: 1) provide key destroy
>> function when creating the CPR hash table; 2) use same CprFd for both
>> key and value.
>>
>> That means that when we have several devices supporting CPR with
>> repeating IDs, we do:
>>
>>  g_hash_table_insert(table, fd1, fd1);    // table has fd1 -> fd1
>>  g_hash_table_insert(table, fd2, fd2);    // table has fd1 -> fd2
>>
>> Here fd1 and fd2 have same hash of course. According to GLib docs [1],
>> value is renewed in this case, but the new key is destroyed and the old
>> one is used.  As a result, fd2 is freed.
>>
>> And, mind you, this all happens long before actual CPR, cause the
>> devices with CPR support usually call cpr_save_fd() somewhere in
>> .realize().  Thus we get memory corruption right at boot time, plus
>> subsequent CPR will likely crash.
>>
>> In these circumstances I'd personally prefer just asserting on repeating
>> key somewhere in cpr_fd_hash_insert().  The only downside is that it'll
>> crash when booting 2 CPR supporting devices having identical IDs, even
>> if the user isn't going to perform CPR.  I'd say it's acceptable, what
>> do you think?
> 
> I'd prefer an error if possible.
> 
> That said, can we append a prefix to the key (e.g. `vhost-vsock`)?
> In this way we reduce the chance to have a conflict. Of course the user 
> can still assign `vhost-vsock-something` to the memory backend and 
> `something` to the vhost-vsock device, but yeah xD
> 
> Thanks,
> Stefano
>

If you mean erroring out directly at startup whenever we encounter a
duplicate CPR key, with a clear error message instead of abort/crash - I
agree that it's a better solution.  That'll likely require changing the
CPR FD saving API, but shouldn't be too intrusive.  As for the prefix -
once we forbid duplicate keys entirely, there's no need for it.

Andrey

