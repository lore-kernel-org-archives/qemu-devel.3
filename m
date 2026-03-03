Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7818EB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 03:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxGCO-0001Iu-GE; Mon, 02 Mar 2026 22:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxGCG-0001HW-TF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 22:13:20 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxGCD-0005em-Ve
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 22:13:20 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-827390e8a3cso3337028b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772507596; x=1773112396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Zox7Sxd0hNHTTmGxWZbjgue/E+XUQRUZjr9ntI9brfw=;
 b=y+S+mb8QXzfp4Oe1qALVYLIe7rPZPu+5z2tGMBeCYR8Er9ex3+C5XFm/njfABpoTSx
 GTyzuf8fZdnYhVFGIGI5m/q37e1c+fY2/Lk56iW+BxN35Ltduk7CR6dSkIZ1esTWXNp7
 tBMfXbo43j5oUwzl/XUYYz3KzYqQ9VQWgnFN0Bim7kQrpqEfpOZHe5yk2NjAZSffzUIo
 ijdcWDTFjJQnp9KTks008MlwZ446DvGEE/D+19tGglNT7vMk04vTJcVnv20H7aFFnhu0
 XoDWqJD2QjHpETK7Y790rrVidjn63pBcTby9d6j7Vz9IyqROfl/ea0ZYcroZo1KDvTzH
 zDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772507596; x=1773112396;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zox7Sxd0hNHTTmGxWZbjgue/E+XUQRUZjr9ntI9brfw=;
 b=ka9ow0PIKNxVNdCmVMBZVAHo9GPehv7V4BCfugCcxWn3wyvq9oMdxTGYvKuFMu50N5
 +XyDJrAzn7N9jzLuSHSMCCXU/fIhUvTfYajs7dy/0K4tZv+5osuIAFhgiDXfsV94SrG4
 CDdww5kJ53D5uoHQXPAf9SjdMTqqKTOQ8CANVG4wk97CY6IwnNcK6OYOi0PN/rLJBewA
 3lNjo0TYPCCCxIosLmhM3Cf2YhRx/i7fEtFTmLMdtDOqVtzFPdWXQPFpWdQRxaPvnpuj
 caLAb4rfz8PGMLuR2g0OirqZA/uvND5r6W60zVE1Zkt0zFTHgI59tSand7oVohuRhw1R
 6bKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeI/OhHmI44nGSDRkqbBk77ecsdPSYKm0VgxazznQMtsOTNDDnH80hrIj10Rvt6289dIhGxhnZB7Ex@nongnu.org
X-Gm-Message-State: AOJu0YwRm6fOt5/KyqUEeVyDJJq6JUAJcSb1/LvudaKhbMbyRgipxB33
 HYN1j5WmTDQlU/cKRUd+j8y7lQt4u7xcnG3vITOlNQwhdljK+Sz/WjL4JyQFR2tfczI=
X-Gm-Gg: ATEYQzxCqoOaIv1mlX+wU/d1LEkll74ecwnyh3lzwgvt5fyjG/BIIglBzdNKzbkJdQi
 2heAMje9zptViZekIcbsfBhrQmcCHP2LXeR0DUWk6pvVBq2gPJDPXo7ffN+Y6qx4KtRiqP8ZkQ8
 PVpBvrcOoaMu2qUHETYTeiYM0omaQqxTRqd0TnD06GAtUg8CKBjBwUE8QjzZtDuCWniW0G7Zf/V
 f0nefoa8VT6PO+ocb+GyIuak1cgoKSDlRBC0axMre5BeQVjZ6uERz59VNKRvNI6wXNE4fsIK8xT
 prAK1hixJjbdP+iYDoi7HjYv773UF+8S1Mr31dQ44YC1xvluhExP5IdEFA7D2BF1yrB5wBSV+7S
 ZZpus4fZtWYIwqFZl2aVdH4L34LAeEoPR5Wv6w6ClEmM21pFfL/IZxNai3nKwldLrf4YlS9eeYX
 vfClrbbm+eq3qKYLNW1pCuUnxEmvmtL8osZ2Nq4NfX+9NjKTha1M2epEwIPSDG3I4g/ABj
