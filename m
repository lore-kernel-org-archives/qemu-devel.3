Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC83109E52B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5bKR-0000r9-83; Wed, 25 Mar 2026 23:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5bKM-0000qZ-BP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:24:11 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5bKK-0007wU-Qo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:24:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-359fea895b5so394023a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 20:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774495447; x=1775100247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uTEt/a5eMiXktrPcS1L/JSSs1tC1//0c+yqvGQDucRc=;
 b=MmUB2rtH178HsisbO2La0tTMWBATUynzOnF+VvD+Y7g/hb5a8tdAgBiwWKC89c14h3
 1pHw3xf2fwrX7VlkKPtLUTJrH9C5F2EniVYYjtlO9NcY/DHRxsnBgABL1IjyzsEQNNkY
 YifgBuGYkxLzONF36+QCizgBeC276HVzzBpId9wiFQbXklR6iGzbif+BfOC675Y5MwX4
 ejOR/tB422J6/PWkhwVOw477DnjcFNxAuKWhoTHmcLB3PC3CzwpL0UUKirij19E39IrP
 jgfcDL/GfnuYGEzf8275Ixn5w3A23HtnOnhi6AI4j2pPetmPYOifEURHIgXUX9DFcqAj
 4tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774495447; x=1775100247;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTEt/a5eMiXktrPcS1L/JSSs1tC1//0c+yqvGQDucRc=;
 b=hB7wcpY1uShDuhoc7wFTAMISVXLPzdpdgECTEI24ewmVronNgdTGm9OQAwpTuB5qEZ
 70OFdOrDphzrz+S8YfH41nu77U4qe4gUW2859WyohDav1xeLa8BotJlWjSqBEHO1HcOY
 WQXCasSTZyMFyPzRTLSDUCWBOPd4jjch36rp3r4nyxvlTqyuhu2Xk7tOF/qC6swD9Acl
 RSk4y1In63ynM7szS1c1ZoxVQR+ISDwm6AAxjS5fHZVYMrVGLR3A9jxH/bBaOP0tHpYr
 yrNkOJWk+L34CftWawqb7zske51ZfGPyZgp+KBygGtSy2ZRi1REhycyKfJTmyK15mmlI
 w5YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/EBaluaGIkl+KejlHKwBACv9EtdjOyx61ck+pNztcjI0IdRmmJTITQP0JLe76K9OmLASkzVR69ZnW@nongnu.org
X-Gm-Message-State: AOJu0Yzu9fu/+OA4MwOt0GjXQgr/UercYzE++2tsMGNFAHG47JLVxPyp
 uma+eYajUZ8PmjFc7HOdR5ldQamhHhLeIh5GTTVbwBVA1Zo8N24IPTJ115QVaAjvrw0=
X-Gm-Gg: ATEYQzy631GeCPG+i2y3Snp/ptaDk2UC/V0MYO4rrlzCWBmw1aBMNW5EVgPOef58iOn
 OjOTb6y4H7/upwsTqFIXab5BuNyqJ2gtCjsKeKng8Cs69PRAaxkrMgtfhIKOA/hAOeNOllSafJc
 MBTH9g7vimL2FGFKX4kC+9LbhLRXDhcvVga6CgkJtw4IC35l9+dfB+VUw2KHehK9pnDkowDLNWQ
 SN9gexGegg4NTBFq4/+iXt5d6OkESYbRQY/8wNN3ao8hFMlyxzjnjCFEppAWqOeLK+JSwuV1OeD
 HTB5SNNTSg7uHEUAHJgrLBH0Mf0y6pqakqM2Q9VY59RZ008Q9oJlQ0JhWBIAddu9KP/GSEvGz/2
 7nwm5oI9MUHmCV4bw/gP3gvihR6sn43JvAzkjzen4AkL3VdFzv/gJpO5H36b9XXMW2KC/A8GEp9
 IsjNHo/g1y6/3fcf4+45l9bc8Xd20Wxvpcy9KONFRygg==
X-Received: by 2002:a17:90b:1dcd:b0:35b:a656:a60a with SMTP id
 98e67ed59e1d1-35c0dcf48dbmr5536207a91.8.1774495446952; 
 Wed, 25 Mar 2026 20:24:06 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0312ee89sm9177425a91.1.2026.03.25.20.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 20:24:06 -0700 (PDT)
Message-ID: <23a0d240-6f77-4edb-8128-fd2c2b8354df@linaro.org>
Date: Thu, 26 Mar 2026 13:23:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] target/riscv: Support runtime endianness in virtio
 via sysemu callback
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
 <20260320150552.169480-8-djordje.todorovic@htecgroup.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320150552.169480-8-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 3/21/26 01:06, Djordje Todorovic wrote:
> Implement the .virtio_is_big_endian SysemuCPUOps callback for RISC-V.
> This makes cpu_virtio_is_big_endian() return the correct endianness
> based on the hart's MSTATUS MBE/SBE/UBE bits, which is used by
> virtio_current_cpu_endian() during guest-initiated device resets.
> 
> For bi-endian RISC-V targets, this ensures legacy virtio devices
> correctly detect the guest's runtime data endianness, matching
> how ARM handles its bi-endian support.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

This is only for legacy virtio.
RISC-V does not have legacy big-endian, therefore this should not exist.


r~

