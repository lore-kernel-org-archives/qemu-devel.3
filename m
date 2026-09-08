Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B616AC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tVs-0007Gw-L7; Tue, 08 Sep 2026 06:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tVq-0007Gc-PZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:57:14 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tVp-00008y-Ea
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:57:14 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8664769db58so21205747b3.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788865032; cv=none;
 d=google.com; s=arc-20260327;
 b=UduGORwOGXnqUaZUvC+4EHGVrYv9kLLCVAQd6URXUoDnEiFL74OOONZrKiWR9iN03v
 lr2F52++ss+H2vxEiB1dd24BqbEp29Ssc7XXJRPBmk/wNwai0huJvgqJUqdlgv7wMvGR
 M9FgzV3LBOE0oqdEcTCFuBSPZFqtBDULST74U+YB7CqylWq+l5qBD9cyxUQRLcZasfha
 rq3vRUGCg99iMXrlhGryorll1Bi+fvzLWbVH4rcWyx9pmIUIqtJKyu5PsHXZ4x1cVmf/
 9L++pW3NOh0XFIcmsyn6Rh0YVItUOteeNbREI3JpctgmjcVbxoznvwx3dsyPyfxAh2EX
 QxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wQ9WmKGL8giA6BBf2/BQrVAt1bLQIDDgWR/2kPbzTr8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=oMkO1Atp7A7Eq/7ywO/FrozsKIQOQYdSyGV0dwGNYWUlqMeivfpLIThvtDUpGAwQYR
 MDKMTo1Gu0eKh6Uk8XHyOh6MuBZu3B4XCd2QohTrVR9NaD2crTGdy6t+0WgVIzjSzTcE
 b4QUpzj32Zz0LtQIzYpu7jsdnVPArJLafhUpgsicrOaBxFC68Xd496iUcQ97iTLFX9xh
 HCjyhjkMNfIUSy5BQYOBJs9uC/Z/E4uXAP665bbtfgtF3gm4xoglRDnYvLQnjk8gf8kX
 PTtgKQeI0uWl4/4fwPHGgHKtYQ3VewnCbK24Cn1wRAZB4ywyAUo6MgmeMmfFf+ijPvMd
 RPyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788865032; x=1789469832; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wQ9WmKGL8giA6BBf2/BQrVAt1bLQIDDgWR/2kPbzTr8=;
 b=vQnJmQSX9Uh1felo6elQlvYbJNcwqZab5gLgmPwE0C/jhdmZFtGqgtd8sJAPz1mX/0
 0RpAAfzWsfqB3/ZCOpFUY8LKR9frHtDpXj+ULM3arBviGs+uZes3vmJW6CUF16tLSpkE
 Jc4JO3E5m/qzYZ49+SpqBirZTu8Jts3AQ56GBwiU5hA2XVjbTPjUqYvIOf/UtgucFqnL
 e9+9RYAGvqux0mztmbN5uvqHbirvF7EuWl6YlCRdMzwkUFHKagWHbhGqgkS+uhDWEUHD
 RKxUrJOee2k2o078/OCb6EDJtz6vm6dmOE+B8UaWhM4q5xP8GeW3eEJ9uJ0C7nEE9GGf
 LlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788865032; x=1789469832;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wQ9WmKGL8giA6BBf2/BQrVAt1bLQIDDgWR/2kPbzTr8=;
 b=mT6qxcWIePBYBRyjQDQa+95FgWsIR/qd460jetrmto7AfOR3u6cXszSQjVNkASKTJY
 CT4MyzwRdb3XCv4j6cUfLVlDCwe0kLxbLg1nQypb+XJw+3PEfEtrFsqZLvHFYhWUYHBY
 cgeBCLoCXuvRPMdslgZBzjWGMSoZ1s2xBO/hWfy3wQClwjfv8TJE8mFDhvl6mPrEz9zt
 uSKCvY3+5AChC7Lzx4lDbhwL0hF5kWPMR6Cjt17Z54z0F7TmjRG4FcMN6GujO383NfK9
 rnR40SPytmugVD+bmXgQV/8UO3h9H3qwnxaU/O/huxZwXvj9k7/m9G6Jdw77DSBQsqx1
 iRMQ==
X-Gm-Message-State: AFuF++krpSahOIh8/KIfmXXmKa8e2+w++cIGgajdQXtBBRlpVpaNpT+B
 TicNUBmBpZCQYw/tBE56/R82mGpSnuL/aEF0oOhNRJm955k2KfS+cJHcEP+wkPVKTj+/3nd0UDA
 7CoXR7iWxyNpfSuIEJDsz9kEdsyX/DI4izX9Yu2sECw==
X-Gm-Gg: AYBFou0PBNgglaDtBxHcQVsgTHt6fF4xGy3B0Nby4HCkBI5io0e7v2kPna1V7/+UcB4
 a/cCr3IQLfc1S8uoGibFQnSPxNlnphrzDvb1q0U1raSNnkNwvSmpCjN8KlEp0XKnFC6E9Ui4Y0s
 GieUxRsEjavu+W1jIZ9iYXNJCb1UHo6d77HIxZdfP2cayn+dxHh8LWbbj1RnT3BV1qnsVxp/K6F
 VQmEKzZuT5ytEua4IRqM66R/X2HS+N5nqYrus2sGRQsN3/YlBlIGOr11V5iUq1KPNHvheIwmDQe
 2wEjknp6d0tY88ETP3oIRVVyTuOG40NHCB6qJljywlycfodfPL8HtRIOWLKIVnEdOWCy4rIvNVI
 qjWpETcUjaidArahEyrIwa1LOmPmA
X-Received: by 2002:a05:690c:a4db:b0:873:5c0f:28e with SMTP id
 00721157ae682-8735c0f0462mr53492697b3.56.1788865031998; Tue, 08 Sep 2026
 03:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-7-richard.henderson@linaro.org>
In-Reply-To: <20260828222639.1432046-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 11:56:59 +0100
X-Gm-Features: AcwNN1XLGSYVeUq5PVnGc0rGldvQYhb4Njf0MMqwKd0YpvF_bZke504yFYXChrY
Message-ID: <CAFEAcA_i+bbSavAZ8tBBaspwn7rn41di-n1f24jfrq49S_McPQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] target/arm: Add isar_feature_aa64_uinj
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 28 Aug 2026 at 23:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

