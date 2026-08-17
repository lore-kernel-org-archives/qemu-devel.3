Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D88EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyxc-0005pQ-Qq; Mon, 17 Aug 2026 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyxV-0005o5-IL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:09:06 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyxR-0007nV-Jq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:09:04 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-836cbcd0a48so46027527b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979339; cv=none;
 d=google.com; s=arc-20260327;
 b=lGAGLDPvn9OG7Ka6mQDTM6Zo9e4eVVcKUl4EOCS/2m65eWz9YNY6iWdK/wicg/s/ga
 nhJb8sHNuVkbSRBi7EZmWwiq+y6w4plxOMnIvPWVd31ACu3/CrujuHp11OhCSiW12U+h
 9mMl1fG7OcuqFHXRI89b+wCSuoYLeTLE9kZuU6bPaq4+ym3nU0TloFTOfLetbsT/eop4
 1C3kcjJQRoee1rVNZa6Af/gINNwMivy3jSOpWlwsOjwPKPK04/pZNxzQZNl9RQE9ZSpw
 TfHeK9LNGXeX33fwonXj+XQfMfB8zjSszPgan+VohHFHOMbF++Xb/oZYSY3XArAPR4DN
 rbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CCG+xxSAoUzfQJn3qwYkPMMhQLP6vX0/ozyibhEsBus=;
 fh=vE9mroPCwojMeyL7Rki+gZ+2836oHAtez0oUCr4h0qc=;
 b=Scvxsk/a0qU7ZcPasqLS5fzcr9grEBAxK4vl0wQBbtpqj7V9jIDVzIeZSbtziAbj5l
 jijSNpBwsPq4fqIs5bzmJ8kqGwxwD0tPtlwhDRM6ef8UQwB/iDvOjE0BXpw8ZzJ5qx+6
 OjMEGlVlEP8YwQtSWyE5W+j6EqXskMtMXgrAyGWOpgMdMNU9+5JN00GLmbzSeAGXASBR
 ODVZDIYT514JzGcHxLzq2ZWiUartb0JH/fM5EbQ3SrEWSpGmARGHz3iunRq7dV3oQANN
 4WHrkxbud/9dq3018QnGD8/ahJFU3Y/wMyRReBVy16XXbnsB0OJuTHtwfBmNWi4pGg02
 1BLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786979339; x=1787584139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CCG+xxSAoUzfQJn3qwYkPMMhQLP6vX0/ozyibhEsBus=;
 b=VsY1P8USP8V4I0TVWMgliyH2oe5TNAsyukENiCAUMEmSb7YPilkIWOxMknz+aTkHLC
 Wk9NdwhbgYf82VWZ9YreEkjQYRM93pwpV2XVZdeFTLRM2GRLmHhBAUzKtz3pxzkEjLbR
 LnN0ScLWARrpOT19U+L6maeuXByJQbpmd+K0llku2pvyxDTwnjdin0Io46n2Lbwrhuqj
 /dEBBnbBNFWkACVhdTG/XakgkqAUVgF0DKQ6sFg0o2MbGIRjNXPadIHaAG207AZMdcvz
 f6sfqpsZaPbzDe5A5FimDEcxNo+HfqkVRXnDAthWb38KzoQiL+YMaMW+D+Sy4udaaeh+
 njWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979339; x=1787584139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CCG+xxSAoUzfQJn3qwYkPMMhQLP6vX0/ozyibhEsBus=;
 b=ZqI1KYGu6x9wyPYf6t1780cnpCdGnBIbfzhTEhwzfg1au16i8KvLNCfrM5SDks71Jh
 BWCd//9Inb3m1g9XQnzFMJxpu3eK2h96CDzVPy1wjTLvS4k4bPG0YWfdZud0uc8MvPjl
 xXU2ZYkv6d4FUx1831j06hckDHxyjVaVihf4wbbiTLD9DTMjGJdhw1Tw29zvSai99RaH
 QBK+joNcpR9GIux1Bf2s5z7pKyHFuZzCTKhKPzhqkt+RGlEVO6vtAwzDzPWOXH9yYDlc
 C7nKS6uCOdiB/FtNzCZ3jQKkZ703THMOHzPnszxdcHimHWomMMomP6L0fTAIFDRQUHL/
 leyA==
X-Gm-Message-State: AOJu0YxX5Ww85Oex1pI2vR5LQGEODkI8ho0W7CC/6MhbsruuyIjASmjK
 n+ca3St4qOO+PKJcTX3ZgyleAgfBMg9DpFiFeMBOK6BvAcETt6GWGTDswIIutliW0bL/bxSuvfB
 kIOWPadSGT8NehsPYOEZ+0SNckdgAgmlqdnSU7DT8nw==
X-Gm-Gg: AR+sD12XbNNh89FmfeQreFlLG8IY8oAjimwHjoI8Ctryi36yLvisEbuYbKfGa06pqiw
 bquM50i2gX1kcM7Gi3i+MJjr6nHAYSylBHlSU66L4a2PMJxry950mjTQ/DnfLEqT+l2M3Y5wrlv
 Lpf9pEKh6eubSaCWT2kFpJiYb7vvf6pbydDQ0KE6XyQL1kv2Upd4sFiX5Kw4aY3D+RrKG9bjs7Q
 sTj4wk/6r9pBnbUeSkaBpvQPoSkNQ+G1jYclbzimCgesBTiwPhBt2KzQwjv1zhLVV82KBXJhHcP
 MCvWn9Hx5j0tE+wj7BGrNRQmOoFIE41kjHhik3W/dTZuZPMO/ndvc9hYrLMSVkf0Uqs39kUlY4w
 8lZ0hAR0BFtRVhXPj8RPgMLb5ara3
X-Received: by 2002:a05:690c:e188:20b0:81e:98d3:cac7 with SMTP id
 00721157ae682-8412d32316fmr5135417b3.12.1786979338841; Mon, 17 Aug 2026
 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260812220816.94034-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260812220816.94034-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:08:46 +0100
X-Gm-Features: AcwNN1UkxGNOMoIOLMU5Rtn4GFE9U2QtuFe-EMEvaOrhMtLjrwYRAGx0ieHFuVQ
Message-ID: <CAFEAcA-hNpNCRow8u=WzXsstNKY8LyUq+XVG8yZMsfajSkyq3A@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF
 and WHPX
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 12 Aug 2026 at 23:08, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> While trying to fix the GICv3 dependency on KVM and WHPX in
> commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
> selects GICv3 for TCG, not HVF and WHPX. Fix that.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM =
/ WHPX")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

