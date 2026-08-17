Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A12C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0Re-0003Yo-FF; Mon, 17 Aug 2026 12:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Rd-0003YY-Fo
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:44:17 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Rb-0008Um-Bf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:44:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so5103566a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786985053; cv=none;
 d=google.com; s=arc-20260327;
 b=KGDney50y6+g+ZBDziI6xLe7r1RIhgyWOSfa0dMRmYmaO1vSoEwHsVYrNcD6evakSO
 332ByotViNv6e3CPwFk1VBPIg4nkqPCFwkcNId1T1j3DnZ8yJx7zzwX17QvB1zNo5iDD
 VRiS0DpRLDq4UJhD0Fad8qmlwjDwaVLgCaH5uPHJedYoMLkldWlxRHIvtTl8KPo9bexJ
 vilhUZQEHbYQRtrLuj8m8mtd7lKtkQgXag/W37XkWgBDR8s12FO/3Fwd2eIl+RqPM1tj
 SnFfSnkPWpPre3yxUcxHlzDDNQgdK3+kS9xnKnJWZCT1I1ghV6NTe6rLmYqH95DMp8eJ
 Wafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eG79e0j0rvVWQ/Peard3rBf08wIFnN6l/QHNPSHKgms=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=p1pbL50Z86gz2+qUVZE689xgRX97pDnP5WBnBK5wMsQgtQSXey1qpCRENu3oLenWeu
 mNf6o9d5SqsjQdDmdE87B2xA47coblOhlsc/4PdKsuvNeFL9ebAh/OxRI8j6pxt+y17y
 GbHlZwMnLB78tXyUG0wAijkvzNVdYTXuyttTZeQ5KFCxNcLBMs8807arK7b7assGaHfB
 WDCOH58CpfoY2T1Pc3cw3KiLKA9yEtaqxSa2AM0hx5kqdQE1EgMC81ruVj1TRqra9/Nu
 NYHe72z4sEh4XEMjPzPiamYcksOIJ9uuX+dNRUFeuvdw7pOrWgN+4bKlZMegO8DWjA1e
 IuDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786985053; x=1787589853; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eG79e0j0rvVWQ/Peard3rBf08wIFnN6l/QHNPSHKgms=;
 b=nZcwnznJxvpG8OHoJkkaRpk5iKL9IaOL+vqh2dkawnSkyksk3Adu8MskJI9suqWZw0
 jfSWxBbxrI02faXpQJ+TGd4LNtPJUFkkhaoz/IclYryoTSunCILI/zQ3glq6E3vV2XXI
 VEDTk5ZVFJSfzjvIykmk88atk/rh84ZoJH4rppYBfDzrGYlu3IzCcHd0RYMFiTaWSkob
 rdhrmzJpsZICk8NC1yFk5WZLIs7gD7JkeggA0aoIAi5LN6RCoI8fsFENYOGCvg2k8l4i
 dGTT5ZTZggFg4kIwGZ+OvG/m76mw6kh/AMqmaaOuS8+4MQMDM/Z5wVhIN3vMdw5tiKWt
 74Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985053; x=1787589853;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eG79e0j0rvVWQ/Peard3rBf08wIFnN6l/QHNPSHKgms=;
 b=hmDS0Eq42IGYIeokOL2CHXMMlmPmfI7/2PB5LHFA3dNQqu+v9Z2DaY33gKuBdwHNNu
 paQpBnzV287JM6CYjW4Epuk8RTGPU1gwBKMeXHkLy0JWqHMcuM14SpaogzM8N3U2Fxh/
 J0wVI6oQ2zMW30EBm9SbOOVLwIrcZ39aLddhLzZt3uTd8HtOKjQiLcJC/cVyKjoeVyOd
 z1WI31GAtXOF5GPI2Zp03fr07SW++Qs53LP+92CmAupv4K6QE34iIp4x1y99lVtVBQUk
 Bfp6RmLryewcvHM0qjbVUMmMSBBavazcfudYegsgkP+r7l3xVCvKNIBBaYEfu9w8+qqq
 3d0Q==
X-Gm-Message-State: AOJu0Ywoh9LfoWUN0aSXDhhHN789hAdMkvvPbI9MHIbj0DdR9T11x0qm
 en69Fp1qQCmKgbsabkxEFzazFnRxNuqQ05dyBmSPn7mr+GvoAtnic2xA5hZ8cXzbejGxw7Xe3qG
 7Ej8+/ANJGKOvsf+QNQSU4SA5wAxsfgpFaiH6EJjI7w==
X-Gm-Gg: AR+sD13MNPpx3ZAED/ljuvCQJrMB803XtsV1//O0KdpPJEjgysumclzIuNOUi/0iPym
 u42PmblhEzd8aTea8CuGROwrZXF6uVVM4QSeWZbK9k75bOvaC7vnasJWguWBZOaB5lxVv0wpmR6
 vrnpUAla6Wp2hywKT+faHu/Q2pE+3nmmm48Bx24oZkdnv6jGpoFWR6DKZ5X11OkE5fO7MGfhy0w
 ENfDH0VmC9mDXNZp00zL0hUUAgey0fLAkpKHJ/CESglsmhre2KEiJIcz1uL/eUKFZ1u8SzGU+ht
 JDgTUPWJF8vSQ6Nl2UaBcwbKzvKDln3eTy66KpfWdA4wU4CuzT1wvig/KFZE4wU/blIoO2lm+eG
 H2qZhgzoWCBmo+mLBtjFKUMV4zTlW
X-Received: by 2002:a17:906:f589:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c2188294c18mr82409866b.0.1786985052728; Mon, 17 Aug 2026
 09:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-4-richard.henderson@linaro.org>
In-Reply-To: <20260811191540.79882-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:43:59 +0100
X-Gm-Features: AcwNN1Xpcf-QcF1FPXDq2OjUsyCT6SryBu-6J_SK3mc1y7sEfAqis7pyAojhDVs
Message-ID: <CAFEAcA-8ZYKni0cnsC+WhtOtn9704tO7PPjcTo4mTkTibZNq1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add regression test for
 whilewr/whilerw
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 11 Aug 2026 at 20:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/sve-while-ptr.c | 28 ++++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  5 +++--
>  2 files changed, 31 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/aarch64/sve-while-ptr.c

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

