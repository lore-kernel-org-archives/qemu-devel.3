Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4539C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFXs6-0007Dx-2K; Thu, 15 May 2025 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFXry-0006wg-D1
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFXrs-00076o-5R
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747312757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gkygtFPvgUmfb0WJIqlgbjR/SHhkw6Po/wcCRO/H0Uk=;
 b=J9N52RM2GHZBKdolji1n7YWaEdef1BtsLZ+iXSx7OppQJcaY7r//M2j5y77XnGVaAXzwA0
 96k83HAOO5aBX0yndsDB7jEtI4PJ3Px7Bf8GOmcvuf2KP2eZhRFb8jlgBAWKQa4PpGgb5b
 fOSWRY1jIhTG8ArvUtLYwL4L68Yz+hc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-N5ht1OIINCKys-jYYXyZhA-1; Thu, 15 May 2025 08:39:16 -0400
X-MC-Unique: N5ht1OIINCKys-jYYXyZhA-1
X-Mimecast-MFC-AGG-ID: N5ht1OIINCKys-jYYXyZhA_1747312755
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a0b5c28f05so498949f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 05:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747312754; x=1747917554;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkygtFPvgUmfb0WJIqlgbjR/SHhkw6Po/wcCRO/H0Uk=;
 b=DKcgFAmpCnNZ7qXRK+sJkpON7//JIMSIfyQfV/Wk0HggzxChGzRGc824eWjLlKsZYh
 eZs7ZXryp9zyLpULfH1VdXmwXLvVy3LReUa6GvcDPOUya30do70S9Xf4miaKDtE83y6A
 qXcjdWykIVGYgIXVAenAxaEzDJy1OtAyN8dHZG0UqFf5R8aIqVF+sLaaJqGEwLhC9edr
 nm4YBuLscLvjZquXHB+ITqdVFdhx3rEw9iqCQlzO2RGCiYJ3hquGZkkuoUs9PajSorC7
 jRbQgg7updSvjqqasp5NbuL38R0dR/CnxS1mmDoqIpfcC+AdNUzaaCmnC2gI8ggMD2cF
 JZBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5+fbNmhvmpmdAytxR59Xo1YCecWtJnaoiZu7hxx79DXweZr4GSJAXe5+Q124jqApO/r8PiC8qQ7sH@nongnu.org
X-Gm-Message-State: AOJu0YxuhSnwxf67GJBWrXoIAn4yJcQJ2bBS3uVTg6eseysTGhbZo4uc
 szSAwJ9U2GUtInP0vfF2UTKwnCc29CHSW1K63Yirvebc8PR2lW859iLs3jKd9dDIHj6H2C9hBMq
 F0z+6awLYzz1R/UYiYAFRjVnsK5o/3UTpn24MbExXbRpBmkpbjKy2NSzwat2ygBo=
X-Gm-Gg: ASbGncvobOl59nvRa98VaMhAj2MgcsaZDhFJWb/9xWgNQh5r8udtulV/qbxd4pF6X5l
 EFKx4814qTkRN/EDBct34w64EMyXFtzKd39wehuLWN6+yrp3rZkPDvE/we+jDYLJfZdvJk+aZ3P
 6ZwGGl6PqmthrjZqlmDkBSrWl2yIwEO27mNgCpg03xzOYKkDVipUtI5IwSWQdcn08gaHDISi9N/
 n0vq8QR5epe36goRuHHo2T4W10KBOZX99cqdX/cPyjjNlhLlfHuVilhWMdpwCdWmcqcmo6qb5CA
 jQF0gVJHTOBo2N4E56N8LfmQu/us/eMUA1cW24qIt4rGbAeB6Q==
X-Received: by 2002:a05:6000:1a8c:b0:3a1:6e2b:85fa with SMTP id
 ffacd0b85a97d-3a3496d015dmr6413687f8f.31.1747312754642; 
 Thu, 15 May 2025 05:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI+OZ6rOWKCOHu04sq8KVrT1KNMe5XmMbtXWThI/TUssPXXq6YE1ECrHuQ0/f89i7zKbvdQA==
