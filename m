Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979ACCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTJI-0002Vo-7W; Tue, 16 Jun 2026 08:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTJ0-0002Rf-2Q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:54:15 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTIy-0004sL-NH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:54:13 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66077f6c438so4462070d50.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614451; cv=none;
 d=google.com; s=arc-20240605;
 b=aQW/UXqqTvqoXcTAFqTQiST4E8GqXai+9iVLqQP9bvQ6tzfb7wtdgs10GenOR/E7s7
 8GckxGfmr25jLW9jKo9ax0XWm5OU66AVDPHc8W0v2yZrnsBZ+gN5HFvQ1/MgVqLy4uul
 oyE57jIdCQ8FoKfMcyvs4vWMjFFJIu+Px8aBWyALELFkYv2EYdsGek/433+RO+mQe1AQ
 0T89Umg4MRqPda3Y+P5yKejprEUaFiQx9etPONUY2+sRyky9kdeCWvQYWEKRvqcfrn3F
 Q0Z3r4hUK0a6MO7tAt4yRNoCgEebTGkjDRnZFsfUCb5/ZcPM4YFxWiCmyQbGvodbHaaA
 YhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b7ORtwr+bgAFGcFbGFQyTBKbTb5kga4FdFmDpH9qMEY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=fHYamGoY+umlNT6JZekQSAOA4KPZzsGdNJpzrFim/7Wl4Pt4msMfvxf1o62STyQc1U
 P85M1ATqhrLFzPWCw8tsgo0bGhEfNHUX6j0jSWyxrPngO4bXCBsTFpXeQ2PAwSEwGKEa
 crsUP0ikHwh/XgbnpA0I1NF/sDOa3Xk4EWOv+AUgRDWDUmVCqZ4dfyyG7PE4tYrOC6Rg
 HpfJYOD+U/lYJKJx48KcZ95bPFcLZlGtOGRH1BAaZaPYRMTDs+UeyaqXLwRJxPLfNuDt
 SkEssQFpW2cze82JE8nc80AbmaFi4sr+x/C+7aCaUH1fS0vbI9r1zTXRRP03qlDtHgRa
 OqUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781614451; x=1782219251; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b7ORtwr+bgAFGcFbGFQyTBKbTb5kga4FdFmDpH9qMEY=;
 b=z5uz9lQ6tMpGnF+g02QC+304Iy/dwQ+k87NaFmehzZPNxTA3Pd4hV896Q6bF5rYhhj
 QmX7+mtretLQzdkSUZtLNs/QgO0pybO2UJ07mEcrIACAbUYpYoxtDxKlkjthDk4XyAxT
 DPv2/VF5k1J6TvmpwgDcLdVbPLIA5D2Tu3ZXkufdnwiZNQ19vhci7yoRUpKxKjxHCrUQ
 hyz67y6tHwl2045wnZFSQKq1bTq+4CnMAsqO+hwoXk0+MOaCk04VGFvaFyIXmkcYUkA3
 ac6ZljlCPhr7yVbb3eul2woAlLPzfPmU4c2euS8Hd04XRBrnBR2Ctx43tx52o6HT36K2
 rslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614451; x=1782219251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7ORtwr+bgAFGcFbGFQyTBKbTb5kga4FdFmDpH9qMEY=;
 b=gGScwEEWkhEDwAR17QiUskuI0/rQD8qVI95lEc5u1B6+eh4oBeU6ku5vGv8wfZ+FxF
 BD8HjiI2VsbYnAUgfaMqESwp6KwHredEwffqwixpQCTz7SKeMfYg9CrYb/dH9Tyesg4K
 D2hAwnVDTnVLxnabmLsM1E0n6oFmtFT3a88r9qItcYJl/ftNPielCUBWeuL+R/BZO/Dg
 tE6AmS+O2EP0ACBF27AR0os3U50UqotrYkpBbhGmhBJtw16c6YpsS/Dd3Ak6YnM//cVS
 /yt5YX0h6WT6VU0mIxi9DNeFhFO7cpz8ifcQ6/KbY1EIuQih7SH3eTLq+0NiLadiKZmi
 XNOw==
X-Gm-Message-State: AOJu0YxOLRbaq5m+sQ28m7EM950Aaq/kpkC+Xz3SVRscnilcnwlSydI8
 EAWL1YH4ZwtAA4vOYMdHufHikmynmZLmX41/3RiAnK3ZlIR+dFsSdyOxxvDlHmLaOC6OMi1JPTq
 Z3lYjEQItx4DljbjHqKo407gfJI0oGWY8wMFvaFgO1A==
X-Gm-Gg: AfdE7cnBWK1qpsWG0gIlaBBWIDd0NUuGsFqwD5CSQ0xVoFhD4EU9GgPAJA8t6fHmoOK
 UQwOsqzRYktjDmcJGTTmJLoAdtbl4S8VdrzvY+aCZh1OhS4hf7wZBsUNWdLunN/WPyxBcmEBeD+
 tWYUPsKrnBsTQnPEvXGOo6VhL1iBqhnvb3vLowxRn4+C5LRlJJ3jfWHr+iVKh8V4KeHAwyKiQQG
 FVGL/M7HyZ57z5oHP39Bau5JYloaFgKkSVVO2a5kxKmWPCw60JOuUUI4K263+kyX0hH3G4cAEAz
 xoB/WR8xGX5wNJjGypkCAcOABa3hHAYcBUQaRc7u9woQQAzc5uy/1IVoiouARj0zNpA=
X-Received: by 2002:a05:690e:408c:b0:65e:5110:a60d with SMTP id
 956f58d0204a3-662b614f3bdmr2470612d50.50.1781614450987; Tue, 16 Jun 2026
 05:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-15-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:53:59 +0100
X-Gm-Features: AVVi8CcLd513JRm3KXUYEGtuIdxOxFJQAD1qNGmaD8esinyJWtbrvaVbTxFJVD0
Message-ID: <CAFEAcA8L19Sjg_KXcDRAE_m_d91BqjPPSS81kPu2_ZmXismFTQ@mail.gmail.com>
Subject: Re: [PATCH 14/25] target/arm: Implement SCVTF, UCVTF (predicated,
 zeroing)
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

On Fri, 5 Jun 2026 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 34 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode      | 16 ++++++++++++++++
>  2 files changed, 50 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

