Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE6FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFhr-000281-3y; Fri, 12 Jul 2024 08:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSFhp-0001xd-9c
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:48:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSFhj-0001P5-8a
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:48:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso3366312a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720788528; x=1721393328; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vdOFy6dxjkSCrkZ+P1e1QlY6kQ0YliHjTaABQ6io8rQ=;
 b=tosNO/Nu6xHyDgZPu1VLZpQCnWSl+TV0sBey5zxHPEb8XQvo7ROudCT9pfdVuQeYbU
 Ddcc1j9Y/HZIqXQwxSHuIyNpFB+UlBQsHf2554DPqo1Iyp9RQvs9f7JTUZqyWX6HM3Qh
 DUPXMFCY35MGkqT4e71xKQ4wt+GZrQRUnnKi2z98Xz9gTpe9wOYJXHkTt5La8engSNAq
 7f9FGIMUZ3fH6KkfIqKsdS10XtDRv2U1WZp0vt+2M7O2oKrNaBDhcHcwnFcu99DGxVNz
 udSSTpVKbl1osRFb3KPOPr8mQUId/XuJRAqxfd7HbF5fOT5w4poa0dg6I+ooKqPjAUIG
 NtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720788528; x=1721393328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdOFy6dxjkSCrkZ+P1e1QlY6kQ0YliHjTaABQ6io8rQ=;
 b=ZmQW3wqMYM+b9BtPbP5Ujaqfok9FcVGl5cc7Z65CWvue7a1X+/HfpfMjGkCQtyDN3h
 BvL3pwUgWb85CX+gmPZPGvuzmOhzpblO0/h9o3sw/WjqN0Ey+fH0Q381IybhjHwbtNyo
 fLgrG3/JrsDUgAA4eoQjF3aLOkUZHsELicoKP+HM66V5bXFAhTVModPBMTVd9Ftxthv7
 pIuvl6jrFe6LooOy/aBw9P7ML5qJVyailTg4xZg6J6NzXt+zhxjYnOFWU488CARBcLhX
 hK4scC4lqRJ0/ZMoxzwnvCZUYq4a8+hA1FP7eLobm3dz0ng4qao5r07z99jCCnELS0DK
 c3ag==
X-Gm-Message-State: AOJu0YxGrWbX1s6XZRr+Am8P+1HNQtQTTFxWVnCvJL/+IkCcigLyYLfy
 ftPrfMfhNdyjr+6RbnWSVun0KNWXfPO4/Y7rv0pkyHJDhY54xWoM8aaQxrZDjikIQHJBkkSvtdV
 xmdrw7/ViMuXjMxVOMQRdJIAa92+MHVVZebJBqA==
X-Google-Smtp-Source: AGHT+IEnkOW/XZVm9n+PCbXy26cBw54AAv+itGuFwGWAS+HDO+EeZzUBoH6x8qdHCiObZlDgiL0iIKOlp98vpzsV6+w=
X-Received: by 2002:a05:6402:34d5:b0:58d:45af:43dd with SMTP id
 4fb4d7f45d1cf-594bcba7d38mr8801006a12.36.1720788527970; Fri, 12 Jul 2024
 05:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-2-richard.henderson@linaro.org>
In-Reply-To: <20240710032814.104643-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 13:48:36 +0100
Message-ID: <CAFEAcA_BsY1mSJ=BBfHzNemQkfy9FqD_x_38RkRdST4cur5bhg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] accel/tcg: Move {set,
 clear}_helper_retaddr to cpu_ldst.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org, 
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu, 
 max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 10 Jul 2024 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use of these in helpers goes hand-in-hand with tlb_vaddr_to_host
> and other probing functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/user-retaddr.h | 28 ----------------------------
>  include/exec/cpu_ldst.h  | 34 ++++++++++++++++++++++++++++++++++
>  accel/tcg/cpu-exec.c     |  3 ---
>  accel/tcg/user-exec.c    |  1 -
>  4 files changed, 34 insertions(+), 32 deletions(-)
>  delete mode 100644 accel/tcg/user-retaddr.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

