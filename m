Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932CDD62077
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDS5z-0003Vi-C2; Tue, 19 Nov 2024 12:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tDS5x-0003Va-A0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tDS5v-0005wy-KM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732037573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dAz5pYhqecfFhqm2Mf07qg1B9QQayF4dqYRUzb4K7f0=;
 b=Zta2fXRiZfXTbF79B3ASnriY0sX6QXK88PvwMN534OUqJHF2sCRxpYPFlqy5hUYNTJ2ewP
 thYJsm3n04GjuQfOM8a7Sqb1/elopXmsaymPGwZUoDihNUj7K7aFXY6540AN6aXCrvsrsc
 2PKYXM4coK0l4/Qo38Gh+FLAY0t+gUY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-b--FlOd1Pnmn_AZp7XSn5Q-1; Tue, 19 Nov 2024 12:32:52 -0500
X-MC-Unique: b--FlOd1Pnmn_AZp7XSn5Q-1
X-Mimecast-MFC-AGG-ID: b--FlOd1Pnmn_AZp7XSn5Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so33770955e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732037571; x=1732642371;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAz5pYhqecfFhqm2Mf07qg1B9QQayF4dqYRUzb4K7f0=;
 b=YI5zJBA3qCtAsPleyrTIj3o+cADwFK9Xgw6yKFbL8fj1kzqTa+4W7Jmhswi8ZiNtfS
 mE3bO4bY18xyWgCZk5HnlAuZnK8uWOxWadLgGQqnDAIsex7myw/wYdQfMY49BW7mbOwm
 jbvXFqz5dNZ9KNry+jyvUc+VoKpr1VnONLHAs7hb9Ot2SwnE605mzOQWxOulB69mFmlf
 gJR4wzBpE4Xs2wS+LfKgeWNNwEI9tJIk8NOW3lCChxPSkEDUo1vOTsdw5uMIBap2+kXM
 ZUSU0zBh8UiF0JY1VRGOLoyT8Xgmx+DxX00SMwKmuzdsrygsbYk8ZBwVYJ6iv7yvpIkP
 yS2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/KZFKqiribBHoXJ/moFluUNHjdTFjHI8Uh8GWzKGBdMdqKvz6NTLgypd6jYTvicR0arjJ1WyqXEUX@nongnu.org
X-Gm-Message-State: AOJu0Yx2f363qHiNsObbd8dUPYZNTWm+85SBrVXQHRiC+lCnMZKJlo7S
 SoJbN8EVUq3EsPTLVhmqy4LGSW/riB84QJfBcoqPeXP8c5fix97xnWf0cSNrIrKYfXmNnhdqLH9
 yE4VvuKn8ArgHLC1BjhbVub+3i9Iwg5zG5RpVTdxWiyTPuhWjZHvh
X-Received: by 2002:a05:600c:3594:b0:431:5f1c:8359 with SMTP id
 5b1f17b1804b1-432df743ed2mr160512365e9.15.1732037571058; 
 Tue, 19 Nov 2024 09:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbuLCI1XqBjgl+83csJHOTtyYat4XUAfj0zfyUgmVLFIY9fBeduNL81+ny7MKD3LgqPWtvXg==
X-Received: by 2002:a05:600c:3594:b0:431:5f1c:8359 with SMTP id
 5b1f17b1804b1-432df743ed2mr160512165e9.15.1732037570751; 
 Tue, 19 Nov 2024 09:32:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-244.web.vodafone.de.
 [109.42.49.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824aad691csm4702838f8f.1.2024.11.19.09.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 09:32:50 -0800 (PST)
Message-ID: <77060968-f07a-484d-9ad6-7a0e09eddd68@redhat.com>
Date: Tue, 19 Nov 2024 18:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] tests/functional: remove comments talking about
 avocado
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-8-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241119150519.1123365-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 19/11/2024 16.05, Daniel P. Berrangé wrote:
> The first comment is still relevant but should talk about our own test
> harness instead. The second comment adds no value over reading the code
> and can be removed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_acpi_bits.py | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
> index ee40647d5b..6a7758c576 100755
> --- a/tests/functional/test_acpi_bits.py
> +++ b/tests/functional/test_acpi_bits.py
> @@ -196,11 +196,11 @@ def copy_test_scripts(self):
>           for filename in os.listdir(bits_test_dir):
>               if os.path.isfile(os.path.join(bits_test_dir, filename)) and \
>                  filename.endswith('.py2'):
> -                # all test scripts are named with extension .py2 so that
> -                # avocado does not try to load them. These scripts are
> -                # written for python 2.7 not python 3 and hence if avocado
> -                # loaded them, it would complain about python 3 specific
> -                # syntaxes.
> +                # all test scripts are named with extension .py2 so that our
> +                # test harness does not try to load them. These scripts are

Since our test framework does not try to scan for *.py files automatically 
(but the files have to be added via meson.build instead), I'd maybe rather say:

"all test scripts are named with extension .py2 so that they are not run by 
accident"

or something similar?

> +                # written for python 2.7 not python 3 and hence if our test
> +                # harness loaded them, it would complain about python 3
> +                # specific syntaxes.
>                   newfilename = os.path.splitext(filename)[0] + '.py'
>                   shutil.copy2(os.path.join(bits_test_dir, filename),
>                                os.path.join(target_test_dir, newfilename))
> @@ -399,8 +399,6 @@ def test_acpi_smbios_bits(self):
>   
>           # biosbits has been configured to run all the specified test suites
>           # in batch mode and then automatically initiate a vm shutdown.
> -        # Set timeout to BITS_TIMEOUT for SHUTDOWN event from bits VM at par
> -        # with the avocado test timeout.
>           self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
>           self._vm.wait(timeout=None)
>           self.logger.debug("Checking console output ...")


