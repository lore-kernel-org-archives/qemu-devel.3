Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBBCC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOC3i-0002Yv-AJ; Mon, 01 Jul 2024 04:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1sOC3Z-0002YC-R4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:06:37 -0400
Received: from mail-bn8nam04on2050.outbound.protection.outlook.com
 ([40.107.100.50] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1sOC3X-0002bX-CI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:06:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh/EFitqUXlXYUDqL1n2B+nVuHWhVNhoUd9AodzJW+jk6Vry29bWtOOhNLMc2yIYyENzlEFvP5Xp/c06heboAjIrIc8yiqkbdUPaEbebbmeDYJ47uc7fVcf6EmlthEJZt0eA22clsF/qdROMmUqIoSy8VOBuZfZ8h7e57AYPtP/jdt/LI1O39eJp8qnQ56kOuwDEZ2snWL0TH5sfFeTuz1IHzRSIjUo9dC3yFCa9RJP/vqku6SAlUsgbFH2mYteANdnocJbFuxmR5KXe47lBaow0xwcAFPAuNVZo/sq23k+SosX6Rvqm74VTP1HKM1ixtOieQg1rZZoQzOMBeQn2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1g9sPnrwiZHDWfz8wB0qAgWP1VydR0dSMWV81H9Tio=;
 b=dcG7KxmrTYfwV1I/JtjPunwwb4krnMcK5zBGfKAlpKDv+qQ5MrUtf9BbWeU49lZ/6OLZ0FabdBuTmoqRwAnh+B/gpTEZfivixumvdFNZgOVOioEzqGzKIu2O0ZkcchTY+Ya3k0vrAfzeMQs0SRlxBB/1W6g/KLBR4b2lSeVsFQNJiim3ym6tPKY8NOxqpXkH0YCx/aawWV3jefO3K9EbZhWAoENhP6pdGN1uzC57ZqmUlhB1kMrWCnB3Obe0gfB+qIZ20HSddbw0FelcU/9ZkvGpMnc2V68K9YEBhKywBD7+o3d6f8/qAThVtwqp4u+bmeNcMigqKgQU3/KC+XFtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1g9sPnrwiZHDWfz8wB0qAgWP1VydR0dSMWV81H9Tio=;
 b=O9Du/LM2iAMB1Rz9Ki59O5j+K8+DPDkwX4uqokhfz9ByReQl/k++pfUYbdKsJBmssyK1rhHxALj9/+2bAY5xoWpGO+ALWqX86S0xpeh/zXHHlp6HllZH6TOTD9GarBCGKo264I3wpCL1QRCb05on/F5gMEygU/evwj5cOvZFiw4=
Received: from BL1PR13CA0179.namprd13.prod.outlook.com (2603:10b6:208:2bd::34)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 08:01:28 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::e4) by BL1PR13CA0179.outlook.office365.com
 (2603:10b6:208:2bd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Mon, 1 Jul 2024 08:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 08:01:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 03:01:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 03:01:24 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Jul 2024 03:01:24 -0500
Date: Mon, 1 Jul 2024 10:01:17 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v42 06/98] hw/sd/sdcard: Do not store vendor data on
 block drive (CMD56)
