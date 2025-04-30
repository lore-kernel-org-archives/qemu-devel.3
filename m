Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C792EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAi2-00080t-2W; Wed, 30 Apr 2025 12:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAhw-0007uP-10
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:54:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAhu-0002Zt-EL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:54:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227d6b530d8so608525ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032089; x=1746636889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QC1szndaJDScQ5x1wZkqEPhfH+yT3CuWcq7/t5Hq6vg=;
 b=S5FhdrMYBBXZI4m1HWhDQ6nClUq2IOjXaXKsVNM+/q3F/T4LAE3N7a6ei8HsISHejx
 VuRFB4Xq97PIcgWM0aMPQ6Q+jMn/xRlcIE7n6QBEzzKJoE++HkjJ7MjlWMWA1DyK/DRW
 eVGK94dvzuVND8vFRz5aeRiUmkEx2n45Qyv+hQquxpgJ3nmhSfuxldTU1zynOk/BEH+1
 KQEQDnJN27VXNZINdvY68do803FRxGcL+autvhbi/jPZxcMOIc1E36VwTfyhjmBWknrg
 uGqktrm/4b8JPU28fdvhuvFcnB29AM0ePk3Im9lKbshXgKMe2L/zo7T+Yz7xSITaOfvs
 alzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032089; x=1746636889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QC1szndaJDScQ5x1wZkqEPhfH+yT3CuWcq7/t5Hq6vg=;
 b=unc621p02gPl2rQSlVPhoI+DS4myu6XKPpmlc5ggejw8iEHYJuUpY6hgTlnGnuT4vv
 l0o2R6DxhPgCRGB/oKVvwKEw6gVY/9AluyzrJVQu41lACBdfWvSHkMupNt/2UefcukCG
 2uek2JBWmBLWnmDs65Q44hjbmROYkso/bRLFPr+NbYtZnDidNViAdRXVj2S3rZlFmlR0
 N/u6YVvKmtFfufv5BEH2Y1+2F9r4Cfw1v35cW2DSQ7w97PPvj3iX8Q5kkD4E8q2gpfmI
 /k1c6fT99eIsTIfoDvP0ucNvuorU2YRlmgz88Dl6Lcf8uadWSezIbmcMHp0x5txO21dz
 CRlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4klFZ8+WUg8RcJAm08bek2R7A59W1xXVrKvMYPGe+ktXV0kV1fGDRsxO2TckG6Wx24PVOVmGu1daX@nongnu.org
X-Gm-Message-State: AOJu0Yxpb4xzpRBJbGLnNOoZA+y4iNcJgh59LQ4QRdhXcMEK9szdYtuQ
 vWfABwLdHNgqWNQdRLmSKPro0ucLyd7oJDpAjEfjrKy5x4de+R8wtCkloLh7mg/jPDJHgy32Jet
 V
X-Gm-Gg: ASbGncvejCLcMfYml+CqoqmyP+EaH98XMKRo18p7eZN2JQ+/gdNWEdsUwzBf+t1bBo/
 hr4sxzrlUY0ZCfGRUSrWzGP11rc2bW3JzHcpronI/ZAwKZ1bKP6uQThTslPPTB5H8lQCr2wsIqU
 VBG/eLf8xwN9Hi7I1qyCeuqlBv2hhN/DIopwEwNxx3qkMeLDKEcYnr9w9mubas4o7OK4p18GEz0
 B0yVpZdzEyEnDK/rTX8vJbARBtda5cxvkDWNXZvLF9GHKwySrdf9UShSvTuVVm0whwU+J79GNYx
 zKDSveeqqcywuZ5ty4rv+XDeG5qKMLvpiqWMCO9+SpSClu7vmi2e/A==
X-Google-Smtp-Source: AGHT+IHyNGHSegk6474mi38layWzME00B8Nt9OK4OZ5SDwSVEtfydQNpCLh5Nk+BSHUPzdL/olyotQ==
X-Received: by 2002:a17:902:e5c5:b0:219:e4b0:4286 with SMTP id
 d9443c01a7336-22df35121a9mr62665325ad.29.1746032089027; 
 Wed, 30 Apr 2025 09:54:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22de49dccd3sm44071755ad.123.2025.04.30.09.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:54:48 -0700 (PDT)
Message-ID: <96a4a81f-8976-4be8-b40e-f7db1bddacff@linaro.org>
Date: Wed, 30 Apr 2025 09:54:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] target/arm: Unexport
 assert_hflags_rebuild_correctly
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> This function is no longer used outside of hflags.c.
> We can remove the stub as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h  | 2 --
>   target/arm/tcg-stubs.c  | 4 ----
>   target/arm/tcg/hflags.c | 2 +-
>   3 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


