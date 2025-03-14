Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E13C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 00:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tstMq-0000oL-1K; Thu, 13 Mar 2025 20:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tstMo-0000o2-Bg
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:57:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tstMm-0001fp-TI
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:57:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2243803b776so46120815ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741913855; x=1742518655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gsAnFdBC5vvV47kKGy8p32rAkjmOpD1MoWY3tb08uo=;
 b=UyNM5HTutLCA6ZNL21egB2OelDODSzYPd1YqA/KJZNmpBTv4ecR4z3LsE/ysyb6K1x
 TffNogGgxSH5bE9elPXET9pa2481nXZ1ZebixKnnyJVXtRN0C/FOiH1N6JwtjOrwvxQV
 Len47YPQ7xUJUX4ud5O1KuNGCQ3q7Tk2TwlW7/E/edND7fqwu5KBa6MnQIxJSaM46vRy
 AT4q1Jyo3tGqq2bi9XiTN3V5IKNfomBwbSxNDFief8LY1OcrGLWn3TX4X9netiuMdG9m
 HOvmBTGx4/NMN4Y6AoOXsLE4kHlPwFVh+ciMuUMg9eGLZkrF6Yqg2xY3cpMezKBHzrXJ
 flrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741913855; x=1742518655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gsAnFdBC5vvV47kKGy8p32rAkjmOpD1MoWY3tb08uo=;
 b=iCJ/KJetcdozihMWab1GIhWJZzYi950hjPv2weGv1oFGNQDeUqw8HcRp1GigpUfAd/
 49cDQ6QU0h3o3MvrnzKIRc1689mOdnOuQ7UWmjVVoIhcrhLD+tN+NBskp84znMuKymOx
 0sgmd+nf4wvsjncyREZ8H1O6J7xvinFvAhskMuGjuawpMomMy27nlkW5iwZ8hDS8zXBY
 xUZb+q7egj6n4MWYqLEASpnqrV72etHYE3AQG1AnPeXAKTaRf64oXPjzRwPWQ/TxoQ8q
 V7ptuytiuPh0e5s8kJrAJiw2MaIus46XeyrH537XzI4SIEO7LvNZhlxwQg36KisYX4Ja
 F+oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAYRZrQiRnIpWKuMlKJjUjCVZp8DWEQME0w/2yR7lMjUWF145YWkk/bgOjtyZzMqmcCoPpx8q3DI5/@nongnu.org
X-Gm-Message-State: AOJu0YzgSXnbBUSxKpyXeXY996080OASHCtfYNUI81bZH3gqYGCm9KDS
 m1BUYw2L7eH4iw2HVy0LZ2Hb1CHQ1RnMwRcl+JbXV7YwqXaBjLfCQZpQsnViXms=
X-Gm-Gg: ASbGnctVUR9Lnu71IVMhEpxfSfK+RZTI9pqmc4L7wd0vXCG3u5460B4vrOJWBsIdljX
 r1e28LlkWzQshpktmUBQ9HuIGq5XFafTpFGHSuEEfFqp4ZxEZw7QXGbGUx5+7Ym2CjnWWVoEt9G
 R7Q/C1GvRKzOfZI/wnUgm+wxWMPbRRwuEP3vuwkOeWAaIKRKEzVOoLjzz5XhMTXgPnLBjYu3k72
 CWSQ71Dh9kuwo2dlZbUuWxu3Aw3uSoqNIZjixcP7QMfz6wBkyH13AkePY2ercbijeGpLz5PYuWC
 wmDbwUYgICOCeAt9e9dYGXFZHOBq+lGVQa0n2zHUOe+IBASsPM/Ya5bpd+ItI3csFQuWnKLSbn2
 0KlR6n/s8
X-Google-Smtp-Source: AGHT+IGKZ4AtfL5E3sMwgxq0CVhF5DUdbUv+2gqVLOFUh53N/UAIBYy3VFr5CwBXAsWcHMuz2PBYTQ==
X-Received: by 2002:a05:6a20:12c8:b0:1f5:9330:2a17 with SMTP id
 adf61e73a8af0-1f5c13165b2mr1096551637.26.1741913855113; 
 Thu, 13 Mar 2025 17:57:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9c94cesm1946122a12.6.2025.03.13.17.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 17:57:34 -0700 (PDT)
Message-ID: <58b9e84c-440e-494a-8fcf-fa1073999190@linaro.org>
Date: Thu, 13 Mar 2025 17:57:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/37] accel/tcg: Use cpu_ld*_code_mmu in translator.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-11-richard.henderson@linaro.org>
 <a4ecadb5-2626-41f9-aeec-c08457e6e9cd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a4ecadb5-2626-41f9-aeec-c08457e6e9cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/13/25 10:21, Pierrick Bouvier wrote:
> On 3/12/25 20:44, Richard Henderson wrote:
>>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>>   {
>> -    uint64_t raw, tgt;
>> +    uint64_t val;
>> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
>> -        tgt = tswap64(raw);
>> -    } else {
>> -        tgt = cpu_ldq_code(env, pc);
>> -        raw = tswap64(tgt);
>> -        record_save(db, pc, &raw, sizeof(raw));
>> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
>> +        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
> 
> Should it be MO_UQ?

Yep, thanks.

r~

