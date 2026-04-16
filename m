Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1C8F8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOJi-0000P3-S8; Thu, 16 Apr 2026 11:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wDOJg-0000ON-JS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:07:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wDOJe-0000ou-Q9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:07:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488d2079582so75981865e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352056; x=1776956856; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jDJzDSUW5yyoEw79Hj2zronbZKMozm2nU8sFNYNEOJY=;
 b=ADvJZBLaD3Tg4XkBb3IbNvNb1fPlj8fhuIe9X17tzcY9dGFoJY+Q7NBZOiVpbu72pn
 H65fYdInNCtktVbh1egS/h8Jx1IabRlMvjNyhteHsRToVq/kiCZidXdFKBQDTgC/Adh6
 ADw4vOMGQQFF9j+ui+OYYl9tliACuvli6TLGo9V6mXTrAY83iiTdorRME8abf1po2zdA
 8VYfdDP+9SoKEsSVMHPluqi3aqs4MQKgXzTsmdMDPJypJOmMED0DovqArjkJ3cazyJWL
 lRJ0Nn5AxLoSJn/Gy7jC4wXRylQ/actk/9tWaMPfgWdfHV86usBBiyf1cl9e580kqp6D
 /abA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352056; x=1776956856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDJzDSUW5yyoEw79Hj2zronbZKMozm2nU8sFNYNEOJY=;
 b=SeTHD7kVTfT3bqiCwFicCjsrTvpP8DRJC6VWOORLRbVkU4UqWZSz7M4UP9gUav+3Bo
 qxmINs2RPok/nSl7/2n59TUj2Wzu0hbE9Vv2iLEeKAyL44SgbWhipwv1187+FnynCCY4
 5N7BmihrhSWMKu9IrU5qBKFK95Qnzkz7UMS4CSwBUdinR6dbVqlbAkTQBiPzTtCj/dd/
 C6PhySns5npxFgTCKv6F0AhQuehzUHh1zD902tVd/+HFfgeDFK5UCtzt3PoR9wGs31bp
 VOVuVp5mq8U6slAyKSjKONlte7/7H23qdT4VroiGQ0zKbcURaJkwOGbxEc75fZoyZJAs
 RZUQ==
X-Gm-Message-State: AOJu0YwJhiGK394O/wtbdGhc0bo3f+ywzt1gXMKg0B7v83WdakZxLJsI
 +r3yQ9boA1ONRPCFm25Q1s8E/dKV2mLT77n5+tIMOrPiqXhswBcLPulC6ysOikl0
X-Gm-Gg: AeBDiesp5c/P+rwd547DghEkBTLZDidl4XmU3AJDQYq47N9z29W8aBL59DujtyZf1Ye
 rRA+vzR2PE5yQSV0TzZlyZj/RmdJZB4RbsxwQMPqXt/6ZhcMufyzHJsmQjV6yp/92JPwktXeEEI
 1aRynNvzWrtIOZ5TYTT6XmkKCuD8DiQRqhINob0j2faJSrDFHbW3HZ9t54R0e00ZerIj+Po/0HB
 tJGIqkH5MYXveUaMn4OIRIZ6jZg5aeBHe4/noHLS824SP0NmmPdQwtW+Al8ha732Q/6WzsdvTxC
 Al38SDGaqF3ldnIqc/Zz7Icb3N0+YnrY6nIZlZ1RrYRwr0ZatIpiP5jfEYdFF2h5wW0+aRlcF+B
 p2PXVn4r3KTYMkACSC+JiayqF7FwD9WnRZ3YiKfktpaMY45XXzrGPToQff9VMLwn6XjvmMAwB/H
 IHG+f6/v3YVPJ/MaRewOIXKDw5ExMnQR7xNDYJF1LXXNXkWwgfmVkeHgtOgvfyNUBlfEIPlo45U
 2G2f3xXBpc3ZT8I
X-Received: by 2002:a05:600c:3b24:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-488d6872ed0mr373473815e9.25.1776352055403; 
 Thu, 16 Apr 2026 08:07:35 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f582368dsm71289045e9.11.2026.04.16.08.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:07:34 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:07:33 +0100
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 17/28] MAINTAINERS: Remove Jia Liu
Message-ID: <aeD7NZS8slZ-ki4a@antec>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-18-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416091654.316158-18-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32e.google.com
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

On Thu, Apr 16, 2026 at 10:16:43AM +0100, Peter Maydell wrote:
> Jia Liu has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
> 
> This makes the or1k-sim OpenRISC machine orphan.

This looks ok to me, the time I have worked on the the project I have never
heard from Jia.

I think I would like to mark myself as maintainer on this and the other OpenRISC
machines.  Should I sent a patch on top of your series after it is merged?

-Stafford

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7a345c514..c16a726cde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1496,8 +1496,7 @@ F: include/hw/pci-host/xilinx-pcie.h
>  OpenRISC Machines
>  -----------------
>  or1k-sim
> -M: Jia Liu <proljc@gmail.com>
> -S: Maintained
> +S: Orphan
>  F: docs/system/or1k/or1k-sim.rst
>  F: hw/intc/ompic.c
>  F: hw/or1k/or1k-sim.c
> -- 
> 2.43.0
> 
> 

