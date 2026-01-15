Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A20D46623
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUOY-0005KM-GY; Thu, 15 Jan 2026 15:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgUOX-0005Ia-4a
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgUOV-0004mx-BP
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768510596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z+iaOpLkgTMtOZoCGIglqvBjARykYhjvMx/w/BrS4o8=;
 b=BPIE1Sd+6ZsrEyfwMi7Iyp5eQNeAgtEFB6CT7GJ4je2UeozYwnq7TpfKqLdwp4gShRZKRg
 ca3EHfgKtpHFgzcFIBH725Kt2VbC6EaHWmbkknp0/RTYk63LjFCM49sIoz8fGaef6f56aE
 JdHLcQI4AWGqCdc3hfKYgCEJCQ0hc30=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-YfYg8asNMIC0DVKucF86UQ-1; Thu, 15 Jan 2026 15:56:35 -0500
X-MC-Unique: YfYg8asNMIC0DVKucF86UQ-1
X-Mimecast-MFC-AGG-ID: YfYg8asNMIC0DVKucF86UQ_1768510594
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430f57cd2caso966623f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768510594; x=1769115394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+iaOpLkgTMtOZoCGIglqvBjARykYhjvMx/w/BrS4o8=;
 b=X2ryEYpccw1LblC016CgKNc8A3byktbLJCrgHj24GjBqfPaKMKy332HoyUR3V6uzBT
 /5PxTMwBIIlMNH2/+VF7k6hQF+FlZnpHugE7eQjhoeRvTxq2RpPH7i/DWNoj0Ka6UahZ
 pHOjOCbFgczQJWC3YmP881P+9QNnWI783DqP567Q0onpeBi+sDmVVlEXc/nmPJzQeEY/
 nNqzXvNdRvUuUheU15d3Y6KTxjQVzhlqJpQOX8/VWmepmG0TKirZCrzneokFcGm8RQIS
 7iyjECadrG56Y8Z9Wh0KM1SKzOdOa3C5NvEi+DCjBQsmVEqJCWMduG4njhxSeJYMigKI
 BFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768510594; x=1769115394;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+iaOpLkgTMtOZoCGIglqvBjARykYhjvMx/w/BrS4o8=;
 b=AZubWSl2SWsb/IWIVfA1qR9MxIohq/QoCSHxPNyyITRGg0pbIKAaFj/dqFRuplTRp3
 eZPOhBhbkOjQQZGTIVEUnmXES61RYG/auZwx2Xw4tW3aX3gg8iy7YIF/cgVRNMIjoVni
 1roP+xeocC395Em/Nn+tlUbI2lm06rQROLtem/pIpOrhjRp+Ylq5YkS3gRhIBlO6SLP9
 y0PYUBz8fQttxv/dQ4qFyXW4m7n6kIMxDUfDd8/JYHs1Py0ZQSClZwBYVVOJ4Ywr9Q9p
 xsU6OnMo1yXfdEqq8QfghzpmiLGpqeLL7EnS9hGy84ueRZM5lIg+tyiDMXuatzx4yLSp
 tk+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhU0jiCr12zifhTK/iT7tQFu/Ypazj51M2yVn+Rh1kTaG8R+Lamnaq14vWHBX1YpXwmS1JjIj2LK+t@nongnu.org
X-Gm-Message-State: AOJu0YxSdojCc5v5BXrBq+dw0FJRf3sW53K8JqnAXdBGJaxp4jf4LJup
 uVwLcSqB9lD7kp/4UWsqE/HBf9d3lga9CXbI+jnsj7ma1QQ5vsrGtsxL6qUZ9B+2Wf3f5o8P2Fd
 y1x7O9lvO+mWm7KjKjeqzhj0QxBlN4XhHzw6nP/9ID/SjEegajfHgIYuK
