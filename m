Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2E2C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 17:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc76Q-0005DY-Cs; Mon, 19 Feb 2024 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc76L-0005D4-45
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:06:46 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc76G-00080M-NC
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 12:06:44 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso5452928a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708362398; x=1708967198; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yrl78BR+KeYuZJlK7WS+qodx9vSN/jDCTIimfrNKnWo=;
 b=Q8czWNcJKpigzsyLZu67QwGLeiFiWWOA89ykPIwG9jWeRQiaEs1i01Rtf6D/DEs/cT
 01JQ/7tBgVy7kt2YjPx+g9RKNKxwtTE4fGz+qnABo2tXu2U+LBdkib9OQCoo1CoCtqVU
 ypktOHCTyRJHI9DbKzEPNnqitO/rJJAzTwNlhot21z0klrFfJeG5OeOgpa8DEsvmx90D
 D52WMZEOBWIAlcQq+0xPiUadS6HvDCCgTzwVN4JLX7Gy2QzrKThuwmn9gdqTKI50VqGx
 yAvHOiNyWSiSiY5iq6Z0GGrpnGKnopNWx+aYPvJLT8wfzkJXX9x8XBc5kTzDSyjjS/1W
 pz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708362398; x=1708967198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yrl78BR+KeYuZJlK7WS+qodx9vSN/jDCTIimfrNKnWo=;
 b=ApEr2OV13WVyhiHYK65pnY/sihNG/dIzT2OSb2f7QL+3utEQvxmR8FL63N20OrFKz0
 ZWqvz9jKibHcaG2YF9buI5wB2v0yFOILCqVHQJ6DefbwBgyMslTy7TZNUiGQfnSaZ+Hd
 puKfuwpG0244PIQWDZhnMaKnWFIicABG9vtIOYtbx8hVWD8o4Y1LSRkAxG6gGaKrZb7D
 px5fE8CDELD7Fj9YkeWAbTvga7dZgVUmIQsDUNx2I2uW0CQoY6wbNA113dDAizGavZOV
 QGXgViUpZV7h9XFpb+m+2GNHQuqxxXOhzaRc6TmZ6ypa027Z0U+9dBT+DYbjhDLvwIY/
 wfpg==
X-Gm-Message-State: AOJu0YxXU/O9hk5bWMlnJAKCYpjr0raf2qp1xb0GyzRYKKOGtV0IsEwx
 0xAwBIoH+V52zcdkVsQQA3q9gXVVrqvJX3zdHCwW1irhmzrRLdt+4foOtJUAxN0mSiZyrJZixbf
 jt2eAqedPuRPl3vA1R8n8DGUCmV/6zwppUC1jVA==
X-Google-Smtp-Source: AGHT+IFQTkcMIkV3d041hfRFTBJVTSaHVnL7PqxeAxaywEqsl9JE14g6vMYfrUJI7NdQCmIsaqpZ9VXbKN57gzmP2e8=
X-Received: by 2002:aa7:c742:0:b0:564:aaec:c3fd with SMTP id
 c2-20020aa7c742000000b00564aaecc3fdmr681967eds.33.1708362397767; Mon, 19 Feb
 2024 09:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20240219082938.238302-1-npiggin@gmail.com>
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 17:06:26 +0000
Message-ID: <CAFEAcA8q12k99HohX24rGCB0u=UgV5J_3_5aPw77yCsip9VfjQ@mail.gmail.com>
Subject: Re: [PULL 00/49] ppc-for-9.0 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 08:31, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The following changes since commit da96ad4a6a2ef26c83b15fa95e7fceef5147269c:
>
>   Merge tag 'hw-misc-20240215' of https://github.com/philmd/qemu into staging (2024-02-16 11:05:14 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-20240219
>
> for you to fetch changes up to 922e408e12315121d3e09304b8b8f462ea051af1:
>
>   target/ppc: optimise ppcemb_tlb_t flushing (2024-02-19 18:09:19 +1000)
>
> ----------------------------------------------------------------
> * Avocado tests for ppc64 to boot FreeBSD, run guests with emulated
>   or nested hypervisor facilities, among other things.
> * Update ppc64 CPU defaults to Power10.
> * Add a new powernv10-rainier machine to better capture differences
>   between the different Power10 systems.
> * Implement more device models for powernv.
> * 4xx TLB flushing performance and correctness improvements.
> * Correct gdb implementation to access some important SPRs.
> * Misc cleanups and bug fixes.
>
> I dropped the BHRB patches, they are very close but minor issue only
> noticed recently held them up. Hopefully we can get those and a bunch
> of other outstanding submissions in for 9.0 but this PR was taking too
> long as it was.

> Peter Maydell (1):
>       hw/pci-host/raven.c: Mark raven_io_ops as implementing unaligned accesses

Hi Nick -- this commit went upstream via a different route, and
so it now appears in this pullrequest as a commit with a commit
message but no contents. Could I ask you to respin the pullreq
with that commit dropped, please?

thanks
-- PMM

