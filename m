Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BA4C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBvp-0005rT-FA; Fri, 24 Jul 2026 05:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBvo-0005r0-43
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:11:00 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBvm-0008Ke-L9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:10:59 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-668296d0ff3so133450d50.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784884256; cv=none;
 d=google.com; s=arc-20260327;
 b=DxuppCsa46ZNEd+IGY5nyao0ASQFI0fVtsPSgEjR3AIYDqqOSXhtkucxE8yuUM3ff7
 T7ZsawSSo53dp++0uPzjlXH/OEFWuHU/OZtlJWiL0RbqsAinxPuWS6K/H0p61nuitmfw
 M0+Bnpwy+uL/gKFyTbI1PSF+agZTTppTTkZNkHHzf62GcMOeN2yRxI09HElfzMwoJpqs
 PXeXhLf6NLknWr0pJP5ABtDag9ysuLNL2/UQlMKwLfruQ3gQPDoJDJOLTx9SqBucHL5k
 yeHFqfyyqoGA35h3yarLpGbw2piewzyqiTK4gXhHaL7ytAKTkKdTAiCB6kGiSzHDxWhu
 gWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VO0dJdF5GV/auAv963l+yPhIUGgj8a7BgQ6e6g13+O8=;
 fh=R9au+h0lrdXDpR4FIVhVuStk4RhEvWBYySD5jMU6woc=;
 b=K6+Ek13BqpKjwWXXlN0hjnLxYwUplEq3JIH57Sq6/ePYMfh2j8wy84ULWdFE9YLoyK
 +i2QZDpn0m42TZE3iVIYZod4MJ/om+t1aeC+nvZ/LMpXxDKwfpkF5ZfawWwqZD41f+EJ
 zJEF4poyqITYfuLo5MOnTnyFIKNLTnDyi7pOZ+n0P0iPS1hKyGKmSyasyYbyTHNYSZoW
 og+PYZMuJWH+YghdZ0cDhsX0BSFv9AfcdEuqgEHJwFP1uzD4Terb9Y1SLkSefGc0qfd4
 xN4ikNaqOakdpvPZPI/zxOCbfNR+bsUSAAnLx65JITmDN/54zjBAVuml2cuVBOoYF3Uv
 7MwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784884256; x=1785489056; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VO0dJdF5GV/auAv963l+yPhIUGgj8a7BgQ6e6g13+O8=;
 b=l6LU2L9SMdDBMhFHtXNS7+syy6BettIdfJWAveLjGwSMwqwUfHnkSY9aufNQ+8DzXN
 XeeZ91SwKOpR5k34lEXBu9lX+Lho8jz+Rt8UPZGm7VL5FJ+oiXuk/0MalRgBR2or8e+h
 LzSjZgU9HMfMZnkS2Fyw8qN5zw5nmGi+sYFWdYYf0kxD/fQfD9EbVvT0APkT/gYTpOQ4
 +owOBoVxIM8x2mxGJcr9oIyQDAf/pO5umQojOsyKsb2sXqGFusCIaiSm5xeM29nzT4wq
 g81Ef3HpIStsf58ft+VPYIUPXTy5gTqcQv2gNxZKjh/F7XXXR78deXPUtAxcayEcYv7z
 e8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784884256; x=1785489056;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VO0dJdF5GV/auAv963l+yPhIUGgj8a7BgQ6e6g13+O8=;
 b=TutEEjzlYMfnEVVShmyH2+sZMxkY1rjEzB/2gRpod0h/+5TfIoCF7jj7DEPcTy2bT9
 1ElbG8kK4A++SD4JJKhB/U02p/9WPZ/xWLCy06lRIrOJPh5F0bvb321X96i4R7EC8BSN
 aAnVqCPv0kJeAxUoxxT2L2XO6LZX63OKJpdZtufXHCH26I/0CGlzAKp6k2oap8992AMU
 svsnL1V+WpFVbf6AYqlLHHWyBuizMS60STxrz3wTewoZCJL99K4oaEesERIOa+yn0h4v
 eTguEJlpoFpHQxBcJrGdmwZ+ScXn+Tv82r8lM9XrK52Orqgx+8xBg2cX8K7XEQeaA51U
 8uKA==
X-Gm-Message-State: AOJu0Yx0oHG2EYIE8hs6FkAdNON0myrdxheyFtPRoQRIhTzMMH1G1rx+
 Cx1b+ySUQBalR8j9uQCO9RkNSM9em+tOpozUJER0815o4RMcwYLKU/gbIX4QByL2K9CEZozBM3A
 CZYfqMM6cMQwh5ouS6S6rdyg3Izvmvet0UNO5RWAqrA==
X-Gm-Gg: AR+sD11OEE6ROOpQ2nyIaviHyLV8XTG6lzs4lFeb51KX4h7yP32l22UxcTO/1JhORlm
 7+kzSYdJMnuQI4hBv7grSG5doOG9BXs/Fklj/+LUsCwr946cvQ7Fcic/2bdqM+JrSFFPXFco/+Q
 0hdDY7XRtRTP5YVzkVX2vgxTuSkIeSm/JjZtVWqQiPWqyxU/2mvcijk/ZL0KMp6DjalkLJtyyId
 V6XEUumyGHXzdD4hpOv1EQbgQK6EFh2PTCYmgjttQVxl898qBDFMDQkmusy9zLxG5M4PuQO5gq6
 owT7qVOidDLOuQsP9XXYFPX5HkSSv29SXL9VQLvF9uISVw==
X-Received: by 2002:a05:690e:b8b:b0:667:8b90:356f with SMTP id
 956f58d0204a3-668a5002029mr1642233d50.97.1784884256238; Fri, 24 Jul 2026
 02:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-5-shentey@gmail.com>
In-Reply-To: <20260723070059.6332-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 10:10:45 +0100
X-Gm-Features: AUfX_mw34trfJG7Qsqq7qO2vWTW4nRJ-3VNOadMjSy9S85gPJcEkqG53nUzzEBs
Message-ID: <CAFEAcA-ASb5ppLTpfvtJD+1_FGCutd6touBZdxKZLCPz+DW7UQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] hw/net/can/flexcan: Fix mailbox index calculation in
 flexcan_mem_write()
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 23 Jul 2026 at 08:01, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Calculate mailbox indices from the `mbs[]` array layout instead of the
> oversized raw `mb[]` view. This prevents accessing mailbox entries beyond
> the valid array range and fixes Coverity CID 1662974.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/net/can/flexcan.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

