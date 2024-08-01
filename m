Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E8FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYYD-0008Ik-Sq; Thu, 01 Aug 2024 12:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYY7-0008Cp-1Z
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:21:07 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYY4-0000rn-Fd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:21:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368526b1333so1430432f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722529262; x=1723134062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlt49guQypMiSGg3hxDUfC7FlhfTy7GveVwPenePirk=;
 b=y5e2uDSo3bmx6r7f/Ysf6tHea4iz/+tjDLU04eAhi/b53LJm5zFoE83q3Y0ZoorfW8
 eRGN7HKcOvqbsm50kJOAnGnhgmNDxqnPHEsb480I6UNxoNFIWxA3hHHpSGwEfNUI1t0O
 BcRJR8Z2RzSaRaagMRS91d5UdxhlczqSG2cFpz5Pkf/vGNVB8+7JOvRHSZDf+nauoZP8
 OupUfJT7Iy76tLOdHAsuonxv5lhfiUNBBPZXrEBZsSjbiw7rXo1wTTnQkZMdE7HSF9an
 ch/1CItjcFlhMdVtzcmuoMJLiWwA6Bv3ppHlWq5PQZp78IdFlVdQA9D9/e0iKlZq271U
 zvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722529262; x=1723134062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlt49guQypMiSGg3hxDUfC7FlhfTy7GveVwPenePirk=;
 b=QkLm3nmfJnTiZpsWlHBJmgdOLcGomdmzb5ssaKhpeBGgetO3FDlHvau0WXueH0zl7A
 MknjxhD9TOKsC/8gRTa964hMMaKtl5yTealp+RmoADHjMZyPbvLif3lqasxowRgosxYf
 kqrYhd0kQlW1oBIclh0y95QSGY+IKb71j+L8xoVoa4V6FRp1eLsv0rUxcJygZ7XzlTMk
 8dg0bkkkZm4us+gKaIsDNBhZeWzaM7pSjhLVWIfV0pBsNcuEhkZ5GQQqneU9N2O/aDC4
 8yyUsx3+D46wPz/hHzyQvlf6rKNbJ0fhKi67/NGQrG211dsQbTsSk2+FwjZ/wHWFcaBO
 7c3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2wigUF2I5RyLkgCJqvEk+EiY3vsaJkVzr8nTudx/A+gWonrRB1cZu+8INpY0LD2+J+UpHspxEl62D@nongnu.org
X-Gm-Message-State: AOJu0YyS7G5ueilZeaDrSvYjpMlrr5hujt0t4JV43I2gCpxlMZYx9QZP
 YmZDdvohOIubVCPNjD9U85ojElpQ8CH3MMOzNsu6CodF+aAYHDitoPPzZQ9AqT0=
X-Google-Smtp-Source: AGHT+IFvLiAVJFh3JkQgPLUKAjQSfAPRF6fdzXkLpXdf3vD9WEfJwZwmlWbLpQs4WybCWQqAzO2VCA==
X-Received: by 2002:a05:6000:b50:b0:367:938f:550 with SMTP id
 ffacd0b85a97d-36bb35de344mr1952963f8f.25.1722529262161; 
 Thu, 01 Aug 2024 09:21:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282baba4f1sm62769695e9.23.2024.08.01.09.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:21:01 -0700 (PDT)
Message-ID: <b9a55935-ccf6-4f13-9437-52608afc0db3@linaro.org>
Date: Thu, 1 Aug 2024 18:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] tests/functional: add a module for handling
 asset download & caching
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-9-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> The 'Asset' class is a simple module that declares a downloadable
> asset that can be cached locally. Downloads are stored in the user's
> home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  1 +
>   tests/functional/qemu_test/asset.py    | 96 ++++++++++++++++++++++++++
>   2 files changed, 97 insertions(+)
>   create mode 100644 tests/functional/qemu_test/asset.py
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 2f1e0bc70d..db05c8f412 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -6,6 +6,7 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   
> +from .asset import Asset

For next patch?

>   from .config import BUILD_DIR
>   from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
>       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> new file mode 100644
> index 0000000000..6432da2e0b
> --- /dev/null
> +++ b/tests/functional/qemu_test/asset.py
> @@ -0,0 +1,96 @@
> +# Test utilities for fetching & caching assets
> +#
> +# Copyright 2024 Red Hat, Inc.
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import hashlib
> +import logging
> +import os
> +import subprocess
> +import urllib.request
> +from pathlib import Path
> +from shutil import copyfileobj
> +
> +
> +# Instances of this class must be declared as class level variables
> +# starting with a name "ASSET_". This enables the pre-caching logic
> +# to easily find all referenced assets and download them prior to
> +# execution of the tests.
> +class Asset:
> +
> +    def __init__(self, url, hash):
> +        self.url = url
> +        self.hash = hash
> +        self.cache_dir = Path(Path("~").expanduser(),
> +                              ".cache", "qemu", "download")
> +        self.cache_file = Path(self.cache_dir,
> +                               hashlib.sha256(url.encode("utf-8")).hexdigest())
> +        self.log = logging.getLogger('qemu-test')
> +
> +    def __repr__(self):
> +        return "Asset: url=%s hash=%s cache=%s" % (
> +            self.url, self.hash, self.cache_file)
> +
> +    def _check(self, cache_file):
> +        if self.hash is None:
> +            return True
> +        if len(self.hash) == 40:
> +            sum_prog = 'sha1sum'
> +        elif len(self.hash) == 64:
> +            sum_prog = 'sha256sum'

Do we want to support these? Should we declare them deprecated
and emit a warning?

> +        elif len(self.hash) == 128:
> +            sum_prog = 'sha512sum'
> +        else:
> +            raise Exception("unknown hash type")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Very nice :)

