Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E20CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEV0e-0002oI-HO; Wed, 07 Oct 2026 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xEV0O-0002lA-Up
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:00:37 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xEV0M-0000eh-Te
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYMCeVSW8UsDJB3T0up+ciH54VYUMsytkRpRhyfTgCisdSOSVQU8LxZBd5Ty8lKYQkHfOTdm1yXqSZX6wjgB12LY9/FFtQIeJasS5/rRJ6RHN1Ggvtn87o/xtcbr+DpW5zwGGD9kf3BOxnyfMG0bY1rzLd5jcNspA2l58b6qR3dvp2UprmMIVwy/Qw6yl7OgJlQkdw/6TAKk7QZdeawicK/eOcwjo2aaiEe53l66NgIkqCB5o8Lrbea2rE+jFjYMoeYtQRuSc67NZD5EXwrjDIguBdwtQnzYrF81ay4SxLy+NDr7PQupa0UL5qtutKzwRnlC3Dl5NHzioTem4ytAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON9FWYqsfw5epgpkT23px1SkKQYAkW5dUs/PSbNWTSI=;
 b=IbA2onYv07j5VEhou9Dj8M4sbIvA1yQL5TNh+V/HR63H2EzvBY4q1/8UFzogKuNevzCaOFbifu3L8N4WC+gp3ksv8zVO6yr0JuCDMWplvn6wTpuPIcMnUUvduSC0FFbm8rn7yWINt1vi6XUV6yLMegmzotMFjlmcSmtFqBDZrzxdk3nfwCwL0BCKLNUGfhvG2CHlqoSOs1JEeKzUa16PKlLHI5u6qBvhMfI00TQknDvoVM4rQnWZ2ODEut5RNkqfpDejon4Hh9UgGLWsoo0QCk7Cs3ljAwxpOdM5Zr10fMjM52nXgHCl3yhS1pkRZvEVtC71HdTM4A4SOX10J0rH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON9FWYqsfw5epgpkT23px1SkKQYAkW5dUs/PSbNWTSI=;
 b=Ct2E7y6KL7EQshajIOB1K0D/qyl1v8u+tI31z1F4B/4mLzXv5P8CvO9C8RFdkriHyq6rfj+73/6c1j/OGpkYT/69GmuR1NDrB7O737fsiuGClwHorPWcJtTxlANTntGBPdYaM0SVCWltUPHRrywkmgQPSGZL87Qa+FUQ+yDVmR/M87SDEfLt+1bxklNcKFbeAVoRn3YsjlHm2Qzvb45Dm2SWL08ZeEJFD7o0l3FO2eThnwgg8BsxGr10ZWhUIOoKyeHVrX5V63onlQ66ARsZd75VN5bJ/cyjn4KStYVVkmw/0FeM/T5QomQqD5T6ONXQspBVNOsPoV67CmkcuzN/Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by SJ5PPF09E5F035B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::988) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 17:00:24 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 17:00:24 +0000
