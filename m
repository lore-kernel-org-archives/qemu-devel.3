Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4E1C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8hz-0006Ui-5O; Sat, 21 Jun 2025 20:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8hw-0006UT-Hw
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:37:16 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8hu-0006G5-QU
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:37:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1430727b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552633; x=1751157433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0K3NugwMiEAravQyAliOQfR89qe5YNCeV91HYu3qV4=;
 b=n6dTemVxkGTQ8DUOG47XnXE2rzPJI6Zhr1Z6WmavJfQNN4vP61sv+aTrEBzSdsU9R/
 kqFoB0kniSeNlJ81jJHrcknnxsCoPyx0HFmMqLaHlQSDRfqeu4R4neuE128rr3+145kj
 Lc997XMxK+8P59IaCBCe/Bvnc3QjLbNNDTs4FEgzRX78V0++6u/BhT1nK9E9aWB56f8m
 w5Sx414kMODPNESpTQKr3vNCcYBmLjpQ5wpzZdZE12PCIxL/VRtMKmDXfy1waVWWoDTr
 9W603EHZRLbzcdd2/l3MjZ+rhr40iBw/DPRsCxetFZxjwkRu/cKVYIo1M862MbKiwSLS
 4Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552633; x=1751157433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0K3NugwMiEAravQyAliOQfR89qe5YNCeV91HYu3qV4=;
 b=bg5gT+NK2A26zQJiFUVVEAXazsUppZceFuNO/zeP1Cp1HfHJXxDel7oRTkZIXso16P
 ePLCgmJOWV858e52dSnOXN/WhjaixNAO2MNI3kS599EFyfbUndhfuOkpaoSkr964u4lY
 7jLyul/QlTGryU7gImtpksV3njg3oXFoW+xgMoICVHcvyVqjyFB2XCHidTD1o+6SCPuB
 tL/QGSRZ2us5Gn24gA2Gj1ayose+aOmp7kOuINRGo9LAvLnMlzh3QoyQDNP/XUDDkVUA
 6Au0gJ24569/Wme/XIGznQi2V5yVDGWDBUFuU8lI7E1BftnCU/pi/dFnl2CBwMU4V8SC
 utTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGlQjOhkWkZiISWJ1rIAK1LIMAqgUJMk2viWBXIQc51kZl5QneHo8WgrW6SqrImJAPY8F0yTCbl4Ta@nongnu.org
X-Gm-Message-State: AOJu0YzUKf5tD7cF5b7sggfW86OlhR89h/UveiVaRdob6Kuf4HmJqu9f
 jNNS386BhH2Ulyuc6qphysMw7KV/tkMopS7FzzoVJEfSyyulLSk0bUdOXlNDVyMkkeOCNhIBmk+
 hJUDTYes=
X-Gm-Gg: ASbGncvHSxS7VqjIVICu6qLeeP/SKBkhZmlayizmrJUO/60BOaHBYBg0EXgUV4xhgnN
 DcP+WfcsNvPu83qBJNHOQxX4K+JXsKY/ONY/hPJjzxAKQ5STTHQiNy7gfa5moiOzu5+gOS0uvKM
 XEs7Jc/J9bVrZb9v5AnwOKaIZHW1F7VFfsNScsqA/NUtraxzp3Ro/3qlSfF6Nb49w0mMnMPrRh8
 mB2YuCm8KCa1NNUzesKWoPQtubZV4/J0izZMGX5ZX69OVCC1ai92t5WzAZrjlZlk6BuhFBo7iId
 KDRQWrTXhIrzLR8pkupkcI994uq6oka70G3opQN/mfr0yDfREzLr1I1amPCzSyaNyu4/4XaBMQz
 hAjbB3mgpRkabWUcZI9oPu8QIV4QI
X-Google-Smtp-Source: AGHT+IF6632WlgOfZ8ohzMielno7lAjv6jToJ9aNUm0QFfkdh2uxDhaGxoQrAC7OKMTP/Y5NFaIjRA==
X-Received: by 2002:a05:6a20:9f05:b0:215:dc01:8b1f with SMTP id
 adf61e73a8af0-22026f9c61amr13187116637.32.1750552633341; 
 Sat, 21 Jun 2025 17:37:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a694c74sm5054155b3a.152.2025.06.21.17.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:37:12 -0700 (PDT)
Message-ID: <3c4b14ff-31fb-4701-b448-ee766512d651@linaro.org>
Date: Sat, 21 Jun 2025 17:37:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/26] tests/functional: Require TCG to run Aarch64
 imx8mp-evk test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/20/25 06:07, Philippe Mathieu-Daudé wrote:
> The imx8mp-evk machine is only built when TCG is available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_imx8mp_evk.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

