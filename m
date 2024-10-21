Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA31ED3C937
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mdt-0008Qh-KR; Mon, 21 Oct 2024 03:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2mdr-0008QF-Cd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2mdp-0004oK-N3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729494948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TVxGon3KWm9x2irZSZT3tz5+/0o7syg+4pQNIESNu2E=;
 b=DSbjeDTE8ir/fWmNGVUvS+PLkrJaupfEjEH6Hbv7H7vfZf0gk5q3+fZo/jRb0lclM7WvpL
 qB1bcwcJBATuNHXHTUGK1yF++7xhM2RKBzC0NTAyiKEMvijBTefOUdnYTIPL/xzk7NOocq
 Lw8NckKd5Yg7j/3lB0/j4dTFOKSN5gw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-SVi_AjU-P5CupgF2lgYOHg-1; Mon, 21 Oct 2024 03:15:46 -0400
X-MC-Unique: SVi_AjU-P5CupgF2lgYOHg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a22a62e80so290477866b.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 00:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729494945; x=1730099745;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVxGon3KWm9x2irZSZT3tz5+/0o7syg+4pQNIESNu2E=;
 b=t8mVKmEID1+EAop4CdDifPc8/tKaaIedbz1raQHWyV0nSs1ZkEe2n7U3Rbs4xnewZl
 aZqnry9tth7a9FCBe7aicNXyuhzbof+SbltUAujITc3d1iqweVNZ8+lb8tM+mmyyEurL
 uvpBG8MzqfuqTKdtEevN/HarDGOWbdECoUd111Rsz1teagT5JRbGgsw17iamghhTOdhM
 vMBN9fCxQM6aLj/2gy6cK8Y8epR5B+ybkxMcgYx+6eT6Jh9m9Jeip+StqakxnMod2e7V
 C4YzLTK5EaXk578uP8YwHoP3d+6JYgJMKwObpXognpgJXFI4dH/qzEMqddp7e8f+BBbM
 6BBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJcjHPcQIeVWKkziegHa5V2/KgeTsaFmaQelSJa/LQ9W8jksKgphFH8Zik4ybwhL8gk4ueBUdqWqwt@nongnu.org
X-Gm-Message-State: AOJu0Yy+MAGcMm6f9i02auh4bSev7U80V9OSyjM0BZCNODN5ntb2W7XV
 3WLIGR/txwmdrtSWWPZS6/XvZ4WIo3eBR/kY95qsfhqrqXyks3BXg4wT14uusimToKvgdXEvF8Z
 CC5Gy/+DbDZTrm61PiccR7LWnpAhb5wsJVwN+x48pu4m83VDWpWQJ7kdKIKlZbcY=
X-Received: by 2002:a17:907:2d9e:b0:a99:ffef:aec5 with SMTP id
 a640c23a62f3a-a9a69a80a24mr1036058866b.23.1729494945138; 
 Mon, 21 Oct 2024 00:15:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzjGXtOfKCD4GGEzu3IDBzoe4cnFUcOzxm/dUHDtzTDdDni1xXOT+5mk68iguRzWRP5lWEvA==
X-Received: by 2002:a17:907:2d9e:b0:a99:ffef:aec5 with SMTP id
 a640c23a62f3a-a9a69a80a24mr1036057166b.23.1729494944716; 
 Mon, 21 Oct 2024 00:15:44 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912ee056sm169912266b.60.2024.10.21.00.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 00:15:44 -0700 (PDT)
Message-ID: <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
Date: Mon, 21 Oct 2024 09:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241017163247.711244-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On 17/10/2024 18.32, Peter Maydell wrote:
> This patchset adds new functional tests for the collie and sx1
> boards, which are the only remaining ones that survived the
> culling of the OMAP/PXA2xx/strongarm machines.
> 
> For these tests I'm indebted to Guenter Roeck, who has kindly
> built and made available the kernel images, rootfs, etc and
> documented the commands needed to boot them. All I've done
> here is wrap those up into test cases in our testcase
> framework by cribbing from some of our existing test code.
> 
> Based-on: 20241017162755.710698-1-peter.maydell@linaro.org
> ("hw/sd/omap_mmc: Don't use sd_cmd_type_t")
>   -- the sd card test for the sx1 board will not pass without
>      that bugfix
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    tests/functional: Add a functional test for the collie board
>    tests/functional: Add a functional test for the sx1 board
> 
>   MAINTAINERS                         |  1 +
>   tests/functional/meson.build        |  3 ++
>   tests/functional/test_arm_collie.py | 31 +++++++++++++
>   tests/functional/test_arm_sx1.py    | 72 +++++++++++++++++++++++++++++
>   4 files changed, 107 insertions(+)
>   create mode 100755 tests/functional/test_arm_collie.py
>   create mode 100755 tests/functional/test_arm_sx1.py

Thanks, I'll queue the patches with this little fix squashed into the second 
patch:

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1948,6 +1948,7 @@ S: Maintained
  F: hw/*/omap*
  F: include/hw/arm/omap.h
  F: docs/system/arm/sx1.rst
+F: tests/functional/test_arm_sx1.py

  IPack
  M: Alberto Garcia <berto@igalia.com>

  Thomas


