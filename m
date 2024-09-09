Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9189BECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 11:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sncmC-0005Gz-Kz; Mon, 09 Sep 2024 07:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sncly-0004e3-Ik
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:41:35 -0400
Received: from mail-mw2nam10on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62b]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1snclq-0001uG-Ng
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:41:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRSWMMaE+CH+mgCWSAvTMnJqWA0cXMvOH12CEgodLE6/7LxSPIvh3GujtWqp77Vc30XHCe/asOtNfBpEnJY4g0G81W/i1abqzFjXQstAx4Wkzt+l4sNAO5Py0FC6h8EzmK3QyvyhtDYIl0ZN8shkgF7cV/giumvgr2KhozdXYls1j7CT5Lz3k1KDC3OJa9pVVQpd7KO7OUT+gB0QVIi9DeSDDa3+e76IjudB+AgXPBXPdqkaKpDHFm7uejq+0fIytAcHZsqt+EqN7wspPvpZMIiKtNqlcdDBeW6n9IO27JKrdl2f1nS0ZTXd+dHC40JePyatEfQRnZecEwmDR+cnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk6I7SmZ8u1Y4dj6LXXKrx5Er0Icz0DVRdVGGBGjOhY=;
 b=a8X6e7OdswJ4FosKR6by/71gSENqqkNcFGj8jz8vbJQJwEq4qU+aGZ9tH5ETzyHlq4DsBvPIkt7P3lqzWjcjBCoCtLdKFNx52QAYmrIg65CxLBBCYRaod1RzqOC9N7gCPDACNFhvqsbLRqV40KeCTA2bjcpD1zBqRXRMx3rFhOfOUc6zaoWDkXSnDUzC/QVY7VLshcK+eQFnMeJgWlnIZVeExnYkxj1PHj8pmhHWDMtOorYdVfFbryskISsEbg/ynaR6c05HrZun4sGRaG/t4hjr2uJJnBIL5kKl/t/b474Wl/SFADXCu4Lk5mmK2A5e+HBDQ98noV8UBYAJ9ca1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk6I7SmZ8u1Y4dj6LXXKrx5Er0Icz0DVRdVGGBGjOhY=;
 b=dsHs6BXD6tGsTk0LJe5hCvSaxt5uNuLLFjnUWN0uVPdVMiZcTv2XrVgbaOMpLq64X/Vw+M5N5jUhnVzt5vlia+7MvSd+7ugEPTlfU/ARAuy1I8uR1uw8iTRsw0UI15lW5gngrVde6PlgwLFvkvPm1l6lrGGSOBkJprx2225E8GEevGCDTGza+0TrjnOOuXRg10sIXIFkMP0atI4zRYz8/Ou0H8qHByWcNs7i7eJ4a58jzqNZQETF5mvAZk2eZ1bwMYAxSaZhSkemRghGPczpDWFo1lp/Jl9CRA9RQudZQR6bnpqUIctW5mMAAL7A2YARMcS3bB/e4XFRMdvRSk74Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 11:41:17 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 11:41:16 +0000
