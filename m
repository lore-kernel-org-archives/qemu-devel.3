Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EB9D3B990
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwA6-0007pb-F2; Tue, 26 Nov 2024 09:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFw9v-0007ZJ-JC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:03:23 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFw9u-0005gj-3l
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:03:19 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2958ddf99a7so5128782fac.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629797; x=1733234597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3h6uwdnWOAWIjbwswi//LgzFX7wO2XqVPhDRN+rm7AU=;
 b=mTwxFZ4L0c3pzLLDTijL4PJ2qk3oPTuCtcrtfytSzTlYbN+nTAQDiLJVKBIjLyteyC
 1IWx5sQMUQTpQk33FxJ6VJ0EqC+MJpKLYqhiso1cvswZ/ERnzN7+hgdvhQeMePJuCZ2t
 m99sQGb4l/DTruuEDfVtiFb0dpvxh51i9QMkprzEStoJebg3KHZdBLKQr0+/Lo17Sqak
 5sM18h3hRy1CFztaq568g7A+hpIyiHo+ej3KYx/jO9WjLl3Le/1R0S8YLn5vwy/BsQhA
 Kq8JX+YWARx1vGhpMrSyGTrwoFfLEWbH38He17iaIxx2UjdNpi51oetmLpqcEAKaDBfb
 eUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629797; x=1733234597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3h6uwdnWOAWIjbwswi//LgzFX7wO2XqVPhDRN+rm7AU=;
 b=hkhRXlH4IpvqDT9iG50Jtiaai+kKFg2Yvx7d5zbNPeOXjQ0RLHcrFhEbWpXg0jwpvR
 xEDo4cPoOaRdeTolsvsPQNrgJbPMj73gCi8fC5gF97MzRMwJuy7S1mWe/Nc8zhzM+9wG
 ++bG9FiUaiIH0jXch3O010+bwf/Ni/B+5JF/9jYZfcdxdgyDS1xk5aMkyFR3Bu+p5+Uu
 kZ2LG2au+SAkjosI0+JTR782qmkmLKoV2wVD1GLm6hJ0AuGQfk3hCvc0FMxdbyEOI6fB
 DZt8fuqQAjM4MzTIAyX20CD9XzrKLpfK6CWbGKglg68/Jyqf7EnJyWSP/o0lb5Eb39S1
 Fn4w==
X-Gm-Message-State: AOJu0YxeH9gDnF4ouq7gs38O+vNXtxsXS1CDQii2kbWHz5qbvXGLpm00
 rI84mBV3P7vmIzPnzN3OK453HaWk3rZL8vWWa3AmIDjE6WyGTZQUt9thupP0Mcazf4pT4LBrFmN
 J
X-Gm-Gg: ASbGncvhIHp3pSKp+z/2rermxnx0utE0veJKkoev5AWp8cXQIaltucxvv4M0BR+PT65
 agFDTT2TcBkjlaFhh/+iKSDb1mlx5wi91+XBI4denC+zzZuSvpn7u1CxiMA4WhSl/NRE9v+l0uf
 XDLox8Ma6wucfmx9KtvLWGQRgIevbbNfd/zzU/rmHXYwiiOhh+r3ksfIwH+wSM8P4GPoaiPRNHB
 H6e3GufNihEYHEZyA7QwV1znp8cQ2S/gBw5Jik8DwnSxBHRXXYIBmdrkDeEVwSAng==
X-Google-Smtp-Source: AGHT+IE6nFcEY5O8ZdKIPWVu/HQffCakdpFntBx7zWZPRsqnj6r7aD3wmPlDTS54TSW3iYte7ws3tw==
X-Received: by 2002:a05:6870:a104:b0:289:2126:6826 with SMTP id
 586e51a60fabf-29720d9057dmr17092871fac.30.1732629796797; 
 Tue, 26 Nov 2024 06:03:16 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d5bdf568fsm487922a34.41.2024.11.26.06.03.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:03:16 -0800 (PST)
Message-ID: <7714c8fb-bbef-4735-8c28-14e6e51ee79d@linaro.org>
Date: Tue, 26 Nov 2024 08:03:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/mips: Introduce gen_store_gpr_i32()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> Similarly to the gen_store_gpr_tl() helper which stores a
> target-wide TCG register to the CPU generic purpose registers,
> add a helper to store 32-bit TCG register.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

