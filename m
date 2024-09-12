Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8AEEE57C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sod9q-000156-7A; Thu, 12 Sep 2024 02:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sod9n-0000td-BW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sod9l-0007kq-CU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726121895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtnFOmcdsGvXn+fzWEqvi+QRZ1oih4TTsLrJlyubx4s=;
 b=VulcwOpUAKF2rqFwIKDouV6l9eDkyedtEitF0Uv/wjAIqh1EsaTwSB4O7xx88fEQOxZT9D
 jPoTfZuqr13H1wRc8uBAIFQ7irJ0PqQliWmOeJch5Ov16NFyPLUak7xgwM5AumI73wRMCS
 yA0dqARvMATBJL6AMFP/8eT2KuWweVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-sNUgBXAEMJ64_WfEqXdbGA-1; Thu, 12 Sep 2024 02:18:12 -0400
X-MC-Unique: sNUgBXAEMJ64_WfEqXdbGA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso4268385e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121891; x=1726726691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtnFOmcdsGvXn+fzWEqvi+QRZ1oih4TTsLrJlyubx4s=;
 b=lOZstNFxgT4B0gw/W0p8fJxySPqWeIkut6KuIvociFurZXta92+crjRvGO/wbm5Bbm
 dAFoFd3k959bHvObfnTKbQy74eKJi9P5X0shQkB0599IMZ8jr6Nk3Ou55Wk/WAAoRcqd
 15BWPg19hVb3+pLhIEa44utOFA4l4vjksb30E5MaGcqQohkKzfgw5Y9KEi1H07hJ2wWM
 qs3EpMC6Qj/Q3MiOaRNC11ZaOSmZ4P561E8i1EPe3UT3NMNdkTQ5grxEJGwaooyHWxEV
 4OoGFBPYIQE65p5L+ZqS8B0/aYcOONyStbLlLCFkhqKwyWyk7d5Tb0wv6yrdQVSTGzCk
 bUFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk6d7ocrdvOFT+XNAavVR/iOP6cxxPfIHthGgQHRTDrLq7Rym1nZqdpZBcAD6bPOEsYRHOHXXZ7+4e@nongnu.org
X-Gm-Message-State: AOJu0Yx1Pojb9YRnMI/9DwiXwgs2TdZvuhF1oGTYcjRGKbqYEEJWaxhT
 g/HbOu18hkCt1cS9d7AeIrpZasJtXdau6oHfDSZtfogJe1Q6JlJwfY6Km7Hxv7037O9fhfdn0R9
 ijgwLdC0d0s44cYrTPN+860OXrcgyu6KJCsol8KcRIPI1LYIEY9LE
X-Received: by 2002:a05:600c:4f03:b0:42c:b97a:5f7d with SMTP id
 5b1f17b1804b1-42cdb509fc7mr14284365e9.7.1726121891214; 
 Wed, 11 Sep 2024 23:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIjw+g9mayx8rl0Qp/AyBolUaPi/aaXKguRKMn+haG4amw8wRwfolRUGZ4O47D1baMtRnKtQ==
X-Received: by 2002:a05:600c:4f03:b0:42c:b97a:5f7d with SMTP id
 5b1f17b1804b1-42cdb509fc7mr14284135e9.7.1726121890714; 
 Wed, 11 Sep 2024 23:18:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21a4esm163314695e9.7.2024.09.11.23.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 23:18:10 -0700 (PDT)
Message-ID: <5fca8390-33c8-4139-8238-caef3e3f1dbe@redhat.com>
Date: Thu, 12 Sep 2024 08:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix null pointer deference from error API
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240912051734.5298-1-jim.shu@sifive.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240912051734.5298-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Jim,

On 9/12/24 07:17, Jim Shu wrote:
> pci_dev_realize() use the local error variable, which requires
> `error_setg()` API to allocate the error object at first.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0a99e55247..d994ad8bb9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3117,7 +3117,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       if (!vbasedev->mdev &&
>           !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {

'errp' will be set by pci_device_set_iommu_device() in case of
failure and, in this case, calling error_prepend() is a valid
thing to do. I think we are fine.

Thanks,

C.



> -        error_prepend(errp, "Failed to set iommu_device: ");
> +        error_setg(errp, "Failed to set iommu_device: ");
>           goto out_teardown;
>       }
>   


