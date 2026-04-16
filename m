Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EC0F8A149
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDITq-0005OS-Ci; Thu, 16 Apr 2026 04:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDITm-0005Ny-HD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:53:43 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDITk-0008F0-Q4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:53:42 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651c5d525f6so4492088d50.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 01:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776329618; cv=none;
 d=google.com; s=arc-20240605;
 b=OqiXrVL2rooa2pM7ImWHsyuWTP8twUTPe5qP0SBBfgqfyWUeXBtkV4CiuO0bIp7VHW
 PnN7KUKyKokDiRzQupuIMtqRsrmntqL+LskgSyk/PdUqVq5DuL7O11tL3cJ3wc8yg/jo
 n0z9OpX/UTQQ9YF1naPFOop8K/HzP1mkDwnBwJgGX7QU2Aed52rgTbkAGgrl8IRnGz2/
 BDuIrIwvZWO2UHdNWuqkByMh/xpder4NKRVLPzPPRI7szztEAAR62o5ir5WSxnaCEoF+
 GHUCIoFGZ4JMpVgiW/Yb53aYVWJ3SPW4+cqkmQZJFhsCX3KgWAyE0+ASTKeHNvWgtySY
 vQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x5BDxbEeXuc3Pvvy5dNgf2LyYZeCp/NMK+KYefCTdyY=;
 fh=9DRnXINmPzvpmyEzFbwKbIaANfyGNvJUJ/hQx57tZow=;
 b=lYipgvaiikclEvDKoCia1ncR155bAb4Nn446KzCnO7KLmwIUYU1dSuUV8g6WcHdU/a
 u5eJE/7c9Q8IyVxIYn+LpPnPIiopdHJww19yjpC/BAoz3wXQPuDSvnD5FYUj57u2yfcg
 rOYtxRiFaWs4BwMNJ56GtilOpJ04vgjeEvDLMNINt1GR4l/mZFqNBbfdNbnFVCLxB8mB
 X1Xk1th8xiJ4JGYzy8lV/Tazz/OOSneFFUPWseGiQJ4+OeTQSzr/eAGWrJ1SwnINgGmL
 /ZsVMUHkcx7VqufdffP24OtAPXC2A39Eo3FGa3J35k+RUB+v86eP6NHaSS2N+YPNCBcQ
 AWBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776329618; x=1776934418; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x5BDxbEeXuc3Pvvy5dNgf2LyYZeCp/NMK+KYefCTdyY=;
 b=HHflbZR16AtrZ0fuz5CIE5lGFMzNcqHOZ67BvChI057K78qpfQOq0N1AP1RWqT4/7W
 IWzSqQOxjCltF5ExJUp6PP7YbFYJ3A2EWhrtXePxPRvLhYMCx1zfz5uIaepaCfSTDxix
 +ANIz8VktEwbu8tHHsCBrABPhILyo+bug8OijL1dV3TNBr4LPGlqBoUuLjcV3qvupV3B
 ekC6EOR2DRtbTBsYom/my8VFK3LYV5yVEeB7scpKMLSddl13FKPnYYsWLnP7xjtDMdh6
 Y/5N3QRvB8yScc7Qk7lJqYh4cW7Zd3Z//iRF2HNMCYrcbPBT/5vVcPzYgXetaaq3lJCE
 1Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776329618; x=1776934418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5BDxbEeXuc3Pvvy5dNgf2LyYZeCp/NMK+KYefCTdyY=;
 b=oKD5+G8+xmM9JIGP1EL3/zlGEZZfwI034rb2F7CEZ3s/O/wPA6xSUKwSZdbnskVME1
 5kHLvRKFbUqWlBYvnRiercFnp8NEkmBFiYkfKqA4o0La6ggzHC/T36Q+3Z/HZz/TEY3H
 ei2VAZgLzCHi1PiFmvtMWuWuzIepfFxsUFw1B2aK6SJbKU/5+Us+BzwPJ1Jr+OkD4neU
 jfX6TwW2qC2X/D2+PT/m/Z4wv4H9MPyCFmmlPCtlvMtBVYaO5iLIa0gKTvgB18jJyP/V
 QqYz0a6YVHCxsVbSdd2m6q7gebZzTFVkXAeuZpKqP98ymQjRgufV48jDHZGh167o9P9Z
 GIvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fnFULJhUeuoaprzLoJdNDvt7swvXVRRMri4KjaxBn1vE551Iz4NpbAnpT1f1woBkis8asHgGfH1Qs@nongnu.org
