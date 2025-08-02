Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7046CC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIoc-0000C0-Pm; Sat, 02 Aug 2025 16:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiImN-0006vb-F4
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:24:31 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiImM-0003Fj-4T
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:24:31 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8ebd470b69so1771133276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166269; x=1754771069; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fYBfzvh/PXlzS7SLHUEwcAhI8mZSkYJpZFmsq3c6X2s=;
 b=Dr0myASpezAO4ncNwwjPxFWc0CNlSxqGgccR4etDQy4s4j2+bGsu2VtqWBopXvckQw
 70P775wyN/iMVDhmqS7/cDo95nPsBBOu+tptnQyeJXiWmm7czY5xr+2n/SP2+8cRAtXy
 bbRQ1KPiOybgCDiJOssX9aINRI/ZDrChD5OJrvd1jkN/ho2R8iwXpykUNfBdINtFVbSd
 pFxTZz5w+PUl/Xcb87E2EEAMnCb1fXN0KsJ0O98ieywRHOM+/5pv82dsaSlfDO1HCsNJ
 gmdSbDcJp2JqQBTmgrtnhVjhrsX2ZO0u8NVJ94JIaywt98af5s+tF8tv03d3LVJfhRYE
 1mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166269; x=1754771069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fYBfzvh/PXlzS7SLHUEwcAhI8mZSkYJpZFmsq3c6X2s=;
 b=Lsh7VvllK4O6EjXmVh1v13jmFoygZdzDczKPVouh4FJYfHGGTeQ5KCiGCV9A2WIGEk
 RiRfenG2zfZVZ0/NxyIHlWvWeqTB90eXHzX0Rfdf7HZsEJpef6/NtlUc1T3/LfnInPVI
 KoqBiJwe4hYdMzHcwzJRIdVllWjvHAOC0AEyowO4n7DHt+MJRcFxFCAnsAjPh7AWoA9F
 bsVWoX4KzEl7twMeTzio3mFC8kg3U1VbHaM5ETkBTi2wrmCZT+NH/CYdfczmO1DpnMyQ
 KIDnyvrxHt2gpuf33vrhnWz/bMB+TmLRK68zMYIBNbFvhu0+oWO3iXAq4QGP6zFIF8Be
 EJOA==
X-Gm-Message-State: AOJu0YwQ6rf5DnJWwMikAbCB18UQ+DVnnjL+aohcZLyFIECllpmbZ799
 KHUfyVxb6P3Xzc47jl+WGH8roIltnXBlFoZxqQxRJ3A1dYxQtgc+aSa9u+ACCop+Tdx+otHaX7Y
 Hz00S1XzhWSJFCmxZMXRy817ojnsUCqE0uebL4BBEdKzKgfc7ssxb
X-Gm-Gg: ASbGncsOoWCANzLCeTdlc42GEN4sMZu2jMJtPGcMFu4xuUGIG/CVkYqx7rKAdNbLAjC
 jgbuVb//f/Pa1QoBGgranTC5Zvn6AWskH7ekrGgtSbbpFMkFWIlPfBabi3MUi9dRpOzY3ysbDSZ
 TtaF38hyvIzJMPNdYN1kizLNt9qtxe+G7zwoFi3mBwy5pdHV/n3NzfmAnjrZUqq9g2/1ztEv1pZ
 0tXEGeP
X-Google-Smtp-Source: AGHT+IF1b9mQW2wor1vzTMyvjFDqaSYR8ok4tHIyBk+t64nTFPnLOSv5LWCh+WGF0Vo2axvSBgaZnRyAj6ui7brdfdg=
X-Received: by 2002:a05:690c:f8b:b0:710:f1da:1b5f with SMTP id
 00721157ae682-71b7f0a34a3mr58804517b3.34.1754166268767; Sat, 02 Aug 2025
 13:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-64-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:24:17 +0100
X-Gm-Features: Ac12FXyxVx8GsRk3SEJyFBXWptja_T8C6y53wnzlRfDWxjp57eLaqASpDGpKX6E
Message-ID: <CAFEAcA-si30Qc32Vfdv53AAxFymE8HHTRE0vHQFmtLyOmxzwhw@mail.gmail.com>
Subject: Re: [PATCH 63/89] linux-user: Move elf parameters to {i386,
 x86_64}/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 30 Jul 2025 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/i386/target_elf.h   | 23 +++++++++++++++++++
>  linux-user/x86_64/target_elf.h |  5 +++++
>  linux-user/elfload.c           | 41 +---------------------------------
>  3 files changed, 29 insertions(+), 40 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

