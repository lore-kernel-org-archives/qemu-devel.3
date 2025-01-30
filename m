Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED472C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 07:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdPO9-0002pv-Rm; Thu, 30 Jan 2025 02:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdPO8-0002pY-OC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 02:55:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdPO7-0001IL-0v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 02:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738223698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=83N77j35HMqhRcwCiguYX8Rv2G5zcDTT4f6mFCOCI9I=;
 b=WakWNGftetboXBHa/NrCn+ITghCQw2gSM5RPdXApzigUDFEYAknQTkfV/e7Ma6BnLfdSJ5
 2mABCBXI9rml7himh3KL7tJXxML6q2lIS937Kms1CaXt+z0B95MeF28Mag7QmjfYK11GKR
 57bLh5q18oxXbUgHdIbiufTxbyAW0u8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-WrnkOLEbMC2hbWoPSubCcA-1; Thu, 30 Jan 2025 02:54:55 -0500
X-MC-Unique: WrnkOLEbMC2hbWoPSubCcA-1
X-Mimecast-MFC-AGG-ID: WrnkOLEbMC2hbWoPSubCcA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436248d1240so1974325e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 23:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738223694; x=1738828494;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=83N77j35HMqhRcwCiguYX8Rv2G5zcDTT4f6mFCOCI9I=;
 b=XhWLg/swOdD/1ZNCId3Ntq+YqEST0B3hl/hIalCHgTFNTdn3JJx/5Orfp1m6F0I47Z
 ec50XbyKHwBNfqqnYL2c9XEXR6sd/HOnlX1t1/8wIj96IkLHitQfPI7hzXT95C9YBzyi
 YnOZNnlcdU8QCFC9XT1DIdlmtpDilAN9FVeRoU2OHeBbuTeh73wxiOC7oFLFYtTxb3o8
 d0iwdR4J6SWPlTnCB+BLTA6yyJ2JScwgSebgV03Lrf1LQXX+YMIZHzVkKPBboujGIyZX
 MkCM2sSrzSPcQssRSGkR+J77YNteK06RgsvW0061f3IxV/OsFvYEk7IRibg+FD+cfYc0
 GoDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd0Vr+UNUzIcOCwe7n+CdfQzDGxYWiK0doON7D+oLqE6tM85SpWQk7Tdn3bV02dXgCRdp1jCKFbdKc@nongnu.org
X-Gm-Message-State: AOJu0Yz5tBHANHClpA23ivbMDMdY/jogr67F44MI6BFQ5PkSuAp9w0PM
 iPRyCkCI+AOeggWaRYazZ/DlcnsyYFUP7aM96SeaTiBZxe7eCD56aG/3GKmIxa5zwhPk1b2rfkb
 sCHDyiI3K9fTM0QH+3JDZotyA4Wy/UYfAzMeIMAhSp4+nXxvmzVce
X-Gm-Gg: ASbGnct/qEuPxqwjAv/z9MhDKO3RE0i91CT1PhwAA9EQGPi18jkVTRSlJ2U2binwpFN
 YmLJskvLhwjNFI1HjtCjjr97dh0CwrB77WhbMZH0hGova0hSbl+mNIKbq+DqGpEgbCvGoJgz37r
 zeBHEjCUKrp5OKy41wAigZOxuELozuSQfBtymuTNUe15cnv9RWxNzYyKvkE2DpO5dMduQYfBEFx
 IiuoNi54B3JUUgDpPoqFEVoqZd+gOCkL5fuXCjdK5JzILLZrSrFg8jCG9mDJayoNGKIhAoySdFq
 Zujfta6LAHIgor5bR+0JHQncF7C5OP1dOTJt
X-Received: by 2002:a05:600c:458a:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-438dc3c333cmr57323775e9.10.1738223694106; 
 Wed, 29 Jan 2025 23:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE31kENdvEioaxgSyeoZTeqLbWRCPnEGlZ/cfOhBSAzrA+Towv02jCtxa1oaquyh1NKleeagQ==
X-Received: by 2002:a05:600c:458a:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-438dc3c333cmr57323555e9.10.1738223693786; 
 Wed, 29 Jan 2025 23:54:53 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e384sm50609745e9.19.2025.01.29.23.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 23:54:53 -0800 (PST)
Message-ID: <bf801db0-ffab-48de-b8fe-1577c3bd17eb@redhat.com>
Date: Thu, 30 Jan 2025 08:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: Introduce a bletchley machine test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250129071820.1258133-1-clg@redhat.com>
 <20250129071820.1258133-6-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250129071820.1258133-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 29/01/2025 08.18, Cédric Le Goater wrote:
> Use do_test_arm_aspeed_openbmc() to run the latest OpenBMC firmware
> build of the bletchley BMC.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/meson.build                  |  2 ++
>   tests/functional/test_arm_aspeed_bletchley.py | 24 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
>   create mode 100755 tests/functional/test_arm_aspeed_bletchley.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 5c782ceb0a98..a8eb9c9a7af5 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -25,6 +25,7 @@ test_timeouts = {
>     'arm_aspeed_witherspoon' : 120,
>     'arm_aspeed_ast2500' : 480,
>     'arm_aspeed_ast2600' : 720,
> +  'arm_aspeed_bletchley' : 120,
>     'arm_aspeed_rainier' : 240,
>     'arm_bpim2u' : 500,
>     'arm_collie' : 180,
> @@ -86,6 +87,7 @@ tests_arm_system_thorough = [
>     'arm_aspeed_witherspoon',
>     'arm_aspeed_ast2500',
>     'arm_aspeed_ast2600',
> +  'arm_aspeed_bletchley',
>     'arm_aspeed_rainier',
>     'arm_bpim2u',
>     'arm_canona1100',
> diff --git a/tests/functional/test_arm_aspeed_bletchley.py b/tests/functional/test_arm_aspeed_bletchley.py
> new file mode 100755
> index 000000000000..10e6703b53cb
> --- /dev/null
> +++ b/tests/functional/test_arm_aspeed_bletchley.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +class BletchleyMachine(AspeedTest):
> +
> +    ASSET_BLETCHLEY_FLASH = Asset(
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/bletchley-bmc/openbmc-20250128071329/obmc-phosphor-image-bletchley-20250128071329.static.mtd.xz',
> +        'db21d04d47d7bb2a276f59d308614b4dfb70b9c7c81facbbca40a3977a2d8844');
> +
> +    def test_arm_ast2600_bletchley_openbmc(self):
> +        image_path = self.uncompress(self.ASSET_BLETCHLEY_FLASH)
> +
> +        self.do_test_arm_aspeed_openbmc('bletchley-bmc', image=image_path,
> +                                        uboot='2019.04', cpu_id='0xf00',
> +                                        soc='AST2600 rev A3');
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()

Reviewed-by: Thomas Huth <thuth@redhat.com>


