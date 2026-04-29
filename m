Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFF1FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9uV-00012I-6C; Wed, 29 Apr 2026 14:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9uS-00011J-8i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:45:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9uP-0002Pw-IN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:45:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso515655e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488315; x=1778093115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=namiZWPt5U8QIOnR7As6vSDvJV25Jz465JkjNmRfknE=;
 b=Lg7pZVf2N5bkOBcPQTokxByHDaN8qYZZyegtIFiQitXqNlxrgfdja+JCN8SXEDMoE0
 430JhvffJMzfibH04rE/XNNEZ1qWET0qg01OgrTqWYQIKMW+/6h3kI4yroWVp5gmf17x
 VvEMuCTsEwPnYiIIilxe9XE+AWGcCYthdUz5ep1/y2gD/ZqzLwfBZO3iyIOFW2aHoNqL
 fW3Hqnx5gat4Qd+dRvEvOw2IWWUWfevgcXE5TINadRvZZqVNeME47bF88MSkeTvIjOqv
 BFAHAPzJnt1WFFim6lOSuitnoS4BmC2b9/y0k6TjU7L8hpslrmQmMrct7E0q6fE1YYp3
 q4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488315; x=1778093115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=namiZWPt5U8QIOnR7As6vSDvJV25Jz465JkjNmRfknE=;
 b=MW+tRxH26LRrDYnS0MrCRzxmTpHNUxQI5R5Ac7Z95G3qmP7Swp/xurSLpfq0VY6hof
 RZgZLahwfoDMqH/m9WOSAxY29n0EtcSOSC9oUI6wjICenlD1ixBEnj0wNiMVDSqfyntA
 TrPb8oTZ47EtCiSvCuDso7I7D2/VsPTLDrIiHDZZq4TXgvZ1xfer741Tk5KueBQAtiyu
 UGFc4Zqhj8QmMER3ByMNfT7F5gCGIey/4G3ILQiLJIr0nX3DYQhga2+n7ibwqLwDwSoZ
 /osBika+4pQ36s2sx3VQpvlUVmeLs5YFcWckdSaIo2KBmaXyv0WvpCf446g2pu/CVyNy
 ScYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QSjbUl63zZP23AfDDUO1enkwgBz1zZ8dIrVVU03xcS3dyIjjn8p05o0oIUZGoPZU58ssRhPC5Czaf@nongnu.org
X-Gm-Message-State: AOJu0YyLxyBK6A5uTdHwcMtOjwUMlI3TV+F3zSG4fL9PRB7+mv84SIfe
 f/efNxIwQLtUcHoeGmQ0RcrsrDyfFGE2EsjLNe8wsqWbde/Ewa7PUCpjHtZa5qeU0T0=
X-Gm-Gg: AeBDietRhZRibyf0WxYbR9jFf8aUa+/r84VXNSjWAZz6VDNJ4C2dHWYHb4AMNttUnV6
 AEh8TlqiZG0Q+7SbqUCY9yLD+TGeTMh2iPhFAV2fwDZ4kb1ZIBTJTu6rJw+hSc2zY9GknyJYrBB
 3Gy6/orHt9/2Zr21NQyejX/sztSOp1d0f1BGN2solFau51B/g3w7NyA4h99r606DbLdQtGxKUrt
 CPz76ClAQ1N3Y0PaFYGGjUF9zony42x4f0lL7rjxfkEUfrqY3qJXY8AnsoU0ud1FH51Hm/IhPq7
 jcVFjmwFicil4UYcuZ1IIK1zS470gBZ0mUzWX5K/1xyKympe/TyuH1dA61eiBqNeVrBQpMIi1eo
 xU+nNfd4R93Pl9SuQ+tszhTf04w8AcLmUYNytssqEr5UA3YpQpDmRfb5KX7QPCW1g3uJi3bLODk
 y1iA5UmEW3a0He97SPxftyGZWKNrorR2eG3a9gLNb6F2fH5AezSSs97I1B7DX+Sl8/JBlXM+8Rj
 B6+
X-Received: by 2002:a05:600c:4341:b0:48a:53ea:1408 with SMTP id
 5b1f17b1804b1-48a77afcf0amr70770555e9.8.1777488315030; 
 Wed, 29 Apr 2026 11:45:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822be902sm10618165e9.6.2026.04.29.11.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:45:14 -0700 (PDT)
Message-ID: <bc9e5460-3c3e-434c-842b-9d05447b5125@linaro.org>
Date: Wed, 29 Apr 2026 20:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/84] fpu: Return struct from float16_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 94 +++++++++++++++++--------------------------------
>   1 file changed, 32 insertions(+), 62 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

