Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F843C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 07:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOubI-0003Ae-Qv; Wed, 03 Jul 2024 03:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1sOubE-00039o-Tn; Wed, 03 Jul 2024 03:40:22 -0400
Received: from mail-bn7nam10on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2009::620]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1sOub0-0004B2-1J; Wed, 03 Jul 2024 03:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcwUhtXltJX2llOlP/ekSUCVMIt1J3gzya9vKftlTdBPWRY2FRZlHjNhC2QO01O1u4EDzukGubDSNXWQI6hsuKfdOv1w0pHvwzwO4xGF/KfyrCem5WAR3Wa4XI2HdXAKG79Fr2V/XHRymM6n9no3gKWzmBIE0eejVqoFJ1lGOf050cNjbeEAXvV64CCguftLvi/l4jujyArNR7z6j0SQblBvzEqQwbmTK7y08vBsm4XMbDhfU2FEesWlBdD6b05MmRU+wesWwGMoB9N9NqKLLC1swHJDEuBh+7T5CIDw7/eXSvWo8z9JpipZx+ShdF+bF8nldJoEcrIpxSyfDl7EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPvL4ggqIom/xhUdt3RWu6OsL6G42gLFcxksNwpfAQg=;
 b=CNY+XFr1WySC1/Lw7IOqUMWclRlmtfVQ4jNq+76VzMNqTZaCtJzunoj7kLj4orig/U8EtipdntFzHVJZIQtJa971MeuYgog/R/oIQgffCLt3rzQbTKzRBsA/QOtrL+RPhHy42IaZw3p3pbp7eK7NW1sKzCNOBZ5pyG6tHOYHfrBmajcNZRG5HuAVbX5EmHP9O5RefTOg6fLLFNPWtG1QFmAqHXGQC0+39+qjVtOa7sDCTjxRDxYtFsHGu3yGxaOIMA1MYIRnD3nqHJqAKS9TOT0CQaJ6adMErOLjXPCu/7nejm+vlkLoJGbjenvSleJjuyqdGGuCgrcI33aacj90iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPvL4ggqIom/xhUdt3RWu6OsL6G42gLFcxksNwpfAQg=;
 b=fM6J32EW6TZWdnTbNQKmzW/6WFnx0r/AqD7eciJuk0kwAT1/nGhRMGu3yJ8EvnpXR8XnKHi2eJQTQmvPlCkSOXRuvhD4Sf2E7pHx6PpgMUQr1JqO6iu7dOiqn8MJ1ABAQU5vS2ZpVw8LtqghD7pBr8ZTgFBoUXZqxGVRGrpxFag=
