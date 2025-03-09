Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F42AC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 19:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trLti-0003Cw-C1; Sun, 09 Mar 2025 15:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLtg-00035Y-4t
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:01:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trLtb-000496-Gm
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:01:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so27776185e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741546865; x=1742151665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g009UrFww2P8l+qxIe1bJHkpF3pMcLhl8nEq6hi+Dek=;
 b=OI0yHYB6XoIhVfR4nkTQfUvStJo4/4yPBozbgUEC4+QXNVE3Fxvlu6gwMsc0Re1gwO
 NyMg+1bB3pJlC1cF5XetBH4+KAR87WoUyayY+aaGY6UsFqmX8wWYsEAn7dANJFGDH4mE
 XABaenwf61zA56ue5g0+2k5NpfQQtCV1ueFKIleR6Cbu1GP/Ovcx82L4cN7dNQ2g4TVg
 HtaC92+sDHTY04oZqySTZKHc9jrkiLldCp6yJ2r6G5oyKpzZ66GWnar+JLf+g9brUJm7
 hQ08Pxrow4Xk2KjHagsummdKH+JKVRPU1R0xAxoC99im/8riUksbhvfcAPzYFkYeNWeg
 e8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741546865; x=1742151665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g009UrFww2P8l+qxIe1bJHkpF3pMcLhl8nEq6hi+Dek=;
 b=hOdueA7E9MIyF3Sb+PV2VPqjgKydBt2Hb9kXGCurcyYpxKvw00WPacLxsLoqE7aiSS
 PtrlETUMGiJj9Ya75JoMxhHhSUIDcIIRI5IQsIu84cxl84yYmb9ApsfE5tYzmOgYg3pa
 YCWwTi3eE4LaUJFg9Qsu6XcJvEqxuHWiP54b7YsK2xfGwqWlf176aibBw36LPKgGsUOO
 ZG6DTXtgzYf/DPhQKTKKJl9B7ypLBtrIZ4Vn6mjaFAtDcIw10wyNvFqqUqYfVFqb7EaR
 G5Mq1s40AikiR61bwOBA3osJjWUW5RT6w8NEBU+M3Z7NP9f7+DOgitTJpVhc5zy/cJGp
 veFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+7T8OZ3VP0gVaY3lFAWB0JyyRjcclUDSprAE8TzOU7QzEOG8CG55EeAGKFSCtudecTpQWSBixKjD8@nongnu.org
X-Gm-Message-State: AOJu0YwzBCZP5uF9dugJV/GuyTv2xg8i4xzkE+7qWJG2mDE9nbX1G+Kh
 NMrpFXPbq9LBkVGHXgO186UT0qJW0haDtmGozpleh2rceFS3VGneZKdKcfmibEg=
X-Gm-Gg: ASbGncsbiSGVsBNYGmJYllPdB7rfRzA3Y7+nHj4s8Owi8l5k+KOcn6dH8JHJOuBCS/+
 iluf8ijXPMLjgsaXjF6W4Onxuds8hX/KZeC7aSomBjiPanew9sn6QU1ZXR3Q7QSmX+fLyByKY54
 dmLDBORikQkVdDSqS+LvfkYfKxeJSpnDlTsPq4qbmZrjyLoRE3I9SPPrz6oytQ+kxS959CpZCGB
 cxWx4ny+A5/aM6SRNFZk11aO0GHBJX+N0dlvndGYp15bZR1687NlHqU9G7V6pdlBapFzpDwqdRl
 EAgY5W0o60ItovTqd8kW+5huceQDIjTjiRpgEOuKq22NgOEiwr5M8GL4zs5ETZPpSZsJYOPKpip
 VwNQSEmHNmgnC6dfZlPkjZCA=
