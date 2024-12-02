Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7EAD10DCF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 08:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2Fk-0003Wi-LJ; Mon, 02 Dec 2024 03:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2FM-0003Sf-Ig
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2FK-0003CA-7p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733129852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tOfBKuDORpC+jGQy58MM9q+xpm6EIRWd5FAviJqx1Lc=;
 b=b4AdJXwC2Ri7JMyd+Nr+o7yEfHpX4G1qtN7OhBrEn8c/NKPoi30yxyZbab1codgnRn3Szn
 nonOPuN/Zwn6EH/cQ4plKN/X0MLpqqC2HNaNqWk7+iOD/q+DlkPvN9MY2STFmsdjCBoLwE
 Fmu/7iXOxftvU5Q3wyIiRgL/6NyEI0U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-eCheAaeDMJyaoAAf6XojOA-1; Mon, 02 Dec 2024 03:57:30 -0500
X-MC-Unique: eCheAaeDMJyaoAAf6XojOA-1
X-Mimecast-MFC-AGG-ID: eCheAaeDMJyaoAAf6XojOA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so702869f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 00:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733129849; x=1733734649;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOfBKuDORpC+jGQy58MM9q+xpm6EIRWd5FAviJqx1Lc=;
 b=cVQpeGn8k/ICC80zGPL40Mm9iDRZc2IhbXe1pjajdoEQFTIh3Wic/tuzjn1oN6/fBo
 BqFoO+p/3q81rCJ7TlNiNEFei+stoF8mNZjyuOrhNy+9paTfNI9KXr6NupKbswBsDSDy
 fut5I2ZDu10VHHUmUKmkcg8n3c1MyW59NN0JbQwiUJzQpMOq+2sow326Hdons0Sz/iCd
 yMNtPE5KCmlhD2dScBkW4fnqrRj5gjIi2b5rVGPbXAgcp5Z2xJEdI7TXX8ue1xqkjICY
 z3AkutQ2EJZmopsiqAk8cUT96GdO8cjO6U6rsmVhSuSf9A2uAtx7ckFP5QuFdhfe7RgU
 k5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7DX0jcSl0Q6sbTOdbwHPk6qHooj5kHeYjP1FlOXhdt4U794Ic0+Taz+aCGlp3VMLfugRVzUFxzH5h@nongnu.org
X-Gm-Message-State: AOJu0YxefAxIIaRT3G1C9rIvlWgU32a9RqdvKbbxprp82Jz0uSM5qp6s
 SPGd890rFlxmRm+7bnV3g+bobEIx1LmGfLS8KLrZoCUsvY2Mx2pi7W1BZGqa9L6Zy1t0OnqSj9a
 Ey9jTMmy9lsKtDqQkytyHbz5dHrMOsx9F4hdiQ9jStDLvfGdUAcFd
X-Gm-Gg: ASbGncu0MM5RIKEk4wcXElnXTX1Q7rWeWWoZvuebafLpwfLM/SaQFIBwu5WsSy/KBJ8
 PnTsumCIVWOUVH10+NFQHALK8ShlgC63BbHJn+nJ0t4hQ22wUrxodlKyTbmSuS6Q//lkPh1Dwgx
 7/vppdsDXHp1NIXxgZSOyNBnMTKOfEGttj4gT0IrURGKlmjThNUDf/w377SVDvubLYFcD5u7iWK
 p19V2VbjHXYMhxXcie99Bbm4FbEX2+S+adNB3Sv2XrxQqOXO0qNHBdQm3ztDE239Jgx3aEdn2I=
X-Received: by 2002:a05:6000:2a9:b0:382:5010:c8cd with SMTP id
 ffacd0b85a97d-385c6ed7749mr16332289f8f.44.1733129849037; 
 Mon, 02 Dec 2024 00:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE08gm1bLx4C6hn3AM36y3jMhdwDhYvUtX6cnaPoIDtBto6U7kQe59ivXBY6xG86/fbc2pgtw==
X-Received: by 2002:a05:6000:2a9:b0:382:5010:c8cd with SMTP id
 ffacd0b85a97d-385c6ed7749mr16332262f8f.44.1733129848663; 
 Mon, 02 Dec 2024 00:57:28 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a5d56da3sm131980225e9.0.2024.12.02.00.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 00:57:28 -0800 (PST)
Message-ID: <9b02f469-1fc0-40ad-ad7c-34bce61865dc@redhat.com>
Date: Mon, 2 Dec 2024 09:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] tests/functional: switch to new test skip decorators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-8-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> This ensures consistency of behaviour across all the tests, and requires
> that we provide gitlab bug links when marking a test to be skipped due
> to unreliability.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
> index 068740a813..db872ff05e 100755
> --- a/tests/functional/test_arm_aspeed.py
> +++ b/tests/functional/test_arm_aspeed.py
> @@ -13,7 +13,9 @@
>   
>   from qemu_test import (LinuxKernelTest, Asset,
>                          exec_command_and_wait_for_pattern,
> -                       interrupt_interactive_console_until_pattern, has_cmd)
> +                       interrupt_interactive_console_until_pattern,
> +                       skipIfMissingCommands,
> +)

In the other files, you placed the final ")" at the end of the previous line 
instead?

> diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
> index 0124622c40..82d3d335d0 100755
> --- a/tests/functional/test_m68k_nextcube.py
> +++ b/tests/functional/test_m68k_nextcube.py
> @@ -10,16 +10,9 @@
>   import os
>   import time
>   
> -from qemu_test import QemuSystemTest, Asset
> -from unittest import skipUnless
> -
> +from qemu_test import QemuSystemTest, Asset, skipIfMissingImports
>   from qemu_test.tesseract import tesseract_available, tesseract_ocr
> -
> -PIL_AVAILABLE = True
> -try:
> -    from PIL import Image
> -except ImportError:
> -    PIL_AVAILABLE = False
> +from unittest import skipUnless

I think you could also replace the other skipUnless() in this file nowadays: 
The version check here was only useful in the days when most distros still 
shipped Tesseract v3, but these days are gone, we don't support any of those 
distros anymore. So I think it should be fine to use skipIfMissingCommands 
here now instead.

Anyway, I'm also fine if we keep it for now (we still can adjust it later), 
so with at least the ")" nit fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>

>   class NextCubeMachine(QemuSystemTest):
> @@ -43,12 +36,13 @@ def check_bootrom_framebuffer(self, screenshot_path):
>           self.vm.cmd('human-monitor-command',
>                       command_line='screendump %s' % screenshot_path)
>   
> -    @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
> +    @skipIfMissingImports("PIL")
>       def test_bootrom_framebuffer_size(self):
>           self.set_machine('next-cube')
>           screenshot_path = os.path.join(self.workdir, "dump.ppm")
>           self.check_bootrom_framebuffer(screenshot_path)
>   
> +        from PIL import Image
>           width, height = Image.open(screenshot_path).size
>           self.assertEqual(width, 1120)
>           self.assertEqual(height, 832)
...


