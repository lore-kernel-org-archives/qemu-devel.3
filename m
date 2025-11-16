Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6750DCCD19A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKgmw-0001rl-0u; Sun, 16 Nov 2025 12:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKgmu-0001qR-Oe
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 12:43:44 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKgmt-0004JJ-7V
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 12:43:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso1950810f8f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763315021; x=1763919821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dkWhFoK7BbNbEpGBPaHi0+vCp4oQ2dro0gxwJN/uaQ8=;
 b=GS5y6wRSW+I5c3b9uoiUbNk8rm8vu+xKaer/Dt7Y8QtbhMNqsIPdjqrrjiTvIFH7P2
 54VxYr0kNqSDB5mwTp2f5iGllCXaoD4o2iwKx300LH3XWXY/FU2Ce1i6YIMo0WrB3AMQ
 7jKc73cPZDlS54OzYtXHT36pU33rVjfqJSD/2qrbsXHHkaRtSqQxsgvzUhGZWxYX+ACF
 xgNLb0qH2fmO331kULOTdN7aST7Cr4iRJNbTXPYXatWhGUCYqX/6Y6Q7lGqFErfUAai8
 fjgSCkEG9cNAe4lVKoOCHdwYoGPpTrpZHH/ljVv0jXeOdn1yEibvgSRQBknEetH68X5/
 id0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763315021; x=1763919821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkWhFoK7BbNbEpGBPaHi0+vCp4oQ2dro0gxwJN/uaQ8=;
 b=OWhFMbmVBv629DfFb/u1EeldaN+NvOf6aL8OjvKKIz0S4jBJhAU0EZuqmYGu7W19lC
 ucOVJ6OkkpONbyd5HXoccamO8aXx3EUdT6qcP2ZFjOXKffrFqCl7y+jnNJnOoxDfNyVY
 uLn1cIDeBEn5Y3w2CIhTDYMvITfUEvOcD9Xz9VOERu9ME6hIX9KivdGBcvssrQrcV7Sb
 EHjcOD4VSn4ac6sD3YrNY8Nxx//Uh5AlF+70vATcjqzQ9lO7ONNfI0O3dQ55jiVmMeej
 SFlWOi9JF27qkvm7R172qm8HQ2TL9OIbp4uNT7rkNJlo1VEoLXR88ud/hSkwoajsLl8h
 tJAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnDiPjdDNE50q0SgT7jXuXmqT88e0ehBJ0RfAvaJmP6sp947YvL2FkvlaJi8GFp78fQIsYZfpc8ZQC@nongnu.org
X-Gm-Message-State: AOJu0YznFP3Q/RnhLIrcwm8+K1J1wjVXa8mBHTNADEkCDNXZ2Hjwwsi4
 GZGZZhbbTMZC0D/IDzqAHJtNP7a6RefEX85M+G6XbgV2sktfsobiPQLz1AckU2jxglc=
X-Gm-Gg: ASbGnctXvhVRq7RY+p1xqtWTfzYjQBbmhgAm9komWri7vbhwoOktJPMw09Oy4d/MZCX
 UDqPZ44i6UONruugCVQwzCO2nwf921lZfnnAzpp3a2LKwR7vx8KHTFRgP+1AuovtbAWQw2AI37n
 va0LoJ/RjffN9K3UNLzf5A1LPt6Wrey3qNdMI7+pSiIXZAf2wpa7kqlKbvFRBXzpvDVIzupUQbC
 49/TGIXyGfqAvkcahxlux3w8Z8ZIT+vWBtu8NPhL7p7Wx6oHL6AxIuA9N4TrX3i40GGtRP+zA10
 bANpHpY0NCJGjLY44tmiuiv0cQSCAsN6uWxFbyftpRaTB7vuHDc9PhccjP4nM769M34puMlvLZ4
 bh5CIve3U6XJMoYwPM0lIKOrAQMqRZvzUoTGn+dinLQEbX+U4RhC6qqmVcbmKVYPM7TCWI4LEW/
 giKJlN0BnD00bc4RS6qIxOXhM0bFEn1wvUjQ0kKyjsmpJz+HurlxpnuiyEaR3M/f8L
X-Google-Smtp-Source: AGHT+IEjJqAAuyNSPau1udMOfHzbpjcFPoJ6pgP4FQWNj58/dDXZ8jBGLyuprNoJ/OR/cA62N/JjnQ==
X-Received: by 2002:a05:6000:1884:b0:427:2e8:fe3a with SMTP id
 ffacd0b85a97d-42b59339143mr10420458f8f.13.1763315020818; 
 Sun, 16 Nov 2025 09:43:40 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7aea7sm21769202f8f.1.2025.11.16.09.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Nov 2025 09:43:39 -0800 (PST)
Message-ID: <663acd8d-5c39-4f1c-b5b1-569e36e4ff95@linaro.org>
Date: Sun, 16 Nov 2025 18:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Avoid confusing address calculation in
 rpmb_calc_hmac
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-block@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
References: <4f7e1952-ecbd-4484-b128-9d02de3a7935@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4f7e1952-ecbd-4484-b128-9d02de3a7935@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Jan,

On 14/11/25 22:27, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
>  From the source frame, we initially need to copy out all fields after
> data, thus starting from nonce on. Avoid expressing this indirectly by
> pointing to the end of the data field - which also raised the attention
> of Coverity (out-of-bound read /wrt data).
> 

Resolves: CID 1642869
Fixes: 3acf956ea1a ("hw/sd/sdcard: Handle RPMB MAC field")

> Reported-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Tested, not causing any regression. Please check again if Coverity is
> happy as well. Thanks!
> 
>   hw/sd/sd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9c86c016cc..7fdb9195e0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
>   
>           assert(RPMB_HASH_LEN <= sizeof(sd->data));
>   
> -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
> +               (uint8_t *)frame + offsetof(RPMBDataFrame, nonce),
>                  RPMB_HASH_LEN - RPMB_DATA_LEN);

Having:

#define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)

then

RPMB_HASH_LEN - RPMB_DATA_LEN = RPMB_NONCE_LEN.

So this is equivalent to:

         memcpy((uint8_t *)buf + RPMB_DATA_LEN,
                (uint8_t *)frame + offsetof(RPMBDataFrame, nonce),
                 RPMB_NONCE_LEN);

How is this not equivalent to my previous "broken" suggestion?

         memcpy((uint8_t *)buf + RPMB_DATA_LEN,
                frame->nonce,
                RPMB_NONCE_LEN);

(Yet again late here...)

>           offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
>           do {


