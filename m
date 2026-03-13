Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5A8107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Ie-0002gv-MP; Fri, 13 Mar 2026 12:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Id-0002gn-Hk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:23:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Ic-0007YN-2w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:23:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-829928e512aso1271685b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419020; x=1774023820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrDbwCFYLgUvCdw8aHYwU87OjaTBlhicnvx035FJnEM=;
 b=A+vmSS3vE3VnRuzPjUbpeuesfX+SMGYequMATNzOuK6ijPA00g1jeRLPEIBip3qENb
 uBzXtjHKa0GX/HeQV1Y+dkfJSiZklBRqzZ3IwfoBkSLRX74GcAWFvS8WHUHjiRbSHD9Y
 AFTMCprUMMA/jPHx5vPmlobLHmuk/idZB0VaBJrAR2tyMuQoZJuAGosK2lPOQVXarcxt
 ydWMIak2gFB+x4211fiEeKpXW2PnUtIHNBp6ZLte2w8AVoQ3CSJSiCRhJZFu1+/FHdIA
 bVY9euugVVHEWMi2dQbuu+TA3T/yoJ09f3hFi73omskAWjVxRRiNcZ5Hvxwa2TPa4FI5
 OKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419020; x=1774023820;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrDbwCFYLgUvCdw8aHYwU87OjaTBlhicnvx035FJnEM=;
 b=eGwthWm6t8f8bireoCwEO67XJ7dlPGn8hKZHJwttXbKEIfwxvoWmsiLfr3ZaRielim
 LOJ8/IqU+wu1UdsjTyWglmk1uRtRmHmy7yWYxuOr78Vu8mTTH07RZl64za2VTaUGFmVE
 jemP59lMKeQ4zoEfpzH47J5Fpwbwuzes5XMLCC4BJG0O7xm38k5jBubCdhYgBDDgYeuy
 jSFXYl5XsRCM4kVgYVKnTggeNJAUK59RMKdlI2l3nnIZhGxIrjmaGnkQUf+NCW++Oqca
 8zm9LKdFFnQCm0mKW3QY65G5Tctc+X90cdTXpcOIVwuls3P230XR8LTOUA/4e4yVm4lN
 2dhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM8yT78msdjLjtdmztg3oTBEwCSvinZsc9zuEvyc6vBB6ZLwKt7FUevIIUcsHPaKzEoKxH5e8QMQ/5@nongnu.org
X-Gm-Message-State: AOJu0Yy7g06MG6FL2qkKbMFFBu/EFcpKfwveL+xIVwQcYQuwn6t75YuB
 7vx18ZjpOUA/62eIKE8jbUINyYIF0rf1EHUXJUx0mNJ8N/Y8WHeOX/rQGPQDHIwWT44=
X-Gm-Gg: ATEYQzzYaKMBMADH4RmLU+NiXMe+ayGcBcBLsFSwCFv6QNUpwPbw7N4pYOCuBJyZ5+8
 MGBcHCqf22T2Ejask7B2v3qz5UqnroscCBmDdGknZPJIM7+YqSQvnZxUdVy8Yq43J6UoclSuT67
 RpfinJv6CeJO5qTY8W7qezg238yeC+qY9K6oy4PSW+ivQwD/6WWE0otvOUplETC6LQTysLuPECg
 le3wzF1BwLWO9QNqPGt4+4q9aph7aMswwHlNAWKL2sCZUodaOpdFLTB28v6Cg8lWUNcequKcjiS
 vW1ayh7uvSGtbsCwD59c9JYJYO2qlw7LeMavoPxO1G10EjjIwH1hiBQ5ozmlz4vGRM26wJh9RCt
 ZlHBVSNfaaO/jRHQEsveocaTcmKBaA2p8e17cKcMxLZJVHQ41MxXCSc5ern4msl1Qs+Tyf0Ztyh
 +1gIByTX5GXyl8hb08DcJL5wm3JKcgHGlG/1oZdrFd5qPKQr1wuSFwOJhQlHZ3g960tQDOiDOky
 LFuj0k=
X-Received: by 2002:a05:6a00:4406:b0:81e:8e66:38cc with SMTP id
 d2e1a72fcca58-82a196b55b9mr3178721b3a.9.1773419020359; 
 Fri, 13 Mar 2026 09:23:40 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725e05esm7929831b3a.18.2026.03.13.09.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:23:39 -0700 (PDT)
Message-ID: <ea2b0158-335a-45b4-9302-61dceae98f13@linaro.org>
Date: Fri, 13 Mar 2026 09:23:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/38] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
> compilation unit common") which replaced the target_ulong use in
> arm_handle_psci_call(), replace the one in hvf_handle_psci_call.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

