Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09089C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEn-000084-QW; Thu, 28 Aug 2025 13:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure3o-0007wW-E5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:57:08 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure3f-00033m-7Q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:57:07 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d6083cc69so8988857b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393016; x=1756997816; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=94KQVHfj13pI0OojH2Lgf0mTRqoIRs3MJWumF7UzXm0=;
 b=LCzwSIFZTicJtheWHrLjL5lyJuikHW1Fqu6HZkYYBBRJE8pYEJxYVf2sRLhtZGHDH6
 +qzqJXY0ffLIcCVoCWec9IR26mXaolvvGQigwnbf59tb2mtFo/dP3NeWY1N99YU1q8q+
 Eru4kh1p4Kp0DZSZLg61i1XAi4jqMfS1uTlIw7DhLHGDT4eBreJR5PlkSBFrHwKcGgCF
 bZtDp5D0jErXqm/mEWX0SFmV6hlS+mSVHSaNuHrAqWR35GRqYwZIWX0FM+aF+YbDv0l0
 m6ViX0nYMaQueWHLxQwHvuTX9Jt9y0t3F/1ZT9k9IfZfjnSL+YN3Sw/5OmPK5l92F3Fx
 xu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393016; x=1756997816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94KQVHfj13pI0OojH2Lgf0mTRqoIRs3MJWumF7UzXm0=;
 b=VsGerFSQu3rWAD5dz0+eAyhFUM0TdVtD5XHjXjik3i+IQGofNoG+4y6HNB3p+KPfU0
 eWmjvTTE7ivxVKiv9s8v9Ua5llR9nfzoGZSS/VPbOK3RS7k0dSfaKsZVPn2FJbY0bWEb
 C8g+Asd1mlQSiX4z8EsL8ds/YK7E6myumlK0vES4lTcmTtOgNABW8M3mvszq+TZxmtQ3
 cKSMAci3rQUbFONc+ixCfWrRgn5k0gdodpLPF4TZ6jKQ7j7Xkyt1nM+3cW+IdTmnVIWy
 VhHqYPCWHwoXCBhmsF0nOgrfE4opQA1j1KEsAACehUFg/6Hi0IDGPWBEJhUGEG3fdImP
 3SyQ==
X-Gm-Message-State: AOJu0Yz4VGEZuiZuIq7auY7OHykkHb79fLJDyz2r6dFBlJ/tsvkIFSc5
 psGjrDmr+tnucPYyjBg8rKUveX1vbanvDtkezjfczwh9ZPXY9FEyHD3boIWLKBoXvKdqj2RRkyq
 0rTQE6nD2q8uIJUYL3SzVxriaMv48xAkxvNt0BRGEFA==
X-Gm-Gg: ASbGncvDnCLXPPEWZqU/gTKeCs6eGsVY8fDwMEACe8OxQxcZyM5hJvVitF/zjdhtZSX
 n0pj1HbT+6qAX3YE6V/5Swx9OOeqSE7eSrAtWU3ugyX8GiUPUNXE6ozRZFhJe0ZdL44AfihPazl
 93nUmkGC5GJYI8suc+PNmS8ncScH69NwKswcc3mimqAuhypv3GW8ArerYotahbrBPcqVnxpbx0O
 wd/D1r9G2phhrbyj2U6KuVaoTPyXA==
X-Google-Smtp-Source: AGHT+IFjb9n10mlvXzJ00MeCEsrn068lQCSl4uyBWfWV3PtHBBCNmQZcoUp8TZVHqXFi2rLbQUuNP+iaW38KvZqGVQc=
X-Received: by 2002:a05:690c:7482:b0:720:4ec:3f7a with SMTP id
 00721157ae682-72004ec494fmr199745207b3.31.1756393016022; Thu, 28 Aug 2025
 07:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-45-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:56:43 +0100
X-Gm-Features: Ac12FXwv8E-i88MbEQVQl8ASRBbOhctE6jtENkEtSxrdt3-wYQYNSMmQCmKONgQ
Message-ID: <CAFEAcA-dL6+Pa1M-1i_nVr=vyARJjsixTxKq9CTnc0D5PTnNYg@mail.gmail.com>
Subject: Re: [PATCH v3 44/87] linux-user/microblaze: Expand
 target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

