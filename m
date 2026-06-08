Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D1CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdwt-00041y-5U; Mon, 08 Jun 2026 13:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWdwq-00040u-Fw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:39:40 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWdwm-0004R5-Rd
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:39:40 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-660390a8999so4978663d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780940374; cv=none;
 d=google.com; s=arc-20240605;
 b=d2iEapflNao5RJAvLRU44flYIe0Np1x2BOLiAUGbnBpM/OFoxKb0jrs3LPQfDO03sn
 jcTYsG6YMv/Nk/+iZhgI3SRJfyts7weeq7NmgvG2kSaLOqKj/ZbRPHRcg3p8NJS5nUfV
 S1KWaQzku0Su/yK5a0SmQTKyBhL66Fawanj8QyonNn6A6Iy9EmKGZHjaGcd2c13ABSMA
 rm9ky9VCFgogQ5dUvhTsyAcWzIVSl0OyH/7PlJqVkp1def4iYLUHaKB76ovu9t7S5QH/
 jqrQZ1lfXOSJtprsJlqNMgiMGlniQVpVBbOMDmjVtT6EFBcDyfBgms3MdNaTCICm7ea1
 FyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GDfYjN8KryhyZHcjZXVEHRFOSjSPzrx2RbSq1y93hUw=;
 fh=SZDMjL+lyo2IEsJMuBcLhU14FCntnjYE2dO2IsQoumQ=;
 b=H3I72+YTmXHIuvpxod/QDjg5QbI0yUOYwcwwvJLI0E4lKaB7MvGNCepa95oGo0BXEx
 OaaXseA2m8A4sl2uRvoJZzm434y/H1j2zER7rJdB7n+xzGkigRrWmLZH23SSrj7mlGZo
 ZVdWgQAAH0HKo9R5fORaqhfrLvm1bxJthkWI6PBckZJ4jwOiD8bsi7TzOmm4i2hEpUpQ
 4pxMTWhBewgySMFM/koafGE1orBfhcfqkgn4XVG4hbUiQjHmKcqdi3sSQ+twyWi8HzhP
 +egfKwa+ViI5xXkUp7NmLRddcDSJY4ToER79BztM6xsM0eJvFMG3/IUF3INslxp5FgIz
 L89Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780940374; x=1781545174; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDfYjN8KryhyZHcjZXVEHRFOSjSPzrx2RbSq1y93hUw=;
 b=WwmWq2YBZYFBMQ8nnz3LwHd3v1wSqVkS7EJvidzt73jGDc0NGCCoCWnDE0Z0FhPHAp
 MI8JbQ8vvGrQIr8/3OoiYGOlIeRaqZxn49SQv6mro2C1rzp+//45C0PXNQIhI8/gG0Kf
 DUUNSW0oW5YRBKHpWhIwrWknr4Bgzj/wd40F+3IIz1PFrll4JMp4NWu2ZMbsr0lBJ6qv
 puiBLMfujH2CFrs7w4H55KhZ66YGZFq/z+aaZuxVKNUFtfpZAOw3kpfKU0kK0SClUS9Y
 cPRrmavKw5mjBc1STeDeuTxdPl4P2nePmahvFHT6z6s9Gg6+rLiZuEmsWnKsT/biJgAH
 vHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780940374; x=1781545174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDfYjN8KryhyZHcjZXVEHRFOSjSPzrx2RbSq1y93hUw=;
 b=npmgAhPk3PYs75GhF/hQSGJJQD8A3uUX46Jipo5+YNHYiJoYu/b9iR9xlw81euhtkA
 thPCDvxZ4miILv0c4jC95OPN3YuMsxOP/GDXuW+4WNnSj9YYCfdPzrO9F/Vew/E2Uapj
 sdtrqaGatoS2Mr4Pq1uzG/bFcSVFXmDkAveKhgBwIC7IEdFobjag6i3Xs3S+Y/upnack
 T2DQiuPoeEMDXKCRUozMoG9QCIOROyywa6VKyhhez3vTHTgF4Ojx2a5Sq3zqYxXvxWaa
 LcJr/+H4egl6NOp1/lYfhAKRlRWVEONK8fV1+tJMDJ54C4HAypRdpbvtPDUX5VAfDJyj
 VLjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XiCVlXmjeTTo3iH/Y4DdSIknMdOFe7APEcnYJ23tMKckR2DvQJHpBF5BUjtUH3A0vl8fEw57f/Yqj@nongnu.org
