Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98122C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udo5w-0002Cr-Ro; Mon, 21 Jul 2025 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1udo5F-0001oA-7n
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:49:30 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com
 ([40.107.237.57] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1udo5A-0001rF-Ev
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tygBvWV8NlI4wcvYno5dh+kQ7BHxPcoDXT+BjCrxdUjo3L4VZmmAIc3BGY8dY2OC3vlQP9JnVve4V4DfcXLjtTpo+nYHwRURUcOoAzHl953VSXr4j6DGHNjBEVPtV9urrPxaHtB4kaLe0ODwsa5NlNHNojkwlgBwBHOyMfcVaCT+Hx5sw63kOUyWACEr87bSO+PrYLuTWpqcWHHsmgxAVvN2xkVU/r0k12SF8vpmxqzdic0GCTEE5wa8vtRLFTL15CuJ0iWpZ4CKcrIhuv9Mi9qIu3JEuTRZbmlDHiO7wt3ufNnZ1siR7inZv/Vy5WjpXOFD3seNsr8lwcJTHScaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBnnrPWU7gMJgLw7wfCpLPvhj8K5NunQt6NlNnE19+Y=;
 b=CsdSYrDrpBySLaWbavfJhtf7BJHInIhaAJG6ltlgeEarvHmTLoV0/zZH0Pmhd4z35aJfy1ogW1NBj3g7QmkInMu2U+4L/Ydal5JHgby6iFsvf3E1aCH3c/01lKH3VKl74DRs00Vn4rGiYseG5FUKDd0vgqhzjvLBFYKeFdln1h20wrAWEC3G1GpMesmm1/uTglCZusU1o3iLqui3wQmx8D97RbRPa66vy5eoQ6hACz2i76jkYLLH2metxfjqcV/m4ftwktZmGHvnoV5zmWG5/L2QObbEKlTjBkbdxZgBd2wf/BE1PdQI+zcsCr9fYXAquuv5mzc3ztA7VEq6b0SwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eviden.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBnnrPWU7gMJgLw7wfCpLPvhj8K5NunQt6NlNnE19+Y=;
 b=fjsUIEmsPRbz4lx5iZjgIhu0Gkb0ymGDNg+baK8USuFINaaQC1ctOztUGo3QxoqnL3Kw+tGbuzZF5E4VE+v/4LDNquru8qfvdjJeOm2KVaSgYP1pQpy+7VfdMmDBebDYIGW2skMYaJlZrCIbTuwm4keyzWr39U3acmtBlZtDaio=
Received: from CH2PR18CA0033.namprd18.prod.outlook.com (2603:10b6:610:55::13)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 10:44:13 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:610:55:cafe::52) by CH2PR18CA0033.outlook.office365.com
 (2603:10b6:610:55::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Mon,
 21 Jul 2025 10:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 10:44:13 +0000
Received: from [10.85.47.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 05:44:10 -0500
Message-ID: <1636d30f-5362-4901-8c74-0ce8e461d215@amd.com>
Date: Mon, 21 Jul 2025 16:14:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/i386/amd_iommu: Fix event log generation
To: Ethan MILON <ethan.milon@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alejandro.j.jimenez@oracle.com"
 <alejandro.j.jimenez@oracle.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250716073145.915-1-sarunkod@amd.com>
 <20250716073145.915-6-sarunkod@amd.com>
 <82390341-1f20-4154-bff5-2e56b555a934@eviden.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <82390341-1f20-4154-bff5-2e56b555a934@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: afb529f3-573e-42f5-48de-08ddc843885d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0xOdTJmNGxYV2lVNTVnaXBaajlPVTJOOHpvV1dWQmtRTUFPcGtMUlFHdHZY?=
 =?utf-8?B?SGFIdjVLTlBQTWZ0OENaaXVnY0U3c0x6dVk3eGJLdmYrZlZ3V0c4TEtVYXlI?=
 =?utf-8?B?UVhXbWtoeURMUXBCN2M3elJ2VHdYbExaNW82blBnQndsV0NuRFV4OXY4bjNR?=
 =?utf-8?B?SUgyV2UrVmFxUkh5OHRSMk4zZnhSNHFrcWVBL0wyVHNiOWt4aHBjT1hhZ1pz?=
 =?utf-8?B?dkJ2V3BDaUM3eXM3ZlBSeUQ1OGpEZTN6UDUrZDQvS0E5L1FiTmkrOXovSWI2?=
 =?utf-8?B?WTR3TW15UzdBbmpGVlNzMnU4UXRrRFlVcnF6aVZxUTZ1MTh2VXByWUhuSEov?=
 =?utf-8?B?eitZSUFpbm90enVhNGw2dWRVODRHMXdOYWRhUWd2dGxwZDZBSkJjSVNyL1VQ?=
 =?utf-8?B?MlRnbVZiL05rQUdMdmx6VW5JRnBnWXV6TjJFcTlQdFpBNlEzWjV6QU0va0VS?=
 =?utf-8?B?SXFIOFF0WUloRklkalFHdERzVjFoK1gzTUdIVHYzNlJFM0NJa1pTQldLWExN?=
 =?utf-8?B?UmR4VG90MDkwWnFKS2ZqTlAxSEx1bWFySGszQlBiay85b0FneXVVM1cxUnhF?=
 =?utf-8?B?c09kVDFGLzlQdC90NVJ4STVrR2svdTh6RFNWOW9EWFVjVzk3aVVpdUdtVlVo?=
 =?utf-8?B?V25IRFlDc2Q1VjZHdTFQWHVLS0d1ZjY0NVhYbnJacmZTalFIS3FCSGEzOEJq?=
 =?utf-8?B?ejYyeTZ0RTRxaUJSZFhLTlJkNWFqc3RaN1ZramphYWFuZkYzUjJqSlg1OW56?=
 =?utf-8?B?Rjh6Q3l5aHhGN2NlUVU3cndialhVaEh6am5kMHEzZFdyZE1TWHR4NU5QUUUr?=
 =?utf-8?B?cXF6UUE1R1VHQzh2cGxUTThRK2tjam56cmVLUS8zMzI4Z015eW8vUHBBWUdD?=
 =?utf-8?B?cWNJQTNCOCtiTDVjd2N3SllIZXpYdFEwM3BpejhOUW8zclJyNUlIWWp4YXk3?=
 =?utf-8?B?M3loS2VMNnNrU0RVblc2UnlsQnRQcGt1OWpFSGVIdFNrclNkZ2FSZnl1L0ZY?=
 =?utf-8?B?ZTRIbXFzVW9XbEdISmovK3hmZkk5emh2eG9kUWxTalJiRjBnckpvaUsxU20x?=
 =?utf-8?B?TjM2ZnJyZmxoWEp5MU5MOTlnSStYUS90OVlMTDJDVXpGQWZldkdUUlJZYWdO?=
 =?utf-8?B?WmlHbnc2TEFUMlNjR0xHV2FCQTdxcDgveThsdFJleGU5S2tJa1p6ekxBK2pR?=
 =?utf-8?B?MzBFdkFRWGdrSFpaSVNDVTJJZmlycHNsY2dDdVk3UDlielVXb0lLWkRpOUlE?=
 =?utf-8?B?djRGYURoOHhlVDBsbnFXNDFzUjdTbWNVdC82WnZHVVRFRytRY2ZxcThMT2Ji?=
 =?utf-8?B?bTVHV3FySGZtNlNyNllEalo0em9RbjQ1YXA5bjM2Ym5FWjBYWlFDREljYUs2?=
 =?utf-8?B?VmhOQ091Z3dINk9IWGUvOHY3YjFpMFNkK0ZRNWJpaWRiMDBLQm0vbnU5RWdv?=
 =?utf-8?B?MkdTdjB4SXQzY3ZVbCtBWE5Na2pTTm4wejBZVUFHVExIU21Ib09reERWd003?=
 =?utf-8?B?L25jbkwvVnNSM1dlUmdRQlc2TUM4NmhndVZYS1VVSlFCL3lFWjNZeEtKYWRS?=
 =?utf-8?B?UEVFUVZKSFhKZFcvVzdWUTlJemJYbnAwTTNUdFJXRUwyVllqUnVDTGtLdlMy?=
 =?utf-8?B?Rk1xaDA5bXl6R25uVzEwQ2pKSXJYS1NOZ1YzNXBPWHNRY0hjR1YzSklEdUFy?=
 =?utf-8?B?eVRtOFhsa2VSYk1NR0VvSDAvTDZ0QUs0akdCaE1xSWh2Ykk1RHgwRDVrR01M?=
 =?utf-8?B?TXBxWlZ0dHNuMGNoRVE3Sk8zN0EvbDdiVklsUEtnUFFYVHUxdUxQVzlMa1dL?=
 =?utf-8?B?UStyNmc0NDN3S3NuWGpRaWY1dVBtUTczdnVxbGpjRFQraE9wSmFTdDhTcFY3?=
 =?utf-8?B?cFExRnhoUGZDblF5ZW8yYTNwd3hjVXlmTmNEQ2VHZDZpMUdzWUtYRjFnWElM?=
 =?utf-8?B?cDB0K3U5eVQvRlltekJSOEFQWVJUV1g2eklBRTZwYVB4S0JzUXNYekdFMERy?=
 =?utf-8?B?UFdNM0NpN3FDK2pDR2JjT1lDTUJIdzVONmJxRFBYeWFVUjY2Mzhjc09sa2Qz?=
 =?utf-8?Q?gCKZxm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 10:44:13.1868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb529f3-573e-42f5-48de-08ddc843885d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
Received-SPF: permerror client-ip=40.107.237.57;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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



On 7/16/2025 8:20 PM, Ethan MILON wrote:
> On 7/16/25 09:31, Sairaj Kodilkar wrote:
>> Current event logging code is broken, because of following issues
>>
>> 1. The code uses '|' instead of '&' to test the bit field, which causes
>>     vIOMMU to generate overflow interrupt for every log entry.
>> 2. Code does not update the eventlog tail MMIO register after adding an
>>     entry to the buffer, because of which guest cannot process new
>>     entries (as head == tail means buffer is empty).
>> 3. Compares eventlog tail (which is byte offset in the buffer) to
>>     eventlog length (which is number of maximum entries in the buffer).
>>     This causes vIOMMU to generate only fix number of event logs, after
>>     which it keeps on generating overflow interrupts, without
>>     actually resetting the log buffer.
>> 4. Updates ComWaitInt instead of EventLogInt bitfield in Status
>>     register. Guest checks this field to see if there are new event log
>>     entries in the buffer.
> 
> You missed one issue, the head and tail should be reset when updating
> the base pointer.
> 
> @@ -707,6 +711,10 @@ static inline void amdvi_handle_evtbase_write(AMDVIState *s)
>       s->evtlog = val & AMDVI_MMIO_EVTLOG_BASE_MASK;
>       s->evtlog_len = 1UL << (amdvi_readq(s, AMDVI_MMIO_EVTLOG_SIZE_BYTE)
>                       & AMDVI_MMIO_EVTLOG_SIZE_MASK);
> +    /* clear tail and head pointer to 0 when event base is updated */
> +    s->evtlog_tail = s->evtlog_head = 0;
> +    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
> +    amdvi_writeq_raw(s, AMDVI_MMIO_EVENT_HEAD, s->evtlog_head);
>   }

Hi Ethan

Thanks for pointing this out. Will update it !

> 
>   static inline void amdvi_handle_evttail_write(AMDVIState *s)
> 
> Moreover in the spec at 2.5.1 Event Log Restart Procedure, it is
> written "The IOMMU event logging is disabled after system reset
> and when the event log overflows."
> Should we implement this behavior or the overflow flag is enough ?
> 

I think overflow flag is enough, Because code discards the new entries
when the buffer overflows (which is equivalent to event logging being
disabled).

>>
>> Fix above issues, so that guest can process event log entries.
>>
>> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 20 ++++++++++++++++----
>>   hw/i386/amd_iommu.h |  1 +
>>   2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index e0f4220b8f25..a34062153194 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -172,7 +172,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
>>   /* OR a 64-bit register with a 64-bit value */
> 
> s/OR/AND
>

Ack.

>>   static bool amdvi_test_mask(AMDVIState *s, hwaddr addr, uint64_t val)
>>   {
>> -    return amdvi_readq(s, addr) | val;
>> +    return amdvi_readq(s, addr) & val;
>>   }
>>
>>   /* OR a 64-bit register with a 64-bit value storing result in the register */
>> @@ -201,16 +201,26 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
>>       }
>>   }
>>
>> +static uint32_t get_next_eventlog_entry(AMDVIState *s)
>> +{
>> +    uint32_t evtlog_size = s->evtlog_len * AMDVI_EVENT_LEN;
>> +    return (s->evtlog_tail + AMDVI_EVENT_LEN) % evtlog_size;
>> +}
>> +
>>   static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
>>   {
>> +    uint32_t evtlog_tail_next;
>> +
>>       /* event logging not enabled */
>>       if (!s->evtlog_enabled || amdvi_test_mask(s, AMDVI_MMIO_STATUS,
>>           AMDVI_MMIO_STATUS_EVT_OVF)) {
>>           return;
>>       }
>>
>> +    evtlog_tail_next = get_next_eventlog_entry(s);
>> +
>>       /* event log buffer full */
>> -    if (s->evtlog_tail >= s->evtlog_len) {
>> +    if (evtlog_tail_next == s->evtlog_head) {
>>           amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVT_OVF);
>>           /* generate interrupt */
>>           amdvi_generate_msi_interrupt(s);
>> @@ -222,8 +232,10 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
>>           trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
>>       }
>>
>> -    s->evtlog_tail += AMDVI_EVENT_LEN;
>> -    amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_COMP_INT);
>> +    s->evtlog_tail = evtlog_tail_next;
>> +    amdvi_writeq(s, AMDVI_MMIO_EVENT_TAIL, s->evtlog_tail);
>> +
>> +    amdvi_assign_orq(s, AMDVI_MMIO_STATUS, AMDVI_MMIO_STATUS_EVENT_INT);
>>       amdvi_generate_msi_interrupt(s);
> 
> We should take into account the s->evtlog_intr flag before generating
> the interrupt.
> 
> And I think we could refactor amdvi_assign_orq inside
> amdvi_generate_msi_interrupt, so we could do:
> amdvi_generate_msi_interrupt(s, AMDVI_MMIO_STATUS_EVENT_INT); for
> example.
> 

yes we should do definitely do that ! Thanks for pointing it out.
Also I don't want to change 'amdvi_generate_msi_interrupt()' as it is
being used for few other things in future cleanup patches.

But what I can do it add a check in `amdvi_log_event()`.

Thanks
Sairaj
> Thanks,
> Ethan
> 
>>   }
>>
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 62641b779ca3..3dd4e7e3e8b8 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -111,6 +111,7 @@
>>   #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
>>   #define AMDVI_MMIO_STATUS_EVT_RUN     (1 << 3)
>>   #define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
>> +#define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
>>   #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
>>
>>   #define AMDVI_CMDBUF_ID_BYTE              0x07
>> --
>> 2.34.1
>>
>>


