Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8D9FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIO45-0005YK-Uo; Thu, 30 Apr 2026 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wIO40-0005Y1-3T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:52:08 -0400
Received: from mail-westusazon11012031.outbound.protection.outlook.com
 ([52.101.43.31] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wIO3t-0008AN-9f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:52:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM1ooUUwUCMKi8ofb9qQykOXRiX1FPq0L2WF61uJu4Ue+o5DutRp9OYchWPqDxVpfpvEE5+M0zEssGjCZcxYuJddOGuhCZuwx1C2rnVqqDHi7aiEkbfwzd/alKzGFwVFd+q5L7hfjdduupFGrhvVkJ98TfFQGVxUf0GXlG+nvG3oCE42NcOQON9uDQNNC0pUc1Bm2puk/HnRyob/WhMvtWAF1URXxITmqYCc7+h6f+/HMiLlMmEm2rL6c7X+uNKR1H/r9CsJnpHMsoPBkLOxsMbOubrF6xXdyM6j6InP0dCIWHhJ6qcRwP33nLsZqvwv1wDXvEzh6d+kYSmls6FHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZR4l8CwBD0/yejgRl359rM1/cNbYgtx4kPItxcnfD4=;
 b=f+U9QaIf8I3V1gEEdeTj3eYhcSK0YoZUyonKsJErbGjCwzTiu9Q/mnr2ye8POTAvkTRCmRkmebYX87rPuzvVfN8Tl+Fb7VI93byQ9mAOs/iUUy8PdXmKkW4bI0/WsNe15NtsMyBmSYdxGGxFk8XY+BCccFYE8RglEGmgXj17ooya7f50IIjBoT14/BgATJPlARQM/VPKy4vQ3/fHPR9iYqUfWvVLi9oYlgIY4A3xpEADm9X+vEr96tiRrynikXo9A2Sip3UL+0ar/t5LP8+pHiaEHNONzLIXQMsHT4/7XKjCa5CnurtfO1D3BWZlo0p9rD9hlOzQxu/sonNRWx/I3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZR4l8CwBD0/yejgRl359rM1/cNbYgtx4kPItxcnfD4=;
 b=huyV3icAxX6kKcdJl8ErGIm2G3ONS4L4Wm62LUgTKUsM6EHk91dnmdiPZb4MC/+kjVGEsawHs+TNKykD6O28V866q8voLopTeDHQMStm5o9m0A9De24CsPwTBVRUIievPI7wqi4KT9QGud4tRICbqXM8ptd8GR01h0BpsUl9wcI=
Received: from SA9PR13CA0178.namprd13.prod.outlook.com (2603:10b6:806:28::33)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9ab) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 09:46:49 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::17) by SA9PR13CA0178.outlook.office365.com
 (2603:10b6:806:28::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 09:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:46:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 04:46:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 04:46:47 -0500
Received: from [10.67.184.128] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 04:46:44 -0500
Message-ID: <5481c478-1957-4a6a-9732-806b81100e1d@amd.com>
Date: Thu, 30 Apr 2026 17:46:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] migration/rdma: add x-rdma-chunk-size parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Samuel Zhang
 <guoqing.zhang@amd.com>
CC: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>,
 <lizhijian@fujitsu.com>, <eblake@redhat.com>, <armbru@redhat.com>,
 <Emily.Deng@amd.com>, <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>,
 <Qing.Ma@amd.com>, Guoqing Zhang <simpzan@gmail.com>
