Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D9DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 06:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0aW1-0005i7-AJ; Mon, 22 Sep 2025 02:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0aVz-0005hr-EJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:59:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0aVx-0008JU-R7
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 02:59:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e9042021faso3172030f8f.3
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758524348; x=1759129148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3TrDNN+SaNnGfqX0st6UljeB4F4bS62VvZnuSvsaIcU=;
 b=CUVtHoEVoYkV4xlpylXixxY4WtBpfJrN89aJfRrkbeJA6e2ZcfUoN1JSW/9REHSN5I
 0qKnDBXwzSWYCNCxe7M03etpQTGa1SBbKDJX5r0JAPa4CDQW4gLjlPRrfs0n7bpt9yBw
 7IlgoHy4I3xoI93huk/rVLQ9Ky1tf6lG6c9VfjJqcTxbWNn+sFiZcmOMS0crL1Zo8Qb1
 Cbq4gR7ZxwXDwczxbD3/U4Ca057LbxZaQQjbyT/qQJOkOrALzl72J9Hi3COFmBMIUxhQ
 G+d/dr2tFhv+VZa6zYEJjI1fOfSNSLa2TFk5ZnlEiG9YRJONUWe9t8iWPxVwApABtCUw
 b/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758524348; x=1759129148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TrDNN+SaNnGfqX0st6UljeB4F4bS62VvZnuSvsaIcU=;
 b=V4Je8Owo7t0MQoRDsLwt4tQNzC5jORmu4jO6onLu+R4Q4/18i5lCeSNQIkpMZyhtIw
 QuIdus2d8RpL1MlCoKefbW8AetKjymdKCdDPneaJr4YCmXHPkYjMBARQr2TiER76uS9+
 wyFI/bF83IooLc86F3r6eyHRH20MD8LubK1cj3IJ03U/yUMBEYgmeZjSkooF+sKuAS40
 gnSzKVg9zuHZ2KRumZM8rnNZDYvJGVWlL90oOmuv7cll+PBhX1Qr38NA4VpNpo5W4bVH
 5Nv3wRVIHiCUe0QrLVzyqTYlm4Kek6RSeLFr2WtKIAYgEbG9jTFbeyBld0MPxsK0f0Fx
 CjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKY45JV7ahKXcLvJBs4xmEg//NyMnZef/QHYkTbDwhCuVIXIQPYd4fZAjH52EAQEEyw4YVXldAmplG@nongnu.org
X-Gm-Message-State: AOJu0Yx2mb9m4sU9wt4HjF76m4G7eBCequZifvBwQAK0rIf54jP5rPnq
 lZ4CScNqKun04IwpWhDFA9xfXchg4HTHOD2sM7FC7CORIDH0+WM5z//VAev1l5jVSn0=
X-Gm-Gg: ASbGncv7QFYBE/6SfVITwC1wg3ZiQbONluv4diQIUkc9DZi8QM8bF3pcMxs6r148n6a
 iR9l8XI2lWt8k/S+LIvb6EzXeTHZ4oRQu5PeB0raoqyJh201JtJGrVRY60VGPnPx/aSMbFJXoWT
 b1+baYcg0X36XzqNv3LZ88ur/EIVjhWqhTeBE1Y0c6xph2gSBdAIKaUCBZmtQc6uNr0KOxS5zpj
 uo4bKsWRxBn7O1Nky9KWnuibDIaRCdP/oMdRS9vNmgiD6HO7Xn0GmGIIKloS5dJeJ+nf7Vc6HiZ
 GKCkoC5MTlyIqdFzn78elrEQmDV/cZVprITDKm83CiNXeqe45Cwg4ZfB9VYFE6eM5I0Xf8Z4nIJ
 5XQPUNE4RR2kte5lXDS8UPC3u5DGM4pSsa9vZkmX7MeA2b88W0NoENs4g8d53OIwqh6r2G6w=
X-Google-Smtp-Source: AGHT+IEDSU1AZQ+WzavlZzIBhKC/VWEC0uYtRTxB63EcjNIIdNuD7aEifZ8qIVZVoRj+Dr8142tVjg==
X-Received: by 2002:a05:6000:2203:b0:3d4:2f8c:1d37 with SMTP id
 ffacd0b85a97d-3ee7e106162mr10244216f8f.26.1758524347691; 
 Sun, 21 Sep 2025 23:59:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f5a285efsm212240755e9.18.2025.09.21.23.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Sep 2025 23:59:07 -0700 (PDT)
Message-ID: <12f33412-18c0-45a2-8acf-abb4cdf1439d@linaro.org>
Date: Mon, 22 Sep 2025 08:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for
 MicroMIPS and MIPS16e ASEs
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250814070650.78657-1-philmd@linaro.org>
 <5f3ccbec-5f6f-42c5-bb65-1139a7fe86a6@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5f3ccbec-5f6f-42c5-bb65-1139a7fe86a6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/9/25 22:15, Michael Tokarev wrote:
> On 14.08.2025 10:06, Philippe Mathieu-Daudé wrote:
>> We weren't parsing MIPS ASE in the ELF header, so couldn't
>> automatically pick an appropriate CPU.
>>
>> Since we'll have a rc4, I propose these sensible patches
>> for 10.1, but both ASEs are available since 15 years in QEMU,
>> so this isn't something broken since the latest release, and
>> I don't mind holding it for 10.2.
> 
> Now I wonder what should I do with this wrt qemu-stable series.
> Since no one complained (?) for so many years..  is it worth
> to add this to previous stable releases?

I fixed these for correctness, but indeed nobody cares.

> 
> (fwiw, all 3 patches are needed, obviously.  Also, for 7.2,
> the following 2 patches can also be picked up:
> f7e3d7521b4 "linux-user/mips: Use P5600 as default CPU to run NaN2008 
> ELF binaries"
> 3e8130da7c9 "linux-user/mips: Do not try to use removed R5900 CPU")
> 
> What do you think?

Ditto. If this is too much burden for you to carry them,
don't worry dropping them.

> 
> I picked all 3 up for 7.2, 10.0 and 10.1 series for now.

Thanks for your careful work with the stable tree :)

