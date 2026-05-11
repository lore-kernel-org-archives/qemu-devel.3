Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCC0CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMV5l-0001C6-Su; Mon, 11 May 2026 14:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wMV5h-0001AV-Kc; Mon, 11 May 2026 14:10:53 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wMV5f-0006hq-QZ; Mon, 11 May 2026 14:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaRnxmNNKU5k8aKoWsRrZX3yJSeHv7ec3QgQt89IaE6ZJ+K9MeC0lHJ0Pqq7CAdVDp1S7sNSOgKWuDMuqEb140GdpRFGvGfq7nUQGm38Pm2T/aqEXJY5TZH/ZfTucqLd0LVUv2G45+cEsZDlNmSyg8NpeXSqJ6LzB0fuQXYgF/l5+dQQcSK/Avb+ZX/cNbEPGQWd4FbPr5Oka61n9cRzgUKLApLpnQKLtv5pj7Ew9j34LbcIDnMMQ75cC+QISB32uJkTh82mgTawOtYD5fW462jb08m7XgpaIvkHpxzMVWUVFDMQ6+FH/tEOmITtOsPbDXNx/Cwykp1qcnDtx2HNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn+Ldnu0aElTBkw8QMbvPMnLxAQWHPA45bSVzPQEbPg=;
 b=Mr4263n3f1GLqDszaCf2iU8hlXuJSu/5FHe0Gv4Wx9Y1JtpRvJYZct4tvjmk1oqEejRxOPaGHVqmsx7Mty33LjRx3p+NteReYxrDcaoSl9xv8LRldT3t+7FZbzZ6SPcFPiKH4oEUQvm5bCGYpELmHZQDJtivhE/1vuhA9vsa4WWUbOvbI+KRXBaGIFvlNB0cnIxtdHfrycj+wPBPgYqgRNxRqQEJmaL3OcEt77kEoYaUrje9tbrDzAAc0BB78VEmbPr2MryKm05VRBJpdPpQzwI68FUR3FvXj0SqPT5fMq1m8h9XbF+ptajIpRUnG4aByQ67gNyWmQXXdO1MLjMpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn+Ldnu0aElTBkw8QMbvPMnLxAQWHPA45bSVzPQEbPg=;
 b=RnfP0TQY4cW6GO/JwyQkrUvJW3Z0O7It6xvO1tjCsA73584CDxI8G0KT5Ngjp/s7be+oRg5qT07WWzScROu7QVbN1gmEKhuf6+cUiDei+v+AjwVyC8d7Sa6tGOjYIfAvnOkivN05ZkJuSCEf7YY/qqxKA5Ipzwzk6TOdvUS7ddDf4YUZt98JGswPNQaLWBwoL+izD1MYfHNcHaxS6yClVp58xQcTJC6iqVjw9pci0JhXm+mIqiA1386wAggt+2C97cs7e05e4LWhZA1IxQCnfW3e9ougq2veEzsf/nNVey+na5alaXVESmom6i5MUE1+7eEDyaxvbn7aCLB+ubFPIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:10:45 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::3885:dd8c:612c:a746]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::3885:dd8c:612c:a746%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:10:45 +0000
