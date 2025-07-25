Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB09C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufPAG-0001Rs-Tw; Fri, 25 Jul 2025 16:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP8N-00009J-UC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:35:16 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP8K-0003YO-K2
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:35:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so2122974b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753475711; x=1754080511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6fWWxCLqeaLq2d1JjMCCxDhqlgn8PzUW3aAuU9GD/c=;
 b=DTFGs3SKW1U2FjjHx01/ZVjztHwL8NCKBg1hlW8a3IVw7OS5BSSEjlPjoj48nHf8VK
 c7MoQRHwHC85ox9TqoaQusBd8w68kuZzz0P65l4Cltc5eb/BCHvvVyUuojSMKOrf6Q8L
 pcej38dT8g9NJau2L/A9B1ZY32vJJIXYcDg9Vmw6roshUdcLF3ykOxfuoEGTZ2gdo0qh
 LJU88C4g8i94pUwo9q2FtS6RFtLBrPPeHZdMVeuVKc0L8/3ATH4zsPnahEBt0p0JGANm
 ldwHFvuM8BPg8iGqifvgrwMjhmvTwYTpL+wXqjYMrU+bZVGVQjgdDiSkb+Ns+lM4cSpa
 hGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753475711; x=1754080511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B6fWWxCLqeaLq2d1JjMCCxDhqlgn8PzUW3aAuU9GD/c=;
 b=CGmfj85gZr4z2IyVHBeaFlo16JxisVrEZKQc+1jOt15cqUWuPEYJPvb6SWHiuv8ENz
 dlQYg9O2NEPPUFfotLFlMKDHc4bHPAXJUz7j1RaxvP3uO8BY0Qfgxfs6Npz0qB/Xg4v/
 nhayCXMUrj2vpMhrD5toXe62j8JKyxfzFtGzze4XwxhK3gaq7H9i98EGIe18U5BNJw1U
 GT4ZvQjehlYh+Y6EEM43qmCUNF7f8giw23zL28UKOqRN+VlmZ3LlA00quWCobmbPHSBa
 DXINRaBK5BJyar//NX9tuxQ+iwuIPHU03ZqnqkfXLkOp7G11yq7GPFnLesrzYP+xtBia
 FgOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyI7MyTZz1lCdqXjfIk9jXF8JisxpAvzBvQSSFkn7gcILp7RABP/Sj0gcfWFC5D0kUajLRLPz9R/vW@nongnu.org
X-Gm-Message-State: AOJu0Yx33HXiAogQB2H0ywHy1SslLF13ZYnWkIz+aVQ50dwPyR6jd4fE
 lwne1SvX9+Gv4xmZyJ2nxravKdQ+gCnV80y+SHiZqgPv99NkOf5+8ysjTpRkADIx/nM=
X-Gm-Gg: ASbGncvsbtBHl9Ro6IgRIp8vO9Tjo7zdMoOX2BczP0tXj60nk3No3sSWYTsYpD8HM1U
 zG8qcYXQbsTnhj2eumsy9FMFcfcBperiA0nLTwBDCJveH2qOk8M6cKYe91xtze1ahG/2GWu4uwK
 GNhLxhlm+BoumAkcWQTo7YpXyZs+mmYRMpyIDSR9d3EqW6ZYBtCCjGErSBnc5EvTtCr0AD3yVzb
 iZVGk4mx/znwLQzKBn4UnQ/fjl3mwfPpOYBXyTH/A6H/CpPZKAPoYTQt/5gAjcSoYOR6MmSaMHZ
 pRb01tf4IZ/WYlENset/JUKvB1RzNx9TI1p/lvPShtLGYmd+GwF/3lURCPBumxIJzeiEeq/+3ul
 2FEMnA00TK6zeFxqs+xwUQnFGA0xqp7HHPvFF8UV8Xsthc3Q99CIrkNic/NFfZBlU0Q+3zTb+Si
 4ihA==
X-Google-Smtp-Source: AGHT+IEVpwsBlZOKffyC0ChYpd0oT6oCsvlfx1OlQ7lGHXJlyu7b+d2xd6gv8Ta3GCnLyMouZGqvZA==
X-Received: by 2002:a05:6a00:13a8:b0:746:27fc:fea9 with SMTP id
 d2e1a72fcca58-763382d6fbcmr4507072b3a.11.1753475711147; 
 Fri, 25 Jul 2025 13:35:11 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640863513bsm403911b3a.8.2025.07.25.13.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:35:10 -0700 (PDT)
Message-ID: <be00519b-b2a3-4c8e-968e-d459296ab4f4@linaro.org>
Date: Fri, 25 Jul 2025 10:35:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpu-target: build compilation unit once for
 user/system
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
 <20250725202016.21325-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725202016.21325-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/25/25 10:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   meson.build        | 3 ++-
>   cpu-target.c       | 5 -----
>   target-info-stub.c | 4 ++++
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

