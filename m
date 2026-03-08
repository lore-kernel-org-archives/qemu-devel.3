Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7804EA853D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 18:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzJIz-0008QT-Bw; Sun, 08 Mar 2026 14:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJIy-0008Pj-DP
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:56:44 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJIv-0007t1-Q9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:56:44 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso10339809d50.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 11:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772996200; cv=none;
 d=google.com; s=arc-20240605;
 b=E6cLz0Nf4+6ggvraqPOse1lSL7l+X6y31V18JH8T3eGviTbNVuuPpWfmjmWwt0/YPh
 G1P7v3FkzLIQ+JPlyZ8TwIOmAP9Syevr2/Y+OKQj/X/fSsZ4I8bWPgdTwQOK/GX6s/xx
 4goBfoVxsWcJw+g9snRDx5LHv4D6oF7jxGjQL1m8EBMdAlbe6m8WRs6swbHIFwwMRMv2
 3ks6Vq0bps9TBi9yODMI5O1HL2usvTr5P8ueTESF45bugaIFyCLGP7y5eabduckg9UO7
 6ClljeCeNpFPcnaha1uofIOFg9QMv/jfh2AdQrf6UtnHmjUKHwLj/dRyWJYgDAzxsM4L
 u6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TnYTmuuSBV+IuIyOe9Prr01CAvq1nrGY9GjPuBNSNrQ=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=hzbyn6R7pL71e6gFbfN/2OJp6j+OryOSOQ97Z6ojOMeDQC/VEt+R1E3MHACOFCnoZo
 4qYsLly00dcITx1cbj/QghbFu0xX9C/ADLQQKE/1lbAHjZRrB8NtPorNFZf5rQbQmZaE
 +EKPfl03KAluRKNWGCGu5qEoW8Ns/psBPXJMnzHCO7h2ax0/FBodHCDPdSjIq3xzcfBJ
 +zaAcNwtveMCbWdWWIq62YUy/VoJ274Xq152SKT0JiOyJCkFVvmyYSNQcMk5UtNsSHoS
 j/jZ3Gq82qqWF/FwuBugeSljXrkbJcmQC1ENVOQXDa9raqF00HLKvEMy87X2FJqy/wjH
 TbSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772996200; x=1773601000; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnYTmuuSBV+IuIyOe9Prr01CAvq1nrGY9GjPuBNSNrQ=;
 b=DK755HxXZJZ/a9FvOeSmbtw/1n/3XLGPcIYEkzXJ1doqM8EfGRJKL1Uz01o19rsGLo
 Jp/fSEiKlfjF5311oDBqi675cSgGntkwy3jFWftiCegzAP+LUCUJJQdkFs5Se6Yajacw
 kD9OKQIGhEdrwqeP9VL8881A2gA+yGXheg8RVN8BUzIKt2aVS8M0BslZ6xaDMk6+BSg/
 Js3eSDqsMujxeeUOFdm6xoYHQxB6QGBssPSdGbNiZ9JWuKDCQbH4OBqcORbUgjOoKyOX
 bmZp4RFGNru3EvCjngqHiNbgXPwU790KjnWxSHb9sYYm1tG1Ns7vP0jTeAGSrWLsRt4p
 uexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772996200; x=1773601000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TnYTmuuSBV+IuIyOe9Prr01CAvq1nrGY9GjPuBNSNrQ=;
 b=iKjs8qfQmYQkaEOjI6UckPlsQ7kIBF2GwNQpAP1A+M148f/pnDJhJIFPLLj2niUQa4
 DZ/YQy3PpTMIxBZ8GF7yLpslgQoYrna/7VpJbZWbrpwcsmxij15i01LpsdrXlExAxLxm
 l588y+h+UoyZPMoXcv9QVxLixk1feuCSIeCd8ApbYyN8F0niD1P5onwRdG0+dNZr76Nu
 DENWQ42ehISLyL3MVrzdCtBR17yBEud98tduIb+fN60nlHh+DV41r3nHRozOQWtdRbUm
 pXZFv3QyHQDKC1qYFKpIKcgyPUZTfFJcTI1PUqcpwOukdBMX6KiZEz7kqodhAzcEW+ax
 mRng==
X-Gm-Message-State: AOJu0Yz4hZ7NbCiDPgc290lV96WKEyYSpjr+lb6lw0GdsoTLl73TzqDT
 kpLMHgQdiAqadQrX74hbufQwWyqb3HEV1JViYNME+oamcUWRXpZ3qLkW0uj06g0Ymx3HogSuF+y
 XVX3ZB80cst0KZUI9v01QD4iSxluQjrGRramhA/GPYA==
X-Gm-Gg: ATEYQzwlsyFKrPenew99vOjBCZ+do/vfu4DQzU6pckrhtydH3Ju8DWX7SAweAMqug1D
 eOe7o2kBwIsB4erhWVBr1H+sPBF537VsrTsLZWSb5N/BLPeinmV98vuIqcvKry5dvycnzn4kZqM
 dzWp2qq3dYHfqngGc44iGNgHtYYYBDMY9TSf8CzMsPyn2N1spJw1u0iBQlIdAVOsXcdZYdtDrac
 zNXUkb/PmN/L5iHBrgqzIoa8R4BBFX2HzsRtjSAgMX0zqMDUk1Nr58ymiFIWHjjSP614PXmMGV6
 w3gmyybE+YZMPveFj1UXj+JiAlXM0b+l4GiH1Gi7IU8chzVkfUoKqs4KPe0p98+ewiI=
X-Received: by 2002:a05:690e:e0c:b0:64c:adfd:209d with SMTP id
 956f58d0204a3-64d141a84d8mr7070328d50.35.1772996200251; Sun, 08 Mar 2026
 11:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2026 18:56:29 +0000
X-Gm-Features: AaiRm50MJDOsebfYLZGuhLXHNbn3gyyCQ5Q7xS8eQvnOlTjgxlKyIWvd-Y0x7vw
Message-ID: <CAFEAcA_LL6GcPbd4jWctJy7V4KBr_UT9H1gy4CxwJv1=b+AJ4A@mail.gmail.com>
Subject: Re: [PULL 00/20] virtio-gpu updates (resolution, error handling,
 fences, native context)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 6 Mar 2026 at 19:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 900682c57287ea308850af4490339455512e92=
e7:
>
>   Merge tag 'pull-target-arm-20260306-2' of https://gitlab.com/pm215/qemu=
 into staging (2026-03-06 15:58:24 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-11.0-virtio-gpu-updates-0=
60326-1
>
> for you to fetch changes up to 4eb0aace85f507e21bb8ac323ad81c5860f7a52d:
>
>   virtio-gpu: Support mapping hostmem blobs with map_fixed (2026-03-06 17=
:27:40 +0000)
>
> ----------------------------------------------------------------
> virtio-gpu updates (resolution, error handling, fences, native context)
>
>   - support per-head resolution definitions
>   - don't disable scanouts on sdl and gtk when display refreshed
>   - take care not confuse virgl with switching contexts
>   - use dmabuf to import textures when we can
>   - keep virtio BH processing to main-loop
>   - improve error handling for fence creation
>   - support async fences
>   - add support for DRM native context
>   - update virtio-gpu docs
>   - remove superfluous memory region enabling
>   - validate mapping offsets
>   - destroy vrigl resources on reset
>   - support mapping hostmem blobs with map_fixed



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

