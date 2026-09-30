Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E20CA5FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq1B-0000m1-6f; Wed, 30 Sep 2026 04:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBq17-0000km-JI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:50:21 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBq15-0002d9-TT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlNfo8j8I0EM+t92cFNcKMe+4uJXjQDgVz2qo4/Rphrs03MA/efakuQ3X6oOGJDNFl8W9C2PIg0RxPhL0nsLZoO0NTHaeZn5nhUKCkdCfLnSFWgp182Yl4EudhvJRVcnbquHyYTTMKJEEUt7E+t2/nySodcB/FPDIcuNmT06SOyT6iflJkM5wMWfAbENo3InfacBmUk98aCpvQ3LeuZ5BhJghht8ZiyXpsObqMey978Xf6DUyLAMPSJbcPOd6mx3vo+M9qL8ApVZgvcJljB1vsU0OOA7CCyKqKrPVYOZskBxOYDBZ99VYY9soUo5IGmkl0s9ToqPt8mOVNXkYwPcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsNr/6vcIn+vq67dy4S8PS3Z+64Wm5lCKavcXXo77Bo=;
 b=lKVnAMjqNZSLjVzYArJ8lnXIc+tnwGbaJTeOSlFVG9Gz2CS3/kQCzPvTvrxv8LaUp8C4BYMgROqNjAQE8iylUt7ly9oXufRp2fthUy8OsyujGHs+/UnzBvZvYdBKgWOTN2e74NSNwNSAENG1o4Htd0ArPPJ2hTVBGV652HNGx7jkVvZzmxP3+G2LUfEk0F6UI24w+cl1PuaeVueOLw/tKeVabBdxMLUmIeZ2plHumEj9P1sted4qOUXa+ryciadRXkqVFQiU6HryoZqrNWbDIWgUkYq6QjG74WmS5IRUn58JYxT4dtVzRchlu3LmxHsHY2iKIz9s94jbzAKoisMXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsNr/6vcIn+vq67dy4S8PS3Z+64Wm5lCKavcXXo77Bo=;
 b=m+StJnnKGJ/pC/jigtovZyGObuNVb5v3me7lgS1O2tGpJN7hRWlm2VtvXqRiIPEKCIeqV0Gw2QYaCAPxKBYQeFBZPBsadnQ7HHJwmnBop8FCAQBX/NhFttc3cxNumyEZkRkmaPyT+3H51rNOarzILUNFpmOwqwtjTKXgUa+R4Kcs50r8KEDFJ6U2JyxugOCiTvwVB+W7KpMhedccA7eOQezq+FqBYDZRqhYhNoCfzEwLZ7yD1E8QX5Aqz9NFoa2n283YtHMlzEt37xz20llR1XrBly9iKABvbaFL82bR2VhXi9k8rRER3IYAVVltPKQQT+Q2Waqz11fnUIGg9rQbGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM9PR08MB6164.eurprd08.prod.outlook.com
 (2603:10a6:20b:287::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:50:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 08:50:16 +0000
Message-ID: <9ac6a2ef-d293-4043-a05d-d95208346f3d@virtuozzo.com>
Date: Wed, 30 Sep 2026 11:50:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/17] migration: forbid snapshots under Xen
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu
 <peterx@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, clg@redhat.com, den@openvz.org,
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, farosas@suse.de,
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com,
 Paul Durrant <paul@xen.org>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
 <arwCADGhCZenoYke@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <b7d2302dfa4b48480e45423ffaceb93ce2239e7b.camel@infradead.org>
 <arwOl9OvOlXJTtwS@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <arwQBnGBbCgv8srv@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f8554a62-4be5-4ea4-8697-3b0c69f64849@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <f8554a62-4be5-4ea4-8697-3b0c69f64849@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM9PR08MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: dc12b4ae-2ec8-46a5-094c-08df1ecfd916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|10067099003|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: FwYdWlewggITL3B7hQyhqY32zSn6Je+l0lmWGplWLkccQEv/oN8XYu6Q8G+J5cq9i/4f6SaFK0aDxEVXjgJtbYnoB6GiDbekONf+uJGJQjNmwpgQNqEerB9AbgRe+q/6Z5/X8ybdRdz/YXR17PE++ZGRsCIy3lEmF8t/AYk9y7A5vqIhPLc8HvtpVHKQjm4ldqS7QiXQk8L7JCDmbX8OYYwNGA57YGq5X/S/WuQzh2+xOFYNDK47xganusbf07WXR3E88H9m6HKnSjbRLPrmgXeGympsKjG8759gvfgVZBOxK92v3EENTky17n6XmzAGTxpTfX78S+hqELGUosycRHZ4zQdVpYuuqqaiX0DeSZfEuwDaht+ArHkFzKAAFs/MdiVLpTj4poaAzmsEEFe928rhol+gnZELQfMcFYPsJwCHhKsjVMy3qrISlxl1ZYZMSKCznzMj2lX8JueNTMUYg7LVKFOnjtLFHeRcSYBBMwtyZN4SIL5swa91mrN9b++wbp7CzQRQkSwSP7TOBL4WltzGt24boo1hsQv2rkXi1ue+r8vY/QaO6T/dAIls8T/ZPXc2AFoMqt/+Xq1hoBt43JqaRrVQx0ouRP+Gn10r7rXq38fgjxTtCqGDrKhFvPF3zuSQHTj+SfODX6lYfRPYnmJx03+P1OwJnFkFKJb3gbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVAzM0hIcEo0UzZ6SlZNVHZlQmtRMUduOS90bjdTSitGazJwaTVUSm9hYmp5?=
 =?utf-8?B?MjB6RlArSmUvWi9EMm5jQ1p0cmpYNkZGOTV1OXhzTFl0dDZPK0lYQ3pkbWcy?=
 =?utf-8?B?aDF3bWhlV0dNVFFpMFdQTHZEbS9MS1A3em9FYm00M3dkS2JrN1phenREMXdZ?=
 =?utf-8?B?cElCQzlKVVprL1pWcjA3VW5nbkFBeEdET3RWMkRvZEZ3TmhQdmF2RkJmL0FX?=
 =?utf-8?B?bW04VzhvbHJOeHNxZFlwRFJCK1FOQUtkQmxoRExKQ3BQaDBuNjBRSWNsOUFZ?=
 =?utf-8?B?SXZ6b2JydzRiYmlRNFBwSWlxazU5cUZZUjdiN2pMc0JEa0hTR0xFVTZ0djZu?=
 =?utf-8?B?aHdtK0NZdGdtZUdFV3JvYjRqUy81eFBvc0Y2VVEvaWI1bm1Ub2xWTm9wMXZQ?=
 =?utf-8?B?ZmdkdFRNVnNQcDRWY3drRnRhZ0J0R0t3TVErMTlMNlNYcDRrSzhsM2c1WXcx?=
 =?utf-8?B?dzM1UDA0UWlJdEsvRnBOTG9aRG40Nk1FZFdJS2toK240VE9ZSDhMZkVVSWYw?=
 =?utf-8?B?NTNSK2NPMnhydS9kS3hESUZWOXBycGFxZFdpaUIzbWFLcS81UlpjNU0wRUtU?=
 =?utf-8?B?eHdpY0Fka3NRbkFVZzIwbjhPV1FNKzlxZ0RwK1MxTWE1bGpVaUtMZUJocUhJ?=
 =?utf-8?B?SUlPSk5Za1pnRFFUbk40Mkd1azlOQVEyOW1MUFhJUlBJVzR3d0QvaVlsUFdT?=
 =?utf-8?B?M1BGU1Ribi9FVEx1Qm9FL0piSmNYZUh2ZkVyeWZ1WlBHa3NJckFDalhlK2xQ?=
 =?utf-8?B?YTloNWx4NlphRzdyNFpFODZuMnJ1MEc4WCtRcmZkSzllWUpXR1ZHTjQva3Q5?=
 =?utf-8?B?TVlFb2EwSHY0cWxCcDJEaUFtN2pkMytTV3NFdFY5dDZBY1VFVFJyR00vNHNx?=
 =?utf-8?B?Q1BSL2ZSQlg5R1RheC9iakw3U1Z5MkV6SWFGa20xSGhodTdxZGpWN3loNWVG?=
 =?utf-8?B?d3pLTnJhYm1EK3dYeHhkQzMxUWQyVUxNWHp0TDRleWllVnFwaVJCSlY4dDlB?=
 =?utf-8?B?RGk5NVR2QkRtd25Pb0dQWkNzQnI0NGxmNDZZSlpKdk9VMVIyNEJRVEZYNkNq?=
 =?utf-8?B?ay92Sm9Lc29BUmVxU0NXdFVEenFsL1dxVzVHNlRjNVZVTGpRTktNK0drbEk0?=
 =?utf-8?B?NENvdzRIK3ZGaWE4ZmVvSnlUaklYem9rZFY2UmQ3S29oelhNVHBxRHFXZWZH?=
 =?utf-8?B?VDFFMW1URjBVRmJqTHg4aW9qN05CRGxFZVh3eHRMNm5TUkJrdCtHVWF2Q2kx?=
 =?utf-8?B?ZmZtdWl1UlplU2ZtNUpEOFJ5SXdHY0xCUmhrU0hEd1lJRTZqMWN5NmZBSExs?=
 =?utf-8?B?ZEZxbVFoOGs1eUJDNnhPTWRnNzJ4eHpxMFBOb0FDQXJhcFZDbTI1L2dtaWhY?=
 =?utf-8?B?L0tlL3hVcVhQbGxSbFFVRHZ4VmFOdkUrdlJ5Q1FzaVVoSU5ocGpiRmplUXVH?=
 =?utf-8?B?QjB0aFBWQWxtWHFsK3o4T0g5NE9lUERjdnZSLzVMdEZyL2ttekExcG1URWZD?=
 =?utf-8?B?eUNWWGhQK2swN0VIeVh6MEJKeDlQQTA2c0lQL2lZRldrQWw0UDIwZFc5N2N4?=
 =?utf-8?B?SEFyNmtaWExranlEeDNLQWd0UnBZSFZGUllFck5RR0VjZUFHQzhTaldnUkU3?=
 =?utf-8?B?VmZlUHJWcUdnRTZqUFdOaFZ0R0NFeUJkV1VtY3UvYysrcTExUHBpTGVHNk5a?=
 =?utf-8?B?Z3ZwZHB1Mm9LdCswZzIyRUJqU1VETWFMRDJwZVE0eU5teDJ3V01VQVlHQWRC?=
 =?utf-8?B?VEVIZ1FicWRyUW5iY2JpNHdhbVdlTGxoWDY1TW5YSFhBNmpKOFhueFNFeXVm?=
 =?utf-8?B?WTF5VVREN1RCb1hiRjBtaFJEdWlQcGF6REpad1Q2UEt3bnpZV0l2bGdZS0h5?=
 =?utf-8?B?VGs4ZCtZTU4wYVJ2dHEwRlloZTZEdkN5aHplRDZ2V09aNFlCNUFMNm13ZDZC?=
 =?utf-8?B?RTBySXEvTWIraWxtMEEzR2UrWUtOd3ZsTzlJUzdNT1BaZlBuWXVCNFZ6U0ZI?=
 =?utf-8?B?STVHUisyT2pZR0ZQVk1zZkxMZW9tNGk4UXVtQ2dwYTdxSmhWSjdNNnVpUi9U?=
 =?utf-8?B?bWgxL1h2Vy9VVVMyUjF4V3B3SVFIYWxwdlAxVXQ4Q2h4aHFUekJjMXg4Z3dm?=
 =?utf-8?B?Sk5OdzBVL3orTUhreTV3d0dLck9kTGVvYm45dVBtOWxqb3RoNHFocG4xVml0?=
 =?utf-8?B?WTBSektpSXRGaStIRWh0MXJUMFNlM0FtbTdRZkZuczBzZGE5TWxab2JZaFdz?=
 =?utf-8?B?Tzdub09JeTZMQ2lhWEdvM3huN1RhRUgvQVBNRWNSQVZQNWFET2RMcXcwVUYv?=
 =?utf-8?B?WjVCQWJJakxxSUVHdTlBL2RCa0paWHptSFlnVlllYWdlWHo2bnczcENXbGhJ?=
 =?utf-8?Q?IJq6OAbnEgBTg6k8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc12b4ae-2ec8-46a5-094c-08df1ecfd916
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:50:16.0379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TuR/yAgF8HVaVY79+d6wCK76EhsGe2cQvNq0oV0kN+wem0DUo5L8e67tnjVUaV1xBu2Z+AFX+QUuxzkCUvXGp0CwOV7o1UTR665nnWpv9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6164
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

