Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27457FB3CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79Ez-0004CI-30; Mon, 30 Mar 2026 05:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w79Ej-0004BJ-GB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:48:45 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w79Eh-0004rC-Ml
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:48:45 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6501cbb52e5so1114570d50.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 02:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774864122; cv=none;
 d=google.com; s=arc-20240605;
 b=Jnr6G/6v/s0oxzV0gIMnbbFh2KIu8Oio04qas3wKiiHPirw8wwCetOd615CRi5WaK0
 2e527FWR47ciGfUTqRJzsPTyqHGzgtqh6djuOW/KrFUMOdIJMYxOxQi+x3UItWiw7IDk
 iVBEHfJT0xNcCJmtGtthjxYdfH2V9N0mqj1UWmgpo/IzOZgk371RNHaPUI2w6xtJ3SVX
 5uqn+gFvPDSajekh+bBDyPg97feECySdgOVjwdwJrY9P9AMdgBPsBZA+J7EUulzyVOC4
 1WkebWCaGpNVPCW4PudGBoOJx1CtLMCI01YVzddKkFtFIMzbxEGlehNcfbB3ZVOaoQWy
 4dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iycBXHR4OTtAqOojCOVJqRWbKeXzzC5WpBs226XflUw=;
 fh=AEBg2FGFISbLihcAZizbFzQQBOdP+MZ/WH8KBCvFEmI=;
 b=FLaLtXEgT4cxFWdzuZUkacfCLj/WgIsp9z1rKN63WHwUtMojjTGS+F+FlfbptpleXY
 LrF3WzYHR07zZTLw5kMYXgSLRRxNiHGsHve/PnkoNAf8Mw9ovxi3/KS7L9GewhxvonHK
 HJ60cxHkGHZhqpTafttXg0M2L1v+DHfvSRhg21txpEaSSxuqm9V5gNFiOp3ns+Nnlt9n
 AhilTAtRcnjfKnYP++ie+oUh31KezbbAYAuDeb5ovscX17IeFGPVmHIqXxbiMeeecc7z
 m2qh15X8doBXJAyiL4lPSg2YBrp4HyMd68sx5CiLpE15StWJGk77Kyg7+fuIJcpV/Fy4
 am+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774864122; x=1775468922; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iycBXHR4OTtAqOojCOVJqRWbKeXzzC5WpBs226XflUw=;
 b=ruYXpEr9ZYy3j6YVrbaj9F4d9kaXuHPmUfsVOwGR7IG89f6ztp+lP1Qb2ec2r+BFeP
 2tfXOP5puZvwMSyVD8seya90JADqz1OoolrrgUQPUAEecG35XsXu7RhQbp9PsbdF9XYq
 MJMs2ANZYdSal3Zdk4xRXEFXzYikKwtHgTthtrdIBRXsZuT7rREGYY0D0Q53wsNjHzYC
 m1R5R2BhWw0tuGhBA0Wdz5mK6IdC/RVmMOaCmLqDVQb+ZTbn35r7LAdUR/tpscuq5Ahg
 2IoLPs3B+QilTseXEPta7Rb7ym37PDLkaby1Odw9DlJ2DUo8KuiH9QwjIltckcQHSUq4
 6w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774864122; x=1775468922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iycBXHR4OTtAqOojCOVJqRWbKeXzzC5WpBs226XflUw=;
 b=Wx/h6VZ613UPLKA/yxRdPdpT5oBU4i8v/rnHt63hoHPCFRPNK51Im6dTNzgaCgDnft
 ajG3GeIUM/OhqS5NNaLtJC0KiNfSJYCzie4GJQoP0rfOSOa2x+qijRsaEFV8V7ANRT5u
 GaYlkhPlqZAwMyoOl2OLrYAR0mjCgj6adwLMx88juvZ2XHdUHeFbPw41FsIA1k1qr6vd
 4KK5H4ze1MWioayESanEHfvbEeAnQ9Fh91GjqW03EwfAATooVYPlK53J5cmi/7LLNzez
 mD5LIos4n+Y1pGEX04wpz/NunEsU1JLt8Z0eRQpf3hJAcm0jQMp04IQwoat+rPR5YCiK
 fXQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbmrVmw572fQaHcvtcKxb+tedlA0zWCDHx443o+IkHyVrz0p57Ev2/7O4Of8VqdKRhWQgSzzejxe5S@nongnu.org
