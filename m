Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88430C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WTl-0004Ef-EE; Thu, 17 Apr 2025 17:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5WTM-00048e-Ru
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:08:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5WTJ-000341-Rc
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:08:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2279915e06eso15709655ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744924112; x=1745528912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jy98ubffpFY3J30aDDry5MZaYuJ5R+InxA2WyR2h0Bo=;
 b=MaL8AbcpMdJ6qefUvhSAgtzHSZQC568lhdWKaxgTUnUzu4Jph3IgeVVueWYANRnKOf
 dcTT0svKRkiG7dY1S6slRyayC3NjV2IOh0d8QK7r4VH31puko0Roo9hpO5UD2Xy40QwW
 SizGJDobuaNN5QdxsrtxN9EPJ/KQ0ciGBoSKFAQU5cmlRkFXam9oRZmIthbsvM6CcS2w
 eUG4/wamaYbCnW95e+fATZKfPRmFuhPXSVtQu6fE+0V4Nzduqv3zTaWlCp+5HHMsbNwJ
 4vHAkSW+7CL5Q8sa6EC5W64ceeivy/+Utr1MJX87qsr3DlN+aaJ5G69TTHBm8bNOKtm8
 nkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744924112; x=1745528912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jy98ubffpFY3J30aDDry5MZaYuJ5R+InxA2WyR2h0Bo=;
 b=XiDGT2blObVlr3zEds2WQArowDOCy1fdxB2CvLm7Ka+nx3LOyHpwvLXYadGIZcqGRm
 NYHUZQDoQTl/hMQY7jlaICPc7pQhv72ngMlYmG3PTLOiKu7GG5eSgjCddr/vPQyYwo3T
 gArW1x2+aOajUyZgHF0z3a8/N53k+9sDjepAbAl/sER8zh8dHfqYIgiTbMxUk1vsSCOC
 A1Jz1g6L0mSh4GCPuuUnk7jkkkcFBPGTJosyEjs9HJKqHLjMNXfD3XVSuN7Pb0qOHxHy
 O8hdrTRrC86e/LqBKz7JnzfazZB6PGj4nt1wgRG3Uqe7McPQ2FYPrkYQPC3yenDIurF2
 lrLg==
X-Gm-Message-State: AOJu0YzkglstAxxWJvGmi86jLGaOu82zGG7S+n5KohX1+5nSnrzMtYTV
 mjRCJUzua3I/lGOKOu9og1k45/xRzOefATV1hA0h8W+7HEYR1vzBYA9k4MndN6o=
X-Gm-Gg: ASbGncuTFwgWieAnEYaweW9o2HiznUBMd7blLECc/ghmiBHjuKUfF8fsEMrhOTDVSZF
 KpRrvciKRUlPo83gGk9YEpn3QQ6YIa9JK2PoHiX0okSESZHKMr28URQ1mDg/+klzO7wOZnjzBFN
 x+A0jbluHIzeVoWBueVlf2Khsyp1k+yRFSiFxRaAm2p5vUX1R2+Vo7zqw/6FsQqaFqoH4+2LN02
 fiyblwl1wqx4aWjFN2gfPM9mMCY9A6CmdOF0RjIjCs2MT5Sm99ZNEDrcSvXoBQ9C7dVslXfRe5U
 S9cNBUnWDBAhOEm6m9gkbnP1qv49HfwD3+ZxeKNU5BmmNSgBIfIjS8ZU2wbxaX8=
X-Google-Smtp-Source: AGHT+IHAqmHG+gCegdRdildPKQzA1FG88dZ39XyUN7OzdAAkJRLdKdrvI8aC4lxYsAoChB03vRdATg==
X-Received: by 2002:a17:903:1b0d:b0:224:a79:5fe4 with SMTP id
 d9443c01a7336-22c53573508mr5949335ad.2.1744924112211; 
 Thu, 17 Apr 2025 14:08:32 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fde89asm4443445ad.235.2025.04.17.14.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 14:08:31 -0700 (PDT)
Message-ID: <3fd95fa9-6de3-436e-95d7-8ff2b9ec0909@linaro.org>
Date: Thu, 17 Apr 2025 18:08:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 0/9] hw/arm: GIC ITS=off ACPI tables fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <b26000c7-f72d-49cc-8f7d-2ce3458c47b2@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <b26000c7-f72d-49cc-8f7d-2ce3458c47b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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

Hi Phil,

On 4/15/25 05:19, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> Could you take over this series? You seem better suited
> with ACPI and testing with Aarch64 virt machine :)
> 
> Thanks,

Sure. I just need to clarify a couple of things regarding
the IORT spec. Meanwhile I'm (hopefully) waiting Igor or
Michael confirm that the patch organization I've suggested
makes sense for them.


Cheers,
Gustavo

