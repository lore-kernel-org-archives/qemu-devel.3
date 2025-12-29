Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E611D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 00:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1Ps-0002yv-Tj; Sun, 28 Dec 2025 19:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1Pq-0002yJ-70
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:47:18 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1Po-0006Io-Ld
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:47:17 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7f651586be1so4073741b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 16:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766969234; x=1767574034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n/G8KBuW0Q/W5PcQ3m9iw4R/ll2Iqa+4C+8T4pwVUrs=;
 b=ccl1V030iPZSugNfHYz3KdIhBVGXrbSFUAj3acG/5GjcrdhGHDDEdzeMA/LWyABpoM
 oOJPAqVsE3aY0UVBcXwpdYmvVJgGgS5lkyIpYv11GlgqrbC7sl1v9YJdJ7j0/YmB+DIh
 inNCs4abJ45BB9vNTFyQwJQZpRSzCeTMQrVeOp4imDsPdtkovhsEKq6W/n8R0VPavej6
 IH2l2vkFC5L3iAeyPGJ+fC2xPgUOTCDa/Ut8ZJnZTZGlYKO1V1uOCUVCyUAzuyzPTSnv
 Sm7a6oLZSV22YpCjKav2Cu9G1thv5nbtiWh4xqO+/JWjAvdSf0hZR3c8cH0jwxLxPnLF
 wveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766969234; x=1767574034;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n/G8KBuW0Q/W5PcQ3m9iw4R/ll2Iqa+4C+8T4pwVUrs=;
 b=dTyPqRKYo9TYDGImm0kQXdQ+vq7sEBMkVF3AJKC5a+/2yNt4kl7vk0QrLKBFvJRVwI
 sJvmegjHTVIwfJj21g4sAgjcIuhwU1mVWOB3nUeVf/DABLxbzwXn5xXthVvdmH1JUMLQ
 eNMRKumpGvCkcxoGb7fHDInCbfI5sKMYEfttTVPmEOTf2Ay0AoOQj4JAPtR/6IEN/Xg4
 0LcCXkl5m3d30NfWSXsoFtfRd8Bhktt5zqH1uHh1uIDU4syAWh5Fwq8hL3GbW8MgHUQM
 YJOlV49Da1kEd+8FL/4pHDlRsD6L+pLiH1AELCqLaGjMG4InmLiKVstkx38QnKtm8pbf
 wz5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX61Sfk1+Ul9ukmA3tCYFsHBhEuihbEXz2e7Nx4ZgDvmC8qpt30iA/m5qZZkYA97AaT4uNfFbc+hb0u@nongnu.org
X-Gm-Message-State: AOJu0YzpYVu5fCrvUSL03LVAC/8GhzFbDC7xCx7cshP7We7Abm+RSuH1
 O1Lrc3uFBJYWmwuUG0TkZ3jFHcr4P0923ZGwQ1Gb2U2hRKZrSLIQjFgd+5mXI76ymj0=
X-Gm-Gg: AY/fxX5YzBuGwtcCMSoe6g+V+xiaxmL7q8TFTcgzoaMaOLNxbzg2m3EMIJKN3WrMZtt
 moDQQrNsFjz0wOR8B7m7jBctsThoFZweH/df7B8KW8w8uSN9ftbM6zgNuU0dW+nQpyTIy01jv0u
 e9nB9SkkhYUyZA/vIkotcOJCgAw/8Lv8kZmRW8ce2ZSdOiTpmFVh3JZfEuKIcQOx0+c3voec66E
 gfCksBhbFoATAHu08Q48ChdxqdQPW6snDSIEBJX3+LozzeHxnbKh6tCIUZeQ0bcFcRULrJATxt8
 W7A4Awkmz8OgnOrSgJmulkvXkQfgBNWsgrCvjHq8/dzdqNLaHCB2qqyl/FiVr4CjTRQrrdzSyJ+
 2nGHkfj5J/N5a2kIH+phnFk9CNJ3DdXUkE92p6Rqp6jskXodAbE4AncHzR26NP472H9UT4QUG9S
 N3sVRPcBrGsqKSXc3TcIvkPXcEXkF55d5dZ0Bxx9ooVDcLCEL56JQkIqlZLBcY17iJy2EA+A==
X-Google-Smtp-Source: AGHT+IFtJa8A4TWMkUd0hQa72P0T8iEcKDzmns2dzF85NhLqN0vh1AEYXbmL47eJqvN+N2ykPFm9RA==
X-Received: by 2002:a05:6a00:2907:b0:7f6:f92d:77e7 with SMTP id
 d2e1a72fcca58-7ff52d3855dmr25669526b3a.9.1766969234319; 
 Sun, 28 Dec 2025 16:47:14 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e8947a1sm27294894b3a.67.2025.12.28.16.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 16:47:13 -0800 (PST)
Message-ID: <bd385d3f-52c8-44fc-893d-fe6ffee66776@linaro.org>
Date: Mon, 29 Dec 2025 11:47:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/25] system/physmem: Convert DEBUG_SUBPAGE printf()
 to trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/25/25 02:21, Philippe Mathieu-Daudé wrote:
> Defining DEBUG_SUBPAGE allows to use raw printf() statements to
> print information about some events; convert these to tracepoints.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/physmem.c    | 29 ++++++-----------------------
>   system/trace-events |  6 ++++++
>   2 files changed, 12 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

