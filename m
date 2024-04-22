Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949BAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytDq-0005jf-8j; Mon, 22 Apr 2024 08:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rytDn-0005gp-Dn
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:56:35 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rytDj-0007B8-Qd
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:56:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so5231327a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790589; x=1714395389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nl+sgvBp+w/CT7gP97ti+pDaudI7/Gy87YKtR8NYhBE=;
 b=wa2/BYeoJ9R5HTeut0yT/PJKlKm+AhIKKeAAZJzuj6Y7zL+GNS9y9K0+ctVVs8Anbl
 MR/5s4Yl5wcfNif8k+sX91aYX8XqgDrKQxM/1OtrGksB+iokNsUcgmIQx0z7qRtAX9XB
 ALxKIPSqr4AleuoNSnexbFFX+yBp+JGlHkHIlOPGCxtzQ0Uf94gIKHMZt73auaBMlAJe
 xIAync8XlxMWjPLfGzdeqmKKnTcxdd2Epliq4p/BXJ3avJNZV3YrZeKQkx/aL9a/fs8j
 v4myAooi3dYEewbCxY41zAh/cKY+99o+8za47fqvkdQbtM8dMZc/1XBRjBkA68muAI+f
 RVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790589; x=1714395389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nl+sgvBp+w/CT7gP97ti+pDaudI7/Gy87YKtR8NYhBE=;
 b=nFcIiZ1VqN57SOEGnntIHOZ4QhX36eZBxR01aKfINSjd6xetOPYYaI4BXw0OQobZ6T
 c9iMFh1theRRUQ3mGjQkfJYfLTLT88k4hkCUvFdEYjg1BcOs0FiSZPbUVQ3Ye/dkTJXS
 vTdDmXlpPgoIvPsrABN0sb8EY2eZmvNJ7+ohT2gjguSzezZHzRFU6YX5cFK7vj4qd3F/
 wdzkG+gRRDGtPqlrre4cTb6a2Mr7UNbq6mTKID9T+o5M33srHRU7s/wKr7ukHnYrrvKL
 sBKtc6JOBGRreSeTr879/rtRN+ZddJIhl83fb8lSVv3K871iTIQFvv4YxxLjYQOICKM/
 HDyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5DPfiYVdPcD6PmRePRaTl6h8suyMuAz+QBxFTeYtcSNJhPzsm6w6CaNxPKKlk7s6iWmonV1QyeoRaxkKGWkSKW0/XUvI=
X-Gm-Message-State: AOJu0YyV3BEKhR/i9jYI0gpkkq/qUykTvIWNpKPJYLYwU4WvF1XXCaUt
 fUPjKCV3rgfebV3uzbxNtc6ZH6JsdxHWFk1sDQhHp2vjJJrnTbGV8zEbFcQnzEtcDB8rHYuoZao
 u2Frc9nr2DtwVB9sBphxO4C/nBRiB2AyaH7RLpKIALjva6EP9
X-Google-Smtp-Source: AGHT+IFUnl+1xZf6WF/Sp3Q2G+R5omXfQcubTdFpj5v/drljRoOcAGkRgoi04hqJ5pviDoEI00aRMuw5/bvLThF07FY=
X-Received: by 2002:a50:d609:0:b0:56e:418:5559 with SMTP id
 x9-20020a50d609000000b0056e04185559mr6425782edi.3.1713790589501; Mon, 22 Apr
 2024 05:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
In-Reply-To: <20240419184608.2675213-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 13:56:18 +0100
Message-ID: <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 19 Apr 2024 at 19:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In previous versions of the Arm architecture, the frequency of the
> generic timers as reported in CNTFRQ_EL0 could be any IMPDEF value,
> and for QEMU we picked 62.5MHz, giving a timer tick period of 16ns.
> In Armv8.6, the architecture standardized this frequency to 1GHz.
>
> Because there is no ID register feature field that indicates whether a
> CPU is v8.6 or that it ought to have this counter frequency, we
> implement this by changing our default CNTFRQ value for all CPUs, with
> exceptions for backwards compatibility:
>
>  * CPU types which we already implement will retain the old
>    default value. None of these are v8.6 CPUs, so this is
>    architecturally OK.
>  * CPUs used in versioned machine types with a version of 9.0
>    or earlier will retain the old default value.
>
> The upshot is that the only CPU type that changes is 'max'; but any
> new type we add in future (whether v8.6 or not) will also get the new
> 1GHz default (assuming we spot in code review any attempts to set
> the ARM_FEATURE_BACKCOMPAT_CNTFRQ flag on new CPU types as a result
> of cut-n-paste from an older CPU initfn ;-)).
>
> It remains the case that the machine model can override the default
> value via the 'cntfrq' QOM property (regardless of the CPU type).

This patchset turns out to break the sbsa-ref board: the
Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
avocado test both (a) takes rather longer to boot and (b) when
running thinks that time is advancing very fast.

I suspect this may be because the firmware hard-codes the
generic timer clock frequency it is expecting. I've cc'd the
sbsa-ref maintainers: is that correct?

If so, we can deal with it by making the sbsa-ref board set the
cntfrq QOM property on its CPUs to force them to the old
frequency. However this will produce a technically-out-of-spec
CPU when used with a v8.6-compliant CPU type, so probably we
should do something to be able to tell the firmware the clock
frequency (if it doesn't want to just read CNTFRQ_EL0 itself).

thanks
-- PMM

