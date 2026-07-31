Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675EDC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wplIh-0001f2-5v; Fri, 31 Jul 2026 07:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wplIe-0001ep-1Y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:21:12 -0400
Received: from mail-southcentralusazon11013031.outbound.protection.outlook.com
 ([40.93.196.31] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1wplIb-0003Mc-HP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:21:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la+QEKseMdmQLt6xRjtjSMZxlP7gmmtbd5NcI+lIXKqfswsCGYoiW8OdkqTq7RoIfQrB8jERpEbqszf6v6Ifhtup/v1iuiWxLFpcabNzm+J6AGBGILEsz0RlJm5XLroJanwvIhIM2LEFKd8CC7FnWG3hio3ET7W96x2uk45PxkTS6SW2Vo1M/vGytYm1Ay2MYN0BZ9B6C8CyBE0Xuh5ZF5CncJrnwXU6RUa/wLbMT6Bv/qAQ5zDP9mh7sAhZ3vpf5UUEnBPYnB0IcSUXDnFRwmDF0zUMxBxLzIH3LB22S02Tt6qAMUi4wMyoXNxrsJCKkLNFyAG/PNd9E5Qpc3Eizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmBh2Ntne/mWXFIjcKPrgMKsvw3s8E2xIrEMYyrUBn0=;
 b=SaG7G0GNH4Gh2Ev2+u6qbeH+EuNBBSYVQOpuaqGocPQBZbTjRJDTOnAsGAraxzpPgHSkEdiYQDqnC7FUAda+fPwhNKSLc82IeGnitBEONP05k7zqL6DlsZE8O0isTCOgoPKmexYoSQtxyXghU0Azk2fPYj63QlGunXHRyLCD0sLwfBWoiPMfdVZ2GR9ctUBTkHUbotlM7gFsF/ZHOZ9KT0z7hIjD14otZ8l/WzoW1uchfK7B9U5/cFeKqQxA1PTnDAUq90ICroNfmTzm0IEWabAnCNtG7bPEbxN0ta4BD1aJftjVhttnIhSIN2qC/GVC6jeqJy6nhY832BrV2sBqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmBh2Ntne/mWXFIjcKPrgMKsvw3s8E2xIrEMYyrUBn0=;
 b=LIJ5adUk84TyqshfDcrAOWJNe2xNbJh3bpBlRYuYiuvlWDLHU9w+uAG4dB4SYB4HGahC/xghH7ZMLGArMczSw001XFHA1O49dIxQMo+BR4ptt5L97FTjtayf8XDJJxPgCzlrLy9d2CaWdifmYSqzJALwUUNxve7Fx22GwIWAxAU=
Received: from MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 11:16:00 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::56) by MN2PR05CA0051.outlook.office365.com
 (2603:10b6:208:236::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.10 via Frontend Transport; Fri,
 31 Jul 2026 11:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 11:16:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 06:16:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 04:15:59 -0700
Received: from [10.67.184.128] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 06:15:57 -0500
Message-ID: <b454973f-275f-4f75-8367-8b6230d42bbf@amd.com>
Date: Fri, 31 Jul 2026 19:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] migration/rdma: add x-rdma-chunk-size parameter
To: Peter Xu <peterx@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <farosas@suse.de>, <eblake@redhat.com>,
 <armbru@redhat.com>, <Emily.Deng@amd.com>, <Victor.Zhao@amd.com>,
 <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>
