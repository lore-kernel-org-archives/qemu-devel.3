Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOdb-0002jq-Kv; Wed, 08 Jul 2026 05:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whOcj-0002ZM-4B
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:31:24 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whOch-00038x-G4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:31:20 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66666bad8beso552709d50.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 02:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783503078; cv=none;
 d=google.com; s=arc-20260327;
 b=jkWiUTxB/VyUcVkpCG+2J5ef+J9aM08UdPiouiKzdhvGVajHcw11Qs8Pw+1CoBtdeZ
 M+3gPrSh/dQ7KNbnkcy8ulrU5mdnEfzIDkOwGQRYyaMnTDeWuQ3S81tp1wX4cJtraThM
 STkZ345e7ovandrFX3lJtgWmEdBEJtWKLenv6CalVyvQyGG1IxHWR3mTAwbdtcN9oiTo
 FXyryaXB/nWyxcPlidqMVIpsPDcHpXY9SkxDbTVdXZLs+1l8/IKpd3cN1ALZ3JSZCk9a
 O7LEiMO7/dOaPVPvXde0lbBCFGds20HXliwd0CH16go+Y0ONWBwd9sl9zhejOfsA2Gw7
 BNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EX4ZaBtThJEvn6+hTN+UCvMpKGavs3Nhi1CFUMs/Qvs=;
 fh=i04XnI0vYWg+95BzMBDt0DrubMgrVlqYGMMrEIhTCSs=;
 b=N6vnltV7mYIN0IJOZT6cwCQ55Ws7lFh2muTYEOt9/4KPVYnT+AnyBOmrE8EYZIuGmX
 NXdNZURMcpbD+B7JCFE2+Tq6apOd9pG26k4Dz1A6ZjKM+GF3IddIJz7ieZrLWQ+xPe9K
 pmnr1llmf4AN812JNzw9+d9cZnzt/JzZe2vz5g1jGYwXR1JjhW6D+9QN9d5q6WBxKzZn
 yhWdlK8/qO3NcLXGeyTBNQlPopsjZLZbzfqqR1ltFonSTr02lG2ZqU9NNhU1I367SoNU
 DZi1o0bm/bhfaPD9uFwbJlor9f7KTocT6blmzebzbNvBsqBvuNrSO1x/KtHlJ22GQWcJ
 8XJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783503078; x=1784107878; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EX4ZaBtThJEvn6+hTN+UCvMpKGavs3Nhi1CFUMs/Qvs=;
 b=VfKjmzYzD+IuHj2gz/feIySAJcbpO4w8hnqfnIELtMKtX9pPSRXPnsfj2utWJ5rxCn
 33ztoJPeqURm/BTJRq6pyDljFDrHFRyomSfSScelcD9B8x5SgLK1QiUyBDsdPCgfrN4A
 kTfNDecQC0bWGuXTyiwOW5dVY6xKVHfNDPOUTxR2snWSqrE6WgGcXPEvwqn9fDNHgkEy
 DrZ2MzQ1PTutw+yrVifezQzaSPyZxProD5AaPcfP1yqqw8U6zcvoKf/DDcN3RKfWu+d1
 MwVbKumL2poqMLMe7CSgsPDvh76qJPO7IWWOys/hATzNC5GLuAWIOrqUjSFOt8IYfKiO
 CEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783503078; x=1784107878;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EX4ZaBtThJEvn6+hTN+UCvMpKGavs3Nhi1CFUMs/Qvs=;
 b=REMDD10XYdQjBomDsS7Wfwy736BsbKLd3t++HeqYK4VkCsZaV39w53Cg4Bd3/5Lwo1
 kp3A60ffcVkogQyTzANPjQyZW5WX6PxRwFtbJO1XpX5VFPZrcP4oWHzS8G9HwDgRSRq7
 uBXVlHtSke0Duw1GsM47o5fR3T0ww55D2iMv5FIM7zcFvsoStezRiewVBWlP6TwpveXM
 bJRGwSpCfyQsk/VELtfszRj27y+cN/fCQt89xD+5Z3g57disCDSovi+eZ9v2RVG7xAsC
 IP1/rHEPN3/JdGe0+G70y7BYiGPdoAGfwJRIbCZaKMxaa8W1wikctf/v6me8aji44CCw
 JWmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJYT6KUdW+zuZrIuAYCrDlWIsvZeZgJEa/ZHu/saoJuF9tSwFF7iRtOqkHMYlKGxt0tcX9E7VCZbuJ@nongnu.org
X-Gm-Message-State: AOJu0YzcxuqDfmpEhavstQQEfDPso0MD1A7eFJZBoafHozAg2Z9JWIuZ
 1zLzqxRJcO9mX3o4jVpst/s2jUOgWB40ShbezZ4sQm09IYYa+5r4yW0fFneztlEh2qp4GpAnZzx
 F8QM6Vpv5b2Wj0w6RRIM926BLk1bk/Xi43vTIboFmng==
X-Gm-Gg: AfdE7ckZv7XVnrFljoxVo0o1d0/bvdfhHNpIKu57MbRg978iTV+If0g9+jt3n0cS3gr
 Wo1uc2pBDC+y0giCXfYvaJBDEguRtv3NIJx0D1120kfuw1Itz7vOOjt0CwE9EzwSHy+RR4kptVi
 PKLsA1WzEZmrRaVbeIkbp7rZ49pVxN3oeg701YxEsdLdBOFxTCWTGOZuZPyj3s0A4a1/osINc0G
 /zSjLidBhIRhuRuOQN3DjtPrui+brumrBSWIMhu9JPfJe/KQZdmHgDfBFydoFqyaP+lCVUiTo3r
 b+50jJe6+QFitICXpO7he9Dz+jcx+3CUCNQ0BplaDUamOCrPfqJL5yar
X-Received: by 2002:a05:690e:419c:b0:664:85c8:f14d with SMTP id
 956f58d0204a3-6679f00e56dmr1125222d50.14.1783503078021; Wed, 08 Jul 2026
 02:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
In-Reply-To: <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2026 10:31:06 +0100
X-Gm-Features: AVVi8CexY1mKLXsWQsBsTgJpCsEZNagGTNEMRorW1Q3F8zPTODj9WYFoHZawm9o
Message-ID: <CAFEAcA9x7tjW9xuT_XwNntdvoVtLrCL_PB+50tfhiW2XDvsCiw@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 7 Jul 2026 at 18:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/6/26 02:21, Peter Maydell wrote:
> > No other architecture, CPU or board in QEMU needs to do this,
> > so my instinct is to say that M-profile should not be special here.
> > Richard, Alex: how do we usually handle breakpoint insns for the
> > gdbstub ?
>
> We handle them via CPUBreakpoint structures; we never inject code changes.

I don't mean "breakpoints that the gdbstub requests", I mean
"breakpoint insns that are already in the guest code that get
executed".

> The patch description explains the confusion: this is attempting to replicate a feature of
> the Raspberry Pi Pico SDK, wherein a guest BPKT really is trapped by an external debugger.

But aren't breakpoint instructions of all kinds typically trapped
to the external jtag debugger, on any architecture ? I'm a bit
surprised that we don't do this already.

thanks
-- PMM

