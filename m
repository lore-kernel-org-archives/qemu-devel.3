Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF0DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxfpN-0004vh-1r; Fri, 19 Apr 2024 00:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rxfpK-0004ug-E9; Fri, 19 Apr 2024 00:26:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rxfpI-0002VO-3V; Fri, 19 Apr 2024 00:26:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J41Whu026400; Fri, 19 Apr 2024 04:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Byubrg7NG4Rwk6kUWE1iFtL0wslxRb1v8S1QWHpW+6I=;
 b=rqmkhjQaFMexYHQ9KozvlCPJTmyMW+ZcESZHgphdI05de2Hm9ql825ewOLbYss2EpRmv
 oTWjqdZKnJLijVaqgxHfta17mzId30r6Y8VGBahFFhGVmbEEYotE9QlCTaCJU+uGcXbG
 zkc7tp+S5vAca9QceXUFADYtxoI/Fleqg+apsHPjoFbJ/T0UsWAqA2F95+tkLb/979/6
 7qToLrwXLfOB2BOMRdEdt/x5hdgPDPEQLvPcaoauOxKLC6QR0LvspXIsrt41hOT9nOiQ
 qBDy5y9TFczkKg+FC4GlRqxKii3vAzf58fncbqbJ5oS+swUhOzhmfmEAlITLAyo6l+28 bA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkh7hg1g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 04:25:41 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43J4Pesi029109;
 Fri, 19 Apr 2024 04:25:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkh7hg1fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 04:25:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43J1RQM0010509; Fri, 19 Apr 2024 04:25:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbmm1hs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 04:25:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43J4Pbkx43647262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2024 04:25:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C75358052;
 Fri, 19 Apr 2024 04:25:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97F8158064;
 Fri, 19 Apr 2024 04:25:28 +0000 (GMT)
Received: from [9.79.176.46] (unknown [9.79.176.46])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2024 04:25:28 +0000 (GMT)
Message-ID: <255f8e9d-9d5f-40ba-aa6a-43b63faf7a6e@linux.ibm.com>
Date: Fri, 19 Apr 2024 09:55:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] exec: Remove 'exec/tswap.h' from 'exec/cpu-all.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-23-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240418192525.97451-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FmrugRU4zCDnhiEcH3BRR04Ls9Xs3lpw
X-Proofpoint-GUID: gBF-QGmnjUoDRow1-fF_vkQDN1dCRNYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_01,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 4/19/24 00:55, Philippe Mathieu-Daudé wrote:
> "exec/cpu-all.h" doesn't require "exec/tswap.h". Remove it,
> including it in the sources when required.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xtensa/bootparam.h       | 1 +
>   include/exec/cpu-all.h      | 1 -
>   accel/tcg/translator.c      | 1 +
>   hw/arm/boot.c               | 1 +
>   hw/arm/npcm7xx.c            | 1 +
>   hw/mips/fuloong2e.c         | 1 +
>   hw/mips/malta.c             | 1 +
>   hw/ppc/sam460ex.c           | 1 +
>   hw/ppc/spapr.c              | 1 +

For spapr:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   hw/ppc/virtex_ml507.c       | 1 +
>   hw/sh4/r2d.c                | 1 +
>   target/arm/gdbstub.c        | 1 +
>   target/xtensa/xtensa-semi.c | 1 +
>   13 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
> index f57ff850bc..e1d47b503c 100644
> --- a/hw/xtensa/bootparam.h
> +++ b/hw/xtensa/bootparam.h
> @@ -1,6 +1,7 @@
>   #ifndef HW_XTENSA_BOOTPARAM_H
>   #define HW_XTENSA_BOOTPARAM_H
>   
> +#include "exec/tswap.h"
>   #include "exec/cpu-common.h"
>   
>   #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 554b937ddb..cfbf51822c 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -21,7 +21,6 @@
>   
>   #include "exec/cpu-common.h"
>   #include "exec/memory.h"
> -#include "exec/tswap.h"
>   #include "hw/core/cpu.h"
>   
>   /* some important defines:
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 6832e55135..85950377d9 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -12,6 +12,7 @@
>   #include "qemu/error-report.h"
>   #include "exec/exec-all.h"
>   #include "exec/translator.h"
> +#include "exec/tswap.h"
>   #include "exec/cpu_ldst.h"
>   #include "exec/plugin-gen.h"
>   #include "tcg/tcg-op-common.h"
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 84ea6a807a..93945a1a15 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -22,6 +22,7 @@
>   #include "sysemu/reset.h"
>   #include "hw/loader.h"
>   #include "elf.h"
> +#include "exec/tswap.h"
>   #include "sysemu/device_tree.h"
>   #include "qemu/config-file.h"
>   #include "qemu/option.h"
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index cc68b5d8f1..1ef303415b 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -27,6 +27,7 @@
>   #include "qemu/units.h"
>   #include "sysemu/sysemu.h"
>   #include "target/arm/cpu-qom.h"
> +#include "exec/tswap.h"
>   
>   /*
>    * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index a45aac368c..1d0613a76f 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -40,6 +40,7 @@
>   #include "sysemu/reset.h"
>   #include "sysemu/sysemu.h"
>   #include "qemu/error-report.h"
> +#include "exec/tswap.h"
>   
>   #define ENVP_PADDR              0x2000
>   #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index af74008c82..3dca0f100c 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -56,6 +56,7 @@
>   #include "semihosting/semihost.h"
>   #include "hw/mips/cps.h"
>   #include "hw/qdev-clock.h"
> +#include "exec/tswap.h"
>   #include "target/mips/internal.h"
>   #include "trace.h"
>   #include "cpu.h"
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index d42b677898..abc02f0817 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -24,6 +24,7 @@
>   #include "hw/loader.h"
>   #include "elf.h"
>   #include "exec/memory.h"
> +#include "exec/tswap.h"
>   #include "ppc440.h"
>   #include "hw/pci-host/ppc4xx.h"
>   #include "hw/block/flash.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e9bc97fee0..b4b1f43983 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -74,6 +74,7 @@
>   #include "hw/virtio/virtio-scsi.h"
>   #include "hw/virtio/vhost-scsi-common.h"
>   
> +#include "exec/tswap.h"
>   #include "exec/ram_addr.h"
>   #include "hw/usb.h"
>   #include "qemu/config-file.h"
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index d02f330650..fd23afebf5 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -38,6 +38,7 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/option.h"
> +#include "exec/tswap.h"
>   
>   #include "hw/intc/ppc-uic.h"
>   #include "hw/ppc/ppc.h"
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index e5ac6751bd..5f4420f534 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -43,6 +43,7 @@
>   #include "hw/loader.h"
>   #include "hw/usb.h"
>   #include "hw/block/flash.h"
> +#include "exec/tswap.h"
>   
>   #define FLASH_BASE 0x00000000
>   #define FLASH_SIZE (16 * MiB)
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index a3bb73cfa7..f2b001afdd 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/gdbstub.h"
> +#include "exec/tswap.h"
>   #include "gdbstub/helpers.h"
>   #include "sysemu/tcg.h"
>   #include "internals.h"
> diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
> index fa21b7e11f..dbc42d1587 100644
> --- a/target/xtensa/xtensa-semi.c
> +++ b/target/xtensa/xtensa-semi.c
> @@ -29,6 +29,7 @@
>   #include "cpu.h"
>   #include "chardev/char-fe.h"
>   #include "exec/helper-proto.h"
> +#include "exec/tswap.h"
>   #include "semihosting/semihost.h"
>   #include "qapi/error.h"
>   #include "qemu/log.h"