Message-ID: <d801c59f-60da-4d42-ae0f-c70d99c45990@nvidia.com>
Date: Mon, 9 Sep 2024 14:41:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1429fc59079d99ca035b31303892d807868dc6c0.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <1429fc59079d99ca035b31303892d807868dc6c0.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc79d1f-64fa-4e9c-c1af-08dcd0c45093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG9QZEJaQjdqbVRaNnBrcytYMTFYZWUwTDBzNjQ2a1hCUXVyNXNjQldBQWNi?=
 =?utf-8?B?MW1wdTBTOFBEbFFUTlRFMDFJdWJNRW8yN0VNeG41ak5sWjZML2FxVnQveS82?=
 =?utf-8?B?WGZ1RWtZRytBRmtMbEpKb1RraGRhVE1NTzdEWUpTS3FlaFlwUStCMnIzSVhk?=
 =?utf-8?B?YjE3VHRnQjBOdUt3ZnFIRTc4Qk95aW1iaEQ5dkVjbkl2ZzVXUWFxYmhJNnNv?=
 =?utf-8?B?VzkrUnh2MG1TUTQwWjV1R0NqQTd0NlJ1ay92U2NHSDFIbm93aFg3TytzYzN0?=
 =?utf-8?B?Z213OHZHMlVaT0ZPNG9RZDRKWUpUNmxMWlExQW4rQWwrQkR4NWI0VFFEem96?=
 =?utf-8?B?VUVzb0NvbkJlS01KQUtwMlZlaWdnNFhtVld0UnRJNkVzc2NhQ1Iwc0o1RDR1?=
 =?utf-8?B?NkR2NVpxSlltaFBNZjF3U3JlQ1RjV3pEa3hwVGlGc0tadjVHRUtralMvMU9v?=
 =?utf-8?B?TENUY0dIOG1jeld4dmxNK3pQZjRiQXpWQXNldzNVemlVL01PSkVMaHl4ejQz?=
 =?utf-8?B?WndpQUF6NGpyN2J3SlF0VVk4MWxJOUNnV2lYMXQ0dVhaWk0wQng1bDFwKzhN?=
 =?utf-8?B?TVRkYWQ0bHVwNFdYTEprVTZreGh4T0czQXdjanZ6clMrcFlJanRlZUdqTjVZ?=
 =?utf-8?B?N3pxL3R6R1g1WEtlM2VPWlZkZVdEdlE1bUh6b3dWYW5HM283aHVMUnJGSm93?=
 =?utf-8?B?NVdnYnZMWjZtM0NkaWlXTUdvVGZXb0p2Y1hSVGZtVWFUSkdncXNCTTBIdnlK?=
 =?utf-8?B?TWpjZXRuTXRTdlAyNVF6NmtXZWh6SXRvTjMxSXZ0MkxmcDZqM2xTN1dWeVZO?=
 =?utf-8?B?SG9ldW80RUI1djl4UzJ1M0dQR3ZEaldINEx6NllkR0lEZ0ZzUEV3ZjFkTnZh?=
 =?utf-8?B?NUluVnBadXZMYjlmQnNMVVUxaU1iNDlGNU55M2RxUW9pWnFaQ1dQM2ROblZU?=
 =?utf-8?B?Q2NvemdRaEVDalBEbDVhVjJjVkV2S2hKVExLZHJVUENDMitFUENqbGIvNEFL?=
 =?utf-8?B?M0lhY3JEYUEzcHJUYlJwTlBPaS9aVWNnQ2p2TzQ1azRwWWIyUnd4M1JqVzJL?=
 =?utf-8?B?ZHZhOFBEbkRGWUFLQUgrUFd6ckhuVm5yZGk0WFc4dDJGQ1E0dkE3TXJMMnh5?=
 =?utf-8?B?UWFVWlJpYk9HTS9xWDFERHZqd0VRMEpaWmtOalJnNEhJUU9DZTJ0enBWQ2lV?=
 =?utf-8?B?d201MHVmMWRFS0Nqc0FhWkliWHh4NW00MjNDWUZ3Z2FXQkptcjVOVnIvRmpW?=
 =?utf-8?B?MkZQcUpEeFE3Y0FPaEQ2ZGNsUXZMSW5SZkJySmdOOUM1ZGpaanBjUUlrWE00?=
 =?utf-8?B?aWQ1WGdNbFp3MHVqd1hIODh3Q3FJcWJhVm5QZDhqTU54dEFjUVNmd1NrU05Z?=
 =?utf-8?B?WGxGYW4raDhnUTVON0xhMkJVV0hCV1phUW1nVVVBeXFNbUgxYUtORzNGRnYx?=
 =?utf-8?B?RDJqeU9EOEtEanpvR1JJTS91eXE3elZKSnorT0pmVDV0cURrRmZNbWtXV0lY?=
 =?utf-8?B?cm56ejkxa3gyOVZ1YTZGNkZUbjZKL1lDMURnbk1tOE1iWmgzMWQyam1OYU1j?=
 =?utf-8?B?cmoxOWljQUxnT1hjR2V0enl4bzJWOFo0UVl4dkVnclpOendFK1NNdlpROE96?=
 =?utf-8?B?OHhNQ3dGWjFWbTdFNXpZT01QSmM3SEtaaitDZ3hPWElPZEdNQWluc0Nwc1lY?=
 =?utf-8?B?QkQ4c09oZ2psR3owS0ZmcUZLaVh4OVhzRjl0cFdpK3U0ZmZEM29VMHBJWDFr?=
 =?utf-8?B?UHEyM0dYS2UwNHVkazh0eXcvakhJTyt1VWNuL3dTdGtOQ05GS0d2SWJEdklL?=
 =?utf-8?B?ZTV1RGpyMnJEcGZuVkM5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdiaDdOemw5QVFBeE91cUt3Yk5ob3JVM2dYYzVMVHZQNmxMeDI3UkZkbzNi?=
 =?utf-8?B?TUtneTNRSGMyL1RyZWRnNHZOVUYwc1ZoQlM5ZFNkdE94QW1nd1N1NU9NcDNs?=
 =?utf-8?B?OUV6cDJ3QWM4bHNQZFVobHJRVzNEOTdUZjR4RHhvSTcwT055eHYrTDFBbGJM?=
 =?utf-8?B?YnRWOGw2MTFwRnJ1VDA1WEwzaFQ3Z3h2U0hoemtHaTdxZStwYlFBQ0JSK1lV?=
 =?utf-8?B?ZjFCU2RXcC8xYWxHbEhaekZiVjRNN2VFUVpRNjNmT2ViYWhxeS9SSEx4bElh?=
 =?utf-8?B?R0JQL2NTdEpHVmlsOC9zRjVWZVV1QmVuVFNYMVNWNjFuT3VRTk0wbW1zYkZK?=
 =?utf-8?B?YlFLQTNvV2JwbjlublZ2V3Z0cG51YmQyWTFnZXczMFJHenZELzkwaTZGUkFX?=
 =?utf-8?B?SjJ6YmttMlRBVG1aaDl0ZnNMdW81ejFsbGZXa0xVREY0Y0dVY2EycFQ3UXll?=
 =?utf-8?B?UGV3cmliY0pDSloyN0V6RHJRanZIcGNlMzJURlROVG5NNnI1QkV5R1ZOSmlT?=
 =?utf-8?B?UUt1dmlaRzE2VlN6OEswT0xTU3QrT2RZSlFsZWFTMkFnTmVsdU1QaGZpa20w?=
 =?utf-8?B?ZUowTHVvblRrTVpKR2xSVmV4Vm1ub3JDT0ZqckxOVXAzNUVMeE45N2FwWjRq?=
 =?utf-8?B?M25IVVVVRnJuVm9SNElmTjQrcVpKVmhNeG12R2d4Q0o1OWlybUpLWVJKQ2cv?=
 =?utf-8?B?cjd1WjE4emZ4NWZYanYzRXU1d3JkR3J3b2FzdFkwTGUxVVdhWHJCL2p1ZUNT?=
 =?utf-8?B?WFFkNTBCU054NFJ5UlhGQkhUOXVwT3YySFd6a0pZSUg1cnc4V0xRaVBOdHN3?=
 =?utf-8?B?QmcyMnJoRjB3N00xOHJMdG9YZ01uL1R5OGRXR1BUT2RVSDNTbkw1eXVpeFZR?=
 =?utf-8?B?b0pZSmwxRXZHVjRSN0kvOFJkRGNkdjRHZlBVem5UQXNEL01qQ0dWZEhKRHl5?=
 =?utf-8?B?MDd1T3NIaUZqYlEyUWh1TU1nVDlSYXJTRTJSMFlua1l4TW5KNVNyZnlhZWhI?=
 =?utf-8?B?TU1XU3gvTDRKbDkybEJML2M2dDlKWmRjcVdLcnArVEl3U2dWNFk3b3gvenJU?=
 =?utf-8?B?a2MxQlRsQTdYWlFkNVJtbXlxdk52RklPU0QzQnc0c1BHSE8wMHpWOGs5Vmpy?=
 =?utf-8?B?eStPMXN4WWxYMllrWFR6d2lJajk0RVBYZUdzY1MzVGVmTWR3Wk9CTE93TGpx?=
 =?utf-8?B?QjRDUWlVdUp4Tktva2JveFUxSGVLYkhBVWJzb0k3VmtXcnJ6VDlFeHlFUGZ6?=
 =?utf-8?B?UHNERHVsV3hXMnUxM011T1ZPZUM3QituMTBjSGY3TnBOSDlBTzBhcHQ2dUtJ?=
 =?utf-8?B?L0ZSL0xIVyt4S2kxVzg0K0JaRGNuQ2w1Z2UycjlFRHVZaUgvMktHd1lKc2Qy?=
 =?utf-8?B?N2p0NUNXbjNUQTVzbllnWUJnZmRaRVFCSlVIRkZzc3JtaDVUWmFtLzFRVnpw?=
 =?utf-8?B?dFY2MzhPTFJBM0hwUW4vaXAzU0NKay9PMmxMQXlCbGhzNE1rdDNKUUVyZXAv?=
 =?utf-8?B?T0FDd1BsSmdsb1hDYVZZc1JlWTBKbGI3MUw3ZnlWYXJ1eUs0UGZKSUFkQXZC?=
 =?utf-8?B?M3dUc0hNN1p2TmJBVGVNS2Y1WUcrQjVpQWV5YnVDRDZ5U0RITjNMMzhFY0Ex?=
 =?utf-8?B?Y2c3Wis1NnFBL05PUWtJbUQ2T3h1SDBCZDNwNG44NjBKdzZxL3Q1V2hDbzdF?=
 =?utf-8?B?bUpVN0V2cGloNGVsVEFWeG5hNzVRYUdJQURGc0VUYWYrREpTRmljZS90TUtV?=
 =?utf-8?B?a2Q1MmNyNEVoNVExRXhZUFUrVkhITkY0enA0TmdudXpmb2N0RDl3cmxOVVht?=
 =?utf-8?B?YVhlcFBQOWlUbWQ5UjRLUmRjb2Y0SjM1bG1qZ0drR2JubXNmczR6NGx1OGlr?=
 =?utf-8?B?MVlLZHNHbmUrZGVEV2dMZ29xTWo3NFZrV2JSS3JOUGI2UFZlYnhBdmJaeXNI?=
 =?utf-8?B?K3luenRYaWxMS2tyT2V5RHpEVEtrczVubWFicFhrWUR3Vy9KejVIRkNScVlH?=
 =?utf-8?B?c2pES0IvOCtpaE8zL0owalMzMXcvdUlGRm1vUWVRaCt2NXFES25iN2pIUzBn?=
 =?utf-8?B?Vi8xbVhabk9zaFZYK0hIVVhERm5QUlV1OWdoSjg5MjZmTkpqOU91cVh4K0Vm?=
 =?utf-8?Q?lVIDR4vb41BBsZiMMPDQmrpwu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc79d1f-64fa-4e9c-c1af-08dcd0c45093
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:41:16.7705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr56aWsiH09dviWtFqMciFcod9aV7B+4VqcyIgnhIIMGJFk9muMPlJ87IK76VGdztrTRPdbIxxwhoI4bgSuMXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
Received-SPF: softfail client-ip=2a01:111:f403:2412::62b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Implement the multifd device state transfer via additional per-device
> thread inside save_live_complete_precopy_thread handler.
>
> Switch between doing the data transfer in the new handler and doing it
> in the old save_state handler depending on the
> x-migration-multifd-transfer device property value.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 169 ++++++++++++++++++++++++++++++++++
>   hw/vfio/trace-events          |   2 +
>   include/hw/vfio/vfio-common.h |   1 +
>   3 files changed, 172 insertions(+)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 57c1542528dc..67996aa2df8b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -655,6 +655,16 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
>
> +    /* Make a copy of this setting at the start in case it is changed mid-migration */
> +    migration->multifd_transfer = vbasedev->migration_multifd_transfer;

