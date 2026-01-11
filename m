Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435A3D2502A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vejNP-00015C-JO; Sat, 10 Jan 2026 19:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vejNN-00014Z-FW
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:32:13 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vejNL-0003Sr-Qy
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:32:13 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0834769f0so37852765ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768091530; x=1768696330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+xqWVb+95nGZ+xAubznyWUPurtZgxcuL2kuZqJ7TmaM=;
 b=VAwkzIO5ehXbouBmK9d4RHv4vzpElr+tH6QCFFJiEfqzT+e99S3V7matJJHelestbF
 fu66UgAyEXnNgqNElD6hvgYT+HR57pQWgX+Sb2tCcK6m17iH1XDBCY0wWPFJSbN7DGL/
 Qpdk8RhqNKfUJAs0CEDYnAtLareHDxMNrlWmC0QMRVnVdI0VQTHjrjHhF77kmSvWPrlA
 7Gq5S23Os1qtQ/lrNF8GnGBOw4klK/E9cI2ZIv0dXZSAzdBoGA58grOTVRE3NdQIE9Mw
 BDtSD1h0aPwsjNfgeGzh41RkBdAdXi6nmarPoln0gsscVGj9q/d4VxtyIciWCrZAhhKR
 +vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768091530; x=1768696330;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+xqWVb+95nGZ+xAubznyWUPurtZgxcuL2kuZqJ7TmaM=;
 b=Y+6MjtGxFtHfUUDhjjfV8Nk+2sSYHGeXXJtX4S2wiGt8/7RlCubuUSGMrRJw7x5m3a
 eEa5YZvkPe7U+KuZ2dOdCnW8j3x3EiRx1Z3YpzkON6PYyZjzCo6sQV0g/IAVZAqIpKjK
 egaAHyk2oUXspXi0MsVMScSEuPmymEZY4HsgjBaFOITCVr3eOuXcvJPeqq6SwpdAZIqB
 EoP971c8lb60+viZvV/BvXoMuHL9/CtIONVkKHAatxSBgDjaecjn27JjyHBKsJPA2DTD
 rZ9bpFIA43dJ6uBn+NkGdEsPnf2KbRJsT4F/zEGGAdJVNu2FAfNCXFAGf9sae48VWmVD
 da9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM3YSKzCffv0Y3wZWjvrEyImUfltEJF5PLjU9x6QkoAinBchsYN0SG34lHA/hG+P5fjYYaYflACO76@nongnu.org
X-Gm-Message-State: AOJu0Yy4EGj/mE1NJ8OPX7zZx8w4r5T6mIT6uNYkv31GD1l8tQDg7y0r
 g93iy2HaUAzI9mj0vqZMFKUUPiUayLlcysfDaH3Ah73y7hhDJMF3NLCnTLgGSEajFBc=
X-Gm-Gg: AY/fxX4tILW1VIcHxyP9PFcu2wt1FSihknRazfodVevr9kDF3TD1RnTs/05FjR1dLYK
 kFy+lnJSggXUbKF0p8srxIUMCOSwHSQ+oS2FEs2m52kMHCphQ4fOy6IVJ2A0AJjwTIZPIcvZW+o
 77ysBsvp7q4L90OLKviL8sNAmWRCuVsKMOsLe5CoMhHCic6mdo3za7j0QXFgOWNeqK62Bvh0T68
 q9uxHPjgSSKJJ3Q1k2Lpw30t4Is1nfmz4auY4onZFtOX7lC+oqjSLHB/FILGKyvw8kbPd+i8OZy
 2qR0D47CxJZX1bTi+Jg0s44vgm1aGut2tgzJWGq0CmojU9S2s0C/gzlqmilu1GdsoLadBrxvGQz
 SjeDFUu4EaPlGt17M204t6Tw3ENAHhyqfAuAIdGH42UmB/lu+75Go5NTVl22I+MGd6RkSEkhLr6
 /hloZy5GLO5wej1knhv5mTQU9LFQ==
X-Google-Smtp-Source: AGHT+IE6PCbRBT34FiqtIJNq0RMJI8Nw/E6cfqWtoCNwbK/KjRwgTsaS5B+86C9aHWC/P8ttIEslnQ==
X-Received: by 2002:a17:902:850c:b0:2a0:bae5:b580 with SMTP id
 d9443c01a7336-2a3ee41d132mr94068395ad.3.1768091529875; 
 Sat, 10 Jan 2026 16:32:09 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4893dsm136037685ad.28.2026.01.10.16.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:32:09 -0800 (PST)
Message-ID: <86fb5c5a-ecc4-4bf3-86ad-ef58eac63ab7@linaro.org>
Date: Sun, 11 Jan 2026 11:32:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] docs/devel/loads-stores: Fix ld/stn_*_p() regexp
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109063504.71576-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/9/26 17:35, Philippe Mathieu-Daudé wrote:
> Fixes: afa4f6653dc ("bswap: Add stn_*_p() and ldn_*_p() functions")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/loads-stores.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

