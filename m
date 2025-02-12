Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF1BC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHC8-0003Vf-Rb; Wed, 12 Feb 2025 13:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHBz-0003U7-NV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:10:38 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHBy-00034l-5y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:10:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so122141715ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383832; x=1739988632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k0VVHu5aShEwTUjLkwOYrYt5Do1lMU4rUfvZMeCpUlg=;
 b=JQPxxLqUsYStCsuKK45DN2HkOKfq0jH0wkmuc8+DDbkLsDYw1D4Nhg2sA+ZNqpg4qz
 J04Caq+jG+jIYB/TolAeXU9HoZKUlSmW+6GyUyY5yOhGCxBl6hsG5Slaat02N1AYjDsk
 3pcSIpb0jTCJ8wRdlaYbupIPWgcb3X6qhm/S60b+Lp5QKIxenrnONtcvIEtABlxGho2T
 o3xxVdDwWmtIVbRyWZcCoTFK9ilnGp1N1dQpXE/eQTgVWqdsDCAxNC0LfdtUct74P8m6
 yct7ErPhC4LUdEjU7pO42h4rQ5Q8XLBFbDXZLa7E3IqkXiBxfwREloY4degejlZP5dMv
 he8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383832; x=1739988632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0VVHu5aShEwTUjLkwOYrYt5Do1lMU4rUfvZMeCpUlg=;
 b=EUF5uCjnUOA8vvO3C/dYt4ouzqcAqCXIqLHDQqd3tTQbqe5t4N3dto2PgVzlvyLWUU
 qVuQz6AZDsqfHZqzdZ40rV+MqX5UQ+FOJlStqx6FXjeI6Mvx6jGKPVQD8CVGg5X6akdU
 3V/ByuDSD+bXarv3MstGBC2oj+vNfPn78TdCnjttimnvV9xq0cNuxWJGbEnyGZrESHyw
 sK0LAkXD2JStKWuVDn+2p47AqT77ePy9eNEjebJ5SI+7nexVgl5NmJUn2U367L2wR5vL
 MfICUPOJgNj5MCYeYBJhSxYd80VycNjtUNCgHLKjpXJyZcLOUUf/1VjkwOOZOvMrQgUz
 Hn9w==
X-Gm-Message-State: AOJu0YypAQeU+QaZK4TypGaHc+AN1TMvqRaRGrG0kziLrk5gpybY76d5
 fDgoreuMLvdcZA2eW5nfh1CFVE1P+wFeTo1WFiGcJVvcU4F4gNiIB1X8OfymuQ77KxpTE96b8qQ
 2
X-Gm-Gg: ASbGncvBzeA/hgiRyPBOrAOMgk84VI53ikVDs3Itr9lzv7j7/VFaJPWiwQ9vp2RksGT
 r9J4W2wDCNnc1hLGmKv+xc4CidhfJ1hlJO2aJ+KCgeZrIYgM/rmtfQeUnibmhKaJvoQX2q0iwWM
 EAnSpSpd7y5dG6G91HL61pH4t4OU0iGLvqWB3FmjG8AXVyaRHMBNhPXdGuLAZtrbu2Y3+LYSlKL
 NH00R7sfs6vGniARJbCWkMbRq4ccxXfamypcAn0rVPWAZ56m7cdJ3+T0vndEmP94jPii2dAFh1O
 JRSPWmamNSuqO7apL8Ry7pTtIpNuGMWPYMjiLUeokVZzXYS0+eC0VME=
X-Google-Smtp-Source: AGHT+IFypYCdvDGTMfqQgmsR6dur6gOdwmwX3sJPv91hpuVzfBUt0B0iVZlYHtFpydVGHOeB50rGdw==
X-Received: by 2002:a05:6a20:d807:b0:1e0:d89e:f5cc with SMTP id
 adf61e73a8af0-1ee5c7450d2mr7435753637.11.1739383832559; 
 Wed, 12 Feb 2025 10:10:32 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad54bca7d0csm6300069a12.58.2025.02.12.10.10.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:10:32 -0800 (PST)
Message-ID: <932bd6db-0b65-4a24-9095-1fde1b7f673a@linaro.org>
Date: Wed, 12 Feb 2025 10:10:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/arm/xilinx_zynq: Specify explicitly the GIC has
 64 external IRQs
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> Looking at the Zynq 7000 SoC Technical Reference Manual (UG585 v1.14)
> on Appendix A: Register Details, the mpcore Interrupt Controller Type
> Register (ICDICTR) has the IT_Lines_Number field read-only with value
> 0x2, described as:
> 
>    IT_Lines_Number
> 
>            b00010 = the distributor provides 96 interrupts,
>                     64 external interrupt lines.
> 
> Add a GIC_EXT_IRQS definition (with a comment) to make the number of
> GIC external IRQs explicit.
> 
> Except explicitly setting a property value to its same implicit
> value, there is no logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/xilinx_zynq.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

