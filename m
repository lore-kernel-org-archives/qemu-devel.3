Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19C2C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nGa-0004sF-Mb; Wed, 16 Sep 2026 06:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6nFP-000449-31
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:52:22 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6nFM-0003oC-5s
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:52:14 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-67109935888so652596d50.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 03:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789555929; cv=none;
 d=google.com; s=arc-20260327;
 b=AKldaHwE9QeniGN36t6uElayQkpZqt2bd/Sk3IeKbDD4KfcayUVXB1UvBMF+ap7UlJ
 2b9QhPsFBvyvFcHsJyii0FB4Sju/abFP93245BnSOT9hgOH2EF/Tg7kWAGdqzwmXDaP6
 6+0tfhBx2ndreCJabOfFNb+x8hfVqlV1KqcQ65Ihw1GxNXiClPlp6DSrMfqt151bWthp
 ahljX5PzL0UNSvg1bDnefgbQ6PgbmRC1BzlwLKZH3iuOq3G1WlsEetFKbieNeLlLJqHe
 qTlRbXlETb1uWx9Z0HSB5JyYeZCDjQzeNLjHdLHH9QNsgLxU2dP9RGO7NoKLUVmFLJkP
 26AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ac5cJOlzb0yNjC/xOK/XtHtFbJ8zu2izgxBr5Yw3TZI=;
 fh=EQRlMMMaBW8zxI2rwUI6QZvbR3nqOcEaFehDENRIQPg=;
 b=OynauQkZpY4lJ6EbUnu+DZKiop46f8Poq62RRt7ZcbvJyQ1zLTHJGJs8cEFmihnytR
 RgvmOQMHO5lVf47Kimm1kMyM8nKDytreQIODJyNYXBPKjkOOYbiwCmsuHU6NvFNCVtNQ
 tQvTTNFBD2ke+q0fDRPtQUTzogGgIZNTPbntpHWiqzurg6UTwAXVXawuTJ2naXlNOxnq
 UvlI+sPCviLcjg+Js/OKOPXAkb0EyyUBmWQqPnFzTcrcUnZF7OM8hL2XIfLaEXf/CT8h
 P0SvkAf/I7nZDCg7oj5VPDpnChvYGi5R35Yq7WYpOKoGQF8QlH7nWSb2vstx08c9XNvk
 ohFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789555929; x=1790160729; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ac5cJOlzb0yNjC/xOK/XtHtFbJ8zu2izgxBr5Yw3TZI=;
 b=xXSf2/l2jkGUEicNG257A7r1BiZDshlHlo7dXTuXqZf1rkfmFziUD0u3nJzuu2yOx5
 Ux7iOi7EyLshDUYenq3FzpmL3wJmIgGfQSdEzoNL6U49E0S9xWHYG10amBCS6xhcy8o8
 Y/OWRFkNqby2pHzRHr4YheFd/nMdGe4w/iHZNeM805Z5Mdr+C7revBWVvRqgjWyDfPje
 9c0LrMvusjC1kKkS8tupr2Nj/219hlm17c4wqu4/wjrseATfBUmdEDUpbXD6fwu5AZKe
 hVR1IYiQh1YiqOSlVgSjkEGPJqBHLvoXR+8Xqs5qrosFHGZhrrn6TEjaos/rI7KDNeIw
 sjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789555929; x=1790160729;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ac5cJOlzb0yNjC/xOK/XtHtFbJ8zu2izgxBr5Yw3TZI=;
 b=J5+l0ds74NRhPuGsXolGLf80aBj4DtmA0/ffjAz+OrF3qQM3YhmgFy37eUjC/nJCNN
 9N2D5hCNwcQabuF5tMUNjDrruUkvxe36EPBpLQHYhpBv2UukZB5OOAPgiuMrLOTsCEbm
 diTcHtD471b1OW0SNZiuhNpJb9pPY97BHF+t0+xw4Kwz+OH9+l9hlEpQNr5AbWz3ZuWb
 4L5P0CTGlFwfsedHIBpSKUJfxYRjDoCeZoXISeKaJeVe55j57NnUMFZEG3Wm0RwzXzLb
 2KtWIPt7sJTmMYCFRwaf6fNlez45icK0ed/f19ly1wlTFeLdTRjiMfsQxQ/RASsNnqGm
 yH1w==
X-Gm-Message-State: AFuF++nnblen5rYzxsLkfy3ntqib4x0rDYtAYsiWd+5142znbmMQ6EDn
 pjKaB91F8re47rtVXLi7xNbYSRhV0OI7rW56IYOnabbk04f3ZMOW31Q5iLB9cb1lG5KmZMA8AfV
 8wn0EdlegMofCahTCamyaLpIbGRC0WJCJqKE8u0RBGQ==
X-Gm-Gg: AYBFou0REAYQD9jHgP974WCUJZeQUwCW9ngNqeA49+9XDx6GJVYgQCyvFHHWuoTiwzf
 XtYYM8iOsU+IpBJzLMtEO3XcJ7nX+jJ2UikzpGPSYnQQRK0JaLn5nw12aDzLN1o4Djj0MdWaxi8
 u/ZH9pNcZ/NHbOQtQ4in7Ef42jVaBKaESGPF/KvyY6KBVJXxMU0QBIU2mK/4+RflLeJsbAPBTw2
 4gT15BSC1OfXjKakHVzQGFPXJFf1ABn7mZR7BBxsaZEDMt5bGZ/MvbrHmd5K2yjBwqSpIEMy9NH
 vmVtX+wZgknVa4iRSivSDbcYxrKkDTqAOi3ZiOij5SBZiLchinIOpsBQMr3vN49KcSUTBJKvyVT
 BMTNIXD2Nfzzg5U/lCa6PrnYgEoFG+8i+WSAJWREH
X-Received: by 2002:a05:690e:c4e:b0:66e:56e1:fcc0 with SMTP id
 956f58d0204a3-67163220807mr1118080d50.24.1789555929574; Wed, 16 Sep 2026
 03:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-10-mohamed@unpredictable.fr>
In-Reply-To: <20260916100021.73825-10-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2026 11:51:58 +0100
X-Gm-Features: AcwNN1VM0oRyQF72K-rzuDp-rYS2wbAzNfeY8Ke6RRoEp4khHQXe6WQGR0qOVoY
Message-ID: <CAFEAcA9eKwvOr+jQ2NLSx1mnp4aZ9pbv3RKs74La17juHK_=LQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/10] vmapple, gicv2m: add macOS compat quirk
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 16 Sept 2026 at 11:00, Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
> macOS expects bit 31 of MSI_TYPER to be set.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---

This is a macos bug -- the Arm Base System Architecture
spec which defines what the GICv2M registers are is clear
that MSI_TYPER bits [31:26] are RES0. I'm not keen on working
around guest bugs here, especially of the "random proprietary
guest has mysterious undocumented requirement" kind: insisting
on bit 31 being set would presumably break on a real hardware
GICv2M as well.

If there's some documented "Apple GICv2m" variant of this
hardware, then we could potentially model it, but I'd
rather do that as a "here's the spec we're modelling,
implement it" than a one-off point hack.

-- PMM

