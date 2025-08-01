Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB2EC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv6Q-0002YG-Q1; Fri, 01 Aug 2025 15:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtYA-0002q7-EC
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:28:10 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtY8-0003aj-IC
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:28:10 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-718409593b9so21056607b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069287; x=1754674087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7hNLlgIhDrhrJcXaPghAf5FzBkxSrQqW5Zn7/7J8S0=;
 b=jnZIlTKnLEOfVpB3au/xvZj7wZaW12Mo/+YFDfZG0Z1lRC/D0LrJ9gVrzKN7I/ggKx
 YhEyblO4M/fOTAk5lSoQojZY7VsuZTiMoo3zPJ7BmO5qEVblMlbOgHgRxRh9tzSYtFH5
 0CxUHiMbflfBWSkizsqXqTA9hZE/2VhK3LJURw7wxdwx0p1svOXswU1SRoiDO/5d3fbb
 rKoLsWkr/wyNn0YHoBp9dH+XlFjhMpNEcjtz72IfoJg+HAZXT7RPXNCZ0logKXAIiXuu
 emON5y9Dk6GpIHmqBYsLELn0FDHB8i1ak6NqTROGpPKAKG+gqn3RiZSqkWyIlvoF4mX3
 JhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069287; x=1754674087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7hNLlgIhDrhrJcXaPghAf5FzBkxSrQqW5Zn7/7J8S0=;
 b=L2ehtDKKMbNBP87V777WKamVL8BAxrmCkXsl37+iaDmo1/16Zxx9NuulfnQ8xtrDv2
 ONVaEvgNzI6fi/XY8y1yLr6DbhMw8VpUPBLQtqrBfjY+iIisFlpgC7P0LRfTj9pNEygI
 05PNL4dyLxLHuPoRgPqN+A0f6u3O86PI0CQi4BV01G4ZH+t+z9kpNiAom+k3Of12Vm2s
 1dOubVFzg7flF4e85uKU0vIBgmDtKPmfR0CYPjp2nfmESlleU2lHRIV2/PqbR12tt60j
 EcY80Y4PKOWnxcemIru+82TikNYrOKWggm96A6ZbZOyU2GfJVKWVVMFGAb31hiSP0gui
 cwbQ==
X-Gm-Message-State: AOJu0YzH4o7g/3WlAME1BAa6pF0u2fl2EmWty1veOj6kmQMwZnZ9HT7G
 1Stp4UTt3OAuMD6heNPUAM0YNUbT9iHWspBqGRde2JJIcYH0r8W2WA79AFZeVYSctajeEy8bbBC
 uUBa8DOpUdMTMgiD/vHvktraQQ7VFcKySZLi4GC2adcg67UbNtq8p
X-Gm-Gg: ASbGncuNpKt7klG4xsZt5c1i7s6K4TxLM1jEZH/nyFIXzCKg5pEusYIJXnDYyN1bxP0
 KzRggkHI2OEsrrY3B9q9sCS+5c8W0k4XpbA3z7W2HjTFx7tqnE49vhh+yTSU9vjmT/4v3H59s9s
 shA455ojr68wMvyCtPMt0HZ8GhEID+tISa6JIxXK/btVv6jjpDdcy8ftC8babF2MDwdvdbpDzQx
 t44f9XD
X-Google-Smtp-Source: AGHT+IGf4Cox71kBXS3W909cRbVVtiyqfHSmVUoSCKWlqByWLCLMNi/ZlgASW7M0SsDKn2ZSC1RcxK90aAZEVRLlels=
X-Received: by 2002:a05:690c:1a:b0:71a:22e1:b32c with SMTP id
 00721157ae682-71b7f5bc0d9mr5875267b3.4.1754069287247; Fri, 01 Aug 2025
 10:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-30-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:27:55 +0100
X-Gm-Features: Ac12FXxivS7wNe8f2TyMyGoLIykp05Z54sUux6DI7CnvfOag7HEoUSE4wAnYYNw
Message-ID: <CAFEAcA9i2dGMPGPEQSJdYOhLzzh4q2M3Z1Xo596NjMBGJH8sdw@mail.gmail.com>
Subject: Re: [PATCH 29/89] linux-user/mips: Create init_main_thread
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Note that init_thread had set cp0_status in target_pt_regs, but
> target_cpu_copy_regs did not copy to env.  This turns out to be
> ok because mips_cpu_reset_hold initializes CP0_Status properly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

