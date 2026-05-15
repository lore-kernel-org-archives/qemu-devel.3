Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E85ACD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnZD-0000av-Bc; Fri, 15 May 2026 04:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnZ5-0000Yh-Ez
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:06:37 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnZ2-00022F-Be
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:06:34 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65318dafbcbso11559585d50.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832391; cv=none;
 d=google.com; s=arc-20240605;
 b=OWngZLGjuCa4bnGWCU5hHjJntytEjCNaqGuoZmwKcM84nzlMGi9wPYYWkus49OcZFq
 nOiEjhzsCAwGqKgrrIiof1xd43dBSYkArdKOKVPMlHNQMS5ZVy/FDPZzSwIB6zOdq0Bg
 ID3TIpg7aDfK+Uea6JPemeknECeIvqWzQQ+pUYHfl8wFJarEBMVRXhg1ltU+ETog/0vz
 30qMksB3JAf7SdSbcFc0fhgqsBymKs/w+B3S0KAQgddkSE2MT8roCuTtqU6uo2ZXZ33+
 5VcyA40x9TIZDeVrhw9b/RvuVBmuZ4RKPB+PjZXHqvGRlojSUam0p/jdT3ZNkSBap9gP
 AqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P4dhqE8j+agd/H0cGbTBRS5+8roBEjapfdz3LMq4yJQ=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=gCpYxSQXdiuI2TWjT2WWheEwMGJWJaHsfz2Sk2+Atsse3/H6fsuBCajmliVIfVj1mo
 3g8nrekZvLK1pJNpO4q71URdyh64vruMn7HHePpvG4OBtuZDm74qiAMH6il9k2YEu2+x
 vcHpg+QSQ1j84SuZ+53M2Fkaw9aPZCwqjnXkBw7Q5nC3l0Pws/mrn1w2jMn7cZDVvm1E
 83AUlxlgjt4of/hluco7oiX78k2dT22FbWKoNkhoGFdeOxCVcoVR+2pXzm5i3BEZXd6m
 W4yYSUPMaM0r3o4PzbCMJhV4Pb/JWy+AgTCLSaBczfoGOxiOp6xzTcV1tUU+/05oY7C7
 bUgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832391; x=1779437191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4dhqE8j+agd/H0cGbTBRS5+8roBEjapfdz3LMq4yJQ=;
 b=b87vxyFKQbUMIJzXKJbg/2aZO4sLQHUG4GEoI0Z3DqR/wz+OH7UOALLl3a/dmckxCB
 WM6F+zVFZHaMkRWX8J84jJA5J22KRNfI+npO8u2lUmuvjCvM3Yk5OUAuHnR+NTvUZMfK
 gbA+dLNEcN8BdtpCULkVYjRpkUroUBqmbath4YdMtjtA9ebVPSeAHepzDs6qoND/KZAR
 RP9d0962nb8cL7eNbZ50OSdgM2CMryH8BSLy7bDeemM87weWwYA1ggDgt+YJqHwYGxeF
 oQYfE2l4hfvQl4UJzpELclVT/Hkp1LjoEurbwgptwHYg9ic5/2Y85Ge5p3U6cKT61YgS
 qpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832391; x=1779437191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4dhqE8j+agd/H0cGbTBRS5+8roBEjapfdz3LMq4yJQ=;
 b=Bxk8KwT+EHPkkdbkdnomxakj3sIYAUPi3IQwqy62CLHMVrkqOPOszpk/oY14nn6RsY
 V0qZL1IXhnD4ktcfvZk2zyDR8sPsj4A73zP8kemxqxUB0dUjajekqkTjo818juI5yMu1
 4wolaqxPMTN/FV9wC0CxpHwS0zeaLHU9gopkY7+UKF7TveiQbFIMgjgv9byiu2jbjr0x
 e3DKpZvdYrk4rnX3Ucjoj5IqEr2tXqTf0/ms2aPSnnjhmsQEYxuu5LaSlx5f+HLez6DD
 St6qaUOSogEPVjeDoOmsrJRnoebscZFhocb/RDJfW2VYqiT6lEhoAyCE8kC5yBk4mowo
 cU8Q==
X-Gm-Message-State: AOJu0Yz4FMLrmqEefMPRuUeBPwVCGS9ZyTak7gcLq8SiP0ZfviEFa7MV
 yIusaVZIe4emcRya04cRGs/21UZhHMBGTupiCHblontAwxMy3D5pARIbMqJZYIt0QrDrmRAdDyB
 KUm7JkTv/07Yjx0heksvjBA5eDAon6LNsfb+WLX9Gdg==
X-Gm-Gg: Acq92OEFMBw2AGSC6FUq8qpojsP1W/qde5ty8YKzOAKCQlKaTFWEwErzelEcJ2qCLq/
 +ITWEU97doiXzoV9e3bR87+n5DvE7/dD4y26dBnXK0LIrmQz70jla0WLWZErXtLdsJalyMAp1zL
 NrR6YnP+2uJQsYpS28/p2iyQqaRprnYuMwuf7niUm+4gvYtOzp4rAVjntZh+RZFKnPkzl73t61O
 0nUD6LgtDTV1UggHbrS3ltPsH2z3f0v+vZu1XMlXp/H30MrYI33Tn3gG87UQz5UkpNUKt7knyk9
 W9W/ZD742/5It8QZkN9gX9Mxde+edCJyb3tqkLhsPRN7RV2Ig1z3/BKOEJTNfMc/17Y=
X-Received: by 2002:a53:acdb:0:10b0:65d:de00:cd35 with SMTP id
 956f58d0204a3-65e226bbd2amr2381500d50.19.1778832390980; Fri, 15 May 2026
 01:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-14-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-14-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:06:19 +0100
X-Gm-Features: AVHnY4IKOau2RICHQ71C2Jfjx6e6f9U72BtxA-XEIBp9cHgTf_lwsB8maTq2isE
Message-ID: <CAFEAcA-qbSEFD6Zbw3UcU_T1joGcwJrRpceat1QLqsQQuhVfRA@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] hw/arm/xilinx_zynq: Add flash-type property
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Read flash-type value as machine property and set the flash type
> accordingly.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---

This hasn't changed since v5, so my review comments on that
still apply:

https://patchew.org/QEMU/20251204093502.50582-1-corvin.koehne@gmail.com/202=
51204093502.50582-14-corvin.koehne@gmail.com/

thanks
-- PMM

