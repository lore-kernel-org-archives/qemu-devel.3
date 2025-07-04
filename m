Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B20BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgFi-00046x-Sz; Fri, 04 Jul 2025 09:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXgFf-000469-EZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:14:51 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXgFd-000868-Fy
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:14:51 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso849668276.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751634887; x=1752239687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgWVAeX696ADS4wvC22eym6C0NlcHUXH23NkY2yCwBQ=;
 b=N9VPMoXcA54iOkIGTLEZIbvy5geY9tasx6opWtUzMEdLPwRZMZFvbNlN4c0B/7XsOx
 zqNyronemTz2XgawjRboaWEWg1G6TxGtxWR4n+D/9htfrTozKsQQLs7mxJgNDcPYO9yJ
 nODbZWs1eORFB5gVyzcbIuMRR3nDPkpS1+3nw0sr9DgYaw7F6kQxO0b317Y25TWEJO2o
 2EVNI43qGk9qH5Luaq3ISKGbGKGDXiaqQg6MGNv5Z6yIz0AbcPz+QBQorIj8wt3h0cS6
 N7wm+An/EGjMUVtf6ksK5gjSbH6PX4QLYpicC026STL9yWWPNK71ugIq2tLSOhygIA6I
 LlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751634887; x=1752239687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgWVAeX696ADS4wvC22eym6C0NlcHUXH23NkY2yCwBQ=;
 b=pBLZTObvSAa/NaFsN6E/TtuHXCMqfNQW2V/5nQjIRaJfdHlXHDIzs46P7/b4mYKUhF
 DKSaCFA6JsZMKo6dJBFElyHGkVpC8FErUvk6Cv/Jqu14OB0UV5aZcdo8lk/ksy7ky1sP
 Erq8RQZmJnGAzF677XvfXAh/Kk+jQm3qn6vGWbXablzVpAr6How8UvWM8zD4ytsrUSF3
 93F4wIuNjltPmkTSmCG5LK1Ks70pUGV9jsqY1t5dcn4VE9Ip73nNmCSX4CsTTj01uIXB
 Pm5+H2oyTBR1Y2zaQKFn82imMmpoc8MzAn/FreRbK4AbRfKlzeerBOJQcebgk1PtW329
 3PbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKHAUC0jK7QEkY4DdVALjXeeOEa8TKLOG+0T1Q0TfhhqqffRuv4g944GCX8J755wK8INJzWqhkpUYK@nongnu.org
X-Gm-Message-State: AOJu0Yw4pan8eVOxRCzy9R6a8/CcPufPlhJVNSgDwZjCzKZy6l43DDYn
 h28rdIXH/sZ40uN2XNdmhyJ8MaGm9IzMWXVT7+oLvwnboyIm8D7+Fevwd/dCkDZLZX/oROVN3+X
 XOsUw0gKQhIk4qFLJvN+Ham82737DZrpbWWNthb4CQg==
X-Gm-Gg: ASbGnct4zhBeg/3NqXqTCg84gUk6aaK7rgM+xfCL9cSphU+rqoZj9tJr0Y9khmAMHFp
 DVVN3ZwsQILQgFGBroKaaTYwaxejQebHIU5KwvLCuSP80QmLU5h8ycVVa3THkdJHnBiY5qY+06X
 fDBmgJ4gi1/PBXk5tVQhUso4DrST4OGqVuX1HEnyOlVYIj
X-Google-Smtp-Source: AGHT+IEHxTsdq5sMOzOnAwfpPI4wg9delp+RPxDCQpnHTDrXLQVwhIyURHz98cxNnYgMDTeSEIqW8ZsAm+f12EfyNFU=
X-Received: by 2002:a05:690c:88e:b0:712:d70b:45f0 with SMTP id
 00721157ae682-7166b81c144mr23919717b3.32.1751634887184; Fri, 04 Jul 2025
 06:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
 <e3e2f53a-33ad-49b0-99fc-c7af4b76a0d8@linaro.org>
In-Reply-To: <e3e2f53a-33ad-49b0-99fc-c7af4b76a0d8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 14:14:35 +0100
X-Gm-Features: Ac12FXwb63s5deve8w9I1Hy8-x-UmmimYtbFzSHox7twYcg-uVB5CEEY8rdhakg
Message-ID: <CAFEAcA82LrhSz47_Q_FwbBmC-Nve-WR2bhfWoWyvYi_60MSBaw@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Mon, 30 Jun 2025 at 17:53, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 6/30/25 6:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > It is useful to compare PSCI calls of the same guest running
> > under TCG or HVF.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   target/arm/hvf/hvf.c    | 3 ++-
> >   target/arm/tcg/psci.c   | 3 +++
> >   target/arm/trace-events | 3 +++
> >   3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > index 7a99118c8c2..6309c5b872e 100644
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -34,6 +34,7 @@
> >   #include "target/arm/multiprocessing.h"
> >   #include "target/arm/gtimer.h"
> >   #include "trace.h"
> > +#include "../trace.h"


> Just a nit, using 'target/arm/trace.h' might be more readable than
> '../trace.h'.

Mmm. docs/devel/tracing.rst rather discourages this:

# While it is possible to include a trace.h file from outside a source
file's own
# sub-directory, this is discouraged in general. It is strongly preferred t=
hat
# all events be declared directly in the sub-directory that uses them. The =
only
# exception is where there are some shared trace events defined in the top =
level
# directory trace-events file.

I don't know if we want to loosen that to permit events
that are shared between multiple subdirs (cc'ing the
trace subsystem maintainers for their view).

git grep 'include.*trace.h' | grep -v '"trace.h"'| grep -v 'trace.h:'|less

suggests that the only current place where we're including
a trace.h not in the same directory is linux-user, where
we opt to use the full linux-user/trace.h path. So probably
for consistency we should use target/arm/trace.h here.

(That grep also shows up that hw/uefi is missing its
trace.h header and the .c files are including
trace-hw_uefi.h directly...)

-- PMM

