Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AACE109B467
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YpF-0001rv-F3; Tue, 31 Mar 2026 09:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YpD-0001r1-FU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:08:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YpC-0002rf-3Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:08:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so70248345e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962484; x=1775567284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i/WCfAxhqTrt0nvPecKBaHXcfH1HbmA4Fx2ck/dQzqo=;
 b=naKF5QRA05J8QcIl6Uw7DZPSo4yGVu/lRasmL/tQKZT6EyM5DgzcRQmvJe2flBpUok
 CMpFo9ciQQwmR7FOpJuls36MZ/NicqiWIKRD51Ropa0xD5APYA6Lk+q805x3yScbNbyU
 ruyUy373z7wWfOtIU9eh3PbW8VT7UIWFfFNgBFfXs/cULm7uU+PqY/vVfkV72383a4ag
 KOcFQsjhivBQus+t1QdfS0vW8V0HckqJWst0XLh0ETO25/hxx32lBGYeINA/TwWcCuZs
 6KCkmppwt10LzTT/1PhWO4xzz4mhiLL6QDgMm6HT2B4OznPhLqAxThiZk2W2f6su51TS
 0i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962484; x=1775567284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/WCfAxhqTrt0nvPecKBaHXcfH1HbmA4Fx2ck/dQzqo=;
 b=SQXL8yABfJ1akMQEUsEueKAHFF6pUii7TTCYLK0vR6gu3PRPPscdja4weKmoKiusKw
 v52wSOcSORLsjd6IVzxuB/UddxpqqHJGxK8N4LCJ6qEYSjKF0R1wLawLWZtFG6+3tDDl
 5rhP2YnggHTa9ALhifAx0QOZsToGfsWxb+iPPVZ7zCtzjLLmXtYH3PuQ5kZvNpEjnWXK
 5nBb8lbNvqyB6cotqI9zij0sjifAkyM7ZN3B71Xb6kkKO/hdaqzyR4YkaGrrmPJovYFC
 YyDrWdGDoE5po1/600RnBKqh36byOInmtAFTwe3WHlxiA2s811m+ANO9kWCnhH+ms60Z
 jwLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs5p2KwApf64UukywUhUlEaUh4aWl/Xg1z4suADhw9ywKk6wTMsamvA/X+SkUUtw71/ame+7GcuU1/@nongnu.org
X-Gm-Message-State: AOJu0YxuU33BxaIcowXItBpoBTd4KlMPJ9axU3INZGrfElj27XgoF4td
 lG5E1UBOODxHGwwHYSPYOArvv/wD/SeyAIEwZJxLDUkKX37xLsb2q85Gb3Yl5+BcXa8=
X-Gm-Gg: ATEYQzwC4n1fZCubOH+h0EV2NGcltN9RfYLAaUbYznXDCWAJf5mCv4XNsJKCN7bE4oQ
 Ep0YXvanSV0Qu3eBmH3Yu4GadVcJAbiK69eYz9wnpRcwlFEkYFe+zZAyMWLLCSY2n+1CfZizphR
 K3cfPtvCUp8HTk2IVXjiYVY5Z3GujcKnGmscuWf6gBUMcZJo5tYdYNCwaJDmv31brMkgplNLoUr
 e87MDpEZpbU+YOshRTfx+vn/0cDLVhizqnfZgQlqflP37I8Hn8RI4A0c8Q8UgLXAuSoxkXITOMf
 kriUlYF8fqfCj+hUxojQuV5lo8XECjAe3XIBa0/c4mbmLX2FNZMxVTiWedhb4J5UNj/glXEB1lT
 DaQnDK4jrbutn0YeqIrS823NTSa1WnK4vx8up8OGrRirbtvMXcBWlI2mtA2/S94Mq99SP5iXgVo
 4W07Erh3pKIf/JWljryfyuS25nDESBGDnMqF9tJtMrQ58XHz0VrLgwbJ4+oI7dfKpF4jRG
X-Received: by 2002:a05:600c:a415:b0:488:80b6:872e with SMTP id
 5b1f17b1804b1-48880b693f9mr14227495e9.2.1774962484441; 
 Tue, 31 Mar 2026 06:08:04 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2570b18sm29920911f8f.31.2026.03.31.06.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:08:03 -0700 (PDT)
Message-ID: <f7716cca-5081-48d0-8f0e-591b83de0f6f@linaro.org>
Date: Tue, 31 Mar 2026 15:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ati-vga: Add upper limit to x-linear-aper-size
 property
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <541ffffdaa4c67b9dcbca6c2498e69b137bce95d.1774904832.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <541ffffdaa4c67b9dcbca6c2498e69b137bce95d.1774904832.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 30/3/26 23:09, BALATON Zoltan wrote:
> Coverity warns in CID 1645968 about possible integer overflow. This
> should never happen but to ensure that, add an upper limit on the
> x-linear-aper-size. This may not silence the warning but makes sure
> users cannot cause an overflow.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/ati.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

