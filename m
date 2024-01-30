Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66925C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpwZ-0008KD-23; Tue, 30 Jan 2024 10:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUpwK-0008Fc-Si
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:22:21 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUpwJ-0005V9-BS
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:22:20 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cdeb954640so57042361fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706628137; x=1707232937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhfYWFPTLaVCETvG+E3DzGpKwVJo6yuNwYkvrIphBOM=;
 b=k0krZYhlnfrwpPx7WbMoer+MPWoFd15NFopBDutxP0lYDMmVcL91NLR2nelYgMwwTb
 82CS8CX6U+WQYvNvMokLSYZ+HmOpEQhw8znAZy3U4eN6k9Zl9xH10L03/HP77+/rKLQO
 PcthIlpcH5DruRwwMyG0HnaOE2UzsMPXQDdk6xwvt37CPWnBeFSOywp4sCsARiNsYMvd
 Jutgf4CspETcmhcDFuH8hJLE0QqkzD7U+zIavKEeGYhLMePgM6rHtRO8nCcveKLgD4/l
 L+SpFTZV3b6RXvv6bRaWZXPBREwE6O3hKsluT2KLpfhJsOaF/8SydernKahJ18sTk4s4
 Ux7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706628137; x=1707232937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhfYWFPTLaVCETvG+E3DzGpKwVJo6yuNwYkvrIphBOM=;
 b=qUILdgZffFE0FJtjL3S2KXpxkCmPZZQRX9Y6QaPSNyKSbajTu9nF/sUykW87WCRYSt
 OlJ8yS3JY5Iwtrdoyz4swOf5eWHUdbPioth3UvOc77o7+NrRQ75QsHXVzx2eu6U17CNb
 hxI0QOo92aLwRCZIYFgKfk4poBj75hiWoKrk/pFswzwnIHSwwzGN8YAl3ZSNqB2zjz2e
 ZYUYB+/tMQ9fDA3QqiwSMaXzCTdKbXzreDp3FE8BnjHMsh1ZRGTetGwYyrbdiEevGEhL
 Xhl/vyT7xTGa5mB5WdrQaAn1Y2xNyRKx8gu4kLFnsrpwqCbeFcFY1QF/cJq5nPV8Neod
 /q7A==
X-Gm-Message-State: AOJu0YxLMT1HCSvvpTshG6OTZiM0nhSvh8OIFusqtP9/AozQ08PUKRo+
 tSl6qfEQPNuSEtEUy2VtSfdGdrDlIxhKe+CgF99iCwKEHYp0FAPLIt8LKfkYs/0Z9clG6WVwFp4
 BexP4/+7yp63KezIruIKp90jUNYNM+uA1YMU+Vg==
X-Google-Smtp-Source: AGHT+IG++GT0MZ6EZePQQZdfF8HD02NL+I0wAK0X8hdRcF+PNB1LzJV8OTX9Fa1LXYkYMu+rhR814/mgLis/PKMyqoM=
X-Received: by 2002:a2e:a9a7:0:b0:2cf:40c1:206b with SMTP id
 x39-20020a2ea9a7000000b002cf40c1206bmr7038204ljq.10.1706628136926; Tue, 30
 Jan 2024 07:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <ZbjMNZpX9kYyw5hW@redhat.com> <82lcl.1qg7az61g8ip@linaro.org>
 <875xzaonzv.fsf@draig.linaro.org>
In-Reply-To: <875xzaonzv.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 15:22:05 +0000
Message-ID: <CAFEAcA_eMbsyt8rogW2VNqGEqbe0EXPhyf9uv4CdKZZp6ED6-Q@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Tue, 30 Jan 2024 at 15:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> I suspect the problem is that checkpatch.pl is an import from the Linux
> source tree which has since had syncs with its upstream as well as a
> slew of QEMU specific patches. If we don't care about tracking upstream
> anymore we could bite the bullet and fix indentation going forward.

I had a look at trying to update to be based on a newer
version of the Linux checkpatch some years ago, but it turned
out to not be a trivial thing to do, and we've only diverged
further since then. (Which is unfortunate, because I imagine
there have been bugfixes to the perl script's handling of
parsing fragments of C code which we'd like.)

-- PMM

