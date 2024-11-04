Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF09D1CA03
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85LD-0003Js-D9; Mon, 04 Nov 2024 17:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1t85LA-0003Fq-81
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:14:28 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com
 ([40.107.220.81] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1t85L7-00030j-Nc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:14:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsiDcP9oW4pMWesUVfjvU4erIZAL0Isz8tVDAdWDHcUzGOCY6WsWtFR2IcGaFwkCkkk3wU/Ov1YLgT3WUaaktnvPQIFqp2e5sxm5p23Eg8t+d8/GLkG+KZImobsVBF2fVBipADmM1YmiJvdUXx1Y636FzropT1m2IxHf1gL2wG2a5Ors+Z08h1o6JSZrEdbDed9fuJJIiRrLfCynAKsxFWtrTAVUBlNZ4Bh+ckyc1H/ZjIfVYDKl4PfJH8qtV/HK5tHOyTM0Pm1bhQXxD10EnafaFEb+J0dGaJR7lcng0Km46pVV+co6rfXo+vSJrjn55qGQmSXEWi5nh92Psal9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+CTe0DuLRxVNwagvnEk52+IwGebyG5Mudi65S8b6hs=;
 b=k/DBrfGkdMwlAi0kyA9fSMhHnLMIcpxW94i5hWVJvvozKkp55/xT2jTtXCRAnCOYbFp+Ga/BVRD6fyT+8L98YFQ/q66e0TP0MfRWqBjbjWtZkPSPAQWUXzmMOt8+tFMyDCuKmri2LlYybIpaMCFgCSUibT4jFVgIzN3wLQuxZeuojUWh80NiT3QJaejUTXErcvNnn3m4XdILBUo9m5geMpZcM5QRmql8s76kAXfZXvgqhFerl+SuaLezHoGzZA1+90U7mFv1VsJD92nZ3SUIA+jzF1bQpzRhsTUb0/b904x3zHBCxnfk+6dA0FhcYVnLl2FugvsC9ARTsp43vIAMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+CTe0DuLRxVNwagvnEk52+IwGebyG5Mudi65S8b6hs=;
 b=KXLr3a7Zel41mLZ7uoqYiJUSbrqApaOmN+ErVPrKu34KAsSLg4ta+U9o2QtWH8fZrAbkUVW3I25bDbvnYElTHbQNBCVw0pOIUpWLKkbzLVGg64fZOH7qFua6aemeZMATCJHT5FVLICCM909D6ra9S3QKNMZzrDw+XSkAqT91SSY=
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Mon, 4 Nov
 2024 22:09:14 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::33) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 22:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 22:09:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 16:09:12 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 16:09:12 -0600