Message-ID: <518c7575-2e44-4d6f-9e5c-3504758e396a@nvidia.com>
Date: Wed, 7 Oct 2026 12:00:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/pci: Expose ACS ctrl on Guest as configured by
 the hypervisor
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
References: <20261006013133.3457555-1-tdave@nvidia.com>
 <20261006013133.3457555-3-tdave@nvidia.com>
 <20261006004500-mutt-send-email-mst@kernel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <20261006004500-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::7) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce419fb-6c5a-440f-5b5d-08df24947aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: fFCHnMcQIe/BbNW1tK4k4KvOBEUD6Z2bJqZai8LAnbG4X7bBuO9u+nBlNiN5IJkucsJCHXl/GqkGJH0NgqSi16NeYl+EYFrSx3V/QGmgKZdNXkvA+cwePwQDIbIhiuyhkoPP5ykbU8oJAuC7Ge2yv7mSZTO8dDuBu57zcyfjovTUaQTrVfkT38RzYqR9g8MWethkxBRTGAGQ7aKFupWBm2q8TD1qCnQxXei9/MOY15k+2SyluXKGp78Vop165anAtnL/YGtBWMab16kf3CualVDF7NxXbY5UK4ufaFzV7+bpFJWea3Z7eA1MCmN4CZKe8w9nKq6t7HHINvEba9f/Xo/sVZSZpvANVyooavRqFzaBkezkCZoG8UfhGyUP7GSyQqnONFq3pMKYZNjDZZhZ9q4uD/a6a6qaegi1LwLDASL9XfsZ0ZKIMzDR/S73foggTbNSwyR+iXQ7y27L4esYIc7VkfJBgTkiaObMXLmbBZi+0KR3FBM2N9eSVBZ1E3a7ckrJo5rD2o31D4Z1zHtVI4devzinpShFyKvzEv2FR6agPG2F5DQZyecfL3dA+1X4CSEab+btw0b+awwiDDv+hehQ+bScjxe+U/iY+j6UKHJ+Uo69WiSGZusUEXRq8EjWA8tcr0DqsZ+IVBq4Uwzwz1ZanHlyKddaEoPZRYgA/bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdSZUFMQ0szRWx2QWM1aGlhUWcwN2ZKRlliWjdpV2FSV2paMno4SG9wTjZ0?=
 =?utf-8?B?emdQU1ovbE1xazVIZVdydWxtenNSd0MwanhpdFZrMUQzSGVzQ0pFL2RuTE13?=
 =?utf-8?B?RW5xQkJBTUljTDNOVFdXM1hhVHhudnFQeHZBRXBXNVQ2U1JCdmdHcHI1Slgz?=
 =?utf-8?B?ZTRFZVo4SHBzWmIzNkFOckVKL0Jva3AyckFLaTBqV1J1SnhZeGkzTndZTGk5?=
 =?utf-8?B?TFNqRFVxc2NkZlY3Tzl2bmd1Skx4b1dncUJGTmFxb0hiUVAwMi9RQWR4MTRn?=
 =?utf-8?B?WjFQVkZ6aEg3dmNkOVVDN0NWUDdYU09nUVlzVEgxWGg2aFJQOGNvb0dON1Zk?=
 =?utf-8?B?dENrcUFsNXdVNUNBVjF2akNTMU56L3B1ZnVnYkFGUnQxSkZ2QU9mNmR4dlk1?=
 =?utf-8?B?MUQrbXFKSFkyQk0yV1V5c1FkYXRDVE1tT05aMWh3c3ZoTlVjS2NxSlJKazVB?=
 =?utf-8?B?enJ2SlBuZTF2M2RVakFORExLa3k1TXBjQmtOdHVKRzRiempPc2djbGZWaVM0?=
 =?utf-8?B?czRCRUdCc1BTRGxuZG15YTQvL0ErT0pvMUE0UTNsR1FBZGJ5RnRPNVFHYXFo?=
 =?utf-8?B?L1ZSN2p4S1F3Mkl0YzA0UE15WXU4NVRuTkR4L2dyY2ZmTU5SNkZKekVYVTZG?=
 =?utf-8?B?ZDR6cmJ2ek0zYU1lN3VRa2RwWTBSSitUYlVGdXY0Nit4R3llV3hZb0RzV2N3?=
 =?utf-8?B?dlFnQTV2bEVqdDQrRC9uWVB5TURtWnRjVTZDaEpaOS95Mmo0Z0w0TlJtMkxs?=
 =?utf-8?B?aXNjVUlGZGI3YnAwVWZYckluMzBTRlBoM2hnRE1USTNUalJrVzQxd2gzMUpC?=
 =?utf-8?B?RU01ckdIeDBoU0ZibnVRQVVnU0ljcTZ2SzUwUDE2RnN2NDJCVnhQb1J4SWtq?=
 =?utf-8?B?UnVmSEV3NE9VQXE0cUNmdmRLbFVtRExRakZ2WkxuTmhyK2lySHpLcW1qeEN4?=
 =?utf-8?B?UytLZy9XakEybG5Kalo1K0huaHRtYVVFTXN3aU84TzZ5dGFXV1FxWnREaXlG?=
 =?utf-8?B?ZnZrU1FCV1o2VG83clZrbm9QS2dxS3B6cUdmSDJBZkxNQXIyaW9ncUREUk54?=
 =?utf-8?B?ZVo2c25FWVd1NHpKUG9sM1dYSEVtNkRNR2dCVnhzSklFUnBVNldDNnBTeExj?=
 =?utf-8?B?REFIandZNHpxNVF3VEFmVFZVdHNTeE1NaTd4OUZSQUhRVXJ1VmFXYjk5NWlu?=
 =?utf-8?B?MjBBVnVKbldRODA1cjFIYVVldStoYllNcnRRZDRYeFBaNTY0S21YWGpNN0pw?=
 =?utf-8?B?cE5YR1BPM0JEcmpCZTRHcWluelprbjNPZDcxRlVKK2Q2QmNKODRNZmpyYXR5?=
 =?utf-8?B?NWNGQ25TNmZQSHRsOEZmNEh2TmpnQW42aHBVc3ZpUmdRTlFQQ2tna3pPYXNs?=
 =?utf-8?B?U2dkdHAxWUdsUGcyd0pkQVVPNHlmK3VGOVVHSnh1NWg0L2tMcWJ3Ym1Yc0tP?=
 =?utf-8?B?RHFSeitJeUp5U2g5bWg5Z2FYM1dRMm5mblBZbGxQZnBETlcxaXdZVC90eWh1?=
 =?utf-8?B?VEY4bzZkVktPczhPVUxwNEZEMFVtcXArZTlhSlNCa3RrSlBacHdCNkVJL1dL?=
 =?utf-8?B?S01hd0ZlcjR2RGlYNDcyRHF3WGNVSUpWMmQzQ3dQWDVTcTFSRHArazFEd0JD?=
 =?utf-8?B?cFhTcUt0RXRJMUE4c2FyR0p1ZjFKVHluUUpSTEZuYWlUZHMzSGo5L3ZsaEdS?=
 =?utf-8?B?T2prNHdsOWdiVWVaSzA4V2YyK1dpOXZWK2ZXL3JCU2hRUVpDdkJRQ0dVcFFX?=
 =?utf-8?B?aHVwOFNBQ0Eza21hNEFkQ2hsNDhjZklONGRhY3dTVmZ2ekErZTRTZXVHelZp?=
 =?utf-8?B?TmxXM1hPK25kSWZQM2VGYUhrZzVWSXFiczhtTVp0U0IxK1V6TkR6SFhnZ0JB?=
 =?utf-8?B?Wk94OVVwS3orYytSS3B0bVN6OFVCaHNQY01ueEtxRGdXeHNka1ZvMmhoVnFK?=
 =?utf-8?B?YnNOVjJWMnJodTVsNTVlcjB4V2JremVwZW9qc1F4RkxzOVQ3VmRmdFE0MDlV?=
 =?utf-8?B?WFhud21mOEp4T3NXQ2IzQ2FURUFjbE5oOVFaN1ZraWsvRFQvd1JsV0FLaDMz?=
 =?utf-8?B?TktQaURITGx3N1dya1pKdk5WNG1kdi84UUJGamJyLzBkTW5YUi9mWFhiOGVB?=
 =?utf-8?B?TzFUOGVDVmIwSlp4US8zbVFEQk0yVGtKam1USjdoRklobjVSR1QrS1RmZDJI?=
 =?utf-8?B?N0ErTExSWm04eW1YajVnQlpDVVNuKzdLRFlxcjNJcGtobWo0UDRUeGN6ODho?=
 =?utf-8?B?SkNQYy84ME1BNmpBRVpnZ0g1UEo4TW4zZzQ0SVNaYi9iNzV5N2srYW9EOFZ5?=
 =?utf-8?Q?Qq9RygbX6EqKk5alJT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce419fb-6c5a-440f-5b5d-08df24947aa4
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:00:24.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozy8+RR3NdIMv5tNqNuHctiaX0n7Z/mPXNmMNzKYHobmIZMBVTnf2nLY+5qFhxGnLT06NntRUKE96ogcocesQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 10/5/2026 11:45 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2026 at 08:31:32PM -0500, Tushar Dave wrote:
>> From: Yishai Hadas <yishaih@nvidia.com>
>>
>> To support P2P on Guest we must expose to the guest OS the actual
>> PCIe topology and configuration as set by the hypervisor. The ACS
>> control must be set accordingly to have functional P2P. A mismatch
>> between the hypervisor's ACS configuration and the guest-visible ACS
>> Control register can prevent P2P between devices from working as
>> expected.
>>
>> Extend both root port and downstream port to accept ACS Control bits
>> that match the hypervisor configuration and expose them to the guest.
>>
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> Co-developed-by: Tushar Dave <tdave@nvidia.com>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/pci-bridge/pcie_root_port.c     | 13 +++++++++++--
>>  hw/pci-bridge/xio3130_downstream.c | 13 +++++++++++--
>>  hw/pci/pcie.c                      | 17 ++++++++++++++---
>>  include/hw/pci/pcie.h              |  5 +++--
>>  include/hw/pci/pcie_port.h         |  1 +
>>  5 files changed, 40 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>> index 7c3e78010b..e7cce8c0ee 100644
>> --- a/hw/pci-bridge/pcie_root_port.c
>> +++ b/hw/pci-bridge/pcie_root_port.c
>> @@ -46,6 +46,7 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
>>  static void rp_reset_hold(Object *obj, ResetType type)
>>  {
>>      PCIDevice *d = PCI_DEVICE(obj);
>> +    PCIEPort *p = PCIE_PORT(d);
>>      DeviceState *qdev = DEVICE(obj);
>>  
>>      rp_aer_vector_update(d);
>> @@ -53,7 +54,7 @@ static void rp_reset_hold(Object *obj, ResetType type)
>>      pcie_cap_deverr_reset(d);
>>      pcie_cap_slot_reset(d);
>>      pcie_cap_arifwd_reset(d);
>> -    pcie_acs_reset(d);
>> +    pcie_acs_reset(d, p->acs_ctrl);
>>      pcie_aer_root_reset(d);
>>      pci_bridge_reset(qdev);
>>      pci_bridge_disable_base_limit(d);
>> @@ -118,11 +119,18 @@ static void rp_realize(PCIDevice *d, Error **errp)
>>      rp_aer_vector_update(d);
>>  
>>      if (rpc->acs_offset) {
>> -        pcie_acs_init(d, rpc->acs_offset);
>> +        rc = pcie_acs_init(d, rpc->acs_offset, p->acs_ctrl, errp);
>> +        if (rc < 0) {
>> +            goto err;
>> +        }
>> +    } else if (p->acs_ctrl) {
>> +        error_setg(errp, "acs-ctrl is not supported by this root port");
>> +        goto err;
>>      }
>>      return;
>>  
>>  err:
>> +    pcie_aer_exit(d);
>>      pcie_chassis_del_slot(s);
>>  err_pcie_cap:
>>      pcie_cap_exit(d);
>> @@ -151,6 +159,7 @@ static void rp_exit(PCIDevice *d)
>>  static const Property rp_props[] = {
>>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>> +    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>>  };
>>  
>>  static void rp_instance_post_init(Object *obj)
>> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
>> index 6a9df5c174..e243dfdf7d 100644
>> --- a/hw/pci-bridge/xio3130_downstream.c
>> +++ b/hw/pci-bridge/xio3130_downstream.c
>> @@ -58,11 +58,12 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>>  static void xio3130_downstream_reset(DeviceState *qdev)
>>  {
>>      PCIDevice *d = PCI_DEVICE(qdev);
>> +    PCIEPort *p = PCIE_PORT(d);
>>  
>>      pcie_cap_deverr_reset(d);
>>      pcie_cap_slot_reset(d);
>>      pcie_cap_arifwd_reset(d);
>> -    pcie_acs_reset(d);
>> +    pcie_acs_reset(d, p->acs_ctrl);
>>      pci_bridge_reset(qdev);
>>  }
>>  
>> @@ -115,12 +116,19 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>>      }
>>  
>>      if (d->cap_present & QEMU_PCIE_CAP_ACS) {
>> -        pcie_acs_init(d, XIO3130_ACS_OFFSET);
>> +        rc = pcie_acs_init(d, XIO3130_ACS_OFFSET, p->acs_ctrl, errp);
>> +        if (rc < 0) {
>> +            goto err;
>> +        }
>> +    } else if (p->acs_ctrl) {
>> +        error_setg(errp, "acs-ctrl requires x-pcie-acs to be on");
>> +        goto err;
> 
> Tying a stable QAPI to an unstable one like this is not really
> reasonable.


My bad. It is not tied to x-pcie-acs. The error message is worded
incorrectly. The check (added as per Shameer's feedback on V1) is there
so that acs-ctrl is not silently ignored on a port without ACS, so the
message should simply say that ACS is not supported by this port. I will
fix the message.

Thanks.
-Tushar


> 
>>      }
>>  
>>      return;
>>  
>>  err:
>> +    pcie_aer_exit(d);
>>      pcie_chassis_del_slot(s);
>>  err_pcie_cap:
>>      pcie_cap_exit(d);
>> @@ -146,6 +154,7 @@ static const Property xio3130_downstream_props[] = {
>>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>>      DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
>>                      QEMU_PCIE_ACS_BITNR, true),
>> +    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>>  };
>>  
>>  static const VMStateDescription vmstate_xio3130_downstream = {
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 42bcb9206d..af24ec7fd9 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -1260,7 +1260,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned)
>>  }
>>  
>>  /* ACS (Access Control Services) */
>> -void pcie_acs_init(PCIDevice *dev, uint16_t offset)
>> +int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
>> +                  Error **errp)
>>  {
>>      bool is_downstream = pci_is_express_downstream_port(dev);
>>      uint16_t cap_bits = 0;
>> @@ -1284,16 +1285,26 @@ void pcie_acs_init(PCIDevice *dev, uint16_t offset)
>>           */
>>          cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>>              PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
>> +
>> +        if (ctrl_bits & ~cap_bits) {
>> +            error_setg(errp,
>> +                       "acs-ctrl 0x%hx has bits not supported by this port "
>> +                       "(supported: 0x%hx)", ctrl_bits, cap_bits);
>> +            return -EINVAL;
>> +        }
>>      }
>>  
>>      pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
>>      pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
>> +    pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
>> +
>> +    return 0;
>>  }
>>  
>> -void pcie_acs_reset(PCIDevice *dev)
>> +void pcie_acs_reset(PCIDevice *dev, uint16_t val)
>>  {
>>      if (dev->exp.acs_cap) {
>> -        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
>> +        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, val);
>>      }
>>  }
>>  
>> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>> index ec25e7a7de..678ad73f7f 100644
>> --- a/include/hw/pci/pcie.h
>> +++ b/include/hw/pci/pcie.h
>> @@ -137,8 +137,9 @@ bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>>                              uint16_t offset, uint16_t size);
>>  void pcie_sync_bridge_lnk(PCIDevice *dev);
>>  
>> -void pcie_acs_init(PCIDevice *dev, uint16_t offset);
>> -void pcie_acs_reset(PCIDevice *dev);
>> +int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
>> +                  Error **errp);
>> +void pcie_acs_reset(PCIDevice *dev, uint16_t val);
>>  
>>  void pcie_ari_init(PCIDevice *dev, uint16_t offset);
>>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
>> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
>> index b28af067a6..2ad9a563d9 100644
>> --- a/include/hw/pci/pcie_port.h
>> +++ b/include/hw/pci/pcie_port.h
>> @@ -36,6 +36,7 @@ struct PCIEPort {
>>  
>>      /* pci express switch port */
>>      uint8_t     port;
>> +    uint16_t    acs_ctrl;
>>  };
>>  
>>  void pcie_port_init_reg(PCIDevice *d);
>> -- 
>> 2.34.1
> 


