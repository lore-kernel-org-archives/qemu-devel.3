Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390BAC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeQ0-0002ei-Ft; Fri, 07 Mar 2025 15:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqePz-0002bf-7i
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:35:39 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqePw-0000VM-W9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:35:38 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2239c066347so43322915ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741379735; x=1741984535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=55VOhjWRhDe/7IYo72PG5VcIlizMahQVvsMB9m8Ew0g=;
 b=w69ZLfK5Hdjvh6SgQyTbdZdPPwyi0Pxa2uM8NdgokqzvmMRPIGFUBTa5MU6uynkurL
 LCYfmJZqgW2isJx+8iWT55gwxoGGZLiDXh4bbfduIVpT0kPVEWC3RYqlJ05BA/3BUyPx
 WceUa4DYhhCJ2zYI5Ix6T5bSTCjS3eCnaYVuUQ8YkZtCq+A8GWoLtVGK461YymOQAOMw
 oievNizWHTmFtt2VTkE67YjDCi6HFNCJvutdYZ84XcT9hnIcgQw31yuEkHBc8H6cWcwg
 7UwU+AoKXnXbCxNkvUXxn1LpMLtpa+8n2Xp/LDyrhSGCEO+8/3hX4GVoZ05UywOa3q+T
 tziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741379735; x=1741984535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=55VOhjWRhDe/7IYo72PG5VcIlizMahQVvsMB9m8Ew0g=;
 b=RIsxMtd+KSa7r1vQ2TU4yFLmuZrX4QQ/i9uIitjbkV2RhPkcJ3QTSCWkNpd2amKeCQ
 hTLn7sEiAUviyzmTCJPfNOWJ7JB6EXQSI0jVuQNn/bAgQ9NE9gwcF1EXNrXh2Uyzuw+d
 zxspR4TPqzf7/421hazG6dFEN4IguHzhKz+KKVlWxI9XEoPeQCp2vXJgb0sZF5+YhovS
 zq6M8DU5qL7QQn9DQ1m/PfCZEvkmNZ9C8D/RXfDirkyMh74LvMMHgadO5wiCuBNyZ58u
 TXbKRdIapB01vr3TFbLT3AZh6BJ3/ElfeEYpecOSdo1CpLMKWU92XpsbAvQK6Q7Cuucn
 +T1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNxkZTSJD7LFAgxuDOAl3QW+qqZ0bEEcaEBObp85MSm6YKIQW/b9Ba3Os+CXa33BAknGYqsdbCTBdc@nongnu.org
X-Gm-Message-State: AOJu0Yy69p9y47p85Tn6OB8UpaYdU6k8iLG2C4tLLyRVWQioqkDOa8pr
 jW5MW1xFEkg7O1SgN6JaMQoGiACp7x/nU9KRB3nDvpJXqFzpupVKjTg4aSAL67Y=
X-Gm-Gg: ASbGncsQrVwjSlTUI+ebKg6aEA3wZ50nE4A+s7U1iLcDRZw3HhUTXrCKLcASAKtFxhn
 rn0cQp118ZWSFZthPTNtFDyCpJi6DZengo9cWAb3SSy7YIeLlUkVVTCXV8B21SX0kEsPQOmX5wN
 SqVpi//EQZeCmEK7iGY6h4bDM7APA3hkwZNYFqV3l2Sp7ho6IYxXsPcVGPoqIeCgvZPrgsYXAU2
 qlpf66sYPR1AIko4yZYjNbzk7CdyuLhaAjbuDZrg43QfTsbgiZI3O5Je6hMFqwaYe17LwaS0pWj
 sjzaSIaJFzd9lFB13WBBgBE4rUly87+dw4CpNPSny0Xn5uyw7aGF+D6gYeau057neuDNG1PIdHO
 Yo24vTQTa
X-Google-Smtp-Source: AGHT+IFfexELkHA7JPXy6T2DUrULw5Helws9GwQ6ek/j/lv6r4suPV3AiKPhajEcJVC9kGFmoGUFEg==
X-Received: by 2002:a17:902:e74f:b0:215:9bc2:42ec with SMTP id
 d9443c01a7336-22428c0f643mr72368005ad.47.1741379735459; 
 Fri, 07 Mar 2025 12:35:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff5aa3d3ccsm3268445a91.0.2025.03.07.12.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:35:35 -0800 (PST)
Message-ID: <b2ceaf87-1e1c-414a-abc2-b2b6239ceee0@linaro.org>
Date: Fri, 7 Mar 2025 12:35:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Convert the compile time check on the CONFIG_IOMMUFD definition
> by a runtime one by calling iommufd_builtin().
> 
> Since the file doesn't use any target-specific knowledge anymore,
> move it to system_ss[] to build it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/pci.c       | 38 ++++++++++++++++++--------------------
>   hw/vfio/meson.build |  2 +-
>   2 files changed, 19 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

