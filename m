Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB21FF4927
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 00:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w70vR-0006fx-HI; Sun, 29 Mar 2026 20:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w70vP-0006dT-9U
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 20:56:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w70vM-0007D4-QH
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 20:56:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso15760215ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774832171; x=1775436971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ojPG2Ze40t1KtSD6h5yAXHlCsX9S2Na7rWSxoBI4080=;
 b=EoyHCl2OhvlqbvnzOOAcVN/HmdaeMypYBrpQfUWTXl/oxKVX6N2x7XeJDNcNgTKvCS
 UeWBXH29mBbCfSwdCx5c6Qi3ENBkeGgOr4snaycQ2sblMJTCSkIJ5dCOKNoJKuQ8+xsQ
 f6jqGeEI+hnZph0yzV7gYcjMD46MHd3ttbWUJbbicLgkXOOVbxLI5JcxiO55LOcER9BA
 hfex0KmPEE1dHAWjMOeZkvkwIWDRFiRjH65/n6tFqZyQ72eqni0EwuaANioF5LH/6Zzt
 1x98hg19XFiUBp5Y0hjKEGy6Y1odbkU+IOJU3qcx+z5P6NdepSKxBbiTqRq/IcdJE8hi
 iU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774832171; x=1775436971;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ojPG2Ze40t1KtSD6h5yAXHlCsX9S2Na7rWSxoBI4080=;
 b=O67oxngBhsiZvcnIkPBvRNhyvb4S0C3yVaPuB/d74nY8njaQPOqCgTbxF4DJHYRndP
 z9wcuCT2RjRhAkTM678RYzWl8JI1ovFCSHZZZfKalXyzF//6D6TzacE/FmTjjL7lQpDR
 8jCIKwSHdM/5NzHOR6z/4EfC6OCIadv7FcJ6iC7en+wq4XfqRch2KtyOG1hG2yHnss4O
 o7KGxoagMnOaiHWBixuRPeOxOBEBfsBRFzTvJ4A5S8BU29zvB4tHOm/ir3iXmU3iUa31
 BTJLWnQteowCsZGeN6DZ7gWpgvO74HkwhkOwuKRhuLLa317Bw0md7McO9BVMb7FSyqUU
 8jJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQu1EOaZ6KABVdZPFaTgPS8/ZU/yYYXD6tT4tZGEPuHwm28LVmsBntDMVGwFOhnuEc7gJ+3iysHVzK@nongnu.org
X-Gm-Message-State: AOJu0YycO8ZPUgXrRC1EIEsRxvXuKZUSCsT796vrQQil4PduexAPHK8z
 sLsvoCvdyf0vF+nbPFqqaUtR8oHr/zpNjEoRhKqNKb9385OFTRtlcYolktA4wzOJgX8=
X-Gm-Gg: ATEYQzzeUOuF/cCgAZ2GYWmL9IjTfjGwHnvBQj5bzoqBA8/RAgS8xke5NLtZsH/8YjC
 KRVn6ZTYGwLsuEb3E9ZMsGJZkG5zELtJthi2yo6ZjZosoDbFGzrJbTqevD771/hPbJMy8jj+EVs
 38x1hInTU//DdVhIeWO6v306lvkwl7AmUpgMpmdYR6yrJYIg1x++74oDtz0F3ZnxNHUbPhLYJd6
 zVRUDFR71SfmIVJmOTypiidnNNcCvtklgHEWCqRVY7EkMnNARLQbU65qx5WiTxIpRsYlqIXtJl7
 Sn5u94SwhxEZERpdglnvCFQYt5DmSWwK9oxY6dgqLVs3o0Fyn4QpZU4B3o4iBWOofG5PtOfZ864
 imJcOCGZEDL052Rq0IbDUrnOvP6+V5RZpF9KM1tUHY8nt/G4eD+uc3G+dN9V58yJo6GbMeVYAkk
 +N+VJjDGjzhU4UlerSyvHykFsM03EklYYuqd86pO0=
X-Received: by 2002:a17:903:944:b0:2b2:4fe3:7b89 with SMTP id
 d9443c01a7336-2b24fe381bamr29726875ad.38.1774832171061; 
 Sun, 29 Mar 2026 17:56:11 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242765bf4sm70385995ad.42.2026.03.29.17.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 17:56:10 -0700 (PDT)
Message-ID: <e680a72e-8db9-4cbf-9986-0b03db60ddaa@linaro.org>
Date: Mon, 30 Mar 2026 10:56:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260327165042.604105-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/28/26 02:50, Pierrick Bouvier wrote:
> This new header defines a new type for target virtual address,
> independent from TCGv and is parameterized by a new define
> TCG_ADDRESS_BITS (name was suggested by Paolo instead of
> TARGET_ADDRESS_BITS).
> 
> By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
> it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
> set TCG_ADDRESS_BITS manually, which is what next commits will do.
> 
> We preserve existing MIT license when extracting this new header.
> 
> Implemented from:
> https://lore.kernel.org/qemu-devel/a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org/
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-mem.h | 126 +++++++++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h     | 100 +------------------------------
>   2 files changed, 129 insertions(+), 97 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