Message-ID: <ZoJiTdo0yr6V_rgN@XFR-LUMICHEL-L2.amd.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628070216.92609-7-philmd@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 910bb12e-1f47-4860-c605-08dc99a40282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlloTGRVZm5aeE5ZbVFuZEVWekd0cnFocUNtTERzajllbmVjQy8yRzNzT3ds?=
 =?utf-8?B?WTZvU2JJTXZSalZBMFRISUtuaiszc0d1UWZONmxDNUdXKzNDeU5nRkJLNTFS?=
 =?utf-8?B?K3MrUC9FVFl5WHNHNkZ2ZFB3cHd5RzZYRWFvVjlqNExQaERja3BRd3NFNk9a?=
 =?utf-8?B?VnY5VXAxL2Q3Ym5VZTE5cjZ0TDZWYkRqOWdkWktZU3dKMUw3OVg2S1JHY3Zt?=
 =?utf-8?B?RDg4a25OWi9YbCtHZjhWb3VrU3ZEVWQxNW11TlJnOG0vTkUyQjk1cTdDZ052?=
 =?utf-8?B?aXN5OElqclF6d1JhcFBnTmVlT2pVZnppTDFmeDZ0YTgrQkZFTFg2R3grZTA2?=
 =?utf-8?B?ZWpHaFZ1YjhnZWJFdzg1R3AyaUxTOTYwQ2NwazMyOU1BZGhtSDZCYzAvQkFh?=
 =?utf-8?B?NlVEWWlUSDdJYWt2MDJyRGY1N3pBQnp6amVXK00yOTBKeVlLa20rTkpCMFpl?=
 =?utf-8?B?VUpqMTZMeUtzczdMK0ZYbHpTOXdiMTZ0UzVpR0lKNHRMeUh5dUN1dE9MUktX?=
 =?utf-8?B?VUFkRmNDVS9OZ21aN3NqNVRXR3ExdTRuN0xHZjJBanViRGRLNlVzdGZ2K2s1?=
 =?utf-8?B?TndiZG9pNHQyN2h2eHI1YTliQ3NXY2x6MllZK1BpU2daTW1lc3BhMncyd3or?=
 =?utf-8?B?dU9vRHJBamVyUTRCU09IV21TN2Q0NjlvRmt6RUp6Nk5YWXdqdnk1YWI1RENN?=
 =?utf-8?B?cGUxYVBLNUltTTBIdnEvZ05pdENBVHZ6UzVnTmlJdkVmZ1ZqT1kzbXhkTnBt?=
 =?utf-8?B?cVI1dVBuN0s5cmd0ZG5OL2hYK002bjZYdkxwaHNRaXRnRi85a2Jtcm1yNkJt?=
 =?utf-8?B?Z0tzd1c2azVBQmUrSW1VNElJbWw3Ukl2bEE0UU1Lc3YxK1UrMEFtWWVCcEFZ?=
 =?utf-8?B?NHIzUmo2S3RoRHVrSUdhcS9iWng4aHByR2tVRERhVGIwMUExemgwRldEMTJr?=
 =?utf-8?B?UitwWFZKRnI0VElPNzZ0VEN3U2NiaTZSME40OWhTVjlHZjBkcnovamp5QS9m?=
 =?utf-8?B?elFpdlZNUHlIVDZBU09OaXBCNktTZnM1TExEU1hJWmcvZFk1UUUyMkgreWZW?=
 =?utf-8?B?L0kxQnhCaHFLN3k2cjNzZko4ckJoNUM4bUxzYTJBRE5ETmRQMjMyeUx2SGxy?=
 =?utf-8?B?c2c0T0tnNlJBV2FoUHI5U1cycVVOcENNVzZlYnFDNW5XRjdnOG1qMkhCaGVl?=
 =?utf-8?B?VUh2SVFHNmhvOUZCYUFSK3FWSHhybVA5ajdhMkhrRnY1WWt4NnV5RHNsV0Jo?=
 =?utf-8?B?ZjZQQVNzc3ZKbkx2eDlCL1hScXlYbk00dTd3K3FpZjF2SE16UkdnZk10U0Yr?=
 =?utf-8?B?L3ppczVLOGRHSlFXR3d0QWhJbnI4WGlxTWNJT2RHVUlIeU5pSG1MMmF2aERG?=
 =?utf-8?B?a2diM2ZhdGhMMGlJQzZRbkRaTGhpanZGWlV4Zndmd2N2MHFqbjN5cEhTUEdp?=
 =?utf-8?B?KzZUMFBMYkl5Y2kzczFrZkdVRW1nV3NKZTZXb2szNGljaHVYV1ZDMXFHaWJL?=
 =?utf-8?B?VVljZ1FMY1lxVFpIOGNleGRPVGtQUEFzYlYxMTJ2dFBJdTJEcDlERGFCUVN1?=
 =?utf-8?B?MkNkSWVmcDZwRjZuYm45SFNta2RZWE14OSttTnRueUczU0Q1N2NVK05CeE0v?=
 =?utf-8?B?LzVxeCsyR1FmSWxWektlU2k5TDFPVlJOS2NNK0FpcXRXRzRqRnNpcSs4L3JD?=
 =?utf-8?B?aXVkQTNudGtsWlNBV1FtWnI0TXlzWGs3R1Rqa20yMEJnd1BIbnEvYWNNV3NX?=
 =?utf-8?B?Q2p2WWlRYzBFT2gvdC83SlVvc2RpMmFOY2RCOHEwWGtqVEtxUVVMQnlnczBT?=
 =?utf-8?B?dENxRTBldlJ5ejdsZWRHWVRlZXZrSXJBd0xCN25IanZhNzd1ZXNlMVJ5Z3Fj?=
 =?utf-8?Q?YdgNq65tkYsf0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:01:27.3078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910bb12e-1f47-4860-c605-08dc99a40282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
