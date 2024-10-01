Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA09CEACDB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveCZ-0001Nd-Dj; Tue, 01 Oct 2024 10:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveCP-0001F5-1f
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:50:02 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveCM-00056r-MZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:50:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37cdbdbbb1cso1985421f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727794197; x=1728398997; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wW4tS1JbeCnJ6FYG3DPiU/Bq1CUUdX2G31A9LRKnbYA=;
 b=IwzISor/41pQuGL1VR5Mzg9tpxnY7MDP7/Az2kBBMbkCC+HTmitG1muiaoXWHhzmsG
 jd40uLLafNpnGFEKSG1k9BvqA+1G32CBARaYhPWGhPHlBUNBSgxFDKv7bHs7+iHcYtIE
 WVr8uwcpFQkxz8tWkCS4OfQBLSpvereZNPYV128kIgAV4Tchhzp1iDuHFnst3nKIur6p
 PEAksYxKsRe1m2rfyvyg8iFiMCXYFktBKz0PWYK7SjCSbzLseLfVr3jVUBhV/BnrHrOI
 vW09xfyhYynFK+/rrNmjDyq0gw0NvrtPeCHSY/RI3slA0cy4hHeRvREvw0UXO6XDDyJW
 apgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727794197; x=1728398997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wW4tS1JbeCnJ6FYG3DPiU/Bq1CUUdX2G31A9LRKnbYA=;
 b=wJpKpyffd96yq0LAqFPiH33f68RiGXVbw/NWa9CQa253v7DJQaEakC9gmemAqjLHE9
 EagXsiuwElErIaPY/3ZU2E9qFJsrBWHMmFqCUobeJKlI//HachM245j2JaOaHCIoVT+x
 LVEL4Lp7UbN8RxvUFib5r6bX+vY5PTlySabTOvrNkyT+Weh5eml3gegMY/HdYmmjH/YZ
 XqKQF4MWyuiu03Y0MczrN5TbBEbg3p9BRAFFLqBFILECxOAu+ZLXWxo8QDxoWSkzPOsp
 7362YPTmni7U8kGbfprGdNoInMFPWnQcyKkcyozJi9u7KkhrWKXSHrBqHXe+J6KT94C2
 hOZw==
X-Gm-Message-State: AOJu0Yy8UkXx3x4ErS0OPn5+ybBU17hZORmX39aT1MV0anLqkp5+P1lG
 ZgPAAgQgJ1+h/pfVYPKwhmwOb4XVzQSXtmpEdeore1O/UEMr0za3BRmYGWwFk1Ipejg26U550c0
 NjXqSsH9hhD13TWkGHtQ1i/RSxJgfE+jTpet+C37wPsCwSFu8
X-Google-Smtp-Source: AGHT+IEqrGMKIHseIoiAd7jC4ommPzYuzzrXGDU2i5Na+N2YuKlaOoONoVlrNhRqriIdz2pRVdBZV3L7YlFzyMIIF9w=
X-Received: by 2002:a05:6402:e99:b0:5c5:b9c2:c5bb with SMTP id
 4fb4d7f45d1cf-5c88260842dmr15880528a12.35.1727784584381; Tue, 01 Oct 2024
 05:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241001070418.28737-1-its@irrelevant.dk>
In-Reply-To: <20241001070418.28737-1-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 13:09:33 +0100
Message-ID: <CAFEAcA8jG-5pFk2WB1_VHBxjhqmwEPbYaGRkcMWvhF9cW3oUfg@mail.gmail.com>
Subject: Re: [PULL 0/5] nvme queue
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

On Tue, 1 Oct 2024 at 08:04, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> The following changes since commit 3b14a767eaca3df5534a162851f04787b363670e:
>
>   Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu into staging (2024-09-28 12:34:44 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241001
>
> for you to fetch changes up to ebd1568fc73209bbc1339a449f3df0b6c9a12358:
>
>   hw/nvme: add atomic write support (2024-10-01 09:02:05 +0200)
>
> ----------------------------------------------------------------
> nvme queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

