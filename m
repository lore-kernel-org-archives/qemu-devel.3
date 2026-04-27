Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0C3FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHR9-0003ht-RC; Mon, 27 Apr 2026 04:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHHR5-0003gI-9g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:35:23 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHHR3-0005zt-Ck
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:35:23 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651b4d09141so13075595d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777278920; cv=none;
 d=google.com; s=arc-20240605;
 b=gV5MhJ/efgGcpka+vB35XebNGOyJziTol/ZDB6qVtCTNRIvNVC/JUU+mOGMcaSfR3Q
 M2M7714fAG4PKfZ+1HHz9Wwk77jcKP8UJ039ZxHqK93nbLNRQO+PrOO7ic3Z0qJQlu8o
 YTDSsODSlz3gUPnNaU6TnPzSGVzQPRbj7dz4KZAPsl8+yaOmy8JGyhf8BVLhC3Qi+gPu
 7OHrffRO8JcDEa3wYBnKHYH0cWnkuZ30jq95YNPJasx9t7Iz674mOhOzUhDfrNkPVvhl
 y0nid7SP8aD9fcrQ9Gie31QtsOBP8YgWDcX6y4dfqO9pboLoKmt2W64iqlnwWrNDLDFJ
 WAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h9QWKCTN4QOURPXWq3r3LDrWnHmZaiApTMG+jDk3gHM=;
 fh=Majlw+xdldRqm88GFl5XnMKn2ZXbD6SUIlMio57MfDQ=;
 b=GCjBlBm0YqpFixHo0z2Ei2/hKeANFru/dC0SaGYhmx/CvNV1c0PereuCrAGRtcUR+P
 4ca0vjzvavoy6Ll8vOC2JYntzJXXXlXFT+UaCL7sULpPbUg5D3/L/BGMGX9CMuUS1T8w
 hWv60OX8lSikyCfV8pjoQ/TSNfR8sgmWtOu60hkbtqqKJKn4/+BaYiAWLIZhEAj+5Fgo
 Jb5iZK5hZ9TsgHemzXeLjNjqFOPtnl5056aIYyYx/dsiHbBnAJvhShl6OwUOtKVztrrQ
 OiINlIULjV1JKIblZxmwHEbQfq8jfRVrVDaMpYk6SHp1xCK3FzQzkHkT26PpYiQ+lkZi
 B0OQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777278920; x=1777883720; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h9QWKCTN4QOURPXWq3r3LDrWnHmZaiApTMG+jDk3gHM=;
 b=bhwA25jqTemznEDi150gQn/jTkoSYLd3jdx5A7xV1kvwp2vL+KIY5joSIhQ1u1H4lW
 rniNZbqeQuDxrDXqxYOgrijTGcmP5Z0fWqoMGlLu3zRsaWhLq8hjKrvj/Tt8Th21PRyQ
 +ZpqYopf1EmCQWN+bSEdRf+enfgUv9OuVa5zzG5cQB3bsCyObwoAwKkhXsJAigm6K1+1
 oyJdXHBX1Zg9zaj/y1LpPRC5bWt90cZMC9FOscn6hcHHaUAutQUnfevQDIn+YV+R8c96
 aj4KnomQQlr7rHF0jAl/jooqPiTvjLYZG6o3lsWk4CQZVlA6XPHF8il7zGa4gc7NrZVz
 ABoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777278920; x=1777883720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9QWKCTN4QOURPXWq3r3LDrWnHmZaiApTMG+jDk3gHM=;
 b=OQO1MJRXLySBxtt0THCDkRglDqYdE+xcMTWE0WpAY+EDdM04fGaXiuyf9yrz+oXj6E
 JRytsiPm0airgut5q4goWNKJUTfMn0eBPteFm8xzn5OzsxGUlzre9bMDz8G9a34ZDDzk
 S7Jh1xjjAsadZAs7dY43C5wZ1HwQmzqvhHZnaGp0h4tYzkMWJtvBqxOq+rRtc4tHIILA
 EMLdqruIRSdijkbBD99m70fJ2Z0pwxqRTYXaAor4V9SaSfbhr8dyvcNf5nXicgKf8R27
 Jg0LKQRYp0FYSo+D8EdErzasMO9wGW5lnZ8WYGULVrVeEtbisf22zVJN2Vs9YNzYUczq
 6LIQ==
