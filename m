Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40709E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 11:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJW3w-0005Hc-Hj; Fri, 06 Dec 2024 05:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJW3v-0005HD-Ka
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:59:55 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJW3p-0004lM-Da
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:59:53 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf6ac35aso2534667a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733482786; x=1734087586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cCjvmfEs5EJgidXuCv0XGMV7m2dF6rGGbBlwA4fs2fg=;
 b=qPOQw5fJgK3T0ZuIMpcrzUOfWTcz0ErHgQTYtxC/ApXz0Z1dPySTsNBkLu8cml+Y9t
 pTya+H/MUHBuSJ+sJsTxorHcqJvL4GL7V6I1Yn6NqgKcYM4/YpeiE2GO3tRHgHsQq0l4
 BebT8WtAoT5RuPMg47iuDYe3/GMH+fYz2lmz5vZPQ00qtlYzmdTWq6QkKwp9H50m2ADG
 029HQhzudTu5l91shtg7ZvSg5FK2naLf9rJn0ruRk1/S0mqNXx/Dr6CW58AeIgmUZB9K
 qd+2p6+B8AkyWIUcOJy5CzIM0HSAwHcWcMY4urnruALzoE3Yz4A9i0JJzR6mzeaxViFj
 nMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733482786; x=1734087586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCjvmfEs5EJgidXuCv0XGMV7m2dF6rGGbBlwA4fs2fg=;
 b=H11w+X6nB0e567Hby902/ttVvqZH6gJdnBbcsttVfbIwxblQwfpksVk43JiPpFY+6y
 /eXauLvbxkdu+Tol8wEWWqD9FG/CwennqnHQsnxCg8aqYQAh2+0NgEDBiXsEteWRrqyQ
 fiYMFI/7rm94wEaiK63mvRVGW7Zn4RRC9VcqQc8Pc5UJbKBZ/Xkdufaj6sNI+tfmONOK
 Kh72/gjwr5CIflylNPOMeJ0drjnyltI5yJAF6sx3884G4sQCCK/pHKPumWwYc5Rn4Nn4
 OKkbshFxrEBYupteQpVF74IaPf8Rp6H7isWCJONJ4nMVABDAfupt4vPk4oU9lbyzydcF
 sFJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuL4lQoBxFHc+6ZsJ/N6J9Y1RRkMwV6aYY6axuo1+QSvTwzYde/O7ZLYLW61ke9+NqEEuXocVT5o8i@nongnu.org
X-Gm-Message-State: AOJu0Yzv8KISm8VuFK8sPyg967+OgkVhBkvelkvHxBqcTUuGZ22Ghqna
 ppNzOl81IwMUzQQgGq85i3uA/QxnFNUtb2UPpVGAAttrKh0V3ihiW34O4mn9GX3CWfZIWV6n+Us
 QTjXbXBTa700q1w/shnq0dn/bIJ4CvOAQMuANQA==
X-Gm-Gg: ASbGncvlCt1633CBAZXyJRBIBfeoEg8Se8QZjeG9zbEMEamAw8pOH0nblyFD0XRcpGE
 hzNN3vWA3nI09ozrbFYrnDjZzXjUcmKBR
X-Google-Smtp-Source: AGHT+IHwzOcUzTAejnJDa1pS1n1NDczMHLQrdR232D9/vsdR5L8/dNlSMgwd3uJnhocg06m4DZM5GrHKgCrAjZhKNIQ=
X-Received: by 2002:a05:6402:3604:b0:5d0:d2ed:ebb with SMTP id
 4fb4d7f45d1cf-5d3be661a54mr6052184a12.3.1733482785871; Fri, 06 Dec 2024
 02:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
In-Reply-To: <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 10:59:35 +0000
Message-ID: <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 5 Dec 2024 at 18:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/5/24 19:15, Richard Henderson wrote:
> > On 12/5/24 00:07, Zhao Liu wrote:
> >> The MemTxAttrs structure is composed of bitfield members, and bindgen is
> >> unable to generate an equivalent macro definition for
> >> MEMTXATTRS_UNSPECIFIED.
> >
> > I'm happy to move away from bit fields to uint32_t or suchlike to enable
> > MEMTXATTRS_UNSPECIFIED be a compile-time constant.
>
> Yeah, if we go from
>
> typedef struct MemTxAttrs {
>      unsigned int unspecified:1;
>      unsigned int secure:1;
>      unsigned int space:2;
>      unsigned int user:1;
>      unsigned int memory:1;
>      unsigned int requester_id:16;
>      unsigned int pid:8;
> } MemTxAttrs;
>
> to
>
> typedef struct MemTxAttrs {
>      uint8_t unspecified;
>      uint8_t secure;
>      uint8_t space;
>      uint8_t user;
>      uint8_t memory;
>      uint8_t pid;
>      uint16_t requester_id;
> } MemTxAttrs;
>
> is still decently packed and simplifies things a lot.

The old struct is 4 bytes, and the new one is 8 bytes. We do
a lot of directly passing 'struct MemTxAttrs' arguments around
as arguments to functions (i.e. not passing pointers to them),
so increasing it in size is not completely free.

thanks
-- PMM

