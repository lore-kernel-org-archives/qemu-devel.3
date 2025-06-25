Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5E1C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURXE-00063C-4C; Wed, 25 Jun 2025 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURXC-0005wn-KV
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:55:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURXA-0006eP-Fo
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:55:34 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so18180585ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863330; x=1751468130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RNiyol9ylB7U8neM2XCWNq0bYVWMA3eKzoFjWdkip5o=;
 b=NM7H4vsABbWkmhgzGeYI3PJeR90/vIQ0K4azsM7MZJdHt7653dwxm1g9IDDp71rHsS
 4SrO0j+Dpuu1RQ8lN9QSsdfxpT+bTjYDPdypNVPNI4kyOU+1haPluR9/cxpQsnm/VoGQ
 2uvLhOIvMeZNnhioYbMsn4pDOwauT/ywx7bXA4A5gRTXpvUwvl3IOqm0Jtw0mnVDNkuA
 APeCpFErY1qjv7qjJm5nn1zg1P0QKw13gQAbCIym2LlsWqWNQUkpFuK7Mw/89Vb3Zaw0
 0MM18hCDAcj+qUV9DspO7hZ3tpIgVcW1S5Jm2uY/tp6iIKalT61EtOVtzF1srCvpPorC
 Klkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863330; x=1751468130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNiyol9ylB7U8neM2XCWNq0bYVWMA3eKzoFjWdkip5o=;
 b=UnqA75e2WCEuYygcXDEa5zW52sICjILQs5hT3RiLLPC/7ElDhjM2mqvqNICG90D7hj
 V59Zb51uqKTr2/YduNfQdJzpoaxR3bK+NZFw75lxAQqdk7GEItMT2djbHBpyrXEX9f/4
 RcYHcmeFW1PZdmkhQDaddEbvwe+6UyXAfyKpwNyLkOkcabB2fn5L5Lu1Y9z+aPGqjZxe
 EdIuKeXqZZuJ2yjM4gzy3PGdOLmmhZP0T97k1sH9TunRRAQFhWaa/dibCnPk2SFxcM5l
 Nlg1kMuLfySfcR6/COM9rjDmfcb18SkPV455pyPZP41z1+ZNDI/PnyrgYuIjJouspc+2
 hXWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWltHA+dw6SQWp90OjFlw7yV4ShpLzY6MwgBPNyr1V3RJZXkfOjPFpkhp48HOT1CB/5JCft3Wn1GcYm@nongnu.org
X-Gm-Message-State: AOJu0Yy7cK5CpoaisjGIw/58RuwNeI7ynfRpVd2ZBtGP4RKfpr5MyTHy
 ko/q9G3Dn6mnIZ7eFVnS/mNhTml7uAQAuKjNa9mQb/RYBSFt19w4GimAsPu+1rIVnXU=
X-Gm-Gg: ASbGncsYIUVCw4iES8hHgwf5T9ttQgeLrihD/wXH1SOUVvOX+9s5PZ6EEHhG4kspMr8
 x+1lBhMb2Qo5cL2FZQ7EvThK/11wCQIzYGrfIDe+CkCqATCWmDRnWG8LfhT//G2uUqpJdK9GN06
 eZLMD/8Ad+s+V0eWq3CDNx3+lgANbSDlvQsJUG/qNZUy5iYD2yUlaIM658iqPjRcPl8Ikl6kLje
 5XQTlCnkVqAoxBwinceOUUMKiXB+DLmEGVurbzJ4UykBSTeQ3IUmJivPH/KT0j92JLkQ8p1OtTb
 qQHSztJ+R3VkK4uf+VncOANHth9fUhs127HDpcGd/zVYJRK0IZr9a2gYyAPwncaBi7BVKujyfnA
 =
X-Google-Smtp-Source: AGHT+IHMgcHUFav8Hq4Bc70LoURNt66iX7JOYP0WsTS1yoarMSB+ToR+B0KvHGjcnOdUczdN7mAY3g==
X-Received: by 2002:a17:902:d58c:b0:22e:6cc6:cf77 with SMTP id
 d9443c01a7336-23824083bfamr63055875ad.53.1750863330574; 
 Wed, 25 Jun 2025 07:55:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83959dasm140443345ad.2.2025.06.25.07.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:55:30 -0700 (PDT)
Message-ID: <9d7849e0-32a1-4cd7-a063-2347838d3816@linaro.org>
Date: Wed, 25 Jun 2025 07:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/27] tcg/optimize: Build and use o_bits in
 fold_movcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


