Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EDBCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrhB-0003s1-OM; Wed, 17 Jun 2026 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrh7-0003pc-BB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:56:45 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrh5-0001Xs-4v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:56:45 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37cae9b7536so660020a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708201; x=1782313001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNWYekrJFFfnMRJlMA2M2x9PFfj1P5IxC+UPOMFvrlI=;
 b=CSUbHHdt/k4nCVjXwOrbwOq6Zq1og4Qu7v171h16xMlKY46uVazrSoZFNtwof8wlq5
 hl5qi7Zw8CoqWYEpmVr/YW6Rw7irmWay4x1sgDwzrPTSImzb764sXOl3EODbvcjiNBd9
 fUv8owLcYWc/5Vyn7zLo94akdlo4NXHpJDe3TIfGxhr4LekOVDOV18Wr3vLdJYl3w+aB
 SOP//hklz89ET/wGcqFmipGVm4bCD51TcGMNvKXR/Awg7LzmW1ts5xBzbmL43gcXdn6D
 Xq2In4cvjMU2K0eTE5FDuamKMpprA3lmcL1lNL4K1vVMSkqj7i7UvguShl77PpVPAZ/T
 HMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708201; x=1782313001;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gNWYekrJFFfnMRJlMA2M2x9PFfj1P5IxC+UPOMFvrlI=;
 b=eIkcb9SJ3EQwIgla3s1WNw2nis+sWcWnFHjlnk8ASQfjS3HDMNXhLIlxV/i/y5JSIc
 D1/wlE8jKCieD673nT1sgoFMNWpELoFv5q9a0UubJksSFr+qvYSwOpWM2fYBdhkYWln9
 178jNPCxjc/9hZgh9xB+X2BjnYyc5ViIkLmmu966HJse/HUsa5VNWTIhgEIzImUdi/Dt
 DEX5Ln+O98xnfEUHHQ02j3PuQtH3sZiVt1kPlpRk3vnlgPFQ4saeIMeB1HylfTfSdQ+/
 J+oyu4CSQkUIWVcRp+yuBbENRSy38y6WHjw5PNs6wZgirR+SrWqMWJ42WG9nGDyfpv6S
 MaXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Fimk9wlepNo4+ipCUcorGP4b/TiUNFMZT3E6sMQCj07QCWUm0CgOzx5X2K8Cc6U62DQqhBvvgP7MH@nongnu.org
X-Gm-Message-State: AOJu0YyOKzs4hvodf0Bftme5nvjVQFaiUwxegsuc7w4apgDbbV4yfFnd
 Qwmz3NMUg0cI0VsBoeaQvfaQU0QdNcLbmgnrNbxjagc7tvFO9MX3XIBMveRRapkuXuQ=
X-Gm-Gg: AfdE7cl6hhsKQK79zt2PDv283Vq8pxounWNvSA3kRtR4PXvfFsYDfVLajiyPMkrWzdQ
 zF50ytukJvv2+tTJj9c1dymUWknWLJE/yZiTDOp/JmcFHt28z5IdgR+2YnskY+fZg2vvvjdmogR
 pzhDWe/wJ28UgqMLNfrDGeKf/zVTDO+dJ4fPHXE794swJCwOT4V+1jwLNAnPkJ4sv5ADQhgxkdb
 A7qIP5T/xLBIOvRoiBdPsKzm6yPSvfBiCxqJlWY0aCirc/RsSRThBKPQjR97uIcs7bxOqVoxgxZ
 4q/r61SbjYO0ofzUcLKoYIs56HiU4MW159oHGg/Mhv+KlgPTkG9vfMxXx/l6R0zyo+CvAoNhtjj
 BSPgrbYS4+xlLN4RFDaH06EtdplpJMh2BmXtNRjhoeDcf2CSkP4NK9vWcRcMGlyEErVCchkrykf
 hZyA6FFaeqz/tNqbh8AvnZjiqDMVFF04WjCeroxm5A8S23Q6imCmkruqL7VA==
X-Received: by 2002:a17:90b:58cc:b0:36b:91a3:6af3 with SMTP id
 98e67ed59e1d1-37c932f9bcamr4337530a91.7.1781708200733; 
 Wed, 17 Jun 2026 07:56:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ef803sm6361649a91.11.2026.06.17.07.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:56:40 -0700 (PDT)
Message-ID: <2a7e454f-0319-4c74-9e17-db2f619c4a3e@linaro.org>
Date: Wed, 17 Jun 2026 07:56:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Move cpu_restore_state() out of
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-8-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Move the TCG-specific cpu_restore_state() declaration out
> of the generic "exec/cpu-common.h" header, to the recently
> created "accel/tcg/cpu-loop.h" one.
> 
> Include "accel/tcg/cpu-loop.h" where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

