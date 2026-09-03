Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE079C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x22wn-0006Fs-Rp; Thu, 03 Sep 2026 04:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x22wm-0006FX-Dp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:37:24 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x22wk-0005RN-Sz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:37:24 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-855a66e5b5dso21347957b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 01:37:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788424641; cv=none;
 d=google.com; s=arc-20260327;
 b=e3kRvZujQRiuJLVy2gphKg6u7mEuwiI2826OFiqy/sNjoxLt8qtedchgsE9FtlLXAN
 ehb/xWNESErfG9HG7eia1LHyhq7s6VIXhSzTWTD/YFnTVE0Er7Hcu3EBEAO2L0oHGefF
 asoHYP2AIDLzVP0JKk5RrxM0nIYuE8+43b7q3m05AtbFs4QS1gvoywNtyYcr4fz0z+yR
 x9ocWnzijcx2NQJfn4Ph0sPQ3hSxrVeYwsXAmECVvLN3o0xON2QNMk9eJLZv3XHKrWWQ
 6093CtuORVsFL7X2mOupfKcpnpdSFArw+5fSnLiH8TBw9q3LFT4x+pAQjeAUVj8UntY0
 5INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hXkUoJ8wKS+vyyT/zAWTZXjVAEWo0lRbYbycB0+3wt4=;
 fh=+kPQWmgEukF6QZvs3aayszUXLlusYwtp+QfkPgeNqAY=;
 b=fZCxBCIJGyMMVrbgRV7us3tkhP1LKhfJVoPZktX32hqhLYwtZpOFbnwGs/VQk9sJW+
 lNTbxm1ev9sHlj5vDjLZ41HSIF/IV4Gctzv+ZsqcFx2sxj9dC4ZmEbp7PvcMVobkGrcN
 BLCV8olNVrbVObxu5lFvCemocO68YIMJjaqfFTsaBn9cdjlrAiJiNUn5btxLHhRD0EoW
 fPpK//JmOBfY17FnV7+5lhihFuEqikrlxr4GCvCElQzwcLQ8iMjeNxJHGlKukIDaxuck
 /zJtSN3vmMAybT6g93sThK2WcHM3ZkOK6zJJNzxEGQ8dToCmLouQ8RW0EzkNY3RqMFJO
 Pd9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788424641; x=1789029441; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hXkUoJ8wKS+vyyT/zAWTZXjVAEWo0lRbYbycB0+3wt4=;
 b=RzS+wRFYKi/6yLsyfkGOYfq2bD48elunGU4lQSttCnvi9JEoaWrX6NIc7inMeXgBTF
 tlqHp+cWm7ECrpdtk9Kn5GDJgffqV63xUW5BIcd2YiQda7ZXK0EdIw6TU/dRYc25C3eN
 DuhGHtXq3J+ZqPt1XvZvNGCCjpLAyrkScyRY1eIx+/Vmm3s4vax8lvoVHMFNZqp7ZQWI
 d9pUsP0DCUxvNguiVSquPAzCLOFetCwuLjFiCl5zu99gGCJjXKNLnDjgGx//fKS+9mJn
 Iw64y2QE+jrA6gJUpeAG1miKdzTXA6T7OfRCQLE1cfb0xhulXAdlX9TDEbJNeR5SjW7w
 KnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788424641; x=1789029441;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hXkUoJ8wKS+vyyT/zAWTZXjVAEWo0lRbYbycB0+3wt4=;
 b=MFfhPqP6iBzziSN3jbNu49JZuty425qxQdTestHtWrTzkFK9tAP6dZAhs4NZSxXH/N
 du9nux1QpZ4SvGl4d5z6zPe6vDSzMUHp19Cozvj6UzKLXqGRA42kh34l8/WE+jYfk64b
 wSk6Ni9XvL+OEHwUt39xBcnG209gFDkh2p05MRw/oNIF3/txQoCXvuC3QW9UE/6lRJsG
 D3adam1O9X5hHIz0+uDwE7mmeFOIZETBwWZGSqadWRYYqQXbbi+zvdl4TRI56omdgazj
 Wulvy4QJdr4LWdKV7y775o/iWyLS4eCJUUhc4uWsZ56FMNb5H+mw/vzWUxl8x6Gw4Iem
 fMYQ==
X-Gm-Message-State: AFuF++n07Sbq4vaExaK1ILVuORvhxDoEhejSGB7mLlX7lGBnLE+tbxVk
 CpERAtatHneAFLdorWCqY8zbvf9tuPO3fVmGoa1clkjbtoDnjpZYEZVHk+tv1lr92wcnGOaKZWh
 dVEPx7f5Q2qvhDEsD46rtXTyP8Rsc28JzbgVTL4fkKQ==
X-Gm-Gg: AYBFou13jm0CP2HicOARDiwNxSvlOq+OsyTBwRt6FswCSC5fRY/Ii7f9oc4umCr+dPW
 FIGRntja8cPMjfhvOKavG732R/mUm9BPIZfajErbzgeZbmzooWw/6XySrug50cNgo4qi9gfN1Y1
 OYepdcP13AM4FqAaDHw1tejDrhMbGNU9kDXNukz8jmKbV4jIOaynP/NSfI4CX9qZLS/BaGXInvU
 esUqjEgNm26dCQub2f6XQEDRAFwTsIVXzpbUEChWtlu4Lx08fdiI3mwUClG8WkMVKDD+TFwTomh
 gMgBZwcjTe9Ic2t3rEDGa93r87kH2rKPhifP+fjkBcLpJJ1029QOTwyghdjY39Og5/SGmMq3Zvq
 UFiqdIdmXeHoQa6s8Ya8En2PSmI2o
X-Received: by 2002:a05:690c:10:b0:7e8:a091:6c4b with SMTP id
 00721157ae682-86c5221e410mr55408427b3.24.1788424640957; Thu, 03 Sep 2026
 01:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 09:37:09 +0100
X-Gm-Features: AcwNN1Vp6Xw_0IDNbiAttJ-rSVW1xfD-0QhB_2bph2oo8_ZLbzXN9EH8z8jdLjM
Message-ID: <CAFEAcA8Jqu6wgBGn_LaWmy76UY1KvUADeqXOQqZqPLWAgGwgTw@mail.gmail.com>
Subject: Re: [PULL 00/28] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 2 Sept 2026 at 05:43, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The following changes since commit eb710c255642cd7dc947f25c9a06c9fc8191e98d:
>
>   Merge tag 'firmware-20260901-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-09-01 10:38:45 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/qualcomm/qemu tags/pull-hex-20260901
>
> for you to fetch changes up to 4a4ba15b2b0de009c662674dd365ff56048e2b22:
>
>   hw/hexagon: decode an empty TLB size field as 4KB (2026-09-01 18:23:23 -0700)
>
> ----------------------------------------------------------------
> This PR adds semihosting, and fixes for exceptions, icinva, TLB, htid
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

