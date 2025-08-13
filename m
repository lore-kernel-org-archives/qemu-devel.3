Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A62CA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 07:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um62B-0005KC-IK; Wed, 13 Aug 2025 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1um625-0005IQ-2h
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:36:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1um61x-00012x-So
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:36:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76bc61152d8so5460244b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755070570; x=1755675370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNmtQya06ImRyytAVRG7qqulngvluV25Ko4jiw2QxWc=;
 b=AOScuL6nM8UlEGglt9OlxkNZLO6w0VXJpexVq0OuaAxuiy2nt0STkIiM1/vUWsb3eQ
 XV2mqQbAFWTYWnmy/x9rMQfeL9lxBz/kUinQkK14QtrNW9JWU5rC/W0fHaEF+qXDGSf3
 gvpGQnfIXnvqAnmrLva2gtnJ+fvgdTnRKiKF4MWab9RFgKz5wd3tujHJpYDZ678dH8ex
 CCs3apXqGwkG/2m6VaRhdr4O6GFOucnVklnUcqjOIQR5gqELsQG1Pnf10GVws0BGLAHu
 qHhnwRm7yR0VZmzVAeHkfS/2d3cWQI6YruLMy9EO4M/bFGvHNwjDxMTO1PiCDHsqnynO
 B2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755070570; x=1755675370;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNmtQya06ImRyytAVRG7qqulngvluV25Ko4jiw2QxWc=;
 b=DZP+N4yGQGwu5+VKEFlrQ3Vy9lzZ0rmvgVjgG04q288Z4bqJuS9K1sT9iLadOr0dal
 xukt2ZRoodDE006pZN3JceM4KLdK+9btwwr/pJtJI+dLDSkoInE7SIB3S0d2NGA73zRA
 RnsyP8Sm8U/xpRcYReHucGF8v+DemHvEFjm+gR9H5axI69byzy/oa5pPyOBQKd+5GY0f
 qWROvkA8eoByd+n4b3I0/3TtFQFvCaqOf2QSYx74nEA/QRhPiAujo03cawm3dTaHJwl1
 RUVCONPHyG4Hy3GJZNJPMdBEAnLUnRbZvYk8NKGP0LpvprpPRpbrYsZvXAjN1OE5TN2d
 yjew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV48UTitX3x5Rcs1gqDGKEYiVPSEesatlJqgOViRfHkxIL8SHeg1JLwTULQyIf+X224z5c4Jw4fm7v2@nongnu.org
X-Gm-Message-State: AOJu0YxLgZ8xVNpC31L5K7yf/JjCLlTmiVWk3EBhLjPHSge8mweu3WDk
 Zs5AAPpXRo3oDeUHck82QbHeQ/+xw4da8C1mxqtM4wz5HQGMZ8RKcC93r4psdxnoV38=
X-Gm-Gg: ASbGnct5guwkiZuHFJGEE3tlnj9+5D5bMT3PR4dv5o6ZN14efMpDKp8hDAYZTpaw7BY
 sz3Di7lxrQo+PTByHpQfFzoqyr2iisZD2WI50QVv09mssnp9UU5ZsHuCitJde0Ifis9+oSAhpbB
 XoDEDmTR5exnBwcIJYCt26n9giANogWdyln/Bi89e+16JKFfdbnm5bEHDwFSrtM25Gp7M0Jmxre
 0VszLwhMhQX2qQBHj5guwwDiosJpRHGoT4PmR9ZvlLnvi3EhGtnRx8uExgp9QdEF2YjaIQ6mwSL
 FShnnHzD4bjXAiGYqNOyRwishP2e/bWyPS/3RzjHF2VrCkOFt6uWtOWk7UxZIiGCKpIgzsEQ3j8
 L/N1X/xhMmqggyA70TIuHmd6RBFshtPHhqhLHHrkHDeLKx9/yN7GgtGzD5T5GCQ7OJczOHPjrIj
 3F2yGG3wTDj73n10yTOQQjEpLGZ4Jb0Nt1zkJqbOT/RKDfUu3qT6OvIut5Uml4Dubm
X-Google-Smtp-Source: AGHT+IEQELrD0C7Rp7hYXifDb/+etN3oMHhBszhf39fFtaJI20c5SixqCx/5RZgiTwmroOmEfS8ZHg==
X-Received: by 2002:a05:6a20:7f9a:b0:232:3141:588e with SMTP id
 adf61e73a8af0-240a8c23ee1mr3754012637.37.1755070570096; 
 Wed, 13 Aug 2025 00:36:10 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:7feb:3696:717e:2ff8?
 (19r3hzjrscck598x80dk.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:7feb:3696:717e:2ff8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b470262afc4sm1731243a12.49.2025.08.13.00.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 00:36:09 -0700 (PDT)
Message-ID: <29d8c44e-2386-47bc-bbcd-2f56b1deb9fc@linaro.org>
Date: Wed, 13 Aug 2025 17:35:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/10] target/arm/hvf: Sync registers used at EL2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173157.86934-1-philmd@linaro.org>
 <30f26e53-9976-4826-a25c-9cb7bb551280@linaro.org>
 <94eab92c-9b55-404f-8e61-f9e80dc49703@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <94eab92c-9b55-404f-8e61-f9e80dc49703@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/13/25 17:20, Philippe Mathieu-Daudé wrote:
>>> @@ -608,6 +630,11 @@ int hvf_get_registers(CPUState *cpu)
>>>               continue;
>>>           }
>>> +        if (hvf_sreg_match[i].el2
>>> +            && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
>>> +            continue;
>>> +        }
>>
>> I thought you were going to change this to arm_feature(&cpu->env, ARM_FEATURE_EL2).
> 
> Replied in v1:
> https://lore.kernel.org/qemu-devel/08f2c3ff-a509-4a96-a515-b3ceae2ea9ea@linaro.org/

Hmm, missed this somehow.

In which case you are going to want to cache this particular value, because you don't want 
the syscall for every read/write.  It need not be more complicated than a file-scope 
'static bool'.


r~