Should VFIO multifd be controlled by main migration multifd capability, 
and let the per VFIO device migration_multifd_transfer property be 
immutable and enabled by default?
Then we would have a single point of configuration (and an extra one per 
VFIO device just to disable for backward compatibility).
Unless there are other benefits to have this property configurable?

> +
> +    if (migration->multifd_transfer && !migration_has_device_state_support()) {
> +        error_setg(errp,
> +                   "%s: Multifd device transfer requested but unsupported in the current config",
> +                   vbasedev->name);
> +        return -EINVAL;
> +    }
> +
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> @@ -835,10 +845,20 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>       int ret;
>       Error *local_err = NULL;
>
> +    if (migration->multifd_transfer) {
> +        /*
> +         * Emit dummy NOP data, vfio_save_complete_precopy_thread()
> +         * does the actual transfer.
> +         */
> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);

There are three places where we send this dummy end of state, maybe 
worth extracting it to a helper? I.e., vfio_send_end_of_state() and then 
document there the rationale.

> +        return 0;
> +    }
> +
>       trace_vfio_save_complete_precopy_started(vbasedev->name);
>
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -864,12 +884,159 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       return ret;
>   }
>
> +static int vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
> +                                                                char *idstr,
> +                                                                uint32_t instance_id,
> +                                                                uint32_t idx)
> +{
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f = NULL;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    size_t packet_len;
> +
> +    bioc = qio_channel_buffer_new(0);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
> +
> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
> +
> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
> +    if (ret) {
> +        return ret;

Need to close f in this case.

> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        goto ret_close_file;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        ret = -1;

goto ret_close_file?

> +    }
> +
> +    bytes_transferred += packet_len;

bytes_transferred is a global variable. Now that we access it from 
multiple threads it should be protected.
Note that now the VFIO device data is reported also in multifd stats (if 
I am not mistaken), is this the behavior we want? Maybe we should 
enhance multifd stats to distinguish between RAM data and device data?

> +
> +ret_close_file:

Rename to "out" as we only have one exit point?

> +    g_clear_pointer(&f, qemu_fclose);

f is a local variable, wouldn't qemu_fclose(f) be enough here?

> +    return ret;
> +}
> +
> +static int vfio_save_complete_precopy_thread(char *idstr,
> +                                             uint32_t instance_id,
> +                                             bool *abort_flag,
> +                                             void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!migration->multifd_transfer) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> +        return 0;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_started(vbasedev->name,
> +                                                    idstr, instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                   VFIO_DEVICE_STATE_STOP, NULL);
> +    if (ret) {
> +        goto ret_finish;
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (qatomic_read(abort_flag)) {
> +            ret = -ECANCELED;
> +            goto ret_finish;
> +        }
> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            if (errno != ENOMSG) {
> +                ret = -errno;
> +                goto ret_finish;
> +            }
> +
> +            /*
> +             * Pre-copy emptied all the device state for now. For more information,
> +             * please refer to the Linux kernel VFIO uAPI.
> +             */
> +            data_size = 0;

According to VFIO uAPI, ENOMSG can only be returned in the PRE_COPY 
device states.
Here we are in STOP_COPY, so we can drop the ENOMSG handling.

Thanks.

> +        }
> +
> +        if (data_size == 0)
> +            break;
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(idstr, instance_id,
> +                                        (char *)packet, packet_size)) {
> +            ret = -1;
> +            goto ret_finish;
> +        }
> +
> +        bytes_transferred += packet_size;
> +    }
> +
> +    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
> +                                                               instance_id,
> +                                                               idx);
> +
> +ret_finish:
> +    trace_vfio_save_complete_precopy_thread_finished(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
> +static int vfio_save_complete_precopy_begin(QEMUFile *f,
> +                                            char *idstr, uint32_t instance_id,
> +                                            void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!migration->multifd_transfer) {
> +        /* Emit dummy NOP data */
> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +        return 0;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE);
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    return qemu_fflush(f);
> +}
> +
>   static void vfio_save_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       Error *local_err = NULL;
>       int ret;
>
> +    if (migration->multifd_transfer) {
> +        /* Emit dummy NOP data */
> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -1119,7 +1286,9 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .state_pending_exact = vfio_state_pending_exact,
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
> +    .save_live_complete_precopy_begin = vfio_save_complete_precopy_begin,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_complete_precopy_thread = vfio_save_complete_precopy_thread,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 9d2519a28a7e..b1d9c9d5f2e1 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -167,6 +167,8 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_complete_precopy_started(const char *name) " (%s)"
> +vfio_save_complete_precopy_thread_started(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
> +vfio_save_complete_precopy_thread_finished(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>   vfio_save_iterate_started(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fe05acb9a5d1..4578a0ca6a5c 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -72,6 +72,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
>       bool initial_data_sent;
>
>       bool save_iterate_run;

