Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57839109319C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3W4l-0004hM-Rm; Fri, 20 Mar 2026 05:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3W4g-0004gr-LZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:23:23 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3W4d-00067F-K4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:23:21 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64e8c7f5082so1529952d50.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998598; cv=none;
 d=google.com; s=arc-20240605;
 b=VZzBFRGvSQPrURiRe4ZtcpZzf3hSp91Cb9QR2AltRy532d6GLohaH8g8l+RzmAiAnn
 x8CQbVdu+4VtQR7NRELofxFhRXWR/OdALkiLHwETRAWe4j1U9KWURAeto2rZ7tMu20UY
 ErJb4dFmJvBstAn/13UiPesUhSKeVAtN5EbEFhRI2JNe92jgJI9jSfxEdsBSaO+WKIDV
 SmudvSzgjeAGRdjF8EQgBuhDZgovbhz9id+8GyrzekWruWjf9SuLCrtughe7cmXUhjoM
 jWnb3Iz03FWdZNmF36qF/KG5zzhTOovCVhonLT9DZcOusEz5i3FAMlKIWxlCg2Vycxt+
 HlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=889y/1+kK2Rt4+IKXU5ro8R8J8oU67KfahHit7Eylm4=;
 fh=PzbTjfSh5thByvES80y7/ymjUitiQ4VIxw4ZoPURAB0=;
 b=hRSLEO6EhasPF9ADor/gxYO3BVUc3AClZMrI2ltjyJHNp8mroIh5djdIkB2E9YVdwN
 oxIWWjk9PTjDixf+eadKAGbCzIgSjcVpdpmPC2QydQFmNnATYFaPIxIxBGUq7DyDOhZM
 y5H5icQZV2s+R3EQzbTsF3a/aj0ixJi6H2gYDZfaQMY/YtF9Mh8q6QZDYwPuVHfTcsHG
 OkMfvLXQ8U4Hm+KjGqkJ5vRxH1Qj/fPPREod3VPQvPwgrdKiRgkE3/oOhznIRFBPBMHq
 ouwsptr0DVTRPJxtKlEv95mfJdoNFycy+MngSMgLv6Np4cw8I0qIw/32qdhnEN+2Amhh
 Lzmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773998598; x=1774603398; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=889y/1+kK2Rt4+IKXU5ro8R8J8oU67KfahHit7Eylm4=;
 b=C/UMzzUqzoSS3NkV80RTALNs7fJ0aOgsL26wJKV1dM0YMMvRCM3KCS55Z/59Z3p4z/
 PBMsysJYSJm/plPGQzfEGWaHYzOV8Vwiw+eK3XgcncouOxFXN4wokiZxf4k7BkEoWA0U
 C8DWYzFlCice+Urlbz7DljZit97vTJZXiznXIOPkFgwlH6G3Ubk1SV0TOBry/7wTL4vy
 1Jgi94OY0LS9Mg+0sohIp5amQv8SFCnyfHdwG4qIBfT7iye3dRj/rqD6S2iAbgOMygdM
 N74rc78+2EnZFIBSTpwWz6uOviwsP/UyEm7y5egkBCVoiwz2eZpQLoZ8gF/NaEMwR8xW
 LVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773998598; x=1774603398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=889y/1+kK2Rt4+IKXU5ro8R8J8oU67KfahHit7Eylm4=;
 b=Lo/8czqKYZWYS4VauguMabrCmNhbYjNmvRiy+wTgZtsqtkZ2Z/UzMRDZ+q9QVllT9U
 tKSicuMz+eRqcvMjNJ3zgnXAfJe+3SvoFf+sferD140zvRtUCvNOvXg0TuUFNGTjSlAW
 WVk1G6lb6wZ+Pk/6YpWozBmp66q/kLXVu7LNkPRcNjEYkbMUdsoY34xQso4q87NUeFBO
 47heA3PHYVdIZghomf7/BqiGedsOilNdosmMZ6zdKFbeUIySmPcwGaeQLma3q3QHW1ll
 XG7N7M8i3A3dj1EQVbgXZr9JsSCmHgeXO5H8hHdNkWy59M2ZcURq7NLW3QQqyXsC7HYC
 CkJQ==
X-Gm-Message-State: AOJu0YzO87kMzpM0KdNoPRBki4RTcanPR+NXcmAHA/ATQI65Am6WL3L0
 +ZCZH8Egeqx3vNDFYHL+tAW6gbKo6bv+mK/cISxKEhBQE5o4G81IwfcbOM3lVpc+W/f3k8LKbFo
 I5UTHgVl7VYPPWfxGwyWRzUzJbU5Qy914/Rt5UjQgpg==
X-Gm-Gg: ATEYQzyRavaxFal65ajAZ4E5/b0D0Cmk0RgZvlbHKJDPhjZ/iiFrroeE0rSIZvjRvi4
 pxdZZr/Il3UzPZdh0Fq7qwsJHcGFKl0ZFmFUirCjPr0S93Z2FJ26nrig3YneOs8uSXTXAiuZfSw
 6O3wNUXoXrEeWhLmUfuZdu8CH3LxtzrZ7uChryzwjtAoJpJS4roEXwpD3hD9/AYH93a58AlWWVE
 t09hwSUZTZxfC5gZwL3VaevFaiKQrx/WUbgLc4n0i2GsMjBaoSUQGRz4SqzvbVdY9MO5xAw5Jkz
 DWYUStbNCDquhlMQbULIc2F6b6AnlBz38IfWLu4gtePJ7vTBgHWUkorlvFCZmtzJ9qg=
X-Received: by 2002:a53:d9cb:0:b0:64d:10f4:5d2 with SMTP id
 956f58d0204a3-64eaa798675mr1714916d50.43.1773998598376; Fri, 20 Mar 2026
 02:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260305161739.1775232-1-peter.maydell@linaro.org>
 <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
 <CAFEAcA9HgVmbe9TXGOZW5Vbkvbn-Dvah24f1oPn4zvymk=_mZg@mail.gmail.com>
 <a38b768a-3a80-47de-8a03-11faf2b85526@linaro.org>
In-Reply-To: <a38b768a-3a80-47de-8a03-11faf2b85526@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 09:23:05 +0000
X-Gm-Features: AaiRm50XFRMc4WmYdJrVki_D_A3cIp6I9e5NtpXTM7fOCkthArzFTtHHoSGh5KA
Message-ID: <CAFEAcA9dCKF0H=MkNmOmxnfyJV+SeHk_tObL558MJ-w3w8aQSg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 20 Mar 2026 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 3/19/26 22:27, Peter Maydell wrote:
> > I also note that for the data structure I am fixing, we never do
> > an xsave/xrestore on it -- it is purely junk unused padding.
> > The real xsave/xrestore info is elsewhere, in the dynamic part
> > of the signal frame.
>
> That is an excellent point.  The structure you're fixing is never really used.
>
> It's only use at present is to be included in the ia32 sigframe structure, and is only
> used for padding.  As an unintended side effect, the alignment of X86LegacyXSaveArea is
> inherited by sigframe.
>
> Perhaps we should simply have
>
> -    struct target_fpstate_32 fpstate_unused;
> +    char fpstate_unused[sizeof(struct target_fregs_state) +
> +                        sizeof(X86LegacyXSaveArea)];

I did consider something like that; from the commit message:

# Replace the use of X86LegacyXSaveArea with a set of fields that match
# the kernel _fpstate_32 struct, and assert that the length is correct.
# We could equally have used
#    uint8_t legacy_area[512];
# but following the kernel is probably less confusing overall.

Either way works, so I guess I don't care very strongly.

thanks
-- PMM

