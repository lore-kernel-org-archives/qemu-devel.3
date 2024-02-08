Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2C5C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAin-0006r4-V1; Thu, 08 Feb 2024 15:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYAim-0006qm-E4
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:10:08 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYAil-0002dC-0M
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:10:08 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5605c7b1f32so386549a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707423005; x=1708027805; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x3ov+QTtMF8Zj2Z6EbLA3awLDSIs9WxnMZMcqe96+Lo=;
 b=K9n4SqwJkE5MeOyf4lpIwAsMCWgflZxmPxl7L6hNnUr1JIqKKJn+5Zu40eQGf+9rjd
 AB/Lpgnm7UN8KGbjdapFtReF9bxKz+EXEGS6Tsda2AcD/n/EgpHLUInoZ5d9zoAqmmco
 yJ6RMcgCWVuXrzaSYCCNVTmKluUl/GG5MmOPZM8RmtBW+taJBH1gwCoNmJ12ekjIhi7D
 Oj7yXbRbHD/bEugBbMK1HS+rAROEFIj2fPIoHGY2EOfoZ2Yu0SHSu9SVR3fONHIXeNp+
 4kbYo7A4udGgvgmbyJ3hMw+BbMeKwltXUKt+vH0du2k5x3Cw8r959Pe2wa5+AskES4nB
 DXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707423005; x=1708027805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x3ov+QTtMF8Zj2Z6EbLA3awLDSIs9WxnMZMcqe96+Lo=;
 b=LaqMRL4jaAGIwSMP70NijxAAP1lr42jzPSONCLNIQ0Tz/ftclUsu7HCF9v+NQ0VYHL
 qbN4HnxMWzHT/UvinvRPUoKr1OjAfg6l/5HorT0OLt86qmKSIZ3MOsl4jYUHqnVuEhug
 O8ovPb13qe1MMbqBnXz5j+38MAikJ2omlwylJAC759uGvFNj7VL6+JqahBwJPKudku/K
 Nyi/XTepcgvFgfd5MIFpAXqToLgenesFk5NnWdCukxVbH3bgN5drFVBcZf3t3BF2S5Y5
 kyXQfahEyMHWP6AAev/pdbmW/r5RrG36q7tLdyXgN5PG2bR0uo2Ij3gUxWBazFIgdmv1
 PO8A==
X-Gm-Message-State: AOJu0YyKOtAOWS2Lv4LBauHqFXoUkigemLTKQEvSCsEwhbZ6wGa6b3ih
 EYSDH9kZEupRqGa6HXs2D0btxqzdfdrqNwnIlahpkqbUX1wINyL/skC8XswgFlIupycec3WY9fh
 dsqeJlvSVlx2/pVK5VTJcqnttZC1hYkZwbUEEzg==
X-Google-Smtp-Source: AGHT+IFGCWgA9B7TOh05HfsD51BtYg+pB4WbVg9D6xFqy6pjSlPVFMt6KorQBIcPo+k1zVBgNaQ3rK7W/OWaZyWZU4c=
X-Received: by 2002:a05:6402:14cf:b0:55f:abe7:8f33 with SMTP id
 f15-20020a05640214cf00b0055fabe78f33mr205528edx.15.1707423005681; Thu, 08 Feb
 2024 12:10:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8p9BKCrn9EfFXTpHE+5w-_8zhtE_52SpZLuS-+zpF5Gg@mail.gmail.com>
 <87plx6bzo8.fsf@suse.de>
In-Reply-To: <87plx6bzo8.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 20:09:54 +0000
Message-ID: <CAFEAcA_cLRruqwz+3muBE-RfyV5RQgyrFgz4beeVo3TtGaoPXw@mail.gmail.com>
Subject: Re: migration-test random intermittent failure, openbsd VM
To: Fabiano Rosas <farosas@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 8 Feb 2024 at 18:04, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> +cc Daniel.
>
> > Random intermittent in migration-test when running the tests
> > in the openbsd VM (i.e. what you get from 'make -C build vm-build-openbsd')
> > Any ideas?
>
> Where's your HEAD at?

03e4bc0bc02 in this case.

thanks
-- PMM