Message-ID: <d5190676-11e7-40e8-ab12-da69aa751301@nvidia.com>
Date: Mon, 11 May 2026 13:10:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
References: <20260508183717.193630-1-tdave@nvidia.com>
 <20260511050459-mutt-send-email-mst@kernel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260511050459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 107c14db-e382-4881-d9a3-08deaf889ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Rfj+rFp/QQrmZjR7ZkBpnBBn4IxwN+f7L7EazzxQ661+SakPOxvRwrK6v/2r5Gv7V+ePh4wzm6UTfrLWUOmktW2xYHP6mEL9UCYZEU671U/eF0hoEeYvrniUiyTUJYQ29bBDE+yTCzpMiia8IbguSSwYdXqG7vMHJP4xXgNg3qcin95GVfaEH1Ba5suRO5oC3hji6B3PHlk9hBU87/yN5BYCxhPhwOme4cFKts5LPCT3oQzNZtfhVIWkC1HJ8FGmvFxyOC15p2QXfWK6WFLlxxgKcmLaDo9g9RSq+1vr/N3+YpD6nxAu+ftBCzE0mR+0WUmoeNTmDlVELufCe7Agocf+emsvpM/NV4SPc7Eb/XPn2OzA0xlmkYqwurZdT+zJfmI8/2yETNKLH2+5chUOcvnGoFBt3jYXJB/FGibm0d9GTyV9z6Dmptya+6f3Io8Jq6B7fakAq0TrLUA6yq4XFLq4GXGQnqvs/OVwAUAHSKKXKnDVNx94YCGC5lu5oCjbTHQvl0M5i8fAwoJswjUv5JolZOBLgcKnXAz0BaBvBKAMYWKVG/zBs8F9TpsT2mOsrwLixHN6yqMSXCh7/WZ3LsiBCOoNsJDLzQgHMsBE3NwOuF1qxjyOqLa89EBDET4AG6AjyX5J9XKBA4/CEUBJxU50KLFjync16z3UmOy+yMgjv9tkqIpFjXA7Iur/b+KG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4186.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXprOUh1eGZYNnA3WW0zQkJEK2Ztak5vZXF1Wi9vaHlmUkZnbVN3MU01M3Vr?=
 =?utf-8?B?U3FZZFZ6MWg5VkQ5eU9RMWFYMittRDk0M3c4ZnViWmdmcTIyODA3VmlJZ2ND?=
 =?utf-8?B?YkhqRWcvejdITTMreXM4TlNrNytaMHovNk9FcVNuSEtXMVRzZjQ3NDFGM1lt?=
 =?utf-8?B?UjcreUFMbnR4bE4rMEV0ancxaTZ0b2ZxSXQwS2owc2xKQXE0b2pMQUVBWFF5?=
 =?utf-8?B?VzloVVE3MVN3cjk5cmVMc0xQZ2hMYUxxSC9Ta3Yybnk5b21lbGRjZlZwTy8w?=
 =?utf-8?B?NzdkNUEvMWc3MUYxSGZpSGtaTGdPRVpZWHRWYUpBOXdDaERpRC9pS09LVWlE?=
 =?utf-8?B?TWpzcGloVzJHVnhvZElnelZPVVo2YUt0Y0JESGxRbGx2SGF6WnJiK25SNXJG?=
 =?utf-8?B?NTVCbm5LaHZoVWtMaCtPR1poTWlsellkSDJHQnUweFNMOEJFNnZ6ODQ5TTdv?=
 =?utf-8?B?ZFhTRkdnUXMrWXpiMDVjR25tVEsydmcyVGM3Vm53dkt0NlRuT1RCUEpwYTgx?=
 =?utf-8?B?NG8zOC9xUmhGZWVCWE9zZGVqYmpoNjBwN1ZYTjVReCtzSUM3U1Z3em0vQW5u?=
 =?utf-8?B?bkJ6VHU0WGRsR1VrZVZzbGEwa1pSbC9qckRINlJNRDRxYWxkMkJVeUpEc0hZ?=
 =?utf-8?B?WnRESGJPRkpGc3JhSVVuQmRRejhyZjg1RWtGbW9ieXh0cmsrUlpZZmkzcmxC?=
 =?utf-8?B?TUtXNU5acnB5UEhmeFlrWGJJV1BES1VKWWlXWFBEUHZYU1M3YWZoUWxEd1dq?=
 =?utf-8?B?VkRlY3BpRW9NSDRYSEN5bHluam1ianBhdEVJTGMveTVud1ZwWFIvbkY5RkR1?=
 =?utf-8?B?TEJmbDFkZEM3Y2Evd2hPbUt5cWVwNjM5OFZFd0FTNU5kRUU0aXUyc0RWZU85?=
 =?utf-8?B?UzRubklJQTQ4MVZuNTQ4VHhkb1JNZVFaSlFUS3BjUGRBcGYyWXNnN0t6Um53?=
 =?utf-8?B?SVBJZmZ4bUVkcHBGK0plY1hGT2pscForVkRkTU9LbWlpbkU3ekhYT1NXdGpX?=
 =?utf-8?B?MWFUbkt5QldBQk8xSUJ4bGpJL2ZhbnRJVWVvSzJscWpiL2djbXdPVU92UDFo?=
 =?utf-8?B?NWtFNVlPeU9zV20zb3ZubjBYOTZacmhhdXBSOGVZdnNRUjlkWVp6WTkxM2lj?=
 =?utf-8?B?RncxYytBQzVSV0ZqemUzTTl1ekZTSWR1eUNJeGxVeHRybmJBNzQwcWpQMEpC?=
 =?utf-8?B?NkRWR0VIem4zZ1FtREk5RkxUYjc2OXlmelZzSU51MStKT1NwWjZiUllmZ2Ns?=
 =?utf-8?B?YkFhdTU3K09oWFJIZU5EVmI5YndmR3BMQkVSZytMUCt1TFRLRGR5S1JLTENm?=
 =?utf-8?B?ZVo0VENNODYrbHF3THYyUXgxNUVXRVVKQkRrdVpwVVIzMWZBaFplZTVKSkdP?=
 =?utf-8?B?Ynh2N1FZWEszSHphd1F3UXJqcGtmWHppZXJtQmpmRWtjRE9KdVNNZkxmdDFS?=
 =?utf-8?B?MEt0L3RiS3Nua21xYTVQMmNMWVZIV3k0aEh3NTBlbm96ZVJkN1JMOE1GQ1lU?=
 =?utf-8?B?SmZZWnY2TDJ1cERxTHl5bHBxd3BEM3JVa056RjdTWVQ0dyt0T3BKbmUwZUNN?=
 =?utf-8?B?SmdsV0d1T0NrRjJMeVlWOEdTS2dDL1lIMDZkdk9ySGNPT2NqRXFUNVhPczZP?=
 =?utf-8?B?YnF4SFdpaWlncGsxdDgreTZEMnQzYVIyTTk2eklEY2l5aUZCcUNJWWVmUy9s?=
 =?utf-8?B?VXN2OGdzR29OcDBCRGNZQzBVYjVkdFN0MHYweDg2eHVSazZFaXcrSU9Bb2ZN?=
 =?utf-8?B?U041bXNvM2JHbXRUTmhmMnpMSTJYMHRzTmk3ZkFXZ3JtaWNLTzE1YTJyQUI1?=
 =?utf-8?B?VXZibnRsZGVkZDJTSTNrRnVmdjFiZy9YT2hpeFBjaTQvT25qb2ExckJML1No?=
 =?utf-8?B?bXdTUUlZTkpwUGRJWENFMnMyQlJXNk90WWVFczM1Q0gxRTU5UnJ4S0JOVUth?=
 =?utf-8?B?TWUzSldpTGh0K2ZJeFErbTlXZjJNSEZZOU82Njg0WWMvRlRDOHJtTGUrQzlt?=
 =?utf-8?B?dnBaM0Nja3NCVXlpR0N6WklnSjFxbG5qRkdRSWVTL0lmNzJDMURUUkw5cUxC?=
 =?utf-8?B?L3owZ1hlSVROMnRtdFd4RHd6cW05aHFpeTE1RHFqanJMbXpMd1pxUlhUS3V1?=
 =?utf-8?B?bzF5YmJGVFZTL0tIams2V21WYVdBV1V2NXhhM0V3b1dNeitBQ1c3NlhsMXFv?=
 =?utf-8?B?ZFdCQm5DMDMxK3NoanBGMHhqaCthbXhVdnB1dGdVdlZwQjlTT010UC9tOFdu?=
 =?utf-8?B?bzlRaXliZ01PVmdPRzlha1U5OVZ6aXZ3ZkswSFltU282KzZUOXRCV0NpOWQy?=
 =?utf-8?Q?lj7NYeZdUhsp+LPf8G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107c14db-e382-4881-d9a3-08deaf889ed3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 18:10:45.0911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja197E8M0dH1NcFdJ1dlx8rXI1fHyZpNKJ5uFvqGwgU5jOWx0VJDEgMKWYKyxERgDqPbedWlS7TUrAhbj7OnOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=tdave@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 5/11/2026 4:09 AM, Michael S. Tsirkin wrote:
> On Fri, May 08, 2026 at 01:37:09PM -0500, Tushar Dave wrote:
>> This RFC introduces a mechanism to specify Guest Physical Addresses
>> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
>> addresses to match host physical addresses for assigned devices.
>>
>> On some platforms, P2P DMA is performed between devices within the same
>> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
>> without going through the host bridge in order to achieve the required
>> performance.
> 
> Pass this info to guest firmware, let it set bars any way it wants?

We are using firmware, relying on the existing EDK2-supported mode
enabled by PcdPciDisableBusEnumeration, where firmware is expected
to preserve the PCI topology and BAR programming established by
the hypervisor.

In our case, the hypervisor is QEMU, which performs PCI enumeration
and resource assignment before handing control to firmware. EDK2
then explicitly refrains from re-enumerating or reallocating PCI
BARs, as this is already a supported firmware behavior.

-Tushar


