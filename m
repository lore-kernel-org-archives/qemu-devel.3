Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3762AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaV3-0001lt-BJ; Mon, 10 Feb 2025 15:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaV1-0001lJ-Er
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:35:23 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaUy-0002Zb-OI
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:35:23 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dc962f1b9so2054034f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739219718; x=1739824518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1OPLDx3OlnXW7DyyBBfUvXbj6MJEsG2ibdWPRJVsC4U=;
 b=ZNc3zlGeFs8n3DdXnw2yk77hTXlGdbtw0vbP28mYBA7agPOH0ZLheieeaXG9yjZTuN
 PFVnvbcp1T4WcRmlmNvXR4SfKKfeNu/g8yXLSIxWwLjgMZGAVTria7GTTwAHkn1OA66O
 yhSlkIcjMQrd9XRn2Ox1xpbkfkh/CfSj12ncM8ca+xdq3MzWzYIlDruXiBe7bvVivako
 DWaI5fJhmQ5IJyDKD7elg3uy/0ACNrlUSEjSNKW79EMRF+PBBkO3Ri+yLpY843hT7kVo
 nCaZDsSfFfwuv35qMGjt4VzCmoeQwb2+KiGfI/sNDzG5KuyoVWKMVAuabPJikyo5CXwh
 1Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219718; x=1739824518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OPLDx3OlnXW7DyyBBfUvXbj6MJEsG2ibdWPRJVsC4U=;
 b=LXpd4caECZmnQJsWrmy70ta/EPB997Y6WDX3Z9Xdl/o0QWlLrPYdNCVSFR4Mh1BNhN
 FTvTVFqrQi9RC6dAK/hku8WlLCy+2i8Hf9TzRtdWvx3dbdM2Cwm7Er+wOyWp6dy+SxWz
 mzUM6CdY7gZ37Ebj5j3R/QylgFofC/6HfSAWux7B+VJc5hIqjMrYnJKAzI8O8gngaKnD
 sCLkz1r9Hk46Er6Q9Q0cb3e6npL35lf5pzTSguyifpE2ncxLwKmWuztc7yuY0+T/h8yU
 ewAcjpIxL/E5rC9Hcs4+DBMqRw+VV7llbjYhuwqbJMWA7bYr4rm0i2puRSmPEi3n68Yv
 GKlA==
X-Gm-Message-State: AOJu0YxuV/npzkm8/WXEriRQg2Yo3Ei6h/wwbNj2gvS93/Ytdbe6LJmV
 yKOeHYqaGZ2/Xd0s93J11q0QkfslG7ZngyHC8EdzMfyUBK5EHqgpmxHUc7wcvTrGqojm3u6cdhz
 zyUM=
X-Gm-Gg: ASbGncu1bj5hAtaf2thLZUNJEONmL19C7NEQBJ3D7wO32CKyP5jt6Sipp8u484JGmtt
 NYwlnxTeSxxbs7HvH0KkN19GcwqvfkHxTXXfJ5XVhiRX0BqYFlT4aTE4ygUV/6l3oAAUUoIAkoB
 hlwE5shhz6yZyvkd9g7Y2KKC5v8R3y/VMApXbKnlyhIQRTX4jYX3aEhWmdWvrWKBvvvblNQQ34o
 ST3rOHPOlknNRfnYpf0GuPSnf3G8CcisdaWmEJtbwSbac5Pgg5GKlhZn7i8ymNXlv1o0Z387mVO
 pU6nfHTK73bIl3XmVjOXBvtH2xn6RvPqnyk/TEjHjLaR7tI1rzHg2shdFMw=
X-Google-Smtp-Source: AGHT+IHRyo/pS1ztLMeU18aWCsAwFGjFaF9PARkALTgVZ/LdDCb2Vau1CcaK3cW1jak7W2Re9BFgiw==
X-Received: by 2002:a5d:6d0d:0:b0:385:f1f2:13ee with SMTP id
 ffacd0b85a97d-38dc935f47dmr11658801f8f.46.1739219718491; 
 Mon, 10 Feb 2025 12:35:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm7704453f8f.62.2025.02.10.12.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 12:35:17 -0800 (PST)
Message-ID: <029d71fc-6710-4553-9a96-584e544aedf5@linaro.org>
Date: Mon, 10 Feb 2025 21:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] hw/microblaze: Allow running cross-endian vCPUs
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250206131052.30207-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/2/25 14:10, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (16):
>    hw/intc/xilinx_intc: Make device endianness configurable
>    hw/net/xilinx_ethlite: Make device endianness configurable
>    hw/timer/xilinx_timer: Make device endianness configurable
>    hw/char/xilinx_uartlite: Make device endianness configurable
>    hw/ssi/xilinx_spi: Make device endianness configurable
>    hw/arm/xlnx-zynqmp: Use &error_abort for programming errors

>    tests/functional: Explicit endianness of microblaze assets
>    tests/functional: Allow microblaze tests to take a machine name
>      argument
>    tests/functional: Remove sleep() kludges from microblaze tests
>    tests/functional: Have microblaze tests inherit common parent class

Since there is still an open discussion about what machines to
include, I'm queuing patches 1-6 & 12-15 for now.

