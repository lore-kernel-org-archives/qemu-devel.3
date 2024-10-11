Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA2CFD316
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 10:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szD3g-0001MV-PL; Fri, 11 Oct 2024 06:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szD3f-0001MN-Ky
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:39:43 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szD3d-0002z7-Tm
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:39:43 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c9454f3bfaso1161171a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728643179; x=1729247979; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZtBoB5TQVBHqUIHjxTkOLRvUvl3rl8Qg1G47iko0ds=;
 b=I5Z1c3+exEeet4qb6TiNtYENSnLCbp8wCpCvpZ38tFj0aJ9b5AFBxB1xGZ9pxNd8pJ
 YMiZ4TexC8gXN+4h0iwx4pullxHgcsiegk50aIABK2JNDbvMYW5pFhyd0CMEclQhbR5e
 xne7N5ygBGk4hBobbrtQbk4R9v6sgm6SVcXBgh7IkGN/LwY+0wYmc7O9hmgRbMtyb9D3
 rqwt7f1wUtmBp0PN5SjT9Iv+wOnTpxWjUfBOleTjty/bhQXxFY74J6bwnLTPny3uNhvw
 0uOOs7YnSvQ3l8u7pvn6DQ3WfnEmA0YsxbdKVwqhGJ4QZBP2nQIrwSe15ZY6Zc4BmFgZ
 Ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728643179; x=1729247979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZtBoB5TQVBHqUIHjxTkOLRvUvl3rl8Qg1G47iko0ds=;
 b=U2Cm4Lm3ydGp1MdAk1XW5R9NxPHsSTiDbXy7TomfFqtxaLCP3q1WQF8loNJVTfv7OF
 /1uWb15W2+oSnCWy3DlcyS9ZVcI7tlr0GTTidZYELtBNnLGE7uvF2Dnovvyv+hHgIIfa
 S/ub1GBLd/7OdduiECsP4hOAxpaz0gUY9xeygcuwGDGyrKb+TdMPOZNSmeE4i7zqEiLL
 V30RAoeXrvwJC4wDsW8DmPO/l3IIuAmY0xr8eIvMRhbxdxjHnsZH5E/VyzeALfTXyXzF
 tM2bJBheweAAxNnuNLhuXmIrE9GNxsY9feKDyrjBoVL3Tpk6BkJ5FvJcHymLoiHjPJDd
 5ZFw==
X-Gm-Message-State: AOJu0YyOKI+yo316sCUr4QGmrcMnyW2355RIN7ajtxzN7Q7NwpQomKbj
 fGtpZoo6gsWUMkWnhZOomqoRbfD4s9/fED0hwk3IO54n3TPtgTxSru9e5Rze1IzzDWkqK9gzUkt
 GmjBE9cNY58VDqteHMYpOY5fTPmRngiellfrLZw==
X-Google-Smtp-Source: AGHT+IG9mxj1swvphGXn6uFE17v3aCHGHVFH9mdynZHHnmkEp7b6KAvUavKZrcbsmKJSJK9iMa0OUJL3pR9jk2jIlcM=
X-Received: by 2002:a05:6402:1e8d:b0:5c8:79fa:2e3e with SMTP id
 4fb4d7f45d1cf-5c948d50e17mr1563423a12.28.1728643179090; Fri, 11 Oct 2024
 03:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241011094948.34550-1-pbonzini@redhat.com>
 <20241011094948.34550-3-pbonzini@redhat.com>
In-Reply-To: <20241011094948.34550-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 11:39:27 +0100
Message-ID: <CAFEAcA__-gDGRt8C0fcx6e1WqpsHAZj1SzG=XTyR_T+6z-KY6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: avoid unreferenced footnote
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 11 Oct 2024 at 10:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The link to fosdem.org is inlined but also included in the footnote [#c].
> Replace the inline link with a reference to the footnote, because Sphinx
> 8.1.0 is a lot stricter about unreferenced footnotes.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/testing/acpi-bits.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/testing/acpi-bits.rst b/docs/devel/testing/acpi-bits.rst
> index 78aeb6aa3c4..2e4f1d23def 100644
> --- a/docs/devel/testing/acpi-bits.rst
> +++ b/docs/devel/testing/acpi-bits.rst
> @@ -37,8 +37,8 @@ dependent submodules `here <https://gitlab.com/qemu-project/biosbits-bits>`__.
>  This fork contains numerous fixes, a newer acpica and changes specific to
>  running these functional QEMU tests using bits. The author of this document
>  is the sole maintainer of the QEMU fork of bios bits repository. For more
> -information, please see author's `FOSDEM talk on this bios-bits based test
> -framework <https://fosdem.org/2024/schedule/event/fosdem-2024-2262-exercising-qemu-generated-acpi-smbios-tables-using-biosbits-from-within-a-guest-vm-/>`__.
> +information, please see author's FOSDEM talk on this bios-bits based test
> +framework\ [#c]_.
>
>  *********************************
>  Description of the test framework

I think for this doc, because all the footnotes are
simply URLs it will produce a better HTML document if
we instead convert them all to hyperlinks in line.
At the moment you have to click on the footnote link
and then again on the URL.

thanks
-- PMM

