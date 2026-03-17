Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467E6FED9E1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VsR-0005O2-Vl; Tue, 17 Mar 2026 10:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2VsP-0005NV-Nf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:58:33 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2VsO-0002I0-6x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:58:33 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ca4dfdd88so6065743d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773759511; cv=none;
 d=google.com; s=arc-20240605;
 b=Y1MN8h84kv/rAUJOnI1npKM3HF2OmMr2YhAGXlWbDjFNdc0+vCoh7Z8/TcWxXsGF1u
 mw2M5OSnAJ9GLlm9glGxc02Pr6VY3EpDW1+h0CRm2nODfLO0/pkilI8Btrst1Rlu0Y99
 YxPoDP0492TaK+AG0B0SXzT7NPsrXrvTbKtPR1zi1YJZbq0jPuz7camTG3hW4Fs1tq8s
 zWNnvujI/gUp4rpEuGNj9NoUaBjpBmU6W9NtuWx2nSNsnOZ21WvpEnYesYz/qUaHbh84
 22QSQZSC/GQfivlCCxspFZ6kQG0m+QHDW0AFvfFt2pa0nDtPcd5UGgfKY08QrwRcX59u
 rUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/k4y7W6dQfhRkGaokse85tOQ7uuVOpaMmTzk1YghLk4=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=jmeNd/Gr/Ytuu5+EbIYuE5DRNd2Trx9z+rBIUK6Vf3NeVCJqlnPBdU+AUaV70Cv+MS
 PWbmbNdgGgn7Ro2VBM+cNfM0mqAsxlgPahDC8pJm6hz7bi7EvGEy0D1H6WFxnF/3EgNn
 mqaa+JbuE2YriBKI5uq3koUFzi22jlBGWp4MN5z/pGdSWDEuMH2fs/H6H7UhtCxDaZaf
 CxO/gLPJ0VYctn5/TSeiw3fgW1/7+dRb3vOgL7X62oUUAtlRRBqY7NczctIzf+cboQdR
 /iodFI1CvI+2adUx6TEEuwrcN+50MX5KTrEvygHSxCbJO0UwioA8RnsgXhTrKqXd88Eq
 pgdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773759511; x=1774364311; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/k4y7W6dQfhRkGaokse85tOQ7uuVOpaMmTzk1YghLk4=;
 b=u/vIaS0a5+Anlo9J9EXcEQ9gSMUIMmVrAZb1BS6LSaa3SYCLONl9Y6EfZM6Bv27QfA
 VQZoNqVlvHKcZwVRRO/l8iGkOZ9iWgbn8prV1x4ewETc91oFZfhaC4gRy6gLheBOb/0h
 1LcdhIlt+1eCPoiQrIUdDGQpr492AdYFkyJXkRydkJIgqbh+Jy9Ea5Vr34+pnG7DyH6a
 l9VRigk13JFEbxCwrMbZIVp1lenREttr/L9fZQYKDP5eUb4JhhZF/qTCMTqAc6koAsff
 BzZyJdUpydXrK6gyiOYjz4Ho1/x8PjWQ9puW/qK2qXgv79o5fUGSatGlnoCoLgavH2Uj
 W5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759511; x=1774364311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/k4y7W6dQfhRkGaokse85tOQ7uuVOpaMmTzk1YghLk4=;
 b=bj9mYp2HwhHmcTIvFvUj7nlWDBhU+j4SZcHWJgvMT4gEob4cd3KK1qdYOhwZdxx6gf
 4XeR+ct1CsugA5zO5UEr0+dchq6pwxuhmqZeko8Ecfl8kbQQ5jeF470gECwiTDZ6YZP2
 q+K3zgEbVrNR/0GNIdmTFwE/Awqmf5LvuZGlVHjsSxm/C85d0R496JPYQ9dbxjggm5Ge
 PKYt0fROxWEM/CYMTV/wy+UVfq4Tb3egulBH7IcJSl3zdqSI3BZU6abVBqjn8u9tIJ09
 OJAr1/PPO4f36XKpLrShUxbk7IByalYQr9/JoCOnFv2GaLDbv6nQ72lM+eNkYEM+CjuO
 C0/w==
X-Gm-Message-State: AOJu0YwdAaXFVT6Fkyhz0+92ftpG9TPylUWRThA/wR5Fon/QnCA0hwZO
 YwqWAjvRDvNqDN0yMTU49RPa9kVDgkfiWBrW/qSxqUSjZEAFz+LkIB8l8CRZwSfg6PUEcaOg8eP
 rSPq/ZCu1vvtAHFWMNRXUmjwI1wju0ztqQgISdroZQw==
X-Gm-Gg: ATEYQzzNcMhJZU/0dzpnuLdlotS87y8dR0kyIfzwGh2kTWc8bma2a7FhVaE4ULPgTh4
 zEL++WigG3MTkCaaAxYQCeNX6S5vNL2Yvkj0lZGVlln4mrOoBPs6bMNgrOlLALO5855QnNoDOdS
 oOuAu/IpLgmhDyc4ffT6JapZhELGRpEP2u6P6ZfUYQ9lHPQP0rTdbPzHvSRIxbzMIB5i3FgNKBE
 hD+vFzKFVWS3JRtyFPQeKxmpEdIc0QUrHPC0OjEFmEF/ncbbCZqBTx9qcM0yPL6nG8aDXMbfuN8
 tYT2qcbrw5dtWmDOV5Mjce3NnRxpBfSKFOoZ5li3mIgxlBySftNRLmY1enQ5qgi9s1I=
X-Received: by 2002:a53:ecc9:0:b0:64a:d479:bfbd with SMTP id
 956f58d0204a3-64e62f58a9dmr14243533d50.7.1773759510635; Tue, 17 Mar 2026
 07:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260316232016.455394-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260316232016.455394-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2026 14:58:19 +0000
X-Gm-Features: AaiRm50M7RN1UB7WYcjyfGHAeURuHMzDZjJxBqZhbJo4unRuXaYC3xnHMlnG59k
Message-ID: <CAFEAcA-OZy_aqrtSZ=CHDu2jcV+ZAh1ZZO86U4cUrsL=39f+aw@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins update for 2026-03-16
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
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

On Mon, 16 Mar 2026 at 23:20, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260316
>
> for you to fetch changes up to 48221e371686f7704f150aafe46b76bb9306c7b6:
>
>   contrib/plugins/uftrace.c: fix depth for exit events (2026-03-16 16:19:18 -0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH] contrib/plugins/uftrace.c: fix depth for exit events (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260313063441.2048882-1-pierrick.bouvier@linaro.org
>
> ----------------------------------------------------------------
> Pierrick Bouvier (1):
>       contrib/plugins/uftrace.c: fix depth for exit events



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

