Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004AAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 23:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEybT-0008Ir-6j; Tue, 13 May 2025 19:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyb5-0008A6-8h
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:59:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyb3-0003wD-Ly
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:59:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so2600558b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747177175; x=1747781975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xr6pvRDOl5fOUkD0enej84TIYzBIxFNeAPylxEVfqr0=;
 b=HjByJNRqvtmmvOt7rVOq1/GKKykKaKUCZmb29esfvd6ivznSioIRCiyp26OiXqj4Zs
 su88KMjZvqRIdsmzYlVyN2wOJNVb1UKFkm1Ottwn4LfORGVQEgcRxmdGd1RUyzzJRrDp
 qS2eE21d8B45TUTIrb/fPZzTPvRPHB1qoxquoWZKd87y7Red1DkKnqW7iLHmgEhB5T3i
 xid0eNnGPP2fbLQToyjibJCd4Fzwsc7ZwIbfwcu/3qB8tQw5cj4mVheOEscGXm/CJz44
 Y/UIvE3I30VoFPwCZ3fFmLt8Lk8Ctt7JqgM7rXUK0G2SQJmN7a7zGQR3EvuomDEE22iH
 Atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747177175; x=1747781975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xr6pvRDOl5fOUkD0enej84TIYzBIxFNeAPylxEVfqr0=;
 b=rNW1Rhq0X0UV3rUlupX08U0bpz40k3DYr8yfU1GxXyrE8s48JmDcnGbHAZPbxAPmZM
 d1UXNGSEtNEou+caXi3vlTQDPustUCLjRJPR/B/lpao0oLA0gmvFmGy7ya7AEZA60AsH
 ozI7EImVDMgP+89tWDffHx4c9F5kLbxbHvAmpg7UBHV/CD5hP1CwER24OPCHvPaJij4z
 xtXjTQcWi4CnfTDlYPN6VxgDCE8KfQjqiUwQaF1iGFq+cPJ+mx7wNaHVwwbtqwdkI9Ko
 dE091Z2lVSu0vg+NL71VaqDG7LyyF9ftKOdaNt24ZbYAr7qDKBsj9dS+cw6GybHrTaJf
 0rEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe10gLlIfx5qapu2q/djhtNzHBHoZ7RnUinmcysXMQUhlrtZ1bXa7sYndPS9ped4KBQek9TPM+I2QC@nongnu.org
X-Gm-Message-State: AOJu0Yw9SlxICYbwX5+Mu+K/IEXEJPiwhD0tuzQ7s9OqFBzGjPTSwIUq
 8HdlT+nkDdpPCTK83zR8op8zzrBSiQGZOh7CfpalPbFYoHESucYz7bJ1E4TWu24=
X-Gm-Gg: ASbGncu0jikTTh7sVl4Et2HUNCmsLiHyXkUciKUhtJKrXKValE8zxL8OhoPU7DCZH3m
 pWWUB8GdpLvBvX5ERQbCMKg/6qpWVSInI5Ohe1zAb8hwm3Me4klKa1eGKPThlWs4wyLzH06bec8
 d9WQW84rzFLjWVAYGVWTyGHQFyGJM9eF9dCZABUESyDOf/NgMm9NluWdwSMvkC1WD9qyvmXU4Ha
 T7JKqHSBbLSfFXgsHyBn6tmZzuvC7VOL1P2I5RGzSgDVHJZhcyeiorKHABGumbd9CJ4iztTyPkL
 wyuWDVPFiUCHzcqNhRaipEojDRP1mNALKl046HrAu7LscBSez+1aOj1G84AKvkXc
X-Google-Smtp-Source: AGHT+IGCOxvl+qtDPVuGKUe8H66dbkahkWys7+EeicKYDkJxsayHSVR240OVrS7tJCqU+98V4kkWQA==
X-Received: by 2002:a05:6a00:a83:b0:740:596e:1489 with SMTP id
 d2e1a72fcca58-74289373d91mr1716246b3a.23.1747177175074; 
 Tue, 13 May 2025 15:59:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237761e45sm8218618b3a.81.2025.05.13.15.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 15:59:34 -0700 (PDT)
Message-ID: <336bbaad-b46e-4c6f-a903-181e6cc8adf1@linaro.org>
Date: Tue, 13 May 2025 15:59:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] target/arm/tcg-stubs: compile file once (system)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250513173928.77376-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/13/25 10:39 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


