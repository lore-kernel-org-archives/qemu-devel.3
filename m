Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DA4F31E44
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wArfU-0007Dh-1j; Thu, 09 Apr 2026 11:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wArfH-00073v-D3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:51:31 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wArfF-0000Op-PL
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:51:31 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79a60975dc5so12077827b3.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775749888; cv=none;
 d=google.com; s=arc-20240605;
 b=XmDdCHfGS2O9Rzz/l7/Lsof3QpBgB2hgVAW2URjghUGqz+2tHRkoOJ6sW2ssynlFWd
 yAT5eshCqScioZQIuIDDUfH/2XWXMjakHx+a10+CipB98NIG8pwyKzPcfs53yHaFVotr
 M4ha6ZP4ZSOVJkGjUy4mUZw3r0c8OXcxVS1R1R7GISQ/kpoCfGhwy9+33Flr8e5xKTgX
 iaMcLajiRqUDMmbWlCuwJfZVslB/az9En+SsBPXjem5ySEqh7Q71Ei2qO8tt8y/c0yc+
 lTzZ+u3Tx2NRJhY0jlQl34tIanR/pvkX0iYeH+OKU4mKfPZgrfILUm1JZwGuCi0qTh9q
 AFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c8TY27wWNlO+TidtfvNQahmpjcDAa/fwBc1qFWnBTIE=;
 fh=Y9lXldKquU9Bcr843Q0+0eyUvZTOyRlhLgjIsJQtlEg=;
 b=gY6257JqV5dt36RnD79Puiy2Ty/MmP+rWPSj/mzanQycc8uxzDywfzVxIMct4K873L
 rwHULt+p/t+ml5lOQUR2vD8R1PPUZtRxmFIhHd6dJavik25/CGe9X8JgMtz60SwZJdiZ
 HIz4lNn/N0EBqfYPHOkwhUoNwzwXCiDaUnAXThEc5aHwNCc9IAaoWV6rNHfxsc/CUkWA
 JBDHCNN+9XYdVH1x1pRecPQVp4TD6Q9Bx6EXaDIpAhXUAqIAHySLV9k++pug0oHnauQl
 xbTgv102/tSRGLbjarKh88kS3U+kCQN4a/7/TgWQrya8zM4XW9DlRmqj6eVhWK/yCc1+
 y8NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775749888; x=1776354688; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c8TY27wWNlO+TidtfvNQahmpjcDAa/fwBc1qFWnBTIE=;
 b=ntv3J2E360oa89d0rwP9VXWAJaNNSsQnLkTAFNIePQRQmH4AMg7zYavzhd+ZDjcrVQ
 7+NgUSiB1QRN9hHgDFR70vhrAbl0jS8aGn1vUaByLjwvcC5HqWWjH9m/3/7Ml35Aua9T
 atpyTHqFZUeZC5dSj0OgXad8G9gwIp/QDz28KuxZH+a+17qUq1OwP2nQ8t68THy1P6Hy
 tmcldlTNONkbQ6B+WtIx1q2OVWw5zYNJv9AvMTHNiP7RqS1wLDUfH6b8w4hZ7B9kM02P
 NDDOZHaIihfNjxMI/sAlVkWtPhniWG1n5wRlsknVfmwXnfBYruUENhqDMtg6I5lcnUbx
 1hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749888; x=1776354688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8TY27wWNlO+TidtfvNQahmpjcDAa/fwBc1qFWnBTIE=;
 b=b2JqZdj9KzxyETrjjOPdB5QKLR0EcZfK0yKBD2z5z6AGSdwWk3Ii77eXRbSCx27bjo
 qstVpepThh1/QKD6Vc5wgXSHocgph1nf58yR4IcxXpf4nWjG2gto8FTEDfy6XhLhlnZ6
 6GN+NEqARm8WmxDgcYfxlbn6p+n0LQj6WfOwGYpjCATcLBx9mGq3zW7HUNQfwoaJHMRq
 IfdkOerMfKsxbwupRmOF5T3LLx873PqqBT8G+wQYym7zDMQZPOkkohBfNQTDCixJvR5b
 Fuk1NOZEWEFlzeMMSd5F9RUlcuuM4nlvEIA/w7FP3QQ01PqJ3CpRTCoPEOPlxDzwC4cV
 s8TA==
X-Gm-Message-State: AOJu0Ywq+PU6hDux2iWJ1B4vH+tOvSgOOoa8ttSpgEQuNGronQ+FsdgW
 Fqrh/Tq5C3efE77GL8HNWH4bdZ/O5jXaMpeboH8MimOsltjXCEjDPApJGewqRjUz/7PtaQrIxl0
 FwIZUIxMhTTd+d5988No/SeuebZsSssefRC1fhcaUEQ==
X-Gm-Gg: AeBDieu5nvR8N8vMumeXNwiSFvMbfiec94AnQswx+gyqRpn+gXE9C8AKSf/9/i9fldq
 EFvDBz+JHlVwtAslv6GAw/i9dkdY9/pvbRpXQEoOp23tpu8qPdMs8VhRDrad75QCKZYnyHtkGGa
 t0gCt5kkyf6ZOFs22IiQn4qfuD9r6Ur6yMLFG54f0cFsqJcbpiV7DyDguxkBe/gvWPrA0qyHKgY
 Ct7M0JZ7R8SrXQ/b2XmEcBWMlPfHwA+odbocbhB4ZlfK7g/2ec+RzzW2prjhEOCMeYOZpqL4ecq
 MTkrNmxoal3sF5x/8prQCI+hknL+c/WS9s5MVIm06deJjnDFDti/WMd42HfeKls272gF3Zc2+t1
 Sdw==
X-Received: by 2002:a05:690e:43cb:b0:650:1485:26c6 with SMTP id
 956f58d0204a3-650486ef810mr17821202d50.19.1775749888378; Thu, 09 Apr 2026
 08:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 16:51:17 +0100
X-Gm-Features: AQROBzBjfZ-OKubnGZzZsOsd0PaLIW362ws-YqKyzOItkm-WBeLFuU9c-iQaGh0
Message-ID: <CAFEAcA9rQez-BFVhpDBjFKZjKNXtCuK8ikPWRryN1Xed-MZ6=A@mail.gmail.com>
Subject: Re: [PATCH v11 00/21] target/arm: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jim.macarthur@linaro.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 7 Apr 2026 at 23:22, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> This series tackles (most of) the rest of target/arm, especially tcg folder.
>
> We extract tcg memory operation in a new header, with a new type representing
> virtual addresses.
>
> Initially, I went down the way to have a dynamic definition of TCGv, which
> required much more boilerplate and runtime checks. After discussing with
> Richard, I realized it was not needed, and that could simply split 32 and 64 bit
> properly in different files instead. This approach will not work with other
> architectures, requiring something else, but it's enough for target/arm.
>
> Files left are:
> - target/arm/tcg/mve_helper.c
> - target/arm/tcg/m_helper.c
> - target/arm/tcg/cpu32.c
>
> v11
> ---
>
> - update comments

It looks like this is all fully reviewed, so I've applied it
to what will become my target-arm queue once 11.1 reopens
for development.

thanks
-- PMM

