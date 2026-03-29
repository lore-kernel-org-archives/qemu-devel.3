Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244EFF3D5FF
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 12:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6pJT-0002Vh-CF; Sun, 29 Mar 2026 08:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6pJS-0002T6-4z
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 08:32:18 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6pJQ-0005hd-Hy
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 08:32:17 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ea73e7b60so4390221d50.3
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 05:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774787535; cv=none;
 d=google.com; s=arc-20240605;
 b=MiTzR9LjyqgU+w9Iz20+TSZ+qH2s8DH48u+tKJbs2ecUC9bu46zX+Kklu2M0UHoqpw
 NavnkIVm9LGIZEr6CPXAyQbTGKRkaRBQh4EPVhlBOcye0Pr5O9b0igRTxI0tlYXZMPpC
 HH6ghy1Z/Utkl+tjlmM6XB9oVLg21nos8CDbrxD5petqXJ4ODJyM0xV114EiEbVGlH8Q
 rACa7AEggu+xhL2pnD4LkejM7sRiv1oRmnFN12+D+uvFYTgPUHc+S5oe1DDriRiOBlXW
 nQMKo/fXOdgV2qRpf5SPFBvR42DabdzBIIUp0FKoViDUmaxhALyaCSVy4/U+R7sRbpxy
 xOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MjG+DFEPRt9SmIPKJZSw5wGdjCQImeKH7mCepcevsAM=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=WnYKo+55l/bvDB2crw1LdBDfFz/uHLoJg0yz1t2V0IM9Tw+4qDxreJ6LXIC3c6hRXo
 5DlSg5fFnLNdiaysKWGSCdCE0s0AtjkBLtQaQNhrOSfQ02jyqRi4NYDKtjvxJp0bBZXW
 FvX7c0Ldu2uIGrbW9k5jsx/sTcRFOH58sobQzf3XPyPPBREp3Lgep9c9Z+v6gwJTtfxR
 AjEqH4QIhoSL1gQBRnwVObz6nH+webevnM8DRukWXdr7A1O2FkvqR8mF95yWWlm8htgO
 H0KEOdV+Y0Kgrw4Bdfr5kLq1QSalAPVvpIHIb57YtiBfHEwqzbN0J+a5RbUbyfAPfw7s
 HcWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774787535; x=1775392335; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MjG+DFEPRt9SmIPKJZSw5wGdjCQImeKH7mCepcevsAM=;
 b=bOaiJsmOFtVbCf2HmYReHjq+8n+KbA2j4pgtbU+D7WJ9gF8CjsCie9KT2NHRGfIuoX
 ItJoPUBZxwjOGDsDFpLRm+VOV10dCgUuPSV5rCoCktt5qGE20SSMpcZW2TQgdn3QZV4a
 6VQnWf8MTdAAWL4Ag1QLwK7gBMuZI7Jfq5bBOVaJDjDLJfhQ0Tku0PoXxVJ0S6OFgQtg
 W/6XtvTTOmGs8qpRG0G0CQwWYC58sixbEHMMPeSDuNACgYXXj0KdBkVwjGY9pgRLEJxA
 iH9GyTBOeNhZjT4epFnw1blwGIHnyvdcyc3XxNJ1foRdAYC9AWW/kavhy/ikYDHBDzri
 yguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774787535; x=1775392335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjG+DFEPRt9SmIPKJZSw5wGdjCQImeKH7mCepcevsAM=;
 b=Kb1rRnG10lkMqbdbEYfm3ppFOzxtevDzfFY5mo5reoQFMbPhOba3eYTjl+eUqwIAjY
 dOBkSMkrtpnc0AmkPVa1HN1p4074bGlwAyIfegEC5bttOtqgffqn66XCr9folSk76N3e
 Dfa0d+WjsWNu0MEYo7RVxgTPJUUkcS4GHUWqy61jvWEbmdl8XoNUbZqZpT1wPJt5LnFx
 zXHHXcb239jZHRblwDKQP8I40ORn86y8/9dSek6kmiWPEiyBKH5J8inWNwunNRn0+3zL
 q34aioIZfjUvUo+fgkwNxVAeumcJVyv3znC3dIJ9jm3wcBhSqDZwpVAlCWnF+dOrij9S
 VtFg==
X-Gm-Message-State: AOJu0Yz4+7ZB6zCnk7GDpdKP6VWG8lWH71vBkD4uNQ6Tw5N4YChwICe3
 8Tw9iyzXTZyR7jv1u3u02sFrhIJZ39KoOcusttbR8sLJwdfdjjEjCGA8/WXgmVgX1XlNYxaQBhy
 Tgj86/rmSe9sTecefGWGT9e27b5zp/d9dfO/33cnuFHB1K1HWfguPiu4=
X-Gm-Gg: ATEYQzy5U+JgqQv986e4BkC56D89w9yarJ5O6tqkYNxDThE9BD7hrLKxyeMU1L+3zN+
 Xc+425uXia13v9NC/ovNrFiSRW0k80io03iORdrr9MdVvqKGiWJ8K0NCTwUECiuJamT/M4JSh32
 rMuiEPSvS6kXN7HLri8kjcgKhOGpOtxfv3e7btMsyOO9MUhMk2MENFFA9hcyUrDMJwN4Q/w1yDz
 3w3PYodSInF6T20JdunIyHmbLMOW2rFpYTfL4AsDyhLFUMe+KNcHjJH8DqTnj47dGeBRoaOFX/D
 wBCOjQbfijlPucFsOurpHxXNzPPCbf/7iNmLsK3cgJBOk5RPDb9700wUYkAzjWy2PIw=
X-Received: by 2002:a05:690e:4814:b0:64e:7d41:29aa with SMTP id
 956f58d0204a3-64ff72092bemr5697968d50.25.1774787535058; Sun, 29 Mar 2026
 05:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260327182541.691078-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260327182541.691078-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Mar 2026 13:32:02 +0100
X-Gm-Features: AQROBzBoZsUBkOPdO5kSiY04KNUgLx73308bmtAWdFJpXsahg9qUjD2Xsc0zkTY
Message-ID: <CAFEAcA8ttmbdVNoCVF8_hcO9ugSD5uLytYiP6k1pHe-mruP__Q@mail.gmail.com>
Subject: Re: [PULL 0/1] docs and tests: assets moved after GitHub account
 renaming
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
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

On Fri, 27 Mar 2026 at 18:25, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:
>
>   Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-gh_rename-20260327
>
> for you to fetch changes up to d5a678c87c4d70c1b5ec4397f1daea7ff0186dc8:
>
>   docs and tests: assets moved after GitHub account renaming (2026-03-27 11:25:02 -0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH] docs and tests: assets moved after GitHub account renaming (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260326214436.256215-1-pierrick.bouvier@linaro.org
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

