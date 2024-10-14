Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC8CD1813F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 20:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0RIu-0003Hv-3w; Mon, 14 Oct 2024 16:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1t0QvB-0007dc-5D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 15:40:01 -0400
Received: from mail-co1nam11on2045.outbound.protection.outlook.com
 ([40.107.220.45] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stewart.Hildebrand@amd.com>)
 id 1t0Qv9-0007Fl-4x
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 15:40:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acGXjQhoTlI13Cho0+B/muvkVH4JmsPGZDFt21J01nCW8LYhta6iM9812epKB1vyhIoTMkDNMaLFAVOjdODiK+sZ01TSeLjN8F6bhLmYLAqHZmgUiKWNVBwZGyurcDcYZntvyMoaa828xNlrMwvydF+39KDAWGUlF/baOQoeeW9LZ6/HZn0WwwQ5BVS0qtCNcbMA5QH1ngvKtdrPySB9Unb2/0FuE3VCofxAiZRoyRfekr2vZjjpc5UIRo0R1raB8DFTK4U82b69+cBB7u7mKgROW63/0CenSczl84McydHbtb8+VuYoEbjatY/waSHZtOZcHmApq8vlPNi4phH47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So1Uuts7Om0gG4P7bfTl+P+vFuUUY52uL60n03Dy22k=;
 b=hvj2GOeVa2zhCY8k0HTQ+eOHVQ1zTzpkLRMu0Hod7W2LhzdYfOqsw0borW8+K+u8ttSYmyovNyv0o7JIs6qaH8Zxt7/3yATflAz4gd2r+IgVn/7vG7sZw/g0pGd1xA3eoIxLdyBaeWOIPRnfwz46EK9ddRNTD+kIQAfSSpJRXKh0qd8yWR/eJ3iQEwJz2BPwpO28vRj8l8MxwZKlq+AJMzDbqCTSTpXQLv+UOqYj6AdVyMm6ucIFbH6cFoB6t8dtHjXmD4jauBvb0H4aOh+S06nNYiCsnq6ZE2QRr449cJdOIjc3gy4gxQczlumH0PVuIrQHTh3iKWG/bykx06vYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So1Uuts7Om0gG4P7bfTl+P+vFuUUY52uL60n03Dy22k=;
 b=QnhUpjuz9hIHTIAPIJXp6Dl2HIO7QuHDiPkgZpHOYytGzIPpRMlNl1UllG67jxvgvhpfxlmsmTyN9atS5CtPhMhALQ2NfDAegoXoz8JaHblYTuY9AUHm7wCV/TYQDWoaU/yu79P3o5BJAlYYgtPHnRl2p5N5mwDCiam+2GgZafA=
Received: from SN7PR04CA0048.namprd04.prod.outlook.com (2603:10b6:806:120::23)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 19:34:52 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::52) by SN7PR04CA0048.outlook.office365.com
 (2603:10b6:806:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 19:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 19:34:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 14:34:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 14:34:52 -0500
Received: from [192.168.122.223] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Oct 2024 14:34:51 -0500
Message-ID: <fb14e4dc-b8ea-444b-8eee-551d05b7217f@amd.com>
Date: Mon, 14 Oct 2024 15:34:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC QEMU PATCH v7 1/1] xen/pci: get gsi for passthrough devices
To: Jiqian Chen <Jiqian.Chen@amd.com>, <qemu-devel@nongnu.org>, "Stefano
 Stabellini" <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
