Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F31D6E2DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJH2-0006pz-0A; Thu, 18 Dec 2025 14:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJFb-0006KR-PA
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:01:30 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJFU-0001Jo-1W
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:01:18 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34b75f7a134so791520a91.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766084473; x=1766689273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygzMPh28nzYEGussN737LzSkahiLBuOLFrfAkSBXJxg=;
 b=Cs8uu3/SKMbXph5MiG25tnsmfiwR6snGvu+fnoDhB9TWQiTBBs+LfhsALNQZpUvob8
 K+mK+rqne6mqwN3t0gt3NepgZNDPEgutVA+wrm8n2NdByJJ4c7tYQ5Tqbe8DTL5T9y6w
 THOB5Al0KxeW7x1uGs4znA9DrTEyQBqDaw8fQf1G/60AoeN53r5sZaY1RqPMSZ3mz28o
 AeFg169fxC7gZ3YJTdf4H5TT8Rg5nnBkhtokomuqgNUKXpJt7PZrD2jmZsZdSnE5CWRh
 53GWGkZ2lN440pTjEfIxV57FoU6UtZE7bK7Ge0IV+WGWTYlfTuBgIzMiv6XX5JvLRKtE
 2PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084473; x=1766689273;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ygzMPh28nzYEGussN737LzSkahiLBuOLFrfAkSBXJxg=;
 b=jBn0W1iLa+qCTtYBL8ad5eaiWSrSaICs+SzA1j1MLOo7y+T4BD8ZGA1gmolszGm4we
 EOxY4vm3O5lKjOF9nVecz6n6cuPPmAR+UBS3hoD6/k7XIQomUPKZ8LXAt4kj4cXNDIEM
 Z1245VyiLvrRcm4X8yOoKsHxec0u9h8kQaeNYXOTDiD6v+UjpAggDpDUvtampxa7CIGy
 ad95ho62B9UDAXI5kBiMpPdWGpdPZj38BN9Xhn/OXnNtlyqUA0wAPafZL/3EYrlJ9JjI
 0Ts7XyzpzMuBe1RWPGMlf1nB5kyWz2B7x0q7AgDSbtahwCMjTQBjsAsttewWr4jBuG2T
 ELRw==
X-Gm-Message-State: AOJu0YxWEE+kWXWFGEnq90u+GWHQcBtZblycOcmAwsgcsMFUUgH643S/
 s6Rh3mtd2sB72Gwcp5sklFbWFI/arBo8X3ayIfVOmH1U5hDkYYbpdIATkzgJjkKg+SLttlvaGrF
 b6CXHzog=
X-Gm-Gg: AY/fxX5jlQIiEfoUfkbIW9iHzgAOnkR115xuA+TkdxVnexumQIon68EW8WQxJHRYi6I
 cx5oCFAotZkw8lVlqVR+3Ckve51P1SZFZeZpKG3xyKavSFMIoDAFsV8gIdb8wb1gbucSEaF/1v9
 DTnNe1uZ6+66JVwOVNm2zXu1Uxub+xke0y/Xu+akb1qpRuVMM1QMAeM6hgpruRooY0h1wv6FqI7
 T9IaBNAEt6FFqZntq5nq8leZG9VThpBqS1tNZzjdrhwfSmsLjCXbjMyW4f6iP+2E3fqDFUS0EfN
 9CxM9C1+THF/gu5oiMgsU3ZqYoclZcHdaeZ7PuPBjenqY19iKeIdQDVvTWM9PF321gUHSqn//UR
 y8k2hgPkHBzod23J1KaO+Sv6gVo60Vp3BG2z39bDYRAEkoD8tBA6gl8FWsezTCo5Z7ood88fRcC
 R2RB8CnP8Eg6zhr+pMDIO4fo+IvlyPlDICUF9FMNDg
X-Google-Smtp-Source: AGHT+IEM1Ulou8h9aldIYA5EaUpYGz6sbI063hVyeZgq0TPsY+k/45VOlZYDvkvGoscjg6UDjb1iBg==
X-Received: by 2002:a17:90b:2246:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-34e921131b8mr272962a91.8.1766084472342; 
 Thu, 18 Dec 2025 11:01:12 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e76f04b14sm965339a91.4.2025.12.18.11.01.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 11:01:12 -0800 (PST)
Message-ID: <c22d8bb2-383d-4b7f-ac13-e727441acbc1@linaro.org>
Date: Fri, 19 Dec 2025 06:01:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN
 symbol
To: qemu-devel@nongnu.org
References: <20251218181812.58363-1-philmd@linaro.org>
 <20251218181812.58363-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218181812.58363-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 12/19/25 05:18, Philippe Mathieu-Daudé wrote:
> We want to remove the bogus DEVICE_NATIVE_ENDIAN definition
> (by only having it explicit, either big or little one). Stop
> exposing it to rust devices to avoid it spreading further.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   rust/system/src/memory.rs | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
> index 4b3316bf767..4e06c16a0b5 100644
> --- a/rust/system/src/memory.rs
> +++ b/rust/system/src/memory.rs
> @@ -78,12 +78,6 @@ pub const fn little_endian(mut self) -> Self {
>           self
>       }
>   
> -    #[must_use]
> -    pub const fn native_endian(mut self) -> Self {
> -        self.0.endianness = device_endian::DEVICE_NATIVE_ENDIAN;
> -        self
> -    }
> -
>       #[must_use]
>       pub const fn valid_sizes(mut self, min: u32, max: u32) -> Self {
>           self.0.valid.min_access_size = min;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

