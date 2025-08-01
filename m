Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E79AC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhk3o-00029I-RP; Fri, 01 Aug 2025 03:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhk3W-000250-95
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 03:19:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhk3U-0002QL-KZ
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 03:19:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so700632b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754032788; x=1754637588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iwn4QtUwf422kNcNHGBYhRzeO2MDBiHRVwcP1EbYnSg=;
 b=M0a1BWcip3wlFb5OEnNhqlrFzA77MIclbftLq6C0XFl4dvxmqBMktjNerxhRsGOzOb
 +HRiEMZvqKF6ulY4nIeAlioanVtBROe+If8qSaM6ZylIEH5dqd1lbCPxbGvVX30Q3xuW
 xNwVcdkl+uwJI4zcoTtngoq8XAZRb8s+IuwnhbegKJGfpLOfer+iaQ+9y7EV0lXQyZ/5
 m/cyihN1b9fJch6f0mmq/Bjc/M02GZyHUigTX/+MpqGpPronyrPq7B7rj7EsltkoBJIw
 H2U3TldPLt10kPEyOpmt9EhhsYTaWwNIqe3Gb9poPKEUX6mmMR7aZ+n/y5ioCCub4AKG
 LMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754032788; x=1754637588;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iwn4QtUwf422kNcNHGBYhRzeO2MDBiHRVwcP1EbYnSg=;
 b=HPJ2Eucju3plrWD/RNHoTv1SPbImK/E2yhZVdq6SDXaCtLGJiVtRVtBIaVjNgOeCQt
 aN0PCbNgObCviCK3iIShGUPDhWZud0vB6fp0Il85E9a2+OSE20YoxSLV+ZZGpe7V4g1x
 gi/o8ssropKX2ydwdsxg/DxPG/CjCh0bKY6utf1SqxyMq3cqklrT2XiLqKX7uT3mELeX
 eVLe+hWsTz3ReBf6nB9ixzvBYg4Q6aKpOKYJ+oudy5w4skjfR0uECn+O+kvSdBp88XYv
 +b8bPKhMC6P26mGGM6f6EKioVk+MM/O1OUGfo0rVkoxgNtSLvKRZfBFNLQI8ZvuScAOS
 T5pg==
X-Gm-Message-State: AOJu0YymDIuCgp1yk8lS9wCQ6XkAppcAKMPiGjEOF/JBST+CosFgyC4b
 xj+2NeAv9PPYdOjwVld2EjtMNYgSf0wLm6n3VxzUA7z2l80uJXcuURmtcFt3I6ChWko8Mj/uYK9
 KhYUElXs=
X-Gm-Gg: ASbGncs5qWcpZD92M88PkuuHZ3BJ+z86aotkvG6RxNF268t0/EsuI8LSXNTnpBH7ikS
 gZuzMBV+RMjfxp27NSX6SOdzqSHdYXj3FRSNb79N7HIjUBZ2fDp96OMn3H9QsBzAUH/4rqM4Smz
 aGVf6bp5N+ClY6aJn5pbFBYJ3Jd2pvIt6r9dtBo0URyOiwxyeacNF49lY7iy/1ppYVDXsJq4bXJ
 B5l+RBHRMEuoVSgtGZIwMvayZlCyxXfzTKJsN3ZNqBgvEHyioeHQbFWEDjiGz4RwpKF1DsGipiV
 gpMXz5UaMrzpOX6fXgeCS3L9k2mXBCp8GM4jJtNxOjzIYohIywXD+2Kn8AqYeEpCdH0ozaBleDy
 tr7EhIJwidabZxoBLa8Ur0lAzRB1Fyc/NBB0dT7eV
X-Google-Smtp-Source: AGHT+IESWR8mYcKEShQR8r5emaLCUp5MF20kpfhzCF0vnTrpY8fBPfmOERwoV34GMBY1As6EGE4p1w==
X-Received: by 2002:a05:6a00:1951:b0:76b:a582:d55c with SMTP id
 d2e1a72fcca58-76ba582d635mr10701191b3a.16.1754032788689; 
 Fri, 01 Aug 2025 00:19:48 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcdd40f63sm3299818b3a.87.2025.08.01.00.19.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 00:19:48 -0700 (PDT)
Message-ID: <21dec4c1-dcf9-427b-8eb3-84ba278308fc@linaro.org>
Date: Fri, 1 Aug 2025 17:19:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 04/11] hw/sd/sdcard: Fill SPI response bits in
 card code
To: qemu-devel@nongnu.org
References: <20250731212807.2706-1-philmd@linaro.org>
 <20250731212807.2706-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731212807.2706-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/1/25 07:27, Philippe Mathieu-Daudé wrote:
> @@ -746,6 +761,10 @@ static size_t sd_response_r3_make(SDState *sd, uint8_t *response, size_t respsz)
>   {
>       size_t rsplen = 4;
>   
> +    if (sd_is_spi(sd)) {
> +        rsplen += sd_response_r1_make(sd, response, respsz);
> +        response++;
> +    }
>       assert(respsz >= rsplen);

Incrementing response, but not decrementing rsplen?
Missed return?

> @@ -771,6 +790,10 @@ static size_t sd_response_r7_make(SDState *sd, uint8_t *response, size_t respsz)
>   {
>       size_t rsplen = 4;
>   
> +    if (sd_is_spi(sd)) {
> +        rsplen += sd_response_r1_make(sd, response, respsz);
> +        response++;
> +    }
>       assert(respsz >= rsplen);

Likewise.


r~

