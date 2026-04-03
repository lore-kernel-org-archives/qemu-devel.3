Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D68D730A2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 06:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Xtc-00075M-HC; Fri, 03 Apr 2026 02:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w8Xtb-00075E-Cu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 02:20:43 -0400
Received: from mail-westusazon11010043.outbound.protection.outlook.com
 ([52.101.85.43] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w8XtY-0000W4-4w
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 02:20:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plTj0jgkJ9j7rhnNzeTrGeq03yH6oBWO2K6qb9+GG1ct1lOBoZl1noORdY4IFPbvgnSEhOw8OH9A3fP03DtsKgm1xpl1vK+M2+1jY/fY31WZ/r3BRhhT33tu1pwUYDe7RzMd1t9aOIV8et2rDMdwJcTBNG4eGYfCOC3C3I80rych827sZ2ZrGFDjZQXZIV9Tzm1Q7/Sf6U4cs37DwL+KhJPfOhczyL7XxvTv2Xx1oiXUbEEpWkUduz/+xPc4rpU83eLWCXxRpe8ITdfJTZVvCoiVk2GD9K1MlWeYerYZjqEgHGFR1jzqJmpmcZnVKwFJT26SoqvARznLNftpaCBQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsdLiY8yA+Q57sY/ZbS3ZLMzEwUEMryOWq5Q91Om+ko=;
 b=DBi/MmpbNymsRU9cwMnQdNbFoA5XZbP1rE3WdzGYuxeC9OsyCDHasIwbREQw5gW5Pm+bke40EkgQi8J2xzYuR6g1bODtXIonS9Nl0c8nPgyBq+Uk+bxJ0SXrbYe9QZr534PF6Sh9hJSjp2CWQ9usuWiMNWFuJMq7btjWdVg86izu8yyNtK/WFyAEBSX2A0ME5wsimqlsf7Uk8zyr0K/2WS6PVdU5nSVc0u4XabayAcFksN8UwLSawLxAh9jow7F8wpbbbeYiQB1Kr73iye/iIyQd+fPcUdXGmdAuPFOOePtwV+/j8olzIiP8TSj38XlDE6NuNAfCsyK73T3Kb2LsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsdLiY8yA+Q57sY/ZbS3ZLMzEwUEMryOWq5Q91Om+ko=;
 b=n1Jxn/iolvDKJYttIGkjW5rmWTRj5t1jlFPAwk9YsIeCOTIw+fBulldrrWIqG5I5iU9QIMlesQbQOzUxbI9KLbiTlE8+TuD2D3TIJ9Y/Ds/WqP0csFU+42enISVMYLUHEbMn3l6HpiNQHvI5c/kg2w5/lDrIOMuG22OFXl0sz5o=
Received: from CH2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:610:4d::35)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 3 Apr
 2026 06:15:31 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::7d) by CH2PR19CA0025.outlook.office365.com
 (2603:10b6:610:4d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 06:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 06:15:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 01:15:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 23:15:30 -0700
Received: from [10.67.184.128] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 01:15:28 -0500
Message-ID: <59f0466e-71e2-4114-ab4d-285a727aa7d8@amd.com>
Date: Fri, 3 Apr 2026 14:15:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
To: Peter Xu <peterx@redhat.com>
CC: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Samuel Zhang
 <guoqing.zhang@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>, 
 "armbru@redhat.com" <armbru@redhat.com>, "Emily.Deng@amd.com"
 <Emily.Deng@amd.com>, "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>,
 "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>, "Qing.Ma@amd.com"
 <Qing.Ma@amd.com>, Guoqing Zhang <simpzan@gmail.com>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
 <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
 <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com> <ac1AE4vrAlKmawlb@x1.local>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <ac1AE4vrAlKmawlb@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a98c9f2-2c10-4f28-45cf-08de914868d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cd9alxn8iFr6NbUxUQwDrE2DfDcV3x0UVpYR7t3j5gcAS08HWcNz9MUp+Nm7jAC/zpV1Lodsuhsmm1qSL/FDiD2botXbzWNzBGZXo6wDpJeTfY1xEdL8gvtCj0/Je6eO2G5oKmkgl7/5wOEI0MIDDt0Gg9EQVnnf37omxWVjgMusBEoBGSUNstvMhpIj3l3QsFbtz/6dEhpkB5jIYG2utKyQT3qooeezKG/k8kLBgykVZcuMkVNv8vdcNR//UZycuLeRwGXTE71RzIDeODoajbIxC3d1yoWL58XE7Es2RPS2ST7gmzfcgSgWlTHbGnsdqPLSFC9pPJKOt6oZ52uo7k1qMOtDxGV4Eo8h39CO2sdRpRmNNWkB/Tyl6XA9EbmgTCMWXlGctbeGFPbaaU0WvX8rTXarZwmPsgAGv7aeJqlSpNdLErYpQSK/BUqgc3x13zkEbxNdwPsbXhjTxrFLYtiPkKvU9e4lNK0OKZacTQsG63BIdbZYalkPtp/AAyp9uSGUUJH96UXwglLJ24jQqLL7IA3lJpAs4b8Ln/5swBfJTwEV06Gw3aoKEJ3r+ivcQzHxVYOvZF97H1Hb3aXD5jylHvnp9gVOvQ6pSiE2Af5MuEFDpEAyab9lH+uodSSQbZDD2PvqkDRqvPNejLiPTb+lnNc0cg87zUwtTz9ZWuR1VL0trS4PWChzMSupoWxA6/DIIu2/Eh18qRb6tcbes7cj5EDGUI/0EAhFEIEyVBcJbCaSLqEOI1duV0NawSB4Jw8RSXN2PIWWkr/30v8VUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: itEW0WBnkNefz4yUFi6ROZyfJFWJgc8Re0iKdgh0FabfHcdbd4AYeAcyPv1r8DjdE+bDWe3+QOArY5AUEyUped+H5qBPcyo5BKre+vuUhGSNu31uTVB8ltfTwyppnn35uu1BPh078ZjApBl7a5eVrw63f9ajpzljjBCz570Z4RHhtZQ4Sr0Tyc2jMgvat19I6SKqLKmMFYKx7SwM71ytSYbJ++1SAS6ijpBvsgdgjpy0zr9i4viNWchi/MjQR4KVcbB8PVUHpqELGPjbu0IVMqJLbDens91dy8htA7x2ws8dMAa4nSUtH4xqlHL00/kTcQgSmNQUHYeQ44l4LxIpCZXt8ddLVS+/vAX9aQTmj3nlpAJ2pL/NN/7/R2iYJ6QMu/D/F0HIDiDeh/gM2Lv6RXzmfEWzio2pgyUivK35DgiLnM+GPeN9tCOsvHhsTTZ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 06:15:31.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98c9f2-2c10-4f28-45cf-08de914868d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
Received-SPF: permerror client-ip=52.101.85.43;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

The NIC is `Mellanox Technologies MT43244 BlueField-3 integrated 
ConnectX-7 network controller`. 2 Servers directly connected with the 
RDMA cable.

I tried to enable multifd with following monitor cmd on source VM, but 
migration failed with errir `Failed to connect to '192.168.100.3:4440': 
Connection timed out`. I don't know why.

```
migrate_set_capability multifd on
migrate_set_parameter multifd-channels 8
```

Hi Zhijian,

Follow is the perf data you requested.

NIC: Mellanox Technologies MT43244 BlueField-3 integrated ConnectX-7 
network controller
8GB RAM VM.
workload in guest: `stress-ng --vm 4 --vm-bytes {size}G --vm-method 
rand-set --timeout 0`

| transport | chunk size | stress-ng size (G) | time(ms) | throughput |
|-----------|------------|--------------------|----------|------------|
| tcp       | n/a        | 1                  | 44955    | 1245      |
| rdma      | 1m         | 1                  | 46893    | 1240      |
| rdma      | 2m         | 1                  | 47374    | 1308      |
| rdma      | 8m         | 1                  | 38271    | 1542      |
| rdma      | 16m        | 1                  | 38901    | 1558      |
| rdma      | 32m        | 1                  | 13895    | 3762      |
| rdma      | 64m        | 1                  | 4288     | 14357      |
| rdma      | 64m        | 2                  | 5405     | 13719      |
| rdma      | 64m        | 4                  | 9976     | 9475      |
| rdma      | 128m       | 4                  | 3345     | 27428      |
| rdma      | 256m       | 4                  | 3537     | 26097      |
| rdma      | 512m       | 4                  | 3417     | 28440      |
| rdma      | 1024m      | 4                  | 3412     | 27637      |

Regards
Sam


On 2026/4/1 23:56, Peter Xu wrote:
> [You don't often get email from peterx@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Mar 31, 2026 at 06:33:23PM +0800, Zhang, GuoQing (Sam) wrote:
>> On 2026/3/31 11:30, Zhijian Li (Fujitsu) wrote:
>>> [Some people who received this message don't often get email from lizhijian@fujitsu.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On 31/03/2026 00:10, Peter Xu wrote:
>>>> Hi, Samuel,
>>>>
>>>> On Fri, Mar 27, 2026 at 02:50:06PM +0800, Samuel Zhang wrote:
>>>>> The default 1MB RDMA chunk size causes slow live migration because
>>>>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>>>>> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
>>>>>
>>>>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>>>>> faster migration.
>>>>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>>>>
>>>>> Performance with RDMA live migration of 8GB RAM VM:
>>>>>
>>>>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>>>>> |-----------------------|----------|-------------------|
>>>>> | 1M (default)          | 37.915   |  1,007            |
>>>> This is the default. It surprised me a bit knowing it can only reach 1GB/s
>>>> throughput with the current code base.  Do you know why?  I thought RDMA
>>>> should be much faster than this on throughput with whatever hardware setup.
>>> Regarding the baseline performance, Samuel's numbers look reasonable. I checked
>>> some of my old test data on a ConnectX-4 Lx card years ago, and the throughput
>>> was around 10 Gbps (~1.25 GB/s), which is consistent with the 1 GB/s he reported.
>>>
>>>>> | 32M                   | 17.880   |  2,260            |
>>>>> | 1024M                 |  4.368   | 17,529            |
>>> My guess for the dramatic performance improvement is that a larger chunk size
>>> allows qemu_rdma_write() to batch more *contiguous dirty pages* into a single,
>>> more efficient RDMA send operation.
>> The `throughput` data is collected from `info migrate` qemu monitor command
>> after live-migration.
>>
>> Yes, Zhijian is right. As each chunk triggers a write_flush and each flush
>> involves posting an RDMA WRITE and WAITING for completion, there's software
>> overhead here.
>>
>> For 8GB RAM VM migration, 1MB chunk size produces ~15000 flushes. The
>> software overhead adds up and prevents the RDMA hardware from sustaining
>> high throughput.
>>
>> When chunk size is 1GB, there are ~3700 flushes. Reduced flush count means
>> reduced software overhead and improved overall throughput.
>>
> OK, thanks both.
>
>>> Is there any workloads running on the guest during the migration, or just an idle guest? @Samuel
>>
>> The guest is idle when I test the migration and collect the data.
>>
>>
>>> Given the significant benefit and the fact that the patch itself is straightforward,
>>> I think it's a worthwhile addition.
>>>
>>> Acked-by: Li Zhijian <lizhijian@fujitsu.com>
>>
>> Thank you for the ack, Zhijian!
>>
>>
>>>
>>>
>>>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>>>> One thing to mention is RDMA migration is in odd-fixes stage, actually it
>>>> doesn't have a real maintainer so it is kind of "orphaned".  In this case,
>>>> I actually won't suggest we add any new knobs for performance reasons.
>>>>
>>>> Do you have a strong reason to propose this patch to land upstream?  Is it
>>>> used in production systems and it solves some real problems for you?
>>
>> We have VMs with large RAM and find TCP live-migration is not fast enough
>> and expect RDMA migration can be faster.
>>
>> But we found the rdma mode migration speed is slower than tcp mode. See
>> following data.
>>
>>
>> 8GB RAM idle VM live-migration performance:
>> | transport mode       | time (s) | throughput (MB/s) |
>> |----------------------|----------|-------------------|
>> | TCP                  | 36.89    |  1,081            |
> What is the NIC setup?  Did you try to enable multifd to offload zeropage
> detections?  Or is that not feasible due to some reason?
>
>> | RDMA, 1MB chunk size | 37.915   |  1,007            |
>> | RDMA, 1GB chunk size |  4.368   | 17,529            |
>>
>> This patch allows us to use larger chunk size for faster RDMA migration.
> Sure, Zhijian's point is reasonable.  If he's fine, I'm OK.
>
> Thanks,
>
>>
>> Regards
>> Sam
>>
>>
>>>> I also wonder what Zhijian would say on this.
>>>>
>>>> Thanks,
>>>>
> --
> Peter Xu
>