X-Gm-Message-State: AOJu0YzYuBMfp1ps01rFT6kZlf1Is9CEyv67IEwZjm4XgrnLjUYCisRT
 iyN0PRBM+/hL9if3630xr7ZyO7Xiw7aWCA+flQsIQbEVrPtqZvE0E5xa4cd22DFF22HeIcvgiyv
 rPR/ToKVb0GAVNaA5uf7s9ShQMLQgN0V4SIm/FrAnug==
X-Gm-Gg: AeBDieuCwoYLrudP2HoSp7Jl5RMTsmO8blNBO1nolk15hEL+utwiTnVsqEA3YViGbr1
 7BpdZRLwzlaWK2beROrwEjE5yKIKsyoHDPM5lEW5Jb/P6Yyk8MJ662Of/+A8rUcho5oPh5wN3hK
 /GsHBiKVxJTD1o8IztVdPxI//IcARqVJZ2I6aS+GcA5pdvR2EUwK6vS6gQQGE2Iq8BqatXVjpIz
 i3uEF8Os76iBXK6bhO7k069+PxtZRrJ2t8NrahvZt7lpCLPjPJAnKNsNQd7z5FmCjXaYN6mdkk/
 t4Mx6Uu5dAyDsQhyju0FAL83CZrXHeFv3da1cWTPSqf6zckBqNfG7Xv7zi2+yoZ8tASGbr05BAW
 BTw==
X-Received: by 2002:a05:690e:4183:b0:650:1cbb:50a8 with SMTP id
 956f58d0204a3-65311b2fdd8mr22002182d50.26.1777278919850; Mon, 27 Apr 2026
 01:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260421065226.3907745-1-gaurav.sharma_7@nxp.com>
In-Reply-To: <20260421065226.3907745-1-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 09:35:07 +0100
X-Gm-Features: AQROBzBv_52C9AAUorthejaPGXDFdZwzVH9VipnI-wxZlZifyuWLhXVo_hfcLdQ
Message-ID: <CAFEAcA84EkMEUj2fL5q3_eSNnce_voLbqyA3NU_avEsKHzqOWw@mail.gmail.com>
Subject: Re: [PATCHv7 00/15] Adding comprehensive support for i.MX8MM EVK board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 21 Apr 2026 at 07:52, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
> This patch series adds support for the NXP i.MX8MM EVK (Evaluation Kit)
> board to QEMU, enabling emulation of this ARM Cortex-A53 based development
> platform.

Thanks, I have applied this to target-arm.next.

> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

For the future, please don't put tags in the cover letter.
When the tools pick up a patchseries from the mailing list
they will apply any tags in the cover letter or followups to
the cover letter to every patch in the series. The idea is
that it lets a reviewer reply to the cover letter with a
blanket reviewed-by tag. But when you're sending a series
then you should put the tags in the patches they apply to,
so that people reading the emails on the mailing list can
see which patches are reviewed and which are not.

I think the underlying problem here is that for v4 Bernhard
gave his reviewed-by tag for the whole series, but instead
of marking up all the patches with that tag you put it in
the cover letter in v5 and up.

Bernhard: based on my understanding above I'm going to add
your R-by tag to all the patches in this series. If that's
not what you intended please let me know and I'll edit.

I've made the minor whitespace tweaks Thomas Huth suggested
for the final patch, and also wrapped some long lines in
the docs in patch 1, and fixed a minor rebase conflict.

thanks
-- PMM

