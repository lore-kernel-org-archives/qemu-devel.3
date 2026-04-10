Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750E3F44845
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBAWa-0004Un-Ns; Fri, 10 Apr 2026 07:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAWZ-0004UT-D0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:59:47 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBAWX-0004Bn-Ue
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 07:59:47 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64edf260b49so2978369d50.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 04:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775822384; cv=none;
 d=google.com; s=arc-20240605;
 b=Yn2CqTUvYvxeJD7rpIg4ODcbWF3lXlVlRMgIiDBSI3M65o3fbgQ/LIldn1w71xC9BU
 wcv3KLKv7HUTUHuhgJxqzvfpmPt2THJNK9pdUYlsuGf3fZAYR8AUelFDbcnGhNcSDx73
 CP+WkEAyxscpEyGB/dKasom7jZ7hKY7/qoGuqlUoXyfrQk9LQBgp0rdbsSvPfqfM9F1w
 JJb/B93nnI9DhjESz48APJIxOClH4a2bUuHz7q9Te+jdez5Z/rzjjCjplSPYm98YYvm4
 qXyNhf8OlbE3uhMEjMuQp+DqwwfyqSxtVYV0Dgfq/BWzTc1srMBuC6LL+znFZ78nxeVO
 5GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3D40mIBQsPhv5w8N5dbt3L4osa2H/vn6qkOsV7LlUcw=;
 fh=lkzhKWZgHo8tSGJIkF3uZ+inLgOfHlU5ZwYpqW0J3qk=;
 b=WffSOpt+Vh7aSnF5ZUbIk/rO4BYkn3svWoPyDBFm9rc9xQOsZLQ129q7XqYfzc5qYk
 PNTlDHcses8SENR4PKiwSh5xP0EJ3bzElIzjXOstHL9J/gW5Lo4yHeqOChBux72WggDL
 HdaDwFF3G+miKWKo4/nYDxgUdM4pCWrIcxtzdWQDEz5nkSCW250Yrc/qJmMMUJE0DbOB
 i1YW7xbHdj6BDAW5gzFXPQPG6YvqYohporDR+odcSIOIPm4+/6NySTyFwGDqhN54TzWw
 O8tIUbLZrsVNaTc2SAvjMe/UgwZUEzgP2brLLXy+/wLyMteCqYNVZfs1MwewTc5xmcqz
 4ddA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775822384; x=1776427184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3D40mIBQsPhv5w8N5dbt3L4osa2H/vn6qkOsV7LlUcw=;
 b=uL/ZGSwj3aXScLtfnZYsxom+5KzMiNkNVQik3o9ZGsxDdOnbxwaaOiZsvGzkO3OkVq
 A5bUi3FI4Hm8UQ1SZKhuPcZIlgQAqUs77FkP9W8Z4IU5EHpCBtpfv1sK5QD/wHCdcMdp
 b4BpDSYLcsUuIOECxO/T19nuMghtTyLrHPcZ162/furazzRqGByoQKjGaOCS5Y8CxIaS
 blOQDK7rFaUZIz2PJ11Pp8Rusvhnx7p6nKK0GDQse8rvouaDV/s9gOR6SkP7nA3SLUjR
 o28U7uVnV/jpaCy9v8l1RBJb9sCsK3fdZhLRrFCNB1l9fPiGiGiNwUkp/qAXAabXA8Mw
 7KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775822384; x=1776427184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3D40mIBQsPhv5w8N5dbt3L4osa2H/vn6qkOsV7LlUcw=;
 b=emgkIo/Ia/SM8srmyidzvLNwy7ZnjadMGN7O7zMaEzFTG2gcNJxzfCaGBDP+qm9dTd
 q65gTUwWBRhJtKxJuxqkKeZx0YFm9nD91eI8Z35+VGDcMaveMk4luty5I694dt1wy1N7
 vqpArx6tFthom7Kx5AiIjGlsB8L9xQz8bCS/oDOdkYxTBlXNmDJ28jW4C/JXzQl8CEpL
 pJ4wA7q0CXwp5y8ECh1o5fiTrXsq2Zl3PD4hjocu+57bddW2yl8HbGdymRxGf1UpEH3a
 q6let3KAF65U8Q9C2tnIZhHWfUz6pmEEK7EmWPwGvR5pSByFawV2p3GA/Pl9QSW35maH
 g7Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQMVCrBsasXpLFGKyBwMZbjOGMwh8cNbSNBSRJ/u5bxaWg8Yu/S0ZgZAdUIkJyMKzQmGbTsKzJWY9B@nongnu.org
X-Gm-Message-State: AOJu0YwX8i+fazRYJGdRfddVvF4g5HZbrGZjBQ10PR7WOzyRj8CyQOo4
 /z+Xuw+A8ygqo6+TUO6y9wgOhauORZDfTG0ryx5Qq/RQUAmBPJ2Rzrp46q4VyFNaC3UkiJ6yBRg
 XErBMwDChL5ehDZAxy+7O3Tpqqn6esrJ+XqrZdRd9eQ==
X-Gm-Gg: AeBDievTTe8NCIwlpKOhhT80wk3Pt36lIVvwkQEzBgCH4pmi3BQKBDKfl1SWG5FGESq
 QZH53TKb+sj75+Sra1oyTG8QBSYnnyJvg0/Hg4KQe0lqvrsdATcTg0vfkuCM/bT6TC4zXBZF+4e
 7IxEPh/Wy4l547NzyfWOfxZAk6oHWPuAXU08uhCfvQ1bZIEWFbHC3N0Nu1HUrknwg3tE2cP5Wzb
 YczPxrpCGSKAZSs/JQu5y23cXu49CjK6OOsKpLMPB8gvnkTmYnscIW0bvNodSpaEf+6yV6+cfYZ
 qSXEReAl1A7eGbnPhpqngHZmIzPME2bGM7E6TaQVRU+rXlpHtPEeZy1eLT8IvB8Cvgds/sJ63Pt
 E+w==
X-Received: by 2002:a05:690e:c4f:b0:651:878b:d819 with SMTP id
 956f58d0204a3-65199058a4emr1998205d50.17.1775822384027; Fri, 10 Apr 2026
 04:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-7-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 12:59:31 +0100
X-Gm-Features: AQROBzCGRD1e_255lIV7RPpsBrErU3yJsmgWz6BLzMstGlZ2JBe-TbfABlhrWnI
Message-ID: <CAFEAcA8WjE7gJOKJULcBKAu=hbmu3rx_7sj3br4n7xhxeFSatA@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] Revert "target/arm: Reinstate bogus AArch32
 DBGDTRTX register for migration compat"
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>
> This reverts commit 4f2b82f60431 ("target/arm: Reinstate bogus AArch32
> DBGDTRTX register for migration compat). We don't need that commit
> anymore as the AArch32 DBGDTRTX register is declared to
> be safe to ignore in the incoming migration stream.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

