Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B0CCD98C5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz4V-00076u-JR; Tue, 09 Jun 2026 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz4N-000753-9R
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:12:51 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz4L-0006PD-3f
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:12:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-beeba001887so761689466b.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021567; cv=none;
 d=google.com; s=arc-20240605;
 b=DmWFrWIwT15/6D0aT2whXHVODA3GAYzQ6lznMCQ/q5+qh/9f6pUyFujY1Ue7IBiVgf
 6RM6CWu5FdkIGEJcPXDNFqd+RHGg7f95NqD+BrX8c8eKwMh5Tx/k+EzSEMWQWuh+H2hK
 SSDdSFiGLv7TAnIql5Lvj2E2/tmXMjfM2t/OkAL7b5o6yq3K6dDHXaMp4Fs6hqNkmAp8
 kLlv+SrrYzX1SX7pEINSj/WL6eg/k2nH4LkEKrKscnj/AZgR3ruUKroIxv4aPaM9Lg5D
 jQHf8XsH4iNtM48yRuQMFWLef6oxblEc9ycNQH5IVMYc9nwNT4WlzusG2VedPYYWy3nD
 rbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YYsc94xhr0awqd86wM3a2E9dmejW4l3RiQ2v50Wzr9g=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Z7yz/nRxuNsqp/iZtXmAHksLFK8JM8sAswh7MPnTJVA13ggC1Lk6+G9qF/LbMjQZuf
 RjYZlIS1z7M7lrLhj7+MhfBj8eXW1skTr3ArmCDuXhylXmEf1nEXrauhnR6lhcu+ox9s
 Hkz2WDA9W8kGzDgY7tseC8UWH+lT+xx7lLD8gGohmjbClvxlNzR18C0f54jknZdAV1qx
 qoeK8q9VfafPZkNfhJSqrjRLj1Bg9/rzt06W5DTwZvPXsINe3NglhOgMy/Nj4cOiacZA
 cfaCK06/04n87gvHQWxZgcITlDQiWEHe9wDHVax8lXsc75BUQfdaCOyHWxOIXLqPPvHI
 PXKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021567; x=1781626367; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YYsc94xhr0awqd86wM3a2E9dmejW4l3RiQ2v50Wzr9g=;
 b=OocZFT2CuuYfn8G/O45jTPMd4/cFYilXEg4P2hkOlyjcPUWst/mxtQ20BQ0q6utFl5
 DTBOJxiQXD/BCwq9QqZBCi1cjhWbtK9aUAyTMIreqcwVasmpne5CG4Q/Oy0JZMLgffZn
 9kVt8qWwCZyuayUbHcotyF1ZcGpxVcWCIksuoY1QZJZBUOJGj0Cj8EGAikNFiua3p+0M
 7hTAEHN5SZcSKTKA5tt1E/AwGg1KnYylxe44RHRIT4RqL7jTda+Q1GAu9X5FSwkqgXkI
 JEZrQXqg1Zv58b6xwjzs5//WVb1Pz6zEjqs9+uY3yN/0TdHSTuSi/npw9hzxHVrq3Pq3
 lQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021567; x=1781626367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYsc94xhr0awqd86wM3a2E9dmejW4l3RiQ2v50Wzr9g=;
 b=HRFa1fVqt6NEEdNwTiPTSoQZV0eRAUOuNEzJPmCH57VJ+43eGG1usD9FcNqG4LxCZH
 MBXQ2qW6c74mDAWYH+ORxFGDF2UNUL2qC+kmxbvNKm/LnigkahvUgFBmsUPMw6lA990b
 OgoC5WO15DaoHt63+QZJkbroEiE2DYzaEQdcnaJiAfXit/xMajDG+Nhs8LxaaxujkSbV
 E5WqX9z3lliWVnWHH9WORf/WDVsAGgzC5ZQMZ38bs3xvyZK35CkAB7v00uwxafWz23py
 /kxfMlgjvXtAxSlgAGUcb+hrqcICSdkCqjFoU1BhPJXzfrAF0Z+HOBNz9dgjAyniA9m+
 uSRw==
X-Gm-Message-State: AOJu0YwLrfwvHwpeNrL7L+xUflQjgNw1ZED966i+NyyWtfrz45k13wrY
 vVDBZ2MfPma2wvr+9NWXrUXhGgBvmw01iHWOpGs5AAlFd8WBHr52SRixIgC2+YISPl//09kPURi
 QMZEYLNE6xV/qa883OJFdKqOBjc6WldgEbQGtUvvgd7dFylHMEMUP
X-Gm-Gg: Acq92OENOXqBYNVcF7gwfWPRobbHbUcpf2TJKkqmpTp2cISiGBbeuX8hqakgO3Ht64m
 NZp9n5FhuY9QLMU0wlcj9ptUPt5jS4ejzNypZuvq4yc2wzT8pjzg/aPIbgZKbf+Ucf6K9EpKXeD
 wXmQp+jeXjM6I5YzIo9uYuJF09PX02P14ajzyR17ta/wvVH6o0w+aqtw5bBTT5O7H6X/HsJf9qV
 mW4S3gzIrdjJVClMdbf0lHz8xvma/3QJenQMDif4cu9RzuxlvNa/Is0dGKgRYOHe4tHy+ZjJL7e
 vu0mznXLGyx/nPrB1MNXBFBXIKIdGYOlizEEAWOfeZFdl2ZvtAlbWuFsXMQnK1g5wbuLMrdLyNx
 8Fg==
X-Received: by 2002:a17:907:6c0f:b0:bcc:e8f:c3a8 with SMTP id
 a640c23a62f3a-bf3738f1e4amr1020776066b.29.1781021566747; Tue, 09 Jun 2026
 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-35-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:12:33 +0100
X-Gm-Features: AVVi8CcYY8u_vo0WqmfW-Ajvzrf1ZcmpNYN00i1kqO4G5_EJw7xQP4Z5mCaVnCs
Message-ID: <CAFEAcA8cV5pOk8kQjYFb85k05WqM9XjuETHM49jbrLKEdKe6tQ@mail.gmail.com>
Subject: Re: [PATCH v9 34/45] target/arm: Implement FDOT (FP8 to FP32) for
 AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 ++++
>  target/arm/tcg/helper-fp8-defs.h |  3 +++
>  target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   | 30 ++++++++++++++++++++++++
>  target/arm/tcg/a64.decode        |  4 ++++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

