Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138ADC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmf2-0004yI-77; Wed, 21 Aug 2024 10:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgmex-0004g9-Q4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:50:04 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgmem-0007c1-47
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:50:03 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53345dcd377so2317369e87.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724251789; x=1724856589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IGpXJHJ1sePLAlc47lEx+QEQAkdryUXVZ3e/PCZWrk4=;
 b=Qb+Q1lDxiabDnFQ9k3fx2O3+xwhdXA6zYhm2vyv2STDqQPTId/6BbQUKxdYuWNt3Xl
 MHjTjajbJVgEawZ/HNBKVP8vZINgmEMn8RsbKIn4ts9HCBEEfRyjZLtKyeIUn5f/Y1he
 TeuQtJsEEciBW5wb650iuy5gXLmb0DtvInGn0pOnRGeN5sbvGwZ3Lgq5h7yi94IjWPxW
 1wi7OYvGs6N6MzrBrgnqbPeaZJq4fc7WoeQeBFhpnys81WsD4maLxb7C0XuNlyDbyRIr
 PpKca337IdjrLDmvXyaiwTvMdYPHrp4Q+jZX7fiN+F9rJwhr28N91S4mFjOrCLyQzr/d
 gZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251789; x=1724856589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGpXJHJ1sePLAlc47lEx+QEQAkdryUXVZ3e/PCZWrk4=;
 b=oDnROHSMMfmkpGB3PXbL74hQ7iwQszZRnsHNl5Qa8bwjK7E2WG+MI83NsdiaHIpABq
 eDzyLQ15DykXbWN/A5mKG/UtuCyJG/KBESfTQSPebVy+nzg+QCZ85Kkrd+f9VPK57/VW
 B3u91Vr6i2eEPT0M4kwYEOfXvO69Zmm0CSNMrcF07GFE9b7MzOvBJnpP4Kjv5EZjdsur
 YZdWpVhd2Clw18C7H4W4sT3SPX3bq08whqOJBQzu3O+cN+Vutx2k3IAuQ22QJhoRFp5o
 R4r9aVjZf3bZ8Srjy5ehlsRDwXM/4zu0Tg4vrJB5svEQ1Y//xhLduvtuNCtO8Q1S52BU
 kZow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/CNwtKrINsVPqDgarK1aVZgtP88PfSwXhl600lVNvZGaWK9ZJl55Ea0rRYIuVU1WyBkdcUAwxd1+8@nongnu.org
X-Gm-Message-State: AOJu0Ywcy4aFL2gg0AAvtjbgrL5cqlZOhTcAL6Ul2A3W/wyen1h8clMp
 093YJECC/tD/bRsRwWJbOEGCANSCyN0/6DgPJFD4lD+yvVWYVbCs45OjH26xLMg=
X-Google-Smtp-Source: AGHT+IHARokqeieopLWagnp+6t97mXKaga6GLj08UhAA5yykLjsQ7Qg2ge75UgMXJfU7Xq1f0mS7gQ==
X-Received: by 2002:a05:6512:131e:b0:52e:7656:a0f4 with SMTP id
 2adb3069b0e04-533485df9c6mr1262155e87.41.1724251788720; 
 Wed, 21 Aug 2024 07:49:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc081dc6sm8087517a12.91.2024.08.21.07.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 07:49:47 -0700 (PDT)
