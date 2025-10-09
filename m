Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CAFCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6y6z-0008Od-FJ; Thu, 09 Oct 2025 17:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6y6t-0008Mm-JZ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:23:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6y6r-00061E-FP
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:23:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-269af38418aso17820045ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760045016; x=1760649816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IOidL4uzr+VbN48SlOGg2P6JVFnfJml2ayX/o2NPQnA=;
 b=ynFsoiPLKD2ToPx1MhVW4x1JMsbIQRzzeBkVW/tJWY/npzmScF5tEfmVS2q24Q9ajj
 k3eFE6LD4Th5PvECD9U6Wy86lDM6+koP/TO9rkv3kcWhVmQ2vUNvsrKTNEMBHSZJNdPE
 q7J6ONxYs8TJKbxE4GS8SrgcNZgl2n4NFNZYtcBiKhNZ3uo+2V//EI2y7sCvzRVKKTLa
 NaJBvOkFvv1MRiBoT4frlIXv0h75EFy6lxACviwYeE7KKOQOYyBE19M33YIbQcnmT9JT
 ULAo5heOynr1vlEohmnU1vGCLsAFx9FSr3JZGU7OgIQOXC8Qdy/zfBP/8do11e10XoaF
 Savg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045016; x=1760649816;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOidL4uzr+VbN48SlOGg2P6JVFnfJml2ayX/o2NPQnA=;
 b=HfvXKZoDjnrKhLC9S0ISuWJCAIJfTq/gBfbby4HVDhv9YJZo6mkFuUVGBCFyLvu67X
 5yu0u4Apuq4O4q7bRUMU44zajnhlpQLkomAiRvoTXNtVh8GwcZ0VqMAVWOb6Zi71h0h5
 Ixq9mWzCK/dt2Cp+14ENeEEn+43yc5gpWVDrPv47eDjRKuibcBAZuGY895rIalkBGaar
 bVmTsHVBuJz/kKVphSewElZpkAv+umE6OkzEfhYBJGW1zKSo+m+R7F7yzLiqiVfnvilK
 Hyh05QpluUnO3KrZ64DIzKDQZDTdYx2FvjPqGeNuPLvLYiJMViyTB2CiYwtJ3E9kRDbJ
 YxRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXqI57PaAsG5sKzOGWstsIw7OUs3K3pENakdCvj5SgxOZMSF9QqAx3c2M1URQdXWnI8Nnsig8xIL9d@nongnu.org
X-Gm-Message-State: AOJu0YxlnxVC/EDWvOagrK44oo0966TWAvnAS2m6eW2IgSw1rmDhli7/
 Dcyq9RyvfgpE1LpqwmaCOPQyhhVmKg34rX0BELXWiafpvudjgF/G4fF+I4BVXifEIUE=
X-Gm-Gg: ASbGncstsvbiuWw4YJ1wY116Ngg4ZBvcCTRr1JuHPh9ajO9IMfqKyNO/cgcAr3vRNxp
 LNq2YXjG4ofGKvg6oG0PawssMFmac/sV2nWEjQJpN6Gf3L0ZdAqBi/NibUdHfwB8wYprOQVN3wL
 BV8UtTP73hCWwoRTeX7T3jkfTtMcBKCIz7SBgMWE1O2dV4adIbJSkKeFniKTkvxCdER6ez87rQP
 pn/1/Iuwp91EwtjsNdK6nay3YjMnfj0caxu+x1/51OHgvJlwmij/YuaqWzUJGMKhyLYebhVWFsO
 Lt9jI4XRcam4I3J31o67sVtPLIxr9lyW1VFmaTM274xNtayfnWIMSbm8sx8px1hPjnZKh8mMpxg
 zzUmgWKaK/aYenSOW50hHdKagOyX0NVOea600WHPquqwaxN/tN3lMx3oqrTb7OP0v
X-Google-Smtp-Source: AGHT+IFppvy+jZEpPC5NKKZzPOFPoRJM+XuKoJY/wb0SpMpY5vtQJIAarfgCsxyeiN2FlabzBQFZHQ==
X-Received: by 2002:a17:903:1b44:b0:258:f033:3ff9 with SMTP id
 d9443c01a7336-29027402c05mr95559025ad.48.1760045015725; 
 Thu, 09 Oct 2025 14:23:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de9febsm38088915ad.7.2025.10.09.14.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:23:35 -0700 (PDT)
Message-ID: <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
Date: Thu, 9 Oct 2025 14:23:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Andreas_H=C3=BCttel?= <andreas.huettel@ur.de>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/9/25 13:51, Gabriel Brookman wrote:
> For the fmpyadd instruction on the hppa architecture, there is a bit
> used to specify whether the instruction is operating on a 32 bit or 64
> bit floating point register. For most instructions, such a bit is 0 when
> operating on the smaller register and 1 when operating on the larger
> register. However, according to page 6-57 of the PA-RISC 1.1 Architecture
> and Instruction Set Reference Manual, 

Annoyingly, page 6-57 doesn't actually mention the interpretation of the f bit at all. 
However, I can see how the H specifier is processed in gas, and the confirmation of glibc 
fixes is nice.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

