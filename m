Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B8C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 22:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUCLd-0006D5-Sw; Tue, 24 Jun 2025 18:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUCLc-0006By-5i
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 18:42:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUCLa-000855-Fv
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 18:42:35 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso7024433b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 15:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750804953; x=1751409753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBhKC9/39X/o7zlW5+H28DuKjKdckyOJo0S8qZBAt4w=;
 b=WdSG3SfqOlAsNCL90cQZLXfL/qpE0+uCXfoaT1vSldCGjKrwx/ryDQdPYzgJnnAYSJ
 x88ArHcG3KJITdxCN/8QxzpzSnBdihPeJjTC6IHtBx8V7CJ2qiocysQj9n22K8iq4LSh
 mdMIKwH+0hMadtgHRD2KBYzX5CesReO/NXvHZNmJK5aqzvuLuHEZI/OWUCAGUpjohqz6
 Urcom/zWAJInmYsjONp4taSV8gaDLK6b3W5J1+rdGvv/2uEIS1vuhUQEUb0loTZErCBr
 pPF1lMt7dd34EyeEKbSw4r9Y+QNc/fv9Q9xZGjShB+1Qnv5zRo5SJIIWeyyUmqQhlT3i
 zeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750804953; x=1751409753;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBhKC9/39X/o7zlW5+H28DuKjKdckyOJo0S8qZBAt4w=;
 b=qHbBc6V0XBTunYFkZ0bg9dzZjJIpTpVhq7JlOusj6riKfWzPYZF01sxJo80j7VfIji
 p36I1SaQIqY21oTLxUzqch/qfxxILcDpbO5UztkSDa3ErxgDQN7HP/fAW4lYJ7jUYBkJ
 E1ZzUhBeAEDZFwL6HjT8a28jAx4TprkcAqkanHShTxQpPhr6PaAOVVPv66aJ+8HBrPd9
 9zpVAaHXkO9V4dzsl5zqprIC5cplflUHdUcuClYohZRY5WwT2TsDHNfqc0KP6Hvg64eS
 cNP6WK7ZD8vOmRXEG8eNkaYpm/jOpX3uVKB2hc9+KhFfRsz+dWmCsiCzA4L1JK4BCNyD
 dFaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9dxLxz7nlOooA8cd5Hi9hRIlNuMmeBlib+35HWWE20uNt2GwVyt/ZUPZCYNegl1nosYdpIMEYNZzf@nongnu.org
X-Gm-Message-State: AOJu0YzTlbP1fgWYnzBMy83QYL4llZZvTQzTvJRcBat/zfu8h0kzrdXJ
 Tspmgq8RDEdfo6cMvWAEsElKcr9ukep1b3vK1jyL6quxWQA902DfYLMRVnuLdZ/Ah/s=
X-Gm-Gg: ASbGncvBex9rmMJGOctTuJuwB9z4jcl2ZwiQA61amZ548vmEI7mM5j6QXTJFkU6dIiC
 n3t2gKs0pUioJdhyyxiEKKi/phLkAOxhiiIDA11VY67dbcTuxJ3yl1+bWvbg70f1gLZhvkDzF+f
 hXIbjKMuS2hYbxg+rtnjxxzg/04qIOpplu6Uoq5l7k7c8IJm4QoedN39/ZXHwk3akzrUg5z6mnO
 eZDwuyQ7ljwVV2wf4DcLNDjrlQlii2aqj6AXtk1jPHw8UwOFBNhzxZ/VquaiDhW20TwWEVdkpdM
 XZiUOWV/UKt+9d3rQW02kywcTLXKdiCotfutUMMBqoIMoj7HyRtL/U7kpZA+KNmpeDuSJJvW+oK
 vII7WLAJZPw==
X-Google-Smtp-Source: AGHT+IHkaK5bte6ZkBoa2pdNzvZIJdNDE6Xn2iowC88apfVYvtd9iM16IELHxroLDh0bp+DNDmbCiQ==
X-Received: by 2002:a05:6a00:4fc3:b0:748:2d1d:f7b7 with SMTP id
 d2e1a72fcca58-74ad45b9358mr1248694b3a.21.1750804952758; 
 Tue, 24 Jun 2025 15:42:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d06sm2843957b3a.29.2025.06.24.15.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 15:42:32 -0700 (PDT)
Message-ID: <b510f569-e8c5-4bf8-ada8-bac889dd3546@linaro.org>
Date: Tue, 24 Jun 2025 15:42:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] tcg/optimize: Build and use o_bits in fold_and
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250505202751.3510517-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/5/25 1:27 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


