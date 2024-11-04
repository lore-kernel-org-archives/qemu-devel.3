Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8593D132DF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zTS-0004Qm-Kb; Mon, 04 Nov 2024 10:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7zTQ-0004Qb-8x
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:58:36 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7zTO-0006aX-NV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:58:36 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so3016544a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730735911; x=1731340711; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dYpTSTmX67UUQek/Oo9IY+adan9AthKuCbiNaoIy8Ko=;
 b=AlsI60v+tVI4zPknu5RJJ6Xg3KQLflCuzTf73GNvIl4rDIP+kkt9VglCTgapK8igF+
 N6GAwH/sn19T3ZFTKCgkpkZHw4sDOVR8z+4+LzO1JigPX9hJnjR+iyqkgDAJ7kOWYk2g
 op9RpiQeT8VHE65PttYNZZHtd/9OebZpnw25oDnTuBfnxfyoogJwSDp5/Odb+8Z2aayQ
 vTKHjREBxdeFrbcvfNwzGnqGY1IKunprbUbIelWmWFo4vB0nWn0BwJP4ff91iDIymiO5
 frz84ZTGV3+grSO2nZ1hoESL4C/BvCoPa0qdcd4iZY/TluzxUy8Y8J6N2ybv1ZKJhPB2
 cxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730735911; x=1731340711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYpTSTmX67UUQek/Oo9IY+adan9AthKuCbiNaoIy8Ko=;
 b=paTWEs0esS366YZ1IdxIJGMIzH83UOwboLqgVvpAo+snUoxgxFmP3zOHZ6rFzRfULw
 Ap4z0hk6iZax2CyMrjZx+yPaD2mzOa4kz166V766uefk9f8Z9OyhU474NGv+qGBTPdod
 fjv1tZaoF0Nf6Re4u0ovRvas9UaEw9twJKn0+NHOoC7prENvI4v3Zc0hrs/NnuPga9MU
 2QgyJyOFsh7cDNk3ujWjz9jX2NpKKm5xyRGrTCoxg570ax7QfiJEFHCd4UgES1uKT8Lw
 kr9X0IngafSwD53ExlMpxBgXBRRqgRSpgzO84NkAENA1z37MJGPqMy9iYT/oDRoM/+54
 RC7A==
X-Gm-Message-State: AOJu0YwWO1/zzkj2zBLGwxFhO6Znl6rcCOCr0z37FrD/BfOnmYmW7PuT
 bd0vE0KslEbHL9o1YHSgw2HHhMyEnzCj9rw5doFFTiJ+tESg47QchkWBbk8qiEJLwvm7PzzMsH4
 gAsvbmyA8a2k+wvsrepsdqglYAEKgItNQjs/xLQ==
X-Google-Smtp-Source: AGHT+IE6ADf4qVUnF8VoRbeUZzr30kX3CSIZzaR9lsTqfaKSdIgpgnOOhVoh/yUdzSj1lISgC/9jcaVYAvtNSvamO0U=
X-Received: by 2002:aa7:d490:0:b0:5c5:c2a7:d535 with SMTP id
 4fb4d7f45d1cf-5ceabf49e20mr12718651a12.16.1730735911124; Mon, 04 Nov 2024
 07:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-13-pierrick.bouvier@linaro.org>
In-Reply-To: <20241031040426.772604-13-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 15:58:19 +0000
Message-ID: <CAFEAcA_gNGb4yHvCQf9fOi0gkxn=whVWK8_ztqDBzQ8RcJ-5UA@mail.gmail.com>
Subject: Re: [PATCH 12/12] docs: add information on how to setup build
 environments
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 31 Oct 2024 at 04:07, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> MacOS and Linux are straightforward, but Windows needs a bit more
> details.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We have documentation on the wiki currently about how to
build on various platforms:

https://wiki.qemu.org/Hosts/Linux
https://wiki.qemu.org/Hosts/Mac
https://wiki.qemu.org/Hosts/W32

I agree that we ought to move this into the main documentation.
Some of the information in those wiki pages is probably
out of date, but some of it looks like useful extra detail
that we could incorporate here.

> ---
>  docs/about/build-platforms.rst |   4 +-
>  docs/devel/build-system.rst    | 100 +++++++++++++++++++++++++++++++++

I don't think this is the best place to put this information.
"How do I build from source?" is a question that most beginning
developers and some end users will have. The information in
build-system.rst is mostly about the internals of our
build system and how to modify it, which is a more niche topic.

I would be inclined to put this in a new file, maybe even
in docs/about/ rather than docs/devel.

thanks
-- PMM

