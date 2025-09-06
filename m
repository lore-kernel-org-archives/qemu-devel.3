Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7A3CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumY6-0001Ax-BB; Sat, 06 Sep 2025 02:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumY3-0001Ag-2b
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumXw-000538-ER
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso14498295e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757140628; x=1757745428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MKlWTIYqN14qWoHJyyKRPPHzIA2Y/E/isjfIoO3maGQ=;
 b=N5urmqBtvaAvqVATzVwhkNibPnR76oo7EngyC03hlrlp0uYehQ4jRqOvdzQNxfzmmO
 dRfwBD8Igr634fqyWKSdnIi+bbtM7seD1/pAknXD/VFwoiFSiO5ep1q52xliR0WtT10m
 zCUC+hgYbYCIIwnjKoTM+2eLLL7HII9rGjIGZa2MmE1K19FlRVvY6/tPrTPy44eMPClQ
 wbMGWAmQzBbbn7U6G4cEELmPf99p25xNRN7kwtLwTKX9YYOrHMn7xA1lIt/3d4UJc/js
 ZhglBd3E+iicvhVLD3LQNdNs0AAREmvpIlDa8Ku3JrjO/9WGbhoPhnlBwN5oYJQf3df5
 T30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757140628; x=1757745428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKlWTIYqN14qWoHJyyKRPPHzIA2Y/E/isjfIoO3maGQ=;
 b=Kb0s8ghjq3oZiTpT2cfxsuFuT5ETdxHzve9AT3FyQkF1SHmCaaFYEt4/TxknVXzL6a
 O/nZ7DS5hHSodNIcEAodAvQU9wo6/fMnOzumGvgMmuae2RvMBaiW81w7BiwOQzsKYeHl
 iFud5Jd9MCRie1gAakVdno92k0dDgmMnviszIMrxh2dVFF9TIY4Ts72R8nCCBq4fmxTo
 DYN9WNy8hbFsLmAD3sUM2ipqTsdEH1QJ4y+B4WC7S62b0BjOI3seWjASyzOA9WNizrcv
 ZGrE/hAGcRI0U1KTZJTwvNRsgDzm+aAFKaI9zZP0e/Fd8kReoH0Cb0TJWBXmU1ubVhuS
 g2lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz+ao2VsMt0z4ghfVPsew5h+qhwHffozOc8IOc3JeLdMcxbfzsWGTFdoQX8Xjb5iHNR8mveLP3/2XV@nongnu.org
X-Gm-Message-State: AOJu0Yz8kzD65pmLmTnUW5JTIrBN6g3dS8S0C4eqU1UgIN1cwqN7ClGO
 GZ8VeN9duXQTXp9QrZ0isJ8Y0kcXbW5z0GDXKTrb1b68IPWcIdTgFfSOC5Vann7Tt6Y=
X-Gm-Gg: ASbGnctiLaPInIhxeb3LRji1GgdofwI8kNwFjfW5B1jQ+SZLi9c1L8QzwoJBhlubZDF
 5Mkodpz0IJ+rm8/mfbzk+996AzpGeUVFz3dA4NB5PdGLrud5vJ5FSP21G3/2s5GT8czBR6YC2Oi
 qfV4/jwT9dNmrDbtBi1GNMv+lf2yIx7+aRBCPIUi2MUMgh9FLYPAZHo9HBWkTRCOfkSi/IL98xj
 EdAzXotN7MNBSQzvY6P4wh4P2cfXW+VxGrrsn+D03DFkrBQAnTh1MewHSV0m4MhD74+nyUjvhrp
 NNy5mNgLK5FR/3zswss/nC9F1aGmNFqb1/yfPpEAUjV8iFvrS0YbP6tTaIG2RPXgzncqi6d0wfv
 lyY76pFbhYWBTP7aE9s+AYpDmdtlyT/cTQax3bTY=
X-Google-Smtp-Source: AGHT+IHjqu71AVjImfDQ6iZBJoWxJe9bImFeJzIq1eDE5jzn/WUUcJrnF4bxCEaeRmvvvfz92V7m8A==
X-Received: by 2002:a05:600c:1c8f:b0:45d:dbf4:888a with SMTP id
 5b1f17b1804b1-45ddded6249mr8904155e9.25.1757140627785; 
 Fri, 05 Sep 2025 23:37:07 -0700 (PDT)
Received: from [192.168.104.251] ([217.65.133.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd60b381csm61111985e9.17.2025.09.05.23.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:37:07 -0700 (PDT)
Message-ID: <e5dbc5db-4600-43b2-9ca6-37ff1d9ea8b1@linaro.org>
Date: Sat, 6 Sep 2025 08:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Improve tb_flush usage
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
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

On 2025-09-06 07:18, Richard Henderson wrote:
> It is too easy to mis-use tb_flush().  For instance, because of
> the cpu argument, some parts assumed that it needed to call the
> global flush function for every cpu.  It is easy to forget that
> the flush is not complete when the call returns: we have merely
> queued work to the cpu run loop.
>

That's a good idea, and will remove the confusion that sometimes the 
tb_flush is immediate, and sometimes queued to run asynchronously, 
depending on current context.

> (Phil, I suspect this second case is what's biting split-accel.)
> 
> So: remove tb_flush and expose only the core as tb_flush__exclusive,
> to be used only when we are already within an exclusive context.
> 
> In some cases (gdbstub, alpha, riscv, ppc spapr), we can eliminate
> the need for tb_flush completely.
> 
> Lightly tested so far, and I'm off on holiday next, but I thought
> this might help others working on split-accel in the meantime.
> 
> 
> r~
> 
> 
> Richard Henderson (11):
>    gdbstub: Remove tb_flush uses
>    accel/tcg: Split out tb_flush__exclusive
>    target/alpha: Simplify call_pal implementation
>    target/riscv: Record misa_ext in TCGTBCPUState.cs_base
>    accel/tcg: Move post-load tb_flush to vm_change_state hook
>    hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
>    linux-user: Use tb_flush_exclusive to start second thread
>    plugins: Use tb_flush__exclusive
>    accel/tcg: Introduce EXCP_TB_FLUSH
>    accel/tcg: Use EXCP_TB_FLUSH in tb_gen_code
>    accel/tcg: Remove tb_flush
> 
>   include/exec/cpu-common.h       |  1 +
>   include/exec/tb-flush.h         | 18 +++++++---------
>   target/alpha/helper.h           |  1 -
>   accel/tcg/tb-maint.c            | 38 +++++++--------------------------
>   accel/tcg/tcg-accel-ops-mttcg.c |  7 ++++++
>   accel/tcg/tcg-accel-ops-rr.c    |  9 ++++++--
>   accel/tcg/tcg-all.c             | 21 ++++++++++++++++++
>   accel/tcg/translate-all.c       |  5 +----
>   gdbstub/system.c                |  4 ----
>   gdbstub/user.c                  |  3 ---
>   hw/core/cpu-system.c            |  8 -------
>   hw/ppc/spapr_hcall.c            |  4 ++--
>   linux-user/mmap.c               |  4 ++--
>   linux-user/syscall.c            |  2 +-
>   plugins/core.c                  |  6 ++----
>   plugins/loader.c                |  2 +-
>   target/alpha/sys_helper.c       |  6 ------
>   target/alpha/translate.c        | 21 ++++++------------
>   target/riscv/csr.c              |  3 ---
>   target/riscv/tcg/tcg-cpu.c      |  3 ++-
>   20 files changed, 69 insertions(+), 97 deletions(-)
> 


