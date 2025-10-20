Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A91ECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArFx-0001ji-15; Mon, 20 Oct 2025 10:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArFg-0001a1-D8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:52:53 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArFd-0004dv-L1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:52:48 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63cd60ca2b2so4590226d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760971963; x=1761576763; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KGUygBDJuLBF/BmPuAl4YfUZpfaXHHmhe8MB8qq15qc=;
 b=m1OsiIH/TrRXXsKVWX1/sv9QWm0snudnQeArhhTQ5dOwj/oIR1ChThWGfemukCp3aX
 0ERRIxrY14zpI6rh/vDx689Insr6kiKsAOsXoQvDVuM+Nmps4spAmjOhD6oFJCXSev03
 mtnNNTTzNJgvbZmGT8eKfMVAC1GtrheAmHEsg2faoyYl1B1n/MQrzXhNVpWRXq4IFU1r
 GWZ14+UBSR6+lup0S/r07LsLbjHQW0p4FX7KZQZ+7aTS1iTEFuP3vRGTm1ENExKJmQ1p
 xEzQ/LAfZukEBMEAfEY9mgyBLWXv/B0a7zwxqdvmyZtFS5T8Z/+zj4KefJqQ9uDNMkQ0
 VWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971963; x=1761576763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGUygBDJuLBF/BmPuAl4YfUZpfaXHHmhe8MB8qq15qc=;
 b=vHD0d/seb1KF75ZtjBSugsRNyAki+xAcZ8Mc4Y5vb+Nnkt2CESQK/igLMGSFFyeQ1S
 a8EmpvUqqu88CCxs/NNY3G2RiGi9d0e9i3gb86g0124SYz2hSET/RkBbhIpm1VU1JMkt
 Lv2nJvmz94sG6LzDwutXhstMXuAKNBipL/fYPfVPinI29uxaPNnMe7qGz9R+OBGwB8JO
 oNpkLuE9ZKpyrHyydPABWRAIUMRbHdwbHfW+/Ps/1dfRa+0kjmub9C7duFPekfD00aMo
 hyiiUu5lF2j3LJkp8Nbx3NtfAkHQ03BuqSuXchbbMPsxITYp0ZDe3m9o4BsHuXrBdWYv
 Qw0g==
X-Gm-Message-State: AOJu0YwmtRQRSZOqa3AuvQ+NN4rEWo5OjfLpBImNngKajRo2HzHIoUj/
 CYsMf++l8OwOIBehjxxABBePBn/gFFyW8yySXGHAXtfgPoJQlc4F/pJWpcD+gPVobfALLy1dZs7
 Q1WKfhyvv3OttU1i+VJw8W1s8Z7Ysu72Kn2m9qfYoyQ==
X-Gm-Gg: ASbGnct4IbP1/8A/nbf9UgiRyOfp6xAM3wk09/xpyTwbw+cJTyLaneGo2PaAVXyVM5b
 zQlXIb+O6A3xGohmkMIFBBdqSvDhsOup7Lid2GbVasrEndE9TAPNrGaq4w35AWnwCR8oKpKAqCX
 TjWydZZABy/xffi+xxc74wQelXoHwpb4fvc5Bj9U5x0T4QPC14ikK3o7jXUNBuXrPAuGDj7zhtu
 lff/BAJMwcibOtxx8rqL8XWGzwYo+Z+dvVrQJ8rLDgO7k4fcjLFD+c4z2nKDg==
X-Google-Smtp-Source: AGHT+IFniSIVdMjMpW72wKuZamMCebjno7HR+fnPmOtFkmdTi4dAfRefyJ5KcIr58dpZhlwJAp177wy4TmyEqRxLrIs=
X-Received: by 2002:a05:690e:1593:20b0:63e:2598:54b9 with SMTP id
 956f58d0204a3-63e259856b1mr6864086d50.55.1760971963124; Mon, 20 Oct 2025
 07:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-34-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:52:31 +0100
X-Gm-Features: AS18NWDqJkT8zUjomuF7TybOsPGW1e5NmWi1YjPpZr_uppk0wNCWFmqyJCrhbXc
Message-ID: <CAFEAcA8EscxnUGroaS14LVpN915sLkABaSY+Tk=BYnJjjOGoXw@mail.gmail.com>
Subject: Re: [PATCH v2 33/37] target/arm: Implement TLBIP VAE2, VALE2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Oct 2025 at 21:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

