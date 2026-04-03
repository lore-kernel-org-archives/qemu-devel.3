Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C841E7E360
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8bJT-0001k7-RS; Fri, 03 Apr 2026 05:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w8bJQ-0001gK-TU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:59:37 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w8bJN-0005tt-OL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDfWs+ctCAJnj1aT/w7bkEvh8D3qD/b68vFsR9p0j5wbc6iCT4m5wGdxYncCZvMwdQ9UUd/3ULXh38i/uAXbi/1qcB7gZR8jBiynS6Hdwa342tb1aewwPA9NtavBBTe9YqX8zxxrcMCUiiPHXnbV1BQbvOYxwFC+Dlo4QuYcnUkcErPyn3jRGyl0k8K9rbIsrcC2q0wNBwLVil+qhXlpAyXinjVAkT5Ho96wHldUNZ+lkDMtO20I8M3nX4yoiToven9JKrrgDSv4ORtBRSIYDL4Z5SkJjSR0BnMPLX/I0AaQqW/MHFjN0rcx+UMnNTk/2At5N1LhhizkcpgWm8ri3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkAXku5G3nZ7rz9KPOtdn9gFMgfDeJMtRWMHZzQGllw=;
 b=CFBJ2KRsGTi4UpvTZhbwKJopldMO0KzLCbFwMwOZ+XX+qnHPwtylTFlS3fkvr5+juLhsLlqueoWiuJC1Y6zNqPG7acgNiMSzSHwlb3IWhFQcenblOyzrKyZom0uAxaT8GOIHwAzmsS4MfC/41aKYjAf88/pRuw7ohQLzKDSj/aOp5MGahSgLsmPM+3gWdNAeZK870RNRfjttQsFWK7TSaVomJAI9ae6RweqIr3rXMe4lqYCHMM5Obzz99f5t0Qs8/BXQp2LFcvyave83Bwy6YYhO01yGMBYxf4KRXcN4NpwS/VnGNvuIxHeVHbm1eP+CD5ODVd+4/oTn/JFX66CEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=fujitsu.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkAXku5G3nZ7rz9KPOtdn9gFMgfDeJMtRWMHZzQGllw=;
 b=jJFvB5GXWlGRkWqiUAyZC9ZEtzeLzO9QTAO7n1kVx+BcHQBBHlJgWAur1FWzI0wWZm44KB9xDCTgdGRumCa3eJAyTZadkUXIaGuNNeZJNAr5YQvr3kLku51aegxL3Z/9rxoShGgvpsQ8FeehbW36e1Si0zhKwJbs00ooByAmHzU=
