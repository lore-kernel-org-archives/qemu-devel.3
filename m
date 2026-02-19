Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C76E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4nZ-0000dx-OU; Thu, 19 Feb 2026 09:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4n0-0000Zc-VS
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:14:13 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt4mx-0002b2-LP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:13:57 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ae5f0777dso721805d50.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:13:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771510434; cv=none;
 d=google.com; s=arc-20240605;
 b=X+HQwz2WXEwYQTbFOkU8juqMkodh/6CB563AwAXFzjmGoBqB/UoxvQShGs/0+h4Dcs
 CbcLWfU4WWDheqVYVuov0Iy40JKpK3iEV5aw9r4apuuKKJWhhhLP2Ft4iQjHo6NR/Jrf
 jkK1TK79g8JWfMg4b6Zvm5/Vz/vYhzDemZoijb8mofwddOPDrVZ71AIUMSJWingDFsr/
 EN0ADJbsdfGBKJ4Fe3Oyc1g0khW8qO9qtqzIn7YrNW35jClQyV1/je5LlUS9WI4cStke
 c6Lxld8z+M9PIECkuvGma1CkWPySAHRNMdXP/1Ver+qbP7ASGx89Ql7oR0HsETKdifqL
 QvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bgZ/TOT60vVArHneLQAX4i6WfPGeu3gy/NUr8DkNhIA=;
 fh=R1r6CB1EzLFG6qA9Lv/lbb8sJBtnz4v/fkKb0onHZ3o=;
 b=k7xg/uABcVGHWrQnODaUmuNG3TNkMNB5eZt3dmRby7lp7khVMWHNr7AKwfrwtj12b1
 RWTYlyitnqn9TPSUnN1ro18BLceLf4zhZsxFm0TKGVQfOrjZSrcEMksVaDVq2DYKPlXQ
 eWceeL1DVC1P5XypaQupkIv1iEfjUxpvLC8zZy4DFOf26ShZB1cD2gSbapRpV0oxj2ln
 KvXgG62MbSbBQyXQjlQXpELtIsllG5JFeSeG7Xt/aV9xSj6yttisdF7EZgKtlZ0LSAw2
 gMBjOx4BBbfGVnMngLgCdq0lV5rheCGFaUolP20UkGXu49WkrTE0CtkJmxJ7tDEPV0ky
 roqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771510434; x=1772115234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bgZ/TOT60vVArHneLQAX4i6WfPGeu3gy/NUr8DkNhIA=;
 b=GMaMa5B5AtvAa6k8N1ULwkUnsmpQIlnhcEYuFsqVwAnYwxFd7Z+YOCNvxNkZ4IRGRp
 ogjiTe3b8W5XbjBZAUgRe6ljSXnHwHQ7rtngpf07Ot+rirBl53smCPj/qw3Xcdv0WWxR
 vqf96JNvwJfYU06q/NzPVIaqDg+7WArml9ZP8m+c9bIaVPwCRZwt3mHYSi4xwUJ4aq8c
 4lTokDfEKgc9RKv6/3nAOJrK1l75SAo3uM3vfRua56wvs6ds1N3iJdG6e3aIYY3lkfpv
 h+s1PpQEG0n+G+kuBKIvWSo6fPvTvPCUcoIo8QTVs0TGCZ/BvrpQMXkCv8Th29wqQpCZ
 Lgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771510434; x=1772115234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgZ/TOT60vVArHneLQAX4i6WfPGeu3gy/NUr8DkNhIA=;
 b=SJBcMnF2BWyRhOi/QIf03ywfRaQ73EvKHtUF1WOViYJi0xEaHxZlYNkDXiHThHeHor
 Qp25/grmZyn8WCAW0DhSR8Ly+Wy6PNYE5WF8Q3Dzc16izIsnGwvuoBwYi+QVM4+Q6J/7
 5tCsUXE9kg3n+SkPLC1uI1E2a9Tl1V9pHDFh2EGk15VZCsFNlYx79U2Xkn0l1UtCv8nG
 bgUN3dQCxg9IsBxQI6MJNDDvywbV+MJVaE5BPM63JIRDO4732oBCqztgmbX9E5byRKZK
 MT2rgyFCpyPA9iwjjPNQ52DjGGYOCGJgQ5fJSURsDbd+NgI8zyIXhsS8GgVW8ZEw7AHv
 WLBw==
X-Gm-Message-State: AOJu0YyTpS6P1++DrJsCaDjMV+q9T8I+zrz8csxgBQvVFQnT0euNb8aV
 g3EvrXeRq3G1atNgVDLYKnZl34n1hn1307OzvCRxCSfJZ2VmITQeji8bbxMfPpEcLcaDB0cwqfX
 S8ia9gMfvHH61I2cg9CtQQVAcqYizYokaLYtl/DlseQ==
X-Gm-Gg: AZuq6aKnUWBMb2YYwttwGuYXCvCJG79hPZJZnbNZtdLSoE2ber0vjCIpD32YoM7gTtB
 5wPgDWsW40e2matnI/qVDOo/Y4KGNctAlmpYMNlRFcTGSJyDvM5BQi6BnnFRDTSE/VhjTNyZgNk
 D4UBKU9iNFCpgF5VXt174vQem2wzprwK8GizHeyoNST2xQz3BEpOWrHG/SJ6sUHaRLGqLiNGrCL
 mwH6FrXgV5cxq94N1U+niJkIAF5gmoefjAcRMMupsPs2ZH8gkc2wGjkJNcvRpQOWjj/s2yHzGdU
 vBKykuUrpj5rLXJYjNg2Amuu3B9StMC6HNvUbK5SrYbHXMsUiloaELtZTitSevl3jge9Tpl67/2
 XkA==
X-Received: by 2002:a05:690e:e8a:b0:64a:fea4:fe6 with SMTP id
 956f58d0204a3-64c556e39e0mr3483068d50.92.1771510434335; Thu, 19 Feb 2026
 06:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20260219140228.407513-1-gustavo.romero@linaro.org>
In-Reply-To: <20260219140228.407513-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 14:13:42 +0000
X-Gm-Features: AZwV_Qh6--QkokSaxBx2TwmZCgcqeQN3hwhjeC85q4T-C3wRfsZtTbKLFktjGOA
Message-ID: <CAFEAcA_GdkVJbgGm2j8v15PM2ijKF2hYBAUKZ2_W=g6XasFvCA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/ptw: Clean up unused ARMMMUIdx
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 19 Feb 2026 at 14:02, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> get_phys_addr_disabled() is called from only one function,
> get_phys_addr_nogpc(), and from two locations within it.
>
> The first call to get_phys_addr_disabled() occurs when mmu_idx is one of
> the following: ARMMMUIdx_Phys_S, ARMMMUIdx_Phys_NS, ARMMMUIdx_Phys_Root,
> or ARMMMUIdx_Phys_Realm. So, handling ARMMMUIdx_Stage2 or
> ARMMMUIdx_Stage2_S is not required in get_phys_addr_disabled() for this
> case.
>
> The second call to get_phys_addr_disabled(), with mmu_idx ==
> ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S), only would occur if
> regime_translation_disabled() returns
> true for these mmu indexes. However, mmu_idx == ARMMMUIdx_Stage2 (or
> ARMMMUIdx_Stage2_S) can only occur if get_phys_addr_twostage() was
> called, since it's the only place where ptw->in_mmu_idx is set to
> ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S) and that only happens if
> regime_translation_disabled() returns false.

This is true, but only because we never call get_phys_addr_for_at()
with an mmu_idx argument of Stage2, right?

-- PMM

