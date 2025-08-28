Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DB9CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO6E-0005mC-AZ; Sat, 30 Aug 2025 12:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkma-0006E3-Ur
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:07:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkmY-0004Pb-Mn
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:07:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3cdfb1ff7aeso704548f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418864; x=1757023664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66gdu98n6/HjcL+4A8OHa+2xjTTxkZ7IxSyMj1Xo23U=;
 b=d26kq9HeX/1sWumQMN/ZrE7rIyETA0FWwyqirFJyFkmwXZyE1GcUjUYJz4r0YbZE9C
 5LMkj/jUKO67UUv7uXhdBxpvc4uSbwFPC7oOarj5EHGtk9SJy/3jjqwYvL8M79prJf08
 YBq5S/e66cH1z713YdgCdQmlInoHM9MvtlLFU0BrFrzMD9C+MdzpsgXVdm2/+jKTEQJ0
 IYiIHDFVocR59gD7gDfNC8j+ocGpc1YZEy0ctSXYOE07Qg3+u5qNrZUQDX62yyvW/2lb
 S3p/UP/avWgDpb3mrARx4bRAXKpoDrD645BAEH6UyeyIowYdTMwBo3qVpg7VKU4qXKzC
 2lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418864; x=1757023664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66gdu98n6/HjcL+4A8OHa+2xjTTxkZ7IxSyMj1Xo23U=;
 b=pOs8RFoTqAtqa7Z6oWC6hlnlUh/c/gV14Niyirsu0ggrGBcObBPKQGQzr9Vaqe7a9V
 8k4/eZVUocLSDg/3Qsb7rkfHCwy2B/vGXkNsh+lLFWd73Ym260cc9UbDqkpmyEmT0WX6
 m9YnhxFfePLMxmv9MPDBYsOVIKkIoa6tBggO/eBS6k1AUvDSw18HSH1aPLvc6o6RgaRy
 zqYWTMkomAnX1B8ukIDpmUx1qmR+t+ZZjaq7xwkMFxNIwXv7QzorkKQ6x/UpWa8atGhO
 52oQA2fVOT0x0RCXU3L4L57QLh2n+BGKQHysxV1rVBATTRKRSqMuo3rgtRw+x4VGRHA4
 +ScQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb+msR4YlHtirKPQv2kRqZZZ22IEx2X91KSTRkQalPVG+PweVNxd++UjY+u5DVDS2tmqZrf/EO2y6v@nongnu.org
X-Gm-Message-State: AOJu0YxGm0vgjTm2y64SbVVhfahrjx5tcnlM930FYHoR/pocbvm1CtXd
 4F181hAqjrtMgVb4xsma4JPZ9LsRocTJ6S0hG71lpNf27A0aCKEaXO0h8pyPE8o/Vcc=
X-Gm-Gg: ASbGncv/mvDtZncMXeKktjpFOs++pezf/GwA3Bz+PU4TczfvTwoMvcVpAsH7tEkw5uu
 ZK0Gb3/ZVbUnE9HryqPdJsysDwiShNDocAD+uLutVPxUDRXCYR0QUsMK+TdPmSxZ1Nxo2/ENo2A
 JElIW79fCI8Kqq04Dt4iMlfKwi6gGjucqtf+eZ2P74rPeIRyheIEfWgneqLZU22SZY+PuYw50Hw
 kSWriNuW/y0M4UrqMzvpIbi9jvFithjXF3s+IEIXeicukpOqDSjKrhQR7idQ+cTVM0ldghrA5Rq
 9hQ6Y1mMv9wcmlLif3+SvzxHA2NPA7TXIhS+wCr0RbnJ8MO/0j1Kua6rPeg9Bgf/TJpJGEHsK8z
 0H3HP24pDshFJ9lb1VClIvbMl8BFT+OlLJhiKaDnMy26uhnskQ8owoZchzmu0vno8lLRaLtJhs6
 /t
X-Google-Smtp-Source: AGHT+IFgCNYwf20THSM76ZfvjsKEe6bWkikShrRXtLAmv+if23JrxY/YuoBAUkvrnK2gBXoyXLQiJg==
X-Received: by 2002:a05:6000:2507:b0:3c3:a80d:2b98 with SMTP id
 ffacd0b85a97d-3c5db8aa404mr17866439f8f.6.1756418864264; 
 Thu, 28 Aug 2025 15:07:44 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7a9404c4sm20359065e9.10.2025.08.28.15.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:07:43 -0700 (PDT)
Message-ID: <36328ac5-b5a8-4826-9d44-e30bc38c853c@linaro.org>
Date: Fri, 29 Aug 2025 00:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/47] hw/arm/xlnx-versal: split the xlnx-versal type
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-2-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-2-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 22/8/25 17:15, Luc Michel wrote:
> Split the xlnx-versal device into two classes, a base, abstract class
> and the existing concrete one. Introduce a VersalVersion type that will
> be used across several device models when versal2 implementation is
> added.
> 
> This is in preparation for versal2 implementation.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal-version.h | 15 ++++++++++++++
>   include/hw/arm/xlnx-versal.h         | 12 ++++++++++-
>   hw/arm/xlnx-versal.c                 | 31 +++++++++++++++++++++-------
>   3 files changed, 50 insertions(+), 8 deletions(-)
>   create mode 100644 include/hw/arm/xlnx-versal-version.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


