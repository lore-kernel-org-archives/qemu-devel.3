Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482D6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4Up-0005oi-0q; Wed, 30 Apr 2025 06:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA4Uh-0005nt-07
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA4Uf-0000RN-6m
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746008203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T5ePNRWhWKSGH/h2zTRP7rxRu+CVbAeXuUcC5fgxoS4=;
 b=EzeP6icwh874wmOY06y+h61KSi9YaHRu6pu4jMqXbdcoLEiDAmhsenRlIRvr+77hLreBVW
 NwOsuqZrAKVcxRlAXm0MmnLuoS+i5iCMKL7nK9kwXkKcGeq2Y11Z64uK2m0WpDeq0IizPS
 4e6IYDwU1mBxU4yoC+GX6MQ02NosyBg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Tx61b6NSNpmwC3fBIH-QIg-1; Wed, 30 Apr 2025 06:16:41 -0400
X-MC-Unique: Tx61b6NSNpmwC3fBIH-QIg-1
X-Mimecast-MFC-AGG-ID: Tx61b6NSNpmwC3fBIH-QIg_1746008200
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so54177175e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746008200; x=1746613000;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5ePNRWhWKSGH/h2zTRP7rxRu+CVbAeXuUcC5fgxoS4=;
 b=SYSL9IDTat7F9fNPEnXLZ83dT2EOCUmmTkjU/qL/ujcn1GjjWbWRsfC5zWGDKlSF+2
 Pqt1FGcoX/e8ZX6V2lLDS+swKUYjzgnI48WlQjPifKGjpt9uyxspRjWPLVk43IMsssWL
 rkwtSbVWVh0ZNj8SNfHFntDwL1i6tI5q/ysbZ9eFY3Cp3s3WnoBuQ/nJz2sPaQ2DG9w/
 q2bLMj4wnu7BeX2rmvBfkvTmgfSLeM+OKX+t9ZFGE2BexSvZAltZqG/H6YaScl2TdDUQ
 lPhPV+JTWveIcTKr7/RZExYTdCP5Ug3quGwMlIvp6XASzadGGeTOiRKsHGrLdKlN14er
 xHvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/RT5H9RNbH53IW/JKzReJRIzv9sK9RNFHI9G4JaYXvsJktHUyxCVpgFGi1+pVjiXjmIYbRK09tO+p@nongnu.org
X-Gm-Message-State: AOJu0YxnNWbbUTXCLmzLQSuBsGxr9+SOsGF910zwwT91lX90BJzGfkiW
 WuVSEHmdcL8gYANuIO8BI+xIU7v+arEjH7hOXzIRhTdWBv4efa4D++wAwLvkH+PGcdVDCZ9UOzL
 iofJAnAK0xxOe+nQTV/ExdGpdrcZEmzue/G5BnOSBwGUZMQY+GuND
X-Gm-Gg: ASbGnctWMHTPYSUCmQ+j6Idz8mve265k9lbvCiN0hl80fOki2BLRV8Bbljb5TTYOOhS
 nx2Gh/2XENvLV211KKf0O54/xScHo1Zg2FB7cfzNc54bOrBD1igVruM5rpPnO5vGLds6XhCGwb+
 MB8/8LCAdOhPi3cfXL36VJg0QaGeh1hzMeSB5ws5yAMFksHNPMUUlULWcNYkjfpoyVDzmin2VCv
 xDfTh21gWXjLAWyuZxJBcWLmtCK6EiroCsKGRV06hR2qXAbclaokKv20qAzIzPy/3A5GxLG7/Qh
 Smy9nxB6CISfnc4Z2T8q93SHcBFUFjd9BozbqZFj
X-Received: by 2002:a05:600c:4e8e:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-441b1f62053mr18066435e9.32.1746008200198; 
 Wed, 30 Apr 2025 03:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlw+4Ra8xvJ8nyaDPg/jkLSbwvYPAfZq20gysrnPtN/Xtltp82zCduRkzHCfN74rtQIj9a0Q==
X-Received: by 2002:a05:600c:4e8e:b0:43e:ee80:c233 with SMTP id
 5b1f17b1804b1-441b1f62053mr18066165e9.32.1746008199774; 
 Wed, 30 Apr 2025 03:16:39 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b972casm19797305e9.3.2025.04.30.03.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 03:16:39 -0700 (PDT)
Message-ID: <c93a7688-c19c-4155-b9fe-ef3e6b15be55@redhat.com>
Date: Wed, 30 Apr 2025 12:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] docs/about/removed-features: auto-generate a note
 for versioned machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250429131526.1842130-1-berrange@redhat.com>
 <20250429131526.1842130-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250429131526.1842130-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/04/2025 15.15, Daniel P. Berrangé wrote:
> We remove versioned machine types on a fixed schedule. This allows us
> to auto-generate a paragraph in the removed-features.rst document that
> always has accurate version info.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/about/removed-features.rst | 10 ++++++----
>   docs/conf.py                    |  2 ++
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 790a5e481c..59fec3c9a1 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -981,10 +981,12 @@ from Linux in 2021, and is not supported anymore by QEMU either.
>   System emulator machines
>   ------------------------
>   
> -Note: Versioned machine types that have been introduced in a QEMU version
> -that has initially been released more than 6 years before are considered
> -obsolete and will be removed without further notice in this document.
> -Please use newer machine types instead.
> +Versioned machine types (aarch64, arm, i386, m68k, ppc, ppc64, s390x, x86_64)

I think we don't have versioned machine types for 32-bit ppc, do we?
(pseries is 64-bit only)

  Thomas


> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +In accordance with our versioned machine type deprecation policy, all machine
> +types with version |VER_MACHINE_DELETION_VERSION|, or older, have been
> +removed.
>   
>   ``s390-virtio`` (removed in 2.6)
>   ''''''''''''''''''''''''''''''''
> diff --git a/docs/conf.py b/docs/conf.py
> index 60dcf2a541..248ff8cf5d 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -137,6 +137,7 @@
>           minor += 1
>   
>   ver_machine_deprecation_version = "%d.%d.0" % (major - 3, minor)
> +ver_machine_deletion_version = "%d.%d.0" % (major - 6, minor)
>   
>   # The language for content autogenerated by Sphinx. Refer to documentation
>   # for a list of supported languages.
> @@ -170,6 +171,7 @@
>   vars = {
>       "CONFDIR": confdir,
>       "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
> +    "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
>   }
>   
>   rst_epilog = "".join([


