Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35806E776FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 00:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYYvK-0008IC-2B; Wed, 24 Dec 2025 19:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYYvI-0008Hu-5Y
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:09:44 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vYYvG-0001Do-6S
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 19:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=GtWQzOVxlPB85q52Um2y1QTKU0XK1LFR4YL8tsj3AJE=; b=J845BlYEeSlij0+v
 dA7N6o8qJEedujMg/XjxCI4GLHr7KTw0FEfD3nf3CTHYjA6rEnwB4zG88aCytSpxg19aEEA+0sFvp
 D+pSBklmX539ZCpMpUmTpGJ1NVwRaWbB2y+3WsayK68mi8HQl60tabYMT19mTEHBNoZpoR5H1DZPG
 IRNVqBKIRc2JqlHV4fckUuB5H1KFiRpmLlEDwUuhqP0kinkKlIIbPPTVCZoPLXCfYx7elRc5TbegL
 FBLSs5cCMwTGdfuS+vv2NGwR6WMGvgax2fLs0n39/Jfw1WiMEi8Uz9CrOiwDdHWxP436eeGOlKY2n
 MwZzWAaf4hVDu06qtA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vYYvC-0000000BFfw-0Kjq;
 Thu, 25 Dec 2025 00:09:38 +0000
Date: Thu, 25 Dec 2025 00:09:38 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 1/6] monitor/hmp: Replace target_ulong -> vaddr in
 hmp_gva2gpa()
Message-ID: <aUyAwiRLBWOsg3pS@gallifrey>
References: <20251224133949.85136-1-philmd@linaro.org>
 <20251224133949.85136-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251224133949.85136-2-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:09:32 up 58 days, 23:45,  3 users,  load average: 0.00, 0.00, 0.00
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
> cpu_get_phys_page_debug() takes a vaddr type since commit
> 00b941e581b ("cpu: Turn cpu_get_phys_page_debug() into a CPUClass
> hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/hmp-cmds-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index e9820611466..2976f986d35 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -301,7 +301,7 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>  
>  void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>  {
> -    target_ulong addr = qdict_get_int(qdict, "addr");
> +    vaddr addr = qdict_get_int(qdict, "addr");
>      CPUState *cs = mon_get_cpu(mon);
>      hwaddr gpa;
>  
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

