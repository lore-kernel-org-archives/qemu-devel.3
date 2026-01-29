Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763CAD61021
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTbm-0003xv-Dy; Thu, 29 Jan 2026 10:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlTbl-0003wq-5D; Thu, 29 Jan 2026 10:06:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vlTbi-0001ij-RK; Thu, 29 Jan 2026 10:06:56 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DAE5D596ABF;
 Thu, 29 Jan 2026 16:06:50 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ZDZXzaNoLzQ1; Thu, 29 Jan 2026 16:06:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD37C596A10; Thu, 29 Jan 2026 16:06:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BB49A596A0B;
 Thu, 29 Jan 2026 16:06:48 +0100 (CET)
Date: Thu, 29 Jan 2026 16:06:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-ppc@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v4 7/9] monitor: Truncate target register using ldn_he_p()
 API
In-Reply-To: <20260129133241.35990-8-philmd@linaro.org>
Message-ID: <fd61c54d-b271-580d-a3d2-98b08f920cf2@eik.bme.hu>
References: <20260129133241.35990-1-philmd@linaro.org>
 <20260129133241.35990-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1441159683-1769699208=:31920"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1441159683-1769699208=:31920
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 29 Jan 2026, Philippe Mathieu-Daudé wrote:
> Rather than truncating with a target_long cast, use the
> unaligned load/store API.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/monitor/hmp-target.h | 3 ---
> monitor/hmp-target.c         | 8 +++++---
> 2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 6d6653aee6e..788bc9e330a 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -27,15 +27,12 @@
>
> typedef struct MonitorDef MonitorDef;
>
> -#ifdef COMPILING_PER_TARGET
> -#include "cpu.h"
> struct MonitorDef {
>     const char *name;
>     int offset;
>     uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
>     int type;
> };
> -#endif
>
> #define MD_TULONG 0
> #define MD_U32    1
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 5738b47bb03..257605a1c96 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -23,6 +23,7 @@
>  */
>
> #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> #include "monitor-internal.h"
> #include "monitor/qdev.h"
> #include "net/slirp.h"
> @@ -65,6 +66,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
>  */
> int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
> {
> +    const unsigned length = target_long_bits() / 8;
>     const MonitorDef *md = target_monitor_defs();
>     CPUState *cs = mon_get_cpu(mon);
>     uint64_t tmp = 0;
> @@ -83,11 +85,11 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
>                 void *ptr = (uint8_t *)env + md->offset;
>
>                 switch(md->type) {
> -                case MD_U32:
> +                case MD_I32:

Why is this changed? Doesn't seem to be realted to what the commit message 
says.

Regards,
BALATON Zoltan

>                     *pval = *(uint32_t *)ptr;
>                     break;
>                 case MD_TULONG:
> -                    *pval = *(target_ulong *)ptr;
> +                    *pval = ldn_he_p(ptr, length);
>                     break;
>                 default:
>                     *pval = 0;
> @@ -100,7 +102,7 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
>
>     ret = target_get_monitor_def(cs, name, &tmp);
>     if (!ret) {
> -        *pval = (target_ulong)tmp;
> +        *pval = ldn_he_p(&tmp, length);
>     }
>
>     return ret;
>
--3866299591-1441159683-1769699208=:31920--

