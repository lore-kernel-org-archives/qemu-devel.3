Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B98AF94CD9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFRpE-000476-DV; Wed, 22 Apr 2026 03:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFRpA-00046X-Lc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 03:16:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFRp6-0006oA-Ih
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 03:16:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso51843105e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776842194; x=1777446994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e8ItIwgGxG2rVJHhnoj98FR/niIshbCas4mgi/qittE=;
 b=Xnf0Fk7ar8QXD8qRPoEZBMw7OqoPjyqtdZuqXoybj2A6WkrO1qa0ULqZNRreXTKtmm
 k6iWwCQ8mYXHAk/LG9oyiwfHFM13I00xe6+xRV9edU6cy81Rkhe7982ocTN0YkyJ39St
 O6FBfPF/0AuWkoTilgTskvbRPozKjhHoIj41etVmRE6JFogqPrtnvv17AiG0ZElZ4N6V
 6Lg7p6nFVLyfYu0K2lrEs1bsHhRc5w+JAbH1x863M4/gRZQPpy0XxjPlAg7SdW5BxGA3
 mYGCg1+U/9rKnl2UBdF2/POAoNFGXkbBwEOsR6tw3avCCXDJl8aJr9KesHyXzaSp6Z0i
 ub1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776842194; x=1777446994;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8ItIwgGxG2rVJHhnoj98FR/niIshbCas4mgi/qittE=;
 b=M/yQ/NwPIu3Sm9zzcc+zHTNYHsIrU19yLcnUldwX3GQOIANLbwWED70XUgqs3GEYcY
 n2g5PGKX6bky0ol+jcm3PE13/O/AQTtbszwGmoKmvKdZB9OqGoSfn+35epfV+sl6j5Pi
 hQbz3i2K9aYx1g09R/TWHQt+CUHWBM1aOV9VQOaSPZw69zoByZohJnin879DaxjarPHF
 tVHvkONHbRsj5nBvQgGnMzaK5yKlN49TZkKfPpD1tT/47a9LBU+o15eyMk3vjwu70KVf
 zzdNnE7Uc4PoSljXxVJL0o4Fs6tZclUSelYbZC8v4tuFOHO1hrOiilUHkIHP0FbZGF49
 CVNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bbcnrFF054e9ZT5CYI8/CSSNJw/kFd6aJ29ZR1tEtQnFBtk3RKX+b+mpyXrIpCMlx+MwzlNi6zLj6@nongnu.org
X-Gm-Message-State: AOJu0Yx8sJA5SblqUXX2VdD+tgaWZlhJhUemtzCWbFtGmyr8F5U72TQ1
 OtLYPVjWquIpJthFHdl/hYNkplHRmVYUPMTCaFDX3tzFBE+sX6JZOYxeSMh7XFMOngM=
X-Gm-Gg: AeBDietWjweiY+Fw3u9220ZdNeBetN2kNk0nNJx2nRb1dZLniwbBWJzoYsD7gKHGQV/
 TwbKpxLnaoIWaRuobVchrMD3vrTXWPWO5vLlmRylGnUN1OoAe1kvTWtHD2dfuqyiZsRDATWZJ6s
 Y9KO0lb3XL+RRgO/dGaSVeSHQ0SkODJk/uLu9ShdZQRddLGdPNqxLuVIbjGsN4/Z1ve+OPyMklH
 OkBllRtiw6dWJdhjB+/yNo9CJ/L10cmlD933a3zJEBNRBRIQVtLmc1gsu4SGFv6gkvg8Jg2sqzR
 kf7SiqN+iM0IPNYK4XB6Tb1LI4FjCsBnlh6EqiWe3JP9rytvHbsKuG1/jy/zj+h2xJTUqVNIzxN
 nC+DMgq4fbLCHCGNOScUqFNlTXOrLbs23XEQXgAMhfkfW3rl2TaVpLW9gFwkNtF9ondAU8H72dW
 +cgYMfIJ4mL+gP94PMFW6X6XSvP/VOipxe76afngzvNc+WKEN5NNz+938A8N0uTD7g1k8NTmFFx
 BH9
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-4891c1f38c8mr184034595e9.6.1776842194170; 
 Wed, 22 Apr 2026 00:16:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489393ddd69sm57362565e9.10.2026.04.22.00.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 00:16:32 -0700 (PDT)
Message-ID: <d369bcbc-48cf-49bc-b8bd-fcbb33bc74e9@linaro.org>
Date: Wed, 22 Apr 2026 09:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/qemu_test: Silence warnings from
 pylint in tesseract.py
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260422071145.244820-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260422071145.244820-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/4/26 09:11, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains:
> 
>   tesseract.py:1:0: C0114: Missing module docstring (missing-module-docstring)
>   tesseract.py:12:0: C0116: Missing function or method docstring (missing-function-docstring)
>   tesseract.py:15:11: W1510: 'subprocess.run' used without explicitly defining the value for 'check'. (subprocess-run-check)
>   tesseract.py:12:30: W0613: Unused argument 'tesseract_args' (unused-argument)
> 
> Thus add the missing bits and remove the unused tesseract_args argument.
> While we're at it, also add a SPDX identifier instead of the weird three
> dots at the beginning of the file, and drop the license boilerplate text.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drop the license boilerplate text as suggested by Philippe.
> 
>   tests/functional/qemu_test/tesseract.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

