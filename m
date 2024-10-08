Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E82ECEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB6r-0002GR-Ub; Tue, 08 Oct 2024 10:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB6q-0002Fr-Rv
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:22:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB6j-0000bc-Pt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:22:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37ccd50faafso3761568f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397354; x=1729002154; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mIOwIE4dnIoolyLpGLimDS0AFNW4u/gKwOEM/yPvXxA=;
 b=zcziX4jwAShCTmCL8aIQQN3Lb30impBe05WxardqgtzLs/mRym8mhmhzaUR1kbnrwE
 hSFG3CjlLrYZoW15ZqjCN5DF8Y7uMct9wj8Pkq3cGG16lOKcdLlsGUB05Gn0NsqxtFJW
 Em4j9gDSeu8fIHLNHYTDfPbBoegjIShz80wOdzE+8cHxsD9xrKMse3D3fzO9IiCa7A7b
 iA5xyEm/fnTBLYaR//JEQpiUmBxGLT7jWd+aaRbHIbl/h/1vlCiLDeekntk5hnsAr02/
 pFCOS08zyoG4nir1BVCEXccJHgXS+fbDMHHdn/D9Jy417Y5J9Vf8k6kem8EnStwlu3z6
 75Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397354; x=1729002154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mIOwIE4dnIoolyLpGLimDS0AFNW4u/gKwOEM/yPvXxA=;
 b=h1k/eLNRUw8HMFnov+8+YWzu18tSINuBQc0BTht4csmt41kMxY7tPpyRxV6C0cP8i4
 thJWVf3auPMIrEiRzXlxxYzzqcvyBHQQgE8xGAeVDVfHrM1LOQkwmvvorbipWyjF4QhO
 uqcmT9KxXhD+sx6nwwNETHO5nQIo7XW0FY8L2FCnuQ8am51ASlRTCUwGQsB6wdxd3/AR
 eKkNCzG7T95wLZhbnopBZLhSP3B+X0xML0YUcWXD6F/mI5o4Ucnr+lwQ3EXV4rZR4vjh
 N3TIOJDuAUaGSsVUdiXEidRKoB09j2bKUIGk2/2wnT+vBNjxf61srNWNAuJQoPZMxw1a
 vb/w==
X-Gm-Message-State: AOJu0YztqSVp2q9l3ScT7p4RD7ery4GRe/ftPm9iqqXgsUBazAkP/t9k
 X+VRe4SUoFB3ttSfsm1dwfIJXN3rXmXgXZK+OfWfBgkE7Euf1ZZwwGB4RnF71DBP1SHdsKdXj2E
 JJzWSzQhGDcW4WXep6l9Fpmi7AJmf/0mHKXOufA==
X-Google-Smtp-Source: AGHT+IG4DScf133UOLJi0v/dH7Dlw/hjpi7mdUSEXGkfcorU2vYoBNYxL3zcPhTqtqhDp7hvPo1uf/cjZhw/yLcgu+8=
X-Received: by 2002:a5d:49c9:0:b0:37d:3759:bb8 with SMTP id
 ffacd0b85a97d-37d37591daamr704491f8f.53.1728397354228; Tue, 08 Oct 2024
 07:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-21-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:22:23 +0100
Message-ID: <CAFEAcA-vpg_Bun4r5=e7mghzWmh=rP+AHup9drQqzqjz4ON40A@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] target/arm: Add arm_cpu_tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fill in the tlb_fill_align hook.  So far this is the same
> as tlb_fill_align_first, except that we can pass memop to
> get_phys_addr as well.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

