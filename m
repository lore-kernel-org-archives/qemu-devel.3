Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C874CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOfJT-00034z-QS; Sun, 17 May 2026 13:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJQ-00031e-SY
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:30:01 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJP-00050p-B5
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:30:00 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3699cdeec05so271520a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038998; x=1779643798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZnMi7TP+2C9s+8sbzFf6WuPmYWXSYY8tZX1Owx4WfY=;
 b=lMsO7A0cKWgAk1jrFTl9qTOMXjngoBgOF76GeCjtdopL6MmQRIQ0LUKLCeOER0nbzY
 38PV/fQ1OAR2VOmRYKUwY9rJRJwRH9XQ1xcNb7Lv7amC6G3VgdqZgBQgfQCeDPyi6yEa
 xnt43Znd/3/Jnukd1JLAUZ4Voqe4cEGTk6z/EbWRTOVjuvCRWuWqvl2kyODHQWWqvjc8
 yYhJK2G/E4/x4Ng1FCJmh9QHg+WG5kwV7VwzjTe/4nsZySxo+q3NW2uRfI7G/Bhrbahp
 ojTwiicSqpACA/BlfKdMSa2T56jjC/9ts/FxkI/Jr6IbtqOYw0Zr6T5Eq/NLLp+n+jyv
 kV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038998; x=1779643798;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MZnMi7TP+2C9s+8sbzFf6WuPmYWXSYY8tZX1Owx4WfY=;
 b=QONQo8Fxd3EpQjj4yWZOrrp2woZtN5SqfjHe5dQKOPzfpWC5iJNlANjjiUfx61PQRJ
 B2kT4hQ54Go755Ocp2KVk8pi2FCSoKUt8pMEvQtxIICi/GOQ1jOOnNg2hX3vY/qZGKvp
 VTu7oyR0U5B45AwrVQNo1d4/xnP5jymD0fcu4rUxqj76tyHcbAMjCLqvsAJxWS52/j8l
 ta8xVpYlKEuDpTKcCNlZZE0neMjRg2E5hbEX9/hhVhX6WBfxhuMtLw33fMuEaxwkAm4N
 DYf9pyObjUWbJO2bV84Ujd381HYJ4ORL0/Ct5fcl4r57uOjJy927xz97e4xwgKajOX3Q
 3nvA==
X-Gm-Message-State: AOJu0YyJMwWxpSreZ9o8Mps8i+R01mjUQ/gNNr6Rs27CLKatTpfU165i
 h9ggqv8+e2E0HdnC9cgGsXUtumOEylY06ppuluzk4IfvREZdrdJXYCWOe2JRD5IH2FFemJ09pLR
 eWsnb
X-Gm-Gg: Acq92OHeu42oP8X+dbKhLHAftbRQL7MVjUjXqIdLMSBDW+s/A+OrIRTljYI2vWkRRha
 5DFPP7qwl9xIAbkxWnHfZ3W0pkdynql4IyRxYNE1vVSIx78z+mH5FyTjtah2csy0hbD8bUTDoS3
 TABSvXyLkaQ9THGoSMqwtdAMP++zCU28+tmRmXT/cydoSbLD9/3Nr2qV6PqPCFRKdXYlWo/s/1U
 OcBGDTCTgTP+n5C7wzbAL9WBluYcfJI5OzTlox/mcrOI1Dhj0MImD3emYmoT82j6IzePgq12+oR
 QJ6d3pp2GKKLk22YNpahBf4c6ScduL9m3FKaqtGx4+iyTpDhITi7zD1OpsB8JflhTdurt9NY8Hd
 B8RAcCwXliHpsYy/uXIBXtwP7HPKEH8cuPFrqO5BiugGf52Nwvb24VfCTYcc5vVgO891ZcnD3H3
 ohIqVlslN7rKkA5Ib51pnZusMOHayMVhGZQ5RO
X-Received: by 2002:a17:903:3c28:b0:2ba:bfb5:9cc with SMTP id
 d9443c01a7336-2bd7e8d3b9fmr136884975ad.26.1779038997614; 
 Sun, 17 May 2026 10:29:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe4973sm123565975ad.41.2026.05.17.10.29.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:29:57 -0700 (PDT)
Message-ID: <1622e390-cb00-4db3-b820-b2154941e6ca@linaro.org>
Date: Sun, 17 May 2026 10:29:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/35] target/mips: add Octeon MTP2 instruction
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-18-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-18-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/14/26 10:37, James Hilliard wrote:
> MTP2 loads the high Octeon3 partial-product pair from rs/rt into P[2]
> and P[5].
> 
> This exposes the final guest-managed partial-product slot for the
> Octeon multiplier operations.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MTP2 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Describe the Octeon3 rs/rt P[2]/P[5] pair handled by the shared MTP
>      translator.
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

