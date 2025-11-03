Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF126CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 09:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFqji-0007Zm-Ok; Mon, 03 Nov 2025 04:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vFqjd-0007ZV-S0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:20:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vFqjY-0000jb-8k
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 04:20:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso2397003f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762161607; x=1762766407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KctChtSfkGMHWAPbTteDG6VoGVU9BKak32f2sFKKdhY=;
 b=qJoVI7zKCrVvaoOdGtE6ppHLR5KdxK7+EOPJHnFKZ32QUP/wNg619LTdhn5dBraxar
 +kcHjVqoeUoH21M1TZofSTOBz6r7GAPQtKs5V8Pp0fpXHho5pktwf97qtRiUE41ZCzx8
 xihnl4kG5ba2ZAqR6Q04G1iRk/RAh+3mBRrjZ60bVDHbYr1eYOSjuxjGosjWfEXndyL3
 DydS9bFb5IutS+uDmX5zzRWOrE95PR95Uhe3fHBvrttW8WZw+jWSsId26oqFxSGTI0Lg
 OQV3dsFn6XN4KG/LrgcUV85zvNw1pk1D0syGz3VrmI+tCXfySSIbTX7NoJmHEWxprzxE
 RWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762161607; x=1762766407;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KctChtSfkGMHWAPbTteDG6VoGVU9BKak32f2sFKKdhY=;
 b=uCd6Vj8zxrnU3bH8ATNJTiIk7gRyjriafK7THVm6E1hDo6XY2QBjVAgwe1bIL7M9J9
 nIB9pkwfNENjh9XGwrXVOZRW9wCyit6dimPh9MnhThPsXDzDh4CbZMNO+lNfTWtMMg6J
 HNYrdoAhqbIk3b922dDjZJTFby9B15EqFeYSw/VM0JnBA/CstcuMcc8GirG94rKnZe/p
 GGpoKLFuLNB6uQsKUUsTJvvOcsQ7XF5ZuoSazS/oDH/Qr3Z9iDkHhU1RRIx6gJto0BLk
 KxL5/Fvm6GTG5G/5BN9VgMF8mgIx80U8hTj4RlL4LyUpzHbry4+HYGUhnuypAXn4CpJ6
 FVLw==
X-Gm-Message-State: AOJu0YwnNoqiGEIznByy8fyb5duPezROF6U/NHHgAR3rmIjUvA33fzn1
 XTrDi/MCs2rOZYMymPllqYWZaq0vRYmOJ+D1gndluq+74XdgrWrEiB8a01HxKROrHAC1Zj17kTo
 ab1hQaJ8=
X-Gm-Gg: ASbGncspMsvFyhGeUxZS49IS8ubKs7s450NlcjZVs9T7QNh1jsSTOkWBpr9Kj7581Gs
 GppxmCBy3v5L30lb1jVUFJ1MolAA6cw3ZLTjy0zgSvzbDhPMmjVkuAmxv3r1rnL2W5pnONYp7uy
 RLFDwdo4FROoRzqo0OdupxgvB0gMORdDB5IoEez+q0lIES0QCYH8bnlFAuLPqj0wWMRrpJf0tY1
 cWxFwLB3wq9p0B8rV/+GW5gvL0uisFpoNB1JXLSj8V6MrK/X6t0W9q7Wj3itFE14ACWy+8x1ffJ
 4Ew/LNYVIrTjyS3SZEqJo8ICiLKYSn0iFnIHo1gUWE4noYDsqCs3qPj8xat6rDEIvJd1O14dij6
 PPDZJb1UVFr6BsSbzDtpIkTg2/wMvlJMaJRcQj6utE+AAt47Z2gmEQUccB1TmSnmpsB4+l/1GwG
 FwRBzpOoyIxzSd+elxrcagQvVFkjyXP2D4z30vtbpeif8Mdq7sBemxXybHnw==
X-Google-Smtp-Source: AGHT+IEdSlDMBgvQk+ME7HSotrRFpMvWUKVWtzrdkX1mFt/EXEDfcihSyVSCjsdPKbISa/8mIynEYg==
X-Received: by 2002:a05:6000:2887:b0:427:e1bf:13bd with SMTP id
 ffacd0b85a97d-429bd6e1683mr11076744f8f.52.1762161607018; 
 Mon, 03 Nov 2025 01:20:07 -0800 (PST)
Received: from [10.240.88.227] (34-203-142-46.pool.kielnet.net.
 [46.142.203.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce80df16sm8600487f8f.2.2025.11.03.01.20.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 01:20:06 -0800 (PST)
Message-ID: <6aabcdbb-acdd-4b3a-8652-b9c1cf3ce435@linaro.org>
Date: Mon, 3 Nov 2025 10:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] Accelerators & CPU patches for 2025-11-02
To: qemu-devel@nongnu.org
References: <20251102181406.51160-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251102181406.51160-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

On 11/2/25 19:14, Philippe Mathieu-Daudé wrote:
> Vladimir Sementsov-Ogievskiy (2):
>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>    tests/unit: add unit test for qemu_hexdump()

This doesn't build:

https://gitlab.com/qemu-project/qemu/-/jobs/11947161300
https://gitlab.com/qemu-project/qemu/-/jobs/11947161195

and 10 other variations.


r~

