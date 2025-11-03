Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34820CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsqv-0004VS-JN; Mon, 03 Nov 2025 06:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsqs-0004VB-MR
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:35:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsqn-00030h-T6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:35:57 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso54698415e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762169750; x=1762774550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xdt4v+XlIdKSRF70HjuOQ8yLFm2vGhFCyM/wq2M2FbI=;
 b=xYQCZu5JYR0wyIoHkcqJqlBzmnaD3sKfowcwCEa4aRDs+rNqA0s2/i0AVEAme+XMgr
 lB7JY7D0mJ/bwH1h8BXaXfi+GMA729/njCgF7avtOKdr+QnwmjnPB4LHI1i811LLCfYY
 tRtdfir4JISRrXfymHU+JNx+5VgqY0W91Ok7Omr5dEzJXZMIb4j/x1Oq6NrgtuXuJaDM
 QfHgI2qpDUcMYo1Qn0+ty9VmrfV3WOOcqMdLbgwfqXTbpQw9fftaDbTUEJlqcymKyrA7
 tx69o3zCt7IYqssgyMMv75aNwnzXuha8f/X5pLi5Wd4fdLpk97vsieNwY1L8KOJt8OA1
 byVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762169750; x=1762774550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xdt4v+XlIdKSRF70HjuOQ8yLFm2vGhFCyM/wq2M2FbI=;
 b=qDOD8xUx8+aAHaI99ktUWusUJyGuInhPwaeKMfNQSEbRdvEc/bciYMluEUw/Lb3Wlq
 paFM8P3SalQtE8kvxhZm5Su6GabBYScumZy9HcQUrm9vpMYutNKEBfjIBqeIs3zpA536
 jINyvxx8J3R3V2DSp552pZ560qDP+t1wxN9JpaoKs0yfnwsH1DsmRn2N2yLbEHeK4SV0
 p1mmq2jxotdEE9TgFoW4OyZg2YCfcwnKf+EYY5aKsQdB+ZZaZGbJRXfqujo/9PLSO5i5
 l4nN791WEdtLDj3Ki9a22e+xAuSmusc79aefkgB2uWSplAXK59Sg9sl6YInMqTB74hzV
 Y+cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNFcdimLF6G8lZRVk6TMhkNmm2WFyZEynMtjf52OwuAvzHZMsVylYdowGutJdOvvtnI40b9bLN5+Jf@nongnu.org
X-Gm-Message-State: AOJu0YyF8y1CL87/9KALuflXzuFF8BFtRo7WGYewtwLgIMrajnc3BGHC
 6I+TvzuPk/rlpWRhxoq7WQcf3zW7Ok/b7WjTOENp8ro9IXz1fubhayCIKCF1553bMNA=
X-Gm-Gg: ASbGnctLtaYz9UXSJjJMSWuPM+eSL1uDjcQ9PzQZTFWXpmH6iT7vF+joQJqvnyqVDEF
 dvHfT8rDwVdLgQaG5IwdkAn8HZVYqMQ9iDhYcFkGD7Je4QvV/wAycMDEmn5d5kNVtbPIp0Crf7L
 eVSaBHMWulgGEsUt9EC3EG3ilDHCuNcOiC3MPWsdqsuLPGEF/K6Q6RdNC1SMvUGP+kweq9dG0VB
 lnjQ8mtpT1CO0hoi7/+ymSekcHXkVvOquUOyXMZNrbm22cVTrh89dCWQdKxwB8UvTS8jnKNOA8O
 7ur8wFzJEl6p44vAr19aXnT+/HWhpE6FQlZLDcmScczpIZni7YSfhjVZlUDcr7zc2vfUwNT++mu
 ee+zZOzT/F2+UguyblBPpp8QTIrSuQ+30tBFeq4umhvZAWg67Nwlgi9Pu4FVrxhPNqSrNoF2Xr+
 ynlfKqv1ae1fGG40TfoYlsln1CpXzSrVqGQahU9CYTT8sQh/kSmRA=
X-Google-Smtp-Source: AGHT+IG7Klp5SNcHitPTgpT5hWeFG4rJi0Bqg8u13nCOgQtThpU1fiqL5QCS8REVRTOsGIjrGWPbSQ==
X-Received: by 2002:a05:600c:3511:b0:476:4efc:8edc with SMTP id
 5b1f17b1804b1-477307d9920mr99932875e9.15.1762169750128; 
 Mon, 03 Nov 2025 03:35:50 -0800 (PST)
Received: from [172.18.178.65] (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c394e33sm150837755e9.13.2025.11.03.03.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 03:35:49 -0800 (PST)
Message-ID: <1a8ea87f-41b2-40a5-8511-df019b5833c5@linaro.org>
Date: Mon, 3 Nov 2025 12:35:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng@tinylab.org>
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028160042.3321933-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 28/10/25 17:00, Peter Maydell wrote:
> In commits like 969e50b61a28 ("net: Pad short frames to minimum size
> before sending from SLiRP/TAP") we switched away from requiring
> network devices to handle short frames to instead having the net core
> code do the padding of short frames out to the ETH_ZLEN minimum size.
> We then dropped the code for handling short frames from the network
> devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
> Remove the logic of padding short frames in the receive path").
> 
> This missed one route where the device's receive code can still see a
> short frame: if the device is in loopback mode and it transmits a
> short frame via the qemu_receive_packet() function, this will be fed
> back into its own receive code without being padded.
> 
> Add the padding logic to qemu_receive_packet().
> 
> This fixes a buffer overrun which can be triggered in the
> e1000_receive_iov() logic via the loopback code path.
> 
> Other devices that use qemu_receive_packet() to implement loopback
> are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
> and sungem.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I think this is the right fix, but I'm not very familiar
> with the net internals...
> ---
>   net/net.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/net/net.c b/net/net.c
> index 27e0d278071..8aefdb3424f 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -775,10 +775,20 @@ ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
>   
>   ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
>   {
> +    uint8_t min_pkt[ETH_ZLEN];
> +    size_t min_pktsz = sizeof(min_pkt);
> +
>       if (!qemu_can_receive_packet(nc)) {
>           return 0;
>       }
>   
> +    if (net_peer_needs_padding(nc)) {
> +        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
> +            buf = min_pkt;
> +            size = min_pktsz;
> +        }
> +    }
> +
>       return qemu_net_queue_receive(nc->incoming_queue, buf, size);
>   }

Nitpicking, variables scope can be reduced:

-- >8 --
@@ -777,5 +777,2 @@ ssize_t qemu_receive_packet(NetClientState *nc, 
const uint8_t *buf, int size)
  {
-    uint8_t min_pkt[ETH_ZLEN];
-    size_t min_pktsz = sizeof(min_pkt);
-
      if (!qemu_can_receive_packet(nc)) {
@@ -785,2 +782,5 @@ ssize_t qemu_receive_packet(NetClientState *nc, 
const uint8_t *buf, int size)
      if (net_peer_needs_padding(nc)) {
+        uint8_t min_pkt[ETH_ZLEN];
+        size_t min_pktsz = sizeof(min_pkt);
+
          if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


