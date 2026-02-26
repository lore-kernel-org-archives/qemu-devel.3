Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCA1FCE083
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbZb-00061s-JY; Thu, 26 Feb 2026 08:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvbZX-00061X-Cn
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:38:32 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvbZU-0002Y8-Ir
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:38:29 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso936363d50.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 05:38:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772113106; cv=none;
 d=google.com; s=arc-20240605;
 b=ISES9WpO2VEF23daJqQcBXeFiqeUphX75+lKMUpmiBYmF1g//oW+hPeH4CmfBjmrd/
 JoDqPKCrS/SpQ+uplOp/UjmInoAJqCsYfX7j7wPoXqVnn6EL9a5q90FiRJxWmNJD3dVf
 5oJBZJeD5XCrpDI16GAIN8DlvdG1LpbyUP5soUDqy9D7+Ry3FCFwvBuhCj9KMz14q/1q
 QYKUi8MvSC8ewL26/UheHzdQ0teT+sphzt9+SabKTtiXwK+Do9cHLgyw8LeWon5m8fgN
 nQzFFe6MznYG8Q/HDsSutPyOwOARYqSCxJmBU+wkp7CSBZFtTWuwDYFwIHifhhlIfLuT
 BHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nkrh3BDZW39Xf27BtBeCNpsBBgW2vKXKUdvPg9faq8s=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=SqdjISDYvv2+VOntVL1dINirWkMutgDTWtJwYs8Yw7Wfh9bCJXJG+iz/Ga+Jc49v24
 8Hxo9GMC60NdFxr2qVhUYiEnIhq8UKlQzOmVxZauclcOKUrpSKxtx/ZkGggW2fCsei2m
 uT0HEE7JkSbSs/QCaiqOif8LmJp9a8XBZYnXvhJG6smBds/mYYfO+huJH8zE3TEQYrb2
 mURPIYTqoBAOSy56rDCL1DakTNoFXkoXG6jx/2FIMowFK75XOSUfwzdCic2vaSX0mFmk
 MRw0EYYOCNeK3Zsfx3FE4Vi86esnxBCfeCccatdcJczdNTZeMm0IcdyjCQ+lNke4fmuq
 uzJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772113106; x=1772717906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nkrh3BDZW39Xf27BtBeCNpsBBgW2vKXKUdvPg9faq8s=;
 b=DpJKNnZAHaXU3Of0OeZ42gE2RmXLxXGPtjhFsVo7WP5arx1DhCdMT59RoVnqBAqZCB
 Wmszdc/DjCq8TSOhp19HP28lb3mjQOfNEOUilcZruDh4WW70c8wING15sQMtrFNCEiP7
 B0iTllwXbV8D7hrgQhPi2ztRaPRiI819E2IFCQUmUFBTvNAoUGEZW1DU4aaLCrGdVkRw
 xrK0Dgxk/HaD4J4d7tlPv93Ur/Pi0ym2q83G+8ftok9FJ1z/GsXLLLeDweKYkYGRDpB0
 yT9oPoJj8Hr9jixZ8KlXNP9efTm3N2KbM4Xpfv9KHPlR6BbDwX41JT3sKQzVx7c2ms3h
 37lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772113106; x=1772717906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nkrh3BDZW39Xf27BtBeCNpsBBgW2vKXKUdvPg9faq8s=;
 b=t+J/CebWUiILe1pIh7yvRCPOEvS4CXghmurDUOEc3SpkiA8B+Ae0YccBbb27xzZh2W
 1xiaoeFZe+5EPAfp8AhhC6zwq0/04eQ2RSePvLODaadxTKE93bX67zObWYtbmiBkJ8lO
 yiyN54ObFDMcIkOQoJnnu+8PTo0naJKuFn2n4JYxflIykWXYRfsmTlRxFVrHmAPlSNc8
 mng5x6QW6NrizkrPIqqmHyLK0IoJ7qMHf/EuDkvn29v5wtwZ2S0PiTUner9ARbb/I2hX
 RgEbAEsGx3yAsTPG+uGJW1REw8/d8MRFn/AMJrez/MtBLOA0yY/TTrjR+GZsM/rP75Cw
 53Tw==
X-Gm-Message-State: AOJu0YxO/55MKEoTR4vIm4HJWKePvu4oIw2fjaqER7pjK1jpyDjYzmq9
 hEGpJI/LEdko54CTX/jnaRDbUL5mODkDz9lILG1aHyQDSTTyo3mdowjDbdmTEAku8GPBLPls86r
 SM01ED1I7XNxQwPkgOiFImd/4WhxHpNPqEPzdUj9G+Q==
X-Gm-Gg: ATEYQzz5jP2Cdbdb5dSyoeJBXypQyGNxTIzgsHCkc4sg5DTxLP6CrHMh+8EDU+NRfK+
 2N6aQRJ8UisQ8dYKWgfYYlYyljRtiyxuzoyj27mzdFXvwvZtmmc3lM6Q1FfQn+f0gDjjkQ4hurH
 P4JYCcx+xL5C4GtNf8+gMUwxAZfkQ+mYSnYs4VOa6R2+0J5MyTER4LbbwQqEb0sqJ+CYitKaKUH
 5vmclKWCaenA3W5fVkpD1Qwxbm+ZDsZylcTlxk3D/qeEmlhpYTZ/lEuqKi6J2nrR5ZcEoJLCZss
 omD1fipy13I1mDTerObxZzlKtb+ZVD/MLT/aUiRk7rMntCjUZlS93lNWIq2o6if7FEs=
X-Received: by 2002:a05:690e:1243:b0:64a:d311:2cee with SMTP id
 956f58d0204a3-64cb7c89255mr1670338d50.89.1772113105948; Thu, 26 Feb 2026
 05:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-32-pbonzini@redhat.com>
In-Reply-To: <20251227094759.35658-32-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 13:38:14 +0000
X-Gm-Features: AaiRm53u-iiJZvgNePwR8IZXXt5MOAPL0y1tCGPHeCsNP43ibCfyu1SpPCaf9d4
Message-ID: <CAFEAcA91Ghhhve2=aSB+Af6C_Hhdh1-MMQCuUWDpwwMFvYHJgg@mail.gmail.com>
Subject: Re: [PULL 106/153] bump meson wheel to 1.10.0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sat, 27 Dec 2025 at 09:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This version includes several improvements and bugfixes for Rust.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                                   |   4 ++--
>  python/scripts/vendor.py                    |   4 ++--
>  python/wheels/meson-1.10.0-py3-none-any.whl | Bin 0 -> 1057029 bytes
>  pythondeps.toml                             |   4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  create mode 100644 python/wheels/meson-1.10.0-py3-none-any.whl

Hi Paolo -- should this change (now upstream as commit 8c04b6a48b15a)
have deleted python/wheels/meson-1.9.0-py3-none-any.whl, or is
there a reason we need to keep both 1.9.0 and 1.1.0 wheels?

thanks
-- PMM

