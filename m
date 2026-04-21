Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80220F8FA94
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDDE-0004mc-8E; Tue, 21 Apr 2026 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFDD9-0004jr-Hp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:40:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFDD5-0006qM-L3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:40:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3038506f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776786021; x=1777390821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lr3GWJcD/PuSg3pYg5WUcd1YL/qS4AZsBupDz1oZvtg=;
 b=tkGPSiNdO7RYoozLeTm84/25jLRufwi2Cc/QgShV+4SPvTwsSZOWsixtPiJup/Q4Ve
 xc0BYv61vejXtGZiRMDku6bvx3XuDhH6n8A79btqudoMAdWlqtGFEIUFUGItQwVFU4F2
 77izh/M8mp0ZAAZ8dtTVj+NxqUIEizhlU6EkbN8Q3BlENdtPDldTMxRVoFzqIeyo50yh
 8cwh3lbQUp6cC8jBiVW4nt0JgFAOUbWtAaYFsff0MBVQUwBUJpg9lOo472XqFbo8Nj+y
 ov6ujiLXwL8PXu/p27IkXPPYzw/56ek8NEqP79vRnTauAAtdsotCEJd9Nf2bANGEpGUe
 DkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776786021; x=1777390821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lr3GWJcD/PuSg3pYg5WUcd1YL/qS4AZsBupDz1oZvtg=;
 b=YW1XzVqJIEOs9RA4ibjGu8IdZf2xwcXYeraa8iDcX9V46tkPIDVUA8Mi+YfTyVtDrM
 +spoOsF1gb5rMEENo59sJ12vmI3ovW7U1CHqeEg4IgRnFyLTWddyq0sairD3Znwzlwom
 NSDfIVF+y9ZfyuwOmDxAtTVDrzIyrUUctrJxwcT7ZYl0HzEYWlHl4aqSWHshqUTnzE2a
 XwiqvMTs5Np0QUciSqpB1ElRUOGFC4BUjHv5KnfFCCAa+GBP0Atk/OcZyRf7JPh0NBu+
 krHoqwrP+eTBmPQcIt8K+/LaITrynf4tl2TWvH7LI6eOymsuwsBdXyN8zIswCvsePeHc
 uFpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C3PwjVoFeaZJyt0C4IZ2QXmdNkVbR1qXunHk0dRzBdQbJOwDbS62gUsG+eDjengQModOpwnHTJKAp@nongnu.org
X-Gm-Message-State: AOJu0YxZGDh4Kv5ti0lmfVvyRuWWfkKwdK4eFi8LzkdqoqerJuoqflRl
 JMGrQxbHiXIxz+QmFSLsaAh14jaL0HxVaLINo2vd5ulmuYoW0rFREHh3MhdAB/fKWCI=
X-Gm-Gg: AeBDiesunIA5i7Sh9eLsE+IX5TUULOsnBIbYk/gik9doh8FmkmEnmqmhO5x6KKyHufi
 PiMYmIVDzbOTA9j8cTpn0EDcMpShWySkHNngxvQ3IirKiVqiawEJ09tXhlYZKi7QHOGm5wBpXmZ
 10Z6WY/DPhhyP0Kp9v1Nqxtqpi+QspLyxFz0sIawnwMQMgB+FshFi2DYtVeq7BZ04OK9knBmtCb
 Q+eYZzUHwCD5JMzLSpK9vl3k/CtCIPBo4aZjVDnO0IPiaNUkP6HsgGsWb0wIG3NYeccTGBxemNR
 HUmNrgBZ/LpPHmhDdRkk/4CBrT/LBkYjFRU/Od1xE7Vv50yyIbydvbWMl7SVcmXhoiMsGCenfvU
 rkXk7EbN/54kjasWcr6nwLBTnnaCW/mPg6GeiWoYJmHg8BUJSy/IWNYEdzdtkT/0cULNZJWNzkY
 x7WCh9ZjF2pKFVZrSRk82H175A7xCNQVyDK8yrIK5J7ZkTuy9uHDp2Idl4kg7ajldWbb99
X-Received: by 2002:a05:6000:1614:b0:43f:e7fc:af2f with SMTP id
 ffacd0b85a97d-43fe7fcaf5bmr15730394f8f.19.1776786021498; 
 Tue, 21 Apr 2026 08:40:21 -0700 (PDT)
Received: from [10.193.39.66] (140.170.88.92.rev.sfr.net. [92.88.170.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm41902602f8f.24.2026.04.21.08.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 08:40:20 -0700 (PDT)
Message-ID: <13fc97d0-ddeb-420f-8c7c-60732aca635e@linaro.org>
Date: Tue, 21 Apr 2026 17:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/37] target/arm: Split vector-type.h from cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260421051346.41106-1-richard.henderson@linaro.org>
 <20260421051346.41106-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421051346.41106-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 21/4/26 07:13, Richard Henderson wrote:
> We want to be able to reference ARMVectorType etc from
> common code, so move it out of cpu.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h         | 38 +---------------------------------
>   target/arm/vector-type.h | 44 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+), 37 deletions(-)
>   create mode 100644 target/arm/vector-type.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

