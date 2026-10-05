Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506FBCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDjmg-0003c9-TP; Mon, 05 Oct 2026 10:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDjme-0003be-Vj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:35:17 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDjmc-0002ws-GR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:35:16 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8871ada1a26so13026697b3.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 07:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791210912; cv=none;
 d=google.com; s=arc-20260327;
 b=RQQ37nNhtve0l83M4B2x3kYkLGZf5KHeb/xdTlwGpjJVyX5esME2V4V+OeS4LKGt/g
 HZqQXQfN0h/utlOnp6YafrCHE9/amGfIud9QEjHI52SvDvbhajSt7/jiMic6ScUTWT1a
 2j5ONNEOilrUMxn6zLVwnhObQzivnWNcyLcSZuybKgf5cFCBcYhF5kJDAIbU3qaDsrBN
 7p3zTzGX+IkWty7fvqxonD5ZNw9FvfLjCkRkEBtj2QG5WjNZv0dXGbZTTIGGBdGaWZRS
 LsSWZrOilDzqJaOeJn/HnPVgT/iAPU9k4U2+dwlU6bpMX2xLjkos3BgaUohbIKKVYgLg
 bsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jQpfOH1sU91g0An23pRVa4/U1ZxQ/WMkIzNgKV6yJy8=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=kYOnlICcuexDte1RjGvRQKl6L1jQliVsN/wbIkX3qqipOvyy7kHZBsRUMUA43aKpjG
 NNwUuOl+8kVrTvuPWji78FnaTwZeVg4S0tDG7s9DCFtjW7+6lOrWL9mmdJXW/awznzqa
 yytXxKHoWaXSOTNVROB3itPFVOvxhvkZvBnRcrrYA85aODe/RrhhRq0q3pOHZmNOMd+i
 2PItiTYV8sgSBh7G73indIV5JKCo59CxH3nLlwEEk8q+R5yFvEnvPfBE0FzOnoz+iq0U
 OmPeVXDh4rrM3V5tI/PUFRHZXIa6SQP9o9FyFAa9Hq+Ol2JeLFqKr0rytmHS8gmIYhZJ
 Derg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791210912; x=1791815712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jQpfOH1sU91g0An23pRVa4/U1ZxQ/WMkIzNgKV6yJy8=;
 b=cR+BMq2qotVMcAtJ7chvykq0zvw6y1T5Qj2yMOMFtRpcTNErnwR8Tm/+Ema/D5jHJx
 UeAEkHYcg1AHn+r+EZ0aegEkTIZ9+6HcCwWO+6AntLFTga61fo/Gt9v8Z2DYcNfQvwTZ
 VbH7Zrgb42rTsqFJzwkKrwoflUyjG0BsXFb1Fvr3P2OexTexeCMr5PaC+16IMviTe9Ng
 bOFApFOZiAWkHA+6G3JtuwROA7efq1r9WWabKi21hUukqFt53eftUjSEZCGGy1Frl+kh
 seTaFFv6WJYyzeba7XB1mWeficx0lS9AjzLpZTRXSopfreKdO0ez5ejqJj4ODseDNF60
 JXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791210912; x=1791815712;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jQpfOH1sU91g0An23pRVa4/U1ZxQ/WMkIzNgKV6yJy8=;
 b=FzuJEUDMo8GoSZ6YFfroFsSaxLr0r1SlvIoT0lvavtmws1gM7Re2BuAVjfYLd4RWMH
 kR0oEkDw4XZMobgfziujyvnc5xPFlBAqHPnTUaXI2drpBK/vj2SeOjao0z8Zj/fQiUPr
 5RYJbZFAKQSpfvo2aMVU7b5+DD2ECyouE4c8HmJrTN1Lz/gvHos4A/ck55RJwKAU5+R2
 ziye4nFaK/O9nCd2qKKnKPYhMGb83D8frwH2kMe/d0SYdTuvElrmX0kEoh4STl4AR8lH
 Hp1NAgVZ7/URV8f2LeGvahiEOBYuL/fHWkZwEXwT6eGIJgdM4s0g+z3/Cuy4/K2H0s5g
 jP/g==
X-Gm-Message-State: AFq9FYLhiogiP8BZTMexUDENpnaP3QogNxKv6nfg6figX8Y0KIS01qp8
 udUrHN8oXN6m1THJiXIxZtz6h6K8WV8HaVjDQh8ob7vYguSqlWRGEUsv9+IE9JnjW9nZcBHBKP8
 dcf1zW2AE+JkIJSZi3NYBNP17rFXWlwc=
X-Gm-Gg: AYBFou2JeAFHUiZ8wxXL7bU4qhN1ipFpy/a5MNNRc/o/9kV558/z5eFcud+qR6PQ61n
 mn11itNBimvHBh7VdHGhMesT5PciCWIQedGZTarlXS2vccY34C5yzeecO9JCIBsluHbd47UYPje
 zs5C+M8dPiQnIXE1fxym6NMYI+KV49byDqZ046dXIq/J5JyNRpesIMmxw+bi37t34xcyjb82c9z
 pnFVuapBbU8Akj+3dybZd4gb2PuvaNcG9JrpUav0O8pqMQuhx60LV54iDJuSLKJJ18sajh5hzcr
 nFuoLUob19kUv848ZzddZgKZMdYu6SBTIk7yeiOCHcLrJZl65nyAgE07OxBpaxncwjtl9jCzRTQ
 mKuEp3WCmm4kMi+7C
X-Received: by 2002:a05:690c:e3ef:b0:8a8:8456:a973 with SMTP id
 00721157ae682-8ae94ce79d6mr22117047b3.41.1791210912392; Mon, 05 Oct 2026
 07:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-2-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-2-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 22:35:00 +0800
X-Gm-Features: AclHuK_3cBUj5Xdn82d_2FAhKy5DX38VsAkUgNGtXZjhCc6loHBK7N79CD7ApYY
Message-ID: <CAEUhbmUg7PJiPzLSspj_ha8_KKRiyhEyWk4J93sXjge_Jk-d+Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/31] hw/watchdog/wdt_imx2: Preserve own locked bits
 in WCR
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Oct 5, 2026 at 6:21=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Apparently there is a typo in the WCR locked bits handling: The locked
> values for s->wcr must come from itself rather than from s->wicr, so fix
> that. Without it, guests such as u-boot may experience inadvertent
> reboots when configuring the WCR register.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
> support")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/watchdog/wdt_imx2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

