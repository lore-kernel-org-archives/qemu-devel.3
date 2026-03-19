Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DC91075262
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w37Fi-0007UW-4e; Thu, 19 Mar 2026 02:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w37Fe-0007U1-4h
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 02:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w37Fa-0002UO-Vq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 02:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773903176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8lDM67wfkP2YEAGeo9Fp9ewxlXaPwgM13bPiLaWxij4=;
 b=MUeiYfQpOESkqcIz9yvj6hvnh4IFCMLFSbloubmAY6Hj8lqgQVrnwgcVZJM8vNdBvboOPf
 eNM66PFOAUfBewUcWBo4KDkVvq/mEpURduwKGW46/J58aFWz+/sMro424LFbgHyMZq7HxM
 0WemPutynppVQ8OCpzn3MjxbxgYRI+E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-GBo7heD3OG-N78BAD8o_9g-1; Thu, 19 Mar 2026 02:52:53 -0400
X-MC-Unique: GBo7heD3OG-N78BAD8o_9g-1
X-Mimecast-MFC-AGG-ID: GBo7heD3OG-N78BAD8o_9g_1773903172
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853efceaddso12576375e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773903172; x=1774507972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8lDM67wfkP2YEAGeo9Fp9ewxlXaPwgM13bPiLaWxij4=;
 b=XMTSHsfsYJpVTiC6A6/pxqbQNxnTkYBb4Qb2ztHRBt7Rp7JwfTezV+DZXrdAm5SmSh
 4JTuZP4EZ21xEyUp9EBJPRCAF759A/T0V8apfDRuIBbGYXd9xzM/AUhfDnx3OKCR43qV
 Qe3yGaYP1IwtFb7fyKvmDm7KysNFfiFrKS9ZllRkvIIAIWdt9RZEGoXR+lCS9LV2CwNe
 wtbaIbED+OeXJmaQB3DFCjTayBxkqFM+xfPBprwaKRv0KiKDYh30SAtTSQOa73ZL8nW2
 zYRS98tyBEG4g2okFKeAVHEQlNet42t5fXD1PUFmwMFVFAAyLmAi++nVcFGQkTpJ9Sf+
 +N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773903172; x=1774507972;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lDM67wfkP2YEAGeo9Fp9ewxlXaPwgM13bPiLaWxij4=;
 b=UJgnfU9MkG7W9A6AkYaKAObxUWtsc/JwU0q/hxodJ1hfFriw2CqcrJxdowG+VC25ud
 jZ6Z3WOW0NGp1b9ZiXTXaow1QQAVnUCZqXnMUlqnbAW240dpq4RmX5XPPUmvXCRG/QOJ
 wPWj83fpWLTt/X3iH1nWJbgerIeK0AwcLmdFY/1nCsXEIwZJAXaQlhoUNKLPb+VCjMDQ
 ZGQomV+5/wB5IWlha7/mmF2vTDdC2si71oYGXLYZkCBVF0XKpWDQslPTWQkALz9+n5mU
 MoEycZaDxUVV1Ndj+JildbHeUzp5zZWXl4yDXjlUpauYM+PhSqKNMBkEh/qd9KCYYcn0
 lnBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIREiF5+bSlZf7Uqibv7j2JcT+77lu33B0zvNC1jfzSaMv7xhqaQ3lSvGk3yn1n3nlXVIHql+WqN1I@nongnu.org
X-Gm-Message-State: AOJu0YyKSLtDuCyI2Ksz/w5HD5w0OlrqjV+w8+dLTU+8OEJVnVB4wdS+
 kUNRNZ2xI2IcJ6oaHzcV/mOEVyba4ihG+o3+0DilBReyNLcp8MsUnRQgPHqCDVne5GkqPqYILF9
 yvC2u3R5Ulv+JjsmcHM4b2Uc1p8VrIkLmX0ugyrJFaqCyXkQjdUjB3CFw
X-Gm-Gg: ATEYQzwCH0L3VoQpoNF5j6P6OuCy/66hHV/mJOHYY1WMNknq2ltvi8F8lcKfzucBxkW
 2fciuGiHP7LoSzn/zta2Ji++7p7jFPuiw0mMD/DnL4ZgIU/4/3sQ7aiIOMDYWWSqJxfHoOYzVmg
 8KFtyNXvmctr+VfNJ6T1yLoq17FdTlT3g8bkm/GFqSQXufQDUAQ+075EkWP8KnFiOggeOTgu9od
 AMvFC6U4VRtRNAU/QtWTBvE3iTuklh5K5PN0bIJxMrr8jyqrYGQQ+S59Kz3tvsg6o3AMkMArC+d
 690TIiworTBWPK7aFNgbTTNlmIxT5WQIo4f7x7KjA5/A8DcUhc2nhyM9urEDO/e6IAqCvEfYXmY
 khTQE7GjrIp310vTqKOwAkLCdDasDqkhm39n8v1MZ9sPwAVQArHGgYbGr3icr
X-Received: by 2002:a05:600c:a06:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-486f4421c90mr93952115e9.2.1773903171832; 
 Wed, 18 Mar 2026 23:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a06:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-486f4421c90mr93951895e9.2.1773903171439; 
 Wed, 18 Mar 2026 23:52:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fbea40c2sm15615795e9.5.2026.03.18.23.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 23:52:50 -0700 (PDT)
Message-ID: <5b7ce153-30ab-46b2-b9e7-8c31e7cb20a8@redhat.com>
Date: Thu, 19 Mar 2026 07:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] backends/iommufd.c: report error when /dev/iommu
 is not available
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, philmd@linaro.org
References: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
 <20260318180641.1797902-2-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260318180641.1797902-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/18/26 19:06, Pierrick Bouvier wrote:
> In case current kernel does not support /dev/iommu, qemu will probably
> fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
> since QEMU opens it before /dev/iommu.
> 
> Instead, report an error directly when completing an iommufd object, to
> inform user that kernel does not support it, with a hint about missing
> CONFIG_IOMMUFD. We can't do this from initialize as there is no way to
> return an error, and we don't want to abort at this step.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   backends/iommufd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index acfab907c03..2c3ca23ca0f 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -72,6 +72,12 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
>   
>   static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>   {
> +    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
> +        error_setg(errp, "/dev/iommu does not exist"
> +                         " (is your kernel config missing CONFIG_IOMMUFD?)");
> +        return;
> +    }
> +
>       IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
>       const char *name = iommufd_fd_name(be);
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


