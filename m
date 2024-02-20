Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E22C54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcS0r-0005Mn-De; Tue, 20 Feb 2024 10:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcS0p-0005MP-Dc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:26:27 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcS0n-0007Fo-Km
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:26:27 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so6718953a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708442783; x=1709047583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhnnnMv/gHEmsB2f1/LVlTDnoKPM0Mgphs4pdQ8AaHI=;
 b=DeWPd/tpWe97bCY1Ja5P49JiBfLKQDfUeTKP9jHPuMW+hNUlsNCMWYF+27N3PkGdLp
 1gO7NCSVEHbxyQNGL2dqMF/GwTPZxfKVEBGcJ/pcHztvz597/plz4PeDOpKe5X6tNM4w
 HC8qlxRMCIuDDFJWER5ISeYZSfa+jes/uaMJF/89qAVqYFTJlb4Ph6gF2pNWoGzjqphP
 IGUH3I7uXKdC9wdjDCDIPRjEW12Mrj6ICob4r6WVgU3DuZGi7bUlfAZvYP/cAS2lof+Z
 j8Tg7kRRG1pdbY+GophcM5B0V9U4YNA/akgt9qJEj0KvMwPhlEPvBgpMUzEHS8qytW/c
 Tm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708442783; x=1709047583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OhnnnMv/gHEmsB2f1/LVlTDnoKPM0Mgphs4pdQ8AaHI=;
 b=g8DBLddDAqTZgg/BrH6rf+X6iopkXZkk2TxDiLJ0qiJDbJbaisWXl9DOQQ+ZYCrqQA
 JBbmSRpl1MwLAlMuyJKdKEsdh/OzKC+Wyb2RpXs7O/WN9BUsXtwij0Xyfo/vMWSx0OE6
 TFHeMkgmTFi5KMF4zZ3NV2gTGzrsocd+TspuVhsklDzH4nXSJlYXora4W80sJxv7fIay
 7VUyMoKeJTIKw8mFBUm/ihdCwB1ARFq5f87WN4jb8jyhx8JeIF2QAR+bCQZvAUMmJlBo
 kUDJb6/tFpvcg/z68wJ9n6ZXAwaUwZ0Sn80j3OI8z+IIK1VAuqYmBaAmDNZaVzFElL0K
 7faw==
X-Gm-Message-State: AOJu0Yy0N1coX0SPDYxERQSohtOZWjCKW4gILiBnYjIOqsgsdiJdjsmh
 i0RBvsk8mZ8j+JrQ/IN0HZPn+xVTF05934PPPGnIPoM3zYxde2t4np1pLSemJw/5PaLtjsEB5Sb
 iwUMkJeBkXhj0nunEpc/fGAIGPV3GnZMVDtR0rQKYUNrmJO2h
X-Google-Smtp-Source: AGHT+IHCQJlOZ//W2XAZU7fZWLCdXIQuJovxU6/b5bqA4cxjilCDiq2vjvmts9DBQ74bZLQa1ha6KBg6aJbkXfX28rA=
X-Received: by 2002:a50:fc02:0:b0:564:5973:56f2 with SMTP id
 i2-20020a50fc02000000b00564597356f2mr4537382edr.7.1708442783098; Tue, 20 Feb
 2024 07:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 15:26:11 +0000
Message-ID: <CAFEAcA9QW7UHxJ8PWpSweiq4yA9w+=-ge=MUzbv4scNrWJ8Qfw@mail.gmail.com>
Subject: Re: [PULL 0/7] Ui patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 16 Feb 2024 at 13:31, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 3ff11e4dcabe2b5b4c26e49d741018ec326f12=
7f:
>
>   Merge tag 'pull-target-arm-20240215' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2024-02-15 17:36:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to 186acfbaf7f325833702f50f75ef5116dc29e233:
>
>   tests/qtest: Depend on dbus_display1_dep (2024-02-16 17:27:22 +0400)
>
> ----------------------------------------------------------------
> UI-related fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

