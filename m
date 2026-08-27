Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EE5C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZnG-0007s5-Ja; Thu, 27 Aug 2026 09:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzZnE-0007nM-JP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:05:20 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzZnC-0003V2-VJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:05:20 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-85aeb506b78so14951147b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787835918; cv=none;
 d=google.com; s=arc-20260327;
 b=LhhEZ/YDjoyYcsv0okM3iDu+oZycu5NcGZPg6pdWTih2ixZp8Iny8KPYrxkDg/nVYy
 8CZah+ZqOV0+jlb6lyC3VUS1ULOK3AB8BTcQQ+yHTHrqOgzM+rW32Z69mpazFTFBbhqe
 5/93M7jLAxdpA9WK1IhDMIVTFRektqgDcevc5RfgHwsrVwjtfuTkHgzTUbP4NhwRhUH2
 +1pKk9aPkho/E/JQzp1dfQwJlPWUoVV2crLxcFUKkMbvJVZWBuIlYkHWmOt8B1Inkuqu
 a59AcpMDeruj4JApm+oia3bV644Pe5WvPYE67wE9BVwfrtu643OSTHjxIRHSEnoLjgYk
 HB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cbo0OxZfYoOgj/TCxI2up1y7VYLdVDum/RFjOP8ndiE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=IEYs5aiWs+uRk3cS2FZnYKEOp1mMKLV+TmmO5mTeUJ4MZwZyaKdhK8uPQCFT+lt50O
 Hf5vZPBLNyf+kZdoMMA6ntbtabbDX5LCCbsCSXhAdKss6suZNdwNnlfGkItO9F77JrMz
 4AeiYPOeE1L6zTSjeUsshRb9Hy143eMi2xZXjGDnMIw8wa5BqDTxgjXirhb+Ku2k0XkU
 MnYQZZEnUbvXkOj4hyp1zsoDTOso5k9g8ayxaQO6oMpi7xDGPKCbrqCmytU6P6T7Kxvc
 92ESnj2GnB4vXMpuBS+u7UhhWnQt9q3vlksxwbO14WzH98u+Vw9G20vTGqLr5OKHbdoz
 Z2Gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787835918; x=1788440718; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cbo0OxZfYoOgj/TCxI2up1y7VYLdVDum/RFjOP8ndiE=;
 b=UeoLtN7HHltcL/YSXbdztlEMsgrc06qQNWkzkiHa03skqpzBQ7BZfVQFujMV8aQ4nv
 tg3/QjIobmCaIzZWq5MP89PDJdZnvtUZCk4DKZMAFYkgky89QZkFijhD75KgFNfwuxLw
 18JqyGvBjzFTXNvHIWTPo3JqRuqsALnSA1V6Ixrsux8t+CwFq6ovM/DCwfgcfbFsMooC
 8a4qRNKU4GShZlXxTMMwIuthF2o2UI+dNVkoOadb/iiGcQ08PUIM2eSdPy2kSp/4dvSM
 RdusX0ejm9WWnJYz7XBT/N1CuaWvMR0qieV7HXLyriUzEMVW4Ev/lPUDQMbb+2BF2S7w
 nYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835918; x=1788440718;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cbo0OxZfYoOgj/TCxI2up1y7VYLdVDum/RFjOP8ndiE=;
 b=T7Py1GBqZrQ8L0v4eM7+eSu+gxvufXnSo6PepnhxM2J0L0jGuHUO6tcmbhN35eeEGJ
 leeXd4Y+mDJdTI9ya7aYpAcmUME2aCwAiK906xEiPfF0mC0irvTiDFFEI9Jt26Nt23jn
 0FFJyvxeSyrrBZ8Y/nJWirNb4a8MYD1i7CZgEm/t9tKqpMXNdrdW9otlqdzTs2BZwwiz
 85r/FhEktc+l67ntmf0YVNKoemMUpzL38a1hys1hOd7cPuQ8nloRue+W1Ga4wf6l4TF4
 /y3A20+fx/9NLaBq86+OOnmRVawxHkmj9reibUOHQrhNI269swdIyMyjiV7zXBTnDiH7
 RkFg==
X-Gm-Message-State: AFuF++kB3UO/Odsok+fRzDC4Ar6sTqRr3xFQubVGQC/t2zT56n66Vbz3
 BNk6a2XSrWJ/KFmNMsWtNaTrMBwnIKW6ddYXGiboreW/VFOtPz0qU9ES2XF2eogcf7UmDN4TAjG
 xY/DXh8Y1XDiNSGjdYYg7UrPaDTMHZLHSzYktd0RhWQ==
X-Gm-Gg: AR+sD13PQTR2fdeDy/yRbZq5qLxkY2S+jV5qRlsG8mENULMd7mM69cd3HBfj5r94Gwu
 4u0UZRkB6LHpJYBiR7JvQjrwfSxcE2lQ8wBfzSFSTv6AeVIVAciVwSn1CIgHk4nxif6uPClwh/j
 MzL7K81G3Z/np8YXuUaZxd6gRX6nNEMZuqGed6PFJlJRZ4nXaPJJUOn8+PD2yueN7g88vgDDMJr
 3cAR2geT7/F0rtB6HoUN2it1ypQocV40JyxKelhuI0t6jrTc/Rj6TPsYm2mb0uUw8iyE6YAf45b
 Iwy2FH+ZcAgRzXbRopJwSDKwzxODK5jnQIIahM/91gQYSdUkWRUcAeBWGLue5Sng/KIR8gd8c3X
 U3byKLe+8GKM1I2sxITRPFC5UFTzOb61gvWD1j/4=
X-Received: by 2002:a05:690c:5c09:b0:845:ddf4:a393 with SMTP id
 00721157ae682-8574124d537mr57351867b3.29.1787835917357; Thu, 27 Aug 2026
 06:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260826174213.614571-1-richard.henderson@linaro.org>
 <20260826174213.614571-5-richard.henderson@linaro.org>
In-Reply-To: <20260826174213.614571-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:05:05 +0100
X-Gm-Features: AcwNN1WFtZ0uJIBBGeW4VRplAPu3QIPTNxoWdvUImzmyJW2rly56XwSY8J7-4SU
Message-ID: <CAFEAcA9duyTnvhTsdxAn7cXoO-7jv_CpjZHRJe=eQFLUkfOyEA@mail.gmail.com>
Subject: Re: [PATCH v2 04/25] target/arm: Implement FMUL (multiple/multiple
 and single vectors)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 26 Aug 2026 at 18:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c |  9 +++++++++
>  target/arm/tcg/sme.decode      | 15 ++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

