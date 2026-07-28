Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCBEC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojqT-0000xm-LY; Tue, 28 Jul 2026 11:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojpz-0000am-IN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:35:27 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojpx-0002DR-WC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:35:23 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so398231466b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252920; cv=none;
 d=google.com; s=arc-20260327;
 b=bFETnQWWmARugLWIxb5o6AHy2lrhYeYNvi/0tZUvynF9NRP/z51uDhveJGcrWETIU7
 NAPyC1tDIpQxcPW9Y6GsFcASfJ0I3oEBhaEVr7fHtNWaEOVZjr7Y9Mnqoxzl64I5V/Bl
 x2dyd2jReuBp+ajYd9XkPpBjURaLBIV1qTk565ptq2zhTzqxKK2T/7Pg/fHoGs1bcHCl
 JKu5rYhhhKWrqzEfEoRKWe5muZq5duCdXQiGkPElBaS8dduQjMj6l3o92od6ztEKBMG2
 2BGHWiLbnhDqzrSZadga5fDvzGG9kIWn7Ydcgk1qc+rJryJqZDodM3WTzgv3MSFbtlmJ
 w3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wmDaRjjFYiXRbYC5+ygckLhGTWH98b6KM6Tx22x/QdQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=SEW9O3pSNa9Z2aSR/0Q/0VKJ1gCXxNOB0pKnHfn4ZqmvNWr5xQ/uF+Miid0bHnF6Sp
 BO7U9Vbu1nrC68JW9QXatzTda/rh/3jKEjPVQnRewUrcxGxHgpO1h3gAXvuUdqkvHfO4
 m/tKHbW9yXOUtg1MyL02ePHd9ZryNbYAS3PcUg4GqufsZUw14+Yf/faOHw8ZSJ/4OFiA
 lmm5hbJMT62khxBfhwEyRptHisgwIVvriFxeIYDLefVvTQoTuB7zVuvlpAUlwOkzGdux
 ZOdBGfGHOqBPHUt9JIFtoJEdaD5kySD8z/BeBrzW+eCMQsbbVG00BzyrDFEEzJmmprOF
 oplw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252920; x=1785857720; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wmDaRjjFYiXRbYC5+ygckLhGTWH98b6KM6Tx22x/QdQ=;
 b=R2QRlWKnnOTDcGEQm8QGI1GGDCm/9OKKH/eJYqHpwIZd1Iw6Q/IcE+T/o03SJXqQX9
 N2DGdf9//SCiiAhpYBTwlZ/LSM6cdRemWWUEQNSx+LHFzN9DjswbbuyKeHod0aUkH5uW
 koonaLbmUPHe8O5j+/+KP5lyJWhVOV/tfc7F5zYhotdk2tuNKVMIeEjxPsn3usnBdRLG
 MgaokDYSewDKFMZTJeu8NsXh5qhAAybbAJH8HO6ns7SIUn73nhnZ14wyezRj4Nf1ElJn
 VuObpE1RMlRtrY1GIC+Ts+dlqI2fm7X3MA7ahObKbvXYNHtWkdwGEeSdkjtkbRgpwSDw
 K8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252920; x=1785857720;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wmDaRjjFYiXRbYC5+ygckLhGTWH98b6KM6Tx22x/QdQ=;
 b=gggJVZo+VhG0Cx51mqypLMKBLzFPWdn5a3/FTeUvceFYTSo/BFFOWsJc8rp46c3Rk3
 2w6rIDB88ouQB8+KbSUXjt3vOL+S8Zqqe1ycDdYN8DNTqhZLMr3fWNB0Smg9Dg7Yk3rg
 DhtkHrYLMVtbxdbH1uNMs1KoEQoht3ohqA2YLKmCWPTHQyHw8Zwp98JZRbNNlNQ1nVUa
 HPMBbXDMzWQeAPfzd8YyiN2qYwr+NaM0msnaaDSQvKgDff4KhFnCvBYYZDx4P+t4nuH3
 UYD75IRRLJWo5Hb3vkvhnYJCR+sd0aWPe6q36mKyi3uCBKjWLJ9MEUfOIVcF2TKcuNnb
 3Uqg==
X-Gm-Message-State: AOJu0YywpCswL0O2qTn7oJ8C9K4bO0q3R7lA2B4JUf9wol3pA6AoZ15B
 EaN7zxgKu+ZjG6UcVY83ezWZ6tiW9AOX9g6vN78YG4BVJ3nfPMo4qPtjrT1aON5kgoQdfww6Lvk
 pweGlz8x/sL1bIUfn+vBztBclbVlwr/tUl8Dh4jDNI/tASBzxVimz
X-Gm-Gg: AR+sD117I306OeZJlIBk1UXxlYHect/0UM5+Yw5Lpgs90z6qho+6jqMs63Ib49wxYsb
 7mJvxaRBalCrRmjqydXArzfB/X5IjlKaCI5D0XQiHIGAapgwzBgKRpTj9MCVbra16ThDoEY+mh5
 KRJX6TV/RGLyKD76ofPaVCaKF334M54fHyxAKsx5PW9YISYLT9NtwGcVNylNu5bEbteiv85iosW
 xrOD3JemevUaggR+5H3eoTaCWGKSt2f8g2B+wYBNxZxxwu7/LVlCt6N/qyvRYcVPcdaQM6siz7q
 vRk6CfNI1lYcX7nxaH1b54C8bjZmspbCejOcu8rSLR5mHw==
X-Received: by 2002:a17:907:d1a:b0:c1f:32e4:737a with SMTP id
 a640c23a62f3a-c1f727c12b6mr149757266b.61.1785252920099; Tue, 28 Jul 2026
 08:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-13-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:35:07 +0100
X-Gm-Features: AUfX_mw3fFhXFODduhtS0TnuAOIPDjRvsytMtoskzaUdjCWnp90-Z8cmTbfFkMQ
Message-ID: <CAFEAcA_cVofohosCefxKtVQNzGN_NmL1G4c+dF5kRJ7A65Qd3A@mail.gmail.com>
Subject: Re: [PATCH 12/20] target/arm: Rename isar_feature_aa64_sve_sha3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from isar_feature_aa64_sve2_sha3 to match
> the feature name: FEAT_SVE_SHA3.
>
> Reorg trans_RAX1 to use TRANS_FEAT_STREAMING_IF.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

