Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4168910706E1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nsQ-0005dk-BA; Wed, 18 Mar 2026 06:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nsI-0005cx-7o
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:11:38 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nsF-0006kw-71
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:11:37 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c9a6d68e5so5734416d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828694; cv=none;
 d=google.com; s=arc-20240605;
 b=TZ1UFOQ7nLrqT+Nzp+i10Gsrs3HGGq7psJANOApih5TpGhZSAfJ1XUrxxLrnwVq5sF
 xqz1P2K66i1q3MVqStCCLvPv30AhCx7BKFZlPPaTLSfOaY9QQP7CR7X2X7m3+JbYjM3M
 3cq+U5PXFRoO+FbStQ4cQOSXb4acUjziU2OXQo4pHQEoRnGssZ9ZHqppxJQa5rcoBDwP
 JIdalKv5+onyDInqnF0IF2/qPcPYbYmuGbY0F38QEyq8gOjzAhH3rhRjtdihBYuLUMzO
 R3V5S3KlVPMGb+bU4tw7s5iDeE6CeSMOhpNDt7kWquDlPurs4z3sxLBb3zNkBMaAL6Pt
 8Xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I8YwKXGBKVqFSospKVVmNS0YwOzzVk5WZ9eSDNnvEXs=;
 fh=+KrhP2g2cDo4I8Hknz+UXSq7U1irb0LXTq7D5fNm4GQ=;
 b=Hriia6glSWmQ992HIcIUGkSo0jzIRmsZmWbmhWEj5j9H9FrYjIJgMKOhMLhdyEM/oW
 Hd79hGis18XdidR0Ls0SPJ3W2+tHx85YX/C/1TFRcrj4zdWserMa1uj2RaJ8gcTm3AzV
 sN1Mmip3zQbEhHimEa97n0buAIFi4IZmgmeyIhOTPEcVu8J20WMr797anXrNeta0WQNR
 s/L4K5CDcZHRlsRlXimBsDcpJoGDpQeGazOFZnYZjzVTHFcqV/zxOId9njU4fXkoN+l+
 EUfqvxK0ICR/wjWCKFNbb2RxOkFzhaJKZ3SuM1f+THK0BQ44tvWyDS5P8b3ZLwwycXT/
 07tQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773828694; x=1774433494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8YwKXGBKVqFSospKVVmNS0YwOzzVk5WZ9eSDNnvEXs=;
 b=EHy9sJOjn64GLRnHj7Sk3TfdK8xVH8k5Thh7s02SF1P8a9C2yRfcUvK4nUit18HbUc
 Z0OnDewZonsiV/RHqegCV+pAXrLZUCxbEAzz4DTTXzyQ74psX0yp9TqQK59T1qhnlmfV
 19/qmeIuFhrRaeMCWP385sxoriS/ZKaO3bmGxaqJ16b7YZeQFav8Ia4ae2g9uPdgwEM2
 ikYN52knN38Yw0rfVWnNF7pS/c81HmKsu6K/mEpPFU05KNrrwfdpW/Pm5uMUOO0dc49Z
 rygD/OKknFoR10IzefP9WUdBJ7P4+cgeOiUTCoYgGvuAqA8hZK2dpAzc9AcO8TXHPUOo
 BLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828694; x=1774433494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I8YwKXGBKVqFSospKVVmNS0YwOzzVk5WZ9eSDNnvEXs=;
 b=DvMKUUImU5A7k8zD6Sp5qEe7mLRfxjkGHoBY/ib+0X65tDg+yp2HWK12iPk8pIqGvx
 tVKVlEBrSF7MyGjL+f40Mdssdp1Q+Pa6JmC8HeRwuQzB4uqjsPdU/RU5hUneaP/0PNHD
 /vDtpwgD/Yfltz94/aY6PfEs6tBb8XYZH6vqd6qcIM0xlAS1cp1voME3W7CEcK4Nf5AB
 LdiYcDXZRgm8aBHI5jknis+osyLzuPCgVubusWcMpxRnSBmnIca2k5KyhABPYQakmF3Y
 Uu/vqtVhAdbQJdV8EnzxXibpkdWEIMDGM1+fY8aZBntPuw33yGk0LiYFTwI76+pvw13J
 QToA==
X-Gm-Message-State: AOJu0Yz3XeKQXRBON6/5Sjx53AIoHMSzLwmP6UfbKFn6UT3QqRolPvHp
 ZxCvIzV9MmfJwBB1OKZgAz8N7Yx8yw2QoWh3V6gqAyT6CB8nEaQrP9ZiLXx2YM7zrIzTp5bP3Au
 cvgwKiLRwmcTWBsXG7yD9Aht9eHARznLu7atj5JuDWw==
X-Gm-Gg: ATEYQzwtZf8ASm4l8ARDUo90MHJSq42juClmT2oEZP0l1Iyq9SnTJ7YcYfISpG8wGNe
 JH3f68QtxL8AbByDVsxzYIG4olurqp2Lfbnkrq8E7R4GEmKziGlfqUYMV0+fmwj4bTNKmJ5PNoR
 p3ju8UIKFLZRzpKX5WojXgGWiZvaOVPlv08T5T/JML5iwbjCWbWQwKE6dUMltSKp7C76xFKHZhR
 POB/s8tv4cF7tU90QDOu+MupeItpVhXJc2xyW4f+QXsMTuYLWArFYoUnH0Cf5hGyjQ9eRgB9asG
 WBS28wk4iYM4ICTMbSEIslm+IP+dp5IouaAGJOGfxm6fK1khxuMWvD70xHAvi2brjp4=
X-Received: by 2002:a53:c7d0:0:b0:649:c7dd:d2fd with SMTP id
 956f58d0204a3-64e91634b40mr2084191d50.73.1773828694047; Wed, 18 Mar 2026
 03:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 10:11:22 +0000
X-Gm-Features: AaiRm53z2dVLa9k54SlvPv_rR7susrXERY8VH9Ahl0t7zi5SjidHawu7otp607o
Message-ID: <CAFEAcA_UXs8jC0Ttb27SHuP0=toEate7gZTTA6TZjD-Qsbt7jQ@mail.gmail.com>
Subject: Re: [PULL 00/16] ui/audio/dump patches for 11.0-rc
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 17 Mar 2026 at 17:20, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48=
aa:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into =
staging (2026-03-16 13:07:33 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/for-11.0-pull-request
>
> for you to fetch changes up to 461632f0b1cb2c5c29ba9875857637e3356b903c:
>
>   coreaudio: Initialize the buffer for device change (2026-03-17 21:15:10=
 +0400)
>
> ----------------------------------------------------------------
> Gather various audio/ui/dump patches for 11.0-rc
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

