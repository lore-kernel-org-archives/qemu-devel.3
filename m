Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA8CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeBK-0004pG-Ai; Wed, 22 Oct 2025 15:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeBD-0004ov-1p
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:07:28 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeBB-0006st-Dj
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:07:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so4796548f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160043; x=1761764843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cj/Dnpolmh6SNIOBQvRfcGc8MVS05LQfSDEUxUhz6GU=;
 b=haIDEQv+kQfFsLRniPD+PfcbnNOSZgtxLwuJ5mUZ//yez90i5KFKGHRYC95CYe3d8+
 nNUvg/nY5w9EsQXc03boU0V1WIvwXTigRy6jVFEOXr2MfPO1Iu1gSWNGbgbqRLbFDtyY
 V67AVhejWEhAQf9tPmPXUJvll15Xjjxhh+mBNNxjlSLT0gI/Gbzce/D2KEaHPOSEfPwg
 WLC/88ZHdg5LB6rSehjlNOm1dqAE+eMKTCAn88AT8uGB6ahBylYE0GFbj7561ybAd/GC
 A3qU+Lb12XTrY183OCQ8wdInVTDwm8llzH8x0tgL3EivGhA+rhI1g0u6gSzjmZQj1k3P
 CCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160043; x=1761764843;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cj/Dnpolmh6SNIOBQvRfcGc8MVS05LQfSDEUxUhz6GU=;
 b=CqTuCp30PMbUkNE7FpfdOsFo6RaoyUnOz+2U0CfrPYEJEtp9g0B0bRPp567wc3rWXc
 KqkSskH+XVrdlhxm3bRNOCS/CSAay+hop6w/DyP+/wbIxrzIEyB7m+Ctwfk1wCduhGVD
 5SmyYJXZtvgGuDKUbaTAgX1+bT6dUo65x3dPwrZze0rnM/j/S/tNd57RLYeHf2DZvwE/
 76fXjCVL1v5OVkEovo2gYdCmfZGu2qIzdFoiU4rzJRh29zV2iTSgq4tWzE4IbgJqtgFV
 MMNisThbZygzBwPK+gLSIzXQDGw4wNCUjTTJXMbjdWBfwztr/zfmBJnVbjuM1zBiRxON
 JEMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx1Ldb97CEznqA50D2iMDcBKac8DVUMtFKKmtH56uZeunBXB1NRkFZ9VTu97UFZTCQg5wOEp4BPV2b@nongnu.org
X-Gm-Message-State: AOJu0Yx2djTqD00i0SXbgZxkDVtaWANZT7ZjQdLmE7UiSgG8WrJPATSp
 6qK3ICC6jORUGauvmudaeWSvz0ldZ//gJIV6fr0GcpFfH61vOyZuW1awAH7CZb8DR3BNzA8yTtC
 DNvDNsh4=
X-Gm-Gg: ASbGncsPL4Ky7x0Rk63B+N/cqCbH4CA3XU8+SUoEOzwWEsRoZvz9HkrKFcSvZ0xJlGM
 2D/GISyIP1QeDdyPtc8vMB42VzZXIUSKPHqWrG/XMzVSx2o6aWpQRNnaexZ/6VuLjUrNuutWaoF
 vRQ+JtQE7bK5zHo5ebYh4fpLXfoGw0mKHWi3jKmE7iwefz7KU90/UcISeeuvsFbAVKVI5F7rB1s
 z79zs1A7B151uRwnIm/cS40uD4yoNxjDSPmSs+5687RkcG7Akn5QhaIegjWYtglPXv3Ga65AZ/C
 lSwckvIf22umgpqD5zZ2XYUKwbstQNSeIg/McylfztbCfT2/I/fx/jF3spClCoUwX8OvWWlXfD2
 Ir7t5Cx2D8OpUlFBb5UZLMROCBKhV7BoElzI+z/V97f/DVITdoDsKl3APoo+EEcHZTHOBy1iARo
 cUcFDJOz/54KEOelW8chdxYM6VSvUuhIwheXZ3g0PW34QQlvFg4uiKVQ==
X-Google-Smtp-Source: AGHT+IHW7XWCvhN5SZsVtVRi1h4mK0qrVBFugWRUUik/8LjY5661iVbaUSeGCHztzkV6noJzS+JN3Q==
X-Received: by 2002:a05:6000:1a8d:b0:428:3be9:b465 with SMTP id
 ffacd0b85a97d-4283be9b5bbmr12039821f8f.51.1761160043109; 
 Wed, 22 Oct 2025 12:07:23 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a6c5sm26950444f8f.28.2025.10.22.12.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:07:22 -0700 (PDT)
Message-ID: <d551df6e-d18e-4fdd-94a6-f5035096ab2a@linaro.org>
Date: Wed, 22 Oct 2025 21:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests/functional: Fix problems in uncompress.py
 reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015095454.1575318-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 15/10/25 11:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> - put the doc strings in the right locations (after the "def" line)
> - use isinstance() instead of checking via type()
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/uncompress.py | 40 ++++++++++++------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


