Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055F1CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNKC-0003rJ-Ak; Tue, 19 Aug 2025 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNJx-0003p5-K2
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:28:20 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNJt-0006S6-Ii
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:28:16 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6188b5b11b2so6705430a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755613692; x=1756218492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m3xfFX2SkB26ybLGLE6QdZiDrdu3HQCWElmcgwnnPWg=;
 b=rWOW+Crta/tj8UQAwwYlSb5IWtZmbcyTa9cGFp2m2jyzH4zpPikz77j4YyQAtdxH1T
 ct2RiJNA40Po4U2+oj0/2o+AcFHxSJR/GjMLSvpmjR5MB/oq77rEIXeBxpBTsUsBc5gu
 Jp1G+YXJoDPmhEONiuzFFjafFq2Gh11WDdKJXb4VS6cNNvU12gFnlu3X6SVnaYFTyrnw
 lV+IjLKXBMZ6SybFAHKOmIdtVuZJTomIdXRIrwwaWzUdEMiqVnudW5tu7oPWPj3+JNRC
 dk0qHp7N721J+8simBw1p/zfvHwtZ6sOq654U8DtdyWVusVPZEbPgjlTyPeKbjl6J97I
 X9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755613692; x=1756218492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m3xfFX2SkB26ybLGLE6QdZiDrdu3HQCWElmcgwnnPWg=;
 b=KV/1rvdWQ0QAnsronC2LSLYGPWD9VxXmFtbU1Zl7GsBaIYijxludbSeQc83YbIq1fJ
 fKSdHqsUU2KMfTfAsepkLrhON5LXOHs0ANT/nxyooED9w42yEdITdE0a57yG7+fsTxrm
 UMv/FsXImrcAwj2DoKgrlB+5g3SsPVWrkjIvspQz4j6Sd6+Nqgiez1NSQEwwzg7OPy8I
 5BhIf61oBHieomzYvyMtTs2bfjtTYOBRb5v7M4/Xfjr7GP16CSYvVjO8y8Iih0mO4Vds
 jXTrwfmqwgzcRK3Bi4Ec0J3owy4ipnapqjyGQlKa2UxDKFOlYAHt6hk018bV0wxah+0G
 BapA==
X-Gm-Message-State: AOJu0YwY93eMresTfkzyVlPA2rQrioS1COhgOqMcP7avSqFmWEZkoeX3
 teMvNwSLNwU5PsOMHlTtqSRO1uXbgLdeYZSBQxDVdNGaWl3Ohesc3wg6RBI/JXWX++Vlo6tYcHs
 uFWKeD0naFpjqZiGt2yy8FoDFiP3ARW4WPoGRmMEyZw==
X-Gm-Gg: ASbGncsqGaR9f7h/jMpob8hRcT1VNPm6G3KLZF1iStuc0qprJOxI1NR9R9wGyS/O1YG
 VsVSI9mpXrc0WnPG2l/8+n7a0ChG/e4OsR9zKs71+EOtIFlw2pAy0pAeY5ZdaM7lpgpZnblYFrl
 4Sr6X1K41uJ3AoatQu8S7sQKap5LqmJvh7HgfDbOeksRYYxxS+7eeKCjigUjDgBWjkcUgxg3feu
 WaVTytHFX+86ff922M=
X-Google-Smtp-Source: AGHT+IEZ76dSqDeXD40kH+9zDN0jqVPc0SqdDLyNZoCrPB5X/cPTXVs474KFdLf2WPEVzmNgQY+rhS9PygdQl3jnqfw=
X-Received: by 2002:a05:6402:2343:b0:617:f5e7:fe22 with SMTP id
 4fb4d7f45d1cf-61a7e72fd10mr2222065a12.16.1755613691963; Tue, 19 Aug 2025
 07:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-8-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:27:59 +0100
X-Gm-Features: Ac12FXxZDvLheRWB-dKlNWJ1D6jcYz7JMtCeh1fQcyRipy5bybkjV8YYvq481t0
Message-ID: <CAFEAcA-JH1Ux80FcWS9hv6mwv-jVUV43boG6DzHucqQjU_uqOQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/arm: Enable FEAT_LSE128 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 15 Aug 2025 at 13:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c          | 1 +
>  target/arm/tcg/cpu64.c        | 2 +-
>  docs/system/arm/emulation.rst | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

