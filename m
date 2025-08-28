Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB2CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJ9-0008PY-Vn; Thu, 28 Aug 2025 13:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdfT-0005o8-Rm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:04 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdfN-0007uo-Vo
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:31:56 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d6083cc69so8666377b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391511; x=1756996311; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2E/7bNCQUadNvWzTC7R1Tflsb0SCeF16uhVaDbR+2Q=;
 b=m4KC13d4xXVNUEmeuAmtV3s6bbwjt/YJkQgSkfsfVMaL67+LzUqpMcsp/FYkY1JxJX
 Ct3HlGa7sbRqzu1xL9iKf536EoUmDa2jplAVZmtJkU0fuuf9JBm6eaLwMD0gD2eDhUt5
 tFObAS1fcFX5U5OXQqo3uyd70wZmo6mKo0TVyJdE5xhqtNavmhcs2ZchSTEI88jmAWtH
 xzQWIYEQXrGq/3eCKe/8K6W4pt07uDGI0GyiLrYvq1ilm+LW6RoILwAa5ICxpHO61uiK
 BrgyHVWBaIHzzTpEmWzzqwTGM0++xYS8bR/QiG7sZa29amsm4esv5DF7TiYGl0Z/eFhQ
 RR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391511; x=1756996311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y2E/7bNCQUadNvWzTC7R1Tflsb0SCeF16uhVaDbR+2Q=;
 b=qtdmb88XHl955g34KNqnI33dP4yesg69fc3v4f51wXWzyC4TuCGi2lS/sGamBigvLs
 ptroEpyJvUUW4NidLvRK3WXnnDdyIg7cKJ7Qu4gVKkBDWDWmzwD7oQLa21fmJEmkY/5A
 J0i+PvG3hlxyqGvrCWwgmZ5HUnMIswQchs/+h5RaPRCayLOME9MsZSnNbzhN/h94O1GO
 SAj86pyV2CBLkX+/FEYFDo0qKPz7iy3c/1bVHmAP38Hgud+HZRbPG+0gHL2/sUh+G2yn
 hg+DKePjB8GY/oyWMlNhIpASAUQAd3WcnnScuJNa0/ytFNnb13HG6QkRsu3WtCkvHsmy
 Mmrw==
X-Gm-Message-State: AOJu0YyecqV6bqYeWzLNZQyHM+dSfqY4ICVxpSGfHCTkjRhx3oSMP8hf
 j8jUy2dzH8XYczmw7g3V2rOZQrEbPhl9hMXI65+leylOoN/cTdWYcpybiJNYTLvIhxp0qoHCR4c
 SCeHKEaIrtD3XCDm9RzdD8Oqzj0iEw7XjO18zMdX0PlNm59myqhYv
X-Gm-Gg: ASbGncsers/xWi6mTLjEmCg3zBnYTzQp6VmB4wGN+L1wLLrwPbbtMyRyWCpaBFR7uAk
 IyJN2QLrNg+UcMnqekUtNkM2+zqb8+pVoJEFPJTAmcpAHcsCN9EB8UKE5KH0+2eVD8APDlbgUul
 zlrtV37zS3XS+ZP6of4aKG6F2vXtbtBFIg9cYD/5QNjsS49pLe4zpuwrNTcdoBFNoQAVUOlH/OE
 FSFRZQr
X-Google-Smtp-Source: AGHT+IEbvNUssiG0muyTAA5seitsContwhPG69dNuCjRH68COwMrOeK2e0v8USdzKFVgFDfL/4Tz65iv1oGcFWDkPhg=
X-Received: by 2002:a05:690c:315:b0:71e:257d:11ff with SMTP id
 00721157ae682-71fdc31e15dmr280402837b3.23.1756391510649; Thu, 28 Aug 2025
 07:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-23-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:31:38 +0100
X-Gm-Features: Ac12FXzcMw-TT0rX5dS_s0FJZJzRyplC3FMFHN4OiI1SFDoxCPdxjk2KK9oeAPc
Message-ID: <CAFEAcA8==T6BndsWAau9HB828uGPCAFVWuvJBAAevmnJUyhgEQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/87] linux-user: Move elf_core_copy_regs to
 mips/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mips/target_elf.h   |  9 +++++++
>  linux-user/mips64/target_elf.h | 13 ++++++++++
>  linux-user/elfload.c           | 46 ----------------------------------
>  linux-user/mips/elfload.c      | 46 ++++++++++++++++++++++++++++++++++
>  4 files changed, 68 insertions(+), 46 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