X-Received: by 2002:a05:6a00:bd12:b0:7e8:3fcb:9b03 with SMTP id
 d2e1a72fcca58-8295d9c00f8mr554822b3a.25.1772507595443; 
 Mon, 02 Mar 2026 19:13:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4d826sm14638196b3a.10.2026.03.02.19.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 19:13:14 -0800 (PST)
Message-ID: <e5f37295-2825-4c61-bb66-80f1398b30b9@linaro.org>
Date: Mon, 2 Mar 2026 19:13:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] linux-user: make syscall emulation interruptible
To: Warner Losh <imp@bsdimp.com>
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <b280d4ad-522d-4d28-b203-b87f114d0d81@epfl.ch>
 <CANCZdfqML5j5TLOQn2vCNAgxF9iWrL=92x_+oL4_NOUUJqt+-Q@mail.gmail.com>
 <535bf813-7926-40d4-b0de-3cd181dbcfa5@linaro.org>
 <CANCZdfqdC4xn3eQ35MjY09PLr1-hDoNgJ3quZfqU8UcrshhuVw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CANCZdfqdC4xn3eQ35MjY09PLr1-hDoNgJ3quZfqU8UcrshhuVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 3/2/26 1:21 PM, Warner Losh wrote:
> 
> 
> On Mon, Mar 2, 2026 at 10:50 AM Pierrick Bouvier 
> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> wrote:
> 
>     On 3/2/26 7:15 AM, Warner Losh wrote:
>      >
>      >
>      > On Mon, Mar 2, 2026 at 7:03 AM Florian Hofhammer
>      > <florian.hofhammer@epfl.ch <mailto:florian.hofhammer@epfl.ch>
>     <mailto:florian.hofhammer@epfl.ch
>     <mailto:florian.hofhammer@epfl.ch>>> wrote:
>      >
>      >     The syscall emulation code previously wasn't interruptible via
>      >     cpu_loop_exit(), as this construct relies on a longjmp target
>     that
>      >     is not
>      >     live anymore in the syscall handling code. Consequently,
>     longjmp() would
>      >     operate on a (potentially overwritten) stale jump buffer.
>     This patch
>      >     adds an additional
>      >     setjmp and the necessary handling around it to make longjmp()
>     (and by
>      >     proxy cpu_loop_exit() safe to call even within a syscall context.
>      >
>      >     Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch
>     <mailto:florian.hofhammer@epfl.ch>
>      >     <mailto:florian.hofhammer@epfl.ch
>     <mailto:florian.hofhammer@epfl.ch>>>
>      >     ---
>      >
>      >
>      > So bsd-user would need something similar, I'd think. But it still
>     uses
>      > the older-style
>      > TARGET_EJUSTRETURN. With half of the archs still out of tree, I'm
>     not
>      > entirely
>      > sure the best way to approach this.
>      >
>      > The code does what you say, which is good, but there may be some
>     subtle
>      > reason to do something else.
>      >
>      > Reviewed-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>
>     <mailto:imp@bsdimp.com <mailto:imp@bsdimp.com>>>
>      >
> 
>     At the moment, syscall filtering is not available for bsd-user, it's
>     (sadly) only implemented for linux-user. Which implies that current
>     changes are not needed for bsd-user neither, since they can't be tested
>     anyway.
> 
> 
> OK. I'll add it to the backlog list then...
> 
> Warner

Good news is that it should not be too hard to enable.
More generally, plugins were not enabled for bsd-user until recently (I 
added it in 9b23bf5024b5c7d91cfe9233f71859208f4ffa94 around a year ago).

Regards,
Pierrick

