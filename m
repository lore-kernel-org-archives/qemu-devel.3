Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B488CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWj1-0000eB-CW; Thu, 01 May 2025 12:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWim-0000Hg-79
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:25:17 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAWij-0002lM-5F
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:25:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so1225628b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746116707; x=1746721507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNk59ZUe6VB2+qVVwcJX9X+M3hgSClHFSRBg0Eem0Gs=;
 b=KO6hRuymTs32Rh2GXHIauVv2QwaF5REhcTyGbandlkM4n6ttqkmkpLfYt9PLxOzgOP
 ooegvwPtgBlJSvHnFWoffQjL7UuyYeMxMeAPSd3jdnGSw+Srhl+T/LF7BlWCmuXDzRYa
 kYQev+TdBoDth4iXa0Bn1MrRWUQeJipn8KMSYzJU5HryE9TyIAmfa9zrYeDkIncftwaw
 2b73b34pg5e9saA9sWfNyrR+s7kvuGZUAldebmx7+rSVyJZ+1L6xAWkesuryAoYvSp5K
 LX5deU7MP0RuJpy1bSi72TVXBTvK2m4Bl2OLNIcJX4CoxCD0PSIHv+b/deWu1LG9mDjC
 ioYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746116707; x=1746721507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNk59ZUe6VB2+qVVwcJX9X+M3hgSClHFSRBg0Eem0Gs=;
 b=pWrjwCWjGiXiCLeTpXz+z8nIbk3yg/l3csOc6ZfTFElF1Eps8wrfkFmm86AKWGV4NI
 uO1QSH0kOPNYKYide0Lk9QdB1Q+GsdGhy4LAzySWn2Z69vEL/gDc92s5/4v33xMMIrUQ
 nEsz+x8y3mUojS81qnBXuO96p0ikc9fH/3jFXOwWhCsR4MJfH9BLjVFiDFwKIy4e81PM
 fn0JDPeXMGKTeJrtbPuAcUOcInYDRlpUUPZEx6wL5vIy51hPbEBAYulfKYRGBUEBu4iy
 BNJnM0GZTZc7SEbMbAUn+0tLwN93k+AZFSIQvxSVQ+CyWtXYIAK5M3P4HyqPqBwgKRgG
 mp5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWAqbGT/FV6ZmCb1QHPXKO59z+UfKhkAM5P5+oYvPTjgiggYrbxbLSAJPpKbVseJ0SrWFBJMt1Mvoi@nongnu.org
X-Gm-Message-State: AOJu0Yy2+oBpoDPmLnHmLwZ7866No6pIlMEIkfqIT6yUiUX7rp08wLjw
 ZbqcdeiaJwwyBFjGyACetD3XYzi6UTpVZXIhoV3J1TmxupQ/jn4zwgLl/xvHPJA=
X-Gm-Gg: ASbGncuv/Z2u24IybeEU+9WkEkxksGEI3W2ErRSWl431BaiQdphvpakVnCFQtZ3hQ27
 8FaRfYYNrsl45JvXzp0Y6oLcod39D8LazAbNgeCtnhkMcwIVN1rGejbKfl/dhJF49hcIDBc0Uec
 RRX6UtE3QY8JQhqlcpP5nAoNCrsldni040tHe3CYdP/p58VkJtPjHWNt6EK8wUc+oouBzS8rP8U
 w6yY4Lk2D75380JnCRCjLumxc0PYiRyB0h/Ktjq/8bvwAsqPSHPglUShIC9SPok5DPUG1msk8h3
 Qaa9jjtTnAZMJtrGXYUwRzFZIVQk0vixaYJF4qV48ROJmrFTYVvQUbmVogufiXOeLJ3PNHfWOBj
 sr28ORhY=
X-Google-Smtp-Source: AGHT+IHYs10iloHYrQh2kjmtAsUkB8MQeuBbK00pRi5XkfUmMDFdDqej7kPqvmBATt7xswRBv62qAQ==
X-Received: by 2002:a05:6a00:2405:b0:73d:fefb:325 with SMTP id
 d2e1a72fcca58-7404918322amr3877125b3a.5.1746116707417; 
 Thu, 01 May 2025 09:25:07 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404ef14af1sm1005693b3a.48.2025.05.01.09.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:25:07 -0700 (PDT)
Message-ID: <59320c42-466c-4c23-8da6-91aaacf48f59@linaro.org>
Date: Thu, 1 May 2025 09:25:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/33] target/arm/kvm-stub: compile file once (system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-34-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-34-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