Message-ID: <ab83a55f-6413-4d8e-9fdc-edb5f568d6f4@linaro.org>
Date: Wed, 21 Aug 2024 16:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/35] tests/functional: add a module for handling
 asset download & caching
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-15-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-15-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The 'Asset' class is a simple module that declares a downloadable
> asset that can be cached locally. Downloads are stored in the user's
> home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [thuth: Drop sha1 support, use hash on file content for naming instead of URL,
>          add the possibility to specify the cache dir via environment variable]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  1 +
>   tests/functional/qemu_test/asset.py    | 97 ++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+)
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
>   from .config import BUILD_DIR
>   from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
>       interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> new file mode 100644
> index 0000000000..cbeb6278af
> --- /dev/null
> +++ b/tests/functional/qemu_test/asset.py
> @@ -0,0 +1,97 @@
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
> +    def __init__(self, url, hashsum):
> +        self.url = url
> +        self.hash = hashsum
> +        cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
> +        if cache_dir_env:
> +            self.cache_dir = Path(cache_dir_env, "download")
> +        else:
> +            self.cache_dir = Path(Path("~").expanduser(),
> +                                  ".cache", "qemu", "download")
> +        self.cache_file = Path(self.cache_dir, hashsum)
> +        self.log = logging.getLogger('qemu-test')
> +
> +    def __repr__(self):
> +        return "Asset: url=%s hash=%s cache=%s" % (
> +            self.url, self.hash, self.cache_file)
> +
> +    def _check(self, cache_file):
> +        if self.hash is None:
> +            return True
> +        if len(self.hash) == 64:
> +            sum_prog = 'sha256sum'
> +        elif len(self.hash) == 128:
> +            sum_prog = 'sha512sum'
> +        else:
> +            raise Exception("unknown hash type")
> +
> +        checksum = subprocess.check_output(
> +            [sum_prog, str(cache_file)]).split()[0]
> +        return self.hash == checksum.decode("utf-8")
> +
> +    def valid(self):
> +        return self.cache_file.exists() and self._check(self.cache_file)
> +
> +    def fetch(self):
> +        if not self.cache_dir.exists():
> +            self.cache_dir.mkdir(parents=True, exist_ok=True)

This doesn't work with QEMU_TEST_CACHE_DIR set to someone else:

   File 
"/home/philippe.mathieu-daude/qemu/tests/functional/qemu_test/asset.py", 
line 60, in fetch
     self.cache_dir.mkdir(parents=True, exist_ok=True)
   File "/usr/lib/python3.10/pathlib.py", line 1175, in mkdir
     self._accessor.mkdir(self, mode)
PermissionError: [Errno 13] Permission denied: 
'/home/alex.bennee/.cache/qemu/download'
ninja: build stopped: subcommand failed.

Maybe use a getter which falls back to Path("~").expanduser() when
no access on QEMU_TEST_CACHE_DIR? This happens when downloading a
new file (the recent MIPS tests I converted) which isn't in Alex's cache:

2024-08-21 15:45:48,896 - qemu-test - INFO - Attempting to cache 'Asset: 
url=https://s3-eu-west-1.amazonaws.com/downloads-mips/mips-downloads/YAMON/yamon-bin-02.22.zip 
hash=eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab 
cache=/home/alex.bennee/.cache/download/eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab'

> +        if self.valid():
> +            self.log.debug("Using cached asset %s for %s",
> +                           self.cache_file, self.url)
> +            return str(self.cache_file)
> +
> +        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> +        tmp_cache_file = self.cache_file.with_suffix(".download")
> +
> +        try:
> +            resp = urllib.request.urlopen(self.url)
> +        except Exception as e:
> +            self.log.error("Unable to download %s: %s", self.url, e)
> +            raise
> +
> +        try:
> +            with tmp_cache_file.open("wb+") as dst:
> +                copyfileobj(resp, dst)
> +        except:
> +            tmp_cache_file.unlink()
> +            raise
> +        try:
> +            # Set these just for informational purposes
> +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> +                        self.url.encode('utf8'))
> +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> +                        self.hash.encode('utf8'))
> +        except Exception as e:
> +            self.log.info("Unable to set xattr on %s: %s", tmp_cache_file, e)
> +            pass
> +
> +        if not self._check(tmp_cache_file):
> +            tmp_cache_file.unlink()
> +            raise Exception("Hash of %s does not match %s" %
> +                            (self.url, self.hash))
> +        tmp_cache_file.replace(self.cache_file)
> +
> +        self.log.info("Cached %s at %s" % (self.url, self.cache_file))
> +        return str(self.cache_file)