References: <20260330064758.2816891-1-guoqing.zhang@amd.com>
 <ampSFcrRagKtf5y_@x1.local>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <ampSFcrRagKtf5y_@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed1bb4b-7010-4c74-08ce-08deeef51a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sPvjMmtq72q6tqMkE/sRm4RglgoFjjrxSyzSawkM3Do9pb428gGBiBUZJ1jT8hUvdQ8fYsafXOGSPBIQkBoGUHjxad8r/BtEaGvEY5/Try2xXOJBscIUhPuEdFfleUAKAGigzK7TOzVhvFEsH3Vk8Ka9QtI2bpGfoXBEvtaOLwXuj6EmihV+qxQi5mliDzTAC4omcj7uVKclB8ddPUYrqeRssu16/6YXVAElBcNr330rgVDIblNk8drfIuaBc4oeVcR+fi17IcMUg9deYUm2Wr0n6IAiVscJcM4X8Afjnj4Ds1M9g95DMyGH/ly9W4dpy8ssNSkdnI+a9cCyVrWNwPbGJPAF0Sw9sAsWKwSJBGbWKKiWouN7aRD1SsE453Vq2PSEmRu9yaV+59x9qIvxS8ngo/WsXmcT3jq0DoYso/p/GSF+laFWdEQuOcH6DCrgKKP+mgkuOSEHfHWZGGmMAAjQm/AvA0adeIfq54YBQbjXqSFbqM7EpH5imJgCEzShUSjngDNnOldUDQNDg/76H8srh5alFKtsVfmhvvYj65m2vyw250M2BC/3eiMUgF3pLwAS3Ku++K4eSm42pRoC3t3njz0laX3erRPHiAE9YJ5+VLnhaPXSQtQFU4z1/Rolu9uEFdZoKjhh7kTuCrNhcR1qMEId2iymQOOQEN29druY0tsbVy3R2f2aeQUi03oWxmdK2AEvh+wLR8q0o2k/jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HiTDTNGXZJQB4n2baVRKcph8+DZECEvkOvj3BfWqCII3dUnW8R0q7pgJjxfF0qfCBeRxSMx1AEWYpGa7tdpng/pgQn495n1b+YLmr0f8du3EZ8w9+onBeaNLgnk9T6cP6eUQ0t90Taj/roz27tL8lTIobinMTU55MBZx8zLnOjuTTc0xLYAFIgashWrYYWPaD/RAXBwsp2IT7LhK3KsSF0hXKyoMOnUyuMMkVbjqQstjIEb2ygGYgOCYM+iz6nxJjtI/mnOcxnSFuvFsqmxV8JRjt6BbBojAl8awCWSjtntjymGFgYFDO9U4TMQKpU95Oyuyg+DgF8rtOZHU9ugV58rfWYkTP4VRJeIF3GeX2ZuiOpCqrqUPYIJU/mAYmEb55FmlPRY9ygLIxZpGG0OntADfii2reI9MusJ0RhL2WTB0+84hU4SxxeSxX+l9/uAL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 11:16:00.3749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed1bb4b-7010-4c74-08ce-08deeef51a06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
Received-SPF: permerror client-ip=40.93.196.31;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



Hi Peter,

Sorry for late reply. I just got the time and machine to look into this.

For current upstream code, qemu_rdma_write() len is always
TARGET_PAGE_SIZE (4KB), which is far less than the 1MB chunk size.
The mergeable check bounds current_length within a single chunk, so
current_length can never reach rdma_merge_max(). You're right that
it's dead code in this case.

I did experiment with len being 2MB and chunk size being 1MB, where
the condition does trigger: mergeable fails, current_length resets
to 0, then += 2MB, hitting rdma_merge_max() (2 * 1MB = 2MB). But
even in that case, removing this flush caused no issue, since the
buffer gets flushed on the next qemu_rdma_write() call when
mergeable fails anyway or on rdma_registration_stop() at the end.

Thanks,
Samuel


On 2026/7/30 03:18, Peter Xu wrote:
> I'm looking at some RDMA security tickets recently, and I stumbled on top
> of this chunk size problem.  Since this is very recently touched, I figured
> maybe I should ask here,
>
> On Mon, Mar 30, 2026 at 02:47:58PM +0800, Samuel Zhang wrote:
>> @@ -2176,7 +2178,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
>>       rdma->current_length += len;
>>   
>>       /* flush it if buffer is too large */
>> -    if (rdma->current_length >= RDMA_MERGE_MAX) {
>> +    if (rdma->current_length >= rdma_merge_max()) {
> [1]
>
> What is this rdma_merge_max()?  Why it's twice the chunk size, and even if
> I believe when reaching here the current_length should have been throttled
> by chunk size too?
>
>>           return qemu_rdma_write_flush(rdma, errp);
>>       }
> I mean, in qemu_rdma_buffer_mergeable():
>
>      ...
>      chunk_end = ram_chunk_end(block, rdma->current_chunk);
>      ...
>      if ((host_addr + len) > chunk_end) {
>          return false;
>      }
>
> I believe it means when len will go beyond chunk size, it'll force a flush
> already.
>
> With that, when reaching [1] above, we either should have just flushed, or
> we're under chunk size (which further guarantees smaller than
> 2*chunk_size).
>
> What did I miss?  Or, is this line [1] dead code?
>
> Thanks,
>

