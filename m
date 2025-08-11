Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFECC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPKj-0002vN-Ig; Mon, 11 Aug 2025 06:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ulPKb-0002uS-Qu
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:00:44 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ulPKW-0005I7-NL
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:00:41 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71a38e35674so24703297b3.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754906434; x=1755511234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsPQh2cLC7nXcV2D6WOVMEq6geO8j4x4Y22KNmkTKiY=;
 b=Nb13zDJhuf+v8q5lHP7TgTFAJBMa3iA9wtcZJwywTpdbOahXNNcZX0Rn68sg8x7sC+
 UGorPjypPgVnADSe+aaeaDRrcAec8WN9TuIOx2Y3rpL5XpQrTgMr4LEof0FOP32D+fQU
 1TVJXEftWyFt7xwmNIlNKd+jq9nYKnqWawKy+fjtsijL6SEWL5tF4SsHejF3t6zvY3rm
 8Jc5mMr0FPKIyc8vKz92zvlcTNe+hX5+qx0HH42rY9sD355fc/nng01Ys7OAzb0Y/DSa
 pbHWlud++GWGeUt0Ze4lpMEkv81MAYWNFSxNmWmJTQFcFcopOJfTflNn4tcMG+XDDUWI
 +/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754906434; x=1755511234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsPQh2cLC7nXcV2D6WOVMEq6geO8j4x4Y22KNmkTKiY=;
 b=SzprzvdCRJh9q5Xwd66ZdKt2lDUMZ6g8gIVKWXMyv7R3LBok0LMTnhVvSABOczckGv
 rI0MKs+Ca0p8W79QY1aZWmHG18Ga4HBk6XY6CVLtBaxp3r9nYHO4IkWBDjN0s6Bwc6s1
 WbaovUDlg/6+ERUPeVY3boJONYLrbvi5+9yMyvlnLtkxoK2pTZ/ox8vRYq4f+J6GUobc
 YsEhtgs70PWcY5KxuUkxiDyyvWAZ+BQBEeRtuTfS2OpfTfY2ZKDtYsdMLo6GW4vijRoq
 pDQS1OoKl8bMtrJJOUIw63/19elUZMyClOITMEpTmCy8YD50RCVtKG7tj2NNnlWe2Cp7
 N6mw==
X-Gm-Message-State: AOJu0YwUz88Ni/Rmfi/WyBEPVcO5chxhTxtawzWnGt8bSQaaE/vv/YlO
 5CIuQuu3efB3qJ+OQZSbE2gk7KfGoAWVCPdQUHpMQiehV+ZwDDzKUAyBtCiZq8b5yVZ+ujaujRB
 HdmXVju5O5Z/V9Nk+LwZCkZqhueBdLhPHB05E8wu4eA==
X-Gm-Gg: ASbGncv2QDYmQ7ZWpnFMJ8VnGjMlh3/RWhbagLoDGrD7jZJqwANfBdxExBahKqdDHZM
 647oZ09cmuyW2VcS+BwafaDKFy9A7OZhRNnKQv1PE5vkpvOkwpaXJNCTNoP1rNJ1wf+3zPZCUQM
 6+M3EErCs0VI7pnUlo6xGYMDxbMmCmPPJWkodGRBHMFDvqWieMbqPHDEhBoRJIagbbOsuVh8xsh
 KfFTLZU
X-Google-Smtp-Source: AGHT+IEIOb47crAn/VZ+BErJh+f89CI3UdkmsOCT5/S9l1Cacl3+hjjlLzuT5+sdwb6pXZ9pF+vCNn8vNANlcldyHQg=
X-Received: by 2002:a05:690c:4d03:b0:71c:530:146a with SMTP id
 00721157ae682-71c0530176amr121489907b3.24.1754906433546; Mon, 11 Aug 2025
 03:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250811094341.91597-1-philmd@linaro.org>
In-Reply-To: <20250811094341.91597-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Aug 2025 11:00:21 +0100
X-Gm-Features: Ac12FXxr5-m5BYrlnSjMEXK2tCrjUkDyyxDJnkbYEINa1Q6xnUWSpQYVDmQRIVE
Message-ID: <CAFEAcA8ccVxecxNd3fLiT-bNoWT-cUBJSQA1WfMr2OpWva4xoA@mail.gmail.com>
Subject: Re: [PATCH] scripts/coverity-scan/COMPONENTS.md: Add a 'plugins'
 category
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 11 Aug 2025 at 10:43, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Cover the TCG plugins files under their own Coverity category.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  scripts/coverity-scan/COMPONENTS.md | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/=
COMPONENTS.md
> index 72995903ff9..95805b536bc 100644
> --- a/scripts/coverity-scan/COMPONENTS.md
> +++ b/scripts/coverity-scan/COMPONENTS.md
> @@ -147,6 +147,9 @@ tcg
>  system
>    ~ .*/qemu(/system/.*|/accel/.*)
>
> +plugins
> +  ~ .*/qemu(/contrib|/tests/tcg)?/plugins/.*
> +
>  (headers)
>    ~ .*/qemu(/include/.*)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

This reminded me to check if we'd missed putting any other
COMPONENTS updates into the coverity website. The only
missing one is the deletion of the "cris" component last year;
I just made that change.

(It is a pity that coverity scan does not have an
"upload components file" feature, only a GUI for
making changes.)

-- PMM

