Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCA4D1D897
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4cl-0006XY-BH; Thu, 04 Dec 2025 03:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vR4c5-0006DG-QO
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:22:57 -0500
Received: from mail-westusazon11012019.outbound.protection.outlook.com
 ([52.101.43.19] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vR4c1-000811-IK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:22:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpKmDpLCcNl1z1S2Xa2ggRHMR+jeAP8lVlwKkSb8rNagOMAxI6BhOKxl4bgkAMi9uJOBrIzx2XTPt1xpHT4D+LPx71m79xhR+31Fp71Z52luCyn6dlGj+3xNzBSU//vGQAK+RtjURvSF+xRMUuIkL3Eg8ca7h67F5z7odOPKxijVEyQqboxxMBWdM9YQNRbv43i8m4Dxoh/MBlD5mTNdUYaSc4kEM6CBzLqZGgtuErRozZBNKiMTcsl7+THHMtEn4EWm5uX47A6SVYHJhIggAiXR1kEBf3Iq8mt/RQWaupXj9kuTHe08T+nAuCMDLvifro9tFOCGkI2EXzSzXMvnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLIEvcBNy9fXihwePpdlJW4Irb1bfuEdYmnWE7QexnU=;
 b=dyK+eEhfss2FAufSacD1ONMDXiLIxEJU5RqGnI/99EOeUvV1dLNytAvas9xk4TvAD9rGlItsnfDnAWnGvrKFoi3dHyTCerF/mqZ/vF60HqZ0HbWI6WWTJQSC5wUiUPZ21wOicEkJ34vnMXVmvo7q7+C9FXr+cqOnPaKVyR2Izny8d4BmvA4WF2UB5nFvoDBdNKKRLINcCpiP640IM+koFyne6SAontaD2sIibt9csGnJdNQcgUk9tvSso65TOFGvglRaVZWjrSdL9MdjyzTquKDCU0S8UD15jSeuXTJrN6DjWMfLvtEw5InIqKmtBovtcqot2lGbUyq1h8guzHWuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLIEvcBNy9fXihwePpdlJW4Irb1bfuEdYmnWE7QexnU=;
 b=TCOliFP4VSoNwLbC6cgSSuk+uuvc/v9uXaJG0M7LMxlrevvtHynyWAkii/iYnOB7HerIGuXROwE7YXl2OfLgNyZptzOYefQi1S8xaVFRD8+wCG7PV8+Ec6ZXkiDTetDYaHcuwmwB9FfilymfQU6iXCpjMgv+wIUgaOENioF52wE=
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by CH1PR12MB9696.namprd12.prod.outlook.com (2603:10b6:610:2b0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:17:45 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::1c) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 08:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 08:17:44 +0000
Received: from [10.85.41.183] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 02:17:42 -0600
Message-ID: <e564e548-0958-42b0-8c47-29d8c936ad16@amd.com>
Date: Thu, 4 Dec 2025 13:47:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] amd_iommu: Generate XT interrupts when xt support is
 enabled
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 <qemu-devel@nongnu.org>, Vasant Hegde <vasant.hegde@amd.com>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <naveerao@amd.com>
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-4-sarunkod@amd.com>
 <9bc52a98-972a-4376-aec6-69e438971801@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <9bc52a98-972a-4376-aec6-69e438971801@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH1PR12MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: a27a7a90-f744-456b-629a-08de330d9a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|30052699003|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkYrL1E1Ymw0bnlBZGJxZ3ZTREJMZmtiTitkNHkxTk9JMEZDNlhRbHBOY2Na?=
 =?utf-8?B?L0tlVncvanJJWWw3QXd4UTI0N3dJT2lNR05RWlhnaHIxZjhnWlFycjlkcmJC?=
 =?utf-8?B?b2ZWRU9CNkcrbFUxSXdUWG9XWEJFM2NWanNiYVlNZ3BXTGdjcjdqK2xFbTRU?=
 =?utf-8?B?M2VpZmZrU09LYm01eFg2TDB4R2JuTWtUL2Q1ODRzWXBKVTd3eXFtZW1wNU5t?=
 =?utf-8?B?L0s0K2xRV0RORVU5UitVdllhTDQ3eGozOEorUFppOEVwWGppTlp6dVhlUVdS?=
 =?utf-8?B?Y2JMMzFLeE04SjFLK3A2UWJlbmdpek9XTEl5S1ZoeGVRdXVuOG1BTUFuNFRz?=
 =?utf-8?B?cjFHUSsyUVBhY0h2TlJNZTBsUVdSRFN1QzlqVmp3YkZWcG5EODFwRS9IR295?=
 =?utf-8?B?Ulc2RTAxdXRVdUx0Y0twYXJjc2I1UE5RcjYvUVpVZ0phYTdRcDlDN2h0cmlL?=
 =?utf-8?B?RThBS0dEOGl4amxyM0J1Slo3d0NUQ2NIMVJiZUxJWEE0MCtSSG1ZUWJVYkE3?=
 =?utf-8?B?ck9aRzFCQ0huTkdBR01zUjUwdlhTbHpvbjRDQXd1WmI4ODV1K0ZySEpoZkhH?=
 =?utf-8?B?KzdGNlRDMmJ5c3V0cWgzdmFlbUVSRk51OEswajJDV2VCRnhBUTZHRFgxd01m?=
 =?utf-8?B?bkF2MmZiME5WRlJzZEVCcXBsa0x6NExCMU9neDIxamtKaFJZdGh6VXMveHlJ?=
 =?utf-8?B?eTRQNGpZa01obk51WUh6K3F3RHJuZGFONnhid0dsayszcjh5NlpLQXBjUW13?=
 =?utf-8?B?V3JxbVRqTTBWT25GZGNFMXRKUkU5a3pzYlU5bW11L0FzTUZRMENkRWxmb01u?=
 =?utf-8?B?bmtyUUdGVmdXSDBlYTJ4ODJmT1ZRTnlTNm9nVHBGZ0t6Mis0MzVWeGFvQUdK?=
 =?utf-8?B?Z3U3Zi9DZ25GYXFKQkpWdmIyd3VHbzZ6ZlZpdlFSVGdYcTBXZGJCSFEySG4r?=
 =?utf-8?B?bTdaWG13TGFoM1phTndSWGJHMi9hMGV1WWJlUkFGanBLMGI4bkYzOTVhWnQ3?=
 =?utf-8?B?ZzByOXc3dkZLaXI3S3RmV1NEKy8rbGEyWFR4cU8veGpYZ0tTZ0tPRTdiL3Ra?=
 =?utf-8?B?ZGxMR1NiY3pqbnpoNEVkT2EwRUQ3R3dtSEhWZHg0R0paNEFnL01iWVFoTEpE?=
 =?utf-8?B?alNBektnMnRIYkdOMUVhOFJaY1liQk9yc1lyZXZYV1NDcmFySENnQWxvd3Rm?=
 =?utf-8?B?K1VscDJWeG9lU1V6K3VFWXpTb1dsQWdiVW12YmlpWUs2YlV0bk5rNTlJMUFo?=
 =?utf-8?B?SjBsZW00ME1XdE41N3lmYmdoNkZmNVRaSVpSeldYUUxhNEZ4Qkk3YlMzRnBO?=
 =?utf-8?B?VTZsdkdEbjd5MjJCc1dqOUlZc1RTbW5neWdYYlNBelMwMDhPKzZ4Q2RuN3k1?=
 =?utf-8?B?VWMza1RhZkhYcmZxd29jc2poSDdyL2JObjhsS0d3ejlXTmU1NlFLS1E4ZlM5?=
 =?utf-8?B?MHlWcmtuLysyQWVOdHk5VmZuMEpHVmdtU3JFWWY2NnBPUDlDTEQ0eW5Ldys5?=
 =?utf-8?B?WFpqYjlZUUkvbWZWVVZtditOS0JMdk14ZHcxS3JEUDF2dHhoUHJFV0Y5VW50?=
 =?utf-8?B?T1Q2bkhhS0RCYUR6czVCb2c4Q2NJQW9KZ1cvM1NJMXNGNXhoRHdBVzU2ZVNz?=
 =?utf-8?B?UUp0YVBwdXBFZlE4Y2NrellHVFgwMW1ZN3JBcHMwMzBGMng2ZE5mOTN6QWl3?=
 =?utf-8?B?ZDhTSUppdW13Q05RTDg4RWNFc2hDZ25XUFN3UG04RmM1QmpybHNieDlVUjdX?=
 =?utf-8?B?aGJRZmlTeFVXS053Yk14QmdZREF4ZVJYZ0NCbEZUZE5sM2d3Rmdob3l2Wk5P?=
 =?utf-8?B?RC9sRngzbVF5RzFsRVdJTVBWcnU0dmJKS3prS2RqMXpVakdkYVpQQnRUUWF0?=
 =?utf-8?B?WjdKdGRuMU9lZk1Ib2dWTjlKZWRjbFo5cThSZ0F1UVMydmdlQUtFVFFZL1BZ?=
 =?utf-8?B?ZkhucnA5ODBqRmc5eGRLdVpLTzM2REoycVVyd25WcDRiWWQxUTltdWY4cm41?=
 =?utf-8?B?bWE0cldHRkE3clZSd2VXV0JGcTlsaEtGakQyT1dlS3VIRmFUQlFONkk4OWdV?=
 =?utf-8?B?U2xrckU5WFk3akpQREZXQklHMEdzejlmL05NMWZNV0g5T2F1YVoxRXU3YmFH?=
 =?utf-8?Q?E0/E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(30052699003)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:17:44.8652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27a7a90-f744-456b-629a-08de330d9a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9696
