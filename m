Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DB8CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Wqp-00083i-B6; Wed, 24 Sep 2025 17:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Wqn-00082Y-If
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:16:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Wqf-0003aS-1a
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:16:33 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-27a6c3f482dso2375555ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758748578; x=1759353378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f68/Pohu4n0RNbzooZZ0kTk4nnv13lgv+wxYphwefGM=;
 b=FyzqhiooMnCO/mT6WoMpTmzmyeTISz94orhRb6Arf0PIOe/HgAs8v94YuejOVig0/y
 GLuOUqZt9rCgUWlP26mvRPyzLBT8DiDv4l2Kw2B4jl+yjotFouJorafV1cMyLr/siwo5
 A/j7zSc3TGHbhyV3CS1yY6F0l01TMc+5ACCfxZ2D2O7RDYp2CPcm0eLJ6ONyB5zItE0l
 sfXRHtUYKvQALonoHIWgCaVxsuKyD5wbQIxeeg5zR7jM9/ulJf0aF2Jjrgg+FDjdc15V
 4UUhvV1V80k+WLAlPPcM1OFLwsUS1ampwsW2VhPylhQufW1vIyJtIZHQj9HGripAomBY
 Mfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758748578; x=1759353378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f68/Pohu4n0RNbzooZZ0kTk4nnv13lgv+wxYphwefGM=;
 b=lWqVT+eR06g8de8A9DMFz70KPXvYwovQvIL/ZSu/WKcocacud1d4t5J4kNy6YkcdlF
 VJV/Ij9IHbqvlLh7FVVsVD368FRugBtT7W/4CNDt6IuB+7X0rvljp0OwKi80M/dfLUJP
 IiwA0jV8ZQhyZSyTUpFV4B8llxgFsFWDeMPsKMRDAVm0YN7xc1EJaAI0BB8nXnbgEF69
 TUDahLBKDUVyjU9ASldO9x3Rs8f0pYc4KEL1pdMsMZZWsecpyg+1rKPokDrXIGXlZWPD
 lUGL4Uy9vMw5cDFHi0GG8cqy9PGvZbY6qeSt/6f1iuZApORURd0UrMmDfe6J5sqKFlJE
 b2tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/QzwwstuIv9PImecqBo3yZuCMcWfW214Uq5/jPavuC1c/FglnoLIbRz5mav0NXuJFiQ438xbVrKB@nongnu.org
X-Gm-Message-State: AOJu0YwH7gKgjeWHwhtLGAcMJxuUwErS45I0DMEzdQnqQHQXv3G7HdlQ
 yxQIxmxDFv05LQXLNLwwhE520hEAPgw4A6WwWgfC5Q50+RLD/KFrmTX4NPeAroD+wzY=
X-Gm-Gg: ASbGncvhVHAC39OYuwiPhaPPkGewqnihWuB1uyETQiGfWfm8qm35C/DMB2jPaegdoDj
 MIIJoA1Em6YMVgBW2KoQPf6x79/OSW/PNEHZyOpL+1M7rtbxKlLtH1LdLbOPpbAiAQxbuoKO4OX
 SOHDbEi8yT0lBBT+7NyUQ4vHINsozJJ20R8c69Ivrj/K3OJSWlIRCIoCrhwXwVIBCnmH+kQwaMB
 Ip54PNnATn0iOQakvXHtGgwBnE8T8xDbXfhT2+X3Nz8rIVFT6hL0TSEG30qx5HmkiJDzgzO105y
 pA1XjllSCUPloHteNr4lTVzFRPVAEWwrE+tyFPN2mQKUiVUs0E8GQHX1ligF5rj1PABozPtU2pz
 FrFRslJyPfVjtALiVhOnHucdTwc7wyS/qT8Eo
X-Google-Smtp-Source: AGHT+IF8lkztOOVy4UNpGNL5JU2HrGUp4UwCT02q2SzcmQWtQEWKR+AsorSJr7oQfaa5FLTdOIJiDg==
X-Received: by 2002:a17:902:c94c:b0:269:8d1b:40c3 with SMTP id
 d9443c01a7336-27ed4a29ceamr11966235ad.12.1758748578528; 
 Wed, 24 Sep 2025 14:16:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6881fcasm1938555ad.93.2025.09.24.14.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:16:18 -0700 (PDT)
Message-ID: <533c0a0e-7fc6-4640-83f4-06f93a7b98a9@linaro.org>
Date: Wed, 24 Sep 2025 14:16:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] Rust, QOM, docs changes for 2025-09-24
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250924092850.42047-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 9/24/25 02:28, Paolo Bonzini wrote:
> The following changes since commit ab8008b231e758e03c87c1c483c03afdd9c02e19:
> 
>    Merge tag 'pull-9p-20250918' ofhttps://github.com/cschoenebeck/qemu into staging (2025-09-19 12:21:35 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to cd64320e1e27168d3796a847bbfde66c8b1116f9:
> 
>    docs/code-provenance: AI exceptions are in addition to DCO (2025-09-24 09:26:24 +0200)
> 
> ----------------------------------------------------------------
> * qom: Do not unparent in instance_finalize
> * linux-user: avoid -Werror=int-in-bool-context
> * docs: use the pyvenv version of Meson
> * rust: parse attributes using the attrs crate
> * rust: complete conversion of qdev properties to proc macro
> * docs: clarify AI-generated content policy

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

