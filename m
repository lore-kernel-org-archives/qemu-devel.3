Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3C2C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN65h-0008TG-3X; Fri, 28 Jun 2024 03:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1sN64m-000852-Pn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:31:25 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com
 ([40.107.243.86] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1sN64h-0007at-Su
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxrIElbO0NLEBYARVnEXCj9RizdsjxQu2sArXjjVs13UWCt+VLi/Kb/L8ym1Mmqj2O3jG/NtnoJNPy1tx9oQTgqqFR6OL0HySS1O+T7Ey+JlHrejx3FnROGv8DC5rQQoLhDHfkthzuhTWodcwUUTEk+MrBDMWd5YcNQWuKMxeYZMOEwrwG6NE8Ogv4yuotF4tYRvvXIo0xDjJPt2qZkGrQYweEzF4hchs3eM4tUidzV21vckFTItj7IA8C922GNZ76o4pzQONXbeblQeb5RaB8v2DqLo300y1Vhkfyd8sT5IoLFCb0xpDpw/JcHakFBnPsWokkHIwgYgNu29eOn+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12j+6po2VEaoUEvMTxjDymz5CX/Tn7YyPxOS4TqVBNE=;
 b=M+gOEI6BG43F09GVLOyZntkswN3R70jtzZKwaeAgwxH1cvkgwR9llah1qVR3EzXLs9qjOFbzqo2mAcbmLH9HNYJR5Gqzi/9MAEOC5HWoCX4N1/TLOQ2PFPhiE3iSvKYPpxV8pAhrGyBxXN7kl+vMwKAsN5KCgOCu8A6Qf5HgAwK1viNDJDFSBaqVz9U/B8ThjnmleTOtyeP0JmwjFE9nr44tm8TfUorpo5cXduXandUmzj2f4dNJIWWToTC0TTFf6ocAyJ39ot7dCAoaQDyXrPOIiMAm6W2s2gLJx3+PiFru3u0bfD1QYV6FCUhilS/Frz364Vd6lvZfA8boIfCMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12j+6po2VEaoUEvMTxjDymz5CX/Tn7YyPxOS4TqVBNE=;
 b=awvjH4biqxY632WNl7klxELKHKIXyWhJxm3bc5DV/Qktf7hB7dA2qW1canf6+zxtCYXTMWnQ4jbYBDtW6l6K17DiGHo5QuilHER8YzdU3YNg0eMcHGdazzfW6a3r9dcslSJuHm+JnPdOOkWDIrEwv9COkcsq4xkumkFqkZpCDT8=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 07:26:00 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::45) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 07:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 07:25:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 02:25:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 02:25:59 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Jun 2024 02:25:58 -0500
Date: Fri, 28 Jun 2024 09:25:58 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v42 05/98] hw/sd/sdcard: Trace requested address computed
 by sd_req_get_address()
