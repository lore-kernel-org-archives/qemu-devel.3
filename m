Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD6E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW22P-0000nJ-2G; Thu, 09 Jan 2025 18:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW22N-0000n4-Qc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:34:03 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW22M-0003lk-9p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:34:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so11229275e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736465640; x=1737070440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Bbg4cBmBgkN7h0482imXsi4czXzn+KkYZz0j2H1w74=;
 b=wncF9esDQv1kPsELFKqbiYtXyOuVmJ3nQ5M3PKw4Dj1aylod7+Oxf3UZOk5DdPszmy
 kCtn9YJUx8QyORO/yBD84565xZf5gqKyPnkyiheWGwkvu7lqU1s5RWdXCxvZSBegO3mw
 jIMNphopfHau33K9E1IqadwckNVqnaah6ZDzoglpdnLSlPINdvdC/zlYyuS5etG/4pKv
 8NpSDi0qtBq1DxsSRc3tT/zki08ZksVuDiwoSAvL340U5d7mDK1hQHJZf/ufewHIKWrW
 tPO/SWwvtoS8X+4ZGFErTsKa4YFG8pIjz8PCLQztduiV8w1DyWyaQ+YianaIELDeDJTK
 m/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736465640; x=1737070440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Bbg4cBmBgkN7h0482imXsi4czXzn+KkYZz0j2H1w74=;
 b=qhlHjTWnVLH5vI3S7aaARaCMkcnZAPw02mmwZjsmd5hB+yRASEiSTlo5GRcFQI7R/I
 pIdm292LKepyTxXSOa+e/NJrGOxPB85hUSrfaXvW3BGlECadwS37HvbpQEbX7vnawZEN
 sHVxoBU3NW3J+dvnnxPoBmlRs95K4prMfSYB3BIVJeCqoM7VCHjFahJchru3A6gaD7zO
 Bqho0MOIC2XWnGAFEDjBYg4do8kwa5KIBfyYHqA6jk5DAlqPyeP7RBOk7Qghb9SNM47s
 COVjFo7aM+N5LxsGlr/QWIeCnccxuj2ENahqvTMHQ32urSsEQvgd1F/xJshrDzVz2I9K
 Twww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVbsY3OTpCD0e6huNfqC5w8dx6X9S0IyeycMJeJaor2kW2FZxAvuRYzSO1GN3TDCd/Nqfs6w7w6rzx@nongnu.org
X-Gm-Message-State: AOJu0YzA6aDFS4HToji6pVJkI0Kbmha72rJHHWkyS3SCXzneAyqFZoUM
 ltSvXit+xYR/34Wwo2gVYBmbNhMGLVWVlxhX0uUUygYmiJSvF5irZ1e9ITEXYLxa/UCKFPBDiVI
 GkX0=
X-Gm-Gg: ASbGncvRf53sFKtCKLI4Rjwe9KUfexNyg3b+j8vg0ATchiWydd/R81vQf5YB0TE+zLR
 rSMu8Q7xBuT6JJnWw+cMnBNDQnk7PLeMtqjuUrsHgszPPNbipFqMbTDUxLHsmr4AUsDJVxUdzPc
 s4Bs9wM+K9DZJinXDRA5r+Cv4Z+ZV2WZrUMup6yi+kb8i3vZbAmf+biVCR0t6hvMK9pt98hk3Cn
 xtCEcKgtJSqwkFhwIpp4PwLO4Plxe8h65+4lETe1x2c1JQgnOhYK6v+DVf9STw8xeydVybi6tAa
 45UWvLy2e8uZxyYWeFmZd6QEt9M=
X-Google-Smtp-Source: AGHT+IEEuge6mosrFFEtgCi953E46rSjCxincqE4tVnfm7rYvloyBkErN598N0pZOiiPVlu+pIP3Aw==
X-Received: by 2002:a05:600c:5355:b0:436:ed33:1526 with SMTP id
 5b1f17b1804b1-436ed33162amr26424365e9.9.1736465640136; 
 Thu, 09 Jan 2025 15:34:00 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8116sm2936361f8f.79.2025.01.09.15.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:33:58 -0800 (PST)
Message-ID: <55be2c4d-4c44-4337-8cc8-ffed201ac582@linaro.org>
Date: Fri, 10 Jan 2025 00:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 36/81] tcg/aarch64: Expand extract with offset 0 with
 andi
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-37-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> We're about to change canonicalization of masks as extract
> instead of and.  Retain the andi expansion here.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


