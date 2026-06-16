Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072A1CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSgv-0002xq-Mr; Tue, 16 Jun 2026 08:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSgs-0002xN-6f
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:14:51 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSgq-0007aK-NH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:14:49 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6611669cd16so4631608d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612087; cv=none;
 d=google.com; s=arc-20240605;
 b=S2R6ChN3g6v6FBQnS9K3DxcQj3rqgGOoPqCpKsZT66k/sZlbwvYRrxvk0mSF2tkq2N
 1zvYz/srBTYZl/BvHsAk7LgF0s1SGZ53fbb2z7egTo7cSBCLtjwOtAzGZdByMyhR58P5
 A+hr78b9BrSW8GbNgW2GqHGXQtx+r7Qk7kdX4fqnWSk/PCZyQOv8tX8TeVus3T+ucZlu
 z8ePFzrdJXfD2Z3XDCW0Vfi0waLzRcVRgK/WbIU6QSrfCKJaHNZ9RcY9HXf+w6A+gM5v
 pJf1KZ087P0GZgx8S31gG6zlw9vFC19D7ZUzZxXhreMcFDBTAWITZsR6/3Nt3t0JMFYW
 z0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cXEBmNZ72Gr0cGRXJ3F0v2vBeO9CtcBaEsgSWNI416M=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=SU1YcQJtgOjOz67L3VuJagTsGo0XmFd7I81+z0KcjRIlHDJNpKFlqDN1p5rL3Jxp0T
 T+Au990+xwCm6tqUdK+G2oLCs709KezVEI4xZNz6Y1oxW9R1hpfIgc59LeNySHk66TdX
 z+xAPhju+gWKuprriCplt0IUJRsN8Zlje7eJr6Y4LPW4HkrWOn+gSq+DgjnchrfIlZ2A
 MSo2fuNKXrOxv7Hzmhh6Uy+m7EhLLcTt85pWgK8HatyZ8NvYmCirkcfcP+oZi/qY77S+
 vm2fwXsymjrfYvBfO8lOA8snp0x3ZUNvVdLCCboLselsoGYw9HClTOd6Ovmh60Ailecn
 VkvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612087; x=1782216887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cXEBmNZ72Gr0cGRXJ3F0v2vBeO9CtcBaEsgSWNI416M=;
 b=DFIj+5FU8XsJdnE0H6OfnTuURY52jfa9ekl1SF5np+qm/ih7Mj6SY9ZXCba4jtxXxK
 gX4lzxnglgniJTXagMBKKpHYW52CYVQyC5yiOiNF80fADYe0RrnuRxz57/PrqE5VkA3I
 KXj1j4VU8qFy/v8q/hYWeeE6MCQH7ImQTvbsBo3amg9x50WfkcrhwU3QYxU3Wvxw70ig
 KBGE/C8ZOERa4efdBkC9fZs60gzBeDj9FvFVNEvLeaeJwAkrtdee1evgTpLpHOARLUj8
 3vpVLEhHqmgv7+TnxHAVjLD5GiEu2vuu3jReIVtf6SbGvWliH6iJjq9WpIvj5dUdqqr1
 HtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612087; x=1782216887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXEBmNZ72Gr0cGRXJ3F0v2vBeO9CtcBaEsgSWNI416M=;
 b=QfPFSy3jJc83Ms81WlBR3Di1ApBytwoSgOrVGHIBwzRQ4n1k0YdFpn9R/ndttX5BIw
 LV7MIOozieFKrFyT7qiQwWudVLgFhSKkQLYkCxvhmpug8rpxH1S1ZMesg5xANtThJDpq
 chlyIh5hy8Af1DKbNgAt4fV4+MlKmUnJ3gwmNjCo1jHqEnqMz2W5VUTfpYLWWlWo8Kn2
 CTf/7BL6oL94qQHUKl9vSbNMfAbWTfwA9Y4Lduy6htNAh2s1VqMq55hgMXb3V5uwb6X7
 tP8Rb2ldhCfRekVTt+VjOL2kqEM5osgm135y4wVuxtH3UhAu9vlakgbm89Hf/Z/nbH7k
 Xrkw==
X-Gm-Message-State: AOJu0YyhNG3hRFQH6l1DwhmIsSXaRHpXIuUJ5niyT5X7vL4VHJa712vi
 da8j9eOoJeW82GxwmYQvyega4yJASiWrxFYSmY+oCZPSTSTWREqlHR6Anr6v4SI2XP/Jc7+Fs/4
 3q94khZyxwIK0TV2ODYGTi50C8cE1hpdLWgmE7a3G1w==
X-Gm-Gg: AfdE7cm9iaKYmZt+BivgSNX1oQ8NzyRPkA4bRFB8r3xTvhLYdQ2X0+9+X9x/NWfA68E
 RWpECQyg0sU01+UZ8gNy2cbYeaboyOBpJ60NFlQE0SRo8s+ruNAKCIpUyhQw7FyYV6w5AasspIO
 g0BtDzmRuXK4GAEVITbDEbw0rSCwXouNf7Iz2yzB9EWQGeHiOA22uIPAHX5rgr+5OALNgH47PPV
 L0TsToSm/XdNmwWHd6C9BycTl2YunZ0vPMTbJgWbVfS4TqHGWBlRDO8yklIUduX499o/U2r3Be6
 YEMqjwnyi4rRpqOKGqtmS5bH8LVJlxGnV8Ts21G7NRH5JYUzvZhWz+xTy+Im5VbnIig=
X-Received: by 2002:a05:690e:bc8:b0:658:e2a2:dbe0 with SMTP id
 956f58d0204a3-662b606d842mr2548773d50.5.1781612087526; Tue, 16 Jun 2026
 05:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-3-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:14:36 +0100
X-Gm-Features: AVVi8Cd_XrpmYvyVN11Wx-Hni03nHS6HgS-8rmJez9SHz8EtCSqYwRevS1mckME
Message-ID: <CAFEAcA8hPoeHtjyMkHSHLH=2eoQwn7idSOKD7qb95FtGQQzQ8g@mail.gmail.com>
Subject: Re: [PATCH 02/25] target/arm: Rename sve unary predicated patterns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add an "_m" suffix to indicate merging, in preparation for
> adding new predicated zeroing instructions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

