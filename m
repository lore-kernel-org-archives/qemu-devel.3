Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8CEFD377C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIvc-0000jD-FB; Wed, 25 Feb 2026 12:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvIva-0000i9-QF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:44:02 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvIvW-00056y-3m
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:44:00 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64cb577e79cso201222d50.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:43:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772041437; cv=none;
 d=google.com; s=arc-20240605;
 b=fNtMJ3k9IvMc9LT2/hF2pr25MmfO0XUA0CbAB6S6yWHU8tjgxoJMx5awGna7wFSg0i
 dYO7EyTZ9bEAReUs2mFKUx0aHTgmHPvNSxbL7H6TOBxiKtyFvdU2RrHle2lC2jo+QkXb
 /rQehXD9j0m7qYmTFXpnO7FOGfOqCNlmrdvRVaAAybaN9cRjJ2oLB4Gz86z9Ksx2VNmI
 KPEpazYt4cbvPQCgoJBBKnqV1Uszn/ylGDqIvTCeMA/v3Jtz5cxGHHM1QLubJb3lcKJ3
 cC0a8ecDXQldrk4Bd2MlneBHnxn5WOEQzHUuwHQ4RlRugaQs3x6QcIv/4jltuBhKH53D
 hn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5c9lLHsvBwzYZYUkReN6JIA4gRPe+xJCWEDelO7ofkI=;
 fh=5Q281T3cc8WUg4epsyFmyhkHOeoXoHkugv2URdONmqQ=;
 b=CIqDFmja+T3Vs7i7gWaUGWwJwhRTMHEhl01xXc+DDjrr472mZeT3zofJP1R5IgdUVG
 2pHaobUC7uPuprvWsaA5UJOxufbbHZ3EsZzS8hH0Thm8tlm/3h3wy+31gi6YiqNRlw8b
 Q/2SI8mpuXAZjwY3sQOrhmrsVbxJE7Y+oCQIYxcHekhmDyca635UtMo4C4RRedNRlcwh
 iGfM4YCNMZQ0ZrgWudrxU1qp2hy5cKU/sx1E+cAjSJ+XGxjv+osdoDcf6uqrut/rO0dc
 o3ua5z9pBxkq47Aex6NurvXRMwhnnVR2okfQ3s5wzQsCuf9hlqwLeP7jL8jmqO7fstkW
 zkTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772041437; x=1772646237; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5c9lLHsvBwzYZYUkReN6JIA4gRPe+xJCWEDelO7ofkI=;
 b=ja5+HRDKkXXQLoLDmSwx1o1j8qowck53kdLyu8Ub7K+d+XvXQUlmRjJz5tL/Zmj7Te
 XwsmNyQ9/8FbhSG54q0ExA7iLH9it6WvgRYOAM31JLHeuJj3gyR8w7/uXwginyp1xRrF
 MmFI9pLbta1eGlkc8punicC5Su8aJuXB+CD1XRDniq+EoXyJYjgFrBSl8fkc7qs2HGAI
 cXDCl6R0nuV0hlErUUz+kQm2HGT3vemR5/VGwcZM7UGcrPWu0RdmwAUoZ/UnpvVDrQI/
 65kuOh4CcYYymDwbwJgopLXV1Q7SNW+qnZfM/EHJ425lcNvrsZnIijUeR1XbrOO++2b4
 twpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041437; x=1772646237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5c9lLHsvBwzYZYUkReN6JIA4gRPe+xJCWEDelO7ofkI=;
 b=ud1CftyBiHH7WgmmtSQe0qTvP+O7g/o1yQeQBO7IK4zB9Mb4a7aOqK6yZdOySOmFmO
 st3p5NNQva/xQchBA7iMb9msaljokEnAloRjXf1y5KKQpwOWWsNma705Kk7cEt8Q3vHi
 tcOs80z4cLIGZA0bM7rJGpIDrs9PvXf82pKnDs2yuL1BBNJ+17CZ4MQbJnS4P5SpGrZ8
 pKaie5/NUZsOuoq20sz7vKDvuEdBaXtB6cVJZMsflLUPvF2jBwngzsbam81qx89KdafE
 UXy6YQCJc9hKSs0qmGzXApQJNRp94NU2j0X+WIltqnK4O/HpxNqf7LlS608EglBM6vH/
 u5/Q==
X-Gm-Message-State: AOJu0Yxk6+c8nBWGGO/9zzthVS2IsgZQQ1S3TBshb6MBNLXgcxEI8CDV
 afL0C2EXRd8ZDV/7bhCjt6lznUPNh3+FFzOU01pPcuxueixAYitrLtSbZEj+cpmfCPpn+dbzko2
 vOtluK4NViBpLWgqBsyY1FpSZJ6Py6nCwP10QlL20QQ==
X-Gm-Gg: ATEYQzyKmNqFcwKgNzRkzgK8esxGJn8AClAMIv6mJzpyAe6vo/FxC4grNhtPMXuTt5c
 9G3+qi3s5C0OWKEeRZCCbw2ioNjQSQjXv0HBye5hYPpZradSqS0sSKStcWxAn4nlOd7eDkdvjPG
 YyRsTXgTCwHily+RvMibOAMl2UJmSRbWinRL1Mr/MlaOvToZNKlv3PCdKWWU0VQ8C3BvZ47QnYV
 KzT3p17NIMNiTYrMHX0B1JXBgv7Bv8BMX8ePwoXYaiufaUoSPPTGCdHI3zBaG62ZZvzSvuzEPJg
 Ny1erUeEkhUOwcn8YUJoY6Uhx045NMIC+rJGl871EIiVmbA0VTFKzkw+VVLPbIVHN6dDh+kc5iv
 DMQ==
X-Received: by 2002:a53:bb0d:0:b0:64c:20f7:b018 with SMTP id
 956f58d0204a3-64c78d3fd9amr9854081d50.62.1772041436782; Wed, 25 Feb 2026
 09:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-26-berrange@redhat.com>
 <CAFEAcA-6XMp6B-V2X+=25Q7XKwy5JuOpGj9RNpN+mTNxm71wpQ@mail.gmail.com>
 <aZ8lfQ8fqVAYTLAa@redhat.com>
In-Reply-To: <aZ8lfQ8fqVAYTLAa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Feb 2026 17:43:45 +0000
X-Gm-Features: AaiRm51xgmrcjKgxjgq3Dloq5w3hZ2jhHc7pFBS1iFwF_gOmzb_MJIy57ELM9I4
Message-ID: <CAFEAcA-AgvQESekxEYr_Y85qPzRQAfWvZwbM-WjemEU+tOmBdA@mail.gmail.com>
Subject: Re: [PATCH v6 25/27] util: add support for formatting a program name
 in messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 25 Feb 2026 at 16:38, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Feb 19, 2026 at 10:23:36AM +0000, Peter Maydell wrote:
> > Why do we care about the qemu_log output matching the
> > error-report output? The logs are expected to be
> > quite frequent, to only be there if you've explicitly
> > turned them on, and to be usually directed to a log file.
>
> Personally I never use the log-to-file facility. Instead typical use
> case is relying on the trace points 'log' facility as illustrated in
> the commit message example to dump to stderr for simple debugging,
> and having consistent formatting between the logs & errors is useful
> there.

Do you not find that the tracepoint output is often just too big
to be manageable via stderr? (To take a random example, the last
thing I did with tracepoint logging produced a file 196MB large
for a not very long run of the guest.)

-- PMM

