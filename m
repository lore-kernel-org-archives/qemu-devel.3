Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E055CCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFss5-0005PX-At; Mon, 03 Nov 2025 06:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFss3-0005OF-5i
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:37:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsrs-00038q-4Q
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 06:37:10 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-429b9b6ce96so2679616f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762169812; x=1762774612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zGiPhzWHN3Y0aIOTOMsZeTis0Fve+Ko5F+ABzKeY7zM=;
 b=A/gbqwVKLaWXW7JGx2Nc/8JvF+CPRYD30vMQYBWmX3Mz0aPoj/k22ibdhFiKR5ErFy
 rTCHSF9gJ/1aOJY8PLE7wM7Z4uwGkJm58OvhEGtBPz9gA57O7VTG+mi9exDRkc5YrURD
 rgTFE7ayjBw196/sskEGS+oFQQIF/nLuAML2fSdzi4/AiQHigjYJjPDcWRG4SWtnq/K0
 ZdJ5nxbY0swrO95OhJPtp9sJ5fZt6K0XSVsWsLNaHT69IQ6E5j1Zuratv1cI8rnJ+S4G
 onZFmmjK0b+3fuuahJS6v9N8OvysRkah/vfM5jYO5kuOkgIXoy6xLInD+7tN78sQtvPm
 K5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762169812; x=1762774612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zGiPhzWHN3Y0aIOTOMsZeTis0Fve+Ko5F+ABzKeY7zM=;
 b=n9nBI9/dPaaVgRvXmZKsyjllfPy2GrdQbOxXpJu8Wdq3N/jp6RlU5aU9+XNrlaEKu9
 mPEG2LjiaIkmjl1N3JMTPCVK8ARd0A0inNUBgFX+ZCFlUGKJK9MEpUIG5VwfakksexSq
 tNX8CW9OcOe8zdgw6bupneSySAbR6qNfqXBMXXAi7iMmlyiVt7w9IvVo1W713FyB1Y5z
 mwYONq+XLJem5M+SXCUvwEZ8zyCtBmvQCO2tKv3QwtC6auGMF7ExeOo9vMa0ToouLFbR
 u8sWpg3waW7IIhI6HByXbSaeBPwg3RpXovpm4wENWxU2fveuaiaunEtQAKCblMn/nAzj
 Ceqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdGpEw/0x2ihLr9Rn3+FTEtLhn3Pf4pkFF6Bu/wHcR40eZkXz7wGSZrKXb8KnecKbrlMaCJn2hY3NT@nongnu.org
X-Gm-Message-State: AOJu0Yy4pdWMbV6uRdDl0rgUB6Av8ACCDEGokrOBv9k82SlPyHP3S9dp
 r9bdxmcgyeiog8WidCgpR+9af+HSdZzRUauoyXOtkdirjsqoyoaS0uYX0IpzOh51k90=
X-Gm-Gg: ASbGnctNlCNxH4DnZVSMR46qEk5xsZHeLxzZOwsBdeOaHIo0/Zy0Qo5qt90Foghy9Qa
 oDcyMU2YONW8zdJdituxvmz+eL2nnlhHwJLK0OtBbZOWj08kdit9EaTFUk+t9LrX2x/Ukcf0zug
 PmeQKfFf8WjIO5FFDvXfrXKP/06rSU2W3nP9DGsZ6g1WGAwZrxVzVuWJxwhoF4svI/F1PhVIeif
 RP70uWync8PkRpRIT3WxySvcSDRpp2OLfZV25zrGtTJT+JHD4s/xDqGRz7Sa+H8sBeTXSKwRG0R
 iVa060o3lVlWAeFrRr3ztfC09OJIE3QBIOWPN6lVYaPT+UaYpxxhXOwUopojtIVB+K/+obz0sCH
 GWVdeJTzdUYiRRZJM0uSK7FijLn1A6N+eYu9BbICJVhP+Kjd4Nh5fSWHrqj0yoMvFbym+GhkoBF
 icCDuoravlybye6Oxoa2yevEgzWyJOJ+CzXakp46XN+6PoUjPW/UE=
X-Google-Smtp-Source: AGHT+IELzbGXzjV0ejtX+dst7fwn3DpKxrL+APCD67NkZfOdqQocorykBeHwwqDQdYTlxzih5Y1DcA==
X-Received: by 2002:a05:6000:604:b0:429:d742:87e2 with SMTP id
 ffacd0b85a97d-429d7428a6amr1264140f8f.12.1762169811950; 
 Mon, 03 Nov 2025 03:36:51 -0800 (PST)
Received: from [172.18.178.65] (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c583d91sm151545205e9.17.2025.11.03.03.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 03:36:51 -0800 (PST)
Message-ID: <baaef09f-444c-42b0-a267-49d2c311d10a@linaro.org>
Date: Mon, 3 Nov 2025 12:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng@tinylab.org>
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251028160042.3321933-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

(Cc'ing Akihiko)

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
>   


