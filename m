Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D720DCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIvf-0007oj-E3; Thu, 15 Oct 2026 06:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIva-0007ng-Mu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:43:14 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIvX-0006iY-0Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:43:13 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso53736247b3.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792060990; cv=none;
 d=google.com; s=arc-20260327;
 b=VNKAivBOgdhDasf0itpRUApLMg4Y0wMUxV1ColN9C/6YdAnDnWjc9l0YlxX+fh2AyW
 lfVV81LCDBHfmoLYZY2K/LHjNNeiutp7XMvbTKd1prAdB4zPjBs5H/p1Syy74wbWowuQ
 JFNviVopJa6uE4JHsduEMLrwy9lABgk0ZAGyRzTaN6WkcfPlZC5DZ+diKwkj41GWI9oC
 aVtDG5AYwNMG7IEjOqkK1kcKlZ9Rn3lpDEx1p95I+/Ux6r+T5HUDiYruNA0wLh0sDrTI
 2PTwanQJloKrynWyy0ZxxYt+YqV6G/I6QosmQwWtb/yT/oazrSXEV+uBm577WZZcgiYR
 e6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=goJEpo9WJS29B8YvteJZWomX9CylYDEkhExGEjFe6N8=;
 fh=FBdsZjhbP+DsOWwZCD98HP1pdV+8cWYkXHC6040hJGs=;
 b=PEEBwMbjWrdVrIeQoN4M5Ruepzmc+GippRX4qOq3Cs7DV12RGZzgcHyyybboeNmIjp
 7TB8dp+SafJ/fFcDionjBr5lhHER+rDJ76zIPd8RniUGhGcY/UpP+MF3SfNOtVQYxk2Z
 E3EiyAUXRdX8mtOGFXHdmdQnwXh/STcrXYFkLaIScDhpAhxl5ASi/HrirQ3halgLuRaV
 dKYT0AvPn67DpStH+mvx6Qi7RfwWwIOtwJYV6WsVwmEc84zFexOgxg0GxaEWFrSOR/DP
 bDLurwcUsxw2MCKBX3bxWRhuDY8TAWxKBeVz24C8Guu6x7FbmlWUl6mGKZiRVlyu9KMl
 bP0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792060990; x=1792665790; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=goJEpo9WJS29B8YvteJZWomX9CylYDEkhExGEjFe6N8=;
 b=tmgCVVg0dpqazdqqfaT544e3TATkanVYqeHSoDrS8Bx5fBKEBZELFP9ItRQ8njq0wb
 2bANEMzRJzDAgAGp8NDZqXiCuJ3SgZVWdnJQOCRpywXL/s5KOB6mMfvPkk+UGYharMw4
 LRmA1tVVKVYy3f5BVVnjYeBvbReI1UOsG5IvMcjyZsIkUi3S/33Xkc9UeAlTDYXLC8/z
 PcylwXRIKuAC2azwuVhEkfGQdKbeAQjzwrqvbAQBCp1JOCm8dCKkBLdF/kQb1UIZs/vE
 j3DOYOBOQyW03V5JF0/kbYAKy0AhaGAy/bKEpq3awT5Src3t2s27EcksafPmvWcbggFt
 +pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060990; x=1792665790;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=goJEpo9WJS29B8YvteJZWomX9CylYDEkhExGEjFe6N8=;
 b=hV2yE3vM/SugCTzqOdR9T2SKkNSlVt9n6ZDeS6Y4JaJyVWVmR1KoV73+rS3eyda+np
 AR4nAcgo2R7h8CweiWj+03dzvOEc6LPwWwr89e4pwLfJegKukmHHO6C1L8d/6kX6N7kB
 9NsU/AWMqmf3nLxmUqgSgkrO1GMgi2GWzDyoTBxccSbXHWavd3KXwYmfdCLfFz8Kop79
 7izI1C8p/j/BKMxwTxmLgRMXaERUs9tZzTsg6kxpwNLeroBtwzAkYGuM0t25iGJ+sFIy
 XoFn/4Jtr9livs5ARDJSznRTxrRiHCmIr9/zlpCsvOB2DSHr7gMeKN65otD0xs+gGTIa
 Xkfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjbNDOPE7PYNEAgfjGiAtKsHlOLhU3KW1RIYznAARInDICjRE3v5p0OClNT7hxTCYHB3I9P90rSFX+@nongnu.org
X-Gm-Message-State: AFq9FYKP41WAbB4ydvfu0OwRzlsv0cxsqrRuGzPJs6tykc87ijVtd1l7
 DkcEb0Hbvs0nhtYY2CRi02uRE45p1Vfi7DPr+TY91elF37bgDiv/vVL94CY543o1hfBQmiuQIY/
 uP7uhs+Pey+8MAgkNqY0SDBdvQ2He/gc+JbpnVGCbjBAWdTBN1pVQkJY=
