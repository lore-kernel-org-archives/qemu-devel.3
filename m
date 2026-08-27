Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6CC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wza5W-0005zm-DZ; Thu, 27 Aug 2026 09:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wza5U-0005zH-RX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:24:12 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wza5T-0008DD-96
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:24:12 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-836c4474028so24513517b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787837050; cv=none;
 d=google.com; s=arc-20260327;
 b=D3uiWxTY55c0oJ3+5OrkDncMUY1MSTdNLr4ORcROUodQp9DAhuzUnhh7kSQqfJmSLw
 zqCbwEt/Q+ULPnwYWjKq2CprNqTQuzNEh44o6ErK8cDStsKGnVkgPFKOwf85OKFwi3QI
 2/1vCZl9VT0H7Z0Up0ACsMxT3tBjODknDnbOJOhjCsuuQH/WAppJQ0U54BLbHcQXeo4M
 JTusHYf3cuNMQZkCdilh1BHbbuS7KrDWb5NqXDZe7njG0ogD7No82GFdNbXIWsZlgsIs
 8gBvE5TQUyPIBjEo5ZAn3PPWoDzvUT82y6Gk2ny5DfD4BtqCsGYDfnIKp02npxbnYjgG
 ZptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XAaYA7j7G13b2Fv6XG2065GHaY0UFn21jSBTzq0d7xI=;
 fh=ha6/36mnVIse2IYGESlpLWU1S2sZOniWgoAfZb7nzCU=;
 b=lVqGDqAfRfIuJkZ5L6+L2lq1/S6YMoFze1RcSzCfgZQaFam8PSdkBtRzhP+RSpSg8P
 F0+b42qBEIbJO6V2rsFLcHZJIn8JIn7tMuSpe2er8lDd9bZxzxyvh5yrzKATm4g7UPDD
 +Wv/ejSxtVtqtT+OL2AOxcKdXowk5PHE6Ml9FQsU68I21Avo2rU4CVMJE9+b10n3cwE6
 zEjB+DWbm0lMBWYtcww13w5Ot5Om2JKtkDDANaAmCxwWE7oPWrg6646rWw1knBYJmUOy
 C+NW921IQSYxTI8a/4yWcC6hy3qqoPKnu3AbChn+km4grRMsnXPuqMg9KDWZyWWkErQb
 Md8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787837050; x=1788441850; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XAaYA7j7G13b2Fv6XG2065GHaY0UFn21jSBTzq0d7xI=;
 b=iCzVt+z92POn+PqXEUMPpK237dxmwwaV4spamS8SZBYkBAwMekeLI2Ak55rcnLIAfq
 4vgTYD45cLOTuL+lHnpQtapLpbL1NwSMwwWSE0aeA0kY6ou0ENmS6l/fLR47jXnUaiLI
 qW2Dy9CIq88yD0llJv0XIPq8gyIQGxZ/Mhyrgoj+73nlNEoiyFxR03z+JLkW+XMaj70T
 8zLSmbHv4OVM7tokjfMeS+9xWJfNSmNSZsgcU4BSyzk0vryAJIlhR2tnc2uVW1k92pIv
 gqSTqzSrFZ/9TfvzbzE9dB8W0FOmud7w5PUpSkIvW0Ca/8v6K8bYGveY/ThiREVAUncT
 q5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787837050; x=1788441850;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XAaYA7j7G13b2Fv6XG2065GHaY0UFn21jSBTzq0d7xI=;
 b=YKIXvL8V7DT+jbNqoasBwGLP4pMvvQBT+HPK09r90EBuQ5hT7zdiE7/pogwfY2w4yA
 Li6heox2Va/stawKYUuKHHZ+nShO80CNge02wLIoIdLheTMBAaEluIfjtuWdCAQqTJY9
 SfcWxRapyS7750z4Rp1uEouQTbnSf+v2QKthUeak2CSAz/4cyy4OaWlP6CaVX0x/Vw3H
 QSOMSOAVBxbzMYRHuTuKAlW/JuV8EovHoaxT4my79StamkhqQpUctXU9e+MHgyaJUhU5
 I59tECICy8tIw5CV4NW2jNTykh7J66U3MLgoGAvVnUiBSG6yPMJ7mUN+BB4pTthuZ5Mj
 M0RQ==
X-Gm-Message-State: AFuF++nYkAAahNWshMJe9L8HHqJMhIuqWYlRdN7Nws2XpRjBz3i4GmCc
 Owd/7yp/Lxnv/IcuINfRAtryFJpjjhF4KozdNl+0JArsNpg/IUmyRlcEkINIKliHrHlGBuITNOU
 3fmig8QqooBRrioKDrRL51fokdzLyC1hxlYBZMedG+w==
X-Gm-Gg: AR+sD13VCcvTDpPsnb+MUx8fGhloP1/n1fw0akG5ZziraLVRM8z0vPhwrzwIY40ZcBY
 gMyCOrANNIDziisdbiXloji62FzBgbIYJWjjrZFedL6tznzfGlMOGkgpxH32Eb6YQyEFwASGUS7
 R2tJIULs7aO4RFjRfoIFEUXtOqPvbyC4ISCB0BYtNWyx9Pg30Mu/LnMuWPp55VOHrsCkdazFHe2
 c/HLxYMGCN0VdJjrYuU4asDgI6RF8ryHsslE73fSC1yILpAHWgj5GE5ptOyVcvhZb7cV6o+VgbQ
 oOPGQAcLGX+0QXqkJHPngLniPPXm08XNWafpG2P817gWy/9wNk6lSC+TTjBmePFJTtkUAzSBpB3
 NQLSXWxOU7mpUlj5ctxt3FIxPMmf+
X-Received: by 2002:a05:690c:c6c9:b0:854:d9d0:467b with SMTP id
 00721157ae682-85741730018mr51971107b3.22.1787837049805; Thu, 27 Aug 2026
 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
 <20260818002629.172827-9-simonxhy0404@gmail.com>
In-Reply-To: <20260818002629.172827-9-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:23:57 +0100
X-Gm-Features: AcwNN1WYLQyXlxZfBdbBKM20gekZ9gpu6iuWXcmbFulO_pfBB29ZADNazkrdePU
Message-ID: <CAFEAcA-cT1dFhURcxB-qE80LL8apGfydrMM+pwWgbLgJWe4rWA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] hw/misc/mps2-fpgaio.c: add GPIOALT2 register
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>, Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 18 Aug 2026 at 01:26, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add GPIOALT2 register for new an555 board.
> Implement register access as RW with LOG_UNIMP for writes.
> Add "has-gpioalt2" property to make each board configurable.
> Add gpioalt2 vmstate subsection for device state migration.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> Message-Id: <20260805153005.9989-10-simonxhy0404@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