Received-SPF: permerror client-ip=52.101.43.19;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 12/3/2025 11:39 PM, Alejandro Jimenez wrote:

Hi alejandro,

> Hi Sairaj,
>
> On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
>> AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts
>> when guest enables xt support through control register [IntCapXTEn]. The
>
> "the interrupts" is a bit vague, considering that it is only a 
> specific type of interrupts that originate from the IOMMU itself.
> I think the quote from the spec is pretty clear and we might want to 
> use just that:
>
> "
> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU 
> itself are sent based on the programming in XT IOMMU Interrupt Control 
> Registers in MMIO 0x170-0x180 instead of the programming in the 
> IOMMU's MSI capability registers.
> "
>
> I'd prefer if this was documented in the code comments, but I would go 
> a step further and mention the specific interrupts, e.g.:
>
> The mapping to MMIO offsets and interrupts controlled by each is as 
> follows:
>
> XT IOMMU General Interrupt Control Register (0x170): Event Log 
> exception interrupts and Completion wait interrupts
>
> XT IOMMU PPR Interrupt Control Register (0x178): PPR Log exception 
> interrupts
>
> XT IOMMU GA Log Interrupt Control Register (0x180): GA Log exception 
> interrupts (irrelevant in vIOMMU case)
>
>

I think we can avoid mentioning other two registers (PPR and GAlog) as 
we do not plan to support these
features as of now.

