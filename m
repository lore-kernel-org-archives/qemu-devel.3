Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64948CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnnd-0001vr-8a; Tue, 26 May 2026 05:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnnV-0001tP-SQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:10:03 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnnS-0000NR-Df
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:10:01 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c477a3278so10439368d50.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779786596; cv=none;
 d=google.com; s=arc-20240605;
 b=LWbd8fJ8HdKEZW/zOZEo0KtZ38Om/ng+S1PYOqCM4DZvPHFEI5pRW/YwtMMaRusu8z
 cjot+51JKe03PiLP9PCVQLiqqMAJSK5CL6wQc9YwN7W5ntrHap/v1SGSES3SxyDdISx0
 /g+EcikmWeNK4kxP6cLyXhLM3QH652+al+pnsjC9kLdVeJwOvr+FTh3YtzJncCC3ma6k
 KkKR0cym2HS9SgVfOnSsWX9TXCzYJQ1Bx3FMHKbb8M/x1/nDnc9WD7DA6BUiA24EFi4P
 c85GxbPqoUcgg/LOtEWMJsqA2y4qJ8drfgkNu9ClE2xjkqGV5afZbQoL/6EHXRgS+4bf
 z4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QjBgp83PGOTh0TQkQed+vB/tJ2ikY12Cjb9XxnGJEp8=;
 fh=0OcKf33ZCbieJ5TGKYb3ColzD0d74AP6xk66/bUL1Wg=;
 b=lL8NPqAEg9MMqsktX8nXA0JinIz0tIdKlPSIO0LNT/mTaTlPpyDAQrCfqYtEpS0e7F
 cQmKZUGnVr/zQwHcK5BbHHCNuBFo8SdGLJllLMgGildn//Dg2GE01KH9zOqadGdRDCjw
 wEWgfQS0BagSncGZII2KtbAmELSigBruFLf9hSh34zRWT545Xe89JZs9PkTvkhdb+aCw
 mqmeW7nfJXpeTzHc/e05GjBD3cOAm28BjHBsIfhwQ8FM+cY1rqtQNOggrLBvjN8KIizO
 /H+qj63G/vmOXHUgwhpjXZNMGSm/xmYtUDw09NxFPztsTpcjaiBZ9VyxfwOtFd1JEAif
 u+Ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779786596; x=1780391396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QjBgp83PGOTh0TQkQed+vB/tJ2ikY12Cjb9XxnGJEp8=;
 b=td7aabm283VcK7g3ImmkYIDTcmYrzJld9xxBiB8vWlgw2c1nmDxRGnrozkXUq4jXEs
 JCgUpdLQWAnV5VCfMlKgXhF/aIIZzRFN6cOt3HAYE+hl6actYLR07mFw8uQlJdpwjEuV
 MCenqcAs7W7El4NRyCwo5Hu6WEJGtIqMgvL2Tl7jR67cDeCJIQmAiTXQwIw3AfYz/mL0
 XjkV6kCYi8HKdxrfxAADt00U21NKwwH4GhmBziUbOJnefRuFPZ+4DiOGUXoPMSOSuQ5R
 rtcXn2GgwZ4OonJFPTo1S3lSQUZuW5e9dZJIRhwuRc791MH4mLFDDybjc7KQWbM0vg+4
 hwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786596; x=1780391396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjBgp83PGOTh0TQkQed+vB/tJ2ikY12Cjb9XxnGJEp8=;
 b=a2vkyyc+B4pPoAhzf0FCvzegK7PmLcrqrBfPHhyZXW99tu6fOo/AWVKkhtvWpr5xIE
 ZMt4dHhGd4AbYHSHZ4Nxd8UCtNRgqYtX2CKylR3XeBJ3fc0cCOEmtHx85/jJEdF8vfWE
 wzd2TibzfVTYGStwId7FSFOekW0U0RrL9fxb+VrkVtBJuKi69pAP0JaFSaxpxCcmNkR1
 vNNTCck/s2/0+bJGj97ZNdeZ9iTuNCI0XSbrl6nqZh0oBLczhZ+jlMHg37qLWQhByjZv
 oGjrLQq8eYYsS2EZ+sG/fMzp2t8XSTKRkAUOt/mPp9AzUTJ4PAl/hbZE1CjaXrHBzb2/
 K5Rg==
X-Gm-Message-State: AOJu0YxsxA8f5r4Q44Ki4JpUplSARSgD6HfOumC0qyf77CxVZ2K/6xbt
 BxiuwlKpe9FRlOeJfynHoobGfaylEd2TsqP4ssYGe2W0sZllKJQUFMYy78cOg9mNcfleJmlGSWA
 Ec+g7VRLIl0r4v5UllnMOmHkvdI+YEbtShraXDXWRHKOB0wr4eLsu
X-Gm-Gg: Acq92OHzb6NVMtMrZ/pMrsECGskKDB24QSj52hoJB+tGl1NJaKZVat4KyYaGaTPI6gQ
 5WtZ6aqcS3TLGnc4RP8wribf5C7LWBjiUKYilTA/ecZBiZiWzW44DCQgzLKhaK9HTYMTEJCMFaI
 iqByuSmTBVyD8duDh4wXyberUQhD1Z+QftQlio6h89Z4GipYcNK/nRMU8rvuWtfbKk0WxD7jfcO
 3Iz1Miym87s6SYlSM0pAt1sPCiWkCHRxU+rL4xiBPuG8mmJ1lG5qzBTqnshMRK1W2gXV1zKgCG2
 ajbfN4DD7G1dwH07n1awG8wpyEL9jtm9nFwN4oqmvB8pOa3Gc84EBIzWGc4dFt7C1oJasdHvQfV
 QWg==
X-Received: by 2002:a05:690e:118a:b0:660:109:b90f with SMTP id
 956f58d0204a3-6600109bbc2mr4482408d50.56.1779786596356; Tue, 26 May 2026
 02:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260505185157.608910-1-peter.maydell@linaro.org>
In-Reply-To: <20260505185157.608910-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 10:09:43 +0100
X-Gm-Features: AVHnY4JuQXXA4qP_CnYr6Ep9ketJXaXI6giYHu5SAULHt6vIhxOKYjvOCLNHGDU
Message-ID: <CAFEAcA_pcTCLwjYySWtW9KsRXvfkttLQiEL14umaDXtwj3Rdzg@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/net_rocker_of_dpa: two bugfixes
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

Ping for code review, please?

thanks
-- PMM


On Tue, 5 May 2026 at 19:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> These patches fix two bugs: a NULL pointer dereference if the guest
> does something wrong (reported a few years back as issue #1851),
> and a sanitizer complaint about unaligned accesses that I noticed
> while reproducing the first bug.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/net/rocker_of_dpa: Check group ID pointers are not NULL
>   hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()
>
>  hw/net/rocker/rocker_of_dpa.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

