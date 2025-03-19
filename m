Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26A6C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvqa-0007IJ-FO; Wed, 19 Mar 2025 12:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuvqA-0007CP-0Y
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:00:24 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuvq4-0008QY-Jz
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:00:21 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so8786693a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742400012; x=1743004812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c2ypqLgAtK3X+gLxAmm1kzVjbh1+tkBpfpzFpH7Cv4M=;
 b=jyOteQXUDZ+U9AVpmhGs8LQatXuVPacUVFoSlPLWTqTXWEZ6SrxLVeNrhIddKgaLXz
 BYWrOrl2n59wFGoOt5eQuIJjLdB/W/tkO+OwHz/X/q9oa7qR+qB03aXFas6PbI29zBCZ
 gm9Ws0JAdtfOzqfiyaRW/1urO7t7OBGigYuv3j2UeY/VxdseyoMecDky3WQFBdJzCY9H
 LUJGmK9Qr0ojeEofSmmg0LgtFEn5ONcwZbUVQ3VSg2QH2DDQmcnsU4shpGvAM2Sg2DkP
 Hf5Ylk41A3eacNvMr5w8e8SB1bCsC/v8s942H2ct1ZBa8Aa9buRKyT++11dXtgHvH7yR
 IIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742400012; x=1743004812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c2ypqLgAtK3X+gLxAmm1kzVjbh1+tkBpfpzFpH7Cv4M=;
 b=wAtdHlI8mJlGLfQvsC/s2uHfp5NNyT0jRdZwHg0wY44WGHmJHUMU0BVTLj5OP/LLs9
 +hNPHR2KNtThD2LpA2OHrI9jRvyTpLE3ecM6J8WWKmZnVVd/zdfDpU+KWLCS6bd+qA58
 mcvu4FirhP2qSxcZWAAbjlbJkrzgzUa/zWddJzybvMMr7wdqqI5KB042/emen3MBdz0j
 tMHugl2PEg6OUzyKqfaBr8p4QKUkpp38wIkUHMbh1HyloRGrQ1MmAlZBpUSWzYEATDTh
 Zt6uvSPFJrHjprFOYhOpGTxjOLhlFXxP35zUDms9hS2BDbpEkwH9UdhNWH4sA23iOIJk
 +QuQ==
X-Gm-Message-State: AOJu0YzjxOEYOrJZcCA+e1HpUeQGTcy9CzDTnnfAzpuTrF57fqTihX3t
 4hnAG9+l2ZP+kHFaafelS7fwg0EJqS5gtxIVnCTfHn9MemHDijzc61JrcNrM/lHD4EOBA8TWucK
 5
X-Gm-Gg: ASbGncuvbzpmdR99XFGcXRtjoAmfsvjsfUWF8+qsX6Wofeefcd6mtsJNKPfMDH8lzi0
 fNX7PscvWB+XBMvcz8Yo4MbY1suO/69vc1pr5sTMw3qz1FligUWwctQw706jKT05PtfLaXUFIX2
 eefEe0D23GPtE0Q14a5DvYHZj9ylUp91sjUnluiEWmH9D78FRlHXTDlItC5XCTySGHMTNdw4oMc
 9wlVKDAEfK/0TxB8GbJQI/21DT322bF0X0CRkdGydEZchd0gC3igNcc/HCG4xUeeL80hNCtUrlR
 HmiYQkhOPeHdpkTjP8eAKF9h+hZlyGItTTDVYr76d7GqkPOY7G8Al7VHMf6NKIjtgLUqeY11pen
 k6H9Vd+Fe
X-Google-Smtp-Source: AGHT+IEUSWy4lTUyi6Ap50lu3Lmz4vxU8YLRHd637gi8hjNuKmM4+4j3GpS4HGHi6Fgurt8ZFtKCFQ==
X-Received: by 2002:a17:90b:5343:b0:2ff:4bac:6fa2 with SMTP id
 98e67ed59e1d1-301bde739d7mr5740324a91.16.1742400011305; 
 Wed, 19 Mar 2025 09:00:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5a1ddcsm1786943a91.30.2025.03.19.09.00.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:00:10 -0700 (PDT)
Message-ID: <ee6c9d93-f784-43eb-987b-ec0a35168502@linaro.org>
Date: Wed, 19 Mar 2025 09:00:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Cleanups around returns
To: qemu-devel@nongnu.org
References: <20250319152126.3472290-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319152126.3472290-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/19/25 08:21, Markus Armbruster wrote:
> Markus Armbruster (3):
>    cleanup: Re-run return_directly.cocci
>    cleanup: Drop pointless return at end of function
>    cleanup: Drop pointless label at end of function

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

