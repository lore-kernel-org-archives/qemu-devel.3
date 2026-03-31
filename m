Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8356FF60FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7WUf-0004xa-PZ; Tue, 31 Mar 2026 06:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w7WUe-0004s5-0r
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:38:44 -0400
Received: from mail-westcentralusazon11013030.outbound.protection.outlook.com
 ([40.93.201.30] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w7WUb-00060U-Hg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:38:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sz3QFs2BGeYZPHA7Bb3Np3gQaNwId9VTdA2iN9AyFZVrNUQDTDLMTsYq1vWHy0oQFihc7lEWocV+hakPhiSnyiq0SnGRXU7xRuyqqF0ZHG9Vi2V5ZGZFZ+10O5T4NaXCuz9y3NbwQtRrbt3AIsUJaJS6BNHwrUy+mKicYB+aunwoxJAavgTV6NoxQzDRkoqVzJPEOyJVXbw12+pfLnsJ3Cy4/sLncX1DRP1ppibfxojrS9to0KNHY2bSWzHSvmagQrJ6/WgYBKMuRD7C44WLjyHvdHmxpgaI42l5BLmWY/yf+GqskavGfnDqx5xVn0idCyidrYPfOAr9svo1dGjB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+k8j0hfFBzCfP7TmYC2cmmNk0f0TaBpFrrICvlf9BQ=;
 b=VI3OJvTH4YTAXLOgYJfoAVzArX9Lsy/JqlgG+K88HijADaehYYI1W2jwSpP4vFbQl7/X8kJ7gaTWPmuSmEGC3BB7aNsNiUszb742LH6s0+nQujbyNSgJsiAV7taGXCjkUSnTeCR4B/s0sCcQjYfG5NFDkJVD9KWw4iM0ot3AMgbUcnGmQvuB4VoWLzroIbPQTy8qzpG1Rwzg7z8+LVA50Kq9wB2xFTqn491Ur3gdj7HaV5ajBKs761dTEH+vEThH7dpibzdx4ncp4Y1a0DT57E9WNMmYGGl5kcTvVAbbt4bZk3yXTXecWgz03J4d0NI0j5ra24mo16oLdOQGBjU+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=fujitsu.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+k8j0hfFBzCfP7TmYC2cmmNk0f0TaBpFrrICvlf9BQ=;
 b=3nzfu7mFsIuwDsXn2TBcre/CODgDKdBMPlGCxSTlSmvaLZdxPw8jBDVdc2+X5QxZMjrTewYBTTUtRPLNhn7drhiU8soBh30zijBDqAdUREQ6aXPMI1sWnEiiKnJEM1OLHxZR/M/uOpQZDaIcmbRyFIBmXrtQwWaPnSOZ9NLHA6A=
Received: from IA4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::9)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Tue, 31 Mar
 2026 10:33:32 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::fc) by IA4P221CA0006.outlook.office365.com
 (2603:10b6:208:559::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 10:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:33:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 31 Mar
 2026 05:33:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Mar
 2026 05:33:31 -0500
Received: from [10.67.184.128] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 05:33:29 -0500
Message-ID: <02a44178-eebc-4fef-a8fb-802dac76c11f@amd.com>
Date: Tue, 31 Mar 2026 18:33:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Peter Xu
 <peterx@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "Emily.Deng@amd.com"
 <Emily.Deng@amd.com>, "Victor.Zhao@amd.com" <Victor.Zhao@amd.com>,
 "PengJu.Zhou@amd.com" <PengJu.Zhou@amd.com>, "Qing.Ma@amd.com"
 <Qing.Ma@amd.com>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <acqgZShXRkqzBU1C@x1.local>
 <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <e3b261a3-25fa-42f9-a926-306e5a19cf75@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqzhan@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 478d6414-c963-4543-ce3e-08de8f10f4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tecmn7mIJIga8Z98vBuNbIl/2Vy5hlDHsUhgApvp39lZtz84R11ODqbrQkJOGH/+AAOB3lYAFnrg0GXo/CgWikXdUlJnyiWEFdm9U0LWUAWiTHEJZ8GF6i2NSvBtcHYJWOa1OJcXbsY0wlNqTYeVN6ISM4inCNATCxsuJsCY2lLoazoQ2KWLAqzfgDdVNjfNvZbiot9uGTmku5uVGxrZ9cg9XWVmnPThcInvRNGr4qooo3yt1Fe5EFMlJBE9mgbld+jiLmueSz9QJ+v1NG3Z/i1WUA+KtRrNYdUHG+DDJJNQ2VR3n3RyJM0M2zYSNa1nqYHSRtuVZg32YWZSQ3uePjTRl34R159vfRb7hBZZWRm2ph0ZD9hCmtvSHWIgGSNqVZFuk0efcMgKamR1pi4Y5EgYoK/V+60ff+L5XfFYpdwV5gMyGKVeMh0z7O+JEjgLY6Aqzjuw462RgVP8sLf51klbtn2QPQEK13+SRsLy5nRlNJaPhm4/zOPYeeO7cLg2fL0ja6SWx+jQhLypbSD5Y/ho7WXaiviWeG+LXSJxN+MBLMQY+HUmveMsXEGdmJSXhFZnQOwsIl248jgo/RpCPMYeM6aObLJ+NMHsk1PDL1SavhdxvbuCJ5bcTXTBBTeq8Wk3GPzRZo0hS+3DeVvaHOeQnzbkY1X48Unvi67lnFQx8RNojnUCY3OKFtZjLHuPgIn7pAmw6KBLGgsAMI037rETMonu/jmIFZhR/qsTmzIO3DFIZL8jY6g5gHvp1fo3nnzdYqpbIQthj8as+/yKWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kk4afOtgwRiCIostbcc0WZVSMWIglE0TBc05qspXdcB1dE3p9MQL++vw0jEJDTBtCgy9Y0IEPXPvgTsgRWePSsNTiX77HIuhyyW0Ai6c+tj8TYcv9gkg6FwXv+BOOoxchl69I7TT+hqlFMTJ8gfAd87CuUDHtpyuln4M0sN5xGjWAig1HRzKGzG1E/r0+/m7KUO3OBspCgbdbKxE9DRDUvsQ2rFOenU6luqw0hBWL3pvFzaXEiCApEP7XRvbn4uItVoZDxXjbTzfE6CU4bYro8erBmilNEnkdowjkMMmYbfJjNcl8xJhPQ7R6RAgr4jD3GvUgSp+eK7d7o9XvsFvcnk4t9pCIxDF3biQ6k4lVikbFHhOl5/PTYjH+l/mFq93qIR/aI9F4s/yWxHlCpxqoAPoAs+mQ168J+6oBCbAOCHrqgetrcBkDUJcysKHfVRt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:33:31.9444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478d6414-c963-4543-ce3e-08de8f10f4a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
Received-SPF: permerror client-ip=40.93.201.30;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 2026/3/31 11:30, Zhijian Li (Fujitsu) wrote:
> [Some people who received this message don't often get email from lizhijian@fujitsu.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On 31/03/2026 00:10, Peter Xu wrote:
>> Hi, Samuel,
>>
>> On Fri, Mar 27, 2026 at 02:50:06PM +0800, Samuel Zhang wrote:
>>> The default 1MB RDMA chunk size causes slow live migration because
>>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>>> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
>>>
>>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>>> faster migration.
>>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>>
>>> Performance with RDMA live migration of 8GB RAM VM:
>>>
>>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>>> |-----------------------|----------|-------------------|
>>> | 1M (default)          | 37.915   |  1,007            |
>> This is the default. It surprised me a bit knowing it can only reach 1GB/s
>> throughput with the current code base.  Do you know why?  I thought RDMA
>> should be much faster than this on throughput with whatever hardware setup.
>
> Regarding the baseline performance, Samuel's numbers look reasonable. I checked
> some of my old test data on a ConnectX-4 Lx card years ago, and the throughput
> was around 10 Gbps (~1.25 GB/s), which is consistent with the 1 GB/s he reported.
>
>>> | 32M                   | 17.880   |  2,260            |
>>> | 1024M                 |  4.368   | 17,529            |
> My guess for the dramatic performance improvement is that a larger chunk size
> allows qemu_rdma_write() to batch more *contiguous dirty pages* into a single,
> more efficient RDMA send operation.

The `throughput` data is collected from `info migrate` qemu monitor 
command after live-migration.

Yes, Zhijian is right. As each chunk triggers a write_flush and each 
flush involves posting an RDMA WRITE and WAITING for completion, there's 
software overhead here.

For 8GB RAM VM migration, 1MB chunk size produces ~15000 flushes. The 
software overhead adds up and prevents the RDMA hardware from sustaining 
high throughput.

When chunk size is 1GB, there are ~3700 flushes. Reduced flush count 
means reduced software overhead and improved overall throughput.



>
> Is there any workloads running on the guest during the migration, or just an idle guest? @Samuel


The guest is idle when I test the migration and collect the data.


>
> Given the significant benefit and the fact that the patch itself is straightforward,
> I think it's a worthwhile addition.
>
> Acked-by: Li Zhijian <lizhijian@fujitsu.com>


Thank you for the ack, Zhijian!


>
>
>
>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> One thing to mention is RDMA migration is in odd-fixes stage, actually it
>> doesn't have a real maintainer so it is kind of "orphaned".  In this case,
>> I actually won't suggest we add any new knobs for performance reasons.
>>
>> Do you have a strong reason to propose this patch to land upstream?  Is it
>> used in production systems and it solves some real problems for you?


We have VMs with large RAM and find TCP live-migration is not fast 
enough and expect RDMA migration can be faster.

But we found the rdma mode migration speed is slower than tcp mode. See 
following data.


8GB RAM idle VM live-migration performance:
| transport mode       | time (s) | throughput (MB/s) |
|----------------------|----------|-------------------|
| TCP                  | 36.89    |  1,081            |
| RDMA, 1MB chunk size | 37.915   |  1,007            |
| RDMA, 1GB chunk size |  4.368   | 17,529            |

This patch allows us to use larger chunk size for faster RDMA migration.


Regards
Sam


>>
>> I also wonder what Zhijian would say on this.
>>
>> Thanks,
>>