>> guest programs these registers with appropriate vector and destination
>> ID instead of writing to PCI MSI capability.
>>
>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>> MSI capability and does not care about xt mode. Because of this AMD
>> vIOMMU cannot generate event log interrupts when the guest has enabled
>> xt mode.
>>
>
> At first I thought that statement was not correct. If that were the 
> case, I was wondering why we don't currently have issues with 
> Completion Wait, since they are also controlled by MMIO 0x170 offset. 
> But the Linux driver doesn't rely on the completion interrupt AFAICT, 
> it just sets the completion store bit and monitors the semaphore to 
> detect the completion. We might not be so lucky with other OSs, so 
> good catch.
>

Maybe this patch qualifies for the fixes tag ?

>> Introduce a new flag "intcapxten" which is set when guest writes control
>
> And similarly to the xten case in PATCH 2, we also need to migrate 
> this new field. It can be added to the your proposed vmstate_xt.

Right

>
>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>> the XT MMIO register (0x170) to support XT mode.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c  | 51 ++++++++++++++++++++++++++++++++++++++------
>>   hw/i386/amd_iommu.h  |  3 +++
>>   hw/i386/trace-events |  1 +
>>   3 files changed, 49 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 7f08fc31111a..c6bc13c93679 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -200,18 +200,52 @@ static void amdvi_assign_andq(AMDVIState *s, 
>> hwaddr addr, uint64_t val)
>>      amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
>>   }
>>   +union mmio_xt_intr {
>> +    uint64_t val;
>> +    struct {
>> +        uint64_t rsvd_1:2,
>> +                 destination_mode:1,
>> +                 rsvd_2:5,
>> +                 destination_lo:24,
>> +                 vector:8,
>> +                 delivery_mode:1,
>> +                 rsvd_3:15,
>> +                 destination_hi:8;
>> +    };
>> +};
>
> We should define this union mmio_xt_intr in amd_iommu.h header, right 
> after struct irte_ga.
>

Right.