References: <20260427031401.3895523-1-guoqing.zhang@amd.com>
 <ae8NhTr69D7Wzejz@redhat.com>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <ae8NhTr69D7Wzejz@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: guoqzhan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e5c153-4147-46ea-677a-08dea69d66c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: wDt8j4yw/g8rRzZX0CqcbA1rsrpKwhX+tja1NjrMVMysKAAwLMsHW2HAAb77SZdWDDZDDIh2JuwAr+9afjjnAZoKCq68OATTP8Qpcc6Y0i9EYBTmOiKfsrW+WzdHdYCjRDM5PjSJra2K9BNsnM/7+QYrzUV9uMEapU2JVgARZ6BSHH36fbzmCcpVl4jHxlge6Brm0IkiKz/cugblPUPGZ1SB2TLJ0UHIL/SRq62F2Y0aVrq6wmwKTZpFDPgrHfaZfvnKD76D8RYxfgIb8w1X8yRVC4xLQMvTxmFGzr94E2izFp9B/gXSmqMyFcDWr63BnjYHpfYPfUh7RnTyaLfxN0+fL2rFm4GcGWSBrtGKIsHcE1ZzW/mVIjVb5HZG9UWPKjY9azb6fRoyPr8OKN6w5L1ZFN6mf8NatGBIC7h9M0PY37ZodepXRigczvPxXz2VLBEGYvTMjFtkjhEiJAuKLNUwjj2K4ozfxqeeeCzB3QnBe7U8v876yrQB1/xoyZhURd4MhRoWEJKWEG2+kRK7281jYa9Hb5GNcpQUxNHNDFLPc6oo1fXflOkXNJA6zAdKI/CoaFqX1wh6B2hznrRSWtALN6bY84RRCJD43j1508InQa7/lPV+8k/lqS1eNCj1gq1vpd6uYwiHegIh5wAxLdfDxfXDukNkfgf7RWRdG6udKYk/alv7QBsWtq4t38X/7Su7X3D+mOKduMWGVod9Anfr7rT3S3UpAZetCMT6wfOFNu+MMdIlnTwEIjUr5Jeq4Qlj1LxZQnjf35hsUhlVAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HU9DoDn555heLXLbFlcRu74Lr/VpcDFSmnwdnSOAu+qpkMQF/LkO+3Jsdb9L0ha6kYiC8RpJNxpjXxrKSVogwlB6nbJJnNz29B9FVCPR9MyZ1dYyKT1DRTRZiNawCptWPJSDoWG4B4zLTlJiBsM1Je4Ytkg0wk5G4XANT2m2t+Qo9YPhNo/vS5M/apYZlZBv6vaiuzxQOU7TU8J2QmYmzR/fAxuOnveuCB7qiXxtKqVaf3gibI0NIiUVAtm6XnTkspYQsu+eFPjYhDHvD0DjzcLomXHRCt8xoiDYMbJ4Xc+6qhaf8eAtW4M7na+8qOeDYETNfT4miMEc/urpQZaET9+XkmVEoCxNkXt0l4Q48f3XmOTnfogMUvB7oOTlsB58wtvsEoqlN0od3ko2Ew9mGsByuyOPEfFKaSZ0H1qhcFqwwMSKaEZW7lpWm7CYzzf5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:46:49.6931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e5c153-4147-46ea-677a-08dea69d66c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
Received-SPF: permerror client-ip=52.101.43.31;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 2026/4/27 15:17, Daniel P. Berrangé wrote:
> [You don't often get email from berrange@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, Apr 27, 2026 at 11:14:01AM +0800, Samuel Zhang wrote:
>> The default 1MB RDMA chunk size causes slow live migration because
>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
>>
>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>> faster migration.
>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>
>> Performance with RDMA live migration of 8GB RAM VM:
>>
>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>> |-----------------------|----------|-------------------|
>> | 1M (default)          | 37.915   |  1,007            |
>> | 32M                   | 17.880   |  2,260            |
>> | 1024M                 |  4.368   | 17,529            |
> What is the downside of setting a larger chunk size ?
>
> IOW, why should we keep 1M as the default when it gives
> such terrible relative performance ?  Why not make 1G
> be the default instead of creating this flag and requiring
> people to know about setting it ?
>
Hi Daniel,

Thank you for the very good question.
I dug into the git history. The 1M chunk size dates back to the original 
RDMA implementation by Michael R. Hines in 2013 (commit 2da776db48).
I agree 1M is too conservative for modern hardware. However, I found 
that 1G is not necessarily the optimal chunk size either.

I collected the following performance data on my server:

NIC: Mellanox Technologies MT43244 BlueField-3 integrated ConnectX-7 
network controller
qemu version: v11.0.0-rc2-139-g25fcd86805
qemu config: pin-all off (default setting)
VM system RAM size: 8GB
guest workload: `stress-ng --vm 4 --vm-bytes 1G --vm-method rand-set 
--timeout 0`
```
chunk_size  total(ms) setup(ms)   down(ms)  Throughput(Mbps) total_size  
transferred
1m            45,156       864      1,166         1,252.50  8.02 GiB    
  6.46 GiB
2m            41,848       853      1,161         1,354.11  8.02 GiB    
  6.46 GiB
4m            37,836       861      1,435         1,523.33  8.02 GiB    
  6.56 GiB
8m            37,684       852      1,176         1,537.98  8.02 GiB    
  6.59 GiB
16m           37,620       852      1,173         1,538.96  8.02 GiB    
  6.59 GiB
32m           15,034       963      1,864         3,401.26  8.02 GiB    
  5.57 GiB
64m            4,492       868      1,554        13,637.46  8.02 GiB    
  5.75 GiB
128m           3,940       851      1,662        16,860.59  8.02 GiB    
  6.06 GiB
256m           3,640       852      2,206        19,390.99  8.02 GiB    
  6.29 GiB
512m           3,645       852      2,179        23,200.67  8.02 GiB    
  7.54 GiB
1024m          3,665       865      2,238        24,676.59  8.02 GiB    
  8.04 GiB
```

The downside of a larger chunk size:
A larger chunk causes more data to be transferred per dirty region. For 
example, a single dirty page (4K) will cause a full 1G
chunk to be transferred when chunk size is 1G. As a result, the total 
migration time may not be the shortest with the largest chunk
size. See 256m row and 1024m row in the table as an example.

Based on my data, 128m appears to be the sweet spot for my hardware and 
workload, but different configurations may have different
optimal values. I think increasing the default (e.g., to 64m or 128m) 
while keeping this parameter for user tuning would be a good
approach.

Hi Zhijian, what do you think about (1) increasing the default chunk 
size, and (2) keeping this tunable parameter?

Thanks,
Sam



