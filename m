Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE01CDE008
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wch9z-0004ju-WB; Thu, 25 Jun 2026 06:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wch9y-0004ja-2M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:18:14 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wch9w-0000ai-JS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 06:18:13 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-663c66669ddso1594453d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 03:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782382691; cv=none;
 d=google.com; s=arc-20260327;
 b=WNq1vhoXQQWZPCjMu3sJtmF8x2w5JOb1LHVkYnZzq4BDlitMxwZZ+vtwWjmp2ILIh5
 qSOO4PcCC5ksE4YZFQxP8B+Amxf7b19Q0RTMmPuDnIVIAK9oteY5sKEIvdfD1qbk4R9Y
 XmLcLDxSmHdfK2Si79tsIZZmpAHdT6eHTHyGqw/im+lySZqSjbGNxNBEMyy3DGjtXJyv
 rZe3T++8AWBYedy6SlLVJEeO0+OggNs9Uf5GklS/ZXUEaUogPEk56kpGoD1AEmHgiDDb
 7Th1GZ+Flvq6i/l/8yJrzGAAPgX/GaJN3zNNMPKP6+Hm51pj5gNA17L85SG/PSFCqlYz
 JPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oAkhTbS+6AKp48dswyzdQNYeGNYYIc1VF0vVL/Zr1vM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=bZPyCamcThU1mPRY1/kevxpw1apWduAK2IDL30PgdMHr69svEUzzjTPyMgJJvGUImw
 JEb23piDahvGaWXtgqRVSGO2WRfIXmrfecZVM2mAuR9wWScp5ikS5gz2Aau16D0KiHD8
 5bg2ODqtj+TUZqmU39Xkgm86slUU8LfMIJ/vPyJrjJt9awke9Fzsa9fEFyQs5WIzajZB
 j4AjjRERM3o67lUYuvCPXLd+OuoOG3KRiN6sW5VQanwi7LAU+qcSn0oDSWrhSi4v7Fsi
 6/oZ5NDHEMEsENpdcQpoUvJsu0M5il1IjCTe22wbY3e4SpJD/XNNlhyRrIQ8udMXyDwX
 dwjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782382691; x=1782987491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oAkhTbS+6AKp48dswyzdQNYeGNYYIc1VF0vVL/Zr1vM=;
 b=Y9J67dAdHCd+LAypkoO1ngbirjJzxp2RRM63ZF+vt+TnlW7elAKgRY2xGNqpbBqGeO
 5ouAtcwC8n2cPzqE+tCxAkUVvka7M/3wDssWa1J2T1CZPHbDhtKKnZR5zVa6Ljl/NqZg
 uAJm0ZXkmFmjWWDtZNhdDZJT02HiVdRsM1sfLiKkkfWC/uz3BkTs8lXSBqmNuO1/wwBk
 9kmPsZ5VMbQbiuJxE+exvp37DqBrE58tQW2ONcV5paq1iHSk1tKvR25zo1j6gHV7zbqK
 Jhde+1K0j8w4usw5desv5xBWmKZchV4x99IJ8RYJRg9w9KBFz/i11s/P4MweeCCMKlnA
 m6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782382691; x=1782987491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAkhTbS+6AKp48dswyzdQNYeGNYYIc1VF0vVL/Zr1vM=;
 b=H0zfuASjyqA6XyPRVElwIVaMUIXmjBYfjvUiDhgMMs79WxxC+dgf2DAGo7IKYQfqMX
 zrpfHk57v8JbjMYjO1xioov15jqS1HtWT7/F545f5IjxBXNjIklDIbFe0+6t+1KoQ4CY
 wuYoc2WTM5VuYo7JOEBpz1pXOSjqMMpfX+vqGccpoMJDhTF17KeOHJhkaENyZ3wNlZ+3
 susXTGYrS70iBPMv8N6wZurqs4Eoq3RCQkKwcplcW88JBLoy2LQDY4UDT+oZ+xXDNY2P
 SmACFIjZGwThMCFbzytNiRRsM1s0lIR/nH18h78aOztA1vMLzt2E5VP9U4ALLTjGDRRY
 C79g==
X-Gm-Message-State: AOJu0Yx32iG1jowbopsaeOG2e5zoLyY5H3oy2yTUE+rkLeMEKCLIsoJI
 yzNFivTpRnxXekn6Lp9PF25xposXKApl/20B8rLdUrcGvLXdvVeh4pAq79f7aWHMMO5iP/33OmS
 olgB5qISkt8ghl+a4lggmCd71GV5OofeIQEU9/Z1S39rNCmfc1uarGuH3/pxf7n8=
X-Gm-Gg: AfdE7cl79sCe0dUTz1YnJGhwSP/ymz/yU7LHQgYs67RHyr0S9Dhqgg/ICgxEtr0CgFG
 lq4hWdQUXQaO6TOMDqEpMdGqNe+hkOKrfztj4OVtGJ37i4rfMj92LNCOqTxJldq3V/iJDWLjQZK
 q3i4i4kjOHsz/nT+uUKiYszPsY+6MUVU9/PYBcVX3E+CT2LOHB4qqQP2F/QJKVchZ9CefecMfFR
 EIX37Gg8uJAcAWgTS4BsFSXpJbgg/+9YmP2fHCKMiHDjr/688oE+LO4Yy1v9j9pQYnFBpPv0Iyl
 K2ZqxIq+2WuJoClZrT699B9JM8Z+BjBbIfOSEiHqOh/KB4wu6xD8tC/e
X-Received: by 2002:a53:ac96:0:b0:662:e688:ede0 with SMTP id
 956f58d0204a3-664882de747mr1300143d50.50.1782382691264; Thu, 25 Jun 2026
 03:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-3-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 11:17:59 +0100
X-Gm-Features: AVVi8CdMPBJ15mpbRziTidrdciQcCB-TuYVRLSol3pU4soOy1kKpNUtI-ukdvps
Message-ID: <CAFEAcA_DjQBBM+v71E7ain4CXs7K8erj8b8=h6c-YxpP1wV9Cg@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/arm: Rename SME FMLAL/FMLSL patterns
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename patterns to include _sh suffix, so that we can
> distinguish insns of the same name from FEAT_SME_F8F16.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