Received: from [172.25.174.226] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 4 Nov 2024 16:09:10 -0600
Message-ID: <64d8f920-8dbc-4d98-9b1d-535d1413caf8@amd.com>
Date: Mon, 4 Nov 2024 17:09:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v9] xen/passthrough: use gsi to map pirq when dom0 is
 PVH
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "Huang, Ray" <Ray.Huang@amd.com>
References: <20241024090629.1944820-1-Jiqian.Chen@amd.com>
 <356652df-b5b4-4c28-9c5c-4bfc4f36813f@amd.com>
 <BL1PR12MB584985EF3C4F3D482A3F8E95E7512@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <BL1PR12MB584985EF3C4F3D482A3F8E95E7512@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7881d0e1-0cef-4a2c-e9fb-08dcfd1d5171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW03YytzemVMM0QyMTJib2ZCRFNHYmR2SmNld24xVGY3MFNIQUozYWdMQnVL?=
 =?utf-8?B?WHYrVVhON0t0OC8ycXVFRm11Z3Y2cHEyOEZFVjJaeEdtZnVJZDgrRFJxQjVW?=
 =?utf-8?B?NHNPcjJDeFY5VlRYM3RYTmtCUEVOVUIvQlUvUnpVbnQxa1ljaVlGU1YvK01s?=
 =?utf-8?B?N3BIbzdRRXZBY0MyVnpRa0cvZE9BMWZRVHdnWjFpMjQwSnpGLzBkWUNsNVVs?=
 =?utf-8?B?enRWMzhMbVJhbzVoeEtibkZac1M0bnVPbGFDd3RmRG1tRmp4L0RrMWl4Ymtl?=
 =?utf-8?B?ZmVIZ0EvRFVvd1JGcjFPWEN5aTcwRmN5MGlIQ1lXNjJZZGY0OTBJalpRWENZ?=
 =?utf-8?B?UzZpbEtmOHIwN2ZIanl1MmRML1pnYUNmYkZYZEQxeTQ1SmFhTU96TnZTdFB1?=
 =?utf-8?B?eFZmZDZTTHd3Z1FWaEVYWi9icFQ4NEtuMEVrSmxIQ3hDVjJUSmtUTmJ0a2dk?=
 =?utf-8?B?Q3lmS3hSOUp5dWZzcE1YNjJZS0RnemlQVkQ2bUFLZGx3Yk9WUjJmVDZwNStG?=
 =?utf-8?B?akFSRkxzc3lLTkRucVFKTFNyWks0UzBvNEN2dWl2cHZiZ1dYYzVkWm1CZzh1?=
 =?utf-8?B?UWYxMFAwMVNKZkE1YWg3M3d1c2FOOXgwUkxpZU1FMjRoSTBFd0Iwb1JIaG5n?=
 =?utf-8?B?dWJaMW9aWlZEVXh5QzVqRmZLOSs4UUptblpENnhyc2preWg4MHJDdzgxZlFW?=
 =?utf-8?B?NnRFYXU4cE5sVkRRWjNCdGJxVkp6ZllRR2NpbHRWOTR2M2NYT0RkS0dZaGU3?=
 =?utf-8?B?eFhDZG1QWklJL1Ryb0syT2lUUGRpbVpQNHZ6VUNwSVpGV1gxRWE4cVp0WWF2?=
 =?utf-8?B?RTRoOXNzZVVFRE5TRnhzb1lDZWdBbWJjQTRxMmZEVCsrRnJIemRXeXc0c1hi?=
 =?utf-8?B?WlJMQVJMdXlOcU0wUk9vUTF6U2JKSTVybUg4R0lQbGU2cGV5TU8zMmgwdXp5?=
 =?utf-8?B?T3ZwZHhuaVNvUm95UkpSU0x5RnNFNUlGd0pYcE5RaHBtZzRpR3JLbTdVZlhJ?=
 =?utf-8?B?K3EwWjVGRGJ3OE5qaUt1ZmkzM1I3SG0zUDgwWGNyMFRyem1sZ09HZ2dIcXE2?=
 =?utf-8?B?cjNUakhkUmk0ZWVNeUdYSWludTU3TG5Zemh5L05LNjRsNG5RVlRndklsblVC?=
 =?utf-8?B?dmlOL0hyUEl2emJITi92ZFRMTTdvdyt0bFhBZU5qamVQM3JqaTl3L0hyT1Fl?=
 =?utf-8?B?Zm5FZjVvYU5ud1cvNk45b2tUNzJ3TGRYR2grWE9tUGFXSzVOMWVROFVCZjBr?=
 =?utf-8?B?ZjVJdmVOTXZydjBlOTJNVTZLVWR3NE1MWm9mVGo2SUxVNjBnYzgrNGR5UjY1?=
 =?utf-8?B?cmMreC81TWwxSU9DbG5obTBHWHQ5OEkxQUc3cTl4bHFzcXVwVnVsem5nbXdG?=
 =?utf-8?B?RWhvTXBPcm1hMEtnZFQ4OEIraTAyUXFzY2hpOXlOUm9HclRPSXViZjRSbUh2?=
 =?utf-8?B?bGlnaDRaUFNsdXc0cmlJM0FaZHJxUHY1THZ2elZiSnNiZ2pEK1dNSE1oMjJl?=
 =?utf-8?B?ZVYxdHRuSmppUzI0WitBd0RxdlFzdDJYUUU1VG5zb3ZsNW52emswaUI2RUV2?=
 =?utf-8?B?U3NodWI2Nlp4UUlRZnZlZU9BdWU2d1N3cHBNZ09qbWNpeHVRZ0MwUmlOVU5m?=
 =?utf-8?B?a2lHOVorUDdjejZVN0Z4M3llQ1JsL1hpYytrK2d5WDRxSFkxRmtNajF4Vzhs?=
 =?utf-8?B?QWVXS0RFdnFLL3ZFQWc1aUl3M2dCOXVaWlUyNWtzOEF0dWF2QlFPNWhXRk9j?=
 =?utf-8?B?S2JFUHBYNDZKUUwrdmFYVE10emdnSmJibm92ZzB4Y0p3VUJMQnFXSk9jN1lX?=
 =?utf-8?B?S2l3Zmh2SFNtcnY3TWtwaFhDblQrdlNrbEtqTTZlbStleVZCa24vTk93VExD?=
 =?utf-8?B?RUJPd1l0MEEvQXFQcmV0TEMrWU45RklPQUkrQjVvNUxnY2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 22:09:14.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7881d0e1-0cef-4a2c-e9fb-08dcfd1d5171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
Received-SPF: permerror client-ip=40.107.220.81;
 envelope-from=Stewart.Hildebrand@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/4/24 01:03, Chen, Jiqian wrote:
> On 2024/11/1 21:09, Stewart Hildebrand wrote:
>> On 10/24/24 05:06, Jiqian Chen wrote:
>>> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
>>> index 3635d1b39f79..5b10d501d566 100644
>>> --- a/hw/xen/xen_pt.c
>>> +++ b/hw/xen/xen_pt.c
>>> @@ -766,6 +766,50 @@ static void xen_pt_destroy(PCIDevice *d) {
>>>  }
>>>  /* init */
>>>  
>>> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 42000
>>> +static bool xen_pt_need_gsi(void)
>>> +{
>>> +    FILE *fp;
>>> +    int len;
>>> +    char type[10];
>>
>> A brief in-code comment to explain how you arrived at 10 would be
>> appreciated.
> The max number of characters in the description of the "guest_type" is 4 ("PVH" plus line break).
> I set it to 10 to prevent longer description types in the future.
> Do you have another suggest number?

No, I think 10 is a good choice. I'm just looking for the rationale to
be documented.

