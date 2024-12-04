Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D79BE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIiW1-0006gT-Uq; Wed, 04 Dec 2024 01:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIiW0-0006gB-HV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:05:36 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIiVy-0002n2-Rd
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:05:36 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ffdbc0c103so90572861fa.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733292333; x=1733897133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbOEd/nn3E3RCsRljefkMQyXB2HzFeY7HQCRIcpQ2eo=;
 b=mj289LUeqjmm3k6A6kpILZ6UX1aE1QY80EJr/qUWIZB3TdOc5aynkfXe9P4z3IwWKo
 ScSDcEE9bCjKKxmpX2NAIr8uApTUsA+iK/Sn9CagSOmrLl8crNdtgUEiOyNKpm4MVYKG
 te8K8LOLMBOOTfYsmHT4Qjr+IDCLHD+y5oI6Mebtr+dlFfiv0VBJ7vLhKCi2wXAln/xj
 is7Fl7YwEy12XujuhBmMmHmZh6lBbeoXI8kXkk5GoeBqIvgryoRkYOAWL6eDW9chl+Ax
 A/qYsrqcmwufzPngMaSeGWIoXM/8nj95PkMwaC0Dmh413XD8BgfXOcrHKP36ydnh7ZtK
 oI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733292333; x=1733897133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbOEd/nn3E3RCsRljefkMQyXB2HzFeY7HQCRIcpQ2eo=;
 b=AxYKSoxHnKi5wmlnfZjAcP0epy9dSkhtEsPeGzNmEogW82ZECoW+dNr1dOUMnK2cDQ
 dlCW/NgFX/gjx3hOaAISEWQMtx0o+PgJ4s6axzIXrGl/jTnuty0PZVtm6e81Rz3w4ikF
 ctnpVE9oRu+5oMiwE1vKY6Z45eI8zTJbCLE+a+MjhZqp7ILDmH5QPKR9SVxfT+SzsA+N
 dbCmWJ1u8EXY0FoZPe/0IkM02GuAmM2wXWYMwwAAPngErgfNHhuctVIBFKsrVQVyuewB
 IZJZIYPCUv2gm+3pB57tToNMn4WdnNdAquZH7I0aOky0BeBzIACld1quu2221V6PEmzP
 MdDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi9fjXJ/2FWN+v4AKqS3dAB0FCuHiOKJTutCwB5cxu8orTitBn0odGmkId8ASECOiO05exEWSVGH/q@nongnu.org
X-Gm-Message-State: AOJu0Yx0l+A/f7Jk6gd+p8eJHkHutcpL5IMj+cYUf5Tc37DO5ZLHFpO9
 737jT3DqPb6/ZlirDAeZXtyBpLfbEuo5KwP0koWwmxRP0ERM0AkCU71RPj3Q4jM=
X-Gm-Gg: ASbGncsUjqjJZrzr46BCNLdx0cEgV9HwvxIKRXLuW9hHlWSUcAuNGkjYUO3ktpAdqed
 vwCZfrOIe0s4vm55bu2zGSEhQzUWAQmjAqtTmM/o2293aBXeybRMPugumMEWV9jjGSeqwum0mRu
 7HTquvkJfDNXDmYHks3aAtmUaWJ5OQ/kISvhf/KgOXmPlW8iQCcU2NB8BTzRdA60a48ANYQt0fF
 hxR1EhrBgXxTjghtfzl5p5KgbA47pSF9f+spZasnLT50KZ52ALLdA/duhAyv0FLIEKe7eX4V4Iw
 T41PcrZdOT47n9o2SlN4uC8L+jUagaPF06bTd14V1A==
X-Google-Smtp-Source: AGHT+IHpxlMyJM3DtXldymS9fvdYAgGC7rCmm7szBUw/NbldakHjvWzCtkkHCzUShSgDXMhtlNqz6g==
X-Received: by 2002:a05:651c:b24:b0:2ff:d133:b54c with SMTP id
 38308e7fff4ca-30009c63bf8mr45410871fa.11.1733292332731; 
 Tue, 03 Dec 2024 22:05:32 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e6d7esm689603066b.114.2024.12.03.22.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:05:32 -0800 (PST)
Message-ID: <34e1e84a-a7a1-4b82-b48a-f3c3fab31cc6@linaro.org>
Date: Wed, 4 Dec 2024 07:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] softfloat: Inline pickNaNMulAdd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> Inline pickNaNMulAdd into its only caller.  This makes
> one assert redundant with the immediately preceding IF.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc      | 35 +++++++++++++++++++++-
>   fpu/softfloat-specialize.c.inc | 54 ----------------------------------
>   2 files changed, 34 insertions(+), 55 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


