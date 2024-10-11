Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B012D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJGm-0007Z8-TC; Fri, 11 Oct 2024 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szJ7c-0000wP-AZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:12 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szEk1-0006Md-Gl
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:27:34 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so2582771a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728649651; x=1729254451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=so01qP/5pXwY3S9DexgRYUl7xLaihnKYbpO0b2ej86U=;
 b=GtErz6qcVftdEtBeD3fXjNIVGwVEkduL5iOVAYmrWVB03YvO1/xFECuUv0C9XU7dNM
 JOifvzqAPg5SeKy4VuM7YMpbAm8Ekfm/NfNFgxQ8YghN8BR/NjwgXriPpK46gegm43V5
 e1nThO8N7EtUxwrrJ0Gf2u7SXeHWlVhL0NtB9KcppSe5hK+B5ARgjz/garkX3KgwsHgN
 lfN6gVzVsCcfhtHBlJjH2yGBSroWxZLAizyZ9diwpYQavgn/A+WK4QGpw19cPABkehh+
 YAT9MREeK+9W+g8bD32bLVrS06D8Uz0MRNSrBbeDI7GSgAMU6z5sY2jWE9vOPi190Vz8
 FClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649651; x=1729254451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=so01qP/5pXwY3S9DexgRYUl7xLaihnKYbpO0b2ej86U=;
 b=ktE3ESMITf3I2LUKOl/JEeBF7HvEWlFucWlxXiW4LXL7yooHjL/+jTWzZuowuKBy3z
 d9Gve557RE1O4g52cOg5pTX22/IKZWyJGUfNhRdaxCkpscvBJaHVzu7ZLUpruwP58tq5
 2olEAcysTt9Ergz2UceHx3NcKxiJmYyL7r6RGukn6sJiCIdp2M9Vr2Rio8NIDis7fN+S
 pb3+MLyvMME7KFkF7ovW4+kZEQaPQ+E+IMB6USR07k7yIp0pXgfsWVdwnph8itYWWVSw
 zyxnSzWaeLV5AxUj4r23pLtJ1W0Zy3nYOfdNsgDxgbCy6e1nf+C2+r1sQzcaJc35FYfh
 z+Cg==
X-Gm-Message-State: AOJu0YwmIWg3ns225k2lhYrvVOreoOSXdIEIgP56favxxkV6RFPrqUUT
 iKMBPk6l/Qt7R9En3VwoaFP7QCkyfW5NyijT7IJ8hN1jCdvRzBy5ZEtPOp//KPX8rvgCtCGVS/L
 yS5JGJjnwROHMxZ1srfPWpINkM3bC/UspmHRchZtKyA4r0/4i
X-Google-Smtp-Source: AGHT+IHkiKkW0fqG6GLzzZCixKWU7Wf0y10AmUPGbJn7BeMwtLOi0u1k/Vnbbx8qI0sffuWy6t9qOYDB/IqTYnWJfEw=
X-Received: by 2002:a05:6402:3513:b0:5c9:57bd:e9d with SMTP id
 4fb4d7f45d1cf-5c957bd0fc9mr330433a12.19.1728649651037; Fri, 11 Oct 2024
 05:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241011111249.47530-1-pbonzini@redhat.com>
In-Reply-To: <20241011111249.47530-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 13:27:20 +0100
Message-ID: <CAFEAcA-vwCaKhdmcPUubiFQe93z3=7Y3aLo4u6ZbessKzwNDKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] docs: fix and cleanup footnotes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 11 Oct 2024 at 12:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Sphinx 8.1.0 got a lot better at detecting unreferenced footnotes, and
> we have three of them---which causes the build to fail when the latest
> version of sphinx is installed from Pip.

In particular we hit this on the macos14 CI job now:

https://gitlab.com/qemu-project/qemu/-/jobs/8054823697

I'll give this a bit more time on-list for review from
others if they want to, but I plan to apply this directly
to fix that CI job on Monday.

-- PMM

