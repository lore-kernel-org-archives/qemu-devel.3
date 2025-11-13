Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD03CD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUxj-0002oe-SS; Thu, 13 Nov 2025 05:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJUvZ-0001J8-JF
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJUvW-0002VK-Vx
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763031101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XKo5vqTcFRXgLdeTCy6JkxEm7xMVp9TfTcYXdz3iMRQ=;
 b=WRGHPgNPoPZJb6OjbQyJE0TuDM6ngoIvPfoRYvXleYAEuHOW0Z+/3UluLz3v/Q48oquGvb
 wq1oc8XxKppxb5f1pZYYtqmvM0qzvU8LiQ145ldWwFkm02EeVlnnJpZPOLYli3zcVRNkIY
 +rizxtQ8xL6xym23tYb2ZrAk6PrNxzw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-aPvfYIqfOdWPxp6te0mvOw-1; Thu, 13 Nov 2025 05:51:40 -0500
X-MC-Unique: aPvfYIqfOdWPxp6te0mvOw-1
X-Mimecast-MFC-AGG-ID: aPvfYIqfOdWPxp6te0mvOw_1763031099
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477771366cbso4938035e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763031099; x=1763635899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XKo5vqTcFRXgLdeTCy6JkxEm7xMVp9TfTcYXdz3iMRQ=;
 b=amVPPobIsStzN/kR62BbbKQTAZqu9TZ2a96dN4goPV+cOiBH6dVyG14aHtHMnRWojK
 /eTVbToFJIHseU5XNWoD4qWxKczoTvz28DjwDSYyo3/s38fFojloTgExIZ3my/zT7FMi
 owcelEnFtUpd6lD7yeav8wBeRWgX1mqLR131xj7l36WEYI3WOWfXFr8NA0/4IIIGbYeU
 4bKq4bzuLkkhHY821tyDMEAxgK5HtC8iYlLTryLseo35CO8j7wopyRfpAma9mKLkgcg5
 FJxFWGN6Pi9bmmarRuxXe0G8AH5g85ynswU9Ee8ySzb6Nw22vVXTLuc/bpj1sqQp9F2q
 nS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763031099; x=1763635899;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKo5vqTcFRXgLdeTCy6JkxEm7xMVp9TfTcYXdz3iMRQ=;
 b=BaakhbnXXVCN/givhklbhWvyCg77dRyZNH6yLhToeg/+TqqagjeN/3C+Yxyfo1yMFk
 J2+0muGXwcqqXavSOwILz1gkYS5YNB0joPFWmHm2cGhE1AYq1UHCUXLiKFsiHJ/5pm3H
 /dfndITJnq3w3mtSRMLKuTmSzNM6gY2GfTGatTcuEZGmVl0BtdNvLzNc9qe2J1dRBr90
 dVsjDOqihAnE6/Cbg3VN26beDCwhNXfl3WorUc8LSPz1FdrqUVmGUzz8EZ32GAhUbV4G
 Lf4wliZKxIZKj+X5+d1gNd7J8Hggy4QGOm8jIin9ySMUzm8vMuqZklrjYBtsfKi/KFNH
 /3+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7D7b2DZGE7WvKZOUq1VTkSG2xadvziCo+Cz1XpUpq69cc3iPJs69HQxh9Ohbz8fsRlfeotcR9GhE2@nongnu.org
X-Gm-Message-State: AOJu0YzpZD/H0wB2QkTxgl/IBbgidgCRp5x2kWeSLzKDy72TzHSQkGQn
 CGVyzKhubGATI6q8rcckaHBo8tPEFXXMrw9ANKPC1ejC7qgWc9JY/tCXz+p/BNK8U8vg9RMuq6d
 cvH3E6cskVVuS8VW+hZcF+WhaqFjZF49q3rd44Ye/NNWBNywoJmtoQb1p
X-Gm-Gg: ASbGnct7KQa45AzTX8EfWSe7wYn426f4AYGVL+m108n0oBZ9q4pPJdM2OWiyaHLj/Od
 FogL2l7eHHz9fg4zpM05wVT8pQWqp0q4QN0KxlF+hIl4XrUcaNIkMdLI81SPxZXjG2Y/f8ucvMw
 Lp1V225c4HJypVwXJmnhuGlJVEGKL5peeNbHUFdIlv4T/WGN+kBEMt0XAxAB2rKXWqiIxnKmMgx
 2XFzLcm8jhU+6unx7ymb6WF/YV3EqC6xSggomwdsEsYayzKW0ICwDTfhj5Nb30X0w9QnUY+ykf1
 z6786usD4vvG+ywLQzK/KMu/4JFbIAKA8Qs2yti6CyRP0fDyY/Wy30R2aXXUzyffQZmYwJk=
X-Received: by 2002:a05:600c:c177:b0:475:daa7:ec60 with SMTP id
 5b1f17b1804b1-477870b93bcmr61571145e9.21.1763031098726; 
 Thu, 13 Nov 2025 02:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwMEMEf3c6excHPCf9J8TLzB76o0b7MoBgGSaM9Ya9uFIQGkr+RtE4ZWvhrrra3dP1EsLivw==
X-Received: by 2002:a05:600c:c177:b0:475:daa7:ec60 with SMTP id
 5b1f17b1804b1-477870b93bcmr61570855e9.21.1763031098356; 
 Thu, 13 Nov 2025 02:51:38 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm61621245e9.13.2025.11.13.02.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 02:51:37 -0800 (PST)
Message-ID: <3d4cb40b-02c0-488b-93b4-abd26e53e16e@redhat.com>
Date: Thu, 13 Nov 2025 11:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] tests: move test_virt_gpu to share.linaro.org
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Woodhouse <dwmw2@infradead.org>,
 Ed Maste <emaste@freebsd.org>, qemu-stable@nongnu.org
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
 <20251113102525.1255370-13-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251113102525.1255370-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/11/2025 11.25, Alex Bennée wrote:
> Linaro are migrating file-hosting from the old NextCloud instance to
> another sharing site.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> 
> ---
> v2
>    - indentation for long lines
> ---
>   tests/functional/aarch64/test_virt_gpu.py | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
> index 4e50887c3e9..c26a1f20c65 100755
> --- a/tests/functional/aarch64/test_virt_gpu.py
> +++ b/tests/functional/aarch64/test_virt_gpu.py
> @@ -23,15 +23,11 @@
>   class Aarch64VirtGPUMachine(LinuxKernelTest):
>   
>       ASSET_VIRT_GPU_KERNEL = Asset(
> -        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
> -        'download?path=%2F&files='
> -        'Image.6.12.16.aarch64',
> +        'https://share.linaro.org/downloadFile?id=lL8wgnMmSXZo7Co',
>           '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec8b')
>   
>       ASSET_VIRT_GPU_ROOTFS = Asset(
> -        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
> -        'download?path=%2F&files='
> -        'rootfs.aarch64.ext2.zstd',
> +        'https://share.linaro.org/downloadFile?id=qOn1wbfKmS6KVHZ',
>           'd45118c899420b7e673f1539a37a35480134b3e36e3a59e2cb69b1781cbb14ef')

Reviewed-by: Thomas Huth <thuth@redhat.com>


