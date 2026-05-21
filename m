Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE03CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ5N7-00028q-V5; Thu, 21 May 2026 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5Ml-00024B-Om
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:31:20 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ5Mh-0000A7-CP
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:31:17 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65c5361142fso6168814d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779377472; cv=none;
 d=google.com; s=arc-20240605;
 b=R4tDGCDtRnOD/X2fCQJ9MO2FxR0bZb6rtAPkbRyzIU4Ju324VEIJR5zsQXxYjKWQyp
 uqUFYcCAv3h6JUUGTVnxNgkZALsMcFXVxTAtKNdRniDlyAafKGALqtegfXkUgjv9YG29
 YXO73L1Iv3T6SEUjup6cxii3RS6FS3X28l145v/OXJ+838yFG1aPQse9Cj9rGSS8S1rx
 NnpatkzxtE7Ef828eFOGwNkT3fIgHVBpKZCfy16gJ5xrIUAjC7GTtLSmYlDJ38SNxGOc
 NW/k4GQdzQhLgotmx5MgxwlDxQ+WmQyNJ8Z29ZbUXDOIIgN/EhtUEv+R/SyuLFOgoDe2
 VZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OAaWMWJwk63Rg4gmAAVrRYzsSGQ6Cp2o1ToLmKpl1FY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=GwS0LxOA+qs9Y8oN7qp3KydH3X/+5JN99EWHjRBtqhQB9abyyJpFp7zfmTteNn0jF6
 yXhJSrGJySkXKoaUM/RDSfJaltNE4+hMfZE/aDyei5BMUeqkU0xqVeJKJsVDQNRp/HaA
 V9HeAbkHa9Z9MuSm0K8cW6edMy6aeDLXnY47ErYMlK6V6bHUPFVRcJKEKEoa61u94VfW
 Mou5jgZ7smrQoCxMpLESgbDfaVPMH+yxyOGF3uKA1EdvfhvPlI3ui8yF54XcsAaww1Rn
 0xknKxaZGYT/OoSAZBozWNovr0t/FhLM3bWj/OiPlDI9ysRsy555sU7eAv2TOqCurPxk
 rX/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779377472; x=1779982272; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OAaWMWJwk63Rg4gmAAVrRYzsSGQ6Cp2o1ToLmKpl1FY=;
 b=DQnwYLNjdNCxBVKBEwJThRf6ZygmZLIjGHm2tF55kt7Rk68wTd074Zz/iWyVMVYTVO
 HtrXd4GLSVZvh0a/3ZeKnqrHZnjX/EgGmfE7YeMMkG6gUq/MmOvUna+d0nZHAmGxfaZo
 Xr8SvLSMbYoprDzkicb/12l1IvlgsjpaUo6IaNhXChH7YloJb/Jkdpp/UVBg14eKAvwM
 6GM18aaju4vHjbKD1DfOmWn5I0nP/W0sXYJaFuoy8oz6ntV2x6s36TUUkLq08aU43HjD
 x+Ff9MP54OFueXn59JlGI12V3DzEkHf9n9BjxQHA0sXqRIQ/II5l5BMEucvl34Q3onTC
 Lc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377472; x=1779982272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAaWMWJwk63Rg4gmAAVrRYzsSGQ6Cp2o1ToLmKpl1FY=;
 b=UOa5ATxzKmPp1fFv8cukyX2l6BjXWnP9z/TBx8e+k5/k0zaTn6tJdxseTJ5Qgm3Nem
 eytWmdMh8KFx5EzyxTkQKlAZrH+iMjh5FmMU2pKRhjlHjW0wLIzl8K2y+Z3gDAPaipJQ
 It11wyPino2QInHp/Q2BZWU4CH5mWxNYeGVKattpQPgtljQGkja8fA8Fkcyc+h/cMnbx
 p5gU7eGCWtDyz2SdOnczjE+cGXztaH9990OfQC3OA22Xwl3feFcHGCqy8moOHjEvX5e8
 So7XVhmLmqg4MmP1J0X0etKPA8xHXp29SXw6ODK8yBerfbLWODbzAR7hHuAIeuLoCpn9
 exFA==
X-Gm-Message-State: AOJu0YwnbnEfjr6xtyIBdDzmkqtJiygI6QrhPoN7rz3VcrWsSgn7MZ3c
 lTuPJ39gLAZoTeYh/NziO9hdRk6fx3tX1e1HUGgDcItovCTIRPwolE1uQftYnTgHZZIvH9kiezL
 bBda+gcOAAiOLNIBvh261bp9y7pZzAmYefVzlE/bfzw==
X-Gm-Gg: Acq92OHlM99fvwxnJxDVJbaMBICbi/fzA64/eB7IT5A+JMGiKd/piJBxj9DV28GLOwr
 29vNfQz2NRkT/EgCMmSZ3EI4rFh0RGnLe9evBZcEbMsxBIxcmnFZFgC/2q/nE0cj8RPl1FlgT2G
 mOjOfHZl5yeK4LCUdXXtWxON30QAINSEgLZBiIN31j/m7PEPKpCbJuM7zYJFy6w9LQ8znHkIPoX
 UK5XaOaucmQGHmeGuXlis7ABK+POXxFrxgHhpzjF9NUspYexT2lsu7XQmNNQmldRbhNFd6oQYgC
 h1hUpgAOsJseUcBPZAIS4oxJUMkGoegCrXMTBMsLOAZdl9KzS7UtNjlb96AHqYi/D/U=
X-Received: by 2002:a05:690e:d41:b0:65c:3597:5fd6 with SMTP id
 956f58d0204a3-65eae27d729mr2552878d50.48.1779377471480; Thu, 21 May 2026
 08:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-20-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 16:30:59 +0100
X-Gm-Features: AVHnY4L4xUa5jnTZQ36QnkqVzdnfi2DDBoG6gEl8ncYQi0H1pnECrsVQNgRbyRI
Message-ID: <CAFEAcA8xoMxi05C+YXqwHudbnBaW1uu44Eqv-JpX02F5qZ-69g@mail.gmail.com>
Subject: Re: [PATCH v6 19/64] target/arm: Implement FSCALE for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 20 May 2026 at 19:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

