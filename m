Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66C4CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwh6D-0000up-Mb; Thu, 11 Sep 2025 09:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwh6C-0000ts-2N
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:12:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwh69-0007TB-Fa
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:12:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0472bd218bso121015466b.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757596343; x=1758201143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DX5FoeI10alkx6kuDGgMOBk6pebgfXpNtF5ePKM38Eg=;
 b=d4aELZeqvzIFGRvnQbNprvgFg9Q6P+wnrUbRv8yBq/UXsDNcs0b5Xx9QcAgwNQY8c5
 cq3jxZWSg9d/PmN1uEtvdrHRrA9ELFbwgoN434HsksvHbX4QZc66zeb1LdwxjD1cAeFS
 XIOzkwHn+T6e6RBNvnTFQlxYkLPnQhmrezC+llYYLkk2qY6lGqtK4DExoLhKXblA2/rV
 PG9KRRJWYvKPydrnyFtg0w6oVgBiAaC0VQQinxdX4e4m+xDR//xmgX2/n8IB5GpTxedS
 /MaRUTCb9mqk0QGev8HntaMiih+GzuHoMS1eVstT8WAy1wYlXe8AbHgHM0hBRIcziFMj
 Km7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757596343; x=1758201143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DX5FoeI10alkx6kuDGgMOBk6pebgfXpNtF5ePKM38Eg=;
 b=TO5bRB4ENy1DPvHrC5I6qtuYyr7GmK1GvgSN5iTQFa7e6wquYxlgE71+mFvD4JlkxN
 y1OnDeb2lJtJueKoOJ0N1zfSMA7ofKPRuMsveFnhi9Q5oB8KB1bQnlR4n82EyXKYFiHI
 LLYD1yAs9DBMTr1vXVlf5QYsjJ+ha+rUpD2Y0iDEHlI2LHrEuy5/4TMXNjoLUb4vj8qw
 EeHkszCyarkQeDEy1WbWV9QaVeFilFKN70Uzst650sbzLGxk8/iffvl2+thy+ILmkUs2
 GL7zqQVuV1pdzboFnCkEG7zJZ1LYHxyiQzwFBnFwShQ+ReBatIf9mIidrE9xYZOQUlTK
 MAUw==
X-Gm-Message-State: AOJu0YximSilCZIyhQONEHQX/JZkqlcB26ufQ5Xv2bwqyyrZNKUUHmU8
 H1kmp/PZqnyS79dEWkBW3fH2KExFAYYZa0zZJaIncLvTnCpXZNLXSCWvx4u2Pbey0SU7LInypc+
 OiF2uz0LX1hHoT5WCYFm2gP3P6AMnRIjUoEEOvt7vAX1Vk2dpwWHh
X-Gm-Gg: ASbGncsLGMpRaKq736WvPx1T31Be82Y7ynsLZx0wOQSo6bZUBylJPfPqfX3/yuEtSp3
 9ycgDKhsFSQu30k+UVlEESDcoFM7umYjrRm36ZFhA2OdoyX86kGbUOdqE4Z2EYOgY6qwc5HkpZr
 Z4xmbcnxsMzJ/9YKBbcASIkTI7ho10WWwucCEVgAs5tSEBCjKVmt7ORRHg6CfdR9x/w6bJloApo
 Wj0Jix6
X-Google-Smtp-Source: AGHT+IFyb3eAv1xiX7ddu+JSsYGi3l72x/m85XtONIY8lhH6wejH96xoAc9Ts9DX2+cOk1RFOOav8VSZwjRIB1wE1F0=
X-Received: by 2002:a17:907:9624:b0:af9:add3:6bbb with SMTP id
 a640c23a62f3a-b04b1476d1cmr1795631666b.29.1757596342635; Thu, 11 Sep 2025
 06:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250909135147.612345-1-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 14:12:10 +0100
X-Gm-Features: AS18NWBmBpygdNTasc00AOwPfcJBIwKmhzNTpFL64oZ91grxEXP7tI5etS_AwJA
Message-ID: <CAFEAcA_oF549W88Aorh32xy+nkmJsyVnJpUn4AA44VKcO83Nng@mail.gmail.com>
Subject: Re: [PULL 00/23] Functional tests and misc patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Tue, 9 Sept 2025 at 14:54, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Richard!
>
> The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8:
>
>   Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into staging (2025-09-05 09:51:27 +0200)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2025-09-09
>
> for you to fetch changes up to 2fc170bcdc4d2f05534c68572b4f72a7d18c2119:
>
>   tests/functional: purge scratch dir on test startup (2025-09-09 15:45:33 +0200)
>
> ----------------------------------------------------------------
> * Silence warnings from the undefined-behaviour sanitizer
> * Many small improvements to various functional tests
> * Remove remainders from storing avocado artifacts in the Gitlab CI
> * Keep more meson log files as artifacts in the Gitlab CI instead
> * Re-enable -fzero-call-used-regs on OpenBSD
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.2
for any user-visible changes.

-- PMM

