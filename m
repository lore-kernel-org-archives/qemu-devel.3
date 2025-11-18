Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F68ECED63B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMUr-0001HF-1e; Tue, 18 Nov 2025 09:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLMUo-0001GW-GI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLMUm-0005LN-A1
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763475340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YjYgnv3pJA8KXR9PSUbOZGoj46F2MG6jHiAadTXH3M=;
 b=MoHrtZw0ZNuPNYZDM5zLEe9gmbW9VZvepl8RZ4AattXpv/qXkjcUm3aSyLuysam0d7ePj0
 FsX4bK/HRHK1J17YBIkN1yyVbZUoe5mQ+czx30sQHtcRpjhYfkntfZM1FQVP7lbaM9m/49
 fPXdoiGi9ETJZtdNAZ6Y7ALrX6z7k9c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-QGeiZjALPz-8wsU3gp-g6Q-1; Tue, 18 Nov 2025 09:15:38 -0500
X-MC-Unique: QGeiZjALPz-8wsU3gp-g6Q-1
X-Mimecast-MFC-AGG-ID: QGeiZjALPz-8wsU3gp-g6Q_1763475337
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so2669664f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763475337; x=1764080137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4YjYgnv3pJA8KXR9PSUbOZGoj46F2MG6jHiAadTXH3M=;
 b=JfAFvZ2Sx/wPwHSQDFz5Op93RPoyh6zJOC3ob9uQsIoMXOP/PrSitQuPnFEI/coTCW
 /4/0WrIAiwKqsWlSmIbETDEZxHUH5yambPEmHMNIt1kF40TC2Ij0docHfI1uCDwxqUbk
 13utvSwqvX76hHMepEngMc1+dmp6+uMqs0dzX1B0gGs24h/4eJZhDV5EqH7aIMlvbmQg
 jmL0ruaUhu1POQLM+e7pHTpIYfXV4+DCgraKNGtYJgjOZjHtiVrD7ZA5Nox2NCfP4d9y
 fABlO5xSz8U4iw1/dlhDIn29buJOMT2A/vjEz9G6FmuXpawFbBKMYn5d1mGRzm5V8xz6
 wRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763475337; x=1764080137;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YjYgnv3pJA8KXR9PSUbOZGoj46F2MG6jHiAadTXH3M=;
 b=gDX/LVvGRv+93tLoMNX1njbRRZfLtfo6mT04Pb/E6Ut262gSUnn3RLGioVGddvH1w6
 9rpnZma+DuwC2/IL1akuvAXpUDiWwlFDG7yBYxpfr69N1YnTzaRvUQC5l6p6+pFrbXKy
 fMn+dpBp8Htug436g7T8ewLpLydqdqUfHoxvo1s0BShngOdKpe0PNOJTxCWVSYCULrNn
 OglmrvG6v6hZ5bfp4wrjr2ua8LKF+qrM+Sw1BVOINXOHn2P7o9QIh5XypSukkEMEuhjH
 MyAIGuOb8h1ql+Lo6x2Rg9hVev4+l4v2CaRcWdX6hEwFbV97MmUvW8Mi6FF7I0Ci55AS
 2wPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3GnFKI8Rqe6tpvRfggcrE5SR04hL0GMzEYIBRtz2cVvjcAvhjkNikxJltkUla8igbp435tXmFgcFG@nongnu.org
X-Gm-Message-State: AOJu0YytqOmi8le87OqsJ3O/+AQZqnZLnzYHisqWzgeMQJHf69kU9vnN
 /P2zuccd5rFKezW6Fj2ZVBx/hqrhEiRNP94E8VqID4D6vwjhEjRRl8FzmxqzPk9lxn9E5gUi+Zy
 Lv2nYBNhGCdV42YSM3AxTpU4KA+NYtOJ54+cRmj3QGn0sk4F1qZE0BzBg8DOxRHs0
X-Gm-Gg: ASbGnctSAV4ucCKpLnUwTjP3EeUHbkQmwYLPUhwx2Rv9rhZFYvkb+DvfWirxXPmJ9yC
 byN6TCrYDhZ4efmcK12v14r8NKzb5JcASWdbFTP/67B8GPKWBjuUauV7l2/0gBW9CtgRx6e8BQS
 3eXHtKiWYsbHAJRiRo6B9cfUZkMKX0Eyx1Q/EHt86zCpLpEBQgleHxO+/9wITZRpAmAz55+REwv
 ut6gv8M/xNIGvLpodCUZepui51koZR0wbTqrPsB0RkGEgLU8dI1gGvjvkWo8LiXutcwRpTetvFe
 FdsR7cIRBJwbaYQH0mDole8YsCEuqR8yC1RE7NXWUBaht1nX8Wc3jOV/qHtpU3BrK5l+9LFzUcn
 KxGr8CnnhVeYObbyasuL1d+zBONxq56xaOgGaOg==
X-Received: by 2002:a05:6000:430e:b0:42b:39d0:6386 with SMTP id
 ffacd0b85a97d-42b5936796fmr13878172f8f.31.1763475336747; 
 Tue, 18 Nov 2025 06:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbCIgK6vwAWJ+bbWAc/ZJPS2Noo1+Wf0NhNzfilqTaHLZryQJqqUJLU6va1q3+6MTSl5I9eQ==
X-Received: by 2002:a05:6000:430e:b0:42b:39d0:6386 with SMTP id
 ffacd0b85a97d-42b5936796fmr13878146f8f.31.1763475336282; 
 Tue, 18 Nov 2025 06:15:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e982d6sm32717318f8f.21.2025.11.18.06.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 06:15:35 -0800 (PST)
Message-ID: <38066e7a-8e05-4c8a-9779-273ae3d88d59@redhat.com>
Date: Tue, 18 Nov 2025 15:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] vfio-user: clarify partial message handling
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-3-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251117155656.2060336-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/25 16:56, John Levon wrote:
> Improve a comment for this.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 75845d7c89..82c76c6665 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -362,7 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>       while (msgleft > 0) {
>           ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
>   
> -        /* prepare to complete read on next iternation */
> +        /*
> +         * We'll complete this read on the next go around; keep track of the
> +         * partial message until then.
> +         */
>           if (ret == QIO_CHANNEL_ERR_BLOCK) {
>               proxy->part_recv = msg;
>               proxy->recv_left = msgleft;


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