On 9/30/26 9:06 AM, Akihiko Odaki wrote:
> On 2026/09/30 4:22, Peter Xu wrote:
>> On Tue, Sep 29, 2026 at 03:16:39PM -0400, Peter Xu wrote:
>>> On Tue, Sep 29, 2026 at 07:34:50PM +0100, David Woodhouse wrote:
>>>> On Tue, 2026-09-29 at 14:22 -0400, Peter Xu wrote:
>>>>> On Tue, Sep 29, 2026 at 08:23:23PM +0300, Andrey Drobyshev wrote:
>>>>>> The snapshot RAM-saving path does not support Xen's memory mappings.
>>>>>> Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
>>>>>> same way they are refused for CPR migration modes.
>>>>>>
>>>>>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>>
>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>>
>>>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>>>> Cc: Paul Durrant <paul@xen.org>
>>>>
>>>> Hm, but surely if QEMU is running as a device model for a Xen domain,
>>>> all it should be saving and restoring is that device model. It's then
>>>> up to Xen and its toolstack to migrate the domain and its memory.
>>>>
>>>> We've had guest-transparent live migration working on Xen, as well as
>>>> in-place update of QEMU on the same host. Surely all of those require
>>>> save/load support?
>>>
>>> Looks like I was wise copying more people..
>>>
>>> I knew Xen had qmp_xen_save_devices_state(), I was thinking that is the
>>> save support wiring together with Xen's facilities.
>>>
>>> I confess I never know what is the load support, and I was taking it for
>>> granted RAM was managed elsewhere, so load perhaps the same.
>>>
>>> So I suppose this is still a question to the author, or maybe Akihiko?
>>
>> Ok, I just noticed xen also has @xen-load-devices-state, so maybe this is
>> the answer. I suppose Xen should be using those, rather than the default
>> savevm/loadvm.
>>
>> Note, that what this patch changes (migrate_can_snapshot()) only affects
>> savevm/loadvm command.
> That aligns with my understanding as well, so:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> Regards,
> Akihiko Odaki


I don't know much about Xen, but AFAICT Xen is indeed using
qmp_xen_{save,load}_devices_state for its needs, and therefore they
should not normally reach any patch calling migrate_can_snapshot().  We
just make it explicit by adding this guard.  So I agree with Peter and
Akihiko here.

Let me know if this requires changes after all.

Thanks,
Andrey

