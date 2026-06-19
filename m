Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C07CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYrq-0001wW-VT; Fri, 19 Jun 2026 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYro-0001vm-S1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:02:40 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waYrn-0002R5-EX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:02:40 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-662f479a22bso1837080d50.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874157; cv=none;
 d=google.com; s=arc-20240605;
 b=NeMuv8fiBrkkCgyfslcv6vE587O96LZCx3yuX9Z1X5rPAX1ievS9Zg6blCjz0JqqGy
 WOiEyrIt+FQxmYi3vXKY1HS6viOL5YUe2LRyr7/bSZ/V1HMYgHJP/LO+yAzWtsDeeJLo
 4J65Yvcwui9GfxvHOHI/eYwAgXOSoXnFj5D0jFxICsZRLO9zkhTXFidDsUBXrJEtR+K2
 bTzkcJrl14ouioj3CHll3TDs1scBN3b3kKUn3bgWWoBr9RyViP2jqdLGK+ennNEiy+sH
 fcA6sJd37N+Do+lBSxKD4u6LW93G8t9gXtxyXYmYnlQTbt+AekU3wDOSyST17scI839t
 fb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vj7lhyCU6w875fOWKpCllsDIfr4MMDDo3fFJTeXo2Wk=;
 fh=4ArW7zZ5JUyK8fPo/YUH1eSBS6ZNAADQHBvm6Mco9wQ=;
 b=ew4Ms3lXXoHI4U3NJJSGLZaYGvCywwcslirmreGBf+icr3P2MNr44799zM2OtUjvAB
 x4bakq+yh3OZjPuyj2IgLkhmc9kkrsnnKR23xLbAvilav5x9ERosqH3bRO6JdGkLHCoz
 S5QaRFdM4ioSBVgvLNycekVGh8wVjsv1lGIAciJyddxMxh1CZUhaCT83kmxVyaegPuEE
 mFN7R/2hq2nyTSJtoG9llxGh4ktVrRLvwmBX06TlYWWgUaMPXUl6XAcczlzAsIVzP9Mn
 fGMK8GVS1uBIT+QNBWqqUPqeSUFB35aY0yLR3+N00h325fm24zEGl89kclqqbErKHeN6
 N9JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874157; x=1782478957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vj7lhyCU6w875fOWKpCllsDIfr4MMDDo3fFJTeXo2Wk=;
 b=JcbFhlweLn27rJfw3+B1+v/G6RAV6E1vKk10xJpBtC7VypbFR1DCU76CdASFUcBzHQ
 g3si55VbcfeX+a1+cVzPHlWAHGsAx2qXTDtqKN8k3QhODewWYcMekHvlFqNr1J0aTqjh
 iEOsGGl8jU65YtTj+7kqfNcg7/gUjttBXmW7FVGn3HSC0udEsDMk4nAuNmxRRkf3CBR4
 3xyRw70I5juQO9F/br4rz+KAweZbu0/4QPDcMVqP7UbAvPvQ2OnYFjbMQJTZv9RZcfX8
 AXfMq/aryX1RY/vRqDzrU9dCYfMwo5CPPjP9X913T9YO/YfKry98inv/NYo0kOn4iKvV
 RsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874157; x=1782478957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj7lhyCU6w875fOWKpCllsDIfr4MMDDo3fFJTeXo2Wk=;
 b=VM9nqylZCVT16W+d33MDDB8A4FIGDTP49gtF9VEHZImZ0mUEN9Bs4C+v9p3iJtBH88
 ZG+sFJa0kZzsErQ4uH8ULmBOL4uqkTh6Oo41+KQY5iQrwVAphJhn44EWDxftLoFLocYL
 d042NHahqo/hTCpYcCEHDp42aSSxqafemdoox0E4v1XTsojKUmRACHYUete3ve9rPANm
 quAU+mVkhtXH1diZZTboBhWuoIXmSu23QOsWdMPLSO54+grzuqa1vgfVPZmbnDkbwEaT
 UNgJKLQUNvSkUUinvP3zDdPmK42ILRGUDO0Dc7gUqXWRvwkpE7N7i3k2As/pQJvho6xo
 Iumw==
X-Gm-Message-State: AOJu0YzyXTh5gtkc4tcePiUwKtbE4m2f1OyZYamvsGQtaEh9CrIDnaJ2
 ZHqgw/KseXU3+GsHgNUUm+jR7ZiJhtsW8Ia4WLnRrPTUdsFCR2LBhpnZlaMEEMrVvKmyD7UEX+/
 Xit77dDL56uG3GIMo2b4qptaNjYrMXDCMY9J3Pxbu8Q==
X-Gm-Gg: AfdE7clxe9NajuYBpacMdC2dXSkNEssLfHqu2ncjPLrm2fNUXYroDGsHh7wRQdDXKnK
 l57M9rIhK0b0arRiMmgvl1H3qAIKA0qXQhBc5wjSHUhUkGD+cw7NnCjE5Ylwz/31ltI5l4DUxEg
 1bfkuvaEiLTEBdJqE7AMANVYcKxEr1WKH2b+tSNYfvGIzfbY55eMS/LcuX9knu5YX2WPdi/bfPT
 IR0yu95fhX/ub2ZznAiihyRIs91U3nRYaZ9vVmqFsfn1AJ7VdSIHf4Duqc6iKMASteucefFfnMJ
 dbZbzVZa4Z7B96uj7d+AYc2bZd0zlgef288laAyyaMMvmGZnUXpsmMaI
X-Received: by 2002:a05:690e:168d:b0:660:7ced:55cb with SMTP id
 956f58d0204a3-662ffba0dc6mr2583630d50.1.1781874156853; Fri, 19 Jun 2026
 06:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260618040718.572950-1-richard.henderson@linaro.org>
 <20260618040718.572950-2-richard.henderson@linaro.org>
In-Reply-To: <20260618040718.572950-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:02:24 +0100
X-Gm-Features: AVVi8Cf5XGNFcNu4bipr0r32xk9Ctm9dttyGvCs05BYjC9twR26ERl3I79OA7b8
Message-ID: <CAFEAcA8pJz1X2bCsDKSp0+mEPba-V4Aq_90pqZc=Axyqqz+GiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] target/arm: Enable SCTLR_EL1.EnFPM for user-only
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Dillon Sharlet <dsharlet@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 18 Jun 2026 at 05:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We advertised linux-user support for FPMR without actually
> enabling access to the register as the kernel must do.
>
> Fixes: 2430d49a17c9 ("target/arm: Enable FEAT_FPMR for -cpu max")
> Reported-by: Dillon Sharlet <dsharlet@google.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 4 ++++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