X-Gm-Message-State: AOJu0YxT4edJUReMmm/fv9XKpgWNCVGQSzc/TBdfibJlHix0/as8YPdk
 s90ysaTb56frLG/eCYgxOFA1rlc8/G7PbeFuybu77uY/4CPh4klW63og2gHa5g0K8WB38u5yJ7Y
 vLnetwbFZWGseJZJENsKi0cIePzVPwhiRQySVhbpUnw==
X-Gm-Gg: Acq92OHzFbEpclY0/sOYPV3iuPQYAVgLG/2tMHaa+9Vm8OHdZr8+J6IzQ6Jdv/YDglG
 IGLATOZ0iI0U4uyjQWyXaTjnnXE/G0QPpE8/GmtMvuxzw3Yisz1wzSwz7T6znjNb7PBVtgmgX+b
 vSbARY9He9xdVU+AxSvH1zf7/gZ/Ue3cI0kNalyHXHNjCO23U49PpvYVQBeUCZfYgVp4AEBUK1t
 Rx4VrmISujwkK6eGEO12omgrCgpODvimtIOjfvdOqRT/K6+RNfJhlQdcPg88mxlNTApWoCvmqS/
 ko1B/y6GK6G5wNhioqxrjb2mkN8b7cpnGm6/qsWJbs7OKC7Ii3Gf8FRd0eQ8D2vwWe/vMo2qL3w
 dHA==
X-Received: by 2002:a53:d016:0:b0:660:7b47:24cc with SMTP id
 956f58d0204a3-66106eefe0fmr13386229d50.1.1780940373730; Mon, 08 Jun 2026
 10:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
 <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
 <aibhMPHu6nbBT3Yi@redhat.com>
 <CAFEAcA98r4DxQbB+yiWKqnTGSzps+GGQ3gxFPLogBGTXY77jXQ@mail.gmail.com>
 <CAMdbysh2-mjxmWZcfDw53UbJd0keBtTgO_gnGc6pPMzv3GOPDw@mail.gmail.com>
 <CAFEAcA_WtRMz93Y7CrGW0PDTzoA+jXtY-4e0AgYXemCe4GG6RQ@mail.gmail.com>
 <87a61b17-7200-47cc-bdb5-e8763c6c010a@oss.qualcomm.com>
In-Reply-To: <87a61b17-7200-47cc-bdb5-e8763c6c010a@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 18:39:22 +0100
X-Gm-Features: AVVi8CdrM4vpNLCc-vvFa-krgY7gsQitnMDcw5LT7HdKeKOJphyQeIut9DuPcXg
Message-ID: <CAFEAcA9MYxQEF3EDgFa==z6aDtwbHZGMgteKbj-YyO7NsCU6VQ@mail.gmail.com>
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Emmanuel Blot <eblot@meta.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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

On Mon, 8 Jun 2026 at 17:43, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 6/8/2026 9:08 AM, Peter Maydell wrote:
> > On Mon, 8 Jun 2026 at 16:57, Emmanuel Blot <eblot@meta.com> wrote:
> >>
> >> Ok thanks, got it.
> >>
> >> I need to use `ninja -C build qemy-system-arm` to generate the signed
> >> binary, because the default target only generates the `-unsigned`
> >> version (I guess this is the linker's default output, macOS requires
> >> an extra signing step).
> >> The signed version is defined as an on-demand command which is not
> >> part of the default build (`all`).
> >
> > Right, this is the bug that needs fixing. The default target should
> > build the signed binary.

> For information, I recently offered to Alex to do a rewrite of tcg
> makefiles in meson natively. It's not the first time, and certainly not
> the last time, that we waste hours/days debugging dependencies there,
> this has to stop.

This isn't related at all to the TCG makefiles, though. It's
purely an issue with the main meson build files (which is why
it's shown up here with the qtest tests).

thanks
-- PMM

