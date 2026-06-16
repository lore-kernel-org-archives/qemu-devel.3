Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D4CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSlj-0004zh-6h; Tue, 16 Jun 2026 08:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSlh-0004z1-VA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:19:49 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSlf-0001CW-R8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:19:49 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6607048fa62so4228918d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612386; cv=none;
 d=google.com; s=arc-20240605;
 b=jlPkDEzWyF/c3wgat11Mid3PMUU2PHTFDlKvGL8H535BerpJmGCPZ+xz4HxtA6GM5i
 8q/hAgF8Nlu318EO3X/v+eFN162P6TOozDo/Tt9kPXc8+VW9RTYS0hs0URD5GKWSTZx1
 T9PD24mjAlA6PvPeo9e2wXcskqTdbI0ewwNsFeF8Qr1IdnaT59lHUd00PMjE84RYEbDB
 zwlNxyPZyn1wXg5BEk+luE5Uj2diOFfek3txz3+bLSf5+BfVw3iO7d6CUT3asyFXRqRZ
 2id2uHcRt5PEtwvUrczRBnJr1jwaQJgznQ3bXJoYVwnchVjDY+BKO9Ho/vLUlFXKy+8g
 oTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CMY0c9nN2PflzEseX7iLu28OGDZiOlhEH0Gku+6bxhA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=LTZnahLrEWuu+vY9XG0v23Mi03zI4QjwlQbP42iFEC1D/majXmyAKs7OQ/m2ZTsBlr
 xe8iWbhd1wT4j0kxI5H7/bps8khBcTqtXt5xEVBNmnbRzyS6GVgGIAEFYTp1mJlppdIW
 tg0tEIWW3Z4/DWP1Yxrp06vRJWqQ05lmq+uMvHEJNAfKzpxLFvlArbR4tWpJ8LggzSdz
 ZSDVneqGNbIQzdJd0gM5jOMtDTzXZhhsATTW+EhZ7s1zwDPOCetnJajvhPhE1FwA8jQm
 NrsG6ztis1hYYZ+WtnG4pDFZ8zMl1S/uZ/QssRAKiflwVWfNl0tRDnJxuMZlwxIWMJcT
 Rxqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612386; x=1782217186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMY0c9nN2PflzEseX7iLu28OGDZiOlhEH0Gku+6bxhA=;
 b=kOwr28HIC3o6u6G87Hw3gjxBhfj0O+TXGE1cQYB2f9eqtVfxAfF/zyqdbHvCY82Ndp
 SUXqFZvfn+z+KwoyzI0jIpmXuZtQuJ5j6uFgGvzIyNYBeNi9m88PDI5HvVYLNo3mlTp0
 K27vsauGa33MrFaLv8/1AUSGJuD6oFItlJzVDfPL/+PKMQzKIFx4wmpmg7zDMvc3NcQy
 xOqAaDk+IPOqimVnO+k8reAj3t5x9XrW6LjEzz1C40xYYSIUkN31u7ppl7wqM5unpFKk
 ro/zd26pUn42vT7vYyzaAW9E4CBX/+W58w4bZmBTSquUKnhz32jcZqTVucd6ECWoJvcf
 puVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612386; x=1782217186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMY0c9nN2PflzEseX7iLu28OGDZiOlhEH0Gku+6bxhA=;
 b=pIROkEkzqyegi77SV+XEROS1csaOoZw8z/1AcVY90nXWLxqD2pOi8FNAmpa1LN9DgM
 gJfFC8YZMn7BQm7NrFgK+ScjqkCxSMwVgvIHERSXssifNaCKe0voHNoEEcnstcULdxWd
 msq2BIsiUfIMvuvLxyNbyrE7Rj8JFzvZuw5DDB6hl3LCXlnO+v4j8gAeISFsrCNLaDaE
 RYEyEyen4jkEsFtAM5ezn4N1zrak/dyqk1XXLGjr4Ngb0BEEMtHt/2utswwOBJfeq1hp
 1Eh8lOBDdLg5U/4fAJGFjv2gn4WVFqWlP+GIFY+xn/FDg/m5eQ5f2VQRjRJWFOvOIw3F
 8qHw==
X-Gm-Message-State: AOJu0YwZROArTfmb/iI4m75L50H3EbkR5xoNe/sZOtDnOj4DZGYZb4Qi
 7KRFXNXBw4+MN+m5I+GN+1fenfyYLzguHLOD8QQO+2M/9WTSBZc/plkJayMThKJrlYnXcYDPAVx
 F2ZBI4vZFsEVq26fjseaJ2mzC3kxjZxUaBnH9cQrbEA==
X-Gm-Gg: AfdE7clJ/tEdbZ/MvE/qHae4aCV1lJN4myaPcRo0m+l6cgK8D40ZK30x+G3CM9mFefU
 MDrCvWfQjQlYvGzXNdnperfAY3Ub5CW1RE6XyHoSQ79ncPlMYW5PPUn1KM3+sRPzi0faO3GuxkK
 E2GlSqJd9huN+AXGIiJmL+GyHFHvB0Tb73UUVkx2HQ6C4XekNAXYfSBT3UZypPQ00Udb4FvSg8n
 QpV5jsMNZUZqSavUOjMJI6oBf0c1otcc/5YzoWLFdzg9Tu2RZ/qM+Nkc1VW2W5azkEK/jXJ+vPC
 KkBp4OmTz5t/7GauoYvYfl49sSupS8kq4htVoMaWMvm1i2ja9cZ4wHnwo3Hei9xbxrM=
X-Received: by 2002:a05:690e:b46:b0:660:481b:c56 with SMTP id
 956f58d0204a3-662b62e9a4fmr2385910d50.58.1781612386247; Tue, 16 Jun 2026
 05:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-5-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:19:34 +0100
X-Gm-Features: AVVi8Cf_xV09UFt1spNZ828d3wXD1dx5PAfMI0Qz6dYgJg_cUD1rw6ZBQIy4HbM
Message-ID: <CAFEAcA_ts4O_b6JFuy6-h6bpiaj+jYved84WDiy8d21h0XmUhw@mail.gmail.com>
Subject: Re: [PATCH 04/25] target/arm: Expand DO_ZPZ in translate-sve.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare for adding zeroing instructions for some of these.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

