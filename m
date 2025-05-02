Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A93C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAlIc-0005pr-9M; Fri, 02 May 2025 03:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAlIY-0005pY-HY
 for qemu-devel@nongnu.org; Fri, 02 May 2025 03:59:07 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAlIV-0007WD-3K
 for qemu-devel@nongnu.org; Fri, 02 May 2025 03:59:04 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso2497993a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746172739; x=1746777539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcH5rPZ7MEghDtv6JDp01Yt+QvYBS6pqn5wF6nPtJyg=;
 b=u7jYCRrwbo87rzkaVHuCZDCKR9puuOUADbzy/tLMI/xS+OBcvmXghe8dOIRBIGc2Fn
 cgGdvJZkzYQSmwfSY1HKT8943E0+GmCvT8VyUeJs6xufZOzmbO+c8aQpSv5+c9AWT1Ds
 SlxFyNzCLu7ALlvRF7K6CH4kBUh3/vWicYtmTljnwyjMJ1igUzEgx9HLjcm4oQuZQyoh
 REIjPFnBhzwRbVc+woUDU+C6K+TGdhty7ZbXbm7swhUXcAq1BoNwIXibjyrv4MH7Napq
 YW+AUDlwGsgpxuQVcmgMhUwr0qUqWhoC5SbkMAt/9vpnVgt3Qq8cfG2JxmM3/HIKGcs4
 16Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746172739; x=1746777539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcH5rPZ7MEghDtv6JDp01Yt+QvYBS6pqn5wF6nPtJyg=;
 b=pD69p2iyAkil3CYzj+i2YsbRbUuaMq8nGETC6TMWO8GjAZlwzHc9P43WiedxwJVMkt
 U89hs+qJnV8fVDNfNByp5Dheetk4FDhnYEZJYpuCu8HaW8OFYpoKihx0hU4gy4l6fKv1
 xqnYcUzmazgzrtXj3C/5Df16GZ9wpvg9JqwwYGFuMHCvXtNAmJh1AXGB02Qdcx/AOAvp
 CyCaQdF8J5lf1HQZPn4RXOUXswMBxLju2NVFhFZqwY/Y44PffEGZH5CP0H87E7VYnfJw
 oILLCIu0U39B8xrE92bzLKy21ccnpeAcNGO2qf9xIPMDkR+4o/rod7dPGWc5h7w2G9vj
 ZhDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3f499erRj1FTRs60OYS2pVYb7z2d9pmzWR6gwXOlGp7rt0FIQpPYnFgEgcLwrT4WkjTlxaofg7tep@nongnu.org
X-Gm-Message-State: AOJu0YwPoHpukKlmfAJ3nohrGy5HEqLaYExM0W6XWuNOky+/TbIZOHNV
 bNDwZR87mG1RfqDhcay17zVr1PqfKMEZaaZ+W8XwbLLrxT4XYLcN5pZ/xHV3fik=
X-Gm-Gg: ASbGnctDLKRrmGnpVudqOk/9KZughkgwQDcIKGyVhCGdOWTOXefxFJDSDVaZOprmatr
 49E5V+BtTdbtUohfjDxpTMvG+ZgbVcNv/vls6ZQQSx06/1ckOzJodHLI/3EhDS4V/ykYbGHb+dw
 0m0KMEuSE283f+7oqfGWljn+TD7RHC/BbYCP9Kw1pIMcSU0rcGl6CBih7wN+iuVs40xuiqf+vYz
 IN6d1yMnl7oq6zPoHlDlBBlY523Ee4Msq6Xe2PaSnYvFroAU4yUwxpGs8rvppDmCVIIO61eStn9
 SwHsL6D2JHvBwF4yD9xvoOUMnIk4dfOphbOBvoGlG3akbtL+hlJ5jWBj9GNQ1S5905vzu7SO5nZ
 jKAlv+7AYzGq1Tdi1ufM=
X-Google-Smtp-Source: AGHT+IEC20Tt2BNwepPL06ee8vhln1BQhT0IRMHlXydjiC6EDLZjMvDsMI87axhUSAlyqtD5vLUw8A==
X-Received: by 2002:a05:6402:234e:b0:5f6:21a4:61d5 with SMTP id
 4fb4d7f45d1cf-5fa78052cfbmr1396728a12.17.1746172739519; 
 Fri, 02 May 2025 00:58:59 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77816ffbsm818090a12.34.2025.05.02.00.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 00:58:58 -0700 (PDT)
Message-ID: <04218e51-d3be-430e-b1c5-41834cd4ab54@linaro.org>
Date: Fri, 2 May 2025 09:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/serial: Remove unused prog_if compat property
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250502001605.45A3B55D25A@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502001605.45A3B55D25A@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 2/5/25 02:16, BALATON Zoltan wrote:
> This property was added to preserve previous value when this was fixed
> in version 2.1 but the 2.0 machine using it was already removed
> leaving this property unused and unnecessary. This was also copy &
> pasted into diva-gsp where it was probably never used so get rid of
> this property at last.
> 
> Fixes: dbe442ad48 (hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine)

Back then we couldn't remove this property because it was used
by a HPPA machine. Indeed the last use was removed in commit
c061efca0b6 ("hw/hppa: Wire up Diva GSP card"). "Fixes: dbe442ad48"
is inappropriate, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/char/diva-gsp.c         |  6 ++----
>   hw/char/serial-pci-multi.c |  7 ++-----
>   hw/char/serial-pci.c       | 10 ++--------
>   3 files changed, 6 insertions(+), 17 deletions(-)


