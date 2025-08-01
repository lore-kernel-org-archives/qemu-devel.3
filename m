Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E393C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvPA-0002Hd-6w; Fri, 01 Aug 2025 15:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtox-0006ex-Ky
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:45:34 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtov-0006rq-SZ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:45:31 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71b49a8adb2so19676697b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070329; x=1754675129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=15/+eZ9bzYGY5vDxJQjP7LVN41KOH9FDo8jxouBiaYg=;
 b=mkioIgDVqcmsq+HqP5VDeP7/9JMRyhl/RbW+qoudtAEgqsmh+olYMOujcmLzbGn6wD
 HOZ3w7zgEZih5yk++hD1EiGbyYweNZPmoY2H5ASjRunyG1UmnwNWw0YfopqWpkkP/JFP
 LjkV8ki4Prdw2205bbKVzOTW9rdypFUpUPKHtgXa6IQkIiYCN5Q45XFBzJD1Bxj4BS8K
 pYcxBJ6pnL38dqgwzCNoZD73ElQI1bmJYdL+He2NP9Iz9QLWZoFWTfW0ruaIF2fmFEVT
 69VxCd1f7pxk1Cb6x5IRE/lr5pHGLSAI3gGApqnMtlE41X6maZwIAKwt9p/cQH7Riqmq
 BdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070329; x=1754675129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15/+eZ9bzYGY5vDxJQjP7LVN41KOH9FDo8jxouBiaYg=;
 b=vbTzYbo0k6+1ugELxfu9/xiVkIirVqvvtUmqv/4ShedEC2vohsKxTxjB9Iu4gxzVn7
 KEgx1RT7kd+Gq5gwiw65YldjjSVzUSBeLy3GwwG/rU074nvs8K/sSWusoJ9LyttLXXk3
 bXWOiv0zrVZoOJRCSVTxowomOLI+tpr/TebhxI7dA7UyEVJD0fnUrCie4tNYcV5a25Nm
 Ef/x5J6e0azg5a7Ohp0gOBkCZMqIBLS4UFg8zOBX7tSgGW8vo6eh0SNlHDItj3qIeIQZ
 ziL3SZ7rlP0o0Hw27dvAe1hJcgc5mcYgdDRtzs6Ignz6y/JY8inU+VzaSdmbP6glRPKI
 DDgA==
X-Gm-Message-State: AOJu0YzTAxLzMQH4VlXmFTIaiPfUZXD2vmNiwosIm9C73aSzuQxlYv0M
 M8TzXx+JOruv3yxp6EFzqpmEc3CeRovC3afa/LrFneV2PgLw2meDbwG01lYP98rpiTcSuEoMnq6
 wPv+n04m2WkpJAAw5akfBtJGW4kIRhE2vk51ueolodQ==
X-Gm-Gg: ASbGncvhfHNZh5yQFBMMJMSfHHW4h6rLkFVL2NgXzbVQogGmKX/0PNhB3o7xY5krAMf
 /5JUghgxEBJ5xWy/lYzLRM1O2x6ZIjJu5HIIaRPf1GL/8XcuaoxOz6dNEhTp/cvhnNq750AJMoM
 8HTj8C6RfKPtaCuSi2ZeGfP9Z+rFWpOsGJHDx263+akCWZB3RglYzWq7xS+W8qXc+0dcY25jcxH
 ntVO82PZr3tNdbqxKE=
X-Google-Smtp-Source: AGHT+IEpDRruq8TItaQJcRp4W7HqL4VLk6OMNAqC/5Z14KXcMs7nciKFlxDhNCzCAULOkEXASXQJBzZoY+SVXZyKkNQ=
X-Received: by 2002:a05:690c:6085:b0:712:d54e:2209 with SMTP id
 00721157ae682-71b7f5f743fmr7614237b3.14.1754070328673; Fri, 01 Aug 2025
 10:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-42-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:45:16 +0100
X-Gm-Features: Ac12FXxqbXBPE10iF0iu-nS06A6Vz0VihiH8PS90rxlWSaJRKBC0SmIYRAj9Hug
Message-ID: <CAFEAcA_FtS6_vXXWNb2DrwmHuTODMpK_awnYGCaTdn+wbFuoyQ@mail.gmail.com>
Subject: Re: [PATCH 41/89] linux-user/x86_64: Split out target_coredump.c.inc
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                    | 41 +-----------------------
>  linux-user/x86_64/target_coredump.c.inc | 42 +++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 40 deletions(-)
>  create mode 100644 linux-user/x86_64/target_coredump.c.inc
>

Maybe we can come back to this at some point to convert the
.c.inc into a proper .c / .h file.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

