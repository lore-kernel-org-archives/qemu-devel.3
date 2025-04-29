Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDE5C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9m28-0000qL-JE; Tue, 29 Apr 2025 10:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9m1t-0000aC-S2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:33:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9m1n-0003eM-Jz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:33:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225df540edcso71066685ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745937221; x=1746542021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lCvd/jEvoH4uS8fiQaq7q1KoXJTfiBIxoFTatV/aPGA=;
 b=md/3MkBgXjivZIA/lIkZmZB2YlgAumDBGgqcwAqWMgJ23xVlAVII8Ze+kD0dQitgzo
 lQDg+T90IPZiy9Eud+p+zhrnlBTLj87e9gayvwfoBcpT51maLgmV5jCWDHBJ2ilu8DEU
 /JXO+ckvUMi+GDKUzS5kqBAD989UTUV+tO8tT1LBZXiO6Fp3iDUIb4HeAMkFY+jH2UZI
 61YJ7lYNR56PQY7n8sJJLviG46do+FXv/myCFoW1KSODILtLKVkatT1byl/oXvJIM9aO
 UbyShyZgF3fwrGI11RDoLJfQGMpSb9bZUIfXU3WnUgiDSbLQ6rQjFeMHwWH6GAhk1aiK
 Iaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745937221; x=1746542021;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lCvd/jEvoH4uS8fiQaq7q1KoXJTfiBIxoFTatV/aPGA=;
 b=hIsHayhvNiePmgA843QC51Rzjups68eRtiDKOuKZhI9heY2Zi59NjSMUv+mWCG3tjB
 /ZguA2EQ1vq+8BKSWLeENbIDCEDxKWMTusscsMoCJyo85Ey6z9yUy8JxYNuBbaGvlWEq
 Du+kUtTmtxDGVOn8h9OBWEQaLKGqDFtULSVZWHg3gIKFnjh4BWoJd7LOzsoh521gQC2f
 lkK1l/MDBvy5R1PaiJawOoexItZZ9zqYwH2go+56REl/j+4/7WUlCXlA/UfDATNJrWFo
 ACsTTegkpB6PJbQpcC4VyhnFD0h926YQ2ZT9cJM5/OOY9OeFV56HMHaQ0pDV86x4taLm
 wwMQ==
X-Gm-Message-State: AOJu0YxJ9kFa9JO9Ymjdp6LCRrQVnERRC78FV+UNNZE47ZPq6Nnl+KkD
 RfoASE4MfL/khxp1vl8ZukmbHn+IJ7+s5wo4kx68dWmFB/HQOTHCphGLW9aRrDokP44y0N9xxtA
 1
X-Gm-Gg: ASbGncsjhq28gRl/E5PVunxIah8U27BFkO7o6dncCSh7G3voai49S3d3ODzKSLO0imL
 lRMRWUcBo/GIYzqo7TpAv3SV3Ctqw2Bu81KdyhWT/s48BAA7yZ+aZth7++obMFAxuYbTCWcMWb4
 occDHBrHJfUlU8d0/cCFfoxiaz+eOEhGBtF4p2Ma+HOaGxkhAFuKUsCw4PrZ2WeXKtfCkAoGfuu
 G/ea2pwRay94J32WXoYiSizzR1M4fjHQb22DcSuJizUAy/wqrgFi60Mmbj2joTVaNUW/99grBdQ
 e/bVzvxrE3l7BTEPl7POQVxJkdinCwR5vL7Pakx9ekoRMjilHOH4bbvcDbtXQySDoy6MsU+zimG
 DHeDVMYw=
X-Google-Smtp-Source: AGHT+IEx49tIljXSY/B7J5gw1YeaezdqeGO9k44bFknnMMilR55hKzD+EYhBLaNLCYuHaAKyjjblJQ==
X-Received: by 2002:a17:902:e551:b0:21f:40de:ae4e with SMTP id
 d9443c01a7336-22de6bff5b3mr43769385ad.9.1745937221103; 
 Tue, 29 Apr 2025 07:33:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe375sm102905495ad.96.2025.04.29.07.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 07:33:40 -0700 (PDT)
Message-ID: <5b298186-50c8-4473-8eaf-d0bc6f6793ce@linaro.org>
Date: Tue, 29 Apr 2025 07:33:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, Alistair Francis <Alistair.Francis@wdc.com>
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-8-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250425152311.804338-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/25/25 08:23, Richard Henderson wrote:
> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> +    /* Suppress 'C' if next instruction is not aligned. */
> +    if ((val & RVC) && (get_next_pc(env, ra) & ~3) != 0) {

Bah.  I preserved a second bug here: not "& ~3" but "& 3".


r~

