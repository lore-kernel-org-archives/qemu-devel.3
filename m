Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01DCCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNSo-0004tq-QY; Sat, 30 Aug 2025 11:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1us26r-0006HC-CG
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 12:37:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1us26p-0006fL-GJ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 12:37:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7d485204so14894185e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756485468; x=1757090268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=huJdIqvmZ+zaJuBuQQp6mFkNWQfYfBe7ou7wyl7+Fmk=;
 b=W7bYHK+stzVK0GKy9CNmXmUYjpm7bQKY759aPbonrEJKUexG/hB67BFIJhLpyN2HEZ
 6IYbAyLgVGQJKsv8HnOV28elbm5FyH70j7Yw0WqLpyE4Gsi1OD12uabGSEtORPeN2qeE
 IVUq6kqtkAmz2bd70vv0IKxfb5KOSawQQrr7trohMtK3J7tM5X270NfzHTQXB0icorRo
 tDKG/x6jq++PDTaGdAmAxOwIH2fBJExCTMqMpvTavCvfud8sa70gpKJfltXn2g2AcAX5
 h5FilVwikRc7bSwpgdpVYaUpPkXF/72A02zzgANdlcRM2G/o+ObuSsw9FnEQNwuw/Z+n
 /LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756485468; x=1757090268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=huJdIqvmZ+zaJuBuQQp6mFkNWQfYfBe7ou7wyl7+Fmk=;
 b=Agug7sw+IYrzZ0JXGBA0yjfzxOnt4PyQc+FRhFXwx42j+xiUNjL/+yq7GlUNBUpxgl
 QhlXW2rvLTSm1bAlBMOffCmPQW/kbDfmKDrKZLiow/4ct9f85XgNv2C6xK8DrfPXI3UZ
 evJokxGGCJGipFPI1778utcOgMxax2o0H4d48mHTqc83ppn5jAECLjyiAaC1/REf80Uk
 ZowMDlifIdm0LkmuEuSbEm4zxDi7hQTcVfg6SJDMfwDBcTTXhfm/9QGCAX+yC7cL0O6T
 mJFbavFzfgfa1jDqNbFYOaMOM3z9q24ymqw926jZLESuM06ZUHFzaETPAoPX3JFrg0Wp
 bqcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnqiHGtF4gPk4pd0Gv+vaaROa8P2V5zTudww4am+fdOJdAzVO+++IUf33I2drE/9V6QFHgBi2ZCyrX@nongnu.org
X-Gm-Message-State: AOJu0YwsTT6oA6+BhNTRiU6chAyHxt1Dfy7TNVwTONCfe+tgVQPi8PpQ
 i4pxBHccr/PiTlxnzxpaKbsxh2AjTnx3/5wXCwOH/4X3+uNA//goX9mPJtEFN5vYjas=
X-Gm-Gg: ASbGncvx7I2rgGsA1338L1K1//ADlk9ysKq99O7ohsHMScmKCiL3p/S/WA4yURlp1CX
 f6T5pkRx0rYFd3jka/M8HPq0ZYRefOD0ihZ0OU7J9B/OKQC9YZAHk6nktcDtfoE8O87kpHMbYkF
 LR/1s1CJqJhVH4uJKK9zT3QOvChwG7j2KjkJVTJj8nl5okUkFu58xjyLmlCp03kYEGELaUBcWsO
 faC2QJtnz8CdpluChMZya0QGjru84p9CSwoNyLQjpTDkjRpprPuYfnoNGdDzKBW76TnT9+HI96L
 iQgRnACBbxwsLAHjxu4fBBOUYMAyh7bWC6Q4uW/A5OBmeg9YOON7j11fdh0DKAEiYOyrXTkQGb5
 V7QSPTdBh0ZortRagzOjtmizq+DCKyk/DcB8YNoZooxM4XhEOaf3byLUB+N5rvMI9aMda1I7ohZ
 ZToyHFoEY2Op4=
X-Google-Smtp-Source: AGHT+IGx4lPv5fUVgnNxOiziaaiKvWCf956a+8HuCHiCxa7LPGuUslVnlQhGSHWisHWq1+pqz+1LIg==
X-Received: by 2002:a05:600c:4f0e:b0:45b:7f16:468a with SMTP id
 5b1f17b1804b1-45b7f16485dmr27834525e9.37.1756485468589; 
 Fri, 29 Aug 2025 09:37:48 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e89920dsm51510625e9.16.2025.08.29.09.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 09:37:47 -0700 (PDT)
Message-ID: <0c90ebd6-e112-478e-8604-ce5d1a1f29d5@linaro.org>
Date: Fri, 29 Aug 2025 18:37:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw: fix some leaks in xlnx devices
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250826174956.3010274-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 26/8/25 19:49, Peter Maydell wrote:

> Peter Maydell (2):
>    hw/misc/xlnx-versal-cframe-reg: Free FIFO, g_tree on deinit
>    hw/display/xlnx_dp: Don't leak dpcd and edid objects

Series queued, thanks.

