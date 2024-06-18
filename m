Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB57C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJckc-0005y8-5L; Tue, 18 Jun 2024 13:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJckb-0005xh-9b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:36:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJckU-0006CH-Qg
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 13:36:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f717ee193fso42096395ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718732160; x=1719336960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aXWGOlT+LmbMt90QtbOJosjsfmdZv418psn78Wt1Dl0=;
 b=e6lyMjJ4A81DTJh0hswH+v+QoCZwA7ymTcuZTwk+Jjsj8VIU5S8QF2ATV54aUMnN1G
 8qNsuOWUgQtHDHUfOPXSq1enwJrT17QnqV53k1gKLAbM95+PFp9Qh7mI8j/6uS/x5ULL
 PRA4bIwTkOdU9+cV9wbJPXvcm53h+20ABDFjlS/s2obVN5kA/jXDfqYZnDz04zau0fF3
 2MxGen6CpsXKPQVrL+DzMZjOUw9QY+l2tCCas6Av2VsLg75vc0IEBk6q2bh4jeoURIZL
 zdtsS8bISeQAf3RKvffGOsUoPRF3rKRDsDBbNfkiXT5gemAx49mDbp/+XTRMX1MMXKKD
 bpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718732160; x=1719336960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXWGOlT+LmbMt90QtbOJosjsfmdZv418psn78Wt1Dl0=;
 b=jAcn4PJvBNUkmXZ9MhAzyMNdXi0C8CQd+59s/SENZdKXQUYDVdozCrFy++JjTyH4a+
 vgFzy9/UKLPxOIgyJUHraOUu8WFluGZzPTDDGYr35/9O4mcVRk4p/g1pKe8GPjOzoeTP
 s1k39zhyAQnHnF9IP486qnIAJC1PWGBKhvfOY6FyJsHY6MR/GSuWjBYChDLWEM2KZjyZ
 QGvNs79p+2GYEON8Om1CMGLDJco9/kj9MDYgsRYhS4vm+Kxy7woXU9bOkv6ZlmEwVXos
 cwHyTGJzo4trbdzNSZY+fbkMYN+ovTNbw7EYCv2uZJiCIuXJ/4uPW32mA3bHl5B7k4T4
 hyJw==
X-Gm-Message-State: AOJu0YyxJvY1QSoW93E+WKsw7FrjIcP5UX+kg12i2G4jDYR52oZwFpcd
 XP3R+dEmBLA/gfpVWTrSNmR/7zt5TjG/zMqmYzex482ZWoxBFrtH66XoLZ+WYZ4=
X-Google-Smtp-Source: AGHT+IG6IConKh2wFkYVelWUcG0WryrWN38t+UGCGeOuxeRmR4kdTD8BZfMyE4DzXNLWSqeNr7rrwA==
X-Received: by 2002:a17:902:ce91:b0:1f7:174d:3309 with SMTP id
 d9443c01a7336-1f9aa3f8232mr4158425ad.30.1718732160390; 
 Tue, 18 Jun 2024 10:36:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee80f2sm100624835ad.175.2024.06.18.10.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 10:36:00 -0700 (PDT)
Message-ID: <ef020a10-4ba6-487d-b01a-5da2e6b0d437@linaro.org>
Date: Tue, 18 Jun 2024 10:35:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240618085831.546883-1-rathc@linux.ibm.com>
 <20240618085831.546883-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618085831.546883-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/18/24 01:58, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 
>          {l, st}xvl(l)           : X-form
> 
> The changes were verified by validating that the tcg-ops generated by those
> instructions remain the same, which were captured using the '-d in_asm,op' flag.
> 
> Also added a new function do_ea_calc_ra to calculate the effective address :
> EA <- (RA == 0) ? 0 : GPR[RA], which is now used by the above-said insns,
> and shall be used later by (p){lx, stx}vp insns.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                 |  8 +--
>   target/ppc/insn32.decode            |  6 ++
>   target/ppc/mem_helper.c             |  8 +--
>   target/ppc/translate.c              | 15 +++++
>   target/ppc/translate/vsx-impl.c.inc | 94 ++++++++++++++++++++---------
>   target/ppc/translate/vsx-ops.c.inc  |  8 ---
>   6 files changed, 94 insertions(+), 45 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

