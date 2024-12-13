Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10409E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBAY-0004Fx-2E; Fri, 13 Dec 2024 14:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB9S-0002oF-KU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMB9Q-00087i-Mg
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:16:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so25318045e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117394; x=1734722194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNt7E5LBZnakm8Ca0zGgF/hmGsdBljJHkNF8hUFv1nA=;
 b=ZEnoNkAF0JHe3KoYbjg3qUCTg2tl7HoxFNp3J1XrlYFrhaXmNa+g9DUyJnC255x+l/
 P62Ugb5zL6ePBaXa45tK2DRbSwV7+qutJN2uLGDpNAKspx1Na8GIpWH2p4WesloGElox
 GTLAXpnFIXMOBOyLRiz0OC84vrzDrKEbEhZlR2Q4qGS/ujov/xRTvQPN4fkFanOBiukK
 49axyX4cAMiLatLonv2rMEARQI4cwcOk5HxVd38yR2cDMkfZuJij+HgnVdwoEZpFRyOO
 y7GjbMfxXtHrF5ReqIO/FaqCtZGhbH6gdjHdaYh9iIF/6lZrFqbLGlQQ2ach7buNSz9C
 Z3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117394; x=1734722194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNt7E5LBZnakm8Ca0zGgF/hmGsdBljJHkNF8hUFv1nA=;
 b=csMaVUOZEYDFLeO6YJzFB7X0nT1J3pw62xXZmsuuOWow9Zj5Np1frf1wqCelQGEJbI
 g8PehR0Uj6dgSGkh/0jvJIQyr7ZPOdDlj8zRKuFprMJsPrX0Z84Bm/PW3sEQRUNmaj5F
 q3W079MJv6bqo057qPTlQnSIgMT3gufvzf89VHgCjU/xQ6wvldECLWpsKGFKFAKPUZkb
 Lxw+lEb7KyMWOdRnmHUMkrcJwlswec9kdrnb7UNGxj0pdffZS9SjG859Bt5iIZoMvsEA
 zzbtIZAD9rjuIhSnDdfZhztQtEskQ1q4guybfYrEJv5UCEXWqZyS7jTvKneNNqUkzkOZ
 VrYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyyJqORtiaE//L9q2fA/EJ/EJSldHjPTE2EdXle3eWQ1cNr6XSRIYszQAkT80n9Xcb5k6IPsj3pP8e@nongnu.org
X-Gm-Message-State: AOJu0YzNHMW6lSjJz+mJA+Ze6hn6bO+NpM3lfa5/QmsMOcwJYoYVGhd0
 3K2P3lgmiBCuf71wD7VadX4lg8zzrqpUjil3lYTpIN5U2TN7lzAsIwc97t+h5bI=
X-Gm-Gg: ASbGnctW4d3X5g5m/hQvBFxyBfKCYCycPcqJgPR6S8wvVD4KT1tG3uirjClzGgyaaw1
 USGOd6YUrgYfWxj4pLUBnnmQ2hW6UiqN17dpesbzICbiG3nJuAzEw6Grdy0XkYRvVDIcSpLhEoi
 yy7KaHMJxXuHUkkwkSgBkGWIOWdBX46EZpBAQO3UfvWiKpOi1xXAPx8UQDi5qsgKqaFwtZ30fM1
 FODh2GZq6DB/9QDUZV28vMm6aGDTc+pkaAYFy5wlhed1kMrhJpmHOR0q8mOmpOADts0VyHS0b7i
 acRAmkKgm5X0Yw+CYAKc
X-Google-Smtp-Source: AGHT+IF/aCMWk44B1CSsW1qN6uuXq/moAVtVCOriJZzrv2OyGBUmFxJIe4vGquCuYDO0/nB1uX5f5w==
X-Received: by 2002:a05:6000:2c8:b0:385:d143:138b with SMTP id
 ffacd0b85a97d-3888e0bfb3cmr3745115f8f.51.1734117393976; 
 Fri, 13 Dec 2024 11:16:33 -0800 (PST)
Received: from [192.168.224.213] (127.47.205.77.rev.sfr.net. [77.205.47.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046ca6sm297070f8f.83.2024.12.13.11.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:16:33 -0800 (PST)
Message-ID: <8ce5348d-eba3-4650-8916-ddd17754134a@linaro.org>
Date: Fri, 13 Dec 2024 20:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: graf@amazon.com, pbonzini@redhat.com
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241109123208.24281-1-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/11/24 13:32, Dorjoy Chowdhury wrote:
> NSM device in AWS Nitro Enclaves supports extending with both
> bytestring and string data.
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>   hw/virtio/virtio-nsm.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)

Queued, thanks!