Message-ID: <Zn5lVkZFeZCWVPtA@XFR-LUMICHEL-L2.amd.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628070216.92609-6-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c99f194-3020-45b9-1be1-08dc97438f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cytLN2N2bFRpMTVBUkdSODFwK0NQbUtRT29vQ0M1aVRJdU15MnN0dVB3TDJG?=
 =?utf-8?B?TEoxRGF5VVQyQ3MwcW5IK0NaVlFpakkzellYNFduVkFOaVpvc1NWT1FOc0V5?=
 =?utf-8?B?blRmSkk0aTJESm1taGV5V2VYeHNpekZiYTYxSi9TczBHTVQydU54bCtPc2pR?=
 =?utf-8?B?aEJydTI1Q0JpYVlmMUpwd3JDaWUvTWQ4TFlvRjNpMkRWUHhSdGdmKythKzVl?=
 =?utf-8?B?SnhsYnp4QWw1MjVyV0pYRHVRcE0weno3OGtNQ1dOYzZPb0xWMFdjSjFITitr?=
 =?utf-8?B?b1h6OHBub0NKQUlLVW9yRU1zRXZxSytXUlJtb08rNVhMOHVtT1c3ZXJmSWZE?=
 =?utf-8?B?ekxRcXdWVTV6TzBRdUZOQ1puMmhmMnlHM0ZpK0RIcW5VN2FHbFpIYjhKdmZP?=
 =?utf-8?B?dVdYRHJXall3WlBoRk9qV0Z2YW1meklLbnpDNm9vcWhTYXBOcnpiUFNuQnBJ?=
 =?utf-8?B?cXdiNm9Ga0RlQjArcFNKTGV1WE9qSThWeHJCekpNSGxid3U2K1V6SXhNQUZP?=
 =?utf-8?B?cXdzcUhTamtLSzVOOSs0bG9Rc2ExajQ4Ky9hNUdrbHNQM1V6WVVvclc0VDNM?=
 =?utf-8?B?MlVpc08vWVphaWRRc3ZacFVsbjJ4M1o1UDZySlhieWo2SWF5eWdtRVRXVjVN?=
 =?utf-8?B?QnRlRndTRWk4eXJsQ3BxMENwS1hXb1h1dXpPYjNqWmNCM21JSnFwTllacy9p?=
 =?utf-8?B?RndselpncUdCRDBhcDJMcFFZRjdnb1pHWjlnbU5QVzV4QVZSRXRnVDlCWW5M?=
 =?utf-8?B?RTFkRFJHbzI4bjNlRnNMNXc1VzhYOEJVNVpPN21aNVZBMS85QUp3QUZjOFRX?=
 =?utf-8?B?MnJDSkI5aURWQTNBTWNNYUlhMVM3cXNTVEF1b0YyMS9ZcVZ6dzN5YlgwRmdu?=
 =?utf-8?B?S2xZbTVkQ0VHUFRIS01wSzNtOEd4ZUFkVGk2U3RVRitRS21DclFPVm02SmxR?=
 =?utf-8?B?Q1VmTVlOM2RkSEQvTDd3R0FCdGR4QjYrd2Z2NGpReGt1MTdYaURxZ1c2N0NM?=
 =?utf-8?B?VXJKb1U4cFJCTG5wY0hCMVVXeHRYNFJFakN1U0QydmlPOU5qUmNkbGorTXZI?=
 =?utf-8?B?SmJGakYxVVo3STN2YmNhdXR1Z293VWVCUmNNYzJvVDhrYm9SZ05aWW1xdWZE?=
 =?utf-8?B?Q29qVktPblM0NXhSTGdCaWc1RWlNVjlaaVlQWmVYSjB5ZVdia3ozZEgvbEZa?=
 =?utf-8?B?Y3VHbDZxMHRFWG9lcllxZ3hPNmU5UXNVa0g1aDBHYXhsUXhpKzBDYkJKSm5D?=
 =?utf-8?B?QzMyejBCWGlaMDJqSVZyQ2svSXAxTEhqMkhGcGlpMW93V3h2LzV0NUxOdnVk?=
 =?utf-8?B?Q1ZCVlFrUjlqNXgrOUhpTmxzOG9tcFZVYndGWFZFbXZUa1BDRER0dWZvR2NQ?=
 =?utf-8?B?eWFZTmc3TTRUaGdvalpwU0UwWlFqY2p6aVU0VGJZVTJselF5U3ZQcHZldjZ2?=
 =?utf-8?B?RURCT1pNMmMrc1FqRmV0UUpYcEd1VGlhWElVTlRVTlp5YnB5RVVaSk5TS1Zv?=
 =?utf-8?B?RjhCSWczRjYvM3Q2NXBtQVNYa1JhY3ZYb2JKencyb09OMzY2dkNoNDlKRXo5?=
 =?utf-8?B?Ny9XWWZ2aVczYUM0WVJkblp6eXduQ1R3bFV6ak9hZktMOFJmRWtVK05SeVZz?=
 =?utf-8?B?bVhBN2VpSnowN0JFOGlUdXkySElHQjU3V3lyaVBXakJIeDIwNFJWOTFyRERI?=
 =?utf-8?B?cEtpeGk1SWErUkxaWldod1l6RGZjSEVrN0RLVHp4VHp3QWlTUC90em44RjEy?=
 =?utf-8?B?Mld0cnlCYU83d21QZVJuYXFNYnhIaGVNZFYzaitMT2thaGJ0cHVrMG05dFU4?=
 =?utf-8?B?a3lHMld3QXRoUTNQOUJnTlRaYXJCRTRJM2N5dkJxMThka1htdlNwaFZzalVk?=
 =?utf-8?B?ZWhDdHcrQzZpOStaZEtqSHdxQ1NlOFlzQlhmLy9UNjAwYmd2Q3IzcVAwZDFz?=
 =?utf-8?Q?7mBG+7nmgodQ6+bMqH4tPfRCBebnZNrf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 07:25:59.9385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c99f194-3020-45b9-1be1-08dc97438f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
Received-SPF: permerror client-ip=40.107.243.86;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09:00 Fri 28 Jun     , Philippe Mathieu-Daudé wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  hw/sd/sd.c         | 9 +++++++--
>  hw/sd/trace-events | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 090a6fdcdb..464576751a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -608,10 +608,15 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
> 
>  static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
>  {
> +    uint64_t addr;
> +
>      if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
> -        return (uint64_t) req.arg << HWBLOCK_SHIFT;
> +        addr = (uint64_t) req.arg << HWBLOCK_SHIFT;
> +    } else {
> +        addr = req.arg;
>      }
> -    return req.arg;
> +    trace_sdcard_req_addr(req.arg, addr);
> +    return addr;
>  }
> 
>  static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 0eee98a646..43eaeba149 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -50,6 +50,7 @@ sdcard_ejected(void) ""
>  sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
>  sdcard_lock(void) ""
>  sdcard_unlock(void) ""
> +sdcard_req_addr(uint32_t req_arg, uint64_t addr) "req 0x%" PRIx32 " addr 0x%" PRIx64
>  sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
>  sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
>  sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
> --
> 2.41.0
> 
> 

-- 

