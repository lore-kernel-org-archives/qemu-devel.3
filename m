Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03592CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 08:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl2eG-0005sV-Dh; Mon, 02 Sep 2024 04:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl2eC-0005rm-Fa
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:42:53 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl2eA-0004QV-IN
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:42:52 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53343bf5eddso5219547e87.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725266567; x=1725871367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c6eNCAtOybOk7/uOSt24T78OhjXzS37vhcPaUX6FZRk=;
 b=ZUaFdppHu2kmaDAC9KJ57Z5hje5Zb6VuEpY9BWslknBB4IBr4TMB6VTuYdky2D06CR
 SaQX6vQP4cQwTBB/9pmrv/Pjxp4Bpuh/oWRQRy2dBL8ArxpP+rgpgYr+wcPEjVme08wD
 cuA5EDmKKfrRysMGKFIdQKmoqo/x7xUgmxBN70h7FFAuxKyYrrg3JqtN2/cKvHWJ1bDU
 cIJswD64L0Et2h38O6pJfYVIKwYineZLx05HMDZbkO2jlrf2qOW3KYMRizxjai03emLJ
 P8gkimdMx9haj5IKecQ02rYxoEvp1G3gm3op0UcGyB49Sbd2v/i+nULH9K6E52qTRf+O
 uCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725266567; x=1725871367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6eNCAtOybOk7/uOSt24T78OhjXzS37vhcPaUX6FZRk=;
 b=mw4DibWIIKAIFPoTy56u/SM3g9gVubTxG+Z26ly25DABN4RBkC5DTXqKPqJEkMz3AX
 DrGRkyIfvG30tWA/0Zirb3qFz42mqh3HF6G2YUbAZ5PBazxlzyKCv+/NSopUYZUrFSTD
 9lHrLVU3JzAtJ0fSZhcOckb1EsNow3yUWuJJ6sHY/bMUF4EUCZGlyg+W1AKUe5PLk5Je
 NStRMqH805MeVZ5+pQFJTGFrSHq2ZFTUdpBEC0DRNsDSQT7C9mH4VfAPsHUSV42RMkeN
 9gMIgEtsm0MLUEXQgltkvecQrJ7xXDB2IukTBgBKBPzJaZY9RdXtlrt/tSkyZkobSZS+
 D59A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp15IkFCBcVEJTmfCD8i7iiOdF1OhgwQh/lNrt4AdDwmljq1bOd1pqTaeFGQZxb1JFXNP0cAQ2nLfL@nongnu.org
X-Gm-Message-State: AOJu0Yw0Y78ldpIPidHOUddiSeoweAj5KJY2cUP6yVfbUvPsm71OuolE
 4W7nhGDtajbMRBMh4sIja2wnGHlRcJEN5d3GOmD0KV1dJZ2pZBGmjNWR+bCeG/A=
X-Google-Smtp-Source: AGHT+IFHqaWo+YYy8Bu9HANJCBENCnuVWR0DXzmNbo97a6t9JeJPBwipYRTAI6o0TwdzaQc/ih0KyA==
X-Received: by 2002:a05:6512:224c:b0:533:45a1:88fc with SMTP id
 2adb3069b0e04-53546b4a00cmr6101121e87.30.1725266567046; 
 Mon, 02 Sep 2024 01:42:47 -0700 (PDT)
Received: from [192.168.45.175] (255.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.255]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba641db07sm162915345e9.34.2024.09.02.01.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 01:42:46 -0700 (PDT)
Message-ID: <4eb3e8f0-9e7a-446a-87a0-8477731b01d0@linaro.org>
Date: Mon, 2 Sep 2024 10:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/44] tests/functional: add a module for handling
 asset download & caching
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-15-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830133841.142644-15-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 30/8/24 15:38, Thomas Huth wrote:
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
> index 0000000000..c0e675d847
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

Maybe we should use hashsum[:2] as intermediate bucket directory.
(Suggestion now to not have to move the files again later)

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
> +
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
> +            self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
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


