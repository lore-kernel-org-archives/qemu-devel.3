Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721F6C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbHKR-0008Br-QD; Sat, 17 Feb 2024 04:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rbHKP-0008Be-GT
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:49:49 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rbHKJ-0003oH-1i
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:49:49 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 5629F40F1DFE;
 Sat, 17 Feb 2024 09:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5629F40F1DFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708163375;
 bh=/WHptj8FIRTkylktE4aPzFgxdzVeusGrClC9wi7JOS4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=G5VrKzXvvUF2yAp9XmlsGn/Ey+KcCJ675FW1juV5E2LAa2TUMZFSpMKP6KNNYvH6h
 G1hdfAFw+48IFxnpm1pUSj2t3l8/LLbERjB9O+uMK7ayDRBbPanEelcMoFpgTWI+lf
 6itOd7R0SYlrRzCJeo5XXkuRtBST4HhWlqFpVdls=
Date: Sat, 17 Feb 2024 12:49:35 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v5 10/10] tests/bench: Add bufferiszero-bench
In-Reply-To: <20240217003918.52229-11-richard.henderson@linaro.org>
Message-ID: <2abd887c-c99c-437c-f0bc-e06f3a13fd33@ispras.ru>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On Fri, 16 Feb 2024, Richard Henderson wrote:

> Benchmark each acceleration function vs an aligned buffer of zeros.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> +
> +static void test(const void *opaque)
> +{
> +    size_t len = 64 * KiB;

This exceeds L1 cache capacity, so the performance ceiling of L2 cache
throughput is easier to hit with a suboptimal implementation. It also
seems to vastly exceed typical buffer sizes in Qemu.

When preparing the patch we mostly tested at 8 KiB. The size decides
whether the branch exiting the loop becomes perfectly predictable in
the microbenchmark, e.g. at 128 bytes per iteration it exits on the
63'rd iteration, which Intel predictors cannot track, so we get
one mispredict per call.

(so perhaps smaller sizes like 2 or 4 KiB are better)

Alexander

