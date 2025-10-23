Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F686CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBnMc-0006rA-9N; Thu, 23 Oct 2025 00:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBnMZ-0006q1-Qs; Thu, 23 Oct 2025 00:55:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBnMX-0003r4-Ha; Thu, 23 Oct 2025 00:55:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHA7KK030688;
 Thu, 23 Oct 2025 04:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=j9VOuN
 bDCbbJsnURWKsBD1t9d+Sl0uC1D2/+PmeZepg=; b=BPdCKUtbiIIah7a/zQbaG+
 LSplKjBjqkc/9ULPUCLxTSYL0dYIsstaBO5Ip01em3tUB3hamyzbv10T9XVZYt/a
 ymqFiNRRdUW3/2ghllmIF9eEehk9/vIZRxi8cNMHm40N18kC6npHdBCcWADZW+l9
 TfiuQ1ZqU5Sf6o5ADPu/NMlb+EoGrunxIUtHdDyR+wWyO1IEFjO6byJ2Kvqa3Lgm
 OVCRaDelOCT7NQg3fnSCjtTBJmgWxu0GWwvOAxuy8BlKHNQ4a2qEsAPBPnSxW2vQ
 asCb37vsCiJNzXimV/FOW8Rl7FBJZLT+uF1mNPl4JXvFUL/kECyqK+Stv4ItrZPA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s8brq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:55:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N4tdgE011973;
 Thu, 23 Oct 2025 04:55:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s8brm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:55:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N25nk8024686;
 Thu, 23 Oct 2025 04:55:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk3xu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:55:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N4tcWQ33227292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 04:55:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E66AD58065;
 Thu, 23 Oct 2025 04:55:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2997158052;
 Thu, 23 Oct 2025 04:55:36 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 04:55:35 +0000 (GMT)
Message-ID: <9889b27c-98a7-4ff3-8552-9071d59307c1@linux.ibm.com>
Date: Thu, 23 Oct 2025 10:25:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] hw/ppc/pegasos2: Remove explicit name properties
 from device tree
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <fa36ab5a04e10c6acb89583f646aad83df2b0b13.1761176219.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <fa36ab5a04e10c6acb89583f646aad83df2b0b13.1761176219.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: shayLBZcniBYV6PPk5z-aHAcWQFBKN58
X-Proofpoint-GUID: bolkYo-23oFZIls7PjbSXpj-x7bzjctQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8gl2wqdkhl0d
 hYr087nd88bw2sfmHuKcCha60lHHHez7QB4VlRXslIlwWmgCyupAjekxksiA78ntzsgenLnnVL3
 mjuQ6jJuxMI/fRDf3l2jlKS5THB/9f3y0m9yXyqAxEmNhqLz33zw/fabMpzlg7jpBnhtIJ2P9k5
 DVi+rjulBLV8WJuk6M9a0vlkGNABA2wv4GdWgVX+8EfnwmrN8nWegah97QwcSxZ09MinBiXqf/7
 sbGLKU/YfGDgnX9fcNJwTumzIFzOWfYPtCWaP6i1dnUYG0dHS4jPUuSVbQLooK0iS7GJ3bbOcEX
 T4xY2totu0aPCQouRXiQwUH4VZyOFRAIujHoaR/qUvo0X80VuK1WCr7NzOn+6SBEr+84Xvx/e4r
 XxCBby/y+YJIfBn12Dm9DemgjvRWYw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f9b54c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=_I6nGFSwKH0ytRiJRrMA:9
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/23/25 05:36, BALATON Zoltan wrote:
> These are not needed any more now that VOF can handle it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Harsh Prateek Bora <harshp@linux.ibm.com>

