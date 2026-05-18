Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568BDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOst1-0006QE-S6; Mon, 18 May 2026 03:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOssl-0006PM-7r
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:59:26 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOssi-0002q5-Ru
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:59:22 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso2015839d50.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091159; cv=none;
 d=google.com; s=arc-20240605;
 b=bd2EmBShRol1js6ir8h/Io3LxvvBRjvltgEeVz+yLCfMr+Z3okPsSOAl3vIFC8riHs
 Aj3HNMn3etc3su5dwF/cRE2HobP2Y2SxTnpSZF31KqPdegalEEPthwsPV1UlpO3TAhrK
 W9l5dwL0Tx3osaZ6cymGc9yNoYMirydriddxuQ2cWj2b6lIrDbiXnlAfkhOe+WE9SjFT
 jdjCA+VdZAQCjLJBKVNoee64P1ia/TxqzBrqKX7gTKr5eJujHW4PnTAs3TNZ6MyRqrxx
 Z7uLb7nPE6kJYEo+a2lLd+vc+7lleup8PbLiDFkre9xb9Z0/MdycvFDlZ1+sQF+m2WnW
 Ceug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bjPJLzDEZVBVu0sK9PLjZ0sM0ySsDXY2h7uFcBq/ArE=;
 fh=SqhfW9Uabp42tD4Mwg9dafZId5P2FwuZ7m3MYYvmn94=;
 b=S9ufl5c9O8RVChJF8TeTB5GTIjnTAZkORBI8KHvSNT2V66nDZXOe9Rez7bqTNpUtto
 5kg+vH4gTLdhl/CgGit9BeOthtZG3/FmVtmFeU4pVxl3hHkkl9cvZ35fLs+vn4593nLT
 gAcCATcCYOuNbHFxXwiVYiS5gUp30CKyTeRMSCBxV6FepjdJN4ucMSrDyPamAkimgk+k
 lOnpnV3dZhedzBkQjSync2gq8P/32j9VFZedlV9CwaTkIs/B5zFqKlDFwY8B3jqgCG36
 dap4oat8+Ue0ndLJ9KMRhkBrmeeGfQE8AlGafdZJvzBy4jz5ph+DJUpzkE/jwYQjuVnY
 +8Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091159; x=1779695959; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bjPJLzDEZVBVu0sK9PLjZ0sM0ySsDXY2h7uFcBq/ArE=;
 b=meeWRrENC4cfiwZamISpHg0tHis+hx0cIdY8dLDkV6MkbS+KsiTLDR2pmTcCx1tMB4
 sUYIw86fIOHTokGMqifQ60Ge7Yi19TdnSoN4FNmCK7e1ZETQenGMop/P0v7msit32K6x
 5NXwbWWfVfpWqfjuma5avZJoYm/2qtFfeUtg1VQVRLjLX3PG1xM8S7eJiJLB05/ObHCO
 Im7d3KGrhFXtTRRA+kVWcCMCimqGEFJ0bxthsSOWrNm2JIjvCg5z9DCEbqy6RRikjxwJ
 eW+v5O4CUhyu2RgYda67UDWRsAPsn+eK7DG5qCpWtq4T234W830ac0xO1s9x0O8W9qhm
 vGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091159; x=1779695959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjPJLzDEZVBVu0sK9PLjZ0sM0ySsDXY2h7uFcBq/ArE=;
 b=hp0FFyh3ovslkTxhSf7yoNuXXiyQ5Y5tDCmbwtbDiYxLcB96+dCcf8AaYcg5Y5+Fmj
 sxUIhcvQN1v72oO4ZUsn455cdaJxKi3qhGXAS3a6DDL5MpmLiyLvYfhX9aCBHiIIyDfy
 qyN1toMY4SVny43ItpoCnNIQiCdQWuMkv8fAkGEJAd+C8QEKlnvP6PmpUlv+onnBGx/3
 1jOoeo6UnIHedPxrZwriDDaZVdvll2sYeXdv7DV3AWgmkkkWTthoMNl/W2dy7e11x1C2
 SPKQh+OKgR7RtcVnf1AvOztaJiPbrFVEIHWMJK9rE83+v2ym/KZyJQ8p1KeTmF8dgLc1
 fPxQ==
X-Gm-Message-State: AOJu0YxxioDZwZlVV7kyi1ZfMcHxzR5HXr+yYI5EIV3n5Y0BBzfdvuby
 spyXfSGeBa3nP265616M7NgN2AjbAfjs+5zHM9KjSubJqh2xNSy6lFwsIk8ICJjglqzPqutllXf
 /y65D/gySX246KgnkXcQftvdPIbqQK+JK70JjY9XM/r72b2OHHFRO
X-Gm-Gg: Acq92OEhwYyp2TXx+7ys+0XnrnL24yM7Pus4UD9wHJADLBHK6SLvLpHIqJVhp0mOwdl
 usJtJo/DcJAzBGNjhmLc7qJoTia1MjhpZSAPSVQ5VK5DkJXBCMk4aYWrhYO37WcYJpc+PysmnxD
 iuurerMFRe1iRn0psNu9EoEHFYdeMTs6JIhn2Gwjtk/oqS+/tNuSXhZ+i7V1SiYxJ+adPXMW0YT
 aMmJDNLXJTJx4Cwjawpa+wBLzTKYE4zi3KCXypF3hafKI02WC55cl+opKGwFCwkodh0PVM+8SuD
 tFnTq4hXA/p11R3rO3ZH8yvcXxV+dp3i0DQYiEl3imEUiFxhBLqUMLCzNfDnYMMRf6w=
X-Received: by 2002:a05:690e:1588:20b0:651:cc9c:af0a with SMTP id
 956f58d0204a3-65e22769ffbmr11447251d50.15.1779091159239; Mon, 18 May 2026
 00:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260516005558.92136-1-clintdotphillips@gmail.com>
In-Reply-To: <20260516005558.92136-1-clintdotphillips@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2026 08:59:07 +0100
X-Gm-Features: AVHnY4INU3mo0Q0Fj_gwLRptx4DfsJXosVW2MHMlOrg-GHhmOcWwh9lJ7mdghgY
Message-ID: <CAFEAcA8SSL7NGzk1rhBAB2dYTYomvpU6PmiS4fpY1WgWj=fFoQ@mail.gmail.com>
Subject: Re: [PATCH] docs: fix doubled-word typos in user documentation
To: Clinton Phillips <clintdotphillips@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Sat, 16 May 2026 at 05:06, Clinton Phillips
<clintdotphillips@gmail.com> wrote:
>
> - docs/devel/style.rst: "assume that that type" -> "assume that type"
> - docs/system/arm/aspeed.rst: "how to to boot" -> "how to boot"
> - docs/system/devices/can.rst: "supported by by drivers" -> "supported by drivers"
>
> Signed-off-by: Clinton Phillips <clintdotphillips@gmail.com>
> ---
>  docs/devel/style.rst        | 2 +-
>  docs/system/arm/aspeed.rst  | 2 +-
>  docs/system/devices/can.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index b8edcf9..6b9544f 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -341,7 +341,7 @@ but only for RAM, it may not cover whole guest address space.
>  If it's file-size related, use off_t.
>  If it's file-offset related (i.e., signed), use off_t.
>  If it's just counting small numbers use "unsigned int";
> -(on all but oddball embedded systems, you can assume that that
> +(on all but oddball embedded systems, you can assume that
>  type is at least four bytes wide).

This is not an error; both "that" and "that that" are OK here.
(The first one goes with "assume" to introduce the clause
we are assuming, and is optional; the second one is a determiner.)

-- PMM

