Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67905E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 17:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSJFg-0006oJ-6S; Mon, 30 Dec 2024 12:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSJFe-0006o6-HU
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 12:08:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSJFc-0003U8-OJ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 12:08:22 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso7065561f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735578499; x=1736183299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LFqxKqziPnZCZIAGgSjgBvSz5k1XsGB5rDZ/J2p5pr4=;
 b=qt7uKiiJj3ETT7yQWkigbB28hlmpMMvpX+n+bKGhY0bgPMOibsBOvEjffQIgaM8N72
 suzC7UkGgYvqi+TcMDrKNjjwGZJv1sQC8RI7EDmZb0bBsnjbxEz3b/90uuf4Ri47iSAA
 wJ0u1tBkjeuA9ZpBlGeA2GbLyNRAs71GP+A5Hhv1R+2XTggNgx9Bo/ieVdo7XBd1f7zn
 Dwva8rgp0AuEFgAqAnc0bwox/q8RaMyMkqFbH/ud2j91+SYLJyn96eBfHIjZL7cCiaZE
 OZdahz0W38goqwMc+gDGk7trGhmePkw7A1HU3OQK5cstT9LK6viqZbopo0nWtYmh5wJs
 4wYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735578499; x=1736183299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFqxKqziPnZCZIAGgSjgBvSz5k1XsGB5rDZ/J2p5pr4=;
 b=Ajh3WEJnOQDqNUvcQTLZ7A4zjF9oFnbQJYGDYdKUB7S/j66SzhJwRx134QTqQvVKUc
 iCTb0oWICk3H/CvuG2coLBloVOE8/D2qjB3xO8796CoOunlOx48993B9dcy40MtHMso7
 eWwuPnC5f5cSZ1GiEL5D++4uFJVU28wveRlfuz7Ng1ZDS17OJ6prMp8DvLrRBVgLjCht
 wlionLvGdl3DoidBLkZTLJQdCu4SD1ux81nyweyKxXQ31Jss674waN2Gv1t/um+aLE0F
 UbxH6+DkhYswvwQ9kKff09QjUBbuo99ksFvqYH3bk9orWed7IRFe9/zq8sfuRS+pK1TP
 gkqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNB7tQk9HUAIAoqDDc5Jrf/ZybCEeFLT3SWSd+bS+tBvchnasit91f6p2eg3D7ZhUhWs7Wjcg+J7ZL@nongnu.org
X-Gm-Message-State: AOJu0YxQmYRMpSZzKNJq7irDoK9v6qSDDOtPTa+WT+zfMiOmfp+A5GEZ
 ak8zPboWMJETK58tP5hBCV9eiIZqmqRPaB8fxOT/NT786z4jxiblhGYhFUCBHypVY6IwJeSKXe9
 g
X-Gm-Gg: ASbGnctqhguhDycnZDrtOrj3lfXXYt4wqiIdQzOig0JQiQoyzr8Q2AvcjO0bHH/eVUA
 NFAhEVgGzxqsSYXthU7gc2jDvwfLOFigmydyvy7HsBy+YHl6W8c2AFrTrBSISKc5eDEhvDMbSt6
 JskWt07259EBqhFKBeeTb8hJ9drBCgzRgg3Gxx0/q+Zzrzvx273/AJbJXAEzq+ECDmDMl1ck+tE
 jAeqjLws+Xbre8xXqu9OCt5CmUl4jk/glfRygm1cX5Hj5fXRE5FIWaqwjxu6gZuHh2HlqAtw2MK
 I4q5MWgsLBsLRGRyY0H1Hh0L
X-Google-Smtp-Source: AGHT+IFsmRzXy5dDoV2ZN/OXwsMjWExn7atQTRj3e9diFQ9OA9NMt/s/bqeLi6IsNfq4ZcGoPhXI2g==
X-Received: by 2002:a05:6000:18a4:b0:38a:5122:5a10 with SMTP id
 ffacd0b85a97d-38a54452f1amr5179579f8f.15.1735578498636; 
 Mon, 30 Dec 2024 09:08:18 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a636asm31311119f8f.88.2024.12.30.09.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 09:08:17 -0800 (PST)
Message-ID: <d7123d27-ea64-4521-a5df-26ffa1e34534@linaro.org>
Date: Mon, 30 Dec 2024 18:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/49] clock: treat outputs and inputs the same in
 NamedClockList
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241211162720.320070-1-pbonzini@redhat.com>
 <20241211162720.320070-17-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241211162720.320070-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Paolo,

The commit description is missing... See:
https://lore.kernel.org/qemu-devel/20241129180326.722436-3-pbonzini@redhat.com/

 >> Leave around a reference not just for inputs but also for outputs.
 >> This is a better choice because in principle the monitor could walk
 >> the NamedClockList after the clocks have been unparented (which would
 >> free them) and before qdev_finalize_clocklist().

Any clue what happened?

On 11/12/24 17:26, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/qdev-clock.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index ca65685c04e..2f9d6cb7579 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -48,14 +48,6 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
>       if (clk == NULL) {
>           clk = CLOCK(object_new(TYPE_CLOCK));
>           object_property_add_child(OBJECT(dev), name, OBJECT(clk));
> -        if (output) {
> -            /*
> -             * Remove object_new()'s initial reference.
> -             * Note that for inputs, the reference created by object_new()
> -             * will be deleted in qdev_finalize_clocklist().
> -             */
> -            object_unref(OBJECT(clk));
> -        }
>       } else {
>           object_property_add_link(OBJECT(dev), name,
>                                    object_get_typename(OBJECT(clk)),
> @@ -84,7 +76,7 @@ void qdev_finalize_clocklist(DeviceState *dev)
>   
>       QLIST_FOREACH_SAFE(ncl, &dev->clocks, node, ncl_next) {
>           QLIST_REMOVE(ncl, node);
> -        if (!ncl->output && !ncl->alias) {
> +        if (!ncl->alias) {
>               /*
>                * We kept a reference on the input clock to ensure it lives up to
>                * this point; it is used by the monitor to show the frequency.


