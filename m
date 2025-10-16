Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63626CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Gvl-0006gj-KR; Thu, 16 Oct 2025 01:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Gvj-0006gG-TR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:53:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Gvi-0006gO-B2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:53:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so3272065e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760594016; x=1761198816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NLYrzm1RgjvSXbnQrVySspBXTN+XNa0ruyhwAUGOYTY=;
 b=VBAsWus6AhTJMgYhHo9SpYFFXyY9kI0nblwtWKvNR33W3py2ZPmE6XK/5C2wG28RJm
 zpbb2W4tVdPdt9LX8hyVGwGgH+etLvjLzzehUoYvul6Qjjd19fUcSVw6qWyyAlIxB+4U
 KxFgDTUaBgFsUfPLJWwWdNZ9eWH7kBj1qcg5qAHrdhA4xqvJZFvbWrz/n1T0JkH3Z4a7
 UqyL44RoSsgU2yB0zws3n3K9oV5/ol/dMl3YhwHF7SqLVjqvUZ837trumJ+8zpgzY1Gq
 IixPZUtyfWYeJ157keFD9ho9xBHdRjrH34FmYxG9EYH/Wi0+UykkXjN8e4ZLqyJ/P0Gn
 QE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760594016; x=1761198816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NLYrzm1RgjvSXbnQrVySspBXTN+XNa0ruyhwAUGOYTY=;
 b=gMbGd+v6xGP82vGHP/dnucyIJkCPHhgy77pOwIg0q6udcNd04xfATfMz8NRLDygXAF
 ocVY0AFkeiPYuTV2WQGvi/hkdX+W0KFL4I3zd0ZSz4ZKFoWftYXLtoTvk8O7LaBdvfzg
 FsAT+8LR578XxK2fW2taw4IZ1wgd5NGzp5EP3MgyDgiPoW5fcxAng1C3quG4pplC6nMe
 tB147le2VU4JWNjLuWXnZo37VeB0Dkk49y1V5gD9qV/A3AkyfUXk4hRg1d+cg7iB5J2l
 5HqXXMiy8790RpO3c0me665wor0MhgMTNuXgzUyPFPTCe/RX7cVCM021zRG+RuGtnkSM
 vspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA0gJnD6s+lBKp8zmftxxtp6Xtac52lNuEK+ZRcLICjT5G7fSMAMOKHOdusMigXGKbInBznexT5clI@nongnu.org
X-Gm-Message-State: AOJu0YxgcNH/HbaBBvfcHkPeMCjCbgwgwyicZEmlOd2vc+LVt76R19do
 OdrPepdJZVzWv0O3u8GcvtFrraF8mPIvh4FgJUqI6mS40cAIVm8tNgVoqiHxlDxemfI=
X-Gm-Gg: ASbGncs2oohpr+6/7fc/7/oQoaYPOBD1LRscvY2VHIwCU+dB3Nn6CCgmiiLROYZsEBT
 z8xE+kZ6fhMSEZq0/SIffEm2q0cb1CUZMXR2moIl7/ekzyf+pQYQ1SnrXYCzifclB+cxK/XlDvk
 VVk/tljQBi6jodmM02WBAOvJsinDVESZ73PA7EVLW60IXZ68vIay7/WlyMZMcfsFFtK5JPcaO0Y
 IUwMoOoNOKumwI6ZurcjM/giVDyRFUxG6SaijVboBECwdQEubAQeZAbQGFWxb97qWF4nx2DY3t4
 wxzZiRyGh4RtTFAuWV24IZoVYvC8ZkvLmEA7ZApvnoUhGbuwBHmzjvZxZVQCHmI2apbZ4PtK8g4
 E6E6ekcoNH+s7sTGTfWoj+uUaTimDgPKyWRDHLUsjAbYz8i2l1lUOk+mPZgkC7hncnzrf+uQvJO
 weQ/8upd6aKeLU7B9jBaVyu6TOTychIqGquvilSdJb7hBH85I=
X-Google-Smtp-Source: AGHT+IF4MVvfQb8L6PEmTVetzxw3atGT0VjIEHS64DaZ+QOPytwN4y4yY6l/1W+AlTh6DjfMRxySIw==
X-Received: by 2002:a05:600d:416a:b0:46e:6339:79d1 with SMTP id
 5b1f17b1804b1-46fa9a8b3cbmr210205545e9.5.1760594016108; 
 Wed, 15 Oct 2025 22:53:36 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8207sm31727122f8f.47.2025.10.15.22.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 22:53:35 -0700 (PDT)
Message-ID: <464b3967-8a2b-48b8-8c6b-2e246ee15556@linaro.org>
Date: Thu, 16 Oct 2025 07:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015213843.14277-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/10/25 23:38, Richard Henderson wrote:
> These aliases existed to simplify code for O32 and N32.
> Now that the 64-bit abi is the only one supported, we
> can use the DADD* instructions directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target.c.inc | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


