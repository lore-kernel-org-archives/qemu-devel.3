Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53607CF8857
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swpMe-0006w9-91; Fri, 04 Oct 2024 16:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swpMc-0006vW-KK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:57:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swpMb-0002dI-4E
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:57:26 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20b49ee353cso23298265ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728075444; x=1728680244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ndlMhLFUykF4Iga1gTEwdI7vNXa71E2Ol4nDNrqNl3A=;
 b=bmz93oJb03PKEb0kAeRbe5Q921aOBogX7un2vvnFtAm2ZJHUAtHxgkEtvoY7xmy+HW
 16L0LKgQ75RBtl0mb0MYNkImnB5kfD9AsQn4V1m4ARFLlrQQoSt1JI95E7sNVhwFvj0r
 a6lKFNeP55iPmW5QMfSSBlB4jJ/tsbvRLH5NcTj3wGIjQHH1mATPtl4LIXXnLshJwZND
 4Up7ddU2QOnup622enSdV4YU+H2Y918R9zN0anakgg2ZIbMn+l1J5D40gAqNBIB/ngL6
 0/v4x5O0c3keJ0HthuKJm0GgUciGpf/MJBJMyxydOQNBiq87g22RHfosWhLf837XOA36
 HKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728075444; x=1728680244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndlMhLFUykF4Iga1gTEwdI7vNXa71E2Ol4nDNrqNl3A=;
 b=rrOqcRhiIynSWP2EL+zsDWZgYKrVde/TRLMc/MwPbJwi5BuGVMjmvMC+m9b+jfiXUo
 SLSR++BCw0LkWC76RMq1wbqtVlx86JTSLSa/29/XpWnFpuSgPNPI8YvMkX7YyyRAE16v
 e3N7Uz/xQTV94hrY9VPY1YphA/DDe3pH7t/L+YdnzTzevP8kkTRP0/dky1H1OBicWdvG
 xDmZUtNwI1lhs7dbFzea3otnX9NW84G4rodLFWyA9Djc9BO9vwwXWrZbYzNFo0ACPQTa
 dfhZ4B5/VREWcYtCM6uwoyLqSzqjyypfohUGpxeHL1AQSazvqtiae0I3tjyVdzoUBn3X
 1ZRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNuB81Bo3wYqKVW7lGBpiBmwxoHdUv3PhKOwVP9dxu2HfCdqQAq7kZmpqSu3N5qCKOuqI/47Uvs50y@nongnu.org
X-Gm-Message-State: AOJu0Yw2ewUbVy14zFivk1GfsOd5TlLq0a0udtBfRclFhZbxfcE6MbRU
 JtSRkBPVDnsJMjD9g7qrNoOaN8IO5KmuNCgFVWIoOWIBIWuV1jjyMrOYrp4Mr6w=
X-Google-Smtp-Source: AGHT+IG05s1JSiQYUHLDtPh8vVrBoSyenNXy5ywYmKT5CIS1tSypMHNI3cA2e9iOuyUQeslep5LceQ==
X-Received: by 2002:a17:903:22cd:b0:20b:aed1:bf8f with SMTP id
 d9443c01a7336-20bfe298189mr54530625ad.42.1728075443773; 
 Fri, 04 Oct 2024 13:57:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396d750sm2663015ad.232.2024.10.04.13.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 13:57:23 -0700 (PDT)
Message-ID: <ab8a9197-2e5a-4d57-8c52-a27c79cd2d78@linaro.org>
Date: Fri, 4 Oct 2024 13:57:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20241004202621.4321-1-philmd@linaro.org>
 <20241004202621.4321-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004202621.4321-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 10/4/24 13:26, Philippe Mathieu-Daudé wrote:
> Directly use tcg_constant_tl() for constant integer,
> this save a call to tcg_gen_movi_tl() and a temp register.
> 
> Inspired-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/ppc/translate.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

