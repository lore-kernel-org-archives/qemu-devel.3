Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C1CF6C18
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPXE-0000cU-EV; Wed, 07 Jan 2026 04:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vdPX9-0000ZO-SA
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:08:52 -0500
Received: from mail-westus3azon11012013.outbound.protection.outlook.com
 ([40.107.209.13] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vdPX6-0005Ev-J7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:08:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcdxDcX3ZVEnyXCmfTSKiYTNVdzV7NNaEcFZ3SePIibtJTAx3k5gu4vvhDxnGZb1eApUivRp/RGsVhPeHHNw1XImzdPwYh5H/Hovdx26uIz8LkuUtO+mE3QvYYNOqgdMJdhA+gcLX3IMy9KrAl2ee+1n4QSmJEHXormcYiPEZfw/LezClo/INszNBAac3tW2xpl4qGXw1Ya8tDLsXYWncW6ThJOtfduJ35ARBEsuP49ihUkmZQIe9nQpJ/wONbJ5LjNzqq8/zN0qQ5qWB0lAbOQDBG7Id7rOxvjuOGELQ4ZY0oeqPEmB47f970UDePAPPNjuoW/K5W+YW6Per+3/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg9ZTmRfyv9Bh5kJA60/hjxOaDf9SDf/rFy0QiaxGdo=;
 b=p/rB9pcW9jsEhIEX2d2zG7zN14m4T+JJynSqJVOtRjvW77HlU5XgBbOz+JQR/2Dfs0+Qns04xFotj5vLYuCv4I+SIpGDbdxiEixOIdff0QxzU0/4ct0bw0loEuGlwDGJOYdxfTJTSFnlPqKF2/xj2njrrA7mJ+fr6T1VwO70sD2Eqs0sNZ6E5Zr0jp2m5jYeX2nNRpZbV97dLBPFhnahwIPLg8SOMcfE5M0gSp7bSL89gDKnAwjOZFfmw8DhcGIchEDf23IxvedWLFUGzUk85mtcOovGn+QINRTN8LUozXsY3XaO0HwzIWbGm3J2UpWPf1XXnyh1V/x95idaCXSB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg9ZTmRfyv9Bh5kJA60/hjxOaDf9SDf/rFy0QiaxGdo=;
 b=5XfEWBm/e4x0UcDqINZGmg5iGtFlEC3MwhiWDwcYnyOrK08yIcMgS0Zt1E8DnWeFxOHOKjFzQD13a//DikZFVhcdMyXM7enLuHwZ2tohJKltdso+PqTFujTYebxaorjXgQA2vdEdrDsz6zH/PCc8tmBuF1w+mtnr+TqS2olu/4A=
Received: from BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::13)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:03:39 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::e0) by BL1P221CA0043.outlook.office365.com
 (2603:10b6:208:5b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 09:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 09:03:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 03:03:38 -0600
Received: from [10.65.97.122] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 03:03:36 -0600
Message-ID: <9442044f-5cfc-4068-971e-9184bcfd3c76@amd.com>
Date: Wed, 7 Jan 2026 17:03:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Gregory Price
 <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <aVfyl8sylMICO4mc@gourry-fedora-PF4VCD3F>
 <1b2acdb2-ad9d-4fdc-bd3b-a13249cc0ab9@kernel.org>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <1b2acdb2-ad9d-4fdc-bd3b-a13249cc0ab9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ed3b1e-17c7-4a05-d550-08de4dcba5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWdZTCtJeU1rYjVSRkErZHFXQ1drbjNsVHVJRERNVWFLRlFzSDZkL1MwR3V4?=
 =?utf-8?B?Yk5ZVnVHOTRCcFVwVkhjQWd3QURHMis5aVphYkxRTUhkZHZJbUROS3EzVTVK?=
 =?utf-8?B?eGNUVkUvRVQ4Y1JSVFhFaURDZDYvSGVES1dkZEFJVnhiSm9XQlRvUExvYW1z?=
 =?utf-8?B?LzlHNElIUjRiUXNsRFMveDhKSUIzekFSaVdXdXI0bHJKQXpnSGpQS1VvUzRS?=
 =?utf-8?B?alpFZFl4WkV0MGpoRWZmWUc5bkFTOUJoSlF2NmdVb1ZRdVB1bHBVRjRhZTlZ?=
 =?utf-8?B?VDJlRDBCVGxrL200Wi83SFoxdFJ0TjAvSDl1ZjRFSlRIYkdKSkJyT3pTaVVl?=
 =?utf-8?B?YjhLb1Z3Smp0Q3UyOFpET3JJNC9IamQ5T1h0OVhlcjJOdlo4aU1kcUpVNDlM?=
 =?utf-8?B?T1dMSWJVMlZVWEphYkVVWUlsKzJWUTJ4M2o0a0F3VWFwSnorbEx5SFpHbGpt?=
 =?utf-8?B?MDZoQjRaTVZMckh5M1ZvY0dvc0JtT3ROY0dlcWJkemtPd2FnTkN5bUpKWUtn?=
 =?utf-8?B?KzdsN1NpaFdLOFlIVHBPNUtFTHJhcVY5UjZmUUw1TGMveUxleDJZWVp2LzVB?=
 =?utf-8?B?RFh5NFZaZVpsblBaL0RHL2lsYVArRFVzRTY3ZkNlTmx2ZStLb1ZseWN0b2ND?=
 =?utf-8?B?akxsZWl3ZHlBRVNBWTlUZy90enowWU9IWjgwYTFSN1M0YTJ0Y1JRZWlneDFJ?=
 =?utf-8?B?MG1HQXJvZFNkU3hqbTZ0NUxMMVBRNFVLaUFZazFTaVUvaVo1UnNPZE5vU0xr?=
 =?utf-8?B?VXU5a1hleDYwSi9SSVNhdUllSGZPTTNYYzMxbi95RWplU1hqRUFIQ0o1MkRI?=
 =?utf-8?B?eUhNVFFtZjgzYjMzN0pKbXFIVDQxMFN3V0cxNG01d2NVb25XL0NRT0xWdE5o?=
 =?utf-8?B?czNCK3ZKQ3A2c0ZuQzZGNDRiNHNNQnZvbkJIaHFKeDZocllhdzJoSVA5NzRm?=
 =?utf-8?B?VVZ2V0RCMlVaZWh0THZpL0lndTdZRnJQWFVvd0tPRGRRSUJNRFJVR0dUODNp?=
 =?utf-8?B?RXRJa2ZHdmpMTEVmZ25nV1YrbHo2SS9QZVF2elBpaEdDQU50Y2JiSHFrTmhI?=
 =?utf-8?B?K3R0cTdEcm1tR1kyRE9BVUZzWitlTUUveGYrOGszSDVHbHBlQXhqSlk0M1FX?=
 =?utf-8?B?NGdQR1dhc0c0QVN1N1NXUStlcjZUZVBoUzdLSlMydHc2d2VWL0J5L3ZpRGpl?=
 =?utf-8?B?MXBDcUdDSGdNWWErM2p1aUZNY3hnOHVIMUJydDl4RG4xTCtyTHRMSk50KzZX?=
 =?utf-8?B?dzNiMnorU294U2FlM3VQNlJjcUhWOUJCUC9kWHVTNjdEazlZUmh2bXNOZEpz?=
 =?utf-8?B?UDNJaVQ5RXBIcnFuUEtNMUpockFSQTJMTUhuaE1BZjh5LzhIbEZtTGxRSEgr?=
 =?utf-8?B?OVpxb1VoYjVZWjZoV0NPQ1RXMTBtRmVnUWZRR0l1dmt4S05wWnNISG9mcExv?=
 =?utf-8?B?VmExR3E3RG5wc2NhSkRFYzA2OXJHeC9xMTBuSkhQSVp0NDliY2JSYkdhYWx2?=
 =?utf-8?B?bzd2RWVGd1ZEUHhhSzFFSmJEZEh5dW53eXB0bzU4ZFhxNkhaalFwajNlZGxI?=
 =?utf-8?B?OTRBbzBTYWFXQ3l5YkdhU2lCZHFnWUlaMXRtYUhzbGszdlBjZjNzYTRJczRO?=
 =?utf-8?B?eDN5aGNMUzBDNlhmUGNvbGtpd1FkckdGbU1neUhxdHVLdnVZTlVQaU92UEkx?=
 =?utf-8?B?UEY0R2dCUk1EMzNNVVdCTVkrVjZVREwwQ2p3T0x0Vi9TMXh2YStOSENXSjRL?=
 =?utf-8?B?cHpoYUhUL0ZUbFdYdTUrQXR5dk13aFZQSU5nUzY4OElHcnhoZWNPaHpjeDRw?=
 =?utf-8?B?T25WYkZ5RTMxU0FvU0UwanBtYkZhMXJISDhxNWVlNEx5MHBRbk0zOXJVWjgy?=
 =?utf-8?B?Y214cHg3RUtaaTBBcERaTUpsY0FSR2NTUi9ZcHNDMVJpSlRPMWU5ZGtJKzdz?=
 =?utf-8?B?cGpHSzlDZmJvb3JJY1p2NlF4UEVZeVVsK2F2bWlIc2FsYktUT203dDM0RVdy?=
 =?utf-8?B?SmNsSm9SQXc1NUVYNEpwUW1HYVNUbDIvRFJaVE1QVTdBd1R1TGdBSFVpenZG?=
 =?utf-8?B?Kzk3ekdsRTZHSGZTNDQ0VUxZenZTV2pEN2x4RDJUSGY2dkxBS1dUU21QNVRp?=
 =?utf-8?Q?yGMQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:03:38.9303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ed3b1e-17c7-4a05-d550-08de4dcba5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
Received-SPF: permerror client-ip=40.107.209.13;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/5/2026 11:29 PM, David Hildenbrand (Red Hat) wrote:
> On 1/2/26 17:30, Gregory Price wrote:
>> On Tue, Dec 09, 2025 at 05:38:40PM +0800, fanhuang wrote:
>>>    -numa node,nodeid=0,memdev=m0
>>>    -numa node,nodeid=1,memdev=m1,spm=on
>>>
>>
>> Should discussion with Jonathan - whatever form this ends up taking, can
>> we change this from [on,off] to [normal,spm,reserved] and apply the
>> appropriate types accordingly?
>>
>> don't know what to name the tag in that case, something like..
>>
>> memmap_type=[normal,spm,reserved] ?
> 
> That looks more extensible indeed.
> 
> The semantics would be unchanged compared to spm=on: only applies to 
> boot memory. Although, as discussed, mixing and matching types per node 
> should be avoided either way.
> 
Hi Gregory, David,

Thank you for the suggestion on making this more extensible.

I agree that `memmap_type=[normal,spm,reserved]` is a better approach
than the simple boolean `spm=on|off`.

I've analyzed the required changes and will prepare an updated patch
implementing this. However, I need to go through an internal review
process before submitting to the community, which may take some time.

In the meantime, any feedback or suggestions on the design
are welcome.

Best Regards,
Jerry Huang

