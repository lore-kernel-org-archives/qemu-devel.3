Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB172E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 06:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLd8u-0002lf-P6; Thu, 12 Dec 2024 01:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLd8t-0002lV-A0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 01:57:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLd8r-0001Q5-8I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 01:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733986663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jYDH7uP0HNE9txQoXRyV81/hEt0LtUbjqqgFsMm9cUQ=;
 b=M3wQ9gZf0kz+Vnx5FxrVZdFVot1BwoFjzOn6u9Fn1zZe+XgYRYaxeyMjoGLETgBlzHpnc5
 czq/Xgy6Poh/2N54gSkkHti+TOlTujWvkX6CiFf0hlvLozmGXvZOT1Bh9EuTu381Fho0fg
 TS5ccysH84+yPZ3couE4zYoMFvIccwM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-vRtnbYQLPJuatqIItZWZvQ-1; Thu, 12 Dec 2024 01:57:41 -0500
X-MC-Unique: vRtnbYQLPJuatqIItZWZvQ-1
X-Mimecast-MFC-AGG-ID: vRtnbYQLPJuatqIItZWZvQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so2344955e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 22:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733986660; x=1734591460;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYDH7uP0HNE9txQoXRyV81/hEt0LtUbjqqgFsMm9cUQ=;
 b=blAHRN93K/K6VG+g9aHXvL7ymto6b9Q5KM1NwhYy1T0p5u3qo6B4ih17YBzS5Ssx+3
 nYOFdpOMO3tuygRLpY9s5Jvq8Px6J7phSSa0xKqsbAwV4SdcX5SBsdf5eZC9zt1OCwHH
 cUXZeAsLD1UnTdWGkPy7yS5wN8qeH0z6h/X0WDwPu0zqI9DPE7JlM2O52Hikl9mIVTGD
 SyI/Eb2SKrQVmGoPpmAWEXjU5GqmIZ2Iee6DhXZS4G5qRFEBEPoO14QF0el5aynVeM++
 UzN8hQj3+/BpYWptVwoTyd1CJ3ZDsdJP7qHblpCdaMD3OXuJE4WOVsvOgBzBRr7xnnyk
 hJqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9n3+o9Mc3ZkSnU0Ah7K/5BbGjAFqwfF2U5IZVAR5v28qMQAqqV7hOHf6+plYiuyhyaJ41O1d5L2F/@nongnu.org
X-Gm-Message-State: AOJu0Yx8UnxzgCI+pjuYoCOlNDWz8hPVVBqAMWrTM5/7EG34u8VcIfpL
 e9q9KWkPtnGIM0cAOPnTF9yChNSEdo/K7avAnb1V6b2w/0dDPGtlQFgPjZMTBYwPHCc7oc79q1h
 VsJyymue0tdOInZBk2aQBHoPucpZjUBwJtrlAvz5PwSdiUjPJ2h6P
X-Gm-Gg: ASbGnctCXhIbR5Yuk8RWyPXkXa5TzGbfWlvGLlkF9/rt4MMuEOfd5E27qfZsWa0WkL+
 JRFNQYcjbDuRIzg1LJ73d4oulGK5M1k9Cyx4e82o/wN7ucaIB+x1WaHbOZWXx09NwpqP5KOlBj0
 iAmxwfen+sLlM7QkzqaUjHH9AJdZbMNZRyU+6dZ7sp1pUtyGKvYFVXBesDGvFuelDzqh7ETSxYQ
 tOLVtccbJAoEPVqjeu17k5Ek/8m1z+e0Gsp27UkIjQePRuZAfMN0KPrPoEhr5HHMGnTojKPvBwX
 5aNBLgIlcQ==
X-Received: by 2002:a05:600c:1c16:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-4361c344b7emr45970665e9.2.1733986660563; 
 Wed, 11 Dec 2024 22:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6/vnUTrjtgRX+THp9zPeYAue1oZsPg0nbjli4v0kXcklJGunRGOK42CJQhas1EEMplLkthQ==
X-Received: by 2002:a05:600c:1c16:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-4361c344b7emr45970575e9.2.1733986660269; 
 Wed, 11 Dec 2024 22:57:40 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256b4556sm7035025e9.33.2024.12.11.22.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 22:57:39 -0800 (PST)
Message-ID: <1ad6e5e3-a54a-4361-b31f-3b08bad5180f@redhat.com>
Date: Thu, 12 Dec 2024 07:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/31] tests/functional: drop 'tesseract_available'
 helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-6-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241211172648.2893097-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> Platforms we target have new enough tesseract that it suffices to merely
> check if the binary exists.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/tesseract.py | 12 +-----------
>   tests/functional/test_m68k_nextcube.py  |  8 +++-----
>   2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
> index ef1833139d..1b7818090a 100644
> --- a/tests/functional/qemu_test/tesseract.py
> +++ b/tests/functional/qemu_test/tesseract.py
> @@ -7,17 +7,7 @@
>   
>   import logging
>   
> -from . import has_cmd, run_cmd
> -
> -def tesseract_available(expected_version):
> -    (has_tesseract, _) = has_cmd('tesseract')
> -    if not has_tesseract:
> -        return False
> -    (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
> -    if ret:
> -        return False
> -    version = stdout.split()[1]
> -    return int(version.split('.')[0]) >= expected_version
> +from . import run_cmd
>   
>   def tesseract_ocr(image_path, tesseract_args=''):
>       console_logger = logging.getLogger('console')
> diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
> index 0124622c40..1022e8f468 100755
> --- a/tests/functional/test_m68k_nextcube.py
> +++ b/tests/functional/test_m68k_nextcube.py
> @@ -13,7 +13,8 @@
>   from qemu_test import QemuSystemTest, Asset
>   from unittest import skipUnless
>   
> -from qemu_test.tesseract import tesseract_available, tesseract_ocr
> +from qemu_test import has_cmd
> +from qemu_test.tesseract import tesseract_ocr
>   
>   PIL_AVAILABLE = True
>   try:
> @@ -53,10 +54,7 @@ def test_bootrom_framebuffer_size(self):
>           self.assertEqual(width, 1120)
>           self.assertEqual(height, 832)
>   
> -    # Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
> -    # new version is faster and more accurate than version 3. The drawback is
> -    # that it is still alpha-level software.
> -    @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
> +    @skipUnless(*has_cmd('tesseract') 'tesseract OCR tool not available')

The *has_cmd('tesseract') already provides the error message, so you've got 
to drop the 'tesseract OCR tool not available' part now, otherwise this ends 
up in an SyntaxError. You likely didn't notice since it gets replaced later 
anyway, but for bisectability, it would be good to fix it.

Anyway, this is yet another good example why we should rather get rid of 
has_cmd() ... it's too error prone, I made the same or similar mistake in 
the past already, too.

  Thomas


