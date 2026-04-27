Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7232EFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIvV-0006KD-6t; Mon, 27 Apr 2026 06:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIvN-0006Jf-Cv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:10:46 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIvK-0004Ac-PI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:10:45 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6501725d888so8003161d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 03:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284641; cv=none;
 d=google.com; s=arc-20240605;
 b=SO1i2479xIOlZYu36UGz4x6ZX6uD/fHMz1OZZkm/NSL9dhgYZnPmeFKwPPyMzEJiV/
 3+rGZjC+Qm7D0LO8JUCXvnf31gWB6SH/g6aIBAGKNsVTnTySE9GCjL3dHI8tzj4joprm
 TAicfkxXdHK1ISk/T079hhdphwY/UeB9xUAvNLuT2ikK1p0X4BqFCvLOZGMzXNHEsvyO
 ihoOHfyGBFNzvonH5mxF0Du2mweLLHOsVaAhhWE1Zlffg4igOnWQUMlhqB91+0VjHNRI
 GtlDvhcmKIIQxNsh50HuCBZG1gFQogpvq+LlQdh7ZuhjAjHrDLQT4b00GqtgddmUzU4T
 gm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h+aMrKzg5iRPFOP39nzcxuRJir3KbM+Vvk75eAq8OzI=;
 fh=ukEXsNcMmgvP7vIRWVpwV/bHje32cgqtZkJrBhNlMEg=;
 b=eTAhg1uioMvXXcQCBUFMs+U5x+tkYX4adLfmobtypaVYhLAIpITbP4AmfW/JliQpRy
 GRapIUSyItLoebaN+dvz/fNh5jDN0JR9/vTAL8s+jIm7Bwti9mWkhkOzMXZxD/cSzD3Z
 jUS8ZUTDqVijOXKOT9NF35k3Spuh2K0EtpVeckPEdkOKeZNVrtElMcbQCfkHL2vOyMI0
 fHmLnRe6Hj1jR/jYCjCwDS6V7Na0w7MhCnfoJ+l0Wp5LaIHkAwKh+9dzPCbkq1AaeUcN
 bhYnDOOfr1dlZ3942R4nK2e9HYKtIQ5T4a0PxCywr/mBtm4GjrIVWQMvDgFM2rAgDzFw
 A9fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777284641; x=1777889441; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h+aMrKzg5iRPFOP39nzcxuRJir3KbM+Vvk75eAq8OzI=;
 b=rfGPhx7ksbK68BwXy7ydrRvl997asoQmog5NUwy5RDK3F2fd4KWagjqqI0vcXjNYyQ
 FTbPiT3Umtnf+sbb7BNEeaNQzecK7YaOJmJGDI1CoPgiXqkmBnBHWby2HdY38kyfjc7O
 tJEHSh0XGRnUbHykGl6l4zqBBU1t3DZOf/4I/tj2h8uB6UouJcN0IrOQhk3jLZFo6UTm
 +pRjTfQEtzJzu8aY982njaxCca27TVT6t6RhjWr+cb4IEwk3c46Wka8/x/sDw8j0ymJ0
 7rC55qyNAAqs5mZ7TpP/zBowEkf8hKutxsb/q4iRGa4OMDUoFy8I2VD/W8iM3Rzbjt7F
 gmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284641; x=1777889441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+aMrKzg5iRPFOP39nzcxuRJir3KbM+Vvk75eAq8OzI=;
 b=FiEZ9+ELGsXzMNlwg6qcf+04ErkmQ1/aPC70xc24DXU4rvoMHpetKL+NX9eTDGP/zG
 NXuXwKfrT9uwcuzX70DU3p2Vbnx4rq89fykIQ8cr/s7hssrzqTcF+iCKV+R4dfRMMw2g
 1QxgAMzpE8b/QGlmOo4yFMXwfG8xn662qeX6svHrpYfT/OkX7qAwQ4b3kUKZEIjyohsC
 jWo6JpfLslepapHnYjEX4SrHUq4PcSHjwKzu3zj9v1BwHX2wZ3QD6f94jo8lMz6nEzJE
 Ajng/yJId2IVafEtv0hRPlXmlPmR2x8JUVa1oTvT50jHpkwxQMLM99TG9WATUo54rHo4
 fn4A==
X-Gm-Message-State: AOJu0Yxq+VUOeDRxGYB3rc8OXwD9XZqGx/XqWYvmI9lTlRcjj2QdFMnZ
 AojnEU0QCRvbRmA+NzVVZlr+GeI6JD7fYboUbtlaCrNvnFfTIU12FgRG3hlec1BirM0flKZB7+E
 IFi6myrG2eTV1Y7zJ2Qj+dMAenl7rpUy7crZg7ZtCQg==
X-Gm-Gg: AeBDievn1abaSPpijr3Lq8dPbiYPN05J/2m/DujKVTLNDU6ShvHzsfzzkyE5P7Gv9iN
 aFYkMU1OcuI6BODdbp/OvLe5h7dd/AA+sZsQ009U+avc4FkpSmvWQHTjIp0SdFTLq21NDqIJSYO
 84H6EbSf6XYdRKs75gfy3ELCqGOSwsquSo/UiM3g/6AT99C3PT5b66N16W02IEaoKvSr7iM/jb2
 J55bWUYnP4slMhl2emfa5fbhEVXZCSCfOARZsmnGyBITzVpWZLLRTn3iOCSBV1ilRnkYLBV2G0W
 CP1mJn5Q7g9wzG918QEKuH/o8RNU4otSgxCzwTltMF8Hq2TPY9iIhAWNh+/wOn2eCwdVowk/B3E
 vLQ==
X-Received: by 2002:a05:690e:124a:b0:650:3064:4cf2 with SMTP id
 956f58d0204a3-653107edd2fmr38869649d50.5.1777284640958; Mon, 27 Apr 2026
 03:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
In-Reply-To: <20260409220614.65558-1-lucaaamaral@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 11:10:29 +0100
X-Gm-Features: AQROBzAWX_aSS4_al0qqAOlI6OkPMuzx8z2mWLn_PkvrE7S1lPeleeKvQ713hc4
Message-ID: <CAFEAcA-8BeBte6CxH_5Zsk3wvs0zJJW6+=8cNaroRTBegK-M5A@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/arm: ISV=0 data abort emulation library
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 mohamed@unpredictable.fr, alex.bennee@linaro.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Apr 2026 at 23:06, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>
> Add a shared emulation library for AArch64 load/store instructions that
> cause ISV=0 data aborts under hardware virtualization, and wire it into
> HVF (macOS) and WHPX (Windows).
>
> When the Instruction Syndrome Valid bit is clear, the hypervisor cannot
> determine the faulting instruction's target register or access size from
> the syndrome alone.  This previously hit an assert(isv) and killed the
> VM.  The library fetches and decodes the faulting instruction using a
> decodetree-generated decoder, then emulates it directly against the vCPU
> register file and memory.

>  target/arm/emulate/a64-ldst.decode | 293 +++++++++++
>  target/arm/emulate/arm_emulate.c   | 805 +++++++++++++++++++++++++++++

Hi; looking at this I share Mohamed's question about how much
of the atomics/etc we really need. This is a thousand lines of
code handling instructions that in a lot of cases the guest really
ought not to be using on MMIO regions in the first place.

If we have real examples of this being needed, that's one thing,
but I'm not very enthusiastic about implementing "doesn't actually
have the atomic properties" instructions otherwise. Presumably
the guest was using an atomic insn for a reason, so it's either
buggy or else it actually needs the atomic handling and we won't
be providing it.

thanks
-- PMM

