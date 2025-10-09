Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B53DCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rm2-0008Op-2B; Thu, 09 Oct 2025 10:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rlz-0008Oa-Ot
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:37:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rlx-0003n0-CU
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:37:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so895114f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020650; x=1760625450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LLCpjzMmNrwt1at3Iya+PNQW03XJJcDmu76cQ+jSuBc=;
 b=E1ifQVYXryl8nbhpQ7P2yXtkwnS/hiNSFliIPb36YpMk1LK0Lgk1JW4mNIe1/K596N
 +oblzH6DdUs3qHo41lkBFimZMLCscOFWtcvdny2UB5ZESj2otr47Kq5AVgVW9Ux5ceCF
 j8V+5qfiFQYyzMQqjsT/OAbk+D89nb1EkkfGrxyXW1F4RopYCfBRgfrefAIzUeuQVkUp
 2TFotaWKM/qE82fbxw052ztqH4v0Ma3NDFrnIfkrWaTlO/4AT2iYBPRUdcXzoG2x3bhR
 YuofYQdghuI3JO+CwJKYAIdsaWw5yWqW0tayvimXB3IHCKqSWG3iYOVFbv4V6cdlpnwu
 AzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020650; x=1760625450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LLCpjzMmNrwt1at3Iya+PNQW03XJJcDmu76cQ+jSuBc=;
 b=mFE2q6zhr8TyesP44WSTFnJJTm+he0OtUcM2hVd9N3Z60LQc18wfeyzDHRT8KaLJni
 yiTfBq0K0ryBNzLkMaZKN9BRD/0tjTHku7i/j/kKUdwY6QlaFvOj4KfiUuQHUSFboA9+
 ugFP62cM92Sc01QSnJ9uCnQUuB0rIk3Cs79/wsWSn31VRbI73yOg/EphbRblO6o7Q1PX
 ioDhkfs7iD41HOCsVLkMj3SnSWgUDXNKsO5wX1ik0YN4LTk7yVetPmUcoaYv6zOVL5p8
 PTcfzMqFQiPOUAlQ0nNv74Y3o3WudSDau+BWqSlqX/sflYeUYm7KqR/D/bHd0Tgm/7AG
 kQDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGv2gWz/1X0BjV7stJuNHutxjui4R7MkK2JSotDyHUkd4F/s6HFEbURXWUJB0CTjcTLArre/ZQTm6s@nongnu.org
X-Gm-Message-State: AOJu0YylzHE862slnkzBIdd4o5MVvDP+BU4r64/X17V5gNpWqevn26yC
 VaCUf3ud+b4MplnzJtA9vwmCHJwvrmAQBwryyzQFkfAj1LNZrp6O+GVe41qZwpw/Mks=
X-Gm-Gg: ASbGncuEtnSwRpH/s3GhUpklQ5VG0S7RhBbUDCVj8T6UoDfUmoMHT2aWyrPW2I+jure
 cq4kOhNgjC8XQwtjiCENrH8DHNulxZH0GXSKx2ioLOdvLU5f89Zozf1RovE5XUqklH9aMyS+mQF
 +La8+MOKjk7k4nExC2+pcTKQkT9/AaTb2dz9+voxaWQQOrEBJ0Go9ourX2EyGhvwzK+Wz+zi7QE
 CGickv+vEACKbGxJi0Ob5PieAmumce6OOjbhwlJQvfk0s6b0R8iq46I/5JGPq98k+DcU/pNWAIC
 5zzr+BQAOtGWTMt6KALbnBvw5bwzEXVPXkWnYnaCYLXGVuneXMrJSGZWBwbbgS/3gavnRBrikXW
 gLqjr+YQp+zXcj+kP+y8IyObVLIOvcWSOSTJlyhSC82DfcYLlOGJqmkZ+ZebdywjJ+d1R9JuW6K
 dC/f5IilLrYbgLhQklCM5VS+DipFcf
X-Google-Smtp-Source: AGHT+IEgyG3oeDZihU2EyXIHAbfS6uyOxjbTH5/kQwVkCKU/tITY3lhUHHosw22TP/q2bMMPGEp6xg==
X-Received: by 2002:a05:6000:2681:b0:3e8:68:3a91 with SMTP id
 ffacd0b85a97d-4266e8db27cmr4886022f8f.60.1760020650591; 
 Thu, 09 Oct 2025 07:37:30 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm35135600f8f.6.2025.10.09.07.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:37:30 -0700 (PDT)
Message-ID: <af099e7b-dcdb-4e1a-a26b-93c39f7d39aa@linaro.org>
Date: Thu, 9 Oct 2025 16:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/73] target/arm: Export cpsr_{read_for,
 write_from}_spsr_elx
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 8/10/25 23:55, Richard Henderson wrote:
> Move cpsr_write_from_spsr_elx from tcg/helper-a64.c to
> helper.c, so that it's present with --disable-tcg.
> Declare both in internals.h.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h      |  2 ++
>   target/arm/helper.c         | 20 +++++++++++++++++++-
>   target/arm/tcg/helper-a64.c | 20 --------------------
>   3 files changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


