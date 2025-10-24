Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD3FCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCFI4-0001i9-WC; Fri, 24 Oct 2025 06:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCFI3-0001i0-Bn
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:44:59 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCFHz-0006ab-Pe
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:44:58 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c3d913b3bso3341162a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761302688; x=1761907488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VbykXfu5ReLykfFpsQ8/0goS2fZ05aatviuLWRiZqkw=;
 b=HIoHqFNe4o3XJ6rk78SDIE74rre3leWcu83I34se356kNCvVKZAAEEVFdZnAP5NyZ4
 4n/A1GfsQrHRSBDxD46oKsYkLUeGfk5tglI5YC9NUmDh6H1Wntl2/KCMKkqa4HNJ4nko
 ew6Cd8TFE7cmnnr1bu9iGDyIeGQVRlZw++UsNDbZ7niTiXqeXVnQvPIIDMUO/m2f6SxF
 LdlOW5KuTIgBaHNGT5YX/63+5I8vQ/jGouu1Yivxe0iqAZhzupK9vST30Fgmt877xcSz
 f0ehhFI7I0Zq+g3kEul7LiT+S1FCMEBGLqcQdzn5SUSw5FYSzSgT5YVs7ZaIyoLXMgkQ
 4F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761302688; x=1761907488;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VbykXfu5ReLykfFpsQ8/0goS2fZ05aatviuLWRiZqkw=;
 b=jeU2HvFWjN58yUmM84MwHQ5eJgToBng5TvOsyKf51H77kYvKyr4T05Ze6soxJviXEB
 d7XWuOT+aM0Uhqb6OCmNN5qh5b61kR1RlKuBLGz/+j+Edx6VJrDh7jo0gFGODoOx/7BF
 Xi9IT9/rKBpvajVFBpIfwlvNUqeFuUoVXH2G0iF/F69Y62kKz8R1wlJUFd5IKfgPlOk2
 PqACNeRDiszbC9+m/BxsRaNbWiIMZ6QUwHdGcYO1EOijd6quOJdYdBaiXaAeigEjk5ey
 qDVaQrM0ERetSOd8Tp+kevrPiNZkcDPZOmTq65JGJCC4YSSwobKG0Snumhcm4e9RfsuX
 NcTg==
X-Gm-Message-State: AOJu0YyznDGtPUVs7yFbzhb22N5SZ4uC/4AKRx0+3Jyfcs8cI50vGzks
 nCiB2bDb9/qGB0Y+g7AAC99dsfx0sAjjk4jiyMznUrPTGhYL7fGXip71eUJYYb2ThhVwGNbMnL8
 96Fc7PUE=
X-Gm-Gg: ASbGnct8SYbXo+zQIEr8bKPsBDHApU4VQeK2m7NFDnN4OxMRN2HyJuc1xRkfduwnYqE
 bXODXcJE4Dfd5KY+gK3Ka/TU3ZuAMFNlpeDRiZG/+2QzWCX3VOOigcaqNDjzooAIcWjEATpj91t
 xdaLV5nWSXNJfNalJYMalHaTXoxgLJA3NjKN3VxkosScapzRHEcj7acVX1jN0Jn7duk/Cq18tRm
 FAqM2gnBqlBnH60tJJZtNxUj/v0yGTXLJSJHmj5rWuGEssyprkJD+iOSAK+JoQVzlTiwMjbkHJ4
 gJlao9l7cp/U0zPZSYalTQdlIn+fe9sb3pYtUKO1t66/c1+bdZOxEsI0pUVfxY/HljZx4AbliW+
 0rmhdOXcgglZlLoQyFJChLBVxFb97a9ydA7JrR5h+cD+bnGaDMzT+fDoikLrkQQmTkmpniMy4iD
 43/HLIXQaghGAz5NMxmBpDY1tpRy8LF+sJ4xtzs6vnE7STgLGEhkQ6Z4jgUgb6MvP0
X-Google-Smtp-Source: AGHT+IExyk3fY9IfUx0oxxK/3ROGjS/stXwSRQwla4xo//YiCkyPHfoIZMw5eeywcHzvCd7kF+ry6Q==
X-Received: by 2002:a05:6402:2554:b0:63e:2d46:cc5d with SMTP id
 4fb4d7f45d1cf-63e3dff1673mr5431174a12.7.1761302687785; 
 Fri, 24 Oct 2025 03:44:47 -0700 (PDT)
Received: from [10.120.116.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3eddc3c2sm4005010a12.17.2025.10.24.03.44.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:44:47 -0700 (PDT)
Message-ID: <5365da00-402a-4ebb-a011-4671cf260e01@linaro.org>
Date: Fri, 24 Oct 2025 12:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/25] riscv-to-apply queue
To: qemu-devel@nongnu.org
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

On 10/24/25 01:49, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit 88b1716a407459c8189473e4667653cb8e4c3df7:
> 
>    Merge tag 'pull-target-arm-20251023' ofhttps://gitlab.com/pm215/qemu into staging (2025-10-23 13:17:27 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20251024
> 
> for you to fetch changes up to eccf20c02a5ad913a910444dc6bbe5de0952d254:
> 
>    target/riscv: Make PMP CSRs conform to WARL constraints (2025-10-24 09:24:08 +1000)
> 
> ----------------------------------------------------------------
> Second RISC-V PR for 10.2
> 
> * Correct mmu-type property of sifive_u harts in device tree
> * Centralize MO_TE uses in a pair of helpers
> * Fix Ethernet interface support for microchip-icicle-kit
> * Fix mask for smsiaddrcfgh
> * Fix env->priv setting in reset_regs_csr()
> * Coverity-related fixes
> * Fix riscv_cpu_sirq_pending() mask
> * Fix a uninitialized variable warning
> * Make PMP granularity configurable


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