X-Gm-Gg: AY/fxX52pCwUhbCKn6oTBVNTmZAq2piDZ+gqclF7YDCiMGiqtESxWArFZXm3t26Jsg/
 rro10+hAKK5T5VO+XJbh9C2OHjUfN8KcA2+mPQjynZ2lfl8m+ro7JB/aunIgz3oLeTFH5Hlr+tP
 yrX5OZ46v8hjUztz/eENQSMTqZkyZSBvwZQjZxoHyAORGKEf3NVjvD6Mfi9NeywqjLD32mWNQpS
 bkjOCI/oXlWIqtPQrI53DvHkXvK+FdxA/wxrJynKDwHyl7x0zDWyV+lja4mJm0B42w0BBOsOtzF
 i844vPngQ/yDpBfQiA1NuTuD9sGKIv7tgWpxo4SrjF2jrLvbvNhv9t6VuXUT5RMcTFIt4zlquKL
 Tw0vciGY=
X-Received: by 2002:a05:6000:2403:b0:42b:3c25:cd06 with SMTP id
 ffacd0b85a97d-4356a039bd5mr688526f8f.22.1768510594286; 
 Thu, 15 Jan 2026 12:56:34 -0800 (PST)
X-Received: by 2002:a05:6000:2403:b0:42b:3c25:cd06 with SMTP id
 ffacd0b85a97d-4356a039bd5mr688508f8f.22.1768510593865; 
 Thu, 15 Jan 2026 12:56:33 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm1079559f8f.40.2026.01.15.12.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 12:56:33 -0800 (PST)
Message-ID: <251f819b-8a47-43f5-b74c-6ba5fb307de8@redhat.com>
Date: Thu, 15 Jan 2026 21:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: propose OS platform/arch support tiers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260115180123.848640-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260115180123.848640-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/01/2026 19.01, Daniel P. Berrangé wrote:
> Informally we have approximately three groups of platforms
> 
>   * Tier 1: fully built and fully tested by CI. Must always be
>             kept working & regressions fixed immediately
> 
>   * Tier 2: fully built and partially tested by CI. Should
>             always be kept working & regressions fixed quickly
> 
>   * Tier 3: code exists but is not built or tested by CI.
>             Should not be intentionally broken but not
> 	   guaranteed to work at any time. Downstream must
> 	   manually test, report & fix bugs.
> 
> Anything else is "unclassified" and any historical code
> remnants may be removed.
> 
> It is somewhat tricky to define unambiguous rules for each tier,
> but this doc takes a stab at it. We don't need to cover every
> eventuality. If we get the core points of view across, then it
> at least sets the direction for maintainers/contributors/users.
> Other aspects can be inferred with greater accuracy than today.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
...
> +
> +Tier 2
> +~~~~~~
> +
> +These platforms are considered to be near Tier 1 level, but are
> +lacking sufficient automated CI testing cover to guarantee this.
> +
> + * Builds and all tests pass at all times in both git HEAD and releases
> +
> + * Builds for multiple build configuration are integrated in CI
> +
> + * Runs some test frameworks in CI

I don't think that we run any test frameworks for Linux on mips64el or 
riscv64 in the CI, do we? It's only cross-compilation of the code.

...
> +
> +Tier 3
> +~~~~~~
> +
> +These platforms have theoretical support in the code, but have
> +little, or no, automated build and test coverage. Downstream
> +consumers (users or distributors) who care about these platforms
> +are requested to perform manual testing, report bugs and provide
> +patches.
> +
> + * Builds and tests may be broken at any time in Git HEAD and
> +   releases
> +
> + * Builds are not integrated into CI
> +
> + * Tests are not integrated into CI
> +
> + * Merging code is not gated
> +
> +This covers:
> +
> + * NetBSD
> + * OpenBSD
> + * macOS (except aarch64)
> + * FreeBSD (except x86_64)
> + * Windows (except x86_64)
> + * Solaris

You missed Haiku.


> +
> +Unclassified
> +~~~~~~~~~~~~
> +
> +These platforms are not intended to be supported in the code
> +and outside the scope of any support tiers.
> +
> +  * Code supporting these platforms can removed at any time
> +  * Bugs reports related to these platforms will generally
> +    be ignored
> +
> +This covers:
> +
> + * All 32-bit architectures on any OS

Support for 32-bit OSes is currently being removed.

> + * Any OS not listed above

Is it possible at all to compile QEMU for any other OS? I though our 
configure script would block such attempts...?

  Thomas


