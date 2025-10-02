Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A66ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PaZ-0005Jo-MH; Thu, 02 Oct 2025 16:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PaW-0005Ie-4O
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:07:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PaN-0001b8-1C
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:07:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7800ff158d5so1376857b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435640; x=1760040440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aGG7b7qVuPUbP+WFOfxAY7Hl/kftFIQgiGkDpBr5kXE=;
 b=A9UvZaU1ClPcM7zp1ier4tQ/0LMXUn1hsqWZ/yXBg7ZCzeNWOTfSmiL4Q660hhdgby
 fQZItniw9lWllHbbAxHaLKd+ksQJOz0d/9kbmDlJhJ6GONlj19+xMW4cdlrBJqs9uZeY
 MU8ZXKOvrxvGL/Mvo+T85nBDco3e7bp/iVb1fvisa/sZqcwKEI6Od+JVPzxReEU+oSMw
 GJTeiUCmDydmf+tVVqYp9eubTVJGt9TAKwgRPw0QgND3hqsH0wAbvnSB4NNx5ZdMEpC0
 BEwHMuigtqxUUYRLXCC/6sYGXaSkyMh7FtAjiN5mmw7jGKqwGJr5j/pd/2Tz23J9Yfgg
 /QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435640; x=1760040440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aGG7b7qVuPUbP+WFOfxAY7Hl/kftFIQgiGkDpBr5kXE=;
 b=GceMmYXHINm4uIKZl0iZxZSi+pHKYoq3LHkfPkPgvwFMHiwjOZZmlGniWUXRT6Rg0O
 c0A4DpDU4Sn/Ayl2b++QSP0IZF2iwPaMRo25H6ovHRuLIWEiDIXroCZK5AfpI2igksuA
 1QRG/8tkDnZHF4izOnqYd5dqFTZixMpdMPsBR+0JFRHoY1z4gvZo3Rx97L4/UTYeDpHl
 0DEm4SYOIhw/sNNf6lzoSs63dA1QSe9WWLZhGekoe71905o9TlBr0IyQ44/Z3GfVwHtJ
 /298Y7J28/4JfxaKAMiWRTusyx+z2DDwAV4TZMvAXXy+XmnGLUGFeo+C2P3w2ucok26Y
 x0aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8GymsxdXuf2bRUEIY9zvgc3o8iDI/L0Z9+0ztc3b7fvdzubjtdlVFfQ1NogOFP8aAerzQMqezxj8V@nongnu.org
X-Gm-Message-State: AOJu0Yw8zVRqxPeoxUPv+m2CEQ4LocHM0jLqNhHaofh9Dn8XA1SMCZwB
 XRktaMjfWTBZtDdqdjCZsjoO5v2Dt7PIUsEqXRo3HTnXDz9Gf7Sg8xhj0B4ccvdRw14=
X-Gm-Gg: ASbGnctCVi04IRPCxWnbzK1UjAxZY49ER9m8j+NqoDXLsdz3OQuSwAUpq57FG/UnMUF
 xhzY9Ud3wCT3QHnw+WzaoqNoeWu8AlUjPeBrRCxhVl7gsAkKPAQid7r6HyUQjgBuBiyH8pJoE8+
 4aRwElqFtFbf9uzAqIV55ZRDsGW50Pz1pTOiqG4ApgIzqoCRNfjW7l5EQVTQg+enJUY14pCG8Rz
 TlKmzEti3tvL6pbph+UlVBka9FZtvl2beyepe0ZLYodMRdfYjn+D5xFwI+v1Ak9HTIYQ27zpNSS
 xC8ZdYmMJYT8B8NX7WxUVqR9f8QwlSQT0cReFPWS9kVAQMbZn6/vwnKFGv2+PKj9QvShU8DP/qj
 vdjsBDj6q1j4q5Bb1FriqWQwI3u7K+PwjVTacP8CSb/y9D5MIUsRZ+bH/Mm5VIKw=
X-Google-Smtp-Source: AGHT+IEJFE9zijvzD9muKu+K4Hj7PMWh+N4ebhNwWCiZ1bknFy6MLVDDH37t1cXkRKQ/5Gbm5UW/Vw==
X-Received: by 2002:a05:6a21:6d81:b0:2fa:76b6:80e6 with SMTP id
 adf61e73a8af0-32b6208ebf7mr862162637.31.1759435640046; 
 Thu, 02 Oct 2025 13:07:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f99acesm2914796b3a.5.2025.10.02.13.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:07:19 -0700 (PDT)
Message-ID: <784ff9a0-7692-4bb7-bb9c-de5327298f01@linaro.org>
Date: Thu, 2 Oct 2025 13:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/33] target/riscv: Fix size of sw_check_code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-20-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-20-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> The field only holds values of 2 and 3, fix its size to 8 bits and
> update stores from TCG.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h                            | 2 +-
>   target/riscv/translate.c                      | 4 ++--
>   target/riscv/insn_trans/trans_rvi.c.inc       | 8 ++++----
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


