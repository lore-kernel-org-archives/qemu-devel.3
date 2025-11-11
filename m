Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BFCCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIsrq-00021K-It; Tue, 11 Nov 2025 13:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIsq8-0000rf-2G
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:11:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIsq5-0004nH-31
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762884685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TiMa4k140u3cGmFCtj6qdZarrmwEcQGAOitHCjnEHGs=;
 b=TWHW27ZZHD+ZFLa7Ge25z62cHPduqNQgxq6oo6cEOJSttTjG3R1ABrMvjcvrnhYxWGeLGK
 vXxkc1w3gzvDtfypZhK7Wgw8d4ee8gdn3H52uLeclQScFqbJFoobSpvCaUVcWwRS8Z0cfR
 ZUOjDofvmCvdaRx7gPMe3daIHvlDRZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-S-jew_EpMTGbRcyI2VRACA-1; Tue, 11 Nov 2025 13:11:23 -0500
X-MC-Unique: S-jew_EpMTGbRcyI2VRACA-1
X-Mimecast-MFC-AGG-ID: S-jew_EpMTGbRcyI2VRACA_1762884682
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4777a022d1fso258055e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762884682; x=1763489482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TiMa4k140u3cGmFCtj6qdZarrmwEcQGAOitHCjnEHGs=;
 b=J4Ogayfa22Enait47bmM83XTMbdNg1Z8A5dMZrHJsZKIU05niUa3MVb1ZOK3oyT9wz
 xeZSOGaSIE73NYb1r1tBqggFGKEoihZ1A3E1mDnUqp3fs1QCzcvhK3dSjEj3/+PPIUKl
 HAyojgEG4RYRtwLSZJaEmURlbuVw0y4/pTK8FvTO58lNJBYNUSv/YHz3FypYQ+oclFv5
 sLhyrnImx5ZR3LWlgHYqLD4imjZemOC3TRHVzeIRr7bSqUmhlthAXcTlNyvNNuTZA75f
 I/fRErAgp5S+bEkwZs/qNlM66E/pnY57aV66jsf4ICv1AxH/ALkM1QCCnX3ACvOs7g/u
 d5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762884682; x=1763489482;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TiMa4k140u3cGmFCtj6qdZarrmwEcQGAOitHCjnEHGs=;
 b=HDyek5LEW4sQKM+3qqdGDI/I8d0Nxyqx3UD7D0FB5rB0bZWqueY7MnkpIPrlmDix88
 tJgKKgkfxvt6fgMAaUnyGLCQvOD0Odpj1LF2aku9Emx0hqMg6w21ZrXCTUlLT8CUgfKg
 aE+XBf2NKCfAXA2/MKz5pWmXoGhW/TkwLRI4O4dMtgSCjUrp2jxKGacfsHPqWcgIjDpx
 dn+B9ZQfSursnTZe21SFS6/atqDp62aXeETOCH/NUadjx1wYZMPviBFwBMNGDk0VoK5O
 wDvGc0BUXkWo8w7+1t55BoHfpBqtFo6U0Ll63dm306Spq3AUK6AE98eTdbXt0uDMZ3pN
 UYLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKcIqNrmh5ku7B6eEz6ppdb3A5j5Qjau/q9dScLx8hONgU2yhtKtxe5UC26hqqQJ0cO0HkvwfNC7yJ@nongnu.org
X-Gm-Message-State: AOJu0Yw9eSCEifPYAEnx2+KOnDZZJR6UiNygGAR84QTGYfcqEsTcQc3l
 m2joV5Qo16t76FAvgHcY1mYr/oGT8G7v4PrvK4vwgi3WvMd7VowdaXd4/pQq9cY80kO77PYhSp3
 T9MBHnFhLeZ2IsBnrfnX9ZoazCASEJkov5KWfdyYwu1PRPvlL7p3Vz4ID
X-Gm-Gg: ASbGncuTaWJbc4FrxWcA1wa+MsCrJV7aZUdljoZPnwpwlPIGZC0ruhaD2/6p+jR/JRE
 JXqfjgarVHt0umxGk8Vnj4sDybXP40cmLv0MQnkixCyMSxdKVpRNk/q+cbuSZvYDnp9eg/3BpEF
 NTZPycqmwcj5uxk5yBcXsoTla4F5JUteB3wnpsRWWSmZuVX4wc5PQixG4xbCD2T1flvD6dql0XX
 3pRXAD7Vi2ISLnoenVF2SGIeoViGXnUSURG7laBmqg/0Qejp6PQ5KyYukiXoOzHrpNOFzAXmN+O
 nzQd8UA6PHgwMNAQl6nL0jNHJkRdeZRgI7eX3PbUbdTpdNe4M+3UB7RIPM6/MPYJFj4rtWA=
X-Received: by 2002:a05:600c:4706:b0:477:3e07:217a with SMTP id
 5b1f17b1804b1-477870be036mr3108515e9.36.1762884682308; 
 Tue, 11 Nov 2025 10:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHu6jE6Hs2I+kOlDIe38T3qVw2Smz7NUTRAeN2KbdV1zdvJfst63QQOsUcXg8BBcCm4u0VFg==
X-Received: by 2002:a05:600c:4706:b0:477:3e07:217a with SMTP id
 5b1f17b1804b1-477870be036mr3108255e9.36.1762884681881; 
 Tue, 11 Nov 2025 10:11:21 -0800 (PST)
Received: from [192.168.0.7] ([47.64.113.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47781d5d2f1sm24380255e9.6.2025.11.11.10.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 10:11:21 -0800 (PST)
Message-ID: <1b30dbbb-ea0d-4240-9604-2046ceef7f3d@redhat.com>
Date: Tue, 11 Nov 2025 19:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] tests: move test_kvm_xen to share.linaro.org
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251111171724.78201-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/11/2025 18.17, Alex Bennée wrote:
> Linaro are migrating file-hosting from the old NextCloud instance to
> another sharing site.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   tests/functional/x86_64/test_kvm_xen.py | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/functional/x86_64/test_kvm_xen.py b/tests/functional/x86_64/test_kvm_xen.py
> index a5d445023c9..424d4b20010 100755
> --- a/tests/functional/x86_64/test_kvm_xen.py
> +++ b/tests/functional/x86_64/test_kvm_xen.py
> @@ -23,18 +23,11 @@ class KVMXenGuest(QemuSystemTest):
>       kernel_path = None
>       kernel_params = None
>   
> -    # Fetch assets from the kvm-xen-guest subdir of my shared test
> -    # images directory on fileserver.linaro.org where you can find
> -    # build instructions for how they where assembled.
> -    ASSET_KERNEL = Asset(
> -        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
> -         'path=%2Fkvm-xen-guest&files=bzImage'),
> -        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
> -
> -    ASSET_ROOTFS = Asset(
> -        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
> -         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
> -        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
> +    ASSET_KERNEL = Asset('https://share.linaro.org/downloadFile?id=UG0V8dzzHrrHb9X',
> +                         'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
> +
> +    ASSET_ROOTFS = Asset('https://share.linaro.org/downloadFile?id=VwLRKDXKFl6oKti',
> +                         'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')

Reviewed-by: Thomas Huth <thuth@redhat.com>


