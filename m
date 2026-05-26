Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E7ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpFe-00062t-Pb; Tue, 26 May 2026 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRpFd-00062b-53
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:43:09 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRpFY-0003ZT-BJ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:43:07 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651c366f7efso10580705d50.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779792177; cv=none;
 d=google.com; s=arc-20240605;
 b=du7959RmGEjugLULno6aZY2PTs0qdSxxjyU6ctUExexRcZPz94ah+zJaER8nel6VY6
 XLbKcki4iz6imxMfzxBMifBZjiYG8AhyKLQE+qR6vY1z2P6eWGCfB8f++KY4hae7zUZX
 /r1HqKEOVvnYJs9EuHAk5KzV+4w82iy7Zs+lxejkcpbgaltIELQt3a4Cr25PUWz/6W1S
 6TME4jJGgme2nw45EOIfnC2G8/Z1zY7yjEG/5nGYsrhFiGuAjs2RglG942vvmFRYCvxs
 Psno8X6NCO4zKasT4JrjPn1gPYGjCDfWkRlJrTxqV2TDEBM1/5DucYhXedBjBg4oBY1v
 RsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M/UjtwWeJn3BV8j/cB5oDZf5o8Psj2+8LhjOEwpeKPE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=UtS74c82oQPk66FrT3QBrjloBlTqQXEkCb06iew035C9WXU/kupw6hOcwq/9GDPb6l
 ttDy6Ovk0KdhvR1h9ZupVSuxOF9Oo3UdbiAoFd1d4vod8TAWkU1i4BiIrjGZhDnlGpPa
 0Lhu8Hfw6i0j6sJ7U/WvcCflmHcK+iN3SPewA7vnyPTDVQ1sASawCkwEW82odKjiuZbq
 IsWc3dwXV97J1ukHgjtPv7YfD/9Ifzif2tQTQgIGKtB1FEfT7M+J/pU50Z8OqkmaoavN
 c3jMATKS0B+zsLDeL7Lelai4jXQxb7DcVAg9VGeCGEDuDd2kG8HBYtDqrhOxbZkBBHhy
 x7Kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779792177; x=1780396977; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/UjtwWeJn3BV8j/cB5oDZf5o8Psj2+8LhjOEwpeKPE=;
 b=XsEy1gC26etHDgynCrOotamUoSVKcRoS3qiDQCKF3ypaNfvPOjVGGHAkB7KSDSS8fP
 zcGzAcQMS+s5u+JUYBihsywhXR7jCHzqSQIubZg0mGwXE3114bawo55PuLnXi5YXazHq
 hR4zob2/r0d35Hzh3+z7B5huzN/zK5TnpuVCRiWcbc9xw7hhOI48JGXMQEJgmLQiQC0w
 3F7seCjg02mvDQowfqnp7/9944DT+0n3sAximjFy/gGl80zEodpZ3U6Gu+WKPaS2RtWp
 BwzXsu0sKrH3wPVD+mW4UMNiKtMS49beCMKvptm346lF15umsX5yI7Y/NzorlxnCnB96
 9CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792177; x=1780396977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/UjtwWeJn3BV8j/cB5oDZf5o8Psj2+8LhjOEwpeKPE=;
 b=OsLGz0zsGAIFV5rvOiINr0PkleJG64FI7rkJ4xgp3OwUmOWjZrngkyABe1+AvIPKEr
 FI/6bcfivyTKUXShTx25gYdZBjE73N7ZyfJ0MqQTgslZfILOLO5eh9ZPREuNB7xpxt2o
 kzSfaITeoM0zlpye2ST9xA25lYknGMdezIqKgSZ/+bmyrPqNfZ0A5T340xCGGBpUSi/k
 WJuBdnVoBXKSuPrB45ZFl+PJBILuY3Jz44Gt9I32BTMDDl44SC3yV3AT2S4em1kZ3c3M
 kyCvWwh4svH+W1CuSi1JWV3Sq1VAUrxpjAPpKecOPWUN1TkttUeCo8i7N3EbTosdKrZB
 wgyA==
X-Gm-Message-State: AOJu0YxOOyQalcpWuahhuZrgBjGHkcwQtTTONXcGqF8HR9iQrSC82LSi
 IQsF1ROFcNkD37XQ6xoyHWt2DeaQK3sZIxyBQUTM+FuwSoIFagZ/1/6eA1W47H0cbUmDLep/nnQ
 PLkACaUl1UdTOTFq5CRvUiJRJWqvQcCs6ev4HRyAGtQ==
X-Gm-Gg: Acq92OFCc/ZEkRDCen3qlLt+sgfDOf20OKbdQZgYH3n8Mw6u6FG92Taewj3BqmpgzLX
 U5IPMBiMn1/u5ZQupGGiTXusuISGGQhJOhIgAWn5Jg1/gwFcZNt9iVRLeuCUHsn8TnaXpMV5Q5m
 64QXx2izT2WjG8WyoTMwFSm7uv+u8tZOZlPkPUHvj/DUG3USFCOYp10y0FO9jXlc995fEBOMKeJ
 o0pzBcqjsXcY1XIJ29baEzsMAycDJNtkU+LOoZNZc3ndNAWHexrimEKQ3TmEPi+TJ4XX11CeaDi
 yh+ggFpLInC0r50LjkO45zs0UjGWiemPDF4fnO3pf6Raevi0Pt6p7NKQ2JvnYJwxKA0=
X-Received: by 2002:a05:690e:140c:b0:651:daf6:3d82 with SMTP id
 956f58d0204a3-65ec98bdef0mr16952737d50.42.1779792177020; Tue, 26 May 2026
 03:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260522220306.235200-1-richard.henderson@linaro.org>
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 11:42:45 +0100
X-Gm-Features: AVHnY4I1L5gT8Sq8fEIo0Ks2_EflK8xAj3C3OWx2scmoctjfNXRsNjoHET3Lx9Y
Message-ID: <CAFEAcA82v=48FxXuddVi8JHDFK+Z-nM9Z3oAxB0K-xoO=ZNEbA@mail.gmail.com>
Subject: Re: [PATCH v7 00/64] target/arm: Implement FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 22 May 2026 at 23:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260522182658.184604-1-richard.henderson@linaro.org
> ("[PULL 00/30] fpu patch queue")
>
> Changes for v7:
>   - Lots of patch feedback.
>   - Split "Implement hwcap bits for fp8 features" into the
>     various "Enable FEAT_FOO" patches so that we get 1 or 2
>     at a time; previously missed F8MM8 and F8MM4.

I'm going to continue to review the second half of this patchset,
but for the moment I have taken patches 1-23 into target-arm.next,
since they have been reviewed and the fpu prereqs are now upstream.
(I've added the comment I suggested for patch 4.) That gets us
FEAT_FAMINMAX and FEAT_FPMR enabled, and chops a third off
the size of the series.

thanks
-- PMM

