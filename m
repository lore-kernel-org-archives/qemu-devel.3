Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4390AFCD0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2lza-00047o-FO; Wed, 18 Mar 2026 04:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2lzP-00047H-OR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2lzM-0005XU-HC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773821446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b4iVUJZXpPB06P8LxK1UsgezufZA/Xa1+6lXVhtEzns=;
 b=GEfRSF3ndy+PCYxi79Fc7fgkigFpLDGb6fxJ5zwDOAH73tUL1idIt1QOcNUlmgIkIo2qtr
 gy5rmNzHOErs1TZ4W9Vuaeg4lXjflEwJy6o8bz2JiKPTHrPNxP1LI3wEkOuVN2TBtAp5Ch
 JfNvspFIRP6BDJwBFv9jlaQ/jyJ75Cw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Grg77_l5Noii2t7UdugNog-1; Wed, 18 Mar 2026 04:10:45 -0400
X-MC-Unique: Grg77_l5Noii2t7UdugNog-1
X-Mimecast-MFC-AGG-ID: Grg77_l5Noii2t7UdugNog_1773821444
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b3a675316so2871077f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773821444; x=1774426244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=b4iVUJZXpPB06P8LxK1UsgezufZA/Xa1+6lXVhtEzns=;
 b=ccKAul3Wi3OFRiSV5Nhg8jVwqgkEp8/yoVkqxNhZ7BP2kih+3paZB+qRFJOOK0kHVU
 MU0z8+uF9Gw/T+RufQR11qSEKFSf44VSXw1NQOWdjwOs1U05hhhMXlEi/sYJ7S3cJTtC
 w1Uwtvt/pNqe5Y9ZYrnaVq67dfZ57kZLKCN0ERGSOT6qoJ9UM18kLrmz14c7G0KANqii
 +IMKBMdl4r9Q2LUS706+T5Fm6fI8PIMBcBM97gtisFxDyafQlEgKrwOwYVkeJZppeEp0
 unf29KPs6nQ7rdl/r3Or6ghcBNoPcxz3XvcNtTHGkLS8WUrKjCH+NdZygV0wjUquAH+/
 S7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773821444; x=1774426244;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4iVUJZXpPB06P8LxK1UsgezufZA/Xa1+6lXVhtEzns=;
 b=fHxuFhKND94LSR9L7zEWLrvtEK26qUC3FxH0EhkFz5X6jh8RaLGU/9LOnzyZLSN99f
 Kv7ImBUYTVfGpGJLwVM3AhxsUkgUrWD1MRsEKBI8KqpC6IdiZMQ8Glxh5Acl1g7ndHUJ
 Aev1VCkvtjZRSOw/tQsXqtPTlSH8JMXzXHlDjo02zimNkoHy2liw/eRGD5/r4XeGgP1d
 MlMRkiJOCqDr2gqj8ZNFcjJTR9MRzTGkKS0tn6E+KPlBRPUzWeDpGChaD/X6MnlQRHsF
 YWIJyvCRVEwnOzq3PnJOoBP+vqPZInZc0hoc2JL8eo717AJzJRNsz24fvwecuCiaEbrq
 GLOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtmTLlMt5t4QyE12+5J7Fl6w4uv5UA7vCJs3H9qQJ61GFdbE46thDVRZ9wJ3w0gGBBWczHxCmtwCnD@nongnu.org
X-Gm-Message-State: AOJu0YzcVmS4Smo/lvkUDnPEID6wSXoYf59CBv66cvfaX7x7GuhWaNUT
 H2IXTfE795zb5YwEQCjKF/doH7cbaiZY6LDRwwrhYZuh0w/vD9ZmE7QWaxZqvGlLAVOobObA7aO
 6olwceEbA7+SA/YNwR8qpj1H+ac9Duz0oyPXjr83cxeZXUMimWA9lIUbG
X-Gm-Gg: ATEYQzwNyTpO1PxnDdjCRwmlX28wtnIKRznskfWd11SriOUHFih02rnigqCekiuDsE0
 9KpAu3tfbe+KTZhFEd4gMrBRtZrPl/Tao7OSU8Uro71bAgl3X9k3lRH5qkJC198Uaa+Pni7MhZR
 pgBGfIMXUSJR9eGQ300zATMbUBCzUZpBcrZ1DidZLWtqwvOJM8tf1xsj2DEr7qCJJV7iZbJtMKX
 e2GXQpxmEL8CK/j52vxZRre8iwil92GRGM4WKpjmPE+6ZHwKZ+rMYGs/PGx8zEm1AynyoX04ASd
 Zr6qqJfcIQTSZU1SEot4Jpn6b/wC2Os5zBgGF0kWsnzc9NyOTsQZpD98i5HzJ0Bl12F3j/iWXB0
 sIOjzHaPtDGcPXS16zHvsJp3sr9jdM7mhezoLmIAHX7EIwoh0iq2MgaDsS/eE
X-Received: by 2002:a05:6000:4008:b0:43b:42d3:31ac with SMTP id
 ffacd0b85a97d-43b5264dc3bmr3510067f8f.0.1773821444167; 
 Wed, 18 Mar 2026 01:10:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4008:b0:43b:42d3:31ac with SMTP id
 ffacd0b85a97d-43b5264dc3bmr3510012f8f.0.1773821443569; 
 Wed, 18 Mar 2026 01:10:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51805291sm6384620f8f.0.2026.03.18.01.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:10:43 -0700 (PDT)
Message-ID: <024f2ab1-a22b-426b-99b1-ad710b87b83c@redhat.com>
Date: Wed, 18 Mar 2026 09:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 philmd@linaro.org
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
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

On 3/17/26 23:57, Pierrick Bouvier wrote:
> Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/iommufd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 131612eb836..3e33dfbb356 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -274,7 +274,10 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>       }
>   
>       if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
> -        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
> +        error_setg(errp,
> +                   "failed to load \"%s\""
> +                   " (is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?)",
> +                   vfio_dev_path);
>           goto out_close_dir;
>       }
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


