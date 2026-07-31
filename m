Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD03C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr8G-0000BS-Pi; Fri, 31 Jul 2026 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr89-0000Aj-42
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:34:48 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr87-0006IY-Jm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:34:44 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6688acd1a51so1636927d50.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785519282; cv=none;
 d=google.com; s=arc-20260327;
 b=AFy43gQm7FGMANpQHh4Mq/pGSd0TFr/wb3ORuN9bwuI/nOjnygkxNYNVf5nLjyw0nh
 QczWOFNmFPlcfz6aUgeFe0ezShlW8FaghDwko+FkRlkNVvju29nxDp/VKDUUtc6zjxO/
 Oxal85vEYdj14HVUKImrBKErvoXOtAf8CrkQB/ZCCz4LYGbdbJul7R4KYJHTyxRMSiXN
 UKIvMPcnrEUGEzbSQhhbeXJBarDgajf15Z0RWYAYHrl8YDBf7Gsj7qQme46psk87AGPr
 ju9aBHNc/mQjWcj6epOwi2G0eVCT0djvedcn45JP9h5SxLUD0CWINpYODy57p9BXK5SL
 QN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uz7UcaWvtjC1VUrg2O/CUC4pLvht0xzhdCbjVXgGzKk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=pR8sXwRH71ljoxx4FUwJhjicRap5GdJZqbBL34bSvi5AtEgvJ1Nk/3tVxSYqQQJcGf
 0UrlIY8gEpTnMkAcQyJWZYKZnvWYxJfMhyucU8aTydxKj2xPDXUqclntB3adlSQr1qzS
 Afjz2DMkc6eyjha6Z8fwaoyiptR9jVhxkGAyHgAlsin1vmUg5zgYfdnI3JQijWkvrlmU
 EMmT1zkM0YYeXskTe0sAJfoJfoy4Y7FsaYlA0S1hj3j55UL8Z759x9SPNC0/42EdpJzH
 4+wwzDdd1sUbeFM8lWQN3BDUN7JSNZwtyvmm+zPJjX+tAjc+sCD8h8m/lIq7Ih6cW1v/
 9PIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785519282; x=1786124082; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uz7UcaWvtjC1VUrg2O/CUC4pLvht0xzhdCbjVXgGzKk=;
 b=ejwzeXYlQyViTzMJEABhNyqt8zyOcK4w3adswSq0UCoCew6PasBmCNMaXqyyTHdXfH
 n8ccjJ6uF78FmcvLPMkO+Xx/BtKlmR+pJYw2KKW/Xm5TaQr27BAnKMKeyW1M5tOG2vHZ
 it/UvSzPr1sbUor2V3zjien+z7YQ1D0hYkXrI9ucjHCMbgL/swUqBsRMeFQh/xFPIofR
 SFt07cYElTCS4i7b8KfQ0Dg6ghUY6MGWP0FlsiCcF5FeKnmlxKjf5MoYkuWwH8q9VLbD
 HEBz5kSVB3ea7IZgs8rkLRlTTyGsF/lW+jkGx5ZnMGGDLWKcN1UXU2OwrfJyGTzQOa2J
 fFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519282; x=1786124082;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uz7UcaWvtjC1VUrg2O/CUC4pLvht0xzhdCbjVXgGzKk=;
 b=FLuCr11ShYEAMOpvJB5zfKINHH/CPqeEPrQDZ+zIWMtl4LPfA6I/fYdhGGwZV5JdZR
 4em9++tmBdN8xLpD2AdEUC8drYfO9MQvagh/cZ45rHW5+Rv8GLokXqc+A0QODWiWZ+bp
 CmP846LijI6jSb6p/lbL50iwMBhPhCNIB1Ezi8oY/mjAOttZdjwDaOA0zTQD4UIKXMCW
 KFSF5/D/WZJTSH06qzszXtLnHod98Xn4N1cgwIbc140thKa05xd783acz70zTb411Rwc
 LlwXTVfZl8zV9SZo/fYldj5VG3acNPiVz8VJ5rqSkCJmfeClsyXPFRENdHv0o/W8ckjO
 fcpQ==
X-Gm-Message-State: AOJu0Yz+eQm5Wk7jEgSjhXrHv8c8hkSw71DRsAZYtg+/Xhw9QGy/VzI5
 XY59xajaUU0p7FpCV+aT70gOqCsjAAXlLLS2D7qAYTOs8yFtdNMnugCjxOO40VwiU6IxpcoNdan
 FEO1eLOpYxxGRFp/BYgJYM7l8Vvr1tiAL4uFeOH0fOhTpnIWqGEWF
X-Gm-Gg: AR+sD13EcbB4LdhTK2zgkKtgt2JqMJY0ppWJucpp6GYBTzhSrL40I6DpcLqm43B3az2
 M7m5IOrgxmD+Dg6FgDTUZEU3praXNS95uFyMzhL+KILW/4C1SjbyR8R0zaYjkLTaKQUcJUZuyv6
 XywK9s1PvrtIUkH5k/ifBcxe4WLbHdyOwMEmIz0eWPhrjZV8A+5Ob/iQ1BufAjehDYthlyzrtf1
 G607fh6ClAj7BY2M3pVaUWApE+vguktZUmRPGJN5dtg7hzbBvjPnEro6CWiB2OLGOOpXmq8fTZ1
 7jMqdID+TIYeorei6GoSzyS15pPZzQVndTkAuL+/LKmCjYzeUKfm76u2eQyhANd7183CN6GDDbU
 2T6QcYJcY0hs1NixFKSHQVeU8GgPz
X-Received: by 2002:a05:690e:4848:b0:668:9d0f:ab70 with SMTP id
 956f58d0204a3-6694f079ea9mr761141d50.18.1785519282224; Fri, 31 Jul 2026
 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260724031123.76597-1-richard.henderson@linaro.org>
 <20260724031123.76597-2-richard.henderson@linaro.org>
In-Reply-To: <20260724031123.76597-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:34:30 +0100
X-Gm-Features: AUfX_myEsvU3U5TiyVubbw0KY3g515r_kTwIOkrDBppCsIfiCQEeE7meNnJtFgg
Message-ID: <CAFEAcA9jz-88M-f1U8qJb7i2mYKbX8G1ehtV-ZpVW9iCRuUK6w@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/arm: Rename isar_feature_aa64_idst
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 24 Jul 2026 at 04:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from isar_feature_aa64_ids to match the feature name: FEAT_IDST.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      | 2 +-
>  target/arm/tcg/op_helper.c     | 2 +-
>  target/arm/tcg/translate-a64.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

