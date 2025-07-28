Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90509C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKja-0003tk-U9; Mon, 28 Jul 2025 06:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKjK-0003Wc-R3
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:05:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKjD-0000Nr-9n
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:05:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso3973110f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753697105; x=1754301905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x7vd2hxTUcPcrz7+xzupNRwXlmiEluhmpOL87fjXIEk=;
 b=E3oSmXs5xjtoEcTZdO3C/GpDSg69Lh3NO3FFW11Y8N7nqWnFw8+uXLtJx2Ey1uPLNX
 8uyPG45TtPsb0z+OXYeffhtnTHx/jbwV7g0JzPwewa3vvS6i67ECWu0j9LJOCuZ0GRHl
 t7uwNyVtztdkJu0g7rXAkkutrau2K1d2d+cQOui5tg2edJNgSA4o8TpdslnlhCF+IlFr
 QosdbpILElZ5W+oUUC9tFOYaJaLHMmgcq8wgl+m37/xYKt5AQysMg1Dcvt+aXOno38/h
 Quxc8XQFbjLU/I/8rNRe9A+0i5uTNR838JMJm6bknhEwUVoHHM1VBQDr3lzHghFBWnh5
 SBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753697105; x=1754301905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x7vd2hxTUcPcrz7+xzupNRwXlmiEluhmpOL87fjXIEk=;
 b=lSsbgxGHVAlbCHw9RfDt+WWm2+mGnwRoW+Ub5lTdWhCmXbcwCYMEAVYNFJOppb9H4j
 9dOsqH538ek+TA6uEGhtiLa65OUe9BXml6MxYq8RdZE1L8Twa2KGQ8znqM5FRIluKiCe
 9BzpeoTC7jsM1bLX4FZM/lixx122mKsSx4ZnAvZ/09jt0Q5rAkVwU0ufckuDajIgGDKp
 gTFE070vI9+PcN7o61nm70ytJBZ+1j0LA2y7XIm59eumkjFEqXVSNeUvIX5fXOnXWbhS
 fJvFUwkwjcjoTTdvMJFPIR8f2+IAkUcfYvGACXm/QwzHeDK0oYFXOWWCOqtfPMyaoafc
 iptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM4QVdBw4TE74hkT/AWOwEmo4iXeLYzkkzr5c2+Ejh3F/Jk6jWofMSwdrcdIE1185KO8j6ZeC8OA/K@nongnu.org
X-Gm-Message-State: AOJu0YxgMoAFbMZ61hatMner2aj/wK5PLiRzKqAeKI8HMDyGp5KQmJK/
 RhxM/WvWESLPdUgNAFYWGoiQAP9l8ij+n80VLSpXwZ7uipQs3aI4qsCtoGws+UM/+Q0=
X-Gm-Gg: ASbGncu57Tf+CrvL0G3gI6NA+4oT477Vx1gqHaIdDUswfBS8yMXaqGcoMR7Wj/zgzf9
 uE+8Ktyx43K+oa505ppL9fqhkkLG+Z3y82d5Fx8+9igmzZRRJkFN9PlxO2A10aIy6VZ3yR1xxaE
 xcBltEh/i/Kz7y6Z7WUVYwGo/KY9DAHY7UCK7lLdaaKU929s7iLXeuquJrKYiptKRYXJToPguug
 StyCpuaqMBCidfoy1eyD7Ya91yHF+tJcQtuOif3D1+rq2JCZgRtitEKbbWV5ticzp2K3HAacsOY
 qT2uoG9ldMO6e7YZGcicBtKX3o85rBJnrLCNRWCnGYz0VZzAmAo5QJu5ra/zxOKnSeYpuCiP36P
 4iTrh/dNljwq/RuckUd8zgQE1uBi5x/e6glaWVbYja0YSRoh9NEf5rO+p6x993BQ4AA==
X-Google-Smtp-Source: AGHT+IEs+8m/HSy60Yj1uqhx4HJ1sA+jHICgSj7CrEPkqDIH0Kz80PkkBcAvmQCRvmh/kZPmle/eBA==
X-Received: by 2002:a05:6000:2882:b0:3b7:8146:4642 with SMTP id
 ffacd0b85a97d-3b781464b28mr4623057f8f.20.1753697104574; 
 Mon, 28 Jul 2025 03:05:04 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705ce775sm150195165e9.32.2025.07.28.03.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:05:04 -0700 (PDT)
Message-ID: <9a0744eb-e0c2-4ba0-a6c1-af7952878ce8@linaro.org>
Date: Mon, 28 Jul 2025 12:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] tests/functional/test_aarch64_rme: update image
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250727074202.83141-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 27/7/25 09:41, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> TF-A needs to be patched to enable support for FEAT_TCR2 and
> FEAT_SCTLR2. This new image contains updated firmware.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
> ---
>   tests/functional/test_aarch64_rme_sbsaref.py | 64 ++++++++-------
>   tests/functional/test_aarch64_rme_virt.py    | 85 +++++++-------------
>   2 files changed, 66 insertions(+), 83 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


