Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD5DC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFA8-0001xf-KO; Tue, 08 Jul 2025 16:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZCS3-0004O8-Gv
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:50:33 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZCQQ-0005T9-NV
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:49:14 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a9741b513eso93532431cf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751996861; x=1752601661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JimOaRh7w1crCNK8S0djdsSqbjYIJJWl3DwQcYXioSA=;
 b=MPuIx35bK6TcqWt34iBm7ycN+OKcT+5CgRh8JJRyuc6ahkc97u6VHUY7POYDPxzzU7
 WxxGd0ZZNcDmk4XDpS4TZCNu1biqgLl6Agb6fNN1LJRYrgnKb5C4zv2Wsx/C7fQoqCaO
 vnpAtjpx1ZpEOio3r1NPaunLG49Qx3uHPJYs94vvfg/065s2vLzsa0BSw4MYBd3eTt3D
 9+wzkY0ObqPeEPNBaLM/R5njzy5KjDwe4Sfvw7c2zpYgwKb4ekywLyX+3OWQou4TlTOj
 GWf99KYLw+9Si+jPzAmH4p+rC9mViPsGEl0eRZ0YJULA5NbnFqDZRu2/w5irHkoh8bRi
 Jbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751996861; x=1752601661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JimOaRh7w1crCNK8S0djdsSqbjYIJJWl3DwQcYXioSA=;
 b=rYZVHROIpZrci9SO5hGx1sZtrBRCs68Dad2UbhwbrhD2KDuJR1+/rftrKZxJTpVzy7
 uWTHvBwEcId7ea5NtTa29B6BZYpHXK11A0F+Msoa4qYEL9XEH7gajpos04HyW73fOL7g
 qcurefemhQkXjinx/coyZv0Ac4WeElB6H98k00Dx8kyHBWCevHNpJI+oFotJetffdq7K
 +Aj9P1hJ64OpanSqreKF/G98s8j4KlFA+W+LA5SJ8GU+9ii0bmL+WY5OfqXzhxpfy168
 XWsIyvB2/xXnW7x0KdTgwHIn8HKTMl2MWwRQnnaA1fXQ/erC4ykzQErqSK6CPfvbqZ4a
 MR/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFonB2dnC57RYHTjxUQ9pRGk5mfzxy/w5930VBZ7zbBo4ZyEP0YQQY7W/KU+wFHQ/RnRAIQD6H0Mp8@nongnu.org
X-Gm-Message-State: AOJu0YwE9ItIxJUG1N6adGGmoFIV75Xwm7+6yDHLxXpsOq8iNYDfKlOy
 Lis/hfuoLPc6DdrDULoNxlQ+K+3j3kHpP1ZMgWlH2wZJ7OdiCMtuZGt7/TBImUMPJofBe711OkA
 +TEuFHV4=
X-Gm-Gg: ASbGncv88WN7san3hVvM9n4sUZuPX+RygocFj4Bf2BE1gIhTteKe+Rcw/vTKmJSlMn6
 RvLrYW11Y9xYBRM4U5CZfiCgxqZ2TzTvGpqXOhA30HHl5CsNOhZ8uOFJme9KKnGNoRObmnYAgN1
 jq3dwA/kOSGiR1hiyzOgvMII8QRh5jb1fp2oifctU3B+lB5nRoAuiFcpig2mzxr+hfvERh7fqrc
 cefbhxNQnpvqC9PqF2y24+uDtOCJ63p/VuSeBxxM8kE0wMJw9ZZIIKBX5IwQ4AIy4qcOKGcgS2N
 Hc51HdTYb8Vskt6+wWXg/iSCePhCVexpDmLMBcHBuXmNn/HMjSTS64jBlJ08WPyQ6hxx2oNhKcU
 Tp3el4P78bf9tnunLDZOSUc8js0LDJ/lLt3+yFbNb
X-Google-Smtp-Source: AGHT+IHEJP3chP/POsRiyKFxdUz6AF25XSh6D5xzjfmBJquIIary/g2P1/FFAYG+bT4Oi0RyduYPdg==
X-Received: by 2002:a05:6808:80b1:b0:40a:72b7:d545 with SMTP id
 5614622812f47-41110f0c3ebmr3580385b6e.38.1751996410484; 
 Tue, 08 Jul 2025 10:40:10 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02a43d64sm1742229b6e.15.2025.07.08.10.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:40:10 -0700 (PDT)
Message-ID: <d52695e3-0d52-48ff-8402-c9b9fd892cc7@linaro.org>
Date: Tue, 8 Jul 2025 11:39:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 5/8] qemu: Convert target_words_bigendian() to
 TargetInfo API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708171949.62500-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/8/25 11:19, Philippe Mathieu-Daudé wrote:
> -/**
> - * target_big_endian:
> - * Returns true if the (default) endianness of the target is big endian,
> - * false otherwise. Common code should normally never need to know about the
> - * endianness of the target, so please do *not* use this function unless you
> - * know very well what you are doing!
> - */
...
> +/**
> + * target_big_endian:
> + *
> + * Returns: %true if the (default) endianness of the target is big endian,
> + *          %false otherwise.
> + */
> +bool target_big_endian(void);

Perhaps retain the warning about not using this unless necessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