CC: <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>
References: <20240516101338.86763-1-Jiqian.Chen@amd.com>
 <20240516101338.86763-2-Jiqian.Chen@amd.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240516101338.86763-2-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0b5aa9-2a23-4e54-efc0-08dcec874681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG1ubTdPZ1FNVVVOTWhLbUltU0dhajh4V0JzQ25wN3hRc0J4Z1RKRVBBNGE0?=
 =?utf-8?B?c0JMbEZaRmdNdUdodmdNU0RYZ3dvVGo1a2l3bmN2THFsckRrS21zbXE0dis3?=
 =?utf-8?B?eDBaTDdOS0dtS2xqSW54MXg1T2NFUTdLaW5OTVBTL1lJSVdSZ0gwendpbXJG?=
 =?utf-8?B?YVpGQkdvL1hmVFNvQzhEYm5UVUhUNmdCSjhSVXYzUE1ic3VsenlFMitrUDJj?=
 =?utf-8?B?bGpWZ0htU2hvYTNHZmpPMkswOXRiZEd2WU1lUThHU3FLdEZtWmQzN3FEdUwx?=
 =?utf-8?B?cE50STR0OXh1a1IrUTA1M3IrNHNLRmRlUWVsT3lEckowOFZjR1dEWmkwOFE3?=
 =?utf-8?B?dDhyc0ZEQUVZTGc0ZHVqUDVWNFl2QmpBdGFxclFENHYrQlVpZS9BZzhDcmRM?=
 =?utf-8?B?RFBpMnhlbE1CZ3NwcEFmWFFKazAxR3RpWmc2MnpuUFRHNEdJWU5acU5GcXUr?=
 =?utf-8?B?YnRGYWdFeksyR3RVclNzcElRTEJSZ0pnUHh6RHZ6azBuNDc2bmtKWDlFR1VO?=
 =?utf-8?B?VW5HNGhBN3BzWk0yU1RYYWRkYk1KYmVwb2VXMmVFczNUZlVnb2F5cG44a2tL?=
 =?utf-8?B?UE83cDU0bVVlL2lSZDlVSVhuR1c5ZzYvRW1yOEl0cm4rZjhmNjJvUkpXYytP?=
 =?utf-8?B?cjJGYUJqTVc3N050K3hENUhvc3Aza0E5R0NvNGduM09XN1REcXBpQmdLZHdW?=
 =?utf-8?B?UE4rb3VEdHdrZ3VVM3pNV2wvN1JmWXRJbnEzeEUyaU1pcm02eHkrNlJ1dWdu?=
 =?utf-8?B?M0prNExTZjdsYzQxenZ5Q0VJMjIwazYxVXZEVDFFcG1DR0dTek91dCtLci9t?=
 =?utf-8?B?enNYZitZa2tnaXdNMTM3aUtkZVkwVnVMdTVUUU1lUWZiWmdNdm9EZHl4YjFE?=
 =?utf-8?B?WXhHNUIwaFN2M1FoZUgrRVZGSzdYMEwzWUdhVDdBaVJEUWdxUGc0SzhmUXJt?=
 =?utf-8?B?OGprbUxpOFNYYldhL3dmblZNOFBhcHBFUGlVWVdvcWRENXNuckR2UVh1TnZN?=
 =?utf-8?B?SFlQVTlyUmVIeHhwOWFCUUY2VVhDUmNkMTVqVW82M2IyZTAvU09xRUROa2p6?=
 =?utf-8?B?MHhyOTlNbXBwL0xjZ0dNTWRGSGhnemFsVkhRaEE3L3FjaUoxbHFUSC9Tb1k3?=
 =?utf-8?B?QU1pWUU1Uy9JbnNyQytWSFF1MzBLTy9nL0FrUEJZc1orL09Od3dLNEdldTRK?=
 =?utf-8?B?T1d3eUVDYUpCVkt0Q3N2SXRqbU41dG1xWE4yc09haG5YU2hHa3J0SVcweS8z?=
 =?utf-8?B?MU1sYlhCSk5OVERjNUo5UnBFNDQxNm1udENCOTFxbkpDSHFFM2JiSXN4S3pj?=
 =?utf-8?B?cnZaQ25KWmN4cWJ4aFVzS3FUQThtcUhsL1ZDT0JKblF0cnB3OElsWUFTVXJJ?=
 =?utf-8?B?dHNtbkE2ZFAxejY5dVZxOW9UaG5jS2d2bS9HRWYwanVnVUkzMlZ2ZnErWHlO?=
 =?utf-8?B?RElibHRCYjRxdmFEbnhWdC9tcGFoTnR2cHd1ZDlKSWZDSlVDeDNoWlFETWNy?=
 =?utf-8?B?azhqQUdWTXNnVjduNFlnVVFXMVlBWjA2VlZod2RCVDhNUTJCVm0zSU1iYzBi?=
 =?utf-8?B?aHlnN20yZ3EvR3c5RWpXTFoyT2UvVkRvQ0xzVmp6V20wR3RoLzlnejhhUUxl?=
 =?utf-8?B?aE5nTk1LQWU5RXV3OWsvdTNkd3dJNkNTSlZsdnRrTk9yTWtwOHg5aWVVMzFJ?=
 =?utf-8?B?NUZ1L1d6Y1RSV0t0akI2YUFMTlEyTUx5Zi8yWGJ3UTVITWxVbzJVM1ZmcHNq?=
 =?utf-8?B?VzZqaVBJM3lKOTcwUzVHZW5PNTVpK1BwWFMwaWo1czFpZzk0dU1hbVRJMDE5?=
 =?utf-8?Q?CF9zkBRhritVeQOuPZqqw52et+NxbttaC2UX0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:34:52.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0b5aa9-2a23-4e54-efc0-08dcec874681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
