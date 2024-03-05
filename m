Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5758FC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUtx-00054O-K7; Tue, 05 Mar 2024 08:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUtk-00053K-FQ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:32:01 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUtg-0001nv-Ii
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:31:58 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so10049559a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645513; x=1710250313; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wqOQRhCB7IuCXVRIvFLcSu/W8RXwhKm/vJQ4P2++Mzo=;
 b=z3Am3qd6TF61PEsku0o5gK+XtrQ7g/qCOIVD2h3A3k8QrRtX6GG+Lg8p27jIZCFJt4
 9B4p3qDR8vXMnray9jBi1B+s9FVDr7CEwLnOyPp1sl5bcBrGQ+Ct0v6bBJ0Lf9aloX25
 8RQyku1jP1omj2qbwFU+mOQZWn4SeIplQJvdoxlhyW4VtFXbAAhp52dCj5+itRkgICjg
 9Y29IDfVANstwG4UOPN3BHESLeWGphdnP4Dk2pudvvuCxNZKrTCQ14a2Eqh01dmSpSzA
 UMcoBbtTbT1f3nf3oaEqMJyMCKBYTGP1uImyNw5gmBn6JXwmgnkFT2xS5UvA0vHFsVVt
 54uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645513; x=1710250313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqOQRhCB7IuCXVRIvFLcSu/W8RXwhKm/vJQ4P2++Mzo=;
 b=YAKKSbjmkmXLH/gEKhgMNghrUyJ4Xbk8O6NJQ/MpA9uTwEijMoKRjU/Y7l7j1tN79J
 67FyLiQ08v6SMPlvudMuQEglp5seAoyNYsCtgy6HvVWls/8xa2rMCnTIUPaQXJK2e3+e
 na8wYUjbTTMPt/Lc0JjFG9sZUno/IvIPHcTE4FWJ0ojvgRkpJrQpRvfNKRmVhjuFcqiT
 3VjJbNdzdvEv4G7Lf3mNXCQaoUFYGJVw7OcoQhGkHsRrlGNNGkKQcsvqW+T4nn920t2p
 yc7xIFSPcByjeAF9LUT/6PMtT1LbyDzDmrlHAHpyofg3oSY8QCT81Vv9x/t/QqaXum5Z
 PXJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1iYGxUy/jvaizy7jvQ6GCJ81flXX405mdDPTB2oXRMwwvt5SOxyzrN7wXo3/zgeATa3tF4ClXimH3S5KlbpMgt1/DNek=
X-Gm-Message-State: AOJu0YzKgcUe8PM243m1IlQpyaSa672aSKg+XdwrVX9Fz6c8c0zL4tDN
 HFWPgPX0++WamXWAyWnnSNQMm7DjhuIk6L7OA/yK5FYe3vAY/74dC8L9uHDxaGbAEjbRtieWfga
 KtLtyndOrbHCrdDdP8lHpWnDlbUC7/IT2SxCMwQ==
X-Google-Smtp-Source: AGHT+IE/BqnmDo+Zr+vUejev+m47uM7DzoqDnEh1/rP3GLmOeGb7pEKdvfI5M5TinRb07gU3Z03UeuvOZKdvZHUZZX0=
X-Received: by 2002:a05:6402:889:b0:566:200f:362f with SMTP id
 e9-20020a056402088900b00566200f362fmr2774356edy.8.1709645513359; Tue, 05 Mar
 2024 05:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-7-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-7-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:31:42 +0000
Message-ID: <CAFEAcA-mOqBHkGi5gpCepUA_BSxKdQ0icARhKKwXC1yTpQZx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] contrib/elf2dmp: Ensure segment fits in file
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This makes elf2dmp more robust against corrupted inputs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/addrspace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Though I'm not sure where we'd get a truncated dump from
that we still cared about.

thanks
-- PMM

