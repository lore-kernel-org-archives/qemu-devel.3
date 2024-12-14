Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9BDE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSPI-0006LR-7m; Sat, 14 Dec 2024 08:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSPG-0006Kw-0p
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:42:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSPD-0000ge-Cx
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:42:05 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso18285025e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734183721; x=1734788521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ahi267ki5vYUZDOwg+ix38OXxZvj6kYiJn8Ue6NFTUk=;
 b=QaHVrSa4DpDll6VIPj0rsrj6Hjo9XSTFSjdFoSpmgU+uSPKzaNLsiBVEvXb4PmJ2s6
 gB969BAC95NkU+vzBCDCrOIUNAjwASxL9WuBRSTker6zPOU3A6E/FBkviVPmcbLF69jU
 aNauqjG5g0pDSwuLgu37UZeaE4H0aQa4T02NwAL2blHRmYvF3OTbFB/xU0m5fH4aDf1k
 R29dMvsRVXuUjmcddB2YrutUtNuWH4xEqeDrFUAK7YdZzJ58imbXeZeYnF5D3RTSbs1f
 wXHAUfIrRUzvwYB6RGchR9xOBYYFrcSD4fCwfqBGJ2t6HivEHzU7l18oXpyKG3lAMlry
 th1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734183721; x=1734788521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ahi267ki5vYUZDOwg+ix38OXxZvj6kYiJn8Ue6NFTUk=;
 b=dmRWl9H4ZB8pmyWsiMP6WAs3NpEYfhzCSTT1OoazKZv56xSxN/S0KzaB5q1OPuX6BO
 TyflxaYIXNxS0Oga+DNi5m1hcSyu8oFmgUBytV4uo87RGPJpoBHLmwH9khJuGY7F9r8L
 Z26ERTzsWK2r/Lar+2MzLfRO259x3rULGzRL2pR75WCLHQIFJ3cxf9owFGHa+P1lFUC8
 84qjhHLzC/1s/k8tsi+vsE7ZcO+PLtbR1SPuyfEMGxfy/2evlHErKriwKlKEQc4L/q1T
 i5cFW4T/6VNIK9Pp0obRw3XAKuyTDbg0Q4VIUu6RpGxrAvFxNV4sectSKw/HlZpPTbHs
 lQnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB7UbACMARrEg6pJFMWVRGXR/KViuJwq+LPNTOz82UjqFpUdPpZ/KPiO+LvXxgcHvAQXVKV10dDq37@nongnu.org
X-Gm-Message-State: AOJu0Yyilc++egi6TzrPxfJ0WdJavFtehv6jjSB9yLBusslnPozpSflf
 3rFkUbOBFdvIi4p7kWc0r+jmwAIRdznM28ZDbz/wq7yFnoryl6yYcTnel1D7mr+tgiwp0myjg+e
 yHLM=
X-Gm-Gg: ASbGncsyNZdOM23Ymy+DtOmyaKresQrzMWDlLOB1/Ig+6M5kvvseCRqmgS/cHeHNJ/8
 XTQIdQiHZw8A+brIwIVmN++CfOIopMWwVqZquBJG2r6TqzrTVOeDvtBOQvjwBiLWuwcwYg3MqH8
 K38hDFZ3NWBd1lwdF02QBgyKP2MsscIYeNKQ/lRHgrnJA4N7VBj2hxAa7AFKvMLkfxFeJEJVq0V
 oRZnSEEVPDN5zatRi+aESLzb/XmZJiaZsY/0GqK0ay1o+eWl0/Z3A9AAWOE+q3e2Z+2s9hQZKNj
 VRpeLSu5YCOZaka4hCpt5kv4EQ==
X-Google-Smtp-Source: AGHT+IEpGOBVSYRoZkdmP0Q78N/bB+iI9kSuQVq80k28rPB0txZ4PMs+c8yPpLaRF/ksVpW8Jcx+Sg==
X-Received: by 2002:a05:600c:384c:b0:434:fa24:b84a with SMTP id
 5b1f17b1804b1-4362aaa9441mr48947225e9.25.1734183721409; 
 Sat, 14 Dec 2024 05:42:01 -0800 (PST)
Received: from [192.168.224.213] (201.19.205.77.rev.sfr.net. [77.205.19.201])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625717c9fsm79965555e9.44.2024.12.14.05.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 05:42:00 -0800 (PST)
Message-ID: <de034e4c-c209-4a0a-8b47-cae37ef8d98b@linaro.org>
Date: Sat, 14 Dec 2024 14:41:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/34] next-cube: add my copyright to the top of the
 file
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-34-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-34-mark.cave-ayland@ilande.co.uk>
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

On 12/12/24 12:46, Mark Cave-Ayland wrote:
> This series has involved rewriting and/or updating a considerable part of the
> next-cube emulation so update the copyright in next-cube.c to reflect this.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


