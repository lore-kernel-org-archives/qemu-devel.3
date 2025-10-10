Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD2CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ICH-00018d-AU; Fri, 10 Oct 2025 14:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ICF-00018N-SO
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:50:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ICD-00035w-Dp
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:50:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-279e2554b6fso17619635ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122224; x=1760727024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l+kjKu4GPuloUaDPmiEamzdmfRpDJp0oTJIDTOF+LGg=;
 b=zQELrfX0YyCWFUXShJkJUMHJ+PxZOyWXJq9PnKOY18wT3x//cRQ2QTXpQlJh0vLb5C
 w5IdeD/dAG6RJGWskX6BFmpKsQTW4hDDXOZHNcJgCbw7wp3YYfSzHSiH9PAOB2uuTBBE
 SZxzjAbshgVOTAh2CRk3R/oSXOkOGNkMTmqvAz9ltSaMtAAkG+v2/WHTuOXTkirMp2+H
 OjcCnLIG5+hp3mBzC3hL2oQuFg0cmdtgqHcyRsjQk5V3850lEcUaMd8cwz6EGAbT8TsX
 /HA/jD3OuBceW7/k8Yt8PiNMdyP0YxidD7mAC9FxSzLtP61J3CZMhhV/INzpxE1sgYDV
 T9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122224; x=1760727024;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+kjKu4GPuloUaDPmiEamzdmfRpDJp0oTJIDTOF+LGg=;
 b=GQaTLSYlcq7nhJSARC9tPvuuM412wbmi+v/YbX4dOWYzJHUma3D3gA/LK8gXWuNPqp
 EIS4Ak1qVNVDxc7xbyGLGqtdqZTqlR2o110d0c3j44tnw0LqhdL5J5ljfKWup47wd76O
 hOQ1Hyu/qVWNLx42VN9taSr/Gr4SrlPbhMo4c+j0DavZKcpYlNj5FX8uD6L0GNj1m1Eu
 pjBUxxIEugxAa7RhsUBN8rt1n1TOYm/B9JEWsZ3JSVkDI4YCcNqaAhtfH6ILnClJkq7J
 ACvA51osHOTkpJN7x9Rur+FBUttiWAEaESdIbDx6eWlg3QB953+azno410umZlb9CAmC
 au3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAW2gyW/Fb2g430vRKdaY0E1KD7ixzu6tD6BGN1mrClSFJmNl9y8kKQZOg51Cq8pwC+TY6iYxqCkmD@nongnu.org
X-Gm-Message-State: AOJu0YwtKyvSq/iM8aTCOmRcwlUIXlQ/1NUmps/Nzjm1H+Th50Alm9W2
 PW93hbCzDdE9Vgf5Oxn4GmSXR/N5U064QCr6HKPYRNi09oMlzGSVsajGiKsPr6JSx60=
X-Gm-Gg: ASbGnctBC2MHD+ahzKo0dO/yWBo9zkwndoxkyQoq1YaoiCSnzSrC2HWUkniVpbBKppA
 vC6tI9Lrx+p/HvAwIKVdVT1LKlSxKg9i8TyWzXft8BzT98noDJ/YE3E0JrbqsGLw3RqpcNgWzbm
 Y5SuHsgmXo8zoE0ARfixBXAxNDdvsuD/ILfOn4GwEu0Kt0WIdsjyeww3kOes4j+wEW9MSy9Y3Ex
 SGmgEo6KLlulargsBOVHJ1l22e6FMdoMNy8cqq5VK4QF3YJ3PF9ACZaCgOyMD9NyyF4ICMjcUxt
 Ob7Ce+uN7tdQAA0XmA+UFMGAuc9kYn8xBU9ctlkVgSEsq+2k1KyGqPUowJR7sJofNoQuis1j+cU
 C/s7t9cak4M0vhudv0NLEVQzNUE6NofXePLkL7lPBhqyl8vDJKGb0e1MEs0BVIOagJX2uRQ==
X-Google-Smtp-Source: AGHT+IGChs7Ty3fbkeargNCIik96m2ic/d+PRhEKmYkKljhXaygTZw27u+7JWd089YdFEJ/q9ha5TQ==
X-Received: by 2002:a17:902:eb8d:b0:264:5c06:4d7b with SMTP id
 d9443c01a7336-290273ed800mr138891135ad.32.1760122223906; 
 Fri, 10 Oct 2025 11:50:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e47341sm63633345ad.57.2025.10.10.11.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:50:23 -0700 (PDT)
Message-ID: <457485d7-b300-470e-9101-61fd57d44ceb@linaro.org>
Date: Fri, 10 Oct 2025 11:49:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] target/riscv: Conceal MO_TE within gen_fload_idx()
 / gen_fstore_idx()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-8-philmd@linaro.org>
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> All callers of gen_fload_idx() / gen_fstore_idx() set the MO_TE flag.
> Set it once in the callees.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_xthead.c.inc | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

