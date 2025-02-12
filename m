Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF8FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHMi-0000vp-PJ; Wed, 12 Feb 2025 13:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHMg-0000vg-SX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:21:38 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiHMe-0004sw-SV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:21:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f92258aa6so99629335ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739384495; x=1739989295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p9JEcMGu5ptMk2/xRVhY/euFglLjuR4fpKwJpfP8ISE=;
 b=jenIwhUHnBB4YCYVlSHrjJkHrVgPmQdpYYVxw988FZ/hOX3qvLRCFavJT9V2ad/f2b
 Mt4OruP/Q4eiO7o2rOrUDxSd/CBMNAsgqupY7/EdFjs4U0jrtgSBBSvZtsOrr2Gy2Kv/
 8D9FGLkej9v1ZPVLIyy1oIVl7S8bgGTeW1FRvNjFqrJwbEp4TAmcy12uhEP5AoRg9QOS
 kEDETqAqSJ3ZA/7ph4eZzujqEgqgWmw4sLfdL/t9lv30JmiKb1Ft9dDNHyxEoNweBPIk
 6J4FEr2WbSm5f3hYCxvFlkGRR4w3YXB5MusuDUAZjP99IlrSqatJisWnBYB647oUe7RO
 e7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739384495; x=1739989295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p9JEcMGu5ptMk2/xRVhY/euFglLjuR4fpKwJpfP8ISE=;
 b=RvDscbNjLi/FBF5xIIx9N1ukhGpFdfFOJExHswLvS5LwjmVsGpgCKMuyGdrg3l5pSz
 COCIwx0ep4IcK9+2OG0XBk/8obZFS7s+M8PtHPJ+ORXFiSU2ETBo9eAmJUOVftMe4ZVE
 zRlUr1ZURq7vhgmE3q0Yu53yzHYfn2TTaXNug92tb/bxG9qmjCu9hEIHHIvsMNiGRgM0
 Z9cHh6+brttiPonq620LjbOY7aW0FIgi6WCn7VUYSMGBSylTPtDdYR2VwEXY8LxUhsh6
 K7SD6eV8AXEA6uNxBaES0oZN+KKCV/pZ9qRPwOJDOuiKzHJ7pFfgXdIKuaYY4veqUa42
 Dw2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB5wdEXbKQslBZCb1mCtT3jlkYgTM1OvnYu/vkrxYeNxO4pY4GbDqtLFoFJWK+Lpzib+4A7sC6InPQ@nongnu.org
X-Gm-Message-State: AOJu0Yy9W3fcCqE1L0Mh89Gn8G1qYDttQPcsFuLwcHpxzmcOTYFJdcbl
 J9Tclx8Cjib0neNFZaq1d2D27HsmuhCpEhyaNNT1L58u/KTgF8lHnusIaK0qcuq1qkVDNPOwoEe
 n
X-Gm-Gg: ASbGncsoJYCdXo4LGJETMe2rj0HqAU+iFHqEVE79YIq/4/XUbvPBMrLRAMqjka1k44v
 HQ3r2yrSt3b0O0upf5kZbAjiMF4h8ezucscD1Fdcm+OcregmC+XE3uTOI4dQhUbCehupJZzPBeW
 +imkwvgF/UHA9rdosu845xqc5jzgTLGqdKfWb8gb05lsDireI9mlBmuKNr3hzt5dCbhviyy73dk
 ezV7V1gbXTf7Smg1sd91aG/FJeFbIPnXfI3lR4noC6EaES2qcig/fGesEVj0iEnHbRyZ0p7FiiJ
 RhsfoW8RyCdzIjCHJEOwwiJwoGl1UMLQTSQ8aj7Gg1OuPOYFGMTNKMs=
X-Google-Smtp-Source: AGHT+IHjY3GUmpkhcXn6GaGuju9r4FQwkegtQ0kOECieVtMx+yIE3yIISGeww5LVLVZ3cMdkopGSGQ==
X-Received: by 2002:a17:903:1c7:b0:215:431f:268f with SMTP id
 d9443c01a7336-220bbab3403mr76940985ad.10.1739384495024; 
 Wed, 12 Feb 2025 10:21:35 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21fb8ff3a18sm33977025ad.187.2025.02.12.10.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:21:34 -0800 (PST)
Message-ID: <9231fa0b-f7e8-4e53-9acf-7f89d81f6b60@linaro.org>
Date: Wed, 12 Feb 2025 10:21:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-10-richard.henderson@linaro.org>
 <9759c6f3-18c7-4693-a2db-8a10fea182c8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9759c6f3-18c7-4693-a2db-8a10fea182c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/11/25 23:22, Philippe Mathieu-Daudé wrote:
> On 5/2/25 05:03, Richard Henderson wrote:
>> The declarations use vaddr for size.
> 
> Which seems dubious, since TARGET_PAGE_SIZE is int IIUC.

This parameter must handle guest huge pages.  Most often this is 2MiB or 1GiB, which do 
fit in "int", but logically could be any size at all.  So vaddr seems the correct type.


r~

