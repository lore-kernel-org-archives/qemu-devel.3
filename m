Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1068C106FD9A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xBX-0006RA-5f; Fri, 13 Mar 2026 03:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xBU-0006QY-Pw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xBT-0007SK-FE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773387826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0bGaM+93fb+es1F4mpSH3kvQEEEIGegoUZbwppNwLPo=;
 b=bQ1eGZcFqZOT4VT2BokWH5Sw/Q3dsypgcQqmZTW25lf+feIbI1t4kNFJiUX6ejtmciObqg
 JzsfErPjsyo/orMS0XkxgQyTCBmOpdvx9QEKvLUD5XEW1zkbDsq6Pt+Ssd4vgKGVB799Zr
 ebheT6XmEjThmY0zBprBC5jpE7xTuwg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ymrickZ-PY2mxCDoBJ1v5g-1; Fri, 13 Mar 2026 03:43:43 -0400
X-MC-Unique: ymrickZ-PY2mxCDoBJ1v5g-1
X-Mimecast-MFC-AGG-ID: ymrickZ-PY2mxCDoBJ1v5g_1773387822
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48553fdd03dso9602245e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773387822; x=1773992622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0bGaM+93fb+es1F4mpSH3kvQEEEIGegoUZbwppNwLPo=;
 b=dUR02xkHyynXlHW0dDq0Rlmb8ulIl3Ju1/ZzcFtbY7eg2Hx7ZGjU8z37KgqlYHOEFM
 L3S9LsYihm0Xn2pt7E9PLIxUmxr5BtVC9udi6vvGjriW83oJgp908aMUiAHkcTvQi4po
 93UYwmITDd6tbXkMaYRmlSJSz1sCcbSIVCUueqiOOzSw5Gm+y3l9R6j0U3AAAKdgDFHT
 kJ+ukSAQtwXZYU9IcA/CYf07QPhqKUJNhR9lE7byJuv4wtA7lgZA2S7tIZ/M7v8pEAmN
 Z+WTI2AxPDo7Dqy1f/9FKg1ZBHqOKExXYUrAZsKOnXFnn/0JaVy0bW3cJ8qn3pO7LEN/
 63PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773387822; x=1773992622;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bGaM+93fb+es1F4mpSH3kvQEEEIGegoUZbwppNwLPo=;
 b=ZRp3w4KsxGNZu8tDWizXpo6r4REELjY2t0iJuKs3KDBHhRKWJH7ugaEAEMafQ6ocmG
 OJeDT+G9DCI2TuKSyeuASA8Ia7JPHQwPWabs307Q/0Uuy+8obZo6a0G4hg43Kq9AcuJE
 P9qS7asm8Sx/a35lJUjSfnkHu4bcplb2Wu+1SjanhOPoWMrG9WY5oZD2YP7ox5GTttpP
 SiXHbXKA7sX2cIp2axl88vWjcx0GhfGlFi83S8KIYB5ThxVqKmL4Ckrjkqjf8j2chZ/u
 u06HFv13eGGK7CAWJ7PIxcKJIGt8i6L0bR5wBeev6KF3M9+J/BQ4Ic6gdAStMO3b7rDo
 Ouew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrSrwXds492osFhKUrWX4NThTiZW67BRbIRxjR6zS1u2x/Hyzc/RU/6WUn8FbLOWAchFxlAH0SyHbO@nongnu.org
X-Gm-Message-State: AOJu0Yy8Q9DrBeVNTTisnxyyPAfRYKEVH7lUqAB0taP0GOLoWhleb0/Y
 v5dgdtplM+Vpemi7hW7zF/xrqmcGwduGAglqEFWlq/udPUOOTlGhY/mrmWyOD9mQM3DC+15JKS7
 JPUI7lYu6ZicTczuPK669EWDJaMu+cySG9Ux4GLqNKAzi3m0++Xx3UyJe
X-Gm-Gg: ATEYQzwPttSQN3kChuQqf0252y8y8InIx/3OEP9o1CiIAklNxHph5YaLBUVLtNm/GtP
 00KAIq2V/a66goEJS0YrtmwXQhhz3zvj1hDxbUPXJEEZU0LK4yEImDzX5dkt7DawMSDdmOXG+zZ
 dZbB4qkOImQIwtZsxXziYQpN0gs24bOnrNn3MRBp/RF4TsuxSe8Zgw3LRc4b7uqNxQq4M4NUXIc
 nbIwT9v9rKrMO8BRjgPJ+8LLEkjpPBBI1xnWkWJVNDGu6mBhVcWPEQRj4sWwG2i1q6oU7I1x9lK
 4tbG04NKhndpofICJ+vbgJpj5n7MsNIKtrVrdDlIMibuO1si5ymIdrlHZoXgOIlOGMB5uuQgfoY
 en6hVbh9eNc6wnh4XmwkvunF7KLsct67OVodUupoP2hNmjewV05pWcWF79Jz7
X-Received: by 2002:a05:600d:4453:10b0:485:4388:3487 with SMTP id
 5b1f17b1804b1-485566ebd1fmr24317935e9.12.1773387822497; 
 Fri, 13 Mar 2026 00:43:42 -0700 (PDT)
X-Received: by 2002:a05:600d:4453:10b0:485:4388:3487 with SMTP id
 5b1f17b1804b1-485566ebd1fmr24317715e9.12.1773387822027; 
 Fri, 13 Mar 2026 00:43:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6070acsm159512675e9.8.2026.03.13.00.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:43:41 -0700 (PDT)
Message-ID: <cdfef328-4ed0-4314-a91c-33d3ab10ab18@redhat.com>
Date: Fri, 13 Mar 2026 08:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 23:44, Pierrick Bouvier wrote:
> Add stubs for needed functions.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>   hw/vfio/pci-quirks.c |  5 -----
>   hw/vfio/meson.build  |  3 ++-
>   3 files changed, 22 insertions(+), 6 deletions(-)
>   create mode 100644 hw/vfio/igd-stubs.c
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