X-Gm-Gg: AYBFou2KRH8B2ZlE5wig8s/dabXk4bdDmtK1F6mVOvBCYd1HSKxEiYguo/ieJvz9FrS
 epFsjtoCXnsoBtY6YxLZDfxF2BkxD173fvIvng0vej53gdKygMFHZqRLRpknHQTzXIH6MEbiu6y
 sSc6Q70T1Y36P6xXu98WsrgRA7hbfg0VcBd1ScSnJt6aXeEWsNKfwloZWi9aHZZvl6D45eacTvu
 6Ppl4cJawWAnJZhVWomcMVgs4vbAKuarYTgVNZ462ADHumbs3ISorVCJ8jdSCb6fans5zZZzAUc
 2Xi9gadzmT+AnCvln8bd/oBZVjf+2Uk1d/od9U1ovzdqt3mWtPsEcn167BCc3KECItjQTdpLAoU
 0Pc7b+IX7dR456NzAjBrKLLq5I+MRWTpGN2XeQf0J
X-Received: by 2002:a05:690c:6601:b0:8b0:a01e:2cd4 with SMTP id
 00721157ae682-8b0a01e3479mr48027897b3.31.1792060989554; Thu, 15 Oct 2026
 03:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-45-peter.maydell@linaro.org>
In-Reply-To: <20261013083933.1024405-45-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:42:57 +0100
X-Gm-Features: AclHuK8lN38F5_bdx-GxNkdPO7fyPPY7qDliYUkgp7JGXyOO6SseT0qayM34A_Y
Message-ID: <CAFEAcA-2+rrNObsLnMgy2zVbQQbxFd5tezqESZzk=eBYGg1XjA@mail.gmail.com>
Subject: Re: [PATCH 44/86] target/arm: GICv5 cpuif: Handle PPI injection in
 vPPI pending reads
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 13 Oct 2026 at 09:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The GICv5 cpuif allows the hypervisor to configure PPIs to be
> directly injected into a VM.  Setting the appropriate bit in
> ICH_PPI_DVIR<n>_EL2 causes that physical PPI to appear as a virtual
> PPI in the virtual interupt domain.

"interrupt"

>
> Directly injected PPIs mostly behave like true virtual PPIs; the
> exception is that their pending state tracks the pending state of the
> underlying physical PPI, and guest operations that read or update the
> pending state work on the physical PPI's pending state.  (Hypervisor
> operations via ICH_PPI_PENDR<n>_EL2 are not changed, and don't work
> with the physical PPI pending state.)
>
> The complication here is that when nested virtualization is active
> the EL1 timer PPIs must be redirected so that they appear with
> different virtual PPI IDs from their physical PPI IDs.  All other
> injection is a simple 1:1 mapping with a physical PPI always
> injecting to the virtual PPI with the same ID.
>
> In this commit we update the places which read the pending state
> of virtual PPIs to honour the DVI bits and report the pending
> state of the underlying direct-injected PPI.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


> +static uint64_t gic_virt_ppi_pending(CPUARMState *env, int reg)
> +{
> +    /*
> +     * Return the pending state of the virtual PPIs; this is the
> +     * combination of the ICH_PPI_PENDR<n>_EL2 state and the pending
> +     * state of the physical PPIs which are being direct-injected.
> +     */
> +    uint64_t dvi_pend = env->gicv5_cpuif.ppi_pend[reg];
> +    uint64_t ppi_dvi = env->gicv5_cpuif.ich_ppi_dvi[reg];
> +    uint64_t dvi_mask = gic_virt_dvi_mask(env, reg);
> +
> +    if (reg == 0 &&
> +        (arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV) {
> +        if (arm_is_secure_below_el3(env)) {
> +            /* 30 -> 20 and 27 -> 19 */
> +            if (extract64(ppi_dvi, 30, 1)) {
> +                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 30, 1), 20, 1);
> +            }
> +            if (extract64(ppi_dvi, 27, 1)) {
> +                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 27, 1), 19, 1);
> +            }
> +        } else {
> +            /* 30 -> 26 and 27 -> 28 */
> +            if (extract64(ppi_dvi, 30, 1)) {
> +                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 30, 1), 26, 1);
> +            }
> +            if (extract64(ppi_dvi, 27, 1)) {
> +                dvi_pend = deposit64(dvi_pend, extract64(dvi_pend, 27, 1), 28, 1);
> +            }
> +        }

This code gets the order of arguments to deposit64() wrong:
they are value, start, length, fieldval, so should be
  dvi_pend = deposit64(dvi_pend, 20, 1, extract64(....))
and so on.

-- PMM

