Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B1C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 08:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJ9V-0007rg-Jl; Mon, 28 Jul 2025 04:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ugJ6R-0005We-GY
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:21:00 -0400
Received: from mail-bn8nam04on2043.outbound.protection.outlook.com
 ([40.107.100.43] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1ugJ6N-0001At-G0
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:20:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe981guNDYQEbLck5zZO6Mlu4YEJ9wnszU/BI+XYKyn1bVI7Q6MOK/zuEVmb9dWoY38461jVVuAe0dmgufEOIni5MiMPftV+Nlfw3ZfBnQ08uEQiDh2TZWXMeYLX29Uz1wuiaTcqQluDpCoT3HIczgZWM82lyxkPaHgVmLmftTJmMKo8PQ5uwxTsXhRoqo6EOLUO4vIBqqmr1YY/itwOgV5+O5oOcyUE17boXXuhMx0NtVe3ott8l0hyDgzevwLMCfHlvK5bS3GONS4nYticqpJk3J+Edgl7qkDHmFBL8xsGMy1XLrgeN6yFV+ymTUFeC2QLr6B4m/zDiks2iFWcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0MZYS+W99ddRBLgObZ3wgTEbeDh6uZkk38F6ciohr4=;
 b=Q4boUMsrRCZa37wqD3Nq7NBGdDFcM7FUybsRpH92HrlXPkhk/QrxAhs0GHNmDQnwXrMDBxmshKaopjcasrLOolSLZyrr88X3uAXd4E8Wlg96VJ9pGME0nnzDcCowOwidd4KKgQlsotBa/C0zKgJlHN9rZ+55GlX47Qf4ri2ZoQOHU4ltxpVCv5FjKWSGllzAGkFw+aWwMQE4ZgeGRBsSgdF1PX1J1fYeIY6aQhxXvXc+Tq+9qz9B6FFp6sLw3kHR2h5uzCmFqm4mNJKXqP7gm4mu6g9Sa8z84OMUH4bOJ468dxtTj4iu/cERy4HiDJrSmr8jxKKj0wTIggyn9Q9c7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0MZYS+W99ddRBLgObZ3wgTEbeDh6uZkk38F6ciohr4=;
 b=sXPzCO6bk7CVxpOOR/bgUsJbc45Z74uvd5Q52HZpOGR1cy4ambpEMc/kuA9qnXnd3CB10VZkQG6vGuwq5LTjTJfv9Y9lOZ5gSePgmHx7KPyQM5eP31gVXTswgQncm++pk01FOE8jflCS3d3bP/gKX8Dm7wWwvEqsg2T+gjYP76U=
Received: from BN9PR03CA0913.namprd03.prod.outlook.com (2603:10b6:408:107::18)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:15:48 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::9e) by BN9PR03CA0913.outlook.office365.com
 (2603:10b6:408:107::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Mon,
 28 Jul 2025 08:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 08:15:48 +0000
Received: from [10.85.34.242] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 03:15:45 -0500
Message-ID: <6c80ac28-42d8-4781-9bf4-f78e8f181b92@amd.com>
Date: Mon, 28 Jul 2025 13:45:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
 <20250724064745.4091-3-sarunkod@amd.com>
 <050bd22a-0ac7-4f9d-be8d-8d86b712c410@linaro.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <050bd22a-0ac7-4f9d-be8d-8d86b712c410@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7e101f-860a-46ee-51b5-08ddcdaef555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzAxV0F4d0FuZjBTUXdVOGpWb09OckJWRXhlWGRrcXFmWEZWVHVORlJYSGxK?=
 =?utf-8?B?eHdyeXFHaHQvYzVnK0hjOUozZTNWY0d5WVhRaWJ3cWowWmlZNXhJU3JTSEJx?=
 =?utf-8?B?VlN4bnRNcFpjdjhCOUdaTFRsUExCZHg0eHcrVHpiRUcwMDZsOFN6QS8rTkx5?=
 =?utf-8?B?Z294M0JYQnZTUGZXTy9NbWVLNGl4cHkwbFJoS25mYmViaXFJZ2tUMC9HSXBr?=
 =?utf-8?B?ZGphcVdiNUZ5RWwzTHBOWGVPeDBQU0NWMm14NFZMZXV6YzU4akVZK3Z0bkx6?=
 =?utf-8?B?UlR3emlURXVidWFPNlNqQ0NSTnlqRStHZDZlWVlBNElqYWUxL2ZRelVEVmp4?=
 =?utf-8?B?OVpxMTNtOU9aZHFsSUlld1VHOWl5SFpCYXBuS3N2bUFWWG1uSVhtcVhSTjZw?=
 =?utf-8?B?MDlYS2NtanNJMjVmbTdObEZaSEFCQndid3FVcGRvdmZSUVdZSE85ZXM4blIv?=
 =?utf-8?B?Y25ZcVpJTUwzcThzOWx6VlB1MCtsMGxjdktid0Q5aHZRM1BKdVBkL3pvZzJY?=
 =?utf-8?B?MDl2N2ZzenBrR045Tk9aZCt4a0d2ZUIwSjd5YmJYeEVJZDZZRUFDQkRJSlhz?=
 =?utf-8?B?L2xIcUhYQWpuMTBwZm9yUUZFdkFtZmJWOTRtUUJvTlQ3VW51c0dqNzdWNDFR?=
 =?utf-8?B?MWpDY2ZVQVBiTGdZcjJvNEdBQWh4NnBFOThXOSs4MlVKOStGRHVPVUVUc0N0?=
 =?utf-8?B?Y1NFS1d4OVVKNk1KRDdkUGw3SnltNFNlYVJtS1VRRm5UVkIzYVVPRmF5MFdn?=
 =?utf-8?B?ZGE4alB3WkRLL1RBL3E1Z09CMUZzdWpZWEpYdG5ybjBGOGNIOG1Kc3FYWUtJ?=
 =?utf-8?B?TzVoOVd1NERvVkJaV25OTFRxUCs1SkNEZ2FWZ0tQZEY4bldWNmwxMzc1YW1k?=
 =?utf-8?B?MlN3RGRTOWQyUmlleVloWkVOU1A5TW1TQzJmOFJsVTVIKzcrWHNNbTBXMDRj?=
 =?utf-8?B?U3d2YjE4ODd2d0dGM1FXMXZZQ2ZJeFZjSmkveVVmZkc0V3RnTXVxU3VycW92?=
 =?utf-8?B?dWRjMHJBUmFDZHl5cXRDTytxVE1SblZUU0FEMkJIZ0paZ0dFZ1RTakZRMitN?=
 =?utf-8?B?Y3lMVnNJc3E2azZabG9CNnNrTW9uR0ZLNyt3YUlEem9FdHN2M0hvVEdHajVP?=
 =?utf-8?B?KzVSaklxNzNOVzk3SE1LcVVzZWs0Mkk5ek5WdG00NkNjTUxFbUxtWnp2VkRP?=
 =?utf-8?B?SkNXZGV2ZzA0WVB6dlJRYnFUN1NuRWxGenFIbEpHYnZHYlNkK3hicEo1NGRM?=
 =?utf-8?B?ejJaRWFWQVdOMDU1VldsTW42NTdvRjRncUtXNVBLbmMxdUJtcjQrczh6cjFu?=
 =?utf-8?B?TzI5bUpqZDRhb05sWFpJNW5SMmVQQXNJWVplaGgvc0JHbVBUeGVkU0pMdDBL?=
 =?utf-8?B?NUJKZEwvaytrSnh5STlSYXBaMHJTSUhQWjVQZXRxQjByOS9SMGxzSTMvYkVm?=
 =?utf-8?B?U1BId0tGN0ZlSTFIQ0oxcXJ6bDJYYlAxVjBvbFNGQnZOUTBLalZ5eXFEZ2Js?=
 =?utf-8?B?YjJXWVZ6SHdXY2RFclY5UWZhcFRKS3cwMG5qTHUxWmVkekVwcmFLVTVVOVFx?=
 =?utf-8?B?T0ZJeG1kWHhSNGVmUFhvQUNtWTZWTVppZ01VVDF2Rjhsa2IwNVFxQjJMMmhE?=
 =?utf-8?B?Vyt6TnE4bkVBVlZvRi9kQ09BYmtzVUtPdWJmWGZxRXBDbTJoMTlTdzU5MURC?=
 =?utf-8?B?VmY1cXFiZzV1NFk1L3lzTHRMWFNBSm80WFJ2ZmZlaVlsbkZDNzFJZVFpMEZr?=
 =?utf-8?B?anBmYXovNjNQMnpJNEw2MkdDQmV2M0Zxd3VQOEo5YVJRVm82Q2lOTlBWbWRs?=
 =?utf-8?B?OXpLNHRDRnY5cGxHbHphSmJSOTJyWjlpQ24yZ1ZPdEJSeFpGeGFqTmNRaElh?=
 =?utf-8?B?aE9USkcwK0xkVnZCc2d1L0paVDhFZjRRV3NLeEt4Zi9aZXFSOUdsa2VxWE9J?=
 =?utf-8?B?ZmhYWDJmOTJYZXJ6aTQ3eUpIU0g0bCt6NG1kMHQzODZCNnJib0ZELzRsUFg0?=
 =?utf-8?B?UExTWG1qSm9RPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:15:48.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7e101f-860a-46ee-51b5-08ddcdaef555
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
Received-SPF: permerror client-ip=40.107.100.43;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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



On 7/24/2025 2:18 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 24/7/25 08:47, Sairaj Kodilkar wrote:
>> The ats_enabled field is set using HTTUNEN, which is wrong.
>> Fix this by removing the field as it is never used.
>>
>> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 3 ---
>>   hw/i386/amd_iommu.h | 1 -
>>   2 files changed, 4 deletions(-)
>>
> 
> 
>> @@ -1626,7 +1624,6 @@ static const VMStateDescription 
>> vmstate_amdvi_sysbus_migratable = {
>>         /* Updated in  amdvi_handle_control_write() */
>>         VMSTATE_BOOL(enabled, AMDVIState),
>>         VMSTATE_BOOL(ga_enabled, AMDVIState),
>> -      VMSTATE_BOOL(ats_enabled, AMDVIState),
> 
> Please have a look at the migration documentation:
> https://www.qemu.org/docs/master/devel/migration/main.html#not-sending- 
> existing-elements
> 

Thanks for sharing. I'll need to add a VMSTATE_UNUSED() here


