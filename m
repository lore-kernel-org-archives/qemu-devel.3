Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7077ACD98E4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 20:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb2Do-000759-1Y; Sat, 20 Jun 2026 16:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wb2Dm-00074u-Ft
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 16:23:18 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wb2Dl-0005pL-01
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 16:23:18 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-662dd616cdbso3211253d50.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 13:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781986995; cv=none;
 d=google.com; s=arc-20240605;
 b=CutIA60WAMWDxrOl9SZJeDpbJV31+wGV19tSBD31eeWxrIK89Q3d7v5ULKCoXawr82
 uzIRpYEob7mHRAslYm3b8y9qGZojXmgFGrkHKdZNBGa/hEJk1Gzl0GE2eS8Ko/nzaMqj
 P5rEkaB0QRuiiUpMK1QqTaTNg2QFhXB7Y6cznxSXCOKUHseMfJlc3biVcUPgC+VIGt74
 tEDWPRwTGazH2JSIu2Z091KZqrqbFR+Yj/sDa95v6SaLHZnMijDi7uig0ZoXRHE7cwLx
 2N5fk1WbhXYK/cM2rhqIy17RDfxEt5Ovp+GwF743EeTRe+ylWtkHhZD0QyH6V5VaBdsE
 8/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RUSAOhG+fFA5GklYlsz/KwE9hrrVDZgPAZwdexY6uk0=;
 fh=0pgN9jBwankGdvXcd5ZPS6WUrSGSAxeQFGITq9Ilp50=;
 b=YEwZRzHu91CwS47NcSZdxmyxtNxyAk7NjpiqAkk/8Z+LodWhMDl2I537lKZkS1PgMv
 r5uzQGn2tahnlhhNAW5wDTOtAPGrljyAxHqPE1U3kEOoq+WRrOA7t+yFCytEToNL8ayr
 ftJpzxuIut20iOJQ4SJ9hp+g9BDuW2rexKrxCw9v/ZeWOQUmrJ1bcmmD0eHfru7UqjkV
 1isVuqwo/oq/nPFs7uB2ktqB3SGvX+bWU1RPjajbNDkpU12x1YxMbrm0e6qF28F20zRP
 N2y9shXeAkJEcEdwo1e5MnQcD0EdeQ/IcJx6PdTbcwZs1u6i2o412axN4GFV9DVgtuoo
 mlhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781986995; x=1782591795; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RUSAOhG+fFA5GklYlsz/KwE9hrrVDZgPAZwdexY6uk0=;
 b=gcAWaOTHtraGckuxP5jipY1epN+KMyWuNb5P/OR+4V36pLjjD536Id3fwTJhsKuhk8
 kvLw2dhmi7SntSf0qu+Z/StWrBGhmfKB1s0oKeau6VWA4H0InCqrGkiT9YdMwn1RL/tU
 RVfdk2uHBa2km9m040gxr5pi0Cc5RNyw+DT55Y0qaMjo7/x0PrkwYO0oE7UGuX+nBguQ
 JHWqw7ABtcuXOTaDDg8+4KmMnrOa2yxP0yMmVX8zoYnQWxBloGqIYeErKimJGxADYADf
 6xQBrbRE0gKt60XVeqWBlUgZ95YE7BbBhDs2lGWVd/O7Y7GoaQ1HhORWS6wtFq7vleiN
 chtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781986995; x=1782591795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUSAOhG+fFA5GklYlsz/KwE9hrrVDZgPAZwdexY6uk0=;
 b=h3xQvXBqcRO4ID44XptNnGswooFtnN/GwjCmcftTfIX51vOQvKvxFhE7xZx3H8q08J
 cC8LNzeh3aZ3NZTU0L1O/vP1uq61rF1skQDEUJIVBRREkAk+ocid2BRBL9YBK56PInou
 sqB7A2WtwkxUGB5FOL+neR3wav58zD+WaR22/Oo94F3u2Hx6rlbEXDcQBB88jJgpNPA2
 b56a0yuL0dem1Uhd9c9dQSiNCi9jc6mf3+itAmViNQ5gVo6op0f2SV9smSMrEL6DsKr2
 Zsc4Lr25bSJuKl0fakj0D445SeDPPkJsCJFofoUO7cpHp7vCF+VwniPZwyrZrqlp5zLu
 14kA==
X-Gm-Message-State: AOJu0YxH3PuYvZqD5nL0UOBmaVs0zOfthpJc6dsa4Zll1tC/rfwn0LtW
 evq/0qMLLXALPOmA/edX2YIOwwxr9LffIcaE3MqxtSn65JV/80i6cywoMD5wADqY/CVX6iwBdGs
 JMKaJp13BzTxZO3Mtc9Tqb9vkssYmjpJpwC5c+HW9iw==
X-Gm-Gg: AfdE7ckU6o3NK55z9ry/Cv468Sn5o+j037J/ji7Jx3xIgKEACFiwkKG3E08ylHtb2hb
 vQ+qwkvRyu6fklvI2mlTMYoqsYBxWqt7T+llomJJzCDOcDOWaLBk8IvTeOcIPmjLgnXIRLlUeRk
 187UXV2mHWkriaZYJQXBkhzjYGEux+2e1PH6Oif8M+FLG01iWNyH0/E04+G6WTE4FOgN1XyIguM
 127kytcMfaYnDA5qL+8i98Mc6aZb7d1L2pYBAb8jaFmSLtfGGsDRLLQrqBLnZM2FmLotr3icSe4
 Mbe3td2uv20w7wux/BtljPLwPLRIJ9hGm7yoC+TT4nG7xmFeSWEa78Ik
X-Received: by 2002:a05:690e:d48:b0:651:8d82:acc2 with SMTP id
 956f58d0204a3-662ffed7444mr7242271d50.63.1781986995038; Sat, 20 Jun 2026
 13:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260620171318.24189-1-randomjack94dev@gmail.com>
In-Reply-To: <20260620171318.24189-1-randomjack94dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jun 2026 21:23:03 +0100
X-Gm-Features: AVVi8Cc8sp4L0ipNZktBvLI74cn0aLYEOH3giG6BOSHJebxbeHlYKFkD1W2wcw0
Message-ID: <CAFEAcA9_Cy1x46YQSawzmF_fc4GVq_77vyRF7TWwruBND9eCGg@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/soc_dma: Replace if-else chain with array lookup
To: Evgeny Kolmakov <randomjack94dev@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sat, 20 Jun 2026 at 18:20, Evgeny Kolmakov <randomjack94dev@gmail.com> wrote:
>
> Refactor transfer_fn assignment in soc_dma_ch_update()
> via array lookup as suggested by the TODO comment.
>
> Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>

Any particular reason why you're looking at this ancient
code? It's used only by the omap SoC -- if we care enough
to do anything to it then converting it to qdev is fairly
high up the list...

thanks
-- PMM

