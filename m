Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C238CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Wqi-0007rF-8k; Wed, 24 Sep 2025 17:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Wqd-0007ne-Ot
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:16:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1WqR-0003UW-3O
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:16:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27c369f898fso3305635ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758748560; x=1759353360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oH+YNmOWZkslbXNyK2Onh80mtOwdyiTI+eKDqT+9yrY=;
 b=RB5LD6oLtLRfSqBIvc3TmlQV2lF22sJUvLEPW95W8UnENaW6RxO+BL2fpiJC+9Tx2z
 YCQ+F94gmWlOuYCRuGEHQIkG73Mf/KCnIx3C/bSyT0/xHB5SOUWZ1D/1xu5Iko0l5g+w
 aOwiMyc/8TFYu6FpP0etiU61digEdO+gYXoSIBXG5woZSwFAakXeLJCDEUcHY6AEM5UI
 nEt+eVpvNv8GVUExaY5k5grP0klqzWAcWa+m3NJK6FGuuDv1piHIC2OhCaBoLZwvTBSX
 d+XLQIngRvNwB74pKswBH9hmS0JXQ9kQZgH/+FEwjMYWQHxGo2qA7Ca170sO29R32gNh
 K5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758748560; x=1759353360;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oH+YNmOWZkslbXNyK2Onh80mtOwdyiTI+eKDqT+9yrY=;
 b=WND+E9pVV//IrvjCvsg8b6TPPQxSo6cuXkJxq6I880J+Ft4GTybIGe/4V+nwoshH/R
 vh089QQPDQ28A5NxC964Ptm7oda/f8AXQkwug7wZb8EXBJ0C1PNFfrlkVPJCiIR2TbCd
 zbOE+ve8GAybWawtOEf3Jj6c3OahFLktrdz+qOQxEftz2/OttMNjTJuZTuo/CmZ378+G
 kPo7gaqJLudny/s1fRD864UF14mTef5ax5i5Zo19dDx15kL/5blye0IlRvBmkgd8/Y0E
 wqVttYk4Sltm4clZzvJPbwVZvbzUrm2ykdsr1+nEWOUyCflQ6DYpByLs22UkF/Dn/rbc
 Kgow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKOEGUalsHD6N+EP84C+YQ4ZUQf4BtN3OG9ZKI53+1Uc7XkRYXlhY5H9GqGWTXEiSHF5X9JJfsTwjN@nongnu.org
X-Gm-Message-State: AOJu0YwDb2FKamI2X4wTeAmZnntBZkW69sDn61/F0jkLl2DvmpaHjnx/
 y/5Lfv+nLwJfVAKT4vndD+pdX99GPl5287l+mzSLl4rcqx5adHkbrZpYJ9EfaJ4eVM0=
X-Gm-Gg: ASbGnctUXFDapJA9SzXp+Nl19nDjfydW5bbmxwWQ3xxD9INvE7aTaF3bRZqSvGx5g47
 gcW+aTEmxLTktnJ+vpCxAMU6GQOtxkYSf3B2Nnomdwef2+HmRiJsbtD3E3b4LAdD0K2TsUH6Qz+
 UpOlCMH263XgFbMY3UlAV1dnSl0QY98ty9oIIDX19pEavua2dfdN00p2HVDItsP2xJDFhuvok+j
 aMrJcfiHT0v0YMGBiNOUSML+GrjY70cPPPWq3aKyvhCk0zOtV1MzUmH7IHY8y5Vb3TjJ5bgdpbs
 EiiSaAKrkr+tZDB9WmY8ZaWDAxdgT9xfMm1JQS2gsMOiLRuewuD45fRelmYD2qlwk5OG+AN1U7c
 z+0EeHPkok3s/4s6My87pZrwB/snw0D6B0oIH
X-Google-Smtp-Source: AGHT+IHUOfxZ3A9/4pPFSz02sNo7QY1LPpxJSzrBZoxgm/YdsegHUkL2OZBJBmTRtVJAG7VCsMumLA==
X-Received: by 2002:a17:903:46c5:b0:269:87a3:43b8 with SMTP id
 d9443c01a7336-27ed49c7741mr13940515ad.4.1758748560178; 
 Wed, 24 Sep 2025 14:16:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed66cdc96sm2235725ad.22.2025.09.24.14.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:15:59 -0700 (PDT)
Message-ID: <559f0318-25e4-4ed3-a832-a46990a65046@linaro.org>
Date: Wed, 24 Sep 2025 14:15:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Functional test patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20250924063956.519792-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
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

On 9/23/25 23:39, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit ab8008b231e758e03c87c1c483c03afdd9c02e19:
> 
>    Merge tag 'pull-9p-20250918' ofhttps://github.com/cschoenebeck/qemu into staging (2025-09-19 12:21:35 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-09-24
> 
> for you to fetch changes up to 097bbfc5e0ba889ce17106ef941a56111c3de270:
> 
>    tests/functional: treat unknown exceptions as transient faults (2025-09-24 08:26:11 +0200)
> 
> ----------------------------------------------------------------
> * New functional tests to check via the vmstate-static-checker.py script
> * New functional tests for CD-ROM boot on hppa
> * Skip functional tests on more exotic network errors, too
> * Fix another issue with htags in the gitlab CI
> * Some additional minor fixes to various functional tests


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

