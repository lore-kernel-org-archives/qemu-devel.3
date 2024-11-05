Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADBBD2B941
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Lm7-0002Vo-9W; Tue, 05 Nov 2024 10:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Lm6-0002VG-CB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:47:22 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Lm4-00062g-SC
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:47:22 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso7037502a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730821639; x=1731426439; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=40hEXOu1jgX+WtWd1UaXrVQyCfHGofFRPEPHEqvdpas=;
 b=KndW0D0/4ZPLOEVJDCEOIDCcRuR419MKw8Q+XYYYes09CTHs421cRPGFKjn5maNX3+
 eym2vjyWHRrjfUTIqBnRgCrW/M5AksfaXFdNAUm0ukm8b5XtuAq0tnmdYcsDKE7rtBd2
 c+b13Uih+sILDBdMb/czsfb0q/94i0eP6TX5gXgQvXrVl2wELia6vqNky7e5cnwfgkto
 cXjDyvHi/ML4SI0ohQVMDrcP+r5XEZNfcfTQlxiGzpS/wyqn2InX0+r4dJ8GrMXO1kEQ
 iSxF8WZGjmqMqtQKlX97vBWhbW7Jl4Jbq6bVvRhCeukCZ5OpXXQWBsllqDVdTAVdKull
 xXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821639; x=1731426439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=40hEXOu1jgX+WtWd1UaXrVQyCfHGofFRPEPHEqvdpas=;
 b=G7JOSPBiKozZmh8XrdMzaRkfcReub0J7CbApuGi5pN6/abMPty307ttBqMfJBwvNQX
 JHNiOqrvKrZPJwXI+JqGiN0upNwuG5tI+sZp9LpSC8TqT6GoONUDng7xerlvULQ3HdZZ
 W8QWBm/z/DXE9c69KmApCzL7GSycWGEnJhK/2O3CXKXtibMLv3Oo5NmvIVG+PKVfz9rJ
 hmNOpuxdk4uJpWDOArd72Q+HP1OtB621h82EYjKKegFKOEGETKeV415HmO4KnKL5LxMi
 kz5BAwrQoFYxS6jF6wbe6OAV/B4F5Y1pRYNbUJrHnEWbGfg3SfjglXafIML7RzEV3PVg
 VxbQ==
X-Gm-Message-State: AOJu0Yyk6Bqrl+Zt7UOfzl+fWla/7zp3QIwhX8nkO/NVQ/pIGmPa5nUZ
 f+WP7wUEHHKTMB1W2L2EVjWyypVYY0mHqnPaMGNnR+CXOzMGP6H2QAuimxzls1rY+HiGhQt+4EF
 xs9u61leruL2wyf9z0R10dnEBpbPr2L9jy5V9oA==
X-Google-Smtp-Source: AGHT+IGtxpjAf4xHCEVUZ28PAVwqc40FvxhmFkqdqYZx4zwNloXgfNrMa/IDe3q7RqPMBmGuQilG3GhLlgc2VlUfQJs=
X-Received: by 2002:a05:6402:2753:b0:5c9:62c3:e7fd with SMTP id
 4fb4d7f45d1cf-5cbbf8b1d2emr31053298a12.16.1730821639146; Tue, 05 Nov 2024
 07:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20241104134139.225514-1-kkostiuk@redhat.com>
In-Reply-To: <20241104134139.225514-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 15:47:08 +0000
Message-ID: <CAFEAcA-Xwjup-R86qeLMjudx3Sxs65j2AA5fVhOEiaMqD=srvA@mail.gmail.com>
Subject: Re: [PULL 0/3] Misc QEMU Guest Agent patches for 2024-11-04
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 4 Nov 2024 at 13:41, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit c94bee4cd6693c1c65ba43bb8970cf909dec378b:
>
>   Merge tag 'for-upstream-i386' of https://gitlab.com/bonzini/qemu into staging (2024-11-02 16:21:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-11-4
>
> for you to fetch changes up to 9cfe110d9fc0be88178770a85dc6170eecdf6be1:
>
>   qemu-ga: Fix a SIGSEGV in ga_run_command() helper (2024-11-04 14:16:47 +0200)
>
> ----------------------------------------------------------------
> qga-pull-2024-11-4
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