>> +
>> +static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
>> +{
>> +    union mmio_xt_intr xt_reg;
>> +    struct X86IOMMUIrq irq;
>> +
>> +    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
>> +
>> +    irq.vector = xt_reg.vector;
>> +    irq.delivery_mode = xt_reg.delivery_mode;
>> +    irq.dest_mode = xt_reg.destination_mode;
>> +    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
>> +    irq.trigger_mode = 0;
>> +    irq.redir_hint = 0;
>> +
>
> Based on my reading from the MSI details, hardcoding redir_hint=0 
> results in the dest_mode field essentially being a nop, since the 
> messages will be delivered in physical mode i.e. only to the APIC ID 
> in the dest field.
>
> From Intel's SDM Vol3, 12.11.1 Message Address Register Format:
>
> • If RH is 0, then the DM bit is ignored and the message is sent ahead 
> independent of whether the physical or logical destination mode is used.
>

This statement sounds ambiguious. My understanding is that the RH field 
is used to determine
the "lowest priority processor" among all possible cpus that can receive 
the interrupt. This means
that in case of physical destination mode, it should forward the 
interrupt to the cpu with matching
destination mode but in case of logical destination mode it should 
forward the interrupt to the
cpu with lowest priority.

I confirmed this by looking at kernel KVM function --> 
kvm_irq_delivery_to_apic(). So I think the
what SDM is trying to tell by "DM bit is ignored is that" is that it 
will not try to find the cpu
with lowest priority interrupt but rather forward it to the APIC 
hardware directly (i.e. to all the
logical processors in case of logical destination mode).

So we don't need to add a error report here.

> I am not sure if the current implementations of AMD IOMMU drivers ever 
> use the logical mode, but I am thinking we should at least catch that 
> case with a warning e.g.
> if (xt_reg.destination_mode) {
>     error_report_once(...
> }
>
> A follow up question, since you chose to explicitly set redir_hint to 
> 0, and something that bothers me about the remap functions is that 
> they set:
>
> irq->redir_hint = irte.lo.fields_remap.rq_eoi;
>
> where AFAICT, redir_hint and rq_eoi are semantically different and 
> control unrelated behaviors. So I've been wondering why these 
> assignments are done. No need to answer this specifically, but if you 
> have a better understanding of it please let me know.
>

Currently I don't  have idea about this. The specification does not 
provide any relation between
rq_eoi and redir_hint.


>
>> + x86_iommu_irq_to_msi_message(&irq, msg);
>> +}
>> +
>>   static void amdvi_generate_msi_interrupt(AMDVIState *s)
>>   {
>>       MSIMessage msg = {};
>> -    MemTxAttrs attrs = {
>> -        .requester_id = pci_requester_id(&s->pci->dev)
>> -    };
>>   -    if (msi_enabled(&s->pci->dev)) {
>> +    if (s->intcapxten) {
>> +        trace_amdvi_generate_msi_interrupt("XT GEN");
>> +        amdvi_build_xt_msi_msg(s, &msg);
>> +    } else if (msi_enabled(&s->pci->dev)) {
>> +        trace_amdvi_generate_msi_interrupt("MSI");
>>           msg = msi_get_message(&s->pci->dev, 0);
>> -        address_space_stl_le(&address_space_memory, msg.address, 
>> msg.data,
>> -                             attrs, NULL);
>> +    } else {
>> +        trace_amdvi_generate_msi_interrupt("NO MSI");
>> +        return;
>>       }
>> +    apic_get_class(NULL)->send_msi(&msg);
>
> This is great. The method of writing to the address space directly 
> still confuses me, using the APIC helper for MSI delivery seems to be 
> the appropriate way.
>
>>   }
>>     static uint32_t get_next_eventlog_entry(AMDVIState *s)
>> @@ -1490,6 +1524,7 @@ static inline void amdvi_mmio_get_name(hwaddr 
>> addr,
>>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
>>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
>>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR, name)
>>       default:
>>           name = "UNHANDLED";
>>       }
>> @@ -1549,6 +1584,7 @@ static void 
>> amdvi_handle_control_write(AMDVIState *s)
>>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>>       s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
>> +    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && 
>> s->xtsup;
> I think that s->intcapxten should check for s->xten instead of 
> s->xtsup, that way we create only one dependency on the input 
> parameter, and the rest flows logically from what the guest driver 
> configures.

I did think about it quite a bit, the specs does not provide any dependency
between intcapxten and xtsup, that's why I avoided.

>
> On that topic (I should have mentioned this on patch 2), I think that 
> it might be reasonable to make s->xten also conditional on whether 
> s->ga_enabled is true. The spec just says they should both be set:
>
> "In systems with x2APIC enabled, software must set MMIO 0x18[XTEn]=1 
> and MMIO 0x18[GAEn]=1.This enables the use of the 128-bit IRTE format 
> with 32-bit destination field. Even if Guest Virtual APIC
> will not be used, software must set MMIO 0x18[GAEn]=1.
> "
>
> my understanding is that we can't support X2APIC mode without 128-bit 
> IRTE format (which is controlled by ga_enabled), so it makes sense to 
> block X2APIC (i.e. xten) unless ga_enabled is already set.

Yep I agree with this one, we can enforce ga_enabled but then we cannot 
have

  s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xten;

because it'll create a dependency between s->intcapxten and s->ga_enabled


>
> So in the end we'd have something like:
>
> s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
> s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) &&
>       s->xtsup && s->ga_enabled;  // this should go in PATCH 2
> s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xten;
>
> What do you think?
>

PS: just a small formatting suggestion: Please keep the charater per 
line within
~72 so that its easier to read on the email client

Thanks
Sairaj

