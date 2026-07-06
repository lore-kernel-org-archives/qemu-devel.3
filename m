Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB53C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeoF-00017b-RM; Mon, 06 Jul 2026 04:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wgeo6-00016m-Qs
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:36:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wgeo4-00020y-Ud
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:36:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso25842715e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783326957; x=1783931757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wxluw9D1uD+htvCsZ+y0++M6PqdGer7BFSTpmNYZbv8=;
 b=PYdtevvtk/s46TNjHqM/mavfKgzN5e6ikDos0cEXMLJiJdHYSDtUcZ32ft1TH65TYV
 iq0+eFvNfU6hNks8fkDgBrJ4CoBjdu5WItu0moFtEd2XBPxz7NI1DThFxVDZLhkn3sNR
 NZPbVtX20l41z9EDhQRtzPBjIFUE/GnL2TXoXUQt0xfW8PRgWt+jLLNYhw4ovC9O5Fld
 QPa+FpvDp0tHKeyaJKrau3L+JNZtdyeTOLNyLBJvCfoPxSztal8LRMYqgaZsjLP+vecX
 a6GoQO/k+fnG6mCwKBv9O1tbBB5GFYzlgZy1OQggBj52PYMpYlEnaWZ1+GgiX/4sTqZ8
 +a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326957; x=1783931757;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wxluw9D1uD+htvCsZ+y0++M6PqdGer7BFSTpmNYZbv8=;
 b=qE/FwN5W81anBkQ7zMixqoQWk/tmQC1i2VgC50GQ6gST4UMzkx76Oq+E258cmpBU+p
 rxjaf0PzbXWXoh7JGPmwWvWa9lM6n+U1msogrPOY66uk+YVZvNZOqpamnKNlIGZDawT3
 7Lz6al6uB7zAhNtnG/BeYWXyyBPBgLzrvzqTG/UEYpkLPyzRdXr0hdmiExd1/DiF713W
 UyDKwp2dJBELWhzaYCNYlgzSVEHJLEUpD2hK/p9x257Peh1jbJbcRWc2PrJ5UwP3JwaM
 P3HaKb648xdVW7WQkOjXMUUErmaNm57oP8rt+62Wq0tPyuOqF3BLDz8sa+oqFV86WiJ9
 mrTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RopR7N6RQbFaOcmnhG750VEWpKkOAR1xADeddYzzJmbXfs/rlMfxOLcKth9VApIFC8FJwVYi/zoUSfp@nongnu.org
X-Gm-Message-State: AOJu0YwBfLGwBpXOY2fqlZHPDz4ExhXfMR1fUXu4KBJxVhTNUqzzpMRG
 aN2/5ktRKjGZB67+WXQDzM8VESfKvLIGjARbEaXPGrXCljVjK4XpravjGKYeIcyGiiY=
X-Gm-Gg: AfdE7cmib/StlNVtti/eoGF3rCTvEkKJJAt0zNgcWY+185TEkZVS0t4F+Qtv+rqSpCA
 /m7NhscrYAZ5L5qfilL6ZjaZ4cykYONrRBXxMTYfZOdJDj2f8u1JJbUZJ856hSvVR5UUro9ryTv
 E2+pzynhxv41RkqKBaGcbC7BkIkLXu5l2kJm399zM3JaR/ZYvpTFBMFpy2cy65XDaUeMDVhFuZU
 1Je/ACYFcXzuAhR8g5C9rF4N5DKXLWn/4BqsNNyZOZi6cb+XPBkR/WOFj38BF0C3kSKf7QTK7qK
 OPkq+UY2epVJcHaj18xuRomNVTxDbyRt0T6i7BZDPj+fWoC9Ho5N/ykB/2vCdJ9mB3F0I/rviij
 StEP578PbK5H88IGCwNzRoDQ1GsA6/ZhhBeSradn/DUv8JgVpH9Q92XynDRv0wdIgOpw+6Uii09
 heS7eayytjQqox
X-Received: by 2002:a05:600c:c167:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-493d11f4b8dmr101023285e9.20.1783326957191; 
 Mon, 06 Jul 2026 01:35:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba971sm587027985e9.13.2026.07.06.01.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 01:35:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ED6515F83B;
 Mon, 06 Jul 2026 09:35:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: docker-image-debian-all-test-cross errors
In-Reply-To: <24d6a029-5f68-4314-820c-fb1786012fb4@ilande.co.uk> (Mark
 Cave-Ayland's message of "Sun, 5 Jul 2026 22:14:23 +0100")
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <0403705b-9af4-4de1-8f66-c56befa5bae9@tls.msk.ru>
 <24d6a029-5f68-4314-820c-fb1786012fb4@ilande.co.uk>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Mon, 06 Jul 2026 09:35:54 +0100
Message-ID: <87cxx0wm51.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 05/07/2026 10:07, Michael Tokarev wrote:
>
>> On 05.07.2026 00:20, Richard Henderson wrote:
>>> Has anyone else been seeing
>>>
>>> Error: Failed to fetch
>>> http://deb.debian.org/debian/pool/main/d/dpkg/ libdpkg-
>>> perl_1.22.21_all.deb=C2=A0 404=C2=A0 Not Found [IP: 151.101.22.132 80]
>> ...
>> dpkg (and all related packages) has been upgraded from 1.22.21 to
>> 1.22.22 version quite a while (on Mar-2026).=C2=A0 Initially debian trix=
ie
>> had dpkg 1.22.21.
>> I wonder where it is getting the old version reference from?
>> Should the previous layer be refreshed to point to the current trixie
>> point release?
>> /mjt
>
> If that is the case then I think you can fix it by doing a manual
> update of the base image to pull in the latest update locally i.e.
> "docker pull docker.io/library/debian:13-slim" and then rebuilding the
> docker images once again?

You can always trigger a local build:

  make docker-image-all-test-cross NOCACHE=3D1

it looks like the source tree build of images has been broken again as
UNCHECKED_GOALS isn't being honoured for me.

>
>
> ATB,
>
> Mark.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

