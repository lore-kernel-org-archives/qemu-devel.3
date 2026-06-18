Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B85CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waECm-0004R6-Do; Thu, 18 Jun 2026 10:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waECk-0004QV-Qu
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:58:54 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waECi-0001Mq-9o
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:58:54 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-662df6a4fe4so1384564d50.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781794731; cv=none;
 d=google.com; s=arc-20240605;
 b=MpBicjK8OCT6B9m97s8RHr+Mt/o8yxS7rUtiskPYblR6APeRT02Oj7GYUrMu4ychdx
 HV76V3Uy03rih4dIAscrIyPN+6gWLmKepRdhzlDeoRXmZJFpzcvF8YrgPq5KiyOJipsu
 z0nZF20Qf+UdeaPg8SMxzLms5c1VeAYHoBbuBAPRVnJ8JoLpolfxiT6533wNkOIrNrPk
 NeWEYfsIMvQKR7p8WBt/yJ+QdAR4FdBTLFKO4CpWouLt+mJ6LtnPw7FcPiGXs6rgCiKF
 t7d6w07geyZoraH+GyAYojxriXfq534+IoTse5qZkVGLM2InhN0RODyZMm+RmYftU0FG
 UatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tUPIscPmndmx5i525GhyoosCIvCSVXyRVhSDHgGvlUg=;
 fh=tCjhYXo1P/fTiS6prP1L86yLrd3qP6xCeSMcNtIhTkY=;
 b=a06zAvv01fw3P4O/MXJ4pi+h+bBn5gjFE4S5zMmKzHSvqnfxGPNHB6FssdqxaLYHYG
 bZN/veyosSPlQjRWDPbV22U2drcHOmSilKkmDEX2AsmUtdulflwzuO4CQUDnTXUIz8m+
 uJhG1BF567zXCFPd06kB0e2v134FnR4I+At/Bc15VVfhk2L5GBZgvuYcTpG5igEGr4X3
 MJfuOXDFdO94sKQkvmL8mISzAjELTpguIM40KJS1ern7CLFnodDGTv0XQeizNZQ9YWa7
 Ej9kt6B5M2UAs+S+XlYxH04xH4ZkcUpde1W7DEeTWco+I+4MIjYzgcCfSZn/TuJKzNRf
 HSIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781794731; x=1782399531; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tUPIscPmndmx5i525GhyoosCIvCSVXyRVhSDHgGvlUg=;
 b=hfzxlS6KG5KQ4TkbN9cgQwJhQHXckX1MSVN0LAD5AS/xfoorsTItScABG82xdJ+/Dt
 0Pf3bgSqx10oAOf0MFY20FCYKsmXJ02NYrAAiH8URIVNRTqhcjnCkjPvs0YsXTG9G9Zv
 DPu+gGF4PVpI0zCEri00GH5h5INU0+e61uGhdAkC7TTNJQv7+XWMUDovczt0TmYb5ZoA
 tiXBWLwFjCQfdrtGseZnotZscmGtgYSFtoHKxSFVSeJQlVXfWIE3/nLl/R8m4iYHXrkJ
 OzrGRp4Iwu9vBqInpGTuAO7F2BJYw1sjzMNGY8dbKJ+DkzX7+Zr86a9MG8SoOibSV9/N
 uPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794731; x=1782399531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUPIscPmndmx5i525GhyoosCIvCSVXyRVhSDHgGvlUg=;
 b=lAzCeA2IgBUT4PvqqBTmBXxDPdWHqAjOfI+R9QJj/idwnX7zHNsB8m7YFC8c4lYA2N
 KPLX+qppg/YfLCI5Ie3c8uG8pGiSaow60RUhP3pUSVhx4OKqlVR/fv9qR+FeD7NSywDu
 WEfJ3FmtGu8tLomJNa4DJxIPKf7VT98x5CsqYPqjDl/cBRTX5OB9UU2nvijKK6M80PQk
 aJjjY5UWp8q5pqgNa2ra3sMD1huRbPH9ejU6hf1fpSL987VKvn/th7a3Pvfk2CO8ecef
 HeulKO/4nqyrk5xmS9QG1nORKxbI7KRObBI3iq2f4Ht5vAT6nHKOf81sbbzFHU7Qixr7
 FPNQ==
X-Gm-Message-State: AOJu0Yzps0OHYvBie9HSeyU3Sj/PnrMHOv5OSdNCQF1mLtBf3SHu7rdb
 tEHGkmll/QEZF3Gq9gSQY2iuIx1ZhMH6f9A5oqkDstJ+LYg5z8ZFDW/Nt8rRD5Qll+PvETklHve
 aC35LZikEzAFhdjz8iMilrEnIehhrSNwl0hJfZYaicA==
X-Gm-Gg: AfdE7cmWgTswlVXbv9BfaIseFnY/ZIOG6O4YbikbKxN93lWJiXuO2zamTQBOtkwTYuM
 w0prAUTX35VboaG/x/mya0hB719h06bg1qgzeH33mK9nsEYIsRgPAUg/eqn4omSXN0ey5Ebmqh0
 u9MpJJQYZ03nkXInD1LZ32BfCwwdkS0AgnhQjc3E3j8krIW0jVOqfxoqJwdBxQf9YYlKcnEN5+G
 fC4Bw7WOfBPavivy69LjqtRjGIGk/h484o8sIyclA+3xSzXRUZnzjtB6P7PhiVX0kuUporFjRL8
 ew048oXLVyJ0c8E8oF9hRDqzqfMckI7uFduy0wD1sKCq7HiW1rt5pJs5
X-Received: by 2002:a53:c091:0:b0:662:bd61:f818 with SMTP id
 956f58d0204a3-662cbd2263bmr6648189d50.52.1781794730707; Thu, 18 Jun 2026
 07:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-8-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-8-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 15:58:38 +0100
X-Gm-Features: AVVi8CePXzKJX-IjgBl9ocCe6xzRqZ5o2_2oIUuWx0lOKwgI1zZN8DzP69qeu6E
Message-ID: <CAFEAcA_KjOEBduVcop_T6-aH_DKy_4=QwTKa04kvKR51S79UQw@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] arm: sbsa_gwdt: fixup default "clock-frequency"
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 3 Mar 2026 at 09:26, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Comment about keeping legacy freq, is wrong to begin with
> (should be 62.5MHz), but that value also doesn't make
> sense anymore as the watchdog is used only by un-versioned
> SBSA board and the later has hard-coded it to 1GHz.
>
> Other potential user (arm/virt) also has system clock at 1GHz.

It's not quite that simple. We use the back-compat 62.5MHz:

   *  - for QEMU CPU types added before we standardized on 1GHz
   *  - for versioned machine types with a version of 9.0 or earlier

sbsa-ref sets the same 1GHz frequency on both the wdt device
and also on the CPU objects it creates (because it doesn't have
to care about back-compat, so we were able to update it).
The virt board doesn't set the cpu cntfrq property, so it gets
62.5MHz in the above situations.

Changing the default value here is fine, though.

(I haven't checked whether the subsequent patches in this
set make sure that when the virt board creates a watchdog
that it sets the clock-frequency here to match what the
CPU is is using.)

-- PMM

