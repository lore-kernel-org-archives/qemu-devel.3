Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6742CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbip-00045d-3a; Thu, 28 May 2026 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbif-000410-8c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:28:21 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbid-0008Cz-PU
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:28:21 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7cfd0d8eb09so96066597b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978497; cv=none;
 d=google.com; s=arc-20240605;
 b=UE1onwj6OZRpxRM0CCIxNzL+cDAqI6ZbNXGHXBfi3hdseOm/j91eTDNKm1Q7jJUsia
 FjmTk5gVJZJ0/opGSTbB7ZkkTZXY/+n0d6tvlbWW91oF618VdUHq/Fc4QoHoNv5r5w2u
 r/6AsYUsxdES4T2pCSsUhgckS4TpWZfJqbEa22ovFjYuZG2P2fbHEkVglkeqRM5j6AsF
 WmXipL7oSUoMPnHQ581C0SNokgWYnFqQeoyO/vohZ/gkdScgVwaCi7SGut+148RbPi/r
 zU2N63jDzsMSmq6WATP3uELLJ08/UPHkwJnY5vXTd2rCEWlyWDAkhAOt52hTe94sS0OY
 d+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ct7jLG6nYI6De/B/xTcfdYl6028bsiYvvbbLGS1MqM=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=e/nE1mv0D4hGxbqrVZhxmCmNoN4NXGUn3TJZC5dWM+fXT2b6J09ASI2l2WRCrb6Z2k
 NtxNnjl85vp4Bo0ir4OMxvBgyrHpspLyG3LoekgXokNxynyps4zGL3aR1ndz8kL+tJ8o
 b1Y6wyni9KyipibdfZm0BWAZruPAYlsMxDYXCPX4bJBXjjf2kY/pwsHs6yVlEOgKqX/T
 4saPH8p605P0QtEdwYrbaO+eEZaPrs9CQRIuwcwSTUEw5zVPy54XXNiR56w7rq6FCz4H
 8XAbGvgrvIEPOmXscQeixESq48XLICO8RN9/r8sdDKhB4l1SdeWJv3hVv0bZMifj6B/t
 Xtow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779978497; x=1780583297; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ct7jLG6nYI6De/B/xTcfdYl6028bsiYvvbbLGS1MqM=;
 b=Ej1Gjt/5WfQP3LPfyO9SYOgvGD9SbdhdvR+dv8T0MAATRtub83Y1Z1fmnmqgSGeyW6
 Hrf3yfebcXJHy44TZ3Efx4AymEioqqleBAwbi3GWtUxhQGducAfZS5XWr0Ydak99mmgA
 CA0JlTXq3uKEENtXok3r4QaOatTofqKFHp4v/eWTdcXgvy8XK6G8s2Xei0MQYZnHnKC1
 blZeYAqjLpcS4Xi8x6juHKGS2/nqcX3FDoRWkN5d0PZMd28wG2Vj2vNWBD7DiTAMdglK
 L0co3oRb88z0Kfo75bTymiLwNKUzgYHagvlqKd5j9/GFC2cyeUku7WvlEJxtR2cf0luZ
 2IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779978497; x=1780583297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ct7jLG6nYI6De/B/xTcfdYl6028bsiYvvbbLGS1MqM=;
 b=WLu68iAXdiuIrkdvkz8ufEC7xdODzXj65VH7eMr1d0EJkGy4gIY9xuAzqh1ig4qJfn
 7eIF1QJleQLxJUXaDXudF4hfD8E/ViUSa9X85cpM213/p5Zj5Yxw1UjdioKPHiZmKkUT
 YOXzLwgva5xulZ86RcFkqrna1LcB+tDy37DA5rYHlacdWqH14v0t083s5p16CCiKiUTC
 QDqljg3DFue+Sw+OphusyUpKkmCQmCbcZZSJVoV3xedQ2t7I+wDlk0F09noLMzClBhSI
 H+XV4HD0vQzO221pbq5UUwYBOHsPkE135NAdR1Zwk36uos5C3YtlbjHDqrJ6pT6UAj9m
 FtYA==
X-Gm-Message-State: AOJu0YzjJ4rFrJ5TefRWXdvJJJnspib4T/Yn3WehCcJdNggy5pV9Yw8v
 y2dXStuU1wzInW0y9ZiU4ojnC/s8jq0q47ljjPUCmtpTVcxrbSg/B9HdWMVrF0PYDQ/tFjYPjrb
 PA6UPk+YV9i8C6VI4aX7UdJobrZKqCCurS4Z4Kv0mtQ==
X-Gm-Gg: Acq92OGvzfqhxWiNorM95b9JaqhMQVqJ9U4ISu6VHjIMEZm1a8mnbRAE1SbZkx/VmPv
 IzHixaFXolkX3WDjwTRQHYCICikcpzMH0OATQzTDHsLg3HpetZpO9XVxurRwaSKF2ewowANdrxl
 4bb1yuXhf5BOirV0r+cfHR+AMHn8MBkhRalM3EVxT6Cc1jGxCBYCe9B6OetIbhQUqsexlb3Obas
 /XAwn/LR9ikpRQDqOKkI3BsAd2H4nxaxIFHLit2DyyAGEAHmTfN0zuNtimX0/DDOqYZUAAFSNDD
 lD9h3xla5OGV2g6YnWRKwgDVnNUgKktps9HnsiBRII2WHLpTE4yWAitC+Hi2NKOOnDk6mB607GQ
 ydA3gJpqR1bIA
X-Received: by 2002:a05:690c:4883:b0:7d1:c256:b5a8 with SMTP id
 00721157ae682-7d33ac50c26mr284710027b3.40.1779978497225; Thu, 28 May 2026
 07:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
In-Reply-To: <20260521112806.504961-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 15:28:05 +0100
X-Gm-Features: AVHnY4JnM6IPyy5CnDL1pkD4ue-X8IKL9XJ6YXa4ODlXiauZLNXJttCH7g2egEM
Message-ID: <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 21 May 2026 at 12:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Also little refactoring in preparation
> to avoid code duplication.
>
> Gerd Hoffmann (3):
>   hw/nvram: add load_image_to_fw_cfg_file()
>   hw/i386: switch shim loading to load_image_to_fw_cfg_file
>   hw/arm: add support for shim loading

Any chance of some information on what this is?

There's no real description of it in the commit messages,
and as far as I can see the only documentation we have
is the rather cryptic:
  -shim shim.efi
    Use =E2=80=98shim.efi=E2=80=99 to boot the kernel
in the "Invocation" section...

thanks
-- PMM

