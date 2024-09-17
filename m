Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C6DCAC581
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqZVS-0005GG-Jy; Tue, 17 Sep 2024 10:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZVO-0005FQ-Jg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:48:38 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZVM-00033n-TT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:48:38 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c44e1cde53so590277a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726584514; x=1727189314; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBW1K8MzFgJat/LN476Gqy95utPIi2cj/PhjYL2lJms=;
 b=jtJpIMqWNEWxDl3/oO0ACnOQMA26eT3MUq6rWpm02f5f779/fYGIqZ09K1z+IfckVJ
 QKS/VNH41XSV5klh3w63tmKAy6AWuDIsxRSXasweotN04Kp2sgDd/qV8LIHH1/zjxvUC
 bT3rbmk6fFflzphxpzppKLW5TSkyg0uHgjy5hYVz7jwsmUHbxz7VRIqZ/0hg/4gbDy1o
 Bl8mfxA1GfIQQ6hPYr2cifAGZPZohdo4lBKUEowiO3EgMRDpk1zm/NSWJEMqCriI/NLS
 1dIg2o3tm8jVtV++lKwqoxpqH9t0shPzsHdOksIR80UIa83vIkihTMSn/2/wEp6bd34h
 M3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726584514; x=1727189314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBW1K8MzFgJat/LN476Gqy95utPIi2cj/PhjYL2lJms=;
 b=vTnFmVLYlraSoK/Ly69atQKXd3HSlzOn4QqDKFA7qIyvhSDRFQWl4Mxm0rFlZsIteU
 eISs3wUzxiNMiNrhuuVs9ZxR65D6HzOtUqGvlJBNFFveuGcEPpyzdwD0MZ5woXZH7ZjJ
 S9Ee2BnF+tHkbbCiLIlYjpWHE0uYQBoz78EHMTFvau7NKPdGKBJeuFqPrigPXrvlQ4tf
 MNwZGTvSBpJpXuYW4FOpU3kkVfvjSCf7+u2zFypwoLXuknM5IJ8txNEaDQ1uvMp44JUT
 B7JdG8qSqLTueP6LSOEbMJUxXP6UNNqrmv4Bscw6SLebOjGvlLlT6ik/YMoYqf1Gch/m
 kMRw==
X-Gm-Message-State: AOJu0YwUmzHL8Le5jYzcsqHakW3KTLOzsGR0I8CcaqUgI8rW+FspaOvf
 BnP5VKdFwh6oYI62YG7qNrQFHzBr4KejLGO2VuscZ2zxSAQzwG0rXElQ0oqXm8ivxbuinLPGcP+
 brucU9Cm630NwIkaDMK3in89Msc2h1+tOK0bPFA==
X-Google-Smtp-Source: AGHT+IFcDlILehg/UgjK6wI8+fFJPeJjnWnLTSlxXph5ROtfzaV+dWSsNuvTXmOUN0m12YSWyOo9zZC06bZ5xx7/4Cc=
X-Received: by 2002:a05:6402:159b:b0:5bf:7dc:bbaa with SMTP id
 4fb4d7f45d1cf-5c413e4bc9emr16155809a12.26.1726584514041; Tue, 17 Sep 2024
 07:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240917103229.876515-1-clg@redhat.com>
In-Reply-To: <20240917103229.876515-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 15:48:22 +0100
Message-ID: <CAFEAcA_Ds-b-YZS1b-44aX=XGGZT-VhW9eYBCY09LVuuUinEnw@mail.gmail.com>
Subject: Re: [PULL 0/8] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 17 Sept 2024 at 11:33, C=C3=A9dric Le Goater <clg@redhat.com> wrote=
:
>
> The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb=
0a:
>
>   Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into sta=
ging (2024-09-15 18:27:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20240917
>
> for you to fetch changes up to 8719224166832ff8230d7dd8599f42bd60e2eb96:
>
>   vfio/igd: correctly calculate stolen memory size for gen 9 and later (2=
024-09-17 10:37:55 +0200)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Support for IGDs of gen 11 and later
> * Coverity fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

