Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ED7C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 18:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruGNy-000745-C1; Tue, 09 Apr 2024 14:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruGNv-00073a-TH
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 14:39:56 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruGNs-0003If-AB
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 14:39:55 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516d09bd434so6428634e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712687989; x=1713292789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xvL+glsdz5z4Amq1OoQNU2NXRCqhZxgf8cj+gEXovas=;
 b=jilLDqwtDPfxD7mQhBlGk4xh9mrECZU1kxK1XzA6KlRUR39RGML9NGjthrW/cuTp9V
 Dc8q68zjKh/HUMbDTryUgaD1xzCEtQTJAzJGPtD/mzvGqw+S/N8Ioo8RkYW/5PxeIg/u
 fEOodZirHMwmNO2fVzaPM2af8ZkZyMjWA/Sjts6nj5Eoxw/ofYArg7izuK4WdJ+FlLEx
 gfPsye1Bd+9YP0V0CPfK+3PmqP8S05k6UHDv1h/I3jx1bTbPvi3Ge7fhHiuxfkpRQjM4
 EAu1LU/UDmCfBO5oLrcYxPDp0P7IkaHvkNUUmjOfaFsI3hiCVXN5P6VFPztodQ5vrT3n
 pYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712687989; x=1713292789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xvL+glsdz5z4Amq1OoQNU2NXRCqhZxgf8cj+gEXovas=;
 b=HcK6p/Dwx43LPQ784bdcNkwLkF3kOfhfe8ayUooM1WpsNZmvuJs5BNMzTz8gKcIqN7
 sFM3PtHjQKpN3LZ5Ywu9fv0wJo02Zv/KHQyeDpqnV0RfNprBJfCrBY9Rv3mfqGRoDD8N
 4DJl+DEmaGzQXqQzjGkFDA0stkzMMmoCgRMf0W9xalh95cXLr8id7jpKe8IVH11D2Nn7
 qDRrsBN5Y2Qd63dIJ171x+HIqnKJeINsiM+xlX6PnrvplDPzj4N5wX6TfABxLzbRMnXy
 dwiiqx3SpsELnNq5GAi5KiseIx5uZ3bn+QUAjpWMCujD9j1U1zV3Bgqo6pmDAoEUyXfT
 6RGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxOxXW/7VHrMuIDaxTSJzVb1pxj1qqiRmduQJBeTxqXoc6bqugsFP9IicFggXk0hPXDCev1cLfTB4Kgy6+1/W8FC2fETM=
X-Gm-Message-State: AOJu0YzO6vs8Xva46cjuaPnxruv6e71Pk/0NvJ5G8kbCmH+HRmRTFSvr
 pD9VfbVxLDe8tSBtNOonxggbW6kGARjAID7pBT7eOt2KQWGZdS5iQVN3+j88aBCiDhd8aVVMmES
 /sW7HTmYJ49dIf4n5HjLU/muwjZJ56VyI2BZTkQ==
X-Google-Smtp-Source: AGHT+IGOeKhsZh8q3vo1CwFjn5PfrZyR2lETegbrs6OA4Td2qXVZWqFfvioOh3mQaxUqxLBLN79z9Q6K3N84H0UxQQ0=
X-Received: by 2002:ac2:5bc6:0:b0:516:d16f:29d0 with SMTP id
 u6-20020ac25bc6000000b00516d16f29d0mr170614lfn.1.1712687989444; Tue, 09 Apr
 2024 11:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240409162942.454419-1-kraxel@redhat.com>
 <20240409162942.454419-2-kraxel@redhat.com>
 <82b11f6c-fe3c-4cd2-8dca-19b5db1cb09d@tls.msk.ru>
In-Reply-To: <82b11f6c-fe3c-4cd2-8dca-19b5db1cb09d@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 19:39:37 +0100
Message-ID: <CAFEAcA-MiGPvkJe_Dt8kg8FG4-XJ7CR=hBMGDao0UZBQeBS1tQ@mail.gmail.com>
Subject: Re: [PULL 1/4] edk2: get version + date from git submodule
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 9 Apr 2024 at 19:02, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 09.04.2024 19:29, Gerd Hoffmann:
> > +efi: edk2-version
> >       $(PYTHON) edk2-build.py --config edk2-build.config \
> > -             --version-override "edk2-stable202302-for-qemu" \
> > -             --release-date "03/01/2023"
> > +             --version-override "$(EDK2_STABLE)-for-qemu" \
> > +             --release-date "$(EDK2_DATE)" \
>
> How it will look like if there's no edk2/.git, for example, when run in
> extracted release tarball, with empty EDK2_STABLE and EKD2_DATE?
>
> Should these values be a part of release tarball maybe?
> Or maybe it's better to base EKD2_{DATE|VERSION} on qemu date/version in
> this case?

Patch 2 commits the edk2-version file, so it should end up
in the release tarball that way. (Effectively it becomes an
output of the "build the roms" process, same as the edk2 blobs
themselves.)

thanks
-- PMM

