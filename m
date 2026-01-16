Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0854D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaPA-00042C-Vy; Thu, 15 Jan 2026 22:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaP9-000417-DM
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:21:43 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaP7-0008WQ-PJ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:21:43 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c565b888dso1328739a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768533700; x=1769138500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FawDodVNhNoZFk+kq4IwSFWSPLKH5pMRCL6PFrKSZHk=;
 b=o4c4Cs0WkWTg+IhgBmDQO1ZogiauEtEl0vOdMcBmZak98ciScuhZ2NYZaS7/JKbr1B
 +iFIGhvQwGviHwudw4DAFI2XLXQOo7uoKa1ggPIS+rXtaMN5IL9yteeVzAKcxHVhlUPL
 Y6LGrKnPUe7tvFGHqUPfpclxr3HWq0H7Jv/tp83xN1RtIXqOu/TCELGtKQcsC5bsWAcw
 BTSj5nHy2CpjE5Elja1NzRXGkzNA5gILAzIoyQ4gXsIBCYAkOE/4A5UsdvGFApj+FT/+
 UlrAOEq0iHU7Dtjm0eGXWtsKkpnZEP5WX/26Q/SzR6urbuhG+vaoWVO/ARzX0ih8FA+V
 5bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768533700; x=1769138500;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FawDodVNhNoZFk+kq4IwSFWSPLKH5pMRCL6PFrKSZHk=;
 b=L9RaMJbTGCo+kf2xH//Nb283ELFE8J+5yuteN6JHsACQjHZdMgcjSPOSAgV6HeJCNO
 lGvsfHs3CEAEBWkYzdw2XXh9XlqUNrG+oQ1PFCiK+HAoXG8R+n4nXB60WGE7b4dIl7IO
 shvdlKA0+vOtcrwuAmNjZKV03d4te3eh2A+X4V0kgwbrmGgnraGQpRO7TIVzw75QKOEy
 ZFQL2UXm4wy5VlI3IdQ759Xqgw4+4IlI2GJ1WWE8VzGYRSd1x9UIyJotbNtbnVksmkr5
 LibD2hhTAqLO335vzSC5VKx/UihkvnoBLQkAJP0qbkQkC+eWSPkXPPvsLkLD4RegE8Ud
 VDhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0oXAMT2REZyz32a+YVSufV955L21XlP8Vmpf0nFJ6g30y+FgFvf1Miq/O7BRVA6HTSD3IotKoKoQ@nongnu.org
X-Gm-Message-State: AOJu0Yy8Pmw81oeGyRnPYwXe4PMcGdIWFp6ylQymsPJ/0VvMMnzBiLnn
 3aKw/g1ItBPhJvgysZDC7M0yGxr5P+k4cmuKshxCiU/qlSkwL73jIqF8aO43YCGXCGU=
X-Gm-Gg: AY/fxX4bZ5WoxZNTgr6Gv+kaoavH0Ct3QqFHSM6zEp/t0Gh+d/wWbDOpVSeWFRk/xIf
 cS/p6OxvmiR3ky6PoAwEqTkJz9mUHsdd/Usf6jxjXCfprmxerVGkGYR73NROb8ath123x0FECp9
 1UlltCjjDvnLWT63onPlpozZk8Mv3bvnezKZNRxVEhb/XnF4oqU4zVPPpBZ8fdHm388vlir/PTZ
 W4j4T00rzi8AKTT5ts0zeBjbQG5lVaGLQd7oliVCL4/8usLPG0oyHwGRXHeNr25V0blEc6ziv2H
 /BHHqkNIyDpimMNRu16rqji7HdriqKpUnuKS74ppPmgcT4qAH76zfKcQkElBLnxuDjrWkOCVQx+
 mVDV3ujBoebdY+uRsx5Z6Pj0wmoqkbeF2D0/ZatSVfCHsVRIZNcpznnW55mmB4256hFYDUHSFAx
 mUuSIgzpKC5SOwqfM/zsuo4/N2Xbixow==
X-Received: by 2002:a17:90b:2f45:b0:340:d578:f299 with SMTP id
 98e67ed59e1d1-35272edb009mr1254860a91.3.1768533700214; 
 Thu, 15 Jan 2026 19:21:40 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352677ca9acsm3209972a91.1.2026.01.15.19.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 19:21:39 -0800 (PST)
Message-ID: <067c7e1c-0149-42af-9432-abc9e6fe0735@linaro.org>
Date: Fri, 16 Jan 2026 14:21:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260115185508.786428-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
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

On 1/16/26 05:54, Peter Maydell wrote:
> Hi; here's the first pullreq for arm for 2026. I had a big backlog
> of code review after the holidays so this is mostly "things that
> were fairly easy to review and collect up"...
> 
> -- PMM
> 
> The following changes since commit 4cfa1ce0365f56832f46ed8a82d8bd954d16be11:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-01-15 11:29:21 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260115
> 
> for you to fetch changes up to 4efed64ffcdb99b977ad0b2129a9c0208456a6c9:
> 
>    target/arm: Rename access_aa64_tid5() to access_tid5() (2026-01-15 15:30:16 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/arm/raspi: remove duplicate include
>   * target/arm: Enable FEAT_ASID2 emulation
>   * hw/char/cmsdk-apb-uart.c: log guest_errors for r/w to disabled uart
>   * hw/arm: Re-enable the MAX78000FTHR machine in qemu-system-arm/aarch64
>   * target/arm/ptw: make granule_protection_check usable without a cpu
>   * hw/arm/omap: Remove omap_badwidth_* functions
>   * hw/arm/smmu: add memory regions as property for an SMMU instance
>   * docs/system/generic-loader: clarify
>   * tests/functional: migrate aspeed_rainier image
>   * target/arm: Correctly handle HCR.TID1 and TID3 traps on v7A CPUs

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

