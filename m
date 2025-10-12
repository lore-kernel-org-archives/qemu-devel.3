Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63564CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 19:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v82De-0001ZH-PQ; Sun, 12 Oct 2025 15:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v82Dc-0001Z1-VK
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 15:59:01 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v82Db-0000Hj-6p
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 15:59:00 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-74435335177so67569537b3.0
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760299137; x=1760903937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uR/6kkc+XhNAIMK4MGnnVYQuJkVQGyCyNIm74LSXM5k=;
 b=us81VVNJT24i7pUlkkw1s8FrohHhYS6+FDFESz8fXAGIlOHF0jpUIdEu+lTcl4LjDK
 dc2VkEvmQXFbpkj+JwlKMJBQKTwUKmSYolvBQ6J8F+KUiNTPmUDNfyOgwBocX02EgKxC
 zdSQKUs2cbYjOr0NAIjSdbVAsngqNtZzmYfDlUII3a7Ld+oprD4GyvuqD6PWPt/t5cBQ
 ieQrCmB05OmiRzAv271e0N1qUpSwb+owB3hIbmTmM1QTlT96nrGnJGnuQwkV+PnA5SQB
 z5cI6pGAxnyD64cAjyXFJyeu6J8Kg4LyLCgVeZI7AL0rB/IbiW7h60vJb9ZSRNffCRLT
 S2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760299137; x=1760903937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uR/6kkc+XhNAIMK4MGnnVYQuJkVQGyCyNIm74LSXM5k=;
 b=X+oMjDrNqRTGx4qElUh99DaPPc7ukkUscZFaGCfY0NdPimJO5YRMfuzO9ICx4dSiwK
 Kt0u+AQ4DpupnU3BJLaqBPrihx7PRbQxII4vBerLswnQFAlpyFTnAb6oFI2VwicF1TrN
 oKhgWlhfzSqlMgQihIMVBBxMvop1OQmjGBviZ3jGfpR3jMikNEXjLeBpdNYAjeTokFAn
 AsGysVFFI8d2mDpNCZomIKFB+akoVJWfhzwjJwWPFZcM0Y5H2xz4Lv2+VS4YddBV+Jal
 nXf9Z78+FOkEkl1jLFvhBNCGSNMuKrlVIMXI80RqaeHNgahOq2sQo2FhmYdaub3f3PtP
 jABQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+1TfQ+yam44jJzVJ3T+nc1y8rfBs5EAEIVa2qgJuWZBuhePj59L7uogC2oPIr2X7hZfEnfRU1Yujs@nongnu.org
X-Gm-Message-State: AOJu0Yy0CwsC8LP0pr2qtZ77mNahExNjK0QD9KzJMMlJtfLGg6i1GcbO
 n7xZOzRE754EXdarLRUbBDwGwQOkf/TN2YEmZ0r7BpA0QKqFj/mEC1RW7LN9JlcQwMnWk378tdA
 6bUKmAvP63Txg1p05esofEjBJ/nxJ3fKCRD68qUYLxg==
X-Gm-Gg: ASbGncsUxfyLUd5jtOwTbRlPqpfnDOzz78ba0TNEmqIqvYHjnsWeDAdMV+TF7nTKS6V
 O4MexQlfJQ7kBsdJuwyL4lHd86T53qpgC1CMZYPUdman/kQAyUAKroQxhx5hyYf//IR09CFOvtq
 XgXXHFYJMOk/Aenq8LX4or6/b7WWY6igCNvf2BDhQMfeOIw4L2/6wwqbUhvNRBX5SYskHAQYcPK
 L8QuHeqqpqp0YQnayDy4aaXoGq0w/k=
X-Google-Smtp-Source: AGHT+IHb51RPECWLvVmV+ocFCYbAMMTVaaAE7w3o+1h/VHZ9oSM3ir37Ox017opgt50lOXCkVkexHhEjQ+7WgWboUR4=
X-Received: by 2002:a05:690e:110:b0:636:2079:186e with SMTP id
 956f58d0204a3-63ccc3e19bemr13592564d50.5.1760299137083; Sun, 12 Oct 2025
 12:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
 <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
In-Reply-To: <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Oct 2025 20:58:45 +0100
X-Gm-Features: AS18NWA6FiqC3Plxc8irH0-IPkUGXW14lDOQiW26_p6JOGe27HKG93ymMV8jV9A
Message-ID: <CAFEAcA_OLA=Ct7wFHwnfixrYofjyMDuw_5ViNb7Yxu43B12szQ@mail.gmail.com>
Subject: Re: [PULL 00/76] target-arm queue
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 10 Oct 2025 at 20:59, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi,
>
> On 10/10/25 16:03, Richard Henderson wrote:
> > On 10/10/25 06:04, Peter Maydell wrote:
> >> Hi; this is another target-arm pullreq. It's a big one but it's
> >> only two series: FEAT_MEC and FEAT_GCS.
> >>
> >> thanks
> >> -- PMM
> >>
> >> The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:
> >>
> >>    Merge tag 'pull-loongarch-20251009' ofhttps://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251010
> >>
> >> for you to fetch changes up to 00936783abf77ebb47a78312a2e6500c6a13d938:
> >>
> >>    target/arm: Enable FEAT_MEC in -cpu max (2025-10-10 13:22:05 +0100)
> >>
> >> ----------------------------------------------------------------
> >> target-arm queue:
> >>   * Implement FEAT_GCS
> >>   * Implement FEAT_MEC
> >
> > Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.
>
> Could somebody give me access to https://wiki.qemu.org/ChangeLog/10.2, please?

It should be accessible to anybody with a wiki account, I think.

(I have already updated it per this pullreq's changes; let me
know if I missed anything.)

thanks
-- PMM

