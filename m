Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796CCE94102
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 23:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaMzH-0001Ho-6X; Mon, 29 Dec 2025 18:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vaMyS-0000kP-Gm
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:48:30 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vaMyQ-0000W1-HQ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 18:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=uXwNL4fyemQZewTEcgh6qqTIXqf6MMCsSrPlv0u70Q0=; b=YHBye9wumdP5/9G8
 pyjuxoLcMAH8KC04LQb4qwTkb34rgRo+P5vXSgz9V9AS+/+dSBwHMuGdBUBKSnr20Igc7zLIu75Lu
 85ATH1SDGVa0IjSp45bfEhic12YyXjK2SejHFiMS8zPYsa1DGIRiP72+YOaqSc31NQBQE7OwzqQh9
 4fm0BTPG3grayiniFX9NPK/Hc6aM0xJsbY+I91S3ubz+6ubjVJEABv2lE0RaPC8kxDxBsxuGSOfTU
 Cn3WdI1z5uZ7AsfaMsBgfY4bFYUevEEeY+Mm5ZyGCtr8byBJEeu7XbDgSt1y04fJKY4RM8QFCC9ac
 Wmu33ix/xqvPrAV/Og==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vaMyL-0000000BfBx-1X02;
 Mon, 29 Dec 2025 23:48:21 +0000
Date: Mon, 29 Dec 2025 23:48:21 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 2/7] monitor/hmp: Make memory_dump() @is_physical
 argument a boolean
Message-ID: <aVMTRe-Hq7VM3L5g@gallifrey>
References: <20251229231546.50604-1-philmd@linaro.org>
 <20251229231546.50604-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251229231546.50604-3-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 23:48:17 up 63 days, 23:24,  2 users,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/hmp-cmds-target.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 2976f986d35..51dcb9e314c 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -122,7 +122,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
>  }
>  
>  static void memory_dump(Monitor *mon, int count, int format, int wsize,
> -                        hwaddr addr, int is_physical)
> +                        hwaddr addr, bool is_physical)
>  {
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
> @@ -237,7 +237,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>      int size = qdict_get_int(qdict, "size");
>      target_long addr = qdict_get_int(qdict, "addr");
>  
> -    memory_dump(mon, count, format, size, addr, 0);
> +    memory_dump(mon, count, format, size, addr, false);
>  }
>  
>  void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
> @@ -247,7 +247,7 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>      int size = qdict_get_int(qdict, "size");
>      hwaddr addr = qdict_get_int(qdict, "addr");
>  
> -    memory_dump(mon, count, format, size, addr, 1);
> +    memory_dump(mon, count, format, size, addr, true);
>  }
>  
>  void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