Received-SPF: permerror client-ip=40.107.220.45;
 envelope-from=Stewart.Hildebrand@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.252, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Oct 2024 16:04:30 -0400
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

+Edgar

On 5/16/24 06:13, Jiqian Chen wrote:
> In PVH dom0, it uses the linux local interrupt mechanism,
> when it allocs irq for a gsi, it is dynamic, and follow
> the principle of applying first, distributing first. And
> the irq number is alloced from small to large, but the
> applying gsi number is not, may gsi 38 comes before gsi
> 28, that causes the irq number is not equal with the gsi
> number. And when passthrough a device, qemu wants to use
> gsi to map pirq, xen_pt_realize->xc_physdev_map_pirq, but
> the gsi number is got from file
> /sys/bus/pci/devices/<sbdf>/irq in current code, so it
> will fail when mapping.
> 
> Get gsi by using new function supported by Xen tools.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

I think you can safely remove the RFC tag since the Xen bits have been
upstreamed.

> ---
>  hw/xen/xen-host-pci-device.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716a2..2fe6a60434ba 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -10,6 +10,7 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "xen-host-pci-device.h"
> +#include "hw/xen/xen_native.h"

The inclusion order unfortunately seems to be delicate.
"hw/xen/xen_native.h" should be before all the other xen
includes, but after "qemu/osdep.h".

>  
>  #define XEN_HOST_PCI_MAX_EXT_CAP \
>      ((PCIE_CONFIG_SPACE_SIZE - PCI_CONFIG_SPACE_SIZE) / (PCI_CAP_SIZEOF + 4))
> @@ -329,12 +330,17 @@ int xen_host_pci_find_ext_cap_offset(XenHostPCIDevice *d, uint32_t cap)
>      return -1;
>  }
>  
> +#define PCI_SBDF(seg, bus, dev, func) \
> +            ((((uint32_t)(seg)) << 16) | \
> +            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
> +
>  void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
>                               uint8_t bus, uint8_t dev, uint8_t func,
>                               Error **errp)
>  {
>      ERRP_GUARD();
>      unsigned int v;
> +    uint32_t sdbf;

Typo: s/sdbf/sbdf/

>  
>      d->config_fd = -1;
>      d->domain = domain;
> @@ -364,11 +370,16 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
>      }
>      d->device_id = v;
>  
> -    xen_host_pci_get_dec_value(d, "irq", &v, errp);
> -    if (*errp) {
> -        goto error;
> +    sdbf = PCI_SBDF(domain, bus, dev, func);
> +    d->irq = xc_physdev_gsi_from_dev(xen_xc, sdbf);

This was renamed to xc_pcidev_get_gsi.

This also needs some sort of Xen interface version guard for backward
compatibility since it's a new call introduced in Xen 4.20.

> +    /* fail to get gsi, fallback to irq */
> +    if (d->irq == -1) {
> +        xen_host_pci_get_dec_value(d, "irq", &v, errp);
> +        if (*errp) {
> +            goto error;
> +        }
> +        d->irq = v;
>      }
> -    d->irq = v;
>  
>      xen_host_pci_get_hex_value(d, "class", &v, errp);
>      if (*errp) {


