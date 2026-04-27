Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF3AFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIVO-0002DA-46; Mon, 27 Apr 2026 05:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIVK-0002AY-BI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:43:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHIVI-0003Zf-Hq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:43:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so131566945e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777283027; x=1777887827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aGXkQsc3XrvQBkO2d3qp0jClP04MwsWtO7R/3nWQYNs=;
 b=tgqGpgYjbHbxoQ+8V+BaFWZYjo1deWTPmAmSPq1l4An05hbA7KK6B61ZNB+OJdsFO/
 IoN7ZWIbxNino+6CAREBKAMmqvgbXx/mrDmaF+AcYV3JODEsE8/1u3mzKWeoNTHYcZoB
 6RvrEhwnxAeNLT/w6STEFOSKBRaNWaL4nFK4V3ZZ2q0pJzuf/eh0N9VsMwMBvmlvxTdY
 30IHVahW/8Z792PBHtc1LaPN58Ksws8mvjXKPoXAaocMijsrW/WjcllVA5PHplSPVnIg
 7Trwvxju7Xvyw5HuXpsfGeAmcDRLuIDEVWfJNwX19lqYz8CZmmLgmHMs5lLfA7j/UPXv
 jGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777283027; x=1777887827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGXkQsc3XrvQBkO2d3qp0jClP04MwsWtO7R/3nWQYNs=;
 b=B8SLwcqvP8zeMkEQVFEdEZ87v5jbuW7kd9HPdeSQVkG1AEXjMZhOyau89oVfC2spML
 uI4UeeaOiD6UJ8vMDHrgj2nP6e/jLr+Er/hfffP5ujeI+FqxJ9BebAeYRUHSeMaARSN5
 PQjqNlY+bZu7HVVTh4SvxlBegdSYjMqJYEA5jBF3GyIb6/oJaJp+e75JnVPrb09TDlGy
 ozE/NerAqOxQxv+gndKCLVFIEgLmjWU21vOTJ7Psvhng16oMU6gGqWGirv6W5Ikemtwk
 nNBCplOO+9uJ1rGWBnKaTytYXkJ40vEfVfRPRJXDP7fB+wfTlIurej2StyJ4WO9stFRG
 fZsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GgD83fX00mEgpI1I8C/Gon5SDFUbVUPAYGE081YXR0g1oUQsjKdnNI23YgNfWuZ0pf0oPoop0Ja0p@nongnu.org
X-Gm-Message-State: AOJu0YyLlA/65iuugoYjHvzouKZZlyUjTTkbH3iF0tn4IUbXQLSyIk/e
 IOR26E04lLxJDu3BUNb7yfvBVy8Op6gL4TyNoCyI8A61ymDBOoHFcg8lwvfTPQbm1C4=
X-Gm-Gg: AeBDiesPJuhpRaTKT3Iwar5piL1S1BiLBAkcaQtoZcsDuRkBMhC/GYMfQv/huHLTRUn
 7mP35HtRq40gFFl+AY2MS3LTZr+1mgw2e02/MSKo6g0FpoGKxmxR6IwMBIxdnq2j59p4hEbg3Tx
 OeWNZPzb27sni+DnHvSGqmMk6SC4JiPdwczHKOltQq+v60/Jz9Fvg/Z1ulAVW0yVFtK05Yp3wjX
 rypBvNU6zott9jdgCfmByddy9iGrZ6xhrRa3hSM+min3Y+1i17qJ/N0SkVP1rVfYgjicEMWEtuS
 mGyP7EEtTe/NqzPiql6UTQCmce20X0FY1prcmoOmSlMgwENoKjx66YmE/vLvQ7j3cG097A79liI
 2NWbzHkeSB0C+ElzoQop8P45lFOZU5fiKNiGYQfVjPfLGd31oR+D39KpH1wRkAVR4FdFHhfvTvu
 qDRXoRGlQ1DPudQeh9XbBJHuw2coMQx0dLyPUs3ngVEI7UhCr30Ks9eKw+mC8WNtzzkBpPOb9lM
 Enh
X-Received: by 2002:a05:600c:3b83:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48a707e1ae8mr74887505e9.8.1777283026984; 
 Mon, 27 Apr 2026 02:43:46 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c318636sm583611365e9.7.2026.04.27.02.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:43:46 -0700 (PDT)
Message-ID: <9b7a140d-493a-49dd-8982-a8e49d165077@linaro.org>
Date: Mon, 27 Apr 2026 11:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/84] fpu: Constify frac{64,128,256}_* inputs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 53 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 31 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

