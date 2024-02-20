Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27ECC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcS1B-0005dA-Io; Tue, 20 Feb 2024 10:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcS19-0005aK-TE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:26:47 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcS18-0007IU-0i
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:26:47 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso2623287a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708442804; x=1709047604; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ndTFqn/XV3AbCc3wPl0QRHPW0XEWdIhKi+aH+TFtsw0=;
 b=mc8otnQik6LEE4djMS9sI3Z8D6yq/zm00uNLUYjDJtWI2bYUe+7edSrq7TuFDdYgse
 wiJdKmht05zbXre4Br5776OM+9GNIteJIfA18IJzh6QTqzTdfjeH8nw0Hwm+U3P5R4zI
 NNXQtMVspicC46FX1q3e9erL3/r8/fEXp6KwHhC1pFakTzZ4JPUMO7W/cbPOm9xyyPwF
 X8+FF+6VnRmuO0rgVse8td5RQwBP2iOq7NbtJP/YVA2De9itcYBx1/HPFj8JGaKUH4lN
 18x2rZB16oFs+VcYBeDkdKCZEDXleBmuR3yPVzr7x0cjwsTVz2BCtVapYTaingJPHigc
 SfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708442804; x=1709047604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ndTFqn/XV3AbCc3wPl0QRHPW0XEWdIhKi+aH+TFtsw0=;
 b=aGyNTZ8vjIz2IFhEa+2pNuqQfKp17wN/Puicg55SUOepv9VBJ46Kc6qGSyI/dOxVEv
 wzIHO9pFg9/jCFZlojIiLPrBDh+xDmeiWhOfhi9gR6YQe+m/b67AivyKqUSXORvn31M/
 im3yXEtWEhJd+vpMGGeggMO77b+NY1bW27WGkGyw8bqDKK2I97Ayz4V7gLCz1JWRIf0p
 dEUvaL55bWSEC4cHDiwuzLZwipMYkSuSBGqbL3vsC2T6I62bmMRlX5Vmx8rHyM0NspaV
 8e9vQ5gI/ZXHejw9vedeDvbkek2Gqm1Y81JybxICJWlbo9sBHFfDHv+TSdDV9XbLCg4t
 sIOA==
X-Gm-Message-State: AOJu0YzqezDa22d5+6dnlfUaxO0Qpg/RzgiG3SkCY2FXLl6dqpCfGgfM
 rbV1KjNqT7pt6cTxRnVG3UZyS8JhPgi2oTBbHfwk9txTxpyw6QF5MNTly3/S+MWNTK+k4sVGhpo
 WoFApEaO4bCnbPQ8mdF1ncJ9o9JkfkRL6tRdW3Q==
X-Google-Smtp-Source: AGHT+IHFUsvUdkQyvrfa5UjBDmvZyseYqqAVTaowAEjjTpBPvc2DJgfpj6didi3jzIf0SHYBtBIiCwWoXmF9XD4YkFE=
X-Received: by 2002:a17:906:27d4:b0:a3e:b0b4:a83f with SMTP id
 k20-20020a17090627d400b00a3eb0b4a83fmr3968816ejc.6.1708442804649; Tue, 20 Feb
 2024 07:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20240220080558.365903-1-pbonzini@redhat.com>
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 15:26:34 +0000
Message-ID: <CAFEAcA9V5UsGqJKF0HqnrPaEcdrf6sFt8nfTC2W-2f4U59VT4g@mail.gmail.com>
Subject: Re: [PULL 00/17] Build, x86 patches for 2024-02-16
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 08:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3ff11e4dcabe2b5b4c26e49d741018ec326f127f:
>
>   Merge tag 'pull-target-arm-20240215' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-02-15 17:36:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5f9beb5001738d9d32bb8a617ed0528d99d7f09a:
>
>   ci: Fix again build-previous-qemu (2024-02-16 13:56:09 +0100)
>
> ----------------------------------------------------------------
> * Some hw/isa cleanups
> * Fixes for x86 CPUID
> * Cleanups for configure, hw/isa and x86
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

