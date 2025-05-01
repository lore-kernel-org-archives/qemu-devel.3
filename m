Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36CFC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWi9-00089F-9B; Thu, 01 May 2025 12:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWi7-00087U-9G
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:24:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWi4-00027R-Rm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:24:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso1022410b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746116667; x=1746721467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=TAIQROWJE2ekDYhgVMzE/g2WJUj16Le9I50nu4toSNBk2OhktK8Iek26abbIpiH/MQ
 FBF2vAzigyZ0k/lZCYlZ0eNS5SYh86b2dGjCU2EqX+GU6BsqijAqYPt6gJ4s3xvxPxM0
 IdydRa+UwSkcdap/et60AIORxt2wxAJSxSdT3W/RDvO6egm5vK8Csrnjdj+RVNuROwXP
 XBlapnVlcV+VQfXkihah3YQ8q7iRiDRDLMjvS+hW9ILOIk0Pt2D2VZMVzAWUYVyqTVHx
 YqJ3J922lhVu6wxcMHIRTbqwknPfA6n7SAPR/G0M6A2nIHA8MA9kbOg7DiDV9Q1+RvWQ
 bpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746116667; x=1746721467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTb37Xh3764UHx4GkunEtiY4YocHVNCV/2Hme8te8Ks=;
 b=lBfUiJXXeNRJ+RZiHLFW1Taee00tIys6O2h6vuO/Ysh5mlzh8TJU/6CJBbg3LsPZOL
 uTiIDIhOCXoJWWVoeFrEQZZ+ANEQicNsPnxIEH0nIvJcJLPgkH1Yj5n+mrsYWffiitdD
 6t3AE2yXGcZbPrBceTlb+LfnqHgcfUaNupQFn/KdnZw06KVPvlbDLoc1olU/mDk+ejSr
 FhKYg2Ha6uU1xx+Juy6YTxyQP1sBxQNc0LXhLWw7huNNdvsTeqZNHdBx1AZiGUMFVDMo
 hNQjJBpyjuFtOoRw3b0YtrL2pswQNCBfF9AYYJlMh60HaBa35Q7tiDGnH/VQI65W0iU2
 47Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8ntYBoKlvuUsKyPU9RCWOeuE9NmuEENR5gwMWdWdyVutk7ONVKk1G2nNK5jIyArQhty3whBTGwvXg@nongnu.org
X-Gm-Message-State: AOJu0YzWRSuPdgOU7K5u7zL2sknU6YGhPtZlhuahGYm0zKmB1uRA+TuO
 YdrOd0B6o2YEvISo8c9p1pEsnUCWkrYV0uek+dvJJr8bZaymyF214jNVpTgBfMU=
X-Gm-Gg: ASbGnctrIf24/es2NgsQnv/Mqh5Z4fA0o/vFt1BKqapb7RHaPXdxdwUiMWw8+DC6O1z
 hSanfzcqzGCch5V2/AibgzOIbRBFH3+LemTUnqV02jFpqwN+7BfIrR9maDk4dJSTfIWKKeADw1A
 6Q46R3tZm6a8nzUGg0UuQZC4Ky1Szqsic9LUV1rnC+K1ICowIng6FQw7MEnROx8PtMYY0QJoRbL
 YnMXt5h5cOnyoRkKrRF3mTMifI8XI01Q6FIMAQvn74sah8xm9HHAldZHL6xCeqyr/nWBv+niagC
 77KjR/qXGLlEIaEKuejNZvSINWxfIkELuOLdYVCperEN1c9yo5TTP6tkA53P9rgiiiYtc8Uck84
 Mv82hT2f5cz+n5S0JGQ==
X-Google-Smtp-Source: AGHT+IGKLGdqve4sfuTYMdlogniJ7+2V8YZQgAut8VVxQxe9cMTSQ+UfFqgvPdx3ptKN8imUOXcEEg==
X-Received: by 2002:a05:6a00:1784:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-740491db38emr4206130b3a.14.1746116667105; 
 Thu, 01 May 2025 09:24:27 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1f9d66d8aesm794850a12.70.2025.05.01.09.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:24:26 -0700 (PDT)
Message-ID: <9512e14b-9d5c-420f-aef2-30ee28c8f701@linaro.org>
Date: Thu, 1 May 2025 09:24:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/33] target/arm/ptw: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-32-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-32-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

