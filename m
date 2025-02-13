Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF31BC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaol-0000fl-NZ; Thu, 13 Feb 2025 10:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaoj-0000fb-9S
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:07:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaoh-0005Pn-9i
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:07:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38ddfee3ba9so787437f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739459269; x=1740064069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tcce55N5y6YNssmdnVHH6oVtRnzEk4ZqhRGcS6wjB6w=;
 b=m4knYR1reQR/VovORzJRn/XIkThHFnPB8fyIPdI4P/Em7H+r3nUH2mSnq2R6GWbsm5
 qY4b5tP5Waw3viWAET0SpWOgAoXoAORQmGwyuue+FBmZYkVRWu36zTur1sMGpCPR6Vgl
 4De/cTTzOOPy0WuhDsXbrx1fPNTfBtIGpRmdEhxmYQx5XjPKNvE9js0mgS0quV0ekbou
 NjStGOmFqgWaCA7i8jQbj2TMebT/nv9cFeZ5Izk5ZQZBKMJXzN4c6Hy4U4duXhYy/N3p
 HBxxeylDzoLTG2jO16m03wiaT0xfypo37i1UQmaVcbgRrJYBFRSPCrqBSqpQS14UzGY8
 obsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739459269; x=1740064069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tcce55N5y6YNssmdnVHH6oVtRnzEk4ZqhRGcS6wjB6w=;
 b=H4H0kmqBxLrc0PmnES0LJWi/r2sVe0V0tV2VpSvtlOVvq09MB68FriTYMvSHuOzL7l
 KQhW4ZYZ6Tzc8rdDXz42bKYJJeUNTI8mlPfBUPoD2T/oko285BSDAfAjXvahrcP8Y75w
 Ww2h4/YFPDwc5dpUo5GEPBpWTZUpKiLv+Sr4UooPHwj4joiJ+eWX+kixCTyclNlOqyOD
 7dD6rRSdz98cZQWl0hSpnnLrhvRraLAr2VBaJ8G9QwcP/9aKq0yecXKw6yCafc1IBH2X
 lTT9Nf7s++OZu30TyXZCxlSXwecXpuYMaFibQMGVFX98y5++aaie5LHPhY9hgqDJKPdk
 xchA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBj6wboHSPFYNi8LI37UkK4l+yS1crAzY4RDPq+2MDKhIKwUr7/ADYvxBk5tU9eYcosA6GiHfoCJMl@nongnu.org
X-Gm-Message-State: AOJu0YyjbxaA8Y7yQ7HgIXMtnfSJMNXRPjFmQJtrZ+55JZYz9zuvDWdP
 CH2EnWfCTxC+wZALLeYERRmXbwP42WDA6OYSgB5qqyCxL9I3nUp9qfhfihSeaYU=
X-Gm-Gg: ASbGncuB3ESbVm4N1a2wB+Jol0bEYHDic085ad20kGDzdNlJcW6say6YCxMGJ6DkNlq
 +qfEkcRrZ1Bc92uXeJyAoWOPnB2/EfJdfgRXUrwkxWUoibzS+RypqEFVUC/W9llXlIvzFwWXNkV
 pYJ7dMJMXO28aNBVbzX3ipkZMwlb9DZVV4uv564Yu3jr05PfQFhIa+VvvSZYqyngNquoAO0MnBM
 GJPuzAAN+kITMmN6HgB9t9qhFDeQythH4adBatv6OvTLNSzkeVxg0JJsy4IyYvC339LY47Gpf7s
 OqUz/sZemPlkESRvveGI7CCSpS8a/Pt/K23fyec/oC/C5Eu1Z8tN0HhZADs8mXgTrNQaF5PDHg=
 =
X-Google-Smtp-Source: AGHT+IEJBd9ObTUC2oJsDrZPqfeK4sKyF/Dk74TaIip3YTVmOeXNJnEwlrsteCf1ERyARBkAtjdGug==
X-Received: by 2002:a5d:5986:0:b0:38f:2224:738e with SMTP id
 ffacd0b85a97d-38f22247752mr5404961f8f.1.1739459269024; 
 Thu, 13 Feb 2025 07:07:49 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4335sm2191534f8f.15.2025.02.13.07.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:07:48 -0800 (PST)
Message-ID: <bc05ff1c-94ce-4877-9b8f-9fb909cd67a3@linaro.org>
Date: Thu, 13 Feb 2025 16:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250213132513.767709-1-mvaralar@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250213132513.767709-1-mvaralar@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/2/25 14:25, Matias Ezequiel Vara Larsen wrote:
> Use virtio_get_config_size() rather than sizeof(struct
> virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> The frontend shall rely on device features for the size of the device
> configuration space. This fixes an issue introduced by commit ab0c7fb2
> in which the optional field `control` is added to the virtio_snd_config
> structure. This breaks vhost-user-device backends that do not implement
> the `controls` field.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
>   hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)

¡¡Bien ahí!!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