Received-SPF: permerror client-ip=40.107.100.50;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> "General command" (GEN_CMD, CMD56) is described as:
> 
>   GEN_CMD is the same as the single block read or write
>   commands (CMD24 or CMD17). The difference is that [...]
>   the data block is not a memory payload data but has a
>   vendor specific format and meaning.
> 
> Thus this block must not be stored overwriting data block
> on underlying storage drive. Keep it in a dedicated
> 'vendor_data[]' array.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>
> ---
> RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
> to be the same size)?
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>

I'm not sure about this migration question.

But IMHO you can simplify your implementation to avoid having to store
and migrate this vendor_data array. After some research on this command,
I came to the conclusion that it's used by manufacturers to return
device health related vendor-specific data. (E.g.,
https://images-na.ssl-images-amazon.com/images/I/91tTtUMDM3L.pdf Section
1.6.1). So I guess you can simply discard writes and return 0s on reads
(or "QEMU" in ASCII or... :)).

> ---
>  hw/sd/sd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 464576751a..1f3eea6e84 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -142,6 +142,8 @@ struct SDState {
>      uint64_t data_start;
>      uint32_t data_offset;
>      uint8_t data[512];
> +    uint8_t vendor_data[512];
> +
>      qemu_irq readonly_cb;
>      qemu_irq inserted_cb;
>      QEMUTimer *ocr_power_timer;
> @@ -656,6 +658,7 @@ static void sd_reset(DeviceState *dev)
>      sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
>      sd->wp_group_bits = sect;
>      sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
> +    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
>      memset(sd->function_group, 0, sizeof(sd->function_group));
>      sd->erase_start = INVALID_ADDRESS;
>      sd->erase_end = INVALID_ADDRESS;
> @@ -771,7 +774,7 @@ static const VMStateDescription sd_vmstate = {
>          VMSTATE_UINT64(data_start, SDState),
>          VMSTATE_UINT32(data_offset, SDState),
>          VMSTATE_UINT8_ARRAY(data, SDState, 512),
> -        VMSTATE_UNUSED_V(1, 512),
> +        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
>          VMSTATE_BOOL(enable, SDState),
>          VMSTATE_END_OF_LIST()
>      },
> @@ -2029,9 +2032,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
>          break;
> 
>      case 56:  /* CMD56:  GEN_CMD */
> -        sd->data[sd->data_offset ++] = value;
> -        if (sd->data_offset >= sd->blk_len) {
> -            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
> +        sd->vendor_data[sd->data_offset ++] = value;
> +        if (sd->data_offset >= sizeof(sd->vendor_data)) {
>              sd->state = sd_transfer_state;
>          }
>          break;
> @@ -2165,12 +2167,11 @@ uint8_t sd_read_byte(SDState *sd)
>          break;
> 
>      case 56:  /* CMD56:  GEN_CMD */
> -        if (sd->data_offset == 0)
> -            APP_READ_BLOCK(sd->data_start, sd->blk_len);
> -        ret = sd->data[sd->data_offset ++];
> +        ret = sd->vendor_data[sd->data_offset ++];
> 
> -        if (sd->data_offset >= sd->blk_len)
> +        if (sd->data_offset >= sizeof(sd->vendor_data)) {
>              sd->state = sd_transfer_state;
> +        }
>          break;
> 
>      default:
> --
> 2.41.0
> 
> 

-- 

