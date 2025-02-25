Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B9C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1LR-0003hK-5K; Tue, 25 Feb 2025 15:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn1LQ-0003h1-7P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn1LM-0006HW-LJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740514548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q+y5l7nYPpVVn7dMTIPddwfeKoTWjtOlxwdYx/xJMxg=;
 b=DW/nfLrllMquuPdQ7LWf1E2APvBgQKDgkYUomPOSKAK9hS65mind4QTrUQ9rprz0QGy9Sh
 gs1gWhXzawLJOLq2R4we7vrruXA7+ZV/omOYBdp9ojxHSgqAhFrZu2+ya9MskX8JCdtEY4
 R1Wu4jaKoOa0653354Lnp2KuTB0rPko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-7huJSTW7Pueu3KxB_IEwug-1; Tue, 25 Feb 2025 15:15:38 -0500
X-MC-Unique: 7huJSTW7Pueu3KxB_IEwug-1
X-Mimecast-MFC-AGG-ID: 7huJSTW7Pueu3KxB_IEwug_1740514537
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438da39bb69so44063095e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514537; x=1741119337;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+y5l7nYPpVVn7dMTIPddwfeKoTWjtOlxwdYx/xJMxg=;
 b=HvCTe8QTcNsbBEnurNLmFiX8MX+sVvoINAsqh8ap7s507QnDShbyEwydr2ohl4HLrb
 RMIajOFcrB5iO7Gf2XtLmYmZCXF+ZMZpgV1IQRcfepdmrQIoGezuQBR79l92iu9lpAwH
 IXgd2qYPpfwgb53LwH7aKhNz7aaS3++5KwlVrpvPPTWqUvae/8YmpPOJI5/XlBDSWWsA
 rDaKLE1LVohUDc51Jm3U1Ml4794EGtlEoUq6xDr10NN4hUQJrAnrs8V5qXeG3S8pAQfJ
 t8IjGyo6VlN91QH8DQ6l+SFDgRUyXBsgnS1Iuo3D+zmu6hnW3mJxNKv/joOVHdg3qWP+
 o56g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJRaqZoAjPAm5l05HYAaaJ+OwJ/bWIFuoGZTV0hsEBGZlFmxuU+IZVKCY0KSx95BGIo3cDW1emGKxs@nongnu.org
X-Gm-Message-State: AOJu0Yyml4wyZ5z+Avqsbb8SrihwSsjlEcEn1iBsRE/F6wgN4iOjk54B
 P6wMpZjfHk2jjT/sbR4JFm5/j3iQl93eiXiHH5qr4IoL5+8RWQvevMgxIDoRIGigvd14DinlMP6
 KO1K5RD/ZNkoJs9TqkRWSqNNLse8SrUUtyBLgtUfYX5BIU23LlyX6
X-Gm-Gg: ASbGncv4q13HonHYDoo+TfAu4feyZl26quRuO/zkaWU5aujnU1yCBiVcCZpLKH410aN
 fNxUEjyS0Yt/PlkdUSieb+nhpddckbmjwis97A1E/WSHc77esn1VyPz24xzkG4Jcc8EX2CPKuHH
 mnSFPrNKtC04VL89yEnPnb2hnQ7vyFfQhkGJ4foyzUdslLGMPoNplsT2mqPYk9kMzxSimGMUaKT
 ns14hnb/baVXsBuJt6HFz/wWjaOhIHEjPX6tCfLvmLdEKWiv+ktPScItxigq4dF+b3wT85E9mXN
 f7XFb5ieFtaSUhRlK3pAeZycgd5O5Q/EOU1dX9p0ZSrpkMA=
X-Received: by 2002:a05:600c:4e8b:b0:439:9206:86d6 with SMTP id
 5b1f17b1804b1-43ab8fd7344mr7684965e9.7.1740514536959; 
 Tue, 25 Feb 2025 12:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhIOII4BzhXAbj5iX8ORLix1uTb3CHebbSsuf3v9pNXmkWdpqCgKdbUme1qeA+e9eN2/2ZjQ==
X-Received: by 2002:a05:600c:4e8b:b0:439:9206:86d6 with SMTP id
 5b1f17b1804b1-43ab8fd7344mr7684875e9.7.1740514536607; 
 Tue, 25 Feb 2025 12:15:36 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce587sm150905515e9.6.2025.02.25.12.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:15:35 -0800 (PST)
Message-ID: <e5e290e2-63ae-47f9-9a85-5ba5f609a37d@redhat.com>
Date: Tue, 25 Feb 2025 21:15:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] docs/about/deprecated: auto-generate a note for
 versioned machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250225200423.2350471-1-berrange@redhat.com>
 <20250225200423.2350471-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250225200423.2350471-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 25/02/2025 21.04, Daniel P. Berrangé wrote:
> We deprecate versioned machine types on a fixed schedule. This allows us
> to auto-generate a paragraph in the deprecated.rst document that always
> has accurate version info.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/about/deprecated.rst |  7 +++++++
>   docs/conf.py              | 33 ++++++++++++++++++++++++++++++++-
>   2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index abadf8de27..da2b1b48ca 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -269,6 +269,13 @@ Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
>   System emulator machines
>   ------------------------
>   
> +Versioned machine types (aarch64, arm, i386, m68k, ppc, ppc64, s390x, x86_64)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +In accordance with our versioned machine type deprecation policy, all machine
> +types with version |VER_MACHINE_DEPRECATION_VERSION|, or older, have been
> +deprecated.
> +
>   Arm ``virt`` machine ``dtb-kaslr-seed`` property (since 7.1)
>   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/docs/conf.py b/docs/conf.py
> index 31bb9a3789..421ece1024 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -110,6 +110,27 @@
>       else:
>           version = release = "unknown version"
>   
> +bits = version.split(".")
> +
> +major = int(bits[0])
> +minor = int(bits[1])
> +micro = int(bits[2])
> +
> +# Check for a dev snapshot, so we can adjust to next
> +# predicted release version.
> +#
> +# This assumes we do 3 releases per year, so must bump
> +# major if minor == 2
> +if micro >= 50:
> +    micro = 0
> +    if minor == 2:
> +        major += 1
> +        minor = 0
> +    else:
> +        minor += 1
> +
> +ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)

While the prediction should work fine for major and minor numbers, I think 
this will look weird for the micro numbers in stable releases. E.g. if we 
release 10.1.9 one day, the ver_machine_deprecation_version will be set to 
7.1.9 - which never existed. I think it would be better to always use micro 
= 0 here instead.

  Thomas