Received: from BL0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:208:2d::44)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 07:39:57 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::6e) by BL0PR03CA0031.outlook.office365.com
 (2603:10b6:208:2d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 07:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 07:39:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 02:39:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 02:39:55 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Jul 2024 02:39:54 -0500
Date: Wed, 3 Jul 2024 09:39:48 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>, Daniel P
 =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, "=?utf-8?Q?C=C3=A9dric?=
 Le Goater" <clg@kaod.org>, <qemu-block@nongnu.org>, "=?utf-8?Q?C=C3=A9dric?=
 Le Goater" <clg@redhat.com>
Subject: Re: [PATCH v43 2/2] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Message-ID: <ZoUAREvcNtlgpK3r@XFR-LUMICHEL-L2.amd.com>
References: <20240702161031.59362-1-philmd@linaro.org>
 <20240702161031.59362-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702161031.59362-3-philmd@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e85ccdb-0afb-4048-20e8-08dc9b3355cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVdHM1ZkaVBudmo1dHROZEdWdDN2Q1lEaDFZWGVWTlRHWFd3TTlFdUd1QTY4?=
 =?utf-8?B?OU4zMTF2ZTRnYXZoemE0ZzhTSFhPQnNjOVJGb3g4Zm5RU0RVTUs1akg1MGpR?=
 =?utf-8?B?VlpSRnRDblFnc3g2RGo3K2REOUxuaFlQQTlVZVZ5MVZ4WXhYdkhCTWg5L2F5?=
 =?utf-8?B?V2MvZ0M5VEExNmJzOFVHRXNYOUFyeTk3OGt4OGxKbzRDSnRYUWpCMnoySHFj?=
 =?utf-8?B?QUJPdDh1ditya05zRkRNdlppbFBDU2I1QjdBT1BoOGMvYlUycDlxN3l5dmNa?=
 =?utf-8?B?UDZyMmFKUDJ0Q0krNE4zY2UwUjlaU1lqcUhJYUZ6ZzJsaUxhTXhoN1RQUkhT?=
 =?utf-8?B?NmdUU1kzY29odzNXWGp2OCs0VlVFOXRLS2J3cldTZ1JiMW40ZHo1aFczRVJ6?=
 =?utf-8?B?eklzR2NsSnRGYWJ2cG8vVFd2TEJZRVd4Rmp1T2FnRzQ0bE5jaVlJYnd5UXpQ?=
 =?utf-8?B?NDFITEljdVA2K2dDV2R0Q2hQTjNyMS9kUFFyTlRRdlRmZjBqb2Njd1BkM1R3?=
 =?utf-8?B?dXRIVjN0K0VjMjJnVS9aTHRPMi9mdlNueXk5amVzeU1WdG9GZnU1aG54QVo4?=
 =?utf-8?B?WkhCUWlURFFrV1dvZ3ZVY3gvanlJUE1uV0RnQ3U1ODJCZWVKaEVxVzVoZy9O?=
 =?utf-8?B?VzRWMGQ1OE9zdUh5V0QyMFZjc0dTbjY3SXVIcUkvWndkRjIzUGVxN1dkRk1E?=
 =?utf-8?B?QmwxdHo4aW95QTQ0czJ3SEZKUHMxT1lJeEFJZ25wL2VhMy84MDlLZnFhc2xZ?=
 =?utf-8?B?TExTT0FBNnA0MUNwU1NqY0JDdzVHZ3piZSszbnkvOXVOR2V3eFdsYmd1UitX?=
 =?utf-8?B?MnJaQlRaQ0hybXdRT21xUDJkL2xWR0tFamxYZjVreC9ZN1U3d09ya0dnczNx?=
 =?utf-8?B?NWFWck84QWlnbFplU3d5eVYrMTM5ZEJmODM0emgrOEhRdkJIMmVkTWJNSCtR?=
 =?utf-8?B?d0hHS0dqMS9uaExEeHhELzArSlhjWlBxTHJtNmE2dTRiSkphdTdYZ2JPbE9F?=
 =?utf-8?B?cnFKRlFmdGtkUFNIWjFUZ2ttMTZUQWJFQnJFQUV0MDV2YXY0Zk9QaE54Um1x?=
 =?utf-8?B?aEZoZ3QxRkR0UTNRUkcvUGdKWDk5MWRwNHpndG1CdXdHL09Mcm9lcVgySW9C?=
 =?utf-8?B?eUJBTUFZVElHTmhHVE5oWWVSOFNtWWl5Y2ZIZjJ3WUNLOXh1Q3htUTRaWkdt?=
 =?utf-8?B?SGI2a1JibHFySXR3d1lSNXVyaTNsZ1JPK05STzJXWW5VVVJqc3BUL2ZDOVlL?=
 =?utf-8?B?eEJrOS80Uk43bWQvMmxGN1NpNDN6bmRySVhhNHdXNDhUb1NObm1FNGhTQmZs?=
 =?utf-8?B?cW5xS2FscU4zK3VhU0ZkbUNaY2xnd3ZUT3lBZVhmRGRDdEpieWIzOEpaMllw?=
 =?utf-8?B?N2o1bjhCL28xUStTeFVrWVhPRnVoYlRWUGNDeU5tYS9KVWxxYkI5cjY0REJt?=
 =?utf-8?B?TUdpUndRbU5SeWd2Wmk5WGVWOFVqczdndHNzcHZSODE0eS90amwzNHgvTnRV?=
 =?utf-8?B?cjlrMEdTVEthWWs2ZTVuN1J5c2RLemxtenNVMi91OERoV0xad2hjNXhuWVFE?=
 =?utf-8?B?Tk1DbDBqUTZRR1ppeGRpWDROM0pQVC9yS0R4WFUwY3pmdmxUUHY4M25KTEJC?=
 =?utf-8?B?Sk5udng2UWc5S3JGOW52ckN3bDVhV1RSZzlkM01oSVlrNnNBc00wOWxsVkY3?=
 =?utf-8?B?S0F1YzVjd2k2d1R3ZnROMk9WbXNFakNiMzJnMktVcjFzdVgrdnp1STJiNzdU?=
 =?utf-8?B?ZUQvWk42NmY4Vmhyb0dpNnRTMmtRa2RyQzUrc2VQWkdVZW9qaTgwZlhETVpT?=
 =?utf-8?B?aGg2eC91OVJHdWNEQ20vVGIzZGpXNzNGSFhzb0IwaE1pWnR0V2pJVWt6UkpU?=
 =?utf-8?B?aHVCT1QvZUlDaGRDRHAwVEt6cmdvb1owb1dCWWZaVitHdERGL2xBdVJsczc5?=
 =?utf-8?Q?JI/iuV1+owOK0urX8kzF78ALKKNjfGto?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:39:56.4417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e85ccdb-0afb-4048-20e8-08dc9b3355cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
Received-SPF: permerror client-ip=2a01:111:f403:2009::620;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18:10 Tue 02 Jul     , Philippe Mathieu-Daudé wrote:
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
> v43: Do not re-use VMSTATE_UNUSED_V (danpb)
> ---
>  hw/sd/sd.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 808dc1cea6..418ccb14a4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -153,6 +153,8 @@ struct SDState {
>      uint32_t data_offset;
>      size_t data_size;
>      uint8_t data[512];
> +    uint8_t vendor_data[512];
> +
>      qemu_irq readonly_cb;
>      qemu_irq inserted_cb;
>      QEMUTimer *ocr_power_timer;
> @@ -719,6 +721,7 @@ static void sd_reset(DeviceState *dev)
>      sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
>      sd->wp_group_bits = sect;
>      sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
> +    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
>      memset(sd->function_group, 0, sizeof(sd->function_group));
>      sd->erase_start = INVALID_ADDRESS;
>      sd->erase_end = INVALID_ADDRESS;
> @@ -835,6 +838,7 @@ static const VMStateDescription sd_vmstate = {
>          VMSTATE_UINT32(data_offset, SDState),
>          VMSTATE_UINT8_ARRAY(data, SDState, 512),
>          VMSTATE_UNUSED_V(1, 512),
> +        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),

Don't you need to bump the VMState version then?

>          VMSTATE_BOOL(enable, SDState),
>          VMSTATE_END_OF_LIST()
>      },
> @@ -2187,9 +2191,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
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
> @@ -2261,12 +2264,11 @@ uint8_t sd_read_byte(SDState *sd)
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

-- 

