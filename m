Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA19C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9L3-0006iz-Hv; Mon, 17 Jun 2024 06:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJ9L1-0006iZ-5L; Mon, 17 Jun 2024 06:11:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sJ9Kz-0006Rd-61; Mon, 17 Jun 2024 06:11:46 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H7vFCK015741;
 Mon, 17 Jun 2024 10:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
 xMwVdMiQHfAJ7KazknZcLfEdpU/R0vlAK5P+kkn7ww=; b=s/Idjky0KrXuD8nOB
 obPJZd6rNPMcbgzuY8fx53vxGxKPSLLfxL55C/e2MC+xEGad0FNbiTiRfyvIiXOr
 Kc9xhYNRJ1KaFxk5+HyiGSneTmKS9odDfXxrrwP7mJlxfJHpB7bZ2tpGcS12KSLW
 pnrI/q93ZUOJKk6HoQkazf9o6K+0wYPY9z97BLG1Mdy7G34g+gX/pPoZgBf7Fa5a
 Af4hJ01iFTC5QsjIB/b7fk7Tsx4RKwGGLnbZqCKzj6nuoPN4v56PAO2qhltBZ8Qc
 mF1Y2ncz3c8imq16884qPRBqYfTiwgo9WUPJMK1BKRtzYxgzc8unfAEYtQwrv1c3
 PPryg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytgbngj5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:11:29 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HABS4j029593;
 Mon, 17 Jun 2024 10:11:28 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytgbngj5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:11:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45H8F8WN009457; Mon, 17 Jun 2024 10:11:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgm8p44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 10:11:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HABPOj14353058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Jun 2024 10:11:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FA3858095;
 Mon, 17 Jun 2024 10:11:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 073C958084;
 Mon, 17 Jun 2024 10:11:18 +0000 (GMT)
Received: from [9.124.223.158] (unknown [9.124.223.158])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 10:11:17 +0000 (GMT)
Message-ID: <81d3ec2b-2fec-4412-843a-159952dcd79d@linux.ibm.com>
Date: Mon, 17 Jun 2024 15:41:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/26] hw/ppc: Avoid using Monitor in
 pnv_phb3_msi_pic_print_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
 <20240610062105.49848-2-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240610062105.49848-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uc6uyD1DqeB_IAuomQt7fpfJt2Iogn4H
X-Proofpoint-GUID: IooKoC02fBfs-t82jXyLXIp9nLQKTWEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/10/24 11:50, Philippe Mathieu-Daudé wrote:
> Replace Monitor API by HumanReadableText one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   include/hw/pci-host/pnv_phb3.h |  2 +-
>   hw/pci-host/pnv_phb3_msi.c     | 21 ++++++++++-----------
>   hw/ppc/pnv.c                   |  8 +++++++-
>   3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_phb3.h
> index d62b3091ac..24ca3dddaa 100644
> --- a/include/hw/pci-host/pnv_phb3.h
> +++ b/include/hw/pci-host/pnv_phb3.h
> @@ -40,7 +40,7 @@ void pnv_phb3_msi_update_config(Phb3MsiState *msis, uint32_t base,
>   void pnv_phb3_msi_send(Phb3MsiState *msis, uint64_t addr, uint16_t data,
>                          int32_t dev_pe);
>   void pnv_phb3_msi_ffi(Phb3MsiState *msis, uint64_t val);
> -void pnv_phb3_msi_pic_print_info(Phb3MsiState *msis, Monitor *mon);
> +void pnv_phb3_msi_pic_print_info(Phb3MsiState *msis, GString *buf);
>   
>   
>   /*
> diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
> index a6d827f903..77d673da54 100644
> --- a/hw/pci-host/pnv_phb3_msi.c
> +++ b/hw/pci-host/pnv_phb3_msi.c
> @@ -13,7 +13,6 @@
>   #include "hw/pci-host/pnv_phb3.h"
>   #include "hw/ppc/pnv.h"
>   #include "hw/pci/msi.h"
> -#include "monitor/monitor.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
>   #include "sysemu/reset.h"
> @@ -316,13 +315,13 @@ static void pnv_phb3_msi_register_types(void)
>   
>   type_init(pnv_phb3_msi_register_types);
>   
> -void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, Monitor *mon)
> +void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, GString *buf)
>   {
>       ICSState *ics = ICS(msi);
>       int i;
>   
> -    monitor_printf(mon, "ICS %4x..%4x %p\n",
> -                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
> +    g_string_append_printf(buf, "ICS %4x..%4x %p\n",
> +                           ics->offset, ics->offset + ics->nr_irqs - 1, ics);
>   
>       for (i = 0; i < ics->nr_irqs; i++) {
>           uint64_t ive;
> @@ -335,12 +334,12 @@ void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, Monitor *mon)
>               continue;
>           }
>   
> -        monitor_printf(mon, "  %4x %c%c server=%04x prio=%02x gen=%d\n",
> -                       ics->offset + i,
> -                       GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
> -                       GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
> -                       (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
> -                       (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
> -                       (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
> +        g_string_append_printf(buf, "  %4x %c%c server=%04x prio=%02x gen=%d\n",
> +                               ics->offset + i,
> +                               GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
> +                               GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
> +                               (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
> +                               (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
> +                               (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
>       }
>   }
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec..5356a4e295 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -38,6 +38,7 @@
>   #include "hw/loader.h"
>   #include "hw/nmi.h"
>   #include "qapi/visitor.h"
> +#include "qapi/type-helpers.h"
>   #include "monitor/monitor.h"
>   #include "hw/intc/intc.h"
>   #include "hw/ipmi/ipmi.h"
> @@ -774,8 +775,13 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
>       for (i = 0; i < chip8->num_phbs; i++) {
>           PnvPHB *phb = chip8->phbs[i];
>           PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
> +        g_autoptr(GString) buf = g_string_new("");
> +        g_autoptr(HumanReadableText) info = NULL;
> +
> +        pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
> +        info = human_readable_text_from_str(buf);
> +        monitor_puts(mon, info->human_readable_text);
>   
> -        pnv_phb3_msi_pic_print_info(&phb3->msis, mon);
>           ics_pic_print_info(&phb3->lsis, mon);
>       }
>   }

