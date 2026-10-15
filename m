Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEABECC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL7F-0006gO-Pg; Thu, 15 Oct 2026 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL7C-0006fs-Gq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:03:23 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL7B-0002gk-0l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:03:22 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ab3d3c5761so44086737b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792069400; cv=none;
 d=google.com; s=arc-20260327;
 b=I91+9OyZp8DjaRX295BCA3bAuMrlCd4cLgu/43cqst9bNc6zlIIY35NM8oFrYsYjRO
 6l/3pMgOMQ3ijNnd3kxW5Q5VB9NeEQ9H4gQwkEgNsad+8BSC9hZm66hTPY8uM0UghwXB
 iF1A69WOC3gY0RhyKNgEnXqdKAB8nOZeYnphZhVlJ/MHKJtGdWD+PHJvgFsu/CQrX9Ql
 RP+RToO2dh5OZlZww6qTlGNLg4I+d01ic6ILMoj8ZeuadRlx7ilORoschFJD5pc8CzYW
 5EuSij65PoAUHthJZ0QNx+MIy/oFcJ43kRQw3beYgeNCyaq3HbOwqsFSao7aomXgsF9S
 1sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2XhhcCKa83qkhWqWSnAh5aVDUKVrsLbFwX97HYthI54=;
 fh=Yrx4vQe00BZsIPxO4F8lg1/YapBrjycVHbvHsbUERps=;
 b=BQ765TMSADBFBZA7KlBwhwTLRsKy6xeAdhDOz/g7V1lv3oj9LdFcVJp0ck8cJEYvAo
 5LBc01zzhJeGtnoguE53qS7EINagyHQu1ISytH5eeHF/lVzqIcLJZ2xN3cngIcI7vR2z
 uZCyUIjtMZPaOvLSrJEw6ODNSrD1MZjZw2bIJY85PELSTPafejY7ZcyLGIOEaTnLnV2S
 M24384UdLjJFI8he2xdZ4iUX5as0e4NwFCHEQoyBOQeqjh5C9p4k/0zU+uszQ8XoOhgE
 Uwi2YMXi83MD+RUdJbxPY/Cgw6rDDkenLTy7H1PM5Kbzt8XuLzbWrwg+BI4wXvnf+YBI
 b5VQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069400; x=1792674200; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2XhhcCKa83qkhWqWSnAh5aVDUKVrsLbFwX97HYthI54=;
 b=f+er6R/27u5sH3P+7r8bL8i0c8MOGzzz0t690lKgc8TWRDi7R/BrYybscCd/UZgYGp
 jb3bgUsU/V+GpvRiZkaiW5DM1Naq91hUyTZbba3aev5cMDW2y+9M0GM4087/bWBVd1dq
 fDFswQqVoYQS0BINv6JYuVVQeRREcDVK4uQXfQtuT0rme5fMb64XUCp3nnU3qbr+4k8r
 ex9CASH+NGmtpWpxIswwWt/AVQug9VR8iUkR4dcLxEtisvF8ETFmfB1KK94uFM6/jQmm
 Rkem7lE/l2cL8rij9Q6aBwW74JwPGJ1J97YZpYqetVtLMnSJa3dhUJ5xsB3toug+pim/
 t/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069400; x=1792674200;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2XhhcCKa83qkhWqWSnAh5aVDUKVrsLbFwX97HYthI54=;
 b=rnO2MdCswI2qB0mtiBxzUkqqacZHOjyISOer4jV34WMqIwOp5maZdJJ0fpZHIB1tWl
 cKavxQyzIFzWUh9E95dvrKYNNJvGh++VwBfIzH1jK6JBUAE/q5/68GWf2SIktwWSxNNp
 TA4MY5lSx40sKZ5fbRkz8r4rbV0RAGDnY8em74y57WwBrDUKr4RD9Ais4EnQ9fkJxOIE
 PAAnSt3mmjZLfDmEXdaqvHYRhDhDjiy90DpG6GgNHuyyE+KkCfheNHqLL/rhqi4qrUyc
 +0OVIR5QJJCK60PBNJevSWVubRWmeVlWcJ8VTS1Tuc3fi7cncirV8fckNczGPkCKXpB6
 NzfQ==
X-Gm-Message-State: AFq9FYKiGt+y0/4ycNrGifH0fWPqVqMPxCBU2t7LJaJhj+llCDXzdy5P
 3B9lLFZX52SSAfvd1vcvDGSHyhPQXkg5UjwBLV8FpzYfM5lfwvXr2ciW3yL212yA1dZvR6hFvVd
 XrxI14PNjXUdPf3FefPc+vqvMyW9PdLSTzY+D4cqTKw==
X-Gm-Gg: AYBFou1IVK2rbwLBywz/lX1IPGzcbc7kS33k7AV1bKeFHVMTD6xEJPwgQK44UvNJ/I5
 hl1zkD9UtLmL6MDqwe17hAi6mmHmb7RXUFvMMT2NW0fk5edKWw415Uzey0nnEujNillh8Oqsgg8
 HssiZ/ukulLMOAIneOJ9JxGff7Fl8nyN/lScmWaCWHJZffKUVaGHmsuV6SqZuefaff6IE/DxTRB
 mmk+P652TwnhlS0DxUXIYCG+p53nOVKJBhLC7IDGMYhVvy4JSX+DvgqxfV1vRrsgn4WBMknvoJA
 luY/ked/pRwPxmLaqkTBxy2XccZdc6vLqLyAx0+s/GeYgEsB7Q60up6BTRq5eXZnk9p6/6f1jGG
 ohiZc3BFBqs65K5VUju4QgCYh8hk5dSwF/eOLvsA=
X-Received: by 2002:a05:690c:e1d0:20b0:8b0:702f:1d77 with SMTP id
 00721157ae682-8b07ee5ef66mr53154947b3.36.1792069399564; Thu, 15 Oct 2026
 06:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
 <20260725012635.4925-6-marcelomanzo@gmail.com>
In-Reply-To: <20260725012635.4925-6-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 14:03:06 +0100
X-Gm-Features: AclHuK_aiOBfidFNao5RYJOjLgqv0T23QlaGj7ctXYIF4gBVa0j-3dlXvEKdsmQ
Message-ID: <CAFEAcA9DsSgC_rypNbx3h10XGTq2M-qoCgC2DPKEyNNOtADjQg@mail.gmail.com>
Subject: Re: [PATCH 5/5] tests/functional/aarch64: add raspi4b RNG200/thermal
 test
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 25 Jul 2026 at 02:26, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add test_arm_raspi4_rng_thermal, exercising the raspi4b RNG200 and
> thermal sensor devices added in this series: boot, confirm the
> RNG200 driver probes it ("hwrng registered" in the kernel log),
> reach a shell, and confirm the thermal zone reports the expected
> fixed reading and /dev/hwrng actually yields data rather than just
> existing.
>
> Verified locally against this series with the exact kernel/initrd
> assets this file already pins.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

As with commit 49aecf39008eb, I think it would be preferable to add
the couple of tests this is doing into the existing initrd boot test,
to avoid spending CI/test time booting the same kernel multiple times.

thanks
-- PMM

