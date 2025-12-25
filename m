Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6678E7849C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 00:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYZ49-0001hg-Ik; Wed, 24 Dec 2025 19:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYZ48-0001gl-7E
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:18:52 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYZ46-000275-PV
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=VwkiJX4p22340YigJvl8WO++VW+B8LJv4MjLYZF72lk=; b=JM4PWHOFKaaQ0+A+
 fyBqhbHCPulpa/2kp+1Cl46FoXGihgYamtX4zzeu/Ib3T5dPswKa5EEXftMIvb7UMjqSJcN+eYPHt
 L1Y+P3WPwnyRyLOGwAiTuAXBbnEjKs+DRaCeca4fWe+cUUEz7UVIIkjngv6FVCjsJIkQEnNLs9aN+
 qophESnOqxGySz88wHMrYSnsqi+OYg5ciRrdPziUk2AAF+U3htqRA6RfLm/+xpd+p2D0j2W+lKnKL
 L3Au6mjuvMI3oQaL9JdTf/nq5Uww9h7FmF+6HTXG7+/ce7LqDT4T2WNFdyzcNeysp9Fogg1YYQMsg
 YHxhMFeLpzAgoPwSug==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vYZ44-0000000BFgP-20h0;
 Thu, 25 Dec 2025 00:18:48 +0000
Date: Thu, 25 Dec 2025 00:18:48 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 2/6] monitor/hmp: Use plain uint64_t @addr argument in
 memory_dump()
Message-ID: <aUyC6HNv8KftowlQ@gallifrey>
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251224133949.85136-3-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:17:09 up 58 days, 23:53,  3 users,  load average: 0.00, 0.00, 0.00
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
> memory_dump() takes either hwaddr or vaddr type, depending
> on the @is_physical argument. Simply use uint64_t type which
> is common to both.
> Pad address using field width formatting, removing the need
> for the target_ulong type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  monitor/hmp-cmds-target.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 2976f986d35..c00f75eab3c 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -122,12 +122,13 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
>  }
>  
>  static void memory_dump(Monitor *mon, int count, int format, int wsize,
> -                        hwaddr addr, int is_physical)
> +                        uint64_t addr, int is_physical)

(It would be nice sometime for that to be a bool is_physical)
>  {

>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
>      uint64_t v;
>      CPUState *cs = mon_get_cpu(mon);
> +    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);

That's not obvious until you read later down to see how you're using it
and see it's characters/nybbles.


Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

>      if (!cs && (format == 'i' || !is_physical)) {
>          monitor_printf(mon, "Can not dump without CPU\n");
> @@ -165,11 +166,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>      }
>  
>      while (len > 0) {
> -        if (is_physical) {
> -            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
> -        } else {
> -            monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
> -        }
> +        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
>          l = len;
>          if (l > line_size)
>              l = line_size;
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

