Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B93DD1D899
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4m9-0002he-Hy; Thu, 04 Dec 2025 03:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4m8-0002g2-9J
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:33:20 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4m6-0005HA-MI
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:33:20 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso267083f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837197; x=1765441997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJX5Pe6wezJ1mmJa4qbgX9m50EUjiTLmApadCeMPCcQ=;
 b=yPIsvEZl9Vvi3+ooqxDZh7ql6T1NSZiufawuskLwIJJylI+ubKGqXL9H/pNwIrQ2eF
 7ZzmcpDsvmVIkkmDlNn9zUQizX1JVqNJf4ptiBIDXW3uqG626ZiT1Iv9IXD4RJcAU+4Y
 3KgTBd0dZKdsRxPKvUVg7JBzPJJdveGPcwSdJyCJ6ybWAhivJIRNinB13z9ky6IAyVHV
 YdGhwmcWuvcpFQuGFSQrYrEpaQmdzb6vgRNrCjobvs8OE6H3zKiJ1FkZNTUxdVT2UgzC
 oQRATcrONhmuZDyKGl9qpYjGEwfejwl/viOH0oeRH9nH5gFmM9681hjcoTx3kSrBLaWc
 15nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837197; x=1765441997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fJX5Pe6wezJ1mmJa4qbgX9m50EUjiTLmApadCeMPCcQ=;
 b=a9Uq3EVZ2jRUodu8v8hhdPzb8opMQ3IwyJI7iIda9tixOD9NVuqAX/VWM95Dp+VL21
 a1VXB64cnhZAUEkCMMZACY4j/sRi+6BLtIZcUlMsM2AVQF2ioChMlaqzJhMeyGkaQfAZ
 plTH/z7gytjqh2A/Remcw7QTfJZFj1xeMbkjyuPSiMPsatu8dxAlOn3loUSRzqmZIV2I
 d63EGTK+1rKocK6l/TYOs/psXXZ7Bm7NJwRjwQ6POJldqShtYk88khjQ+snAvdRg5RMW
 t1mXTeBA1Mst0T5zO5p+QQPoUasxzt1Wfg9n2xmTjlem7c9wIw+SvkiVXjwAZwE/jOnJ
 s8wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbr7ov4djAWdc6E3zq8l1BRUusLDPhzC88kqn4sfcygEgmSnCH0xGJArdbdfJijw1FiWMEriz35Qcl@nongnu.org
X-Gm-Message-State: AOJu0YwVhujCxhM2jGuup9PGJf/qx94QdZfKuJIF9gnAwEzzr4jsoX/M
 kKchZT2Wk5YUlfe+UGfIOx+z/f1PW1lZoRRFOU7b/2KDTZgBCo2zKp4g5rrX35Gvw0/2zQNDzNy
 fA5SrgV0=
X-Gm-Gg: ASbGncvrtwBJjdMtK//NvnA2ML1tYnp6/YbUcsaNr5RcyPE4udMPnrMVRiyEg7eXIZl
 8kBcfHFYn0YxwyGvDgYNmK551RPMgOuGM1mibnjXKXIgoAFlu3wU/tzYPtm2cSpAiTfLpmagn7o
 2xzjPxwwR9tr16XNiBa9xNuiQCnTZ5s+Qz5vUq3CKxkVqeK5YaVhGgsvbb26m9sscVcF/f8NM/x
 Bh3Ii4XVMuiGS3R7++8Ik67j56jw0dWzTFxT0ettYD0SChA/ksEetd9mdRoGvZ0P+pId4jRKOym
 HGHvdj/eqWIVV/LcL0mmCfs40l/GSxeF0RJ4Mfdvo6Mv7jroO9KzwEFX4KA/79iUykF6O2TxHCv
 fpsiAMhAPFJ8lXSEMTTXLX0SRyMFDjPaciUdmX6CnADZ/6uMbhJ1C8zKcRgmDpjeV1IUEjfMxcr
 aaM2IHMLt3BNh01z36GN33sc4UsfPnv2XkWboCmaecuUqetGgGmHdViokzKP4j1Z9G
X-Google-Smtp-Source: AGHT+IGAxE1q4QFQrItK3K8YQZwF+JWUGCFOT2ZhuCLCeCfxb06R84rTtFd0xvwtW7eBWoPRN/A0Vw==
X-Received: by 2002:a05:6000:1ac6:b0:42b:2e65:655e with SMTP id
 ffacd0b85a97d-42f79853cfamr1856796f8f.27.1764837197020; 
 Thu, 04 Dec 2025 00:33:17 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d3319ccsm1796529f8f.34.2025.12.04.00.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:33:16 -0800 (PST)
Message-ID: <f9a66aaf-14f1-43e6-85ec-2186f9b7d78d@linaro.org>
Date: Thu, 4 Dec 2025 09:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: extract include/qemu/aiocb.h out of
 include/block/aio.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203185133.2458207-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 3/12/25 19:51, Paolo Bonzini wrote:
> Create a new header corresponding to functions defined in
> util/aiocb.c, and include it whenever AIOCBs are used but
> AioContext is not.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   fsdev/qemu-fsdev-throttle.h        |  1 -
>   include/block/aio.h                | 21 -----------------
>   include/block/block-global-state.h |  1 +
>   include/block/block-io.h           |  1 +
>   include/block/block_int-common.h   |  2 +-
>   include/block/raw-aio.h            |  1 +
>   include/block/thread-pool.h        |  1 +
>   include/hw/ide/ide-dma.h           |  2 +-
>   include/hw/scsi/scsi.h             |  1 +
>   include/qemu/aiocb.h               | 38 ++++++++++++++++++++++++++++++
>   include/qemu/job.h                 |  1 +
>   include/qemu/throttle.h            |  1 +
>   block/win32-aio.c                  |  1 +
>   hw/core/ptimer.c                   |  1 -
>   hw/misc/i2c-echo.c                 |  1 -
>   hw/virtio/virtio-pmem.c            |  1 -
>   scsi/qemu-pr-helper.c              |  1 -
>   tests/unit/test-thread-pool.c      |  1 +
>   ui/input-linux.c                   |  1 -
>   ui/vnc-jobs.c                      |  1 -
>   util/aiocb.c                       |  2 +-
>   21 files changed, 50 insertions(+), 31 deletions(-)
>   create mode 100644 include/qemu/aiocb.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


