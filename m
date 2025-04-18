Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B1C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 14:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5n3n-00066L-T2; Fri, 18 Apr 2025 10:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5n3k-00065D-VP
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:51:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5n3W-0002PJ-Px
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:51:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso16956715e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744987852; x=1745592652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/lqzil4Y8RXkEgnQIabhU/geqAiy8/bLIvMU3z8LKlM=;
 b=L8jcZg8gXr68w0Rjkedcuae7sIUObz1a42Hb7umPb8YJ6o5oYqNN4B3hx8qWp9O3Jf
 yJ9rVT1ktc6NYKndgpR9l4QBxg/rKOZ2FWRQqqIbCtRYSfpwr7vuZfDP9Vj45IdzPGDW
 7loWZaPo/oaI6WU5/Q5F1hq5bk9fVb+ylx6cVpmSK+MpNCCmY/OBk/+LAJKWgJlLJmgE
 f5jrn/JK1BlKpq+DbV21DIvk4p46fSCP7Gp/lE1dWFZkqwWDAMWPNVQSWsVH5jZ24OIZ
 9MNm5WXswvuDRZ+toyPdNmL8RpiD5uOr7PRE4MhbePP7SKZKIIkHPFub/QxpvS4pGa+h
 ReZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744987852; x=1745592652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/lqzil4Y8RXkEgnQIabhU/geqAiy8/bLIvMU3z8LKlM=;
 b=qBE6EhtQaSvNn83+LVSnj0tolC0C9FWXgw+oWlU/flY4FGw4cQEn5XN1g8Y/GxOMgE
 MOZqMq0Xul2wKraZgv/Utu0QoQLr3KvgGGdyRFbWnqV+L/hCaTz67u5Eg8fLZmmzSf+O
 89TNZBWS6GqL+CwlSc7EPxDQLh6m6FrHT5IZKfsRhUsWy+eC3wy5v2wEW+w6+8R66llz
 w2RFMBoajeeFLbwBSh6it0QlHY5bxgSx65cknv0biTe+7V2+p7hIm5Nyhgju8PMUhfs8
 zWaLQ9cHcDvVzkizhrYjnHDQ6Zk2//cSNJ9lN/faBhvmYGxdC8kHmE7P1+VQKyfz6XeT
 KliA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu3LLIVTQ+l8HPH8r0JeTQo/Ym94N1Zv0LtFzWymQ1p/rdROitTK6HKGKrdw1KEnNJ6ecyX6wVV85Z@nongnu.org
X-Gm-Message-State: AOJu0YxPvEscW7xmU9umP+sqCsQKbRUU9ML6FqFdNCVEbos7OdEr1lQU
 vwxcjBBiV3fBv8/IXbGqFi/j27AjDLzfGAXOUTTNfqoKBdS1fFeJTVofih2LZvU=
X-Gm-Gg: ASbGncsAV/KVKee6kVFjOUlatvSdGc+L6XAG8M3TE0A4d3iJ3F6qjfuHzez+GWTYERV
 9I2NAW1o3jDd25PCfPZ39jQLBMlzEwVRipnXiZXZIhz6tg1UhbpwIa09kbMZfyAug8o1S2m/2Fw
 C7RTWbCuGcJhIHaDCESrGfgcXxwC0OabdgbfHi30pW1emj6ZIsuSSOjNWG8g8vSQXfIKa2fVD/w
 e/pyki44/GbpFwK4EgOSjDCqVvh2EqZaV4ErtmxzWf94jfjRFnu6M9kN0LUF5tBH01AoZoixFeQ
 H7QsA79CcaCDDzz0uXEsydqOKRY0QM3gaCrqfjJKeXgiC4+HQVpwIobpG35BLSC2LUKqVgSI94+
 tREKc9QaK
X-Google-Smtp-Source: AGHT+IFSSNUz+77pLFm39KcjmqOjRddD73t5iN8GR2onFFwFKTd9Ek37FeK0HwJAvETKQakiWzSlpQ==
X-Received: by 2002:a05:600c:548e:b0:440:6a5f:c31f with SMTP id
 5b1f17b1804b1-4406ab93420mr24753555e9.11.1744987851826; 
 Fri, 18 Apr 2025 07:50:51 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acca9sm24844765e9.12.2025.04.18.07.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 07:50:51 -0700 (PDT)
