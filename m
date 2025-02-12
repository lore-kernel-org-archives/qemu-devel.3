Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAA8C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti93Q-0001s6-2T; Wed, 12 Feb 2025 04:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ti93O-0001rd-83
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:29:10 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ti93J-0001RZ-BX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:29:09 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso10386945ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1739352537; x=1739957337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wgX6nmIL24Hdl4P0VZKRrax5AthdWjzZFI94BuNDxrE=;
 b=M/obVQMfl6HqbVFQCmHk8cLUzcox4sdpf4F306Axqyqbf7AjBiug0aMZELOyBo/Lqp
 wgByBd8KcgOm8qpiOzKmG5AexqRdi7ucKKRrs/FR/9h7dZWcYBI+qfP+gLJjTR4V405r
 JpWABZyc8itkYrRp9AySlF/HEi5OIs+ae0EqWrCh/48V6dv1w3ww++lZDZJ/M8l3pmnW
 /GcYWmHBIVk9PDqJpH/J0KPGkE/KMHcIGslHCpm2hvx1sFXhKaaB8Kje3Ex/KMv4BPIa
 C97KHTSqU5lIJ5ekxhCLRZwkGdmqj/e+XLIr500wm+KFMZ73AKl+W+xx1XMrqdsYYemR
 /SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739352537; x=1739957337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wgX6nmIL24Hdl4P0VZKRrax5AthdWjzZFI94BuNDxrE=;
 b=u4eVLXI8VuacR0qmxfSeBhVBP02Ya8jcr45zVizrDvBUhO6OQr9go2al8gvXERc7gm
 sI4LS5vXgQWtTJ+LuEETpJnup5Juc8RyxPKUU0KTswNe2N+y0NPlSAfqg+c01gdZQum+
 sschrgu45VjySWEmS9oSnUHzZOlarfLulBe1aMVSs/2cyI9W2GRJe4n71MMEHhO3v1pe
 s/MPhcdFB/2pAIK+qhYmK+/rWs4kfCAI16fM5FqhQhaCp30TUyCvnxq2EfkmKNSgXqCC
 2ftE6yCC/Drc8ziWz81+eFOEjNUpj9axmPmUQmPO98jN8Hbt0vfh9C62eJemBSBhdFat
 Mb4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfG+UIx1tgnx6aKIf8uB68/KBza+sA+1oZytvzzMvDvJsysNuDTVNubntp3015y6+GZgG4JPcLMltf@nongnu.org
X-Gm-Message-State: AOJu0YyNDMgeDwDHPpbRal2q3I0XE3P8Gy8+oQ82ohG5iXw1jQNmA4/X
 ioD6q81p8SkXCra7yKpuSO8kaERqHlCc0HmltCRqRbGIcbZ67qdtB6OCFSBJq+Y=
X-Gm-Gg: ASbGncuNHb96xjutn5Q1PIP049G22ZXaJbkHAsC18jiWH+7dwo6boKnSshQI8oWOYeO
 UasYJGzsQd66by4eboiE7UcIZo4qZkdFFH9ZoBINJhX3jQNA8PZmIHFfWBM5PuoH/JvcMeQMIwB
 qbVV6CUhzfyUmRl6WmoRiQDsUALBM8oHeCoaYAZnVMUnSEFQm5fAs2VxLJj3+PJzBUd85eANVGf
 hlA+B/rqOxijJYAWC+Qjhh2IvAM7n3WRJjE8jYdFj8IuFYp3XTBCdbhGEtUb3Q+oter39lcc81G
 D0vnbqx+N7YK1bFSDIVK+w==
X-Google-Smtp-Source: AGHT+IE3Q6Lj+7HXjInoEZXvEGP5hq47jecuWChnSwhfdjqNmgG/FvxqT0IqKaCU8g6+cjp6ZpxLmg==
X-Received: by 2002:a17:902:e74f:b0:21f:3a7b:f4e6 with SMTP id
 d9443c01a7336-21fb6f54801mr116543255ad.23.1739352537368; 
 Wed, 12 Feb 2025 01:28:57 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad546b381d8sm6375546a12.1.2025.02.12.01.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 01:28:56 -0800 (PST)
Message-ID: <afe6b1a0-eb09-4760-b7f7-e09d6793d04b@bytedance.com>
Date: Wed, 12 Feb 2025 17:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cryptodev/vhost: allocate CryptoDevBackendVhost using
 g_mem0()
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 myluo24@m.fudan.edu.cn
References: <20250211135523.101203-1-sgarzare@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20250211135523.101203-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Acked-by: zhenwei pi <pizhenwei@bytedance.com>

On 2/11/25 21:55, Stefano Garzarella wrote:
> The function `vhost_dev_init()` expects the `struct vhost_dev`
> (passed as a parameter) to be fully initialized. This is important
> because some parts of the code check whether `vhost_dev->config_ops`
> is NULL to determine if it has been set (e.g. later via
> `vhost_dev_set_config_notifier`).
> 
> To ensure this initialization, it’s better to allocate the entire
> `CryptoDevBackendVhost` structure (which includes `vhost_dev`) using
> `g_mem0()`, following the same approach used for other vhost devices,
> such as in `vhost_net_init()`.
> 
> Fixes: 042cea274c ("cryptodev: add vhost-user as a new cryptodev backend")
> Cc: qemu-stable@nongnu.org
> Reported-by: myluo24@m.fudan.edu.cn
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   backends/cryptodev-vhost.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index 8718c97326..943680a23a 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -53,7 +53,7 @@ cryptodev_vhost_init(
>       CryptoDevBackendVhost *crypto;
>       Error *local_err = NULL;
>   
> -    crypto = g_new(CryptoDevBackendVhost, 1);
> +    crypto = g_new0(CryptoDevBackendVhost, 1);
>       crypto->dev.max_queues = 1;
>       crypto->dev.nvqs = 1;
>       crypto->dev.vqs = crypto->vqs;


