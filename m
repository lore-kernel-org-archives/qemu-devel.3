Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DCCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yb2-0000t3-Ak; Tue, 23 Sep 2025 04:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yaw-0000qT-To
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:41:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yaO-0004Y3-W4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:41:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e21249891so1885675e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758616876; x=1759221676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FFV2TZD4LmDBMCx714g48Anet9pQr3NqLj1QhEtzhr8=;
 b=VPRl0uuzh6wPKywoz8jCsGttMgL3qW6tkhgGQmWWb/kOB3Gv8zTbS2vOmFn2vMBAcO
 vXV/QyncG3k0KgfGACXn+nOQwNICNtLdygHWeRl2iLSGnwovrVEymGRiKMbuRuXEIP9l
 1z7I3A1g8aeTBBKxShz26NBhSh3Xbb48XiQTZ0aySZcnSAdBmvsj4XQjIw/GjjkIMI6H
 7xSk1cdKrjNNBtXk8YEQNwaAsIp4Z9J5gJUSdGqMDAIcP2JaZA6//WiKaXQj0vo0yOeq
 m/huc6nR5WhC07zKhGOvKAbXE4Mdlz+C2rGdMtL2QRkMmDIrjjmPvj10+htwmArKN17U
 74Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758616876; x=1759221676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FFV2TZD4LmDBMCx714g48Anet9pQr3NqLj1QhEtzhr8=;
 b=cPcfscc8LYpkfYpVK4BLXtoxV+fN44LrNcGykclgN31kfx5N6RvXBXfFlf/x0m/ckz
 k5lNwNDcM04Xpck9pZq/yCByP35fFgq3Eq9BmPcQwcLSK9kjT1H5LAl1sMibxd6vKtUo
 fIdSBpAL527uN0qVWVlNtzncUKivYjyfSguK/d4rneYq3I5khVpwe9k8Wvql96YFVFqm
 TQEOhRc8n0rdDKyrKKhf9TIyfklp2g7vZCpm2F/RRL1laIXB0OuXRvfGMcc2kbn+jd6S
 0NuPfhIOqkgWEqF+no2mpb7XpI1YaRPvfv+ZxaHz0Xh7pG29S3JDgfKUNBAb1ngVJGCM
 TgWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzXxFL+l5aOcItAfDEAa+BRpgrDF5BREcPL2ekbGHRCxLpLDS+0pEZ7kT7h9Tb6oXp6SC7du9dgGn8@nongnu.org
X-Gm-Message-State: AOJu0YzJLAPLmfmEeq6J6U4pivCEeRVOaeyOrjqscRkkzZ8qTC0DAXb1
 E4/7wxh2qhNjZ3NSpjdFPwUvSNX+RHZtx53mlI8Gnjd4hbCmSbwjK/HQcFkiofqjWdA=
X-Gm-Gg: ASbGnctZpg6ogMcUY1U0F4/VqEZIzHElltcjtitcS2y6gh3BGxQnEG4rtXPyN/4RNUB
 nj+7ksfusgMvfTP6KjpYy+wlFM3QjIs0iHIuLZDIRYc8S5+kqzaoth5ZUlFXt1c74K3HPI06YM7
 BwwjKAy1DkoFEb9toJRPuw1iUFh+SAtX33LKSl+sIP8wF5LK1BOwKt2WRTiGekC2uDvw19Wgak6
 YGFZX93OK1jDJ2BrzZsw/ujNzeII9+iHTgddPi7xEZFoOx9HbB1XkSfEfblg/4NMRsR6nSVG4sC
 BbJDw0tPMKv+JnidzEvIR37KZd2jEWbkG1S0lc8GJLIzts8bpsZ8QJQgHTtLmWmCnIv30v9MBzH
 HpzK9fzZqtrbaUNaePvWlzaOjf3c4LqHDO2nf+VRxqxfkORSBsjEDYjFR82Ib8RMMRQ==
X-Google-Smtp-Source: AGHT+IEJHE55spX4a8F820hZCWsJVa9MYspSrP4S4v24LutJl1X2jsGQAF2oknN7IZNh/NEw0d2Xlg==
X-Received: by 2002:a05:600c:1d0d:b0:45b:8b3e:9f66 with SMTP id
 5b1f17b1804b1-46e1d98bfb7mr13583375e9.13.1758616875836; 
 Tue, 23 Sep 2025 01:41:15 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1dab52d7sm10745795e9.2.2025.09.23.01.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 01:41:15 -0700 (PDT)
Message-ID: <b21c0cac-b998-4404-a558-453c62668bbd@linaro.org>
Date: Tue, 23 Sep 2025 10:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] virtio: unify virtio_notify_irqfd() and
 virtio_notify()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
 <20250922220149.498967-3-stefanha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250922220149.498967-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/9/25 00:01, Stefan Hajnoczi wrote:
> The difference between these two functions:
> - virtio_notify() uses the interrupt code path (MSI or classic IRQs)
> - virtio_notify_irqfd() uses guest notifiers (irqfds)
> 
> virtio_notify() can only be called with the BQL held because the
> interrupt code path requires the BQL. Device models use
> virtio_notify_irqfd() from IOThreads since the BQL is not held.
> 
> The two functions can be unified by pushing down the if
> (qemu_in_iothread()) check from virtio-blk and virtio-scsi into core
> virtio code. This is in preparation for the next commit that will add
> irqfd support to virtio_notify_config() and where it's unattractive to
> introduce another irqfd-only API for device model callers.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/hw/virtio/virtio.h |  1 -
>   hw/block/virtio-blk.c      |  6 +-----
>   hw/scsi/virtio-scsi.c      |  6 +-----
>   hw/virtio/virtio.c         | 28 +++++++++++++---------------
>   hw/virtio/trace-events     |  1 -
>   5 files changed, 15 insertions(+), 27 deletions(-)

Nice cleanup.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


