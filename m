Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC68CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYad-0000uw-BT; Mon, 08 Jun 2026 07:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1wWYab-0000rU-GM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:56:21 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1wWYaZ-0005ZQ-31
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:56:21 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 9D7E7C602FB;
 Mon, 08 Jun 2026 13:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1780919772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQ1Be/nZgPCFbHG/uvHS2UsTWMZk5YyU/bZslJ3THSw=;
 b=L28Es3Vito1C/NXS22Zwz4uaGVkV2qA7XjSGnhC1TL8NsRAp8MrUYBRMwiMuFOt9dZPleN
 aMeX7CK5Bir40cZuUdF0CpCg8D5iWK9+L6HvzcBh47Nzo2wZTj0hHrb4ZkFD/Xp1lgbgIq
 RbWMz4a72qz5g7v83IukB/9G8qN5DLQCXJmAcAIMvV2U0/N3nr3qBqyyIA8JjyeERxU3cq
 dzBvOWR4S+waUzuU0XBAies7kox7dG1YlSyj0P8mkoesJyCSmP3FXYr6TbXB1DUPbFdeMT
 zj/A+Er/9ik1Oy6yzl935IbfWL/9EYDRid/mqTzEZHeOI19uUcHm4KIXS5w0IQ==
Date: Mon, 8 Jun 2026 13:56:12 +0200
From: Luc Michel <luc@lmichel.fr>
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, hemanshu_dev@proton.me
Subject: Re: [PATCH v2] hw/core/qdev-clock: Fix potential null pointer
 dereference
Message-ID: <aiatrNTltZPKIOuY@michell-laptop.localdomain>
References: <20260531153354.88909-2-hemanshu.khilari.foss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531153354.88909-2-hemanshu.khilari.foss@gmail.com>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
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

On 21:03 Sun 31 May     , hemanshu.khilari.foss wrote:
> qdev_get_clocklist() function returns a pointer to the NamedClockList
> struct. This function is called in qdev_alias_clock() and the returned
> pointer is immediately dereferenced without a null check.
> 
> Passing clock name that doesn't exist to qdev_get_clocklist() is a
> programming error, and so this change is not fixing a bug, only making
> the reporting of that programming error a bit more helpful and bringing
> it in to line with qdev_get_clock_in() and qdev_get_clock_out().
> 
> Cc: luc@lmichel.fr
> Cc: peter.maydell@linaro.org
> Cc: hemanshu_dev@proton.me
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  hw/core/qdev-clock.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 6e2967e433..861f78f94c 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -157,7 +157,14 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
>                          DeviceState *alias_dev, const char *alias_name)
>  {
>      NamedClockList *ncl = qdev_get_clocklist(dev, name);
> -    Clock *clk = ncl->clock;
> +    Clock *clk;
> +
> +    if (!ncl) {
> +        error_report("Can not find clock '%s' for device type '%s'",
> +                     name, object_get_typename(OBJECT(dev)));
> +        abort();
> +    }
> +    clk = ncl->clock;
>  
>      ncl = qdev_init_clocklist(alias_dev, alias_name, true, ncl->output, clk);
>  
> -- 
> 2.42.0
> 

-- 

