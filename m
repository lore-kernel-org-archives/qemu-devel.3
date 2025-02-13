Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDA4C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticcd-000169-E9; Thu, 13 Feb 2025 12:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticcQ-0000xM-Ks
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:03:19 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticcO-0006ou-MV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:03:18 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220e6028214so9628435ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466192; x=1740070992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LogOcn3+2X70/qShHoEm4l6+LXvM73OnacDKX1JCE1E=;
 b=D++o3KOAVchhdqRDCqxZcAU3n6xMqdlMByZ+nDZNTj42/LRlPBMdNJNYzW5HmeWv0h
 gW2FyOnJefbWjFGaWf9ir1dAE78wfm+wTcxfjSq+9wANc0v2iAm800oXdSqNlMXpujkq
 0lg6AdU3i6Be8X+eGNePNzRR+qKlOY+gOtGRLXcEuFkGdQ1xfsZ+ng0cGP/jJWUJoVH4
 /NksPTTW9NlQWYzC7qocg1M6DthHSyN9EtGwJzU4tX19bv5sYTsJVkFVNLx9d2b7FeT+
 1TbQPt0V64heVnZrvdi/Mn3ZQE0jtDTujLfTVSMVGb3V2PDfZkzlGVYANe1ApPGEaLWN
 QBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466192; x=1740070992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LogOcn3+2X70/qShHoEm4l6+LXvM73OnacDKX1JCE1E=;
 b=bFxb4YSa8UmpOLL3iz2W/fAuG857SCpKweg7ZjV/Jn81QkYVGA1lSM88aJ4IC7Obzx
 ADXwrMSIJeYSWHROBZMRmrDx8OkFK8czpM020OJeLnm+tPwah6wP9zK07AfIutIifjKu
 LXfsEFOspsjkQ9F+1rYOk3zb7xLE/ye/vIITeSn2So9vbl64BTHS5Go0L2VEyk8RA7bv
 0N8ybusaC1cI0s8Cxo3j+4/1KBAq+kQPgVc/4wd2Dfk620U1cDlY3TyTB+iLDYEoX1Cr
 UE1VU2jqpjcT9TTQSqz2bTv9uIZOuihSw3BcZYC64u9Y8Bvd0JifSmTij/NVQEjGnnh9
 o/rA==
X-Gm-Message-State: AOJu0Yzn3hsPn6eHFWn9YBhyVhgdBYIVFWPqXwEx1jpkGsKA4jZYvw2g
 BhoVXzn16iFDC/NpwoRZLzBr3TES+29sSj+ef1+XU1mdCLQb2AaABdCKv/iZIuw9mRkDEwEyh7A
 Z
X-Gm-Gg: ASbGncsIIWiOBBl56CsjK+MduVhoPgl47cgRI6gFXAZL2EQRIEVMgbew/r+e+QMh/lU
 MF37r2Gd7IOx/BG/tFTCh/q2UvwKhIKPus1mfmp/91q5NGsk4iJRRuoLVYzbYQZSgKUg64I13qc
 lcIRyS1xDRwZljR6onFrThelfNJNQDgmBmWt/nhZ8hqEBQxRzJo8RoFva6tLooXKSimD+l8VU2K
 7ndd3o8OSWoL/fbLy7umOBxlnvH+0MoClqcqEamIFGp/jspODQrIgPIZs0f1B29eQ7U+3qUFUEq
 HcMQeqd4pKLp4x7G1SUI1UB6RKwnOUwjGA7MWhNbUWcvOJqD4ZVNh8E=
X-Google-Smtp-Source: AGHT+IHxDiIdPkQV5n6ZlNEM1HJbq1Q0KRN/VUu1NLd1BP4fENZ2RJ94x/X0pQJqXtqBnhLqCMzrrA==
X-Received: by 2002:a05:6a20:c998:b0:1e1:b12e:edb8 with SMTP id
 adf61e73a8af0-1ee5e666792mr13836798637.30.1739466192231; 
 Thu, 13 Feb 2025 09:03:12 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5813afe5sm1261433a12.31.2025.02.13.09.03.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:03:11 -0800 (PST)
Message-ID: <c42b07b3-5365-405b-81b9-f36bc229c85b@linaro.org>
Date: Thu, 13 Feb 2025 09:03:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] hw/net/xilinx_ethlite: Make device endianness
 configurable
To: qemu-devel@nongnu.org
References: <20250213122217.62654-1-philmd@linaro.org>
 <20250213122217.62654-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213122217.62654-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/13/25 04:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
> DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> 
> Add the "endianness" property to select the device endianness.
> This property is unspecified by default, and machines need to
> make it explicit.
> 
> Set the proper endianness for each machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/net/xilinx_ethlite.c                  | 29 +++++++++++++++++++-----
>   hw/riscv/microblaze-v-generic.c          |  1 +
>   3 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

