Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4344FCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 04:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbsWf-0000sH-32; Tue, 23 Jun 2026 00:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsWe-0000qb-9A
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:14:16 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsWc-0003Yq-Jm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:14:15 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so9364949eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782188053; x=1782792853; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0NCyTmgt98g9cfB64qirJ5HXfyrMUQsWRBPptQ7TCKE=;
 b=Tbh2T8TYIOp/FHFA/1FGiD9k/oR6wtR0+Y+9fr5jpOicdA455NInVK+XvMm+KED7Sw
 qdq7T+WDFeWIwoL9Z5C+Sw93WPzt38emJVmPv/aNitnlx+D9Hh+c4TDoHjpGXiOdoziC
 /x9ge3vPC7c9LRcY6XcGVUSuevs7QZfeaTOwjsOBxl2e0zuRLGv5iw+8rNrOH8EwdOhw
 DE5v+Q/a24jNv4zzVZ5x2xMHbs0vmV1cbxUtlla5NnJB8qGWuKRu1bAjijtrqxRpMYP1
 1zPpKAJ3ETzmW0AZ/VQLWAo2YopfoVPPB3ZaMDhlVRghNOplyitJn8ZUdTBcOb+rbUIr
 8o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782188053; x=1782792853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NCyTmgt98g9cfB64qirJ5HXfyrMUQsWRBPptQ7TCKE=;
 b=ceN6NFCP/Bstbx+2AogAyo8atK+GxrH8HMuCKGyZk12xKMHRyGVgm9C6Xi4EBHIEFj
 X4L8eEpJHWui/61FwV3V4+rJy5OkQDhKFKbuJ/lyRPimsfXG9/vwUU1HHUHesHdR2/Mm
 0yQ5IudTlxJaeZKOm8IYulNqBx+cfom4KWkRzBhAZMpce+DHcRFkWlHyy6sYPyQWo/jk
 2E7ldrFYGEUHeLj3h2tIPsLjhU7YFqHOBro1+Pw/brKw9QzLhtwb2jQEWvgqKqK1n6pV
 Nce4t2ZIgoSFKvEOcagWDmkeQyEv8ZlWW04mevWdfl3py3HKVi13Wp1v6zt/Aw+q85dx
 ZvmA==
X-Gm-Message-State: AOJu0YyTBpH1Y3u0zun/lD9XFRHEGC+ZjObfX2jC9Z5Ln6oBVFPS+DzU
 XGx2WSV0t3XJkuWGdeCVgvoWmaJe8spuKNMBfukQYrD2warYeeiR4kLR
X-Gm-Gg: AfdE7clnaOekBbm3AoFkavOHWWe19hEpJuX/LycYKDbB5JVU+sqQ7EW93Ws7PkB8RgL
 wlqVq2uIMR7M30L+70Axs4kOCkE2aaRfY+AVueA5M3Ur046JfN91B0mQq1hkSXYyM5h1RYqll+b
 Kk8aSvnpdalMc5RtqX8NmWT6FVgJ5gzaJ8oKhhUKWSeOwZ0YAgJufiWXje+I1DtbJDVCWW0nE5q
 WLAu8YvlyQbqgwCLRFyXwAnEpRWPR02VnVeswMCvTDiL9xU+Yx8c8bmwPIEW/J7ETSXerCJDpxS
 kqXwyVq9muMozBHEmJw7K3qhM1LvupvsYR+fUCrVLd5bwuJmYw/fMS4/FisHOOEqp/f29A5njY2
 /lC6kDxai3qP4UomHvSWOoa2bN5zOqLnRGPoZnko41XKH9rH3YxohUMPY6YjvkQpl0tHwkvmAcQ
 ficmZAwePf+7DU1Dy2emhTkbCYYWEbxeOCpnDCsRxHNc4h1rp+
X-Received: by 2002:a05:7300:ac8a:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30c1d5955c6mr9388585eec.0.1782188052992; 
 Mon, 22 Jun 2026 21:14:12 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bddfe34sm15430327eec.20.2026.06.22.21.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 21:14:12 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:14:09 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/5] hw/riscv/sifive_u.c: use intc_phandle in plic creation
Message-ID: <ajoHzy3dYz6-cC0c@ChaodeMacBook-Pro.local>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616235939.1358663-3-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 16, 2026 at 08:59:36PM +0800, Daniel Henrique Barboza wrote:
> The info about intc_phandles for each CPU is already stored in the
> intc_phandles array.  We don't need to fetch them again using
> qemu_fdt_get_phandle().
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  hw/riscv/sifive_u.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index fda9a09f06..b3468254f5 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -199,20 +199,16 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      plic_phandle = phandle++;
>      cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
>      for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
> -        nodename =
> -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
>          /* cpu 0 is the management hart that does not have S-mode */
>          if (cpu == 0) {
> -            cells[0] = cpu_to_be32(intc_phandle);
> +            cells[0] = cpu_to_be32(intc_phandles[cpu]);
>              cells[1] = cpu_to_be32(IRQ_M_EXT);
>          } else {
> -            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandle);
> +            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandles[cpu]);
>              cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
> -            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
> +            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
>              cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
>          }
> -        g_free(nodename);
>      }
>      nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
>          (long)memmap[SIFIVE_U_DEV_PLIC].base);
> -- 
> 2.43.0
> 