X-Received: by 2002:a05:6000:1a8c:b0:3a1:6e2b:85fa with SMTP id
 ffacd0b85a97d-3a3496d015dmr6413666f8f.31.1747312754253; 
 Thu, 15 May 2025 05:39:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de0ddsm22277002f8f.7.2025.05.15.05.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 05:39:13 -0700 (PDT)
Message-ID: <81355136-fddb-4134-bc75-5f8baddcefc3@redhat.com>
Date: Thu, 15 May 2025 14:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 45/46] tests/functional/aspeed: Add test case for AST2700 A1
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250309135130.545764-1-clg@redhat.com>
 <20250309135130.545764-46-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250309135130.545764-46-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Jamin,

On 3/9/25 14:51, Cédric Le Goater wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-29-jamin_lin@aspeedtech.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_aarch64_aspeed.py | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
> index 8df6a97a2852..c25c96627823 100755
> --- a/tests/functional/test_aarch64_aspeed.py
> +++ b/tests/functional/test_aarch64_aspeed.py
> @@ -31,6 +31,10 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
>               'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-a0-default-obmc.tar.gz',
>               'cfbbd1cce72f2a3b73b9080c41eecdadebb7077fba4f7806d72ac99f3e84b74a')
>   
> +    ASSET_SDK_V905_AST2700A1 = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz',
> +            'c1f4496aec06743c812a6e9a1a18d032f34d62f3ddb6956e924fef62aa2046a5')
> +
>       def start_ast2700_test(self, name):
>           num_cpu = 4
>           uboot_size = os.path.getsize(self.scratch_file(name,
> @@ -95,6 +99,12 @@ def test_aarch64_ast2700_evb_sdk_v09_05(self):
>           self.archive_extract(self.ASSET_SDK_V905_AST2700)
>           self.start_ast2700_test('ast2700-a0-default')
>   
> +    def test_aarch64_ast2700a1_evb_sdk_v09_05(self):
> +        self.set_machine('ast2700a1-evb')
> +
> +        self.archive_extract(self.ASSET_SDK_V905_AST2700A1)
> +        self.start_ast2700_test('ast2700-default')
> +
>   
>   if __name__ == '__main__':
>       QemuSystemTest.main()

On a BE host, if I run an ast2700a0-evb machine :

    $ qemu-system-aarch64 -machine ast2700a0-evb  ...
    ...
    U-Boot 2023.10-v00.05.06 (Mar 26 2025 - 05:59:26 +0000)

    SOC: AST2700-A0
    Model: AST2700 EVB
    DRAM:  8 GiB (effective 0 Bytes)

QEMU hangs.

If the RAM size is defined to 8g
    
    $ qemu-system-aarch64 -machine ast2700a0-evb -m 8g  ...
    ...
    U-Boot 2023.10-v00.05.06 (Mar 26 2025 - 05:59:26 +0000)

    SOC: AST2700-A0
    Model: AST2700 EVB
    DRAM:  8 GiB
    aspeed_dp dp@12c0a000: aspeed_dp_probe(): Failed to access dp. version(0)
    Core:  125 devices, 27 uclasses, devicetree: separate

machine boots.

Whereas, with an ast2700a1-evb machine :

    $ qemu-system-aarch64 -machine ast2700a1-evb  ...
    ...
    U-Boot 2023.10-v00.05.06 (Mar 26 2025 - 05:59:26 +0000)

    SOC: AST2700-A1
    Model: AST2700 EVB
    DRAM:  1 GiB
    aspeed_dp dp@12c0a000: aspeed_dp_probe(): Failed to access dp. version(0)
    Core:  125 devices, 27 uclasses, devicetree: separate

machine boots.
    
    $ qemu-system-aarch64 -machine ast2700a1-evb -m 8g  ...
    ...
    U-Boot 2023.10-v00.05.06 (Mar 26 2025 - 05:59:26 +0000)

    SOC: AST2700-A1
    Model: AST2700 EVB
    DRAM:  8 GiB
    aspeed_dp dp@12c0a000: aspeed_dp_probe(): Failed to access dp. version(0)
    Core:  125 devices, 27 uclasses, devicetree: separate

machine boots.


I Wonder if you could analyze this issue to check if it is related
to one of our QEMU model.


Thanks,

C.


