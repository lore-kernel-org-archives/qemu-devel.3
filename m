Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3402CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbIXy-0006KZ-E4; Sun, 21 Jun 2026 09:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbIXw-0006KH-Ln
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 09:49:12 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbIXv-0003un-8X
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 09:49:12 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-662dc387b7aso3970848d50.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 06:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782049750; cv=none;
 d=google.com; s=arc-20240605;
 b=MqbvURlY3nu1MJr9AT4FvjsZbYTL5YtIb9rNqVz/rpF2ERsHAjyfrjfMYgnbluLgUQ
 LS29zp9VMVIYTRG7b+y/ZMFfMsgm0Yqs1pRgzkpPrOi9tyITG35fCNw3f35T4SXASZr9
 f5iX2wdEPAWVVdud3HVGCPHvf0/4mxV0w1WuW/cqtz96XY2nAr0PJaWEA7OJ3ZVNVEOR
 OKHqszoONTcJxdjcO2sdH8z5rjvz3CJecbyUqyeECjn0fvZNeLMYWslon+Id5orDxbUZ
 FssPW4XgVpBhtTV9ejWd1MR2X1cjsoiDJcnnnGPIdkktWUVmKjJDE1cAx1pP6uCYAaZm
 BUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/jQarkWKu6AgSWJrVhOLVRSLvpVVrUGu9tmXqpmNEOY=;
 fh=9wXrzXW3P0TbTEosQ5gz1LK5aFWrupVx1LwDDiuTPw0=;
 b=TmizQZPs4c+vqhOkNVaRocIPr5wlLsJ8Amm+whKtJ6zpRwf04ywdQWoxa/yPPfnoDc
 wnQVfbdcyOPHqh5DFc1MjHkp7QhxdbifqClcV1uMiyStKQXuS5Pkvmxv986BQfKwX9i+
 YKClhaijhIpgH/hhw1eb+SXFoLOESlvZro1iXfXJ1wbAvuVr9Wzq0MJGEJI9IDHT/Uaw
 JnzRqTq5+RGRMV/jyVq2wIJMp+0ukOfmKOJ3sMeMAwZQapiRqGqbbq1x+x1fKzBsWrOE
 5VCtYAITBrw3Mx9t/aabDYrEctOlfOcHTqIPzgIPnOhCzK7JVxPcuJrJP/WuHgcOiHkm
 o3xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782049750; x=1782654550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/jQarkWKu6AgSWJrVhOLVRSLvpVVrUGu9tmXqpmNEOY=;
 b=GAhDgLktYUAXE/Jdc9EvJ7b/rzcm2RzJwAQJV2/OQDhOXa10IxxvfqxsAIjjK19qoZ
 koOYUlZIKAoGOT0YKKEEPKKmNs5QEqtBCamoGzxPpVNUOhK+MFEHmhagc3/H1T+BWhCa
 gqgF0LpFXQYX6gzqi6JHxNlALEijlSEapAAgJfPC9Pu5WG1hvCtfxP8N4pPWHmR+FjQP
 xpBCamY8JspB7gkxwChfQ6HxsGNt0sv7aNvkaSBIuRk19UTVid6NCwbALsg4oBZC3Ee5
 l863Qe3EJ3YrVKjjxbrwEpWUYrKzlimWjQU1BnDMwbTyWRvYJB34ukULfo7E7ARkUShL
 fdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782049750; x=1782654550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jQarkWKu6AgSWJrVhOLVRSLvpVVrUGu9tmXqpmNEOY=;
 b=EjybKIfOa4LfNruInF4AldPZNwnJIgrViGvoA8Tzk2zPl6DcX3k0lFyqRhZ3+uyUzR
 17KyPjBzLkZMj+fQOygfRjMaABbTEDBTcm2oc66m3+sbbxem11WU6lXy1w+sKnxZDf0R
 vYURQ0s+MrNZjwbnPQwNS0F2f65un8dddoajsXpxxL49rqq9O1WZzPapTqPfLBgXkqct
 MwgCZ+uil6v1T8q1PcOaMEmYtQ37bB3L2bINFjB0djPq/uOsSNQ5Ou/mpXZ7cpovs7MH
 qq9hxASVBLfb3t2Pld3l9gRML/2fLfAL+533mPlLfQKG9q05ICjoyQrCwb4RJCZYm7nE
 0ukQ==
X-Gm-Message-State: AOJu0Yx0+SiiMkTBR5Etn1RpEEtgr9MrIK/n8N4u41O+G6+PwivV8YXO
 gVSzq1XWR8IROUT3dAK9rUtnF/TGER0ITX4GZXk8QXBHQMe6TkUpI5NMHTXb1VIqKurI+o2Xu92
 HsEpZsLqJR2yn6/7xCYsig8xfmbStAiScy+EvO2n68Q==
X-Gm-Gg: AfdE7cnRjgH0Jd1typhaSkaU7v8ZFZFwdn9yEiW7bS+4EGhpI4gmfZRVbRSYVh/K7qM
 Mjg8R/VHN+waIqMZrw1zhmubo1sIQU26H+2XJQJNBfe8YwBtXrJpeyDSzCU5+KkQKaj7t809Q5M
 R8zU46nqGn67RBWBSvzog+N5KS4XNV8rxhQ1zHqpZWmxfYkEhPknk343zVcRs40TvzuLoiUsiI0
 2gSYeD4ltHSEF7Ez8NW0jq76sTnX9MlT4fyUoQ03wzNKMp6fHyGEQT5YoCZcPyHapFtlYitE6zg
 L6YV1VYz+CNTwOO/F3/VhCalCEgSkGio9VoR7Go18ur1soTl0P0rf0gQ
X-Received: by 2002:a53:ac9d:0:b0:662:cea4:dd6a with SMTP id
 956f58d0204a3-662fcb8bf01mr11642109d50.48.1782049749681; Sun, 21 Jun 2026
 06:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260620171318.24189-1-randomjack94dev@gmail.com>
 <CAFEAcA9_Cy1x46YQSawzmF_fc4GVq_77vyRF7TWwruBND9eCGg@mail.gmail.com>
 <CAFvcSaQ4R7oQ9KMrEb81mZOaqZaR5XqCLn8-DJn-OX7GQuSSCQ@mail.gmail.com>
In-Reply-To: <CAFvcSaQ4R7oQ9KMrEb81mZOaqZaR5XqCLn8-DJn-OX7GQuSSCQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Jun 2026 14:48:58 +0100
X-Gm-Features: AVVi8CcYec0Ui2IlhvJVnOzC_3k_Dgfl4-8V7qY5YCmHiDn_LXEnAynzk_4BIOw
Message-ID: <CAFEAcA_MYAnYqea-1ZW8vu-c=j0s=Eb-jwc5d8VjKXiOMV=-vg@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/soc_dma: Replace if-else chain with array lookup
To: Evgeny <randomjack94dev@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sat, 20 Jun 2026 at 21:33, Evgeny <randomjack94dev@gmail.com> wrote:
>
> Dear Peter,
>
> No particular reason.
>
> Just found a small refactor-like TODO comment.
> Did not think about this code being ancient.
> Feel free to discard the patch then.

No worries. Unfortunately QEMU has a fair bit of
old code, so TODO comments are often a bit misleading
about how worthwhile making some change is. Some of
them effectively degrade into "we could do this but
it isn't worth the time" :-/

-- PMM