X-Google-Smtp-Source: AGHT+IFXqJc2l6l1ckeDyePSNg8VCVTFqUuZpWHmW0ANXxji+tJgICu8+1TqnUUqEeG3aty2+AAhMQ==
X-Received: by 2002:a05:600c:154c:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-43cf63cc031mr8907385e9.1.1741546865449; 
 Sun, 09 Mar 2025 12:01:05 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce715731csm62116135e9.2.2025.03.09.12.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 12:01:04 -0700 (PDT)
Message-ID: <f4262519-017d-4ed7-8c17-5d4d72a219a6@linaro.org>
Date: Sun, 9 Mar 2025 20:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/net/smc91c111: Sanitize packet length on tx
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <20250228174802.1945417-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250228174802.1945417-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Peter,

On 28/2/25 18:48, Peter Maydell wrote:
> When the smc91c111 transmits a packet, it must read a control byte
> which is at the end of the data area and CRC.  However, we don't
> sanitize the length field in the packet buffer, so if the guest sets
> the length field to something large we will try to read past the end
> of the packet data buffer when we access the control byte.
> 
> As usual, the datasheet says nothing about the behaviour of the
> hardware if the guest misprograms it in this way.  It says only that
> the maximum valid length is 2048 bytes.  We choose to log the guest
> error and silently drop the packet.
> 
> This requires us to factor out the "mark the tx packet as complete"
> logic, so we can call it for this "drop packet" case as well as at
> the end of the loop when we send a valid packet.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2742
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/smc91c111.c | 34 +++++++++++++++++++++++++++++-----
>   1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index 2295c6acf25..23ca99f926a 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -22,6 +22,13 @@
>   
>   /* Number of 2k memory pages available.  */
>   #define NUM_PACKETS 4
> +/*
> + * Maximum size of a data frame, including the leading status word
> + * and byte count fields and the trailing CRC, last data byte
> + * and control byte (per figure 8-1 in the Microchip Technology

If control byte is included, ...

> + * LAN91C111 datasheet).
> + */
> +#define MAX_PACKET_SIZE 2048
>   
>   #define TYPE_SMC91C111 "smc91c111"
>   OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
> @@ -240,6 +247,16 @@ static void smc91c111_release_packet(smc91c111_state *s, int packet)
>       smc91c111_flush_queued_packets(s);
>   }
>   
> +static void smc91c111_complete_tx_packet(smc91c111_state *s, int packetnum)
> +{
> +    if (s->ctr & CTR_AUTO_RELEASE) {
> +        /* Race?  */
> +        smc91c111_release_packet(s, packetnum);
> +    } else if (s->tx_fifo_done_len < NUM_PACKETS) {
> +        s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
> +    }
> +}
> +
>   /* Flush the TX FIFO.  */
>   static void smc91c111_do_tx(smc91c111_state *s)
>   {
> @@ -263,6 +280,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
>           *(p++) = 0x40;
>           len = *(p++);
>           len |= ((int)*(p++)) << 8;
> +        if (len >= MAX_PACKET_SIZE) {

isn't MAX_PACKET_SIZE valid? I'm not sure at all but I'd expect:

            if (len > MAX_PACKET_SIZE) {

> +            /*
> +             * Datasheet doesn't say what to do here, and there is no
> +             * relevant tx error condition listed. Log, and drop the packet.
> +             */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "smc91c111: tx packet with bad length %d, dropping\n",
> +                          len);
> +            smc91c111_complete_tx_packet(s, packetnum);
> +            continue;
> +        }
>           len -= 6;
>           control = p[len + 1];
>           if (control & 0x20)
> @@ -291,11 +319,7 @@ static void smc91c111_do_tx(smc91c111_state *s)
>               }
>           }
>   #endif
> -        if (s->ctr & CTR_AUTO_RELEASE)
> -            /* Race?  */
> -            smc91c111_release_packet(s, packetnum);
> -        else if (s->tx_fifo_done_len < NUM_PACKETS)
> -            s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
> +        smc91c111_complete_tx_packet(s, packetnum);
>           qemu_send_packet(qemu_get_queue(s->nic), p, len);
>       }
>       s->tx_fifo_len = 0;