X-Gm-Message-State: AOJu0YzwS37ztkump5WFzSebcBLPOPRIYs2QZIQSAguS6baRZotOfPNB
 o8K6Wr2OVM0J6bo/3ySu/dqv1ZrBYv06JRQpr4WcxoyfM/OltGYVOngx7D3X8ZfWTSYp7gj5tam
 MGzMTxepp0PgbIQfad3LM+qwZ1VSrmIB4sgVUeBEeyA==
X-Gm-Gg: AeBDiev1nVs889YDVYcbSPGI4AF2fU3x+FEx17MoiYAoElGOsWxFSG1ZWVw1h+IwSi/
 d2OLc7I9gK/FyZhc5dYDtT2k3FV8JM7b4wy+0AmrWo6G/kwvrHPjIheFqjUS6OfWIt39fo0skr9
 ozYN8x0di4PALltlfoeFqacT3j2P04hx7qoeFIpQ9dwjpv1kdqfkWgeOr+zQqns62XWV5+Jfqf6
 HPkzI+5H5/jG5CazNgKjZ+gwc2HVkyV/qEPb15ozzotHavvT3knRBF96m1vrf4IYJz93efINLXH
 KlaJQWrIaa44H8ajDh/PEre5EtnvaGPEEPbXC/97ujQQwtl0luo5A49K0bI89S7zDkWIDiJSnFa
 Xzg==
X-Received: by 2002:a05:690e:d45:b0:651:bed1:19f8 with SMTP id
 956f58d0204a3-651bed12ac2mr15152924d50.26.1776329618558; Thu, 16 Apr 2026
 01:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
In-Reply-To: <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2026 09:53:27 +0100
X-Gm-Features: AQROBzCmoW9pMp_7ZZGodcYA9Zhgf1Ez-WADljCTqBgkrSwEJA6BBopE1Z3_lug
Message-ID: <CAFEAcA9hdGZQzqs6AL1OotjJat=SuNfXo_m=XSE2F0brDjngTQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: gaosong <gaosong@loongson.cn>
Cc: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 13 Apr 2026 at 04:04, gaosong <gaosong@loongson.cn> wrote:
> I confirm that the same issue exists in the 9.2-tcg-old branch,
> and you have clearly identified the root cause of the problem.
> There is no doubt that the patch itself is fine, but what confuses
> me is that you attempted to run (ABI 1.0.0) using QEMU (ABI 2.0),
> which led to the misconception that QEMU (2.0) is compatible with
> 1.0, when in fact QEMU has never been compatible with 1.0.
> As far as I understand, the differences between the ABI 2.0 and
> ABI 1.0 environments should be quite significant.
>
> Therefore, I am unsure whether we should accept this patch.

For upstream QEMU, we (as a policy choice) aren't supporting the
old ABI. So we care only about the new ABI. Below I'm going to talk
only about the new ABI and what we do upstream; decisions about the
old-ABI fork are for whoever maintains that.

Defining the target_stat64 struct and TARGET_HAS_STRUCT_STAT64
affects these syscalls:
 TARGET_NR_stat64
 TARGET_NR_lstat64
 TARGET_NR_fstat64
 TARGET_NR_fstatat64
 TARGET_NR_newfstatat

(these are the only ones which call host_to_target_stat64().)

Of these, loongarch64-linux-user defines only TARGET_NR_newfstatat.
(You can check this by looking at the generated
libqemu-loongarch64-linux-user.a.p/syscall_nr.h in the build tree.
Exactly what gets defined here is controlled by the TARGET_SYSTBL_ABI
setting in configs/targets/loongarch64-linux-user.mak plus the
linux-user/loongarch64/syscall.tbl table.)

The kernel defines 'struct stat64' only if
__BITS_PER_LONG != 64 || defined(__ARCH_WANT_STAT64).
loongarch64 doesn't set __ARCH_WANT_STAT64, and it isn't 32-bit,
so it won't get this struct.

The kernel also only provides the newfstatat syscall if
the architecture sets __ARCH_WANT_STAT64 or __ARCH_WANT_SYS_NEWFSTATAT.
loongarch64 doesn't set either.

So:

(1) We are providing newfstatat on this architecture when we
should not; that's a separate bug we should fix.

(2) we don't want to define the stat64 struct in QEMU,
but it has gone unnoticed that we got this wrong because
the struct isn't actually used by any syscalls for this
architecture.

The code change in this patch is correct, and I think we should
take it, but it would be helpful to adjust the commit message
to make it clear that for ABI-2.0 this doesn't actually
have any guest-code visible effects.

thanks
-- PMM

