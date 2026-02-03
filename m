Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8258E8304B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn75O-00047h-9h; Mon, 02 Feb 2026 22:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn75M-000477-Hs
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:28:16 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn75I-0002vN-FW
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:28:16 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so36030195ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770089289; x=1770694089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kG+g41jHxy4QfHPhJ8v/fkwcQN8tia4kNhB6JwYbXVs=;
 b=VKjg5gZr6trkOr95RtEgatAmkPxbr2bLb7ReAutLYXNX1z/qeVVHwDrC4a7z+RFoe9
 DU9Bz1kuzzE0xaYguuXchO3L/L+XFaxp7tNv7qP0aYD2r70+veCgzFZ6drpN/fsihI6T
 dg+i5c9/UqX2h0bpUAueU8bCJkEpXHeN9meRJ3O3guRcaIOMCIDCze832gVTnQl87vvw
 eREDjKAEz6/eRj6W3bJNrZIc4FzRjENPQtenjVCmL7YRMr/2MrPofcAsV44SlsTGQnl3
 Q+6/4eL3ieLT8vWWaM5hJdnrAK5ivDVMS6vAJBB1tF3aE3cjjwEcSM7KDMf1zM7uUnGK
 yA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770089289; x=1770694089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kG+g41jHxy4QfHPhJ8v/fkwcQN8tia4kNhB6JwYbXVs=;
 b=GsBYYN3bgBSWb/EXwM92PRux3ouCz1F9SEeaBdwuvmAuSFNnefl6MZ5TSuwzMW5M8M
 E1z92dT57+NBvtLCrb3hTIL6yZPGVBNnreOg4zmd68svJwms9VFb0RxO8an3VDz/bkTt
 Z0Rzx2ftVclA34k9AAws0gLp7OFoj2H8zn/TlphjsuppspvfEKCQc08Pwzq2e1QHjZOd
 wY8EC5Fw8sJgmVO2qLafZ7wUK/TPROYl9OentGp7Vwsr9GDHsfCRH9t/9Cr8SuqHXKrU
 siy6/TihjIAwgz0MbxAXh57DyEiUGh9lA/PJ0TTE0EQQtKFOzhkaE1H0iUtQWGQKvUJM
 FPPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ6u2rbWu8f1TyEfTvj9S12fvSOPjfI1q5ZjEPnpti1sIlG6rJPs3sgGHcCrxI5kEi2AzHVaZUVxv1@nongnu.org
X-Gm-Message-State: AOJu0YwfpAtURC8UKxyuwe1Ypt77Wfd4BbP2bAw7jvajm5VGViHx6dNS
 PmQFQ2I5was+FOxpJWmfbRrbT+C0U3lDp3UyAt3hjGN30yXjr51RAM3cebrEqW3ifJY=
X-Gm-Gg: AZuq6aLOruzc14W9lKQBO6nhaTZNXarY/xMLAG4Vd/lTxp18/T/h8pYpQuIyDOr9IdZ
 OEsSc8DxsCR82OJbwev+kQ3zvqv/pk4+C4rWymcjal7D6un+Kpj/GF8/qVE1NLafijq37YByhkK
 8F9xMKy2b0iO6UTNqzFqghKQ2khsueMaqGLxBEfi3Wh/nNwMvivTrUtb0la51pIh3ae/UuT7iOS
 FzrzePf6cC/5fWJWm+wUZLGAFE6S6NqnWnai/vyBBI45AoDV3AllFHkGFz5QYZf3qs8myh9whR0
 dxbhZO1Kr+EbzdC/LMZ5npdOl/k5kwjE92mnBDmZCgB+uCQ3WoxzGbKgf8W/MWi6ut8TGC4r1CO
 VLXFVLc+Req3y8YU6vDiF/t2ZBoi10wPTt6UOX027mr+GULRR9zesJdjh2eC8l/JkYbzVo6+ZsQ
 fZ6MsWTj6A7CnoILNpiIymBNmVSMuGosG6naEqU6mNWFoh3Sf4bnLg7upjGQDvGtDrdX1dymBAV
 wa6DrZ4s76cyOWKzJuyCVPj77kb8g2LXYQTGmtCIw==
X-Received: by 2002:a17:902:f552:b0:298:5abe:4b1 with SMTP id
 d9443c01a7336-2a8d99469cbmr151102455ad.52.1770089289424; 
 Mon, 02 Feb 2026 19:28:09 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4163b5sm153423025ad.41.2026.02.02.19.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:28:09 -0800 (PST)
Message-ID: <c04ab010-f8a9-4157-987d-a27c0a1744c3@linaro.org>
Date: Tue, 3 Feb 2026 13:28:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] disas: Have disas_set_info() take a const CPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260202222412.24923-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

On 2/3/26 08:24, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (7):
>    target/arm: Have arm_feature() take a const @env argument
>    target/arm: Have cpu_isar_feature() use a const ARMCPU object
>    target/arm: Have is_64() take a const @env argument
>    target/arm: Have arm_sctlr_b() take a const @env argument
>    disas/riscv: Make rv_decode::cfg const
>    disas: Make disassemble_info::target_info field const
>    disas: Have disas_set_info() take a const CPUState

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

