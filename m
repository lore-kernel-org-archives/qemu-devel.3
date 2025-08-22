Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5CECA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSng-0004Uu-Up; Fri, 22 Aug 2025 10:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSne-0004UE-Rw
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upSna-0001R2-DM
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:31:26 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e39ec6f52so2579168b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755873076; x=1756477876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KcELbuUw+1+H9mAOl6UQfrPWV7H4vzw3MR6CPhp1FTU=;
 b=If0B6u82Ko2KDlO1VcOt9dsLdNtTYAdOH4/D3sAV+Pz32KK89XU5NX+iWTelfyIxXm
 QcpPTUa3sW/bFDBq0Fshrqy2T84RnmMEE9XUTfoPsl9sj5dKz0ocmZNSmGN75EsehnKv
 qdGfy/HFpnVz5wJzVDaeRn1XnwlILoOtCMHdIskLj7/dZGqqyKej8ObfmPYME/m/EGCz
 z3iXBtWcMhjf8jK+2uYGrEvwVi3vf1NDaBQk2pLbg6uXDO1dk6T+lABkQqGymMDWOJ3O
 JAWma2qWiykIDvIykpSdG9Ru0b61j8/Rmq+0ITX1JGvcv0fB5F6lZuw6qnRbJ9YSz65n
 4fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755873076; x=1756477876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KcELbuUw+1+H9mAOl6UQfrPWV7H4vzw3MR6CPhp1FTU=;
 b=vQ+GmSo9nVjMeFhA1THCtBoV4hYy9/20khASXoAcbIkVy6tIQ8SLh4bxOXDVqkFewd
 8ur1WiAoTcgGPIFIUYQEpByRaqbfkqhEro2N+rYccAiNsUgZFmdQ5ILm6VW9Si8lNTd8
 lSzzn0nV9zazpkcgw1FeNDa3dwnkwciy9G/npbmMzQ3okIi79DQVj0kD+BycfkZtX31X
 hGV7pYHhueby60iqOZYcfsBTx7nGCqykH6Lj3tb7TkiwuqWbavBv4X2S8sg35CeJqZ6G
 wnGy7i4G3VJtdht97KQ3IHVzBVKDrpPbduQ60ZNavyU3+8b0pHi/YuCpPPyCNv4NUrCj
 HUew==
X-Gm-Message-State: AOJu0Yzp0PNwQrtZ+7jLVc+NNPBWakYiLWV/URB4LpGILItGeLOMcHcO
 LX3GkmUC8MPopWBhCwh5r+vhQo961vf9wW15MiswMEwNC1p0YNHgNkEYDkp+0R2poK0N3xrwkXW
 JCCHQrcP1Kg==
X-Gm-Gg: ASbGncvPbscEgIRSmEMH6Z8x0z6qSSywCZ93/oaTY4gN2j8gLN1sCS5/Cwnh3r1ttHo
 LB8zGKd0A2WJh91wJMMyqpYJCzrN5X4ToyxsQ/VXhvNam7RA37eaVoGasGqEKWqLZujNNwjA2Uz
 h+eCYX2eS3BsLTSPDOUW9j6oI5hdvzGunBdpxX6PNbJGKbuhJzetMZFBfTrK+A71TpL84tRhrwk
 1qBosf5vniWWu7SmP2WIY5sSKtNbJ8DJxpG1eG97F9D+Isa/Jb1DafnM57T4U3zOeeaZlayTrpT
 AKGzBKyD4VV6Z9zf82OHbYkC1qWXN92peGlLkYKD9AT8d4RJ3ZFpaWMZ87an9PC68mO0/U+sXIY
 RuZ8INe0NBi+CA2l5UeGOjZXpYqeRB9Wzi9A/
X-Google-Smtp-Source: AGHT+IG/qnmJphPksiFoF5HNix04sfvMrecB3tSCzxKuuoV+LT+s6eanNCiy2VASn6zRxic580x5tA==
X-Received: by 2002:a05:6a00:3e1e:b0:76b:caa5:9a32 with SMTP id
 d2e1a72fcca58-7702fa019ddmr3763536b3a.11.1755873075170; 
 Fri, 22 Aug 2025 07:31:15 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffb48a0sm130837b3a.8.2025.08.22.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:31:14 -0700 (PDT)
Message-ID: <3ca7be1f-267e-45c9-9894-67e920ad5ee9@linaro.org>
Date: Fri, 22 Aug 2025 07:31:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] single-binary: compile hw/intc/arm* files once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 2025-08-01 10:40, Pierrick Bouvier wrote:
> We simply compile them as target common code, without moving them to hw/arm.
> 
> Pierrick Bouvier (2):
>    hw/meson: enter target hw first
>    hw/intc: compile some arm related source once
> 
>   hw/intc/meson.build |  6 +++---
>   hw/meson.build      | 45 +++++++++++++++++++++++----------------------
>   2 files changed, 26 insertions(+), 25 deletions(-)
> 


Ping on this series.
I'll be out next week, but it should be ready to be pulled once the 
trunk reopens.

Regards,
Pierrick

