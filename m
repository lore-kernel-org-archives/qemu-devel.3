Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FB6C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz7m-0000sf-Kj; Wed, 02 Jul 2025 11:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz7f-0000qU-8x
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:11:43 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz7c-0003ds-JW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:11:42 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so3959214fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469096; x=1752073896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1P/b15bzQ84TTvxRk2HcWVLkE78aupArmTK/qhV5P0w=;
 b=BWEyoi+7JsljuN1e56BrvE30TQd8AVTGt+TD9Oq6tb3gt39IVwU50xXd9ca300WR1E
 Tfege5NGENDqUze3XfUPxYV414Vm78siI7IkyR5wHy6b+UjhIAksvGgM7q4rUlr+n79H
 T7O/UfVnyNSqTvQAB+mkut6HVvi38YOjjullGQX6f62SQ0fjYcLGJ+zdh8zMgQlXYomd
 a6VG31GiHa8w8h8AmxKr7yffIJk2RU2xk4GLsVBanJd502pb0qX7F0BXjzfRtCrkSOei
 yfZgmbm5nYCvPc6n65BHIy4pLVS27eGwHYTA0g8eNyUE2B1QRT5IlRwAb7uHrwq2jNsh
 SHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469096; x=1752073896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1P/b15bzQ84TTvxRk2HcWVLkE78aupArmTK/qhV5P0w=;
 b=T5bnPAseP0dZB5tmiQSwTcnxJGeo0I/j9pkse9Zc94FqLSNZLERakBHfVwLC6MCjOt
 vNqIkmHDfKNov+JjeMVU4YqdgMZ/BusXGpP2rXT5cjbufh/kh6Stp5TSrNxZUGUrhIX5
 63Bn1M9Fr5xMyCmCWKUS6cYeK6TEui7WwCT0G13vx21fVVGQDnQCgUN1O3geIhFwMX2A
 QbTu3gcdYtc+dkCn1NB6loGASsAP/7+GzXvhKcW0dlDZYJXsRCT6ZgYxVLOeKj4dbAET
 oJ3Z+1eiO3oni2ncGyKV1xqejrRAExH3ENQ5ps2FHj3TPiLOT97LRf4IbxVA6P7aCahm
 6JLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKe9BTdh9i5HItkBxLNkNjIdYCmI3B029NuYxZgpOoJRWtD3jzJMcBzug+13xUSsJQfj7ZY+A01sOO@nongnu.org
X-Gm-Message-State: AOJu0Yy2DlbL0evDvIY+EO01LBwZ+a9skzmZk2G8i7OXjwVG9odN6hHe
 BfBK9uRvXVY8NHooJqEab9Z5DqJ6BTvCbc7w2CbFlkc0B1M1n6U9q8Njsv/SuRyNjhDhYATeTq1
 YCGAO6IU=
X-Gm-Gg: ASbGncuknfex/KVcPfZnhgRqVJ3e73ctK6iuZAXdldO/TE+JohWYcOyUYY6R7HEA4Nq
 PdTjpt1q4fQuTfihqm1wYgutW2umW/+UHYl01fig1xqhKEZ3+6yeXc5sgc3yCIIhxw6zl+9y9ay
 oLt13ocg4TO7zEIjdhyhVw3R7akTGeXB8kU6av31Us9+jpCMnHdp6CUs1dwTTfxeC3Snopu8S91
 RSToZQMsF5peQDIz9Np02z9bCen8+XgtZkCeZ7mskRfpRgVUhxhwsODREJ7LTWe0SJUzXouPspe
 J5J/Uz7OBVdyMMtA3/OGWKgm6+3MV1RS7DFolyYDxAlVRJdPg2RsFI2F2RHyUP6Wjd2swUJVA1U
 P
X-Google-Smtp-Source: AGHT+IFKTubiqBJWBl6/7UlNjlhT/2RPtYSkeweSJyzM0Thgah6kZVbtjYg+DnHdwH+F4qsY9Z2QtQ==
X-Received: by 2002:a05:6870:524:b0:2c2:dfbb:2dbd with SMTP id
 586e51a60fabf-2f5a8b947f6mr2343123fac.8.1751469096120; 
 Wed, 02 Jul 2025 08:11:36 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f9748sm3952965fac.37.2025.07.02.08.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:11:35 -0700 (PDT)
Message-ID: <f7170a42-74e7-4ba8-a9d5-a8d92fbde2bd@linaro.org>
Date: Wed, 2 Jul 2025 09:11:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/68] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-36-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-36-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-all.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
...
> @@ -2226,7 +2225,7 @@ int whpx_init_vcpu(CPUState *cpu)
>       }
>   
>       vcpu->interruptable = true;
> -    vcpu->dirty = true;
> +    vcpu->vcpu_dirty = true;

cpu->vcpu_dirty

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

