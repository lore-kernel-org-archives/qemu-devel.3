Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529D2CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2bw-00061g-Vd; Fri, 26 Jun 2026 05:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2bv-000616-AS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:12:31 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2bt-0003nx-UN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:12:31 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6649fde483bso426906d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465149; cv=none;
 d=google.com; s=arc-20260327;
 b=aQZCTLdzRx1SMoPbJ2zzj92g18DFbwM2seHCfraUaxK3AAa6QHikePEUaElRlLwKbs
 BTFLoWK7M9slpr0ojbMjHR8FElGCTief06XHKYy1xstibeS6N5nj/IFHbPAvcnqS0GHM
 bypNBM7EVYC2eGGx+eGwO18TQfJ+nZZ2ajeM9+OvmLSv3IAcszRZKppCjjymRWf21EkG
 rgZOHfvfmR4txMerzIo7h8+s93wfplLk7YZc4yG9/5j6X51AGWkXn+4sWOQJA3LHaLdH
 j58XrizkupNfACNcVrr9FkN6uLDnKC3Z+t2RDVa58qr8hTuUb+tCPWOveS5kaZXNvazr
 A64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O9cu0xvKU//LJO0clfthiM9MnPHVsDl3dp3KuEb/oAY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=iYF8tlmeIbLQbpoSY6JCL2ITkrf0rd8TNkM1rPH92BnIxHGEB0oqXDiKka7aQzv2RZ
 Vv2vZfe9Fs0SXiM+j1zHKht+yKetPiQAuO9P4Trz8+30HUjvVXhAjKmnZFhvPuM5cuEQ
 LrpzpgkFXccNIO9Jbd1mADw2bThEy7NOC0WfplRFQGn1ZKFN6ByG+XN9tEhX0XqvEFsL
 fax0nJqWrZY5/ZUdDmxdGM/aWDtYogura2jfAQni3fc3CbmHMfmLc9wLLIfYNGgvfa4R
 Bacq12WAvwcp0EelHJYLjjXm2hmy66nFHZn1wTGEuQMdvy9iKOQTYjPe4b7+d6SYoSDn
 wXJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782465149; x=1783069949; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O9cu0xvKU//LJO0clfthiM9MnPHVsDl3dp3KuEb/oAY=;
 b=zwl9pU7wAK8zDiqIRUoh2kaFAw54yFyTAPOewWq6TmZ126L5za+021hARrQbQbssDU
 gyL00Gzl9/fkTk6tLya+mqZ01/aQhBCSEKeD1ZHqwliGLsRfafyHKHGARqXSRT8G9Rwn
 2TwlaZqWEzEZ6NaYtc7hsbydWPBX2lJFYWOBkqu95q7yp2hhasv/xaDCHasRoYxWMSWP
 2lSrwla9ODIKMMIIoPzk458YZ6JE8gmUKUo8jM7qL0VmBmK+JW1o61twOv0QFR2PPmLo
 Sqa7kgQ+eM8slcQgIJhoQ7EEEfphgyUVNIoy6HJ6ynSeF8U9dlp0ek3cfiWiQAGQE/zT
 hgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465149; x=1783069949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9cu0xvKU//LJO0clfthiM9MnPHVsDl3dp3KuEb/oAY=;
 b=kjJZZxW2+Hs8nfkw7/DH2uVkdqNIfDdUVQfUD6Pdb5liYLxikx3vrdDGKauu9qCWmm
 t3oIhma1umXA2GWSs8sjJ3I1CRQLo0GjttgEPn/BHGugywlT9fRaA26OVIGMCU7D62eG
 48TK8QkkGbf2NP83RK5kvYoUpWrCqTluXuGgrIQvRrIXcrPsim6DxgBCI2PiYyQzfvL2
 dpC8Zb+gbtOHS3bM5xnfqTiCz/mEzMyDI3mqkgc4VLhFQqvYO5cu9fNKQFeUiPYP8TwE
 4323hTsbJBZUBYHyaKHLC3nz6arRC+uBFUS7NDLNOx8HNSXOWfRXOYGbKHyDz3amR2Kb
 VcKA==
X-Gm-Message-State: AOJu0Yw02xss9PQLWIErHEcmu5KAsUw71SA/NBKLpgX8Juls+pBZJPsl
 9lAeplWnZRU+v2o+T+XQcASi0MvdkATvaWjxQviVuUmm/GZUIDaIY4COajJRzVO9zsVs99LplAG
 zIqrGQwEuAE52oZVhqania/OsIvq1CYbHsLnPN8eHMrZ3ae7rdM5TlaLgW8oq
X-Gm-Gg: AfdE7cmG6Q0V0rVwlDU9RjBSpswrJ/8jt2V0o2aifUYldX+IzIILo+3UsntjCCbv4c2
 x+9pxDRJqGsjAcLk2TMUVUBexP+xKZcooi/S9AzjR7PvYzUXLOJ3YJNR4i3QoV8I0MyTcV8gL9C
 mMueL5mBC1yNP+Elx8bqLjqnv2N5SqE1HQO5TUBDOl7bCOsXH2LN19j8PbrhyOT8qvZaGNjLd4E
 i/2I9KA63AsaiGgjFF66fwUH3cIdsNeRrzWm5PfhFm4Uv1v0OWsP14BMPkbcw4EX9ojmz3Fg4pb
 VMgGZtuPkC/CTLKcG2X1VoAeyR7alxCMIGWKi63LAtO7RD79D1gdomVj
X-Received: by 2002:a05:690e:d01:b0:664:8d16:8cd1 with SMTP id
 956f58d0204a3-6648d169dbamr4408926d50.46.1782465148733; Fri, 26 Jun 2026
 02:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-5-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:12:16 +0100
X-Gm-Features: AVVi8CfwdP9Z1ZCiY3efh3Unju55KO5-LejBEezawgyJJDsxZbSRWiXiZUW15bU
Message-ID: <CAFEAcA8NiFxqBeAMFSWp7qvVtxKpVgDXzDDS+vcW04mq2wVz=Q@mail.gmail.com>
Subject: Re: [PATCH 04/10] target/arm: Implement FMLAL (multiple and indexed, 
 FP8 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c |  4 ++++
>  target/arm/tcg/sme.decode      | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

