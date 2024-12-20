Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF96E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaKL-00061V-Qm; Fri, 20 Dec 2024 05:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaKK-00060t-Dj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:33:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaKI-0003LZ-Pm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:33:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso12465105e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734690825; x=1735295625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XIdnFfVjDJM6I9CvH8yjiMUXq3/UWH0lwWY8fl0HIeE=;
 b=q+iQs21d6AnbVEW8fIfrzz1aOq1L6RjwY1yUFYd5U7e1cn4qdbilUFCDMrkTF8GmNQ
 ZxQ881RrceWTGq/5F7CK713FAfrTT7OBRsdZKdaBa0S+NYhme+UnOAth+KI72AzRQCPD
 v626tBlG/iZXgjRqx6blsYiLUiTfLnid5awOx/usEUar1u7t0TQvdRhwxWFFyMhqVkdM
 afzzlmDpsy5aDFQhqDmpmPCQKbfIW7cj53uDR1Gm7sDIrDINoOx8XrtkZhYjwjhRVBkG
 rHPOVHFHhZYTeMC5P/tgZwX92jXvjTywO2pSNlCQvEQ7SEHmtquS21wn83S9G1mdW/Xo
 hewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734690825; x=1735295625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XIdnFfVjDJM6I9CvH8yjiMUXq3/UWH0lwWY8fl0HIeE=;
 b=UYbnkSRMHzyANCNbQlX23lSAdj6fdLIhIsLUvwWzp/dRsGFCrzbp7R2snxiCAwoJDj
 hHSxt8qOADBV7Zs0NHSDBiY0W1jE6mOTOl1u4bvLqWudo8uBq/UpqRt/8DheChXAzB/+
 z/uzSC2RgPqW5Hlf0a7a+FTsvoKOpaD9FilYGkgRa/2AluvHdC/wTihjePJtSDJlcN+x
 VdVJbijSqRWJCzulHfBcXAY3fWKpxlB+Q8GVVhl2yc6JFJiBpIYAMPMmnEHs1i18JQ7C
 DvL3MaCxG6AMcONaXNVd70LfRKxBA36J5+vV+GAe+fNlmO7PAy+ZHqBNTkbCu4JkGysR
 LY7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhppf+velyngcHkBUIBtWMy56oboYGag9CSXL+Gtl9mX44yv82snBeiPfXr2o5vIatj+EyNuTCmavT@nongnu.org
X-Gm-Message-State: AOJu0YwqrBQunDMM5QdX+XSFHoXWCGLqrYqjGJhwl3cNecnc9326zuxg
 2Zu/ECwnGi8a8X3VqZ1uVOszMoCZGBQTjvAvg+z7WHuQDBHjdSfliGs1g+0qrzc=
X-Gm-Gg: ASbGncsw8Y7VunALPhCWev6cW2h9A1lpI9lV+Ye+BIPGJBq+Qohkd1+vKaGpxwoKP2i
 YfArbrCHmgbg7tpjWX+EMKu31XeKd/Gn7hly6dkM5n22yftyaNthIFMZ/tdP8iLHjHyqzDd+UyI
 FYStSlMSgxS1wGky/hUY5EtNm8OsOAfXIFoZ2JxaLagi1HFaPWRGvlQwIDc21GyLg9aAhOO0Gp1
 mb14ralUA9jthfgO8uTgW082CgfoTV2wlsMsXVIEI2T/fLwhEX7ge7wVIyaxj95uNWN3g8=
X-Google-Smtp-Source: AGHT+IF7afoCApmcaMDkDHe/Fy866v4ka3BL53l3unYMNFmB+A6n431eFkr6AywoZu1397ewkVHi+Q==
X-Received: by 2002:a05:6000:71b:b0:386:3918:16a8 with SMTP id
 ffacd0b85a97d-38a221ea741mr2018520f8f.13.1734690825171; 
 Fri, 20 Dec 2024 02:33:45 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c493sm41597675e9.28.2024.12.20.02.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:33:44 -0800 (PST)
Message-ID: <731ccefb-b1c4-4052-b3dc-a2ef1355c846@linaro.org>
Date: Fri, 20 Dec 2024 11:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/functional: Don't fail the whole test if a
 pre-cache fetch fails
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org
References: <20241220024617.1968556-1-npiggin@gmail.com>
 <20241220024617.1968556-2-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241220024617.1968556-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+danpb

On 20/12/24 03:46, Nicholas Piggin wrote:
> If any pre-cache downloads fail, the entire functional test run
> is failed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/functional/qemu_test/asset.py | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index f126cd5863a..f82b07e7027 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -102,7 +102,8 @@ def fetch(self):
>               return str(self.cache_file)
>   
>           if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> -            raise Exception("Asset cache is invalid and downloads disabled")
> +            raise Exception("Failed to fetch asset %s, not found in cache "
> +                            "and downloads are disabled", self.url)
>   
>           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>           tmp_cache_file = self.cache_file.with_suffix(".download")
> @@ -162,7 +163,13 @@ def precache_test(test):
>           for name, asset in vars(test.__class__).items():
>               if name.startswith("ASSET_") and type(asset) == Asset:
>                   log.info("Attempting to cache '%s'" % asset)
> -                asset.fetch()
> +                try:
> +                    asset.fetch()
> +                except:
> +                    # Asset pre-cache should not be fatal. An error is printed
> +                    # and the test itself will fail if it is unable to get the
> +                    # assert.
> +                    pass
>           log.removeHandler(handler)
>   
>       def precache_suite(suite):


