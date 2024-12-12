Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026E9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjy8-00005E-Lq; Thu, 12 Dec 2024 09:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLjy5-0008TN-9l
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLjy2-0003FY-IS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734012901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fcWBhr9yKc+aFaxxoe24HCoPoGe69wzVD0gI2my8IKo=;
 b=BjniLLIJUN+Mm1gSv/nLlW2aSVRxbk2XD4q6JSid6YTy71NTbj0trUmDSSrXYAhxQm8qEX
 ESgEEn6kxz39KMDJYygKWFRO7vjZg3I2JboN0jZ2XsUHdvjnyKLIR7KQnmw/A/rHbTA9Gp
 6gCI8uC+reCsqFIWb+Ii7W5Ahq9Qjv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-vSOyTvZmM9KqDy7nD8VFUA-1; Thu, 12 Dec 2024 09:15:00 -0500
X-MC-Unique: vSOyTvZmM9KqDy7nD8VFUA-1
X-Mimecast-MFC-AGG-ID: vSOyTvZmM9KqDy7nD8VFUA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38634103b0dso368141f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012899; x=1734617699;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fcWBhr9yKc+aFaxxoe24HCoPoGe69wzVD0gI2my8IKo=;
 b=cvXOAD10WxHuBGWEkiORVMU28wPCc15+h6ZgMw5QyGpgDgJAZl9GYNsobkvJIYRE3m
 2ri/vQHu3YE96fRE3RQEZVSi8LPRTKjX4TJa7GPKNKU7Fg8K/2glNKu3LF2kl8YremxX
 vPG8Ia3VpBBvHDh6juVqBCSyp7EEvUKtq34a7JXhffHGLm1XO725qEy/6laNnUdyowsD
 x1JQPc6yRQS4b+cfoKfM/iytglE+b9s81QDjYm7CSjAEBVAZ3lgR2XcjPJ+BCqeid+mH
 xEX4S1ENgjEB4MyMC28OgkjYqjNImiZ3XE3Kvg7/VG9VyyswycgwuXtXA/nFceYz7vDH
 tCrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW19IdNh7k1EahL6T/YKsgg3Nc4j8dnpqcIm1idH+cTMQNpg/XgA3jbiqnfcbUd2w8tkZNzli2f9H2o@nongnu.org
X-Gm-Message-State: AOJu0YxOtwiaqCH1K4Xwz0Ta1B4GAJBFR3Ve/p9OnjC/ZkCFy9aJ7lel
 teLSUQqzXioRylYJ8WG1WTPUfgK5XDBLWAs9RGCZopXZuSzMlGAiu0eiYPvDh+kZ+OJIFy/wNTq
 dPRSJtJBdaueYNt68TPpuUd/rXE8or/1Ov+yPDMcOfcN+6nsye9Vb
X-Gm-Gg: ASbGncs++svSAO5XtaGC9XKethjF+axjYPEnbuz3ke8OiZomWSJQRaH6KPrDCHau9uL
 Fr2fxz4CcFQF0zZEymzksK+/8Ksg0vGSYMSfNv0AftGMO5N0Mgj3mYWwCi5F06CgtRyBdKsuWLr
 Lw2uADUxFGH4LJsJ1cITP8b7VYVhsiP0y8g7PZZJtWF9HhRXWvFDLtB+gDe2nkdPPL3f1DkxLR9
 u4dJj8TiJJnWZEpJ9u33m8SQRqyap2zPBadweisDvcVFEZW28vs4YfJzsyLgHOvfXrZ2RMg+opZ
 lO1R8g==
X-Received: by 2002:a05:6000:4606:b0:385:e394:37ea with SMTP id
 ffacd0b85a97d-387876913a6mr2662626f8f.22.1734012899035; 
 Thu, 12 Dec 2024 06:14:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9S4mUZ84fnq0EuW4VgPFNVVh334jw2vIn8nwhGDEW7tNTY1cysBUEey5l3pGPjHiBIMT+iQ==
X-Received: by 2002:a05:6000:4606:b0:385:e394:37ea with SMTP id
 ffacd0b85a97d-387876913a6mr2662405f8f.22.1734012894556; 
 Thu, 12 Dec 2024 06:14:54 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dc3sm4100675f8f.67.2024.12.12.06.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:14:54 -0800 (PST)
Message-ID: <0185be25-32f7-436b-b8e6-2e55c1cd0e18@redhat.com>
Date: Thu, 12 Dec 2024 15:14:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/31] tests/functional: skip tests if assets are not
 available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-31-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-31-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> If downloading of assets has been disabled, then skip running a
> test if the assets it has registered are not already downloaded.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py    |  8 +++++++-
>   tests/functional/qemu_test/testcase.py | 11 +++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index c5d3e73c4b..39832b2587 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -65,6 +65,12 @@ def _check(self, cache_file):
>       def valid(self):
>           return self.cache_file.exists() and self._check(self.cache_file)
>   
> +    def fetchable(self):
> +        return not os.environ.get("QEMU_TEST_NO_DOWNLOAD", False)
> +
> +    def available(self):
> +        return self.valid() or self.fetchable()
> +
>       def _wait_for_other_download(self, tmp_cache_file):
>           # Another thread already seems to download the asset, so wait until
>           # it is done, while also checking the size to see whether it is stuck
> @@ -103,7 +109,7 @@ def fetch(self):
>                              self.cache_file, self.url)
>               return str(self.cache_file)
>   
> -        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> +        if not self.fetchable():
>               raise Exception("Asset cache is invalid and downloads disabled")
>   
>           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 7bece8738a..6c67a9459c 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -184,6 +184,14 @@ def scratch_file(self, *args):
>       def log_file(self, *args):
>           return str(Path(self.outputdir, *args))
>   
> +    def assets_available(self):
> +        for name, asset in vars(self.__class__).items():
> +            if name.startswith("ASSET_") and type(asset) == Asset:
> +                if not asset.available():
> +                    self.log.debug(f"Asset {asset.url} not available")
> +                    return False
> +        return True
> +
>       def setUp(self, bin_prefix):
>           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>           self.arch = self.qemu_bin.split('-')[-1]
> @@ -209,6 +217,9 @@ def setUp(self, bin_prefix):
>           self.machinelog.setLevel(logging.DEBUG)
>           self.machinelog.addHandler(self._log_fh)
>   
> +        if not self.assets_available():
> +            self.skipTest('One or more assets is not available')

So if a test_*.py file consists of multiple subtests, this will now skip all 
of them if just the asset of one subtest is missing?

Could we maybe handle this test skipping in the new archive_extract() and 
uncompress() functions instead, so that only the related subtests will be 
skipped? (We still might need another wrapper function in testcase for the 
spots that still call .fetch() on the assets directly, though)

  Thomas


