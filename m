Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9F4D2D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfe54-0000GJ-3k; Tue, 13 Jan 2026 08:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfe50-0000Ar-Q1
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:05:02 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfe4z-0001cO-9S
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:05:02 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-78fb6c7874cso82017777b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768309500; x=1768914300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGP9pogrURu6COy4QscKhkqpeRI6BYk1AL6F+e+sjmw=;
 b=sgfcXrdH0G04BQKQ70bGwxibZByOc+zG6c9ogCYLox2NscucUCRfPnsAQKPWg2JPq1
 Qomev3RQ4XcD+iSKZZlD5H9StmVC5zrcpfvbDbQJI2EvRavRzbkXEZgLvooGPoOFi9Wc
 P/19ITcJ0W4od3IAabipESHjKmG7Eeu3k5Y0yi3do6Xis5w78qofVocuEWVCrqdn+luM
 SLhHYBXKUXJCVSYoYgBbnH2S4m95kL+0+UCeWPyfp8YtC83Hiq0S4hF7yz1vD33phzVE
 KBcnMMcG8evOgt09GZKDji+HyIr3HaVdfuY9PRfMNrNbXfNVWd1AdQr072cxuPIUB2KR
 39/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768309500; x=1768914300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGP9pogrURu6COy4QscKhkqpeRI6BYk1AL6F+e+sjmw=;
 b=ZD98/jMlRJClLZNvP7J6wLFzzd+nuZDQyE7+wjRWNKr+T4TGXwtYdDy8Jn8ZmLA8cM
 iZ2Z80dLCIq5vNKPkLw6a2D/8xbxH+dzeBBD9KUFUfynvXXQ7bydE9Mt5Ig3fdnjKfke
 /HuCvrmuplLsUvDBxXpgU0mQnimqJOhmXbnfk4TJBVlTzDiInCGT8UuzLWrVRF9kvMa0
 068aBS0el8geEg1i2f0Mp/Qh9yPUDIrLYX7pytqga2h7p/giJziXhd646mDwwfTy3Yi3
 9A0vyMmdjBiwqy7Ho5N1y7TZPnOrTWADEPzNQVetd2oSltLkXlRUsBOq+cFagyJl0XnP
 RQCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ1YwPchsHTQlHJQl+EIoko6np6E5pU1ywQG0JCwNPqyACGPEhKhKbzfwz59ppqA3cz2fRDFMYaDU3@nongnu.org
X-Gm-Message-State: AOJu0YyPrg+mB925sPjyzRpJkMauJtFKqmxfVGyjH8azfb1RJyEvLDP5
 STpFN4feBpCdXe+z41ZnhDWlpwciOuydqM4G5Gn+wZrDqMhPmYIPBh2d0nJe3XjcAXKGi2oC61h
 hgiaHgzUNr2swQNuzcvvxSfC5h9XROTIZX7wBt6mCxA==
X-Gm-Gg: AY/fxX7LLdoaPCMke3Anvb8mOx2tlzGw6fN2XJGo30jMLLMr0CqRg6ja0GiR9XKqYIi
 KTbpXq2jp5M1LH29+E1r3Rrj1UXZpgeP3q7Q0jKLTYsZEDmHFDchBjUXA3cUfFB7j/1y7Ow3KNF
 WqsWdKnfehq0IHhJLD21Ai08BbGP6pn1h4aI+CedqmzXuUzkb95VqL7oQtf3DyMNhLzVTX2uuA8
 YbmJjQ4l9M4Dr467Znn3mRdzF0JjV8DCvG26MOl4FStQIRK36+lrlO5kXP+w2Bnd5uK8jnct3RN
 k4ZNZEYsqRg7C73LxsjmCPY=
X-Google-Smtp-Source: AGHT+IHQtHtKnt78UsVyFuVtrBhh4vIgmO871yuANhGR3F7ABjae7Y+nc8JoZfq4vxZ9+DkHUlhRhF9MCTQSrarUCcc=
X-Received: by 2002:a05:690e:4195:b0:646:7a21:f03c with SMTP id
 956f58d0204a3-64716c9dd66mr17404436d50.81.1768309499959; Tue, 13 Jan 2026
 05:04:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1767716928.git.mchehab+huawei@kernel.org>
 <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
 <aWY10BYoJjck3xX8@redhat.com>
In-Reply-To: <aWY10BYoJjck3xX8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 13:04:48 +0000
X-Gm-Features: AZwV_QgnWogDDwf6bylM0e_z-Ke0E-6T6CGTvYJ-MkEz1ntFVBkkixZ9VzADUI8
Message-ID: <CAFEAcA9wnmZOLnA3zb6FPfjrEs-3PRBmyBs=FfiQW2OY5GJfTw@mail.gmail.com>
Subject: Re: [PATCH 0/1] Sync kernel-doc.py with Linux upstream
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 13 Jan 2026 at 12:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> TL;DR: I would not want to see a new top level tools/ directory
> created, and don't think it fits in python/ either; scripts/ is
> a fine home.

We do already have a tools/ directory, as it happens.
It has two things in it...

Personally I think tools/ ought to be for the set of
things that we build if you --enable-tools in configure
and which we document in docs/tools.
tools/i386/qemu-vmsr-helper.c fits in that idea of
what the directory is for. tools/ebpf/ does not, but
I don't know enough about what it's for to suggest
a better home for it.

We might at some point want to tidy up the qemu-io.c,
qemu-bridge-helper.c, etc that currently live in the
top level directory so they go in tools/ instead.

thanks
-- PMM

