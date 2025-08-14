Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685D2CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 04:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umPyN-0008BW-0Q; Thu, 14 Aug 2025 00:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umPyF-0008AE-L9
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 00:53:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umPyC-0003Ul-MJ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 00:53:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso2335765e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 21:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755147221; x=1755752021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6fZZP6ymX2WMIe/roD72TD9wxwPXAzhkIwdUyU59JZk=;
 b=GzSk9LIWu//yZStjuuSxMrFs/ddFABqFAUoucQJ7I8z7gBFC2Kyk86g2sKDVG0BuEE
 8vDMH6M8dllhv5R2Ax0CeknHiJt6dposcR08imr3t5l0hQDEsIFq9zkis+fRo3SngquG
 jvdQLvtv5P0q+YzFLxOgKvfgtrGcpkHjnUxqwOqzQyvLaQOUesbvSv6vX0abKLsm7aqG
 EnwEt5DHBQVPSjG9Z2U1dFzv9dtfrkOsMpDxg0xXjiLF9tuxCaoJHb7zGQnYVa/lS5Yb
 ejHV+AnetC4rR/mMQCzv/jmHbtVIHo0lHtC0cqGG9HuEV9o79nJePevmnO9EuxHw9fFA
 YmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755147221; x=1755752021;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6fZZP6ymX2WMIe/roD72TD9wxwPXAzhkIwdUyU59JZk=;
 b=Hs3ZvuzLLgDaVqSEYicaXERGdrYzxYFybp831598w+RHdnXZShAT2S3hmgirYLoZ/2
 8Sg6NhzGFjy/PjkOndUdx2UEBTUvpD1Rc96uipgy0GPfPEp0LEdnFgA8kwp/eHihf+ib
 PHg8pT5Gje7wQkP5M+c5x2y/Wdu906k2IZeDL5Q5SpMox/kClzcTgfFuc/NwfFLqT+ht
 XfASynlj2XXCdSaMnVbbj2bJbSuOtzptj/zhUenzgxpjn8z191qbg75YLHDqIVuBZgDz
 9P5zEKB/M+oiTybegEpIKnEUOvhk9/lbe3sEo2r6L3WxPODeenH8/qmnfcZAOuc7cwM2
 +9kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ggjsBAp3D5CKh6aakBeudfdoCHHqmx0ynaqOwTVc6/T0FsPkUPBNuKCWLZXuBJ0mc5F0BGqekH68@nongnu.org
X-Gm-Message-State: AOJu0YyDw//kpusJdQxfGRl+Pr5fWeXUlpbzVVBm72Osmp45D9wFUynN
 5ExrvItrETMuf/+jSx0DP2GMCvcGHw2BFGrJv4CbrEXoDOcbc6sdbwn7PEUFWZDbN98=
X-Gm-Gg: ASbGncte3wEQIbkQCE5+gHHnyflaeu45vk99/T5Z6MovQyotSxRDh2Icj7DO/JLruV8
 6fP6OhZEnjYWpOSwwckuYYJO41pc6Z2/Ve2e+DW0tJV+BDdcs4xXKrEzGzj0Eldt5Kil3tNRiSB
 OcNKmxgfqAxwwcIZ8LOH8bQe1Ld7EhTtDsaLVdW3nKNbxKuQxsL5sj/ChXpoQbYb8/JoFqi0dpp
 KsTdEZtRXsuQt15Moppp0K4FWEo0SS8fwy/upB0nF/wGDYap9ypggrUkQUL208fF2OctRqdqcJ1
 JUpzxBKmvBbRRQ9cO7chwrJHmZ3arM1HmXjMmtyKnNoxLIvoMOZmk7WOhaBZbPnSCtTlFM/6Dih
 RBnInxXljVmQg2j6wR1oUjUyHdk+6rYu4N5CUrhC06rSK+S3aNM5acuTWVUZeCeu8DA==
X-Google-Smtp-Source: AGHT+IGdR73jSuUY2emv+/mlP42h1QCd5/8PmKe5jpuweh4XByr7SWS7DZdo3+UvJaz1cMn6/eXy5g==
X-Received: by 2002:a05:600c:b90:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-45a1b655872mr11163635e9.16.1755147220633; 
 Wed, 13 Aug 2025 21:53:40 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c70cb83sm5946515e9.27.2025.08.13.21.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 21:53:40 -0700 (PDT)
Message-ID: <8b2cd3c9-4795-47fc-a4ab-3c854c42b99d@linaro.org>
Date: Thu, 14 Aug 2025 06:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] virtio: move common part of _set_guest_notifier to
 generic code
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-8-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250813164856.950363-8-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Vladimir,

On 13/8/25 18:48, Vladimir Sementsov-Ogievskiy wrote:
> virtio-pci and virtio-mmiio handle config notifier equally but

Typo virtio-mmio.

> with different code (mmio adds a separate function, when pci
> use common function). Let's chose the more compact way (pci)
> and reuse it for mmio.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/virtio/virtio-mmio.c        | 41 +++++------------------------
>   hw/virtio/virtio-pci.c         | 34 +++---------------------
>   hw/virtio/virtio.c             | 48 +++++++++++++++++++++++++++++++---
>   include/hw/virtio/virtio-pci.h |  3 ---
>   include/hw/virtio/virtio.h     |  7 +++--
>   5 files changed, 58 insertions(+), 75 deletions(-)


> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9a81ad912e..7880c3bcd9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c


> +static void virtio_pci_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> +                                                     VirtQueue *vq,
> +                                                     int n, bool assign,
> +                                                     bool with_irqfd)
> +{
> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> +        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
> +    } else {
> +        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
> +    }
> +}
> +
> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
> +                                    bool with_irqfd)
> +{
> +    VirtQueue *vq = NULL;
> +    EventNotifier *notifier = NULL;
> +
> +    if (n == VIRTIO_CONFIG_IRQ_IDX) {
> +        notifier = virtio_config_get_guest_notifier(vdev);
> +    } else {
> +        vq = virtio_get_queue(vdev, n);
> +        notifier = virtio_queue_get_guest_notifier(vq);
> +    }
> +
> +    if (assign) {
> +        int r = event_notifier_init(notifier, 0);
> +        if (r < 0) {
> +            return r;
> +        }
> +        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
> +    } else {
> +        virtio_pci_set_guest_notifier_fd_handler(vdev, vq, n, false,
> +                                                 with_irqfd);
> +        event_notifier_cleanup(notifier);
> +    }
> +
> +    return 0;
> +}


> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c594764f23..8b9db08ddf 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h


> -void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
> -                                                 bool assign, bool with_irqfd);
> +
> +int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
> +                                    bool with_irqfd);

Please add a @docstring to document (@n in particular).

Thanks,

Phil.

