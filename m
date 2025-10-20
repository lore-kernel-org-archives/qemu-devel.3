Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2B9CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArX0-0004GI-Um; Mon, 20 Oct 2025 11:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArWx-0004Fi-Tr
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:10:39 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArWu-0007k0-BZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:10:39 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78485808eb3so23714327b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760973024; x=1761577824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DeHTAux22KeEGA7Tg1vonwTaHtIJ0DcC+4BUu5YQ7K0=;
 b=UUheYjQYw/zuGQTdC3ajlrc0ymRuG0JakZxXZJq+FivFpYcCPYAQBK3iPrSA+UPgKt
 MrfIT9Js4tgY5a2PnTGzApOSdKFtPjLNSIU29eEMoAaV8Q/FULcT+O6/Glnd+ZvSwNGD
 AYyVrWsU4YFkRod5Akn0HKWhQ0eT9WAmmGOPnBo/RxmTzF2TFozG1sXaPttiXMmTFmU5
 okbcYt++1coq5bGnLRtvq9+aMU0Wodn/vAf8OGRugTyZF3czYItd3+vruMzuTCePHRvd
 hnz5IGGmUVC9OcfDVzsSnA/wf/OErL2B4SY3tYLIECngqvtJGYkezLBo3a9CPSwEdqVW
 jjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973024; x=1761577824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DeHTAux22KeEGA7Tg1vonwTaHtIJ0DcC+4BUu5YQ7K0=;
 b=tuQAVCOqdSmWMxJ63lL5Nyl4RYMi8oc7jjXk+1TooB5LRtpU7pfRKgTcWoADJn3hOA
 liooJrxDtG4kCHw5BSUwNrvpAAgVs0ZaMqzo9LvDMAuf2i8ufkRXYf7P9Yz1jf/Ko+IG
 Yr8yFlQHwt1y1ehD/YSO/xFlLrTMnp9xwgZ296XylgdmeAh4dx1Kf/mf4ZX9oWuWMH4w
 Ya/kY574acjPat3Y0POFPPzltZN96/4QNeseCdmEHczyINoJDc99FfJAp7I6FGGQf5pT
 djPPRWX6PwbAHzjACs9TRYm7Th/OrROGdw3ob4Vs6EoDnQZoipQn+4bn/tWzEO4W3UE7
 lH5g==
X-Gm-Message-State: AOJu0Yy9PxtO5pfyBTZeV4L2lYPwyA9PE4XnZi31sEXSKtJGnWiJhMKh
 Bl0ijMcr6vepGexO9pJx+pA1UjQQ+7Ia+hwObs5yWmlRTAh5IPpnmIoiGDb0gQoKi6yh+KvYAWo
 Nlc4gW8ohmLEklVev/a4brQq9eOtxYFXXjLEqBrVOsg==
X-Gm-Gg: ASbGncuzSK/BgnU8tWqKtrHmTWk10qt4b0fXi5YUKMoZlhvvP60Cf7bt90AzAi61qcm
 Wapqaplk+R3+FSIZNB/CIC5XByQHVp8biHEqXxsA/xMihZAoyNJMR9SzG0uTwu0Fl8qnz6ZkmEW
 HObanKzSGUwbZTKx0dIVJFwrFG9BC2+q/qP3KSGm4pxPuXZI3aEQho2pt/8re9V9HLEc7CaBTy2
 GvflCUMy9lxgkB/hilzup3KFgkR3xu1nPXLlXp1njtMEdpEXj+EADryet9VAA==
X-Google-Smtp-Source: AGHT+IG3xbs0BU3ZAwclcvigbk5oaceqjaB7YoeVOJPJYaxELGIBoKVCstINUdjVe96FfKiHe2AbaRAHsG5xYJ4r/J4=
X-Received: by 2002:a05:690e:1901:b0:633:a260:14a1 with SMTP id
 956f58d0204a3-63e16109edamr9843570d50.18.1760973024028; Mon, 20 Oct 2025
 08:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-3-mlugg@mlugg.co.uk>
In-Reply-To: <20251011200337.30258-3-mlugg@mlugg.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 16:10:12 +0100
X-Gm-Features: AS18NWDWtfM9sdufYJn6K21KN24FelG8rGXufn3CadULkl1Nn6JD5gY_SClPAwI
Message-ID: <CAFEAcA8x3iWO40B+pbMCJUtD7ygfujHU1bX-p9SM-6WTphT=tw@mail.gmail.com>
Subject: Re: [PATCH 2/4] linux-user: fix mremap errors for invalid ranges
To: Matthew Lugg <mlugg@mlugg.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 11 Oct 2025 at 21:21, Matthew Lugg <mlugg@mlugg.co.uk> wrote:
>
> If an address range given to `mremap` is invalid (exceeds addressing
> bounds on the guest), we were previously returning `ENOMEM`, which is
> not correct. The manpage and the Linux kernel implementation both agree
> that if `old_addr`/`old_size` refer to an invalid address, `EFAULT` is
> returned, and if `new_addr`/`new_size` refer to an invalid address,
> `EINVAL` is returned.
>
> Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

