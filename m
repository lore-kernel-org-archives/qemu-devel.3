Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462EAE6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smn7n-0006ql-Mz; Sat, 07 Sep 2024 00:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smn7j-0006qC-6t
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:32:35 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smn7h-0003RX-GU
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:32:34 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so545305e87.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725683551; x=1726288351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIuSzv0OGHzrN+96EehocPc8uBtRjMgwgdKoTzGuq/4=;
 b=z1fHr1dXVwkoE1RVNH44q2a+E0s7wkJ83hqPqcnamDVfP/CmngIQbdN+xs2InKB+3B
 ngIHTj25Bv+oyHTlFoKQyNYVtNVDYcIOmN0PGO/AGElqw2QLygiJ64/TPJiW/8kDgNRc
 YnuJNUqacRN6YxffBEFFYjuHltQ9XWIgy/4dcmlCQP+wwp3N0japKBEv6TsfB3A/cuW9
 DpzDjPBkSsI25frt4bC+kmD6b4lsDNA7/21cUQe/N9OlJ08qLZwbiLG58+3Nv6mfdGmR
 ajDl0BtFm6o721YVR/g5Ka1X1GE6Y1dpmeEc1Qs5AELBmKrWykE2e0atAeblpf9SeQEh
 hf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725683551; x=1726288351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DIuSzv0OGHzrN+96EehocPc8uBtRjMgwgdKoTzGuq/4=;
 b=k3EqwxfmECzJC0yXWd3xpLKFyGyCNm7hVVRmzrZy8bK/Sf+s2UqHbFZpadziBJBVqG
 EqIVc9Q9IWtMP4d2ip3EtNzeLVb9/LmwNUXc7XBqk8DacsX5N5+IA6MG2jw0X6t3mMh2
 v047fBYBOmijtPSETYAQWoZb5L5WQbGXoUaNnQdkomvjXmzThJj1AEeOhl9Jkc6D42Rk
 KhEmrSxT+1Qe4TGcCPgGQnNdrGtJhiaEhKclVhcWMBXENg3Mr3M9YE2pmKATvIsPPJyu
 D8IyOA7JoM/KjPYB+MRa8MmdmB43NW/08OtN1bSVrl9yVb869RDfejIEirUg6hAQhj07
 qN5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTqmXtLEQBcy+b8beXGavXjnHty8kHEqtATfvLrC4OIekiawQFwOMVJyEA0/SGp4b0H6K80FhtERW1@nongnu.org
X-Gm-Message-State: AOJu0Yz1VGMkmAAuECawjr6pYBIs4ZzbI2hp8NCywTXtemf2XK0lXLJ3
 euK9k9yn1Pu0p5rXWp86pC/9pZ+2oxsX9q7+c6TRxI4bcdYe7uBY9yEiuwc30gk=
X-Google-Smtp-Source: AGHT+IFt+BB6opDDyIOwYrDPY+PNusqrrWLtiOp6x+zTXieurcHQZOrUA6eKTXVKPoS8OK2kV4hLEA==
X-Received: by 2002:a05:6512:239a:b0:535:698e:6e2e with SMTP id
 2adb3069b0e04-536587ada57mr2303339e87.18.1725683550645; 
 Fri, 06 Sep 2024 21:32:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5dc97sm25269666b.212.2024.09.06.21.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:32:29 -0700 (PDT)
Message-ID: <e0ac63e5-a5d4-4e5b-b67e-2652c804b5b7@linaro.org>
Date: Sat, 7 Sep 2024 06:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] tests/functional: Convert the m68k MCF5208EVB
 Avocado test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
 <20240906180549.792832-14-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906180549.792832-14-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 20:05, Thomas Huth wrote:
> We've got to do_test_advcal_2018() here now that the test resides
> in a separate file. Also switch back to the original URL (since
> the site did not vanish as originally expected) and update the
> hashsum to use SHA256.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py      |  8 -------
>   tests/functional/meson.build             |  1 +
>   tests/functional/test_m68k_mcf5208evb.py | 29 ++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 8 deletions(-)
>   create mode 100755 tests/functional/test_m68k_mcf5208evb.py

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


