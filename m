Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B25C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 15:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgRDi-00053u-Ot; Tue, 20 Aug 2024 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgRDc-00052s-VL
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 11:56:25 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgRDb-0006WO-3J
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 11:56:24 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f3eabcd293so12589601fa.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724169380; x=1724774180; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bRIKZ3MNZ7awpBYGAovPLiAOUaV7FfVpWG1/wfHWpQA=;
 b=Oe1W5pgTUn5IWotk7ubyuslisB+uGC3PHZo0mYWi+J0Ug+f9pyi3pvcEnAe6Gbg/a0
 0SLoaCqi+0L3seNSeEUlGjs9OrA0sgtE6sNm+Anwctb9ywizSxLJ5HsLh1/d2q/Z8gcs
 NfGNpm6GlSFempBnF0bOjomywDBGvrfVEaxdeQDviN4dSiUANB5cqTWUxuB7i7gpqH0E
 3AC9OE6Z/v8EqBuXAK7zhP4hIDUjr8iywSBTRa2OfsA5HPj1QC/kqBIC+S2JfjrBuw00
 cQ9Lu4IP3cOZVG1AehyfG/SXDlvB1Lkt24MpQ49ex5s31VW0DC6mmxavpaa/bSqCwGTP
 hRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724169380; x=1724774180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bRIKZ3MNZ7awpBYGAovPLiAOUaV7FfVpWG1/wfHWpQA=;
 b=TZz7CVxTMTcg43SSf/TLkhgqM8SlrBdpyAnqVWpvTsIVfhvzNj3/Dtkjn7G7Yn/vpa
 B136K00Zi2mMCbASqH1/sisz71i1XN0up0357IPPWCjWIKQ3Bq8AVcb1SFFl9fipue0C
 uyhtfH+PaEKgKHEWqL74Q65ABw2jjLnDuKoDW57hSFSCq1pymBFB4ypKmKz1E8r2HfBl
 DROWZEyFnl3AdNIeVTCWzRQg5wPw6E0SZCfzuVzA2kbk922g/bbDqUjLya/VrqkUfAn7
 2vDxVpMtxcGxoqcQ6VINsiJjqNDdOedzceuWMYRluxGyjqA0FmvqoBvY5KmMZkyx2NC/
 sjMw==
X-Gm-Message-State: AOJu0Yw9BCm0+tFg4YAD4T6n70JZmGffMFENkDEGvPMRsupnDiyCAPrv
 mM1tbNnPu1fvSSusplpoMw5tTh0UTWMoS0swnxcfnnb/KE1WIQ1FIry5KQwVgcR3b7qn4qYfOty
 a9Zu9uGmFi3N6N+U3erZoIrymjE02DW1Dc6+YdW5hDPGq+9/F
X-Google-Smtp-Source: AGHT+IGwBnVMYYgHj6mfmCPFzT6f3K8MFvI0F2AvQIV30M6thoFMWvrBsKNi0spXFcb2xC7ugQk2IB9/9cZ9xSdmBdY=
X-Received: by 2002:a05:651c:b27:b0:2f3:f111:9bc4 with SMTP id
 38308e7fff4ca-2f3f111a291mr14753961fa.43.1724169379646; Tue, 20 Aug 2024
 08:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240819074052.207783-1-richard.henderson@linaro.org>
In-Reply-To: <20240819074052.207783-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 16:56:08 +0100
Message-ID: <CAFEAcA-tH-Y-1M8Bq96aJNxv3YhCZNHrNj1yFsD6m_NyJdY6EQ@mail.gmail.com>
Subject: Re: [PATCH for-9.1] target/i386: Fix tss access size in switch_tss_ra
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Mon, 19 Aug 2024 at 08:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The two limit_max variables represent size - 1, just like the
> encoding in the GDT, thus the 'old' access was off by one.
> Access the minimal size of the new tss: the complete tss contains
> the iopb, which may be a larger block than the access api expects,
> and irrelevant because the iopb is not accessed during the
> switch itself.
>
> Fixes: 8b131065080a ("target/i386/tcg: use X86Access for TSS access")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2511
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/tcg/seg_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Not an x86 expert but this looks OK based on
description and what we were doing before 8b131065080a...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