> ---
>   hw/ppc/pegasos2.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index e15cf96427..73995624e5 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -662,7 +662,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       qemu_fdt_setprop_cell(fi->fdt, fi->path, "#size-cells", 1);
>       qemu_fdt_setprop_cell(fi->fdt, fi->path, "#address-cells", 2);
>       qemu_fdt_setprop_string(fi->fdt, fi->path, "device_type", "isa");
> -    qemu_fdt_setprop_string(fi->fdt, fi->path, "name", "isa");
>   
>       /* additional devices */
>       g_string_printf(name, "%s/lpt@i3bc", fi->path);
> @@ -677,7 +676,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(8);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "lpt");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "lpt");
>   
>       g_string_printf(name, "%s/fdc@i3f0", fi->path);
>       qemu_fdt_add_subnode(fi->fdt, name->str);
> @@ -691,7 +689,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(8);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "fdc");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "fdc");
>   
>       g_string_printf(name, "%s/timer@i40", fi->path);
>       qemu_fdt_add_subnode(fi->fdt, name->str);
> @@ -701,7 +698,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(8);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "timer");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "timer");
>   
>       g_string_printf(name, "%s/rtc@i70", fi->path);
>       qemu_fdt_add_subnode(fi->fdt, name->str);
> @@ -716,7 +712,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(2);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "rtc");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "rtc");
>   
>       g_string_printf(name, "%s/keyboard@i60", fi->path);
>       qemu_fdt_add_subnode(fi->fdt, name->str);
> @@ -729,7 +724,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(5);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "keyboard");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "keyboard");
>   
>       g_string_printf(name, "%s/8042@i60", fi->path);
>       qemu_fdt_add_subnode(fi->fdt, name->str);
> @@ -743,7 +737,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(5);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "8042");
>   
>       g_string_printf(name, "%s/serial@i2f8", fi->path);
>       qemu_fdt_add_subnode(fi->fdt, name->str);
> @@ -757,7 +750,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
>       cells[2] = cpu_to_be32(8);
>       qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "serial");
> -    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "serial");
>   
>       g_string_free(name, TRUE);
>   }
> @@ -846,7 +838,6 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>           j += 5;
>       }
>       qemu_fdt_setprop(fi->fdt, node->str, "reg", cells, j * sizeof(cells[0]));
> -    qemu_fdt_setprop_string(fi->fdt, node->str, "name", name ?: pn);
>       if (pci_get_byte(&d->config[PCI_INTERRUPT_PIN])) {
>           qemu_fdt_setprop_cell(fi->fdt, node->str, "interrupts",
>                                 pci_get_byte(&d->config[PCI_INTERRUPT_PIN]));
> @@ -916,7 +907,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#size-cells", 2);
>       qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#address-cells", 3);
>       qemu_fdt_setprop_string(fdt, "/pci@c0000000", "device_type", "pci");
> -    qemu_fdt_setprop_string(fdt, "/pci@c0000000", "name", "pci");
>   
>       fi.path = "/pci@c0000000";
>       pci_bus = mv64361_get_pci_bus(pm->mv, 0);
> @@ -951,7 +941,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#size-cells", 2);
>       qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#address-cells", 3);
>       qemu_fdt_setprop_string(fdt, "/pci@80000000", "device_type", "pci");
> -    qemu_fdt_setprop_string(fdt, "/pci@80000000", "name", "pci");
>   
>       fi.path = "/pci@80000000";
>       pci_bus = mv64361_get_pci_bus(pm->mv, 1);
> @@ -959,7 +948,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>   
>       qemu_fdt_add_subnode(fdt, "/failsafe");
>       qemu_fdt_setprop_string(fdt, "/failsafe", "device_type", "serial");
> -    qemu_fdt_setprop_string(fdt, "/failsafe", "name", "failsafe");
>   
>       qemu_fdt_add_subnode(fdt, "/rtas");
>       qemu_fdt_setprop_cell(fdt, "/rtas", "system-reboot", RTAS_SYSTEM_REBOOT);
> @@ -989,14 +977,12 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-display-device", 0);
>       qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-size", 20);
>       qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-version", 1);
> -    qemu_fdt_setprop_string(fdt, "/rtas", "name", "rtas");
>   
>       /* cpus */
>       qemu_fdt_add_subnode(fdt, "/cpus");
>       qemu_fdt_setprop_cell(fdt, "/cpus", "#cpus", 1);
>       qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 1);
>       qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0);
> -    qemu_fdt_setprop_string(fdt, "/cpus", "name", "cpus");
>   
>       /* FIXME Get CPU name from CPU object */
>       const char *cp = "/cpus/PowerPC,G4";
> @@ -1048,7 +1034,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       cells[1] = 0;
>       qemu_fdt_setprop(fdt, cp, "reg", cells, 2 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fdt, cp, "device_type", "cpu");
> -    qemu_fdt_setprop_string(fdt, cp, "name", strrchr(cp, '/') + 1);
>   
>       /* memory */
>       qemu_fdt_add_subnode(fdt, "/memory@0");
> @@ -1056,7 +1041,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       cells[1] = cpu_to_be32(machine->ram_size);
>       qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
>       qemu_fdt_setprop_string(fdt, "/memory@0", "device_type", "memory");
> -    qemu_fdt_setprop_string(fdt, "/memory@0", "name", "memory");
>   
>       qemu_fdt_add_subnode(fdt, "/chosen");
>       if (pm->initrd_addr && pm->initrd_size) {
> @@ -1067,7 +1051,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       }
>       qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>                               machine->kernel_cmdline ?: "");
> -    qemu_fdt_setprop_string(fdt, "/chosen", "name", "chosen");
>   
>       qemu_fdt_add_subnode(fdt, "/openprom");
>       qemu_fdt_setprop_string(fdt, "/openprom", "model", "Pegasos2,1.1");

