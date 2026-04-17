Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EDEF8DFFF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDnHV-0002kO-4Z; Fri, 17 Apr 2026 13:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wDnHD-0002gu-Hf; Fri, 17 Apr 2026 13:46:50 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wDnHA-00059X-WB; Fri, 17 Apr 2026 13:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=oxM6wnbVcSyAC9yeVxfQnW+bPrBukYxactIiN0rJ0z0=; b=gU5XOU65gc8ZQDiZ
 wqyQAoLJPRsXnBGa3fnTCDpTwiptaRD3lUtrNla+VnSHxrhdIqe1nfpslxewD8Zgnmc3XIRET64wf
 5HoBwW0TyGk/mu76R2+Hy8eS6CrFjuRqxrv6d8z8iiTfQEq0KQcgu1rk0WVz5DsvGvLnxqWnPhF3q
 55CUMSkdduOSLL/ewI4ODWjS3RsqQXhSUJH89Q1KERiL/AejMVs1erMSMBprTOyzYv1AEAGIkuNcd
 EiW8+AQQNlyWh8sIyA6fLGamHtpEFgEiHy9YflFb59n34JX2/QyB6yYKA4oq8rZjak+nnKtoCT4e/
 evCFVpW1Y2tP3fUucA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wDnH1-000000091FN-3RaP;
 Fri, 17 Apr 2026 17:46:35 +0000
Date: Fri, 17 Apr 2026 17:46:35 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 12/17] monitor: hmp_gva2gpa: Don't page-align
 cpu_get_phys_addr_debug() arg and return
Message-ID: <aeJx-_s-n46m-zBf@gallifrey>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-13-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260417173105.1648172-13-peter.maydell@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 17:45:25 up 35 days, 18:58,  3 users,  load average: 0.00, 0.03, 0.00
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> In hmp_gva2gpa() we currently have a workaround for not all implementations
> of get_phys_addr_debug handling non-page-aligned addresses: we round the
> input address from the user down to the target page boundary before the
> call and then add the page offset back to the returned value.
> 
> Now that we guarantee that all implementations will return the correct
> exact physaddr for a virtual address, we can drop this handling.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  monitor/hmp-cmds.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index e6d8322bcc..f8380bda58 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -720,12 +720,11 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>          return;
>      }
>  
> -    gpa  = cpu_get_phys_addr_debug(cs, addr & TARGET_PAGE_MASK);
> +    gpa  = cpu_get_phys_addr_debug(cs, addr);
>      if (gpa == -1) {
>          monitor_printf(mon, "Unmapped\n");
>      } else {
> -        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
> -                       gpa + (addr & ~TARGET_PAGE_MASK));
> +        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n", gpa);

For HMP:

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

>      }
>  }
>  
> -- 
> 2.43.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

