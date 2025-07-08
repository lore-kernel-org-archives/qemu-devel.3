Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B86C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFz-0005ht-Dy; Tue, 08 Jul 2025 16:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDtW-0002Br-PT
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:22:30 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDtO-0000y7-VD
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:22:21 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73ce08ff1d9so111528a34.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002520; x=1752607320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHI/pe/hYxCWaN7ZHnWIgGI8hQCDTXyWj/FvjsArrTs=;
 b=C3pLvICouBfZWt38IybJ/kQEk/L5ExTfXnKoeOVvLMFzIFsCPDKaPravg9GvUJQdoQ
 XpWRj5d5di8UyhR07egXNGTEjq1NxTg0cis5+uYgsmCH0Np43tyrW2XzKdn1LeA420wn
 zMlFSfi3Ce4YrsSCrXxJNyvS0fLiLhx6ldGYAw8MoIMAmrEdoxM9tgZoP0naqFlsUAhS
 MaessjhfoUkxkqPXy1+mdLng6R795NGmhJJ7yNAuWAMLD2m4GbWwLDl30mpF3EyFy995
 wxnPfPppTfRvuM6yYLfUsjQtY+d1Og5uJHB5ZS0hcPjjV4xzk8KD8cTHiqcL0atKJy6f
 eowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002520; x=1752607320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHI/pe/hYxCWaN7ZHnWIgGI8hQCDTXyWj/FvjsArrTs=;
 b=jr67baAXF1IkEr6pNawp36QcbVmpam6rT2CnrzXnJr1LFCU+TPbb6gfOVJyaDlhG0a
 KJ5lg7gfRiERqPSi+vkhOfNaL2ELtFTiwVbW8Lq4N0+dKv7WTvyjt8iTvnO0LjOLW9m7
 duMR+G4CYGBdp6BvysosX2ohlDe065XIXlCVxSkGP75C2eLdKTk9B2V+docSnl/oZ747
 X+ZAepaQFQz97NfGjxKsNtKWBu9L12ln8jYjMRj75tfS2r4Y6zFuzbM1g6kjFjAz5NUJ
 3/bfBVhAzB9JvNAWG49WXV1HDc2ZLFbTwZfuExgYBKHG9TyTt6CeTnNCRQ70cTsbeagy
 N3/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/fuqn7561ta5lQlffzEs0yG0fNjhXenl+5KwUu6IaFV6FVVNXeuUgg+xuQR4bXJLqLAB19st+Iy0X@nongnu.org
X-Gm-Message-State: AOJu0Yx+Uzch7ITC30Qj40n4AGGIKIgHvAlaq1z4B4hxKSKJb2WcvMM2
 07JiGgx6QPCvPnqvVmD2q6e4t8V4WjQXSbaa01rxOkKIc9NH3QwOXYA3le7/xhlIRjEsOfhuk6s
 TYm8j
X-Gm-Gg: ASbGnctRwgAEUK7dkwhJItDmvR7DOja/pQir9oWbusVTZs0H+3h8jL4T0pwOSOku07F
 JU3fELUI1kY99nGmvqVBd79H/GjMfqYoaX+TuPlO1fdR6s4MO2OXBP1l0UAFBF5B8CSR1aJsKG6
 GLRetu39ii9ndCcZq7ecdURUQnIeq9r9LNBAOv6QEeDFpEAoJef5hHagcfCHYc64ltLH0Nli2LZ
 5ZZoF3MsiBDqdTQFXrU16LpmjPkJDMyWZHwKV71oJbitfn6idcA4FxhCNCYUEowKAFkIlCY/AII
 I6fqLnD5h/d5Hi9lNNI9J5QwRUq7VAmky4ldE+KzfXr/TEM+eT/m0rtGugSLUi4bnzU2SRbPi28
 =
X-Google-Smtp-Source: AGHT+IHVgoyd0HH+KmsdHkQpMJxYW0hptSnGBPEC8SUBQ0yvzQICg0NnhyPOCx14mOIWwKBsXyhJFQ==
X-Received: by 2002:a05:6a00:1ad0:b0:744:a240:fb1b with SMTP id
 d2e1a72fcca58-74d2678c6c4mr5240287b3a.5.1751996182113; 
 Tue, 08 Jul 2025 10:36:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce42cefccsm12116590b3a.156.2025.07.08.10.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:36:21 -0700 (PDT)
Message-ID: <e319122d-f7f6-4b37-930e-87d2750557f3@linaro.org>
Date: Tue, 8 Jul 2025 10:36:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? v7 8/8] hw/virtio: Build various files once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x335.google.com
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Now that various VirtIO files don't use target specific
> API anymore, we can move them to the system_ss[] source
> set to build them once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> MST prefers to defer this one to 10.2.
> 
>   hw/virtio/virtio-config-io.c |  1 -
>   hw/block/meson.build         |  6 ++++--
>   hw/virtio/meson.build        | 20 +++++++++++---------
>   3 files changed, 15 insertions(+), 12 deletions(-)

Good job!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