Message-ID: <918f450d-a5fe-4e3d-9320-950485352b86@linaro.org>
Date: Fri, 18 Apr 2025 16:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io: Set unix socket buffers on macOS
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Jones <rjones@redhat.com>, Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250418142436.6121-1-nirsof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250418142436.6121-1-nirsof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Nir,

On 18/4/25 16:24, Nir Soffer wrote:
> Testing with qemu-nbd shows that computing a hash of an image via
> qemu-nbd is 5-7 times faster with this change.
> 
> Tested with 2 qemu-nbd processes:
> 
>      $ ./qemu-nbd-after -r -t -e 0 -f raw -k /tmp/after.sock /var/tmp/bench/data-10g.img &
>      $ ./qemu-nbd-before -r -t -e 0 -f raw -k /tmp/before.sock /var/tmp/bench/data-10g.img &
> 
> With nbdcopy, using 4 NBD connections:
> 
>      $ hyperfine -w 3 "./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/before.sock' null:"
>                       "./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/after.sock' null:"
>      Benchmark 1: ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/before.sock' null:
>        Time (mean ± σ):      8.670 s ±  0.025 s    [User: 5.670 s, System: 7.113 s]
>        Range (min … max):    8.620 s …  8.703 s    10 runs
> 
>      Benchmark 2: ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/after.sock' null:
>        Time (mean ± σ):      1.839 s ±  0.008 s    [User: 4.651 s, System: 1.882 s]
>        Range (min … max):    1.830 s …  1.853 s    10 runs
> 
>      Summary
>        ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/after.sock' null: ran
>          4.72 ± 0.02 times faster than ./nbdcopy --blkhash 'nbd+unix:///?socket=/tmp/before.sock' null:
> 
> With blksum, using one NBD connection:
> 
>      $ hyperfine -w 3 "blksum 'nbd+unix:///?socket=/tmp/before.sock'" \
>                       "blksum 'nbd+unix:///?socket=/tmp/after.sock'"
>      Benchmark 1: blksum 'nbd+unix:///?socket=/tmp/before.sock'
>        Time (mean ± σ):     13.606 s ±  0.081 s    [User: 5.799 s, System: 6.231 s]
>        Range (min … max):   13.516 s … 13.785 s    10 runs
> 
>      Benchmark 2: blksum 'nbd+unix:///?socket=/tmp/after.sock'
>        Time (mean ± σ):      1.946 s ±  0.017 s    [User: 4.541 s, System: 1.481 s]
>        Range (min … max):    1.912 s …  1.979 s    10 runs
> 
>      Summary
>        blksum 'nbd+unix:///?socket=/tmp/after.sock' ran
>          6.99 ± 0.07 times faster than blksum 'nbd+unix:///?socket=/tmp/before.sock'
> 
> This will improve other usage of unix domain sockets on macOS, I tested
> only qemu-nbd.
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>   io/channel-socket.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..b858659764 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -410,6 +410,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>       }
>   #endif /* WIN32 */
>   
> +#if __APPLE__
> +    /* On macOS we need to tune unix domain socket buffer for best performance.
> +     * Apple recommends sizing the receive buffer at 4 times the size of the
> +     * send buffer.
> +     */
> +    if (cioc->localAddr.ss_family == AF_UNIX) {
> +        const int sndbuf_size = 1024 * 1024;

Please add a definition instead of magic value, i.e.:

   #define SOCKET_SEND_BUFSIZE  (1 * MiB)

BTW in test_io_channel_set_socket_bufs() we use 64 KiB, why 1 MiB?

> +        const int rcvbuf_size = 4 * sndbuf_size;
> +        setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, sizeof(sndbuf_size));
> +        setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, sizeof(rcvbuf_size));
> +    }
> +#endif /* __APPLE__ */

Thanks,

Phil.

