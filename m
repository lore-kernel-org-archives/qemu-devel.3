Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23C8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvYV-0008E4-Bt; Fri, 01 Aug 2025 15:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhttf-00025Q-Pt
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:24 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhttc-0007eE-NZ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:50:23 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71b49bbb95cso11832647b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070619; x=1754675419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BmUGzLsZ6tbNmFepMV83GbD2oZNnh2iaQmNk9k2r7us=;
 b=CofTT2i7QCpUh3F9dl0f2ZJAx1TMHyYlHJwwXabZxNzPNrv9mhuVqWhAz0Qe2M42gA
 P+A6aOdieofzr61h36OFC5L10h2CB5nY8cSuBNEE4sRkVw9gFRmN3Yijzg+tMfA4+32n
 SApYHZrJ41SJ8CE4ljQ7zDUpkhwqQHl+26Uglo1vpCgkLLXt2ez53KeMW+3BPhVA+S9s
 Vy04go78+My7jlpAmEHEzB9RtkQzleopSRlhISK8qLvIHZ5Ngk8GUeo578X8GsErMpWG
 jIr7OlvSf9KzSUfYBFv7Frqjq3TdTfXtK8in1CLJP6X0fZieSoN3lDQZKEWO/+Pw1CIm
 OSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070619; x=1754675419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmUGzLsZ6tbNmFepMV83GbD2oZNnh2iaQmNk9k2r7us=;
 b=cE1hYHeFVOTIIWsOKEJFbKOfTo/YLn+8zYQiQraiLFJEzaHKiHy7LHSKDpRb7Vc8We
 ohni29uBTKq2qpm/ibl8cjUcNaUthXZfIbDHFd7XmcmrANfQ7Nc7gEhkyJxVWIwEnfjE
 gpmgn10AssFy7NfesyHZT4wMOTjU7u/fX4jdRSX9OYrLy0gDJtTz9oJfYNEMpPidhwe5
 vzCrMvkwt1q/phLmc9KyED9XNBgAe4/G5KLpcvl6y/MMok7BO0UqHT1iZr7wykENpNUh
 lKy/ktevu1TmJ8VQ+9CuZHNe38jYBKCbAH6YApKMtkmVvc36RmWHWe/3icHqLl3GJF3Q
 4CPA==
X-Gm-Message-State: AOJu0YxkzOmcAYbgO6eT6E5DyM+FfLWgDVHkqxgiPVmF8npn5MUjNk66
 sp9zBazRqITp/PZQd9pQ7Tujbesl6lDeLYpqNzG7b51HQHAxXkKYRGAqWxbN4gflZtB4k/9ZWIO
 /CobcuSAeAplyNCl2IWDjRJRe++P8Of8mGjsAWxTNWg==
X-Gm-Gg: ASbGncu7NsbD3+s/mgfjkgTRZ/2jUI6jcaEcm9HWtsC7kRt0tZmzB0ldJV9lcEKBmeQ
 FzpUTWJWWMmxuY2GD/OhfXmdk/bVNbv4KwS5EXKdk79iq1zLuZc8UzLPPQg6ZcARpvPaJPz8pzW
 3wjoO5GkjC4wTz+DHHcDEm1b3yYc33V3j4zFT1+Kc00urVFLiA8usI4wmC4p3pd1oIIJqRksSMj
 CSu/k8f
X-Google-Smtp-Source: AGHT+IGwsfu6dJRgf7w1a96wWHcjYRMSpPAQFFc0QjSOFNzwolpR+pnKxvQh9DWNoc2gy5lR+JVu+KwnMATvBjJcvmc=
X-Received: by 2002:a05:690c:c93:b0:71a:3ab7:bc8a with SMTP id
 00721157ae682-71b7f4391admr8404097b3.32.1754070619327; Fri, 01 Aug 2025
 10:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-54-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:50:07 +0100
X-Gm-Features: Ac12FXw2HZbQNu99ZCQzw25dvjCaKUmS7i1HzAiWlfbSmr7wE1unSC9SVFheFn4
Message-ID: <CAFEAcA8i8_OE4TVCuGyXDvdGiJ3Hbp_OjD2RvhUd5sbA9F1F8Q@mail.gmail.com>
Subject: Re: [PATCH 53/89] linux-user/xtensa: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 30 Jul 2025 at 01:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                    | 38 +------------------------
>  linux-user/xtensa/target_coredump.c.inc | 38 +++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 37 deletions(-)
>  create mode 100644 linux-user/xtensa/target_coredump.c.inc

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

