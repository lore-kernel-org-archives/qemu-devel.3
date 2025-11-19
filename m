Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B1CF31A7
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgEx-0005UB-EX; Wed, 19 Nov 2025 06:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLgEr-0005TC-NT
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:20:41 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLgEp-0006DO-SX
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:20:41 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so47746255e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763551238; x=1764156038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sTruvQbWa2gjlQKeuTYDcuQmvsjs9445tlrKxHSkxHI=;
 b=xPz8FAhgwzNRgyFecFC7BfWVvyt5CBjxAc2JRTCuKYFyjIoK/LeuivygpPKxuY4wey
 mAhZ7sBO9ZcGo4pxIBUYuLzPDuszpPd69LWNygWzGpq6A2h2A7iIJBwatXARTmAFddnx
 irfJQnPDn/qPfusP6FOYtkYJpLvaTpcn+89ofDbXrVzy9JiIkBgUdEqn5au0XGxIjSP2
 NpSsJEa0EYc0CMpkyUhGHuzv2hX0+C2ynhFAPWxL1SF7GloWMJhMq/klOW+3RRzGEnD0
 MO5vpdjZey0q/GoGIw5ebbaVwfEG48alOVAHh6oJg6mthH6XZcgtjOoKboFhrGEuUNNp
 NSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763551238; x=1764156038;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sTruvQbWa2gjlQKeuTYDcuQmvsjs9445tlrKxHSkxHI=;
 b=FqKAxp/xx+M+TPm68yZ2kkv/V3mupqLuJ80mSV1npFTAm2UX8A8XpPj+6iQfQkUch7
 h+jSjipTy5doSgPvYDed27GfbzctRyAOGb5UpH7IReu9NRs8VLWrS6iZisjC/YInezUf
 ojr3O4fBDC3Lawu2uulijcgsjlej4JSKpnangTvlHnxj6FrlXrNlcW6SENO8E1DXI6oo
 dzafmvtiKGPL8mHM/dq1fZWV3PUeQRL6CGQAdUzCEZKVB8iaCDP1QO8r0oF2mFe/yabL
 P7tW0ldokiiZwQfhk6m2fwg5IxRM4TzUjbubdHa/bCecWsN47UYypgeaJatDEE6FH5tM
 Selg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkHKsU0CA+/KHpJxmKCxbju4znTpd4MxeZoQH6yj1ZuCWhwtsSDstjFARdq5lYrCSq6Ikz4LaKhLMj@nongnu.org
X-Gm-Message-State: AOJu0Yw/9EEUb4mC/2DRyqjSS+OtapRcHRens5iKpew3cep2q9otcdI9
 /rOYpiIQfW9nrTCuo36J3x0MWflydKDUkc5F9blGEq16Gk/oEorxKeJ7KxU4h8C74z53vnU/IkJ
 sSWtLNo/arA==
X-Gm-Gg: ASbGncu7qS829Rfwelhfyoh4qGYzYE27xtl+Fa3T5nhzu8CamtxraexrjyTo115EOMS
 VhEbGBwnZWRqrTUB0rwNlmnCMlrZbRaPA75KnMuKzCg3hyizF796LOyE9j34WsTI3O111gf90PR
 Aa+yTHjgJQRZELUdfLmsLudNyfX1XQNXVEa8LtIZsZYdkxS38bmfOD9HjCNZym1gRsHiaoDo7Ma
 7acFjFmYcH8mjevhStwoXcjveKn/02Amz+5Gfazihi3ElORWq0YHb9aaECzk324ru/Rzy9aZn9i
 FxxlSi65BUw1xaVNnzlhag5tkvHZkvS5pTTlri8SOrre8AhUeb+1IoX4Aq5+ikT7G53RK3DGzHM
 ZUiM/UjGj0dTcUWUk4aZTtvevvloqRwLLVLV1raKIO/B0a+D9GKkdCB4imaPdNgDjwJxKG9gRvW
 qSKbIvLCeLVF+42qTJYc4Rz8AGIboFzMByuGBybWfTbV9hM1+jTUwGT6vUP9PUnpC5/1I2uenE9
 LTRnpWEphog5VjR
X-Google-Smtp-Source: AGHT+IGaNWBg3i6e6SRk+YulWvBe3ExscU/we3iBCKBwNKy9AQLFCljnGX+C06aIpTfNMRZF0okFcg==
X-Received: by 2002:a05:600c:c177:b0:471:13dd:baef with SMTP id
 5b1f17b1804b1-4778fea3048mr200781455e9.26.1763551238002; 
 Wed, 19 Nov 2025 03:20:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9df8db3sm37189585e9.11.2025.11.19.03.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 03:20:37 -0800 (PST)
Message-ID: <277c2bb6-5d24-451c-a45e-893822acd2b0@linaro.org>
Date: Wed, 19 Nov 2025 12:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] linux-user: fix mremap unmapping adjacent region
To: Matthew Lugg <mlugg@mlugg.co.uk>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org
References: <20251117170954.31451-1-mlugg@mlugg.co.uk>
 <20251117170954.31451-2-mlugg@mlugg.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117170954.31451-2-mlugg@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 11/17/25 18:09, Matthew Lugg wrote:
> This typo meant that calls to `mremap` which shrink a mapping by some N
> bytes would, when the virtual address space was pre-reserved (e.g.
> 32-bit guest on 64-bit host), unmap the N bytes following the*original*
> mapping.
> 
> Signed-off-by: Matthew Lugg<mlugg@mlugg.co.uk>
> ---
>   linux-user/mmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> No changes from last revision, just rebased.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