X-Gm-Message-State: AOJu0YxitL0hyoMCSTig8FHL/6HQ5wNDJ4ziI2VHoT7rt+0HG43Y21XU
 43y/GB51EIlgERmieWo7coMQJXZvvpb2pWY0kEAq+regCCPs3qXUUemvb0V9J1Uh64+tVx3TGsN
 fd1aWSFCBkauL/KSywLBMmUxYegkAQUExPsCEgAoEag==
X-Gm-Gg: ATEYQzxiYEo+vRB28tL8UN28bwmvYenejjREbBD927Hfs8EPwMww7hb2mpE0RuBza4K
 iBhdXO9qmcVaE08mAS/9RSQb2T30KuUSzqDuhKvhDvgfB4/2QOBhSA00tkfhfwi5CD+M/jRV6cY
 ZVq3Eh6bKpi2s4Zlru7sF7PHNQ6XrKLRVOdL7PCYWUKt80ERrdo2TIBifad69W4t3yXz52ylUXf
 1DHNjKwQnKTrU0aC0k+S+sDyV2DmCK8YaR5F2o0ynNW091wA97Mb+lnuJzZtBiIK8kAjrSqMnp0
 L5zNaYxUeQD1WUN1uZzpJeBuZAF8zmx2qVuPBgWr3rlUam5sxRuNY6+kJwge3frOBXY=
X-Received: by 2002:a05:690e:2251:b0:64e:a1f3:e5c9 with SMTP id
 956f58d0204a3-64ff741d88cmr7876521d50.57.1774864121679; Mon, 30 Mar 2026
 02:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260327145012.907264-1-peter.maydell@linaro.org>
 <f31d3ba2-b843-4322-aa8e-2c5a1cd76fdf@redhat.com>
In-Reply-To: <f31d3ba2-b843-4322-aa8e-2c5a1cd76fdf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 10:48:30 +0100
X-Gm-Features: AQROBzCrCjyaQBwlWbMfmSV8leTPOggZ0jndM_HDgwKjxlOLP347-UrJGdJj008
Message-ID: <CAFEAcA8UQsrFo3nQRN_3F6CAKQGWCgv1AsEP7w8FD5-EWDh8rg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode
 option values
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
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

On Mon, 30 Mar 2026 at 08:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 3/27/26 15:50, Peter Maydell wrote:
> > In zynq_set_boot_mode() where we parse the string the user has set
> > the boot-mode option to, we use strncasecmp(str, "qspi", 4) and so
> > on.  This is wrong, because it means that we will ignore any trailing
> > junk on the end of the option string, and handle
> >   -machine boot-mode=sdXYZZY
> > the same as
> >   -machine boot-mode=sd
> >
> > In the documentation we say:
> >   Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
> > and that's obviously what we meant to implement.
> >
> > The correct tool for this job is a simple strcasecmp operation.
> > Switch to that.
> >
> > We use the g_ascii_strcasecmp() rather than plain strcasecmp()
> > because we're comparing ASCII strings here and don't want the
> > potentially locale-specific behaviour that strcasecmp() implies (and
> > we're trying to standardize on the glib function for this kind of
> > string comparison).
> >
> > Fixes: 7df3747c92d13 ("hw/arm/xilinx_zynq: Add boot-mode property")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>
> > Kostiantyn: I sent this patch out while it was on my mind, but
> > don't worry about conflicts with your series -- assuming your
> > patchset goes in first I'll fix this one up later.
>
> No worries, go ahead since you can apply this even for 11.0; I'll take
> Kostiantyn's patches and handle the conflicts.

OK, great. I'm going to do a pullreq before rc2, so I'll put
this in there. Or if you're going to take Kostiantyn's series
and send it out for rc2 then feel free to put this patch in
there instead of the one that fixes up this file.

thanks
-- PMM

