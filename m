Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C306CD13D2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIssF-0002e9-OV; Tue, 11 Nov 2025 13:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIsrp-00025w-Ru
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIsro-000502-QJ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762884799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lRgB1hC1kS3kFfovfKY73B8SnNqYSnVD8Z5SEzsfZCQ=;
 b=VrD01vOh4Y/JEH3rymfXVrN9QYLDad013T6xzGQX15O0wiu0ameAeBDRaqY7zKOBQgjvuT
 zos+12H32Hx+7o4Clpyjo6MvM7ddaRc5+k0Mr5jsu+Il5eyqaiEkJIJ+yKkVdThXsowTvh
 5pXkla7opQuBO/G2zqzS/5EcvIhg4qo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-qOpICSBDMHSkhjnSHelFcw-1; Tue, 11 Nov 2025 13:13:18 -0500
X-MC-Unique: qOpICSBDMHSkhjnSHelFcw-1
X-Mimecast-MFC-AGG-ID: qOpICSBDMHSkhjnSHelFcw_1762884797
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4773e108333so262795e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762884797; x=1763489597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lRgB1hC1kS3kFfovfKY73B8SnNqYSnVD8Z5SEzsfZCQ=;
 b=OzQ3rtNt00SxpZD0AWgaPW1eh0SUrXZsco/tOypUqKRxakABla6vYDblaa6bF48nhv
 oBZfqji2K9YilR6XArorYpCnUup1B63DgR8JFxs3Fl+MlscGZ9FX6iQ6FEtDX0YdUyYJ
 Ze/0We4uH6ZBCEbkMZXJ+2F0HeC/xKmPMWQCbHvwOZeW2kcfK9pdRMZV8B8t+tAhLJZQ
 LX0+HHeEMPS812Zeg4mzPcRGBKaGdMv7mwxlhMIhPtVQOELvRoMmiBzynSc7Cg+qkafB
 QLIJDId+j3FPHiutIQ9ZT4oXj8qzlsLflTVdL1NPqscghF70OeFVTY7gBbsU3X+He7lS
 ociQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762884797; x=1763489597;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRgB1hC1kS3kFfovfKY73B8SnNqYSnVD8Z5SEzsfZCQ=;
 b=cY1VXeVlHKzFb6HWuFeXP7F9bthbCOT6K1Bs9djpp9+/8XpApXqx9NbCFhhARPsxxU
 2XG3TBZbek1f4d1kBrysIZ0cPg1wL45kj3BwY3CebNq1iLNbXmDJxxiTY9VRPwHiz1oA
 e3si5ST2IZu7riFWwvOd1DRjbBLTF2bHznDMZW9sqk/EIxL+j/ZtmBAqmY+WH6EbQwTV
 dYfsc8ATD7SNNjBsiY4ODpVLLn9TQAeZ5LtdB7SBm8xjpwJllu7AYmgddazmN27RQwkh
 klqMldKn9LsqqB5z2BsWiaN4m3wC3U2XEAEfkXqgDR7ZqTt/Xri7DVKp+bbq9tH73Bry
 F+1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQlJdGBcUqDLrX5HNZsDzZVcj4kGDKsy1MKucctgisymAvCi8MAxBtnQ21T+sc19KFvtdrOvYLenkc@nongnu.org
X-Gm-Message-State: AOJu0YwrEoXWFg6vm2/QJq5AR1LqvxR3rzgcOp7duDOxEQZXTHkLO5c6
 +IGm7gIM8gxrJTpBg84a7bztQ+U5sYXK3FL6SlzIhukom79iGWFQRWxUZ2+TkQpCCRJ/i89k8S0
 Wa+stfu1bBjOZ+jQQQk+9hwfA8YAgb275OZ2gG5KklTR+MhTXaCb36WyT
X-Gm-Gg: ASbGncuuyHINPk0qCglSKlALeU2C4Sq19WnWupsLkdjeFOm7meK1cC68p8OGckV6p/k
 2Bakd9aPz/e58XSXP0uveirXm72ylyZEHvi/JA/o+pAQwnAsNJ9r8lX4038AcXuWYmFc+rpoTCj
 Ezc7K+tmcLZfrjIrEqnzdA/UZ8AEtx4XVL/P+HarJxDtdAbdzQmCc9jS3/gm6ZN7IJqNleKcHZZ
 PSY34ePKOTpix2nl7uJJF+YQuHO+8YJITYknu+WnJKX5jLxiLU7NZjm1hEBRyehlB4O+Thnu6VF
 s6jAZrYnu4PFME4nWc99UUv9pw2zMQHm43ihNmyAQTk5N2FzIBt92G9MST6PZ3IjHbtaH7Q=
X-Received: by 2002:a05:600c:b99:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-477870b429cmr3287415e9.30.1762884796900; 
 Tue, 11 Nov 2025 10:13:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjdehR/YNPEgqy3cfedKaBDMze28akfboSD3IePbaVkMjHIz/3+RB5Qu0H7nZtVJ9olsJiyA==
X-Received: by 2002:a05:600c:b99:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-477870b429cmr3287205e9.30.1762884796518; 
 Tue, 11 Nov 2025 10:13:16 -0800 (PST)
Received: from [192.168.0.7] ([47.64.113.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477816433a1sm25708975e9.2.2025.11.11.10.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 10:13:15 -0800 (PST)
Message-ID: <b351f1ab-d43e-4276-b86a-4012cf1159d2@redhat.com>
Date: Tue, 11 Nov 2025 19:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] tests: move test_kvm to share.linaro.org
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
 <20251111171724.78201-12-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251111171724.78201-12-alex.bennee@linaro.org>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>   tests/functional/aarch64/test_kvm.py | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
> index 9fb9286139f..c8351afc5ec 100755
> --- a/tests/functional/aarch64/test_kvm.py
> +++ b/tests/functional/aarch64/test_kvm.py
> @@ -18,11 +18,8 @@
>   
>   class Aarch64VirtKVMTests(LinuxKernelTest):
>   
> -    ASSET_KVM_TEST_KERNEL = Asset(
> -        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
> -        'download?path=%2F&files='
> -        'image-with-kvm-tool-and-unit-tests.gz',
> -        '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
> +    ASSET_KVM_TEST_KERNEL = Asset('https://share.linaro.org/downloadFile?id=Dt5pQbTe5RrxEii',
> +                                  '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')

Could you please keep the short indentation here, to avoid that we reach the 
100 columns limit?

  Thanks,
   Thomas


