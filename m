Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF83C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x009k-0001tg-7L; Fri, 28 Aug 2026 13:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1x009i-0001tY-On
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:14:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1x009g-0005Ck-UY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:14:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cace91f112so9944525ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787937255; x=1788542055; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D0Igx0/EgfvKPNBjSleMBeir+jf0sAhYiz8X4HLghcU=;
 b=RQVrIhH44U4TcvNu5p4RSUk5b3dmBPJWDq9gwXKw/aSS2J+VDcXqGpliUF+oqV2+c+
 NmHjv+LknYzG1Jlid/FZmp+7527wsYBhzSbCJkGMAGJ4XpuLll50PlAiAYhb0CV2Qi9C
 O85WYOkC8cTWuPoFjQEQi+lqwbmP7ID48bnByjYLBqQo/D5IAZTaz+8lgUmxdQSRbvtG
 YnHxZSNJMRLmcFA7FqNU2Gzh1+BoOmUemRE4c2QxNhQ/QVDJhxgfg/z43BaO1+rl+FX7
 8Ulaf8zMqn++BhYqz/x1AvAt+Snr8bPtlSKx2ivHUbFfZ8j6YsEICSla3CpYa2cprSR1
 e5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787937255; x=1788542055;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D0Igx0/EgfvKPNBjSleMBeir+jf0sAhYiz8X4HLghcU=;
 b=YDzUFtFkiSQ1SlSXW+3tRdRU1RXpKSyKgVx8paokDUmKrUPYdHy+v7cGZK/9yvPNiQ
 cBr1nPIMxFK0Hk+P+9n4hYCU1IfE3R7UyNwheXKD7G0h/n62AF0nR4eX5DoEQMt4szsx
 iYexpKzc9U/weu0DTfxpAr+99+4haxWw+HrR4q0Rsrk6vHcY+g5yFq0j2w9efnalAD4m
 dtFHz85Fz9ax1xGMc1rt124V63mNYu9idwn0oLQi95lIG6KiwbjbWzkz970eyJOgMsGC
 y4RjkIu28SM4F8JY7CM6ovCEZsCdKKRbvmRrzhYPWJUwMx0YL9DxfQLcU4wUrx6pa4Bj
 mD9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzK5RVwo0zhsBRISHzJeXxOFohOMWqiVQ1aAKZJ4qBZgOnY4dtrRNRiEOUdYOHFpBflcl8Z8EpfCWsb@nongnu.org
X-Gm-Message-State: AFuF++mF0RYqSGzw64SW+s8EPqs47JWGgptEDxg/SHHwf+/3qyQ7SEos
 rtewRDY4qIfIssc2SzjmZY3gLbyaiYqzctRebqkDB/cQE0CQFs8iNvhU/IlRKg==
X-Gm-Gg: AYBFou1SoDT27wibC/Dxl5kTWi0FbogJQ53HC+i9RPCNaU6olIXa/yY86T5Y2zPqzhK
 1HMcWWVN4KR+q0GEi4WvyNmvHhD1c2EqKREyJKwrvTLOV2egl3Qg8yisJD1+D4DIATYdYDsCewd
 OTW2tky30QepsEfvC+JwpY8+nJSpVnOypCK2EMAQ9y0rHWrck8Gn3ExcJ1rJZ/JV7iKkO3ypktF
 nd3szh/PCiKc/R1WrmAskgH0RG0lSxjAXFqT4GtXMboWY0J5gCAasrZYvSoNH61XLLmU4Vxc4gD
 lLK0x3dB1yVhm+wVzqz5e7f+Q9VLph3R8pJkhmzpXVPfAYaNNhpnByDP6hnHQ10tbVjnpDnVqhy
 16rvueBHiElDbDz+GIDpjYtn13nQT3YHCYLH1MkIOodE59yupQXa19MMdx81apP5fJyRGkxDwAN
 nyKlWIj/T5ui6B6kjxfGdFiktv1gfhLK/1U6XbUjdPQr1kSPMf/TDlKwCZi56C4j4EiUdLEQ1kQ
 3wsB+lbDWMSmyzTidEhzOnNGqC24ZHcccM+23lnBQ==
X-Received: by 2002:a17:903:1590:b0:2d8:d4dd:24c1 with SMTP id
 d9443c01a7336-2d8d4dd25e1mr18252505ad.22.1787937255158; 
 Fri, 28 Aug 2026 10:14:15 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:5332:3f25:3b45:eb00?
 ([2400:4050:b783:b00:5332:3f25:3b45:eb00])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7598b8f5esm7839285ad.75.2026.08.28.10.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 10:14:14 -0700 (PDT)
Message-ID: <19e79fe1-1240-4afe-a79f-c7b476c0f074@gmail.com>
Date: Sat, 29 Aug 2026 02:14:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: set share_handle for udmabuf blob
 resources
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260827071013.2876553-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20260827071013.2876553-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/08/27 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When a blob resource is backed by udmabuf, the dmabuf fd was never
> propagated to res->share_handle. This meant the D-Bus display
> listener could not share the buffer mapping with remote clients,
> falling back to copying pixel data instead.
> 
> Set share_handle to the dmabuf fd after successful udmabuf creation,
> and reset it to SHAREABLE_NONE on teardown.
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Please add:
Fixes: 5f899c34af1d ("virtio-gpu: allocate shareable 2d resources on 
!win32")

With the Fixes tag:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> ---
>   hw/display/virtio-gpu-udmabuf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index c230509852ff..5d6daa1f7afc 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -91,6 +91,7 @@ static void virtio_gpu_destroy_udmabuf(struct virtio_gpu_simple_resource *res)
>       if (res->dmabuf_fd >= 0) {
>           close(res->dmabuf_fd);
>           res->dmabuf_fd = -1;
> +        res->share_handle = SHAREABLE_NONE;
>       }
>   }
>   
> @@ -149,6 +150,7 @@ bool virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>               virtio_gpu_destroy_udmabuf(res);
>               return false;
>           }
> +        res->share_handle = res->dmabuf_fd;
>           pdata = res->remapped;
>       }
>   
> @@ -182,6 +184,7 @@ void virtio_gpu_fini_udmabuf(VirtIOGPU *g, struct virtio_gpu_simple_resource *re
>               res->dmabuf_fd != -1) {
>               qemu_dmabuf_close(dmabuf->buf);
>               res->dmabuf_fd = -1;
> +            res->share_handle = SHAREABLE_NONE;
>           }
>       }
>   


