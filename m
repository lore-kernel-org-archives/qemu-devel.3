Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B983F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iTc-000818-Rt; Mon, 23 Mar 2026 12:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4iTb-0007xG-AV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:50:03 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4iTZ-0008S4-1j
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:50:02 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79860421382so36935657b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774284599; cv=none;
 d=google.com; s=arc-20240605;
 b=RQg6Yzsl4KGwUpWTa7JJ4tp60xqSItYr46vwA0yJNUwnhmPBUjAO+wVldeL6WfKyRG
 fPGr2NErRst65xqM1NoznCUQf+YEp7lZI4GVNxmHa6AF3jV44u1GmWw0bMkF3irEaz3K
 xMwERCDXZR/hoEMcykZSLQgVA1iwKB0eecsrDZGJ2w7i58EIC7TZ2m7Ogep3eyYJIDnQ
 QiimRz5mWHYE/vOrZzpt0Rb82Ci7rsAiZtyH7BBumSKWoCRulkC7ZucPAqmo62+M8l9K
 PTBAjhShI5iaNov5hsntLsFup/DjaO0NWSrT14+bXmTjMGIpeX0bcI4Hpvv9eHFknhnt
 iC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+NTKtBdRiB/NIe8g1z3Q4L5ewXm7sCohkUuH17ncHck=;
 fh=o9NNXRRpR1snqmakVgbq3eXDVCQ4hGFs6Xd9sNLXLEI=;
 b=kS6JMKEyFKJhqAHSJMIo8F2P4EpaB1NahuGrHAQ6sYYe/IhywPrLeatLWY/riJu26P
 7eWCAOBKTr/BAmmQjObk0nDe2nBfjtbEuGzs6EtT72DSjHRIeID1N9tL6axD+t5IXgHX
 8zLgLLt8hy4SHN715C9x0SzsX1P7zzC2VZI6cr9G/4f7NiaF7K7fllm8NGnHiXU7EK1e
 hs7aSQ8xD1SWB/RGwtkHgRU5iI7wWsR1h7qmIp7SnUO7MD8w9KDP+0PFedikwhLfLguM
 psBjRd0bOKOW7SPc/mHNI3Fa2DyFt0vcaCXty1JPC/m4OoQ8eiuKrEs6tdwbACxN0mFY
 72wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284599; x=1774889399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+NTKtBdRiB/NIe8g1z3Q4L5ewXm7sCohkUuH17ncHck=;
 b=q6d8myzopXfp0FhNpdFpP5NBcrx4braVagIsdl0BkmwqQtwdnDhpCl20wwtPbVpox0
 9fplP/Vt0VOQzskT/fJ9vysUEtu2JNz3RsCOZr+gBqiDE8uHUApMSRtZjPQD+9a9z1/4
 2BhNi9qrvbF1cxwkwP4N+Nhblk/jbig32oZyW1zsgJyIY8beq5fckLsXQgkUC+aDN+bb
 LDtvm/A1/wDYIgqBwQiayxZG7JDwdnNPaLCHoy0L+COq8DTADiB2L4nPdN+K9YFszKNg
 1CIIW6D8c5/cKjMVMSZKbp6V5mutYF6eWORRsA9c7gKaDrpFB9jHi5/BHTRthtJinpxX
 mvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284599; x=1774889399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NTKtBdRiB/NIe8g1z3Q4L5ewXm7sCohkUuH17ncHck=;
 b=pKIapTImtwbWUlEZ+/OK/mQ/o7KN3hpwpkMmMiCLU/NciLEwQQBcjPtH0ftee5gbdH
 T/AdeWIgAUdPZQfl2WFAAT9FzlcZ+X3G1IZGiQMJKugQx+eLy4oiAeURXPFfi5waaWf5
 QIlwvA3sMYBko9QsNLxTD8o4+zFS1FInRawg3JIYCbWSMWV543vdPWvK68hmPQhmMkMN
 kJpsoI+fHDCiEnhGDK6wvI5MasqE1P1uvyrD4krRblFn7xF8BO0NRYSaw3rr+UjN71Ff
 jK8nVokmI9PYEdtmv/rrwesNLwlAiSPQ/nAkkqAEU0GwrBXYS+QRIOQnH4ARTlO6eBqr
 ICDg==
X-Gm-Message-State: AOJu0Yx9bVCpqhwL+uKxR/M1dAzQrLdUrtaIqkKkqZ3qt+CxIPTodB3s
 dkIKcEOiEUL4QZXjnqAQpuDXOIdh0oSWi3Jqtt4ctBFSFO7+tI5/aWdqNLTXzgCwqizvEL6Yini
 r25oT86eVDcn6K7MFCP3SfePm4SxYIUp9ldVDXO56Sg==
X-Gm-Gg: ATEYQzzn/HihJkC4vV/69SBHbAVYXowPvesS9btCXDN0KHZHciyIc4PWwiMsOWsHSkB
 eFX7GPI1Ry4Krg8KlaTB1tibJ25Hgp4YAg1Lr8epgeSZCiQLc1Y+iwHYbcFhLA3b53IKT0RaxIl
 oRv7wHwJe83tSWnCNaTc3QM5W07ISkQI2IqDu4GWgmeNm/w0BSO+JGx6Rdx3F2ItgPjQmT2cYb1
 yOo06PIflC9qV4bZ9Q9tfRhhZrgNU0JMqO8ToNrNOumemzMe5siIEEoYE2HTYZBOc5BaTG+VXdV
 tLX2HFcKoNbIh4HIobMnU5K3xPhPj5SQYxRfELP4KTMCfO07xs/X7E2SFZ0liiEJupU=
X-Received: by 2002:a05:690c:c4e8:b0:79a:349e:9548 with SMTP id
 00721157ae682-79a90aa06famr132032577b3.3.1774284599162; Mon, 23 Mar 2026
 09:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260323130021.376393-1-mjt@tls.msk.ru>
In-Reply-To: <20260323130021.376393-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 16:49:47 +0000
X-Gm-Features: AaiRm53QNJFZrgIJRavRivKwFy8aCFyqP6xji-6XVuREtgnoYRQOSj54Ee71cNA
Message-ID: <CAFEAcA-aiqsMZv4-8ULC9YtN0uhDGLAtEO7donf-a-txE4i3CA@mail.gmail.com>
Subject: Re: [PULL 0/4] Trivial patches for 2026-03-23
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 23 Mar 2026 at 13:03, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27:
>
>   Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu into staging (2026-03-23 10:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 8ef2576d32dcabc3cfe9abfde7c23c1587444584:
>
>   Fix several typos in documentation (found by codespell) (2026-03-23 15:14:34 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2026-03-23
>
> minor u2f tweaks ny Stefan, and small docs/comments updates
>
> ----------------------------------------------------------------

ERROR: pull request includes commits attributed to list

$ git log --no-mailmap
[...]
commit 8ef2576d32dcabc3cfe9abfde7c23c1587444584
Author: Stefan Weil via <qemu-trivial@nongnu.org>

and similarly for the others by Stefan.

Could you fix and respin, please?

thanks
-- PMM