Received: from MN2PR12CA0031.namprd12.prod.outlook.com (2603:10b6:208:a8::44)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 3 Apr
 2026 09:59:26 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::a4) by MN2PR12CA0031.outlook.office365.com
 (2603:10b6:208:a8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 09:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:59:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 3 Apr
 2026 04:59:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Apr
 2026 04:59:22 -0500
Received: from [10.67.184.128] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 04:59:19 -0500
Message-ID: <1ca00148-1de9-49d0-9e13-6d829ef5323d@amd.com>
Date: Fri, 3 Apr 2026 17:59:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Peter Xu
 <peterx@redhat.com>
CC: Samuel Zhang <guoqing.zhang@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "farosas@suse.de" <farosas@suse.de>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "Emily.Deng@amd.com" <Emily.Deng@amd.com>,
 "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>, "PengJu.Zhou@amd.com"
 <PengJu.Zhou@amd.com>, "Qing.Ma@amd.com" <Qing.Ma@amd.com>, Guoqing Zhang
 <simpzan@gmail.com>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
 <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
 <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com> <ac1AE4vrAlKmawlb@x1.local>
 <59f0466e-71e2-4114-ab4d-285a727aa7d8@amd.com>
 <6f1df732-5c2c-4f1b-a59a-aa6af5566505@fujitsu.com>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <6f1df732-5c2c-4f1b-a59a-aa6af5566505@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: guoqzhan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 017f12fa-7d42-4fe8-8f95-08de9167b086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: K0pTHq2XkAshBGzE8yr99+HuiTuyjbcNKxuZbq47DtS3EBLkLMvYiDm0rpaas5QzNRAyMY0ubt35jKe6rLm37TWqIFU/nGI6ULl8x1dsxO93xgO0xQx4HuLhO9dhtCPJ671/ElCreHBmBq/HBJN6tGWRFcHwW5eKGIGZ/iX2oBaQhyjV/nZNy56m0hNOHRI+5NDduGu6CGwn6Ry9KYq451g8nrp+b7snKNFgPV7J2GKWb9sGh/qpoZOrO7OFJnjquy0ps4OL7JxQE08RUb8AF+erqxwkuXCl+5PHHaw+EZf0CKTinYl5FkdHM+Gg/A3l5ibGFgk6oLZzWYmFdKdsHTvcfZqmk0IrXWvT7ZtixSY+QcQi0TIju8rk3pok790beJLWfOSlnmPDkf2y0Dg5jaWCr+fdDZjUrqnoo9OixluRKtpKaOZy0BupTU8OYem7e9yUMOTeqSB/gTQ6CttFlsC3zMQV0Ky1khzvUNrrO0NV58IPmn06p1WjTd3SVc7BSNtwYE04teB9dW7HtitDzGGne8KeujGIM3FWJNejY2H8skckbvtmeGrydNyPsgPKP7tmbPQpIRg3A8BEUqD0TKsJJcHDoLREtX8fFCPsrm4ocjxiqZ1DVe/FLfaGP4EPUPudE8zmIVTJaaTDAGBNLuBlhMPgF24Qm/k3JVHjQTDmbzNqr5UN43neGletzmWQOMBwVSdgwKYD6oEIagLuTR5AyzGvdxrsIZZ+0e3ZbPChrDNeM70v2I/MLi3vy+IADgzw7ZxhjA7/Ztq8Zj2lhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r11ZJD6A4KGEZf2ejEs6DPZCXL3Z7qTc7LRLPdbFUgkLZmuoBSrIPDz5S/Kj0IiNPU9tk3Nl2oPtvmjFi71uUiVtGBhxJ4NmtQJ4YT8Xf/V7JD4kUOOUAJWtmYmScT+MFI1R61SGqSAAGk4Ys6evTCRHjoVOd6YNRO4kCKis4fcZr9mT/FztlHIJgYzPJ/pJMYQHhPQEvPT9AUSDc3tfKJ8Rr9LsDtWvnTQ+pI19nDZKszAhgQjM5xzoaGDuiCkyqYqFESZSUXtgaRRTbiiMYGHdsK6lFXcFz3F3urvgWU3c8QHps3qe5i1jyqyogYdePgwn8CmsaC4DVjZ2D/oEXZ0OcACOdNuKSXC2P4qzkSYBDnIt2CVGHrFBchhvhdep+gcZcZBEstDB6qzgr2QMN1vJ3P3XDj3r7tSq1foHcZyzyoGWurch4Y7OjYWd+k9C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:59:26.2029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017f12fa-7d42-4fe8-8f95-08de9167b086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 2026/4/3 17:39, Zhijian Li (Fujitsu) wrote:
> [Some people who received this message don't often get email from lizhijian@fujitsu.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On 03/04/2026 14:15, Zhang, GuoQing (Sam) wrote:
>> [You don't often get email from guoqzhan@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi Peter,
>>
>> The NIC is `Mellanox Technologies MT43244 BlueField-3 integrated
>> ConnectX-7 network controller`. 2 Servers directly connected with the
>> RDMA cable.
>>
>> I tried to enable multifd with following monitor cmd on source VM, but
>> migration failed with errir `Failed to connect to '192.168.100.3:4440':
>> Connection timed out`. I don't know why.
>>
>> ```
>> migrate_set_capability multifd on
>> migrate_set_parameter multifd-channels 8
>> ```
>>
>> Hi Zhijian,
>>
>> Follow is the perf data you requested.
>
> Hello Sam
>
> I applied your V4 patch on v11.0.0-rc2,, but encountered following error during migration.
>
> (qemu) migrate_set_parameter x-rdma-chunk-size 2m # only 1m worked
> (qemu) migrate -d rdma:192.168.33.1:6666
> (qemu) qemu-system-x86_64: rdma migration: send polling control error
> qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
> qemu-system-x86_64: Channel error: Operation not permitted
> qemu-system-x86_64: warning: Early error. Sending error.
> qemu-system-x86_64: warning: rdma migration: send polling control error
>
> Any idea ?


Hi Zhijian,

the perf data is based on commit 
fff352b9b6080e580aa1fadd29b4eccf4cb2922a. I just tried v11.0.0-rc2, it's 
also working on my side.

one thing to notice is that `migrate_set_parameter x-rdma-chunk-size 2m` 
should be run on both source and dest qemu before migration starts.

Regards
Sam


>
>
>
>> NIC: Mellanox Technologies MT43244 BlueField-3 integrated ConnectX-7
>> network controller
>> 8GB RAM VM.
>> workload in guest: `stress-ng --vm 4 --vm-bytes {size}G --vm-method
>> rand-set --timeout 0`
>>
>> | transport | chunk size | stress-ng size (G) | time(ms) | throughput |
>> |-----------|------------|--------------------|----------|------------|
>> | tcp       | n/a        | 1                  | 44955    | 1245      |
>> | rdma      | 1m         | 1                  | 46893    | 1240      |
>> | rdma      | 2m         | 1                  | 47374    | 1308      |
>> | rdma      | 8m         | 1                  | 38271    | 1542      |
>> | rdma      | 16m        | 1                  | 38901    | 1558      |
>> | rdma      | 32m        | 1                  | 13895    | 3762      |
>> | rdma      | 64m        | 1                  | 4288     | 14357      |
>> | rdma      | 64m        | 2                  | 5405     | 13719      |
>> | rdma      | 64m        | 4                  | 9976     | 9475      |
>> | rdma      | 128m       | 4                  | 3345     | 27428      |
>> | rdma      | 256m       | 4                  | 3537     | 26097      |
>> | rdma      | 512m       | 4                  | 3417     | 28440      |
>> | rdma      | 1024m      | 4                  | 3412     | 27637      |
>>
>> Regards
>> Sam
>>
>>
>> On 2026/4/1 23:56, Peter Xu wrote:
>>> [You don't often get email from peterx@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Tue, Mar 31, 2026 at 06:33:23PM +0800, Zhang, GuoQing (Sam) wrote:
>>>> On 2026/3/31 11:30, Zhijian Li (Fujitsu) wrote:
>>>>> [Some people who received this message don't often get email from lizhijian@fujitsu.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> On 31/03/2026 00:10, Peter Xu wrote:
>>>>>> Hi, Samuel,
>>>>>>
>>>>>> On Fri, Mar 27, 2026 at 02:50:06PM +0800, Samuel Zhang wrote:
>>>>>>> The default 1MB RDMA chunk size causes slow live migration because
>>>>>>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>>>>>>> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
>>>>>>>
>>>>>>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>>>>>>> faster migration.
>>>>>>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>>>>>>
>>>>>>> Performance with RDMA live migration of 8GB RAM VM:
>>>>>>>
>>>>>>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>>>>>>> |-----------------------|----------|-------------------|
>>>>>>> | 1M (default)          | 37.915   |  1,007            |
>>>>>> This is the default. It surprised me a bit knowing it can only reach 1GB/s
>>>>>> throughput with the current code base.  Do you know why?  I thought RDMA
>>>>>> should be much faster than this on throughput with whatever hardware setup.
>>>>> Regarding the baseline performance, Samuel's numbers look reasonable. I checked
>>>>> some of my old test data on a ConnectX-4 Lx card years ago, and the throughput
>>>>> was around 10 Gbps (~1.25 GB/s), which is consistent with the 1 GB/s he reported.
>>>>>
>>>>>>> | 32M                   | 17.880   |  2,260            |
>>>>>>> | 1024M                 |  4.368   | 17,529            |
>>>>> My guess for the dramatic performance improvement is that a larger chunk size
>>>>> allows qemu_rdma_write() to batch more *contiguous dirty pages* into a single,
>>>>> more efficient RDMA send operation.
>>>> The `throughput` data is collected from `info migrate` qemu monitor command
>>>> after live-migration.
>>>>
>>>> Yes, Zhijian is right. As each chunk triggers a write_flush and each flush
>>>> involves posting an RDMA WRITE and WAITING for completion, there's software
>>>> overhead here.
>>>>
>>>> For 8GB RAM VM migration, 1MB chunk size produces ~15000 flushes. The
>>>> software overhead adds up and prevents the RDMA hardware from sustaining
>>>> high throughput.
>>>>
>>>> When chunk size is 1GB, there are ~3700 flushes. Reduced flush count means
>>>> reduced software overhead and improved overall throughput.
>>>>
>>> OK, thanks both.
>>>
>>>>> Is there any workloads running on the guest during the migration, or just an idle guest? @Samuel
>>>> The guest is idle when I test the migration and collect the data.
>>>>
>>>>
>>>>> Given the significant benefit and the fact that the patch itself is straightforward,
>>>>> I think it's a worthwhile addition.
>>>>>
>>>>> Acked-by: Li Zhijian <lizhijian@fujitsu.com>
>>>> Thank you for the ack, Zhijian!
>>>>
>>>>
>>>>>
>>>>>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>>>>>> One thing to mention is RDMA migration is in odd-fixes stage, actually it
>>>>>> doesn't have a real maintainer so it is kind of "orphaned".  In this case,
>>>>>> I actually won't suggest we add any new knobs for performance reasons.
>>>>>>
>>>>>> Do you have a strong reason to propose this patch to land upstream?  Is it
>>>>>> used in production systems and it solves some real problems for you?
>>>> We have VMs with large RAM and find TCP live-migration is not fast enough
>>>> and expect RDMA migration can be faster.
>>>>
>>>> But we found the rdma mode migration speed is slower than tcp mode. See
>>>> following data.
>>>>
>>>>
>>>> 8GB RAM idle VM live-migration performance:
>>>> | transport mode       | time (s) | throughput (MB/s) |
>>>> |----------------------|----------|-------------------|
>>>> | TCP                  | 36.89    |  1,081            |
>>> What is the NIC setup?  Did you try to enable multifd to offload zeropage
>>> detections?  Or is that not feasible due to some reason?
>>>
>>>> | RDMA, 1MB chunk size | 37.915   |  1,007            |
>>>> | RDMA, 1GB chunk size |  4.368   | 17,529            |
>>>>
>>>> This patch allows us to use larger chunk size for faster RDMA migration.
>>> Sure, Zhijian's point is reasonable.  If he's fine, I'm OK.
>>>
>>> Thanks,
>>>
>>>> Regards
>>>> Sam
>>>>
>>>>
>>>>>> I also wonder what Zhijian would say on this.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>> --
>>> Peter Xu
>>>

