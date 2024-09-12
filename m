Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B745CEE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 12:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojDh-0006M4-Mv; Thu, 12 Sep 2024 08:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sojDe-0006I1-1g
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:46:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sojDc-00026a-8x
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:46:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c3400367so895370f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726145198; x=1726749998; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KoMRi3kCgu/r+16U7v98jk3LR1SD4e42KIxnPWtgzOA=;
 b=S1JBdGh77XAgF96dkhb9ezbHHo3W1qzhnmKOP1DellC1+uo5QSupafKzSVEJXRa66J
 EGd3MKMOiaQ6rId0cQwMPXA3hw1f63dydORX5DyMQKk8AkRljCvs87GVBlxDRng+HQYX
 qMZCZbmsRseqQrw1FoKUyim/2k/KGMYw32YDTsqyQdBv2MCf7ZIG3puxt2722uCoil+7
 fM2DVn9Qwu0l4cXL98skIWr+XmOmHdkJvbyMiSINe6SkkNMMesQDeSaC3OHCPc7B4zsJ
 MbA5idfV4gR0VLL1YlMSmwRlOYgyN/bibK6ZCk6kVCwblmfRnQMbckLzW9QbY3ey4SMP
 rP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726145198; x=1726749998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoMRi3kCgu/r+16U7v98jk3LR1SD4e42KIxnPWtgzOA=;
 b=p5m5kKFjxJEVTC5vmkQtFMXDC/fXHJysUgbxvvhW9X06cfvBmkcsrOWSX2+PVrGQ89
 bDYJzXBp7U8SrWgLL8YUwV8DabqL+w7dWVULBIegmgV3H+fyLDgEzsFEQ001qbx0qmcT
 VYoa5BVh/ENNf4SitCgG77X57kB6PRnzRaeXcPWD8ljffufnj/hnLxv00kK1JYJdGjT5
 AbreTN02uNsLw5Cjuw9TwCuBKwc16y/z6VdGDp5cG/wc358yTSPucSSJ1QooWWru7UX/
 tf5aytj0q0SlsluZ2h09fK22id+f26wtOhaC93bCqCn3pWh69jUJ4hSBh1rPJGscqQep
 BVCA==
X-Gm-Message-State: AOJu0YyUV3PrUjWP1+5wE45Bl1/Ep5S/NAkuBfBTx5KbDwGCvYtQ60fN
 w9YXo1FcTbdTxaJYhFnFgSvQVPzeHp8WqQ+msDLrg+VtSxBIBivMN/db05lqX3iMqfsMi+hA5iZ
 iIfyc6Dy8Ob2eVryL1ZxnpVJxLXux+/isZtG8L77DiAgc9hqF
X-Google-Smtp-Source: AGHT+IGRELXXOPshiUyZ6AEVL2qLRGNdJuUQYNl6PfTCPE47hxBGEpfxOuMs1YKFiYaMmgprafcYKQGFRUV7VDfiVmY=
X-Received: by 2002:a5d:62c9:0:b0:374:c11c:c5ca with SMTP id
 ffacd0b85a97d-378c2d4d209mr2006941f8f.46.1726145198290; Thu, 12 Sep 2024
 05:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
 <20240912024114.1097832-27-richard.henderson@linaro.org>
In-Reply-To: <20240912024114.1097832-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 13:46:20 +0100
Message-ID: <CAFEAcA8g3UbfjZRH0VMX0=owDawvdjp1gUnnK5GoNn7jYK4O8Q@mail.gmail.com>
Subject: Re: [PATCH v3 26/29] target/arm: Widen NeonGenNarrowEnvFn return to
 64 bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

On Thu, 12 Sept 2024 at 03:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While these functions really do return a 32-bit value,
> widening the return type means that we need do less
> marshalling between TCG types.
>
> Remove NeonGenNarrowEnvFn typedef; add NeonGenOne64OpEnvFn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

