Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD664C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjrT-0007yt-Lo; Wed, 07 Aug 2024 12:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbjrP-0007sv-4v
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:50:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbjrL-0007fN-MX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:50:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so24944f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723049398; x=1723654198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=33U7p2LnLsKhMpp4P6MDD4QNvPZUeLSexOn71JZcms4=;
 b=KzxDLTPOmsypzsx8f1WykQGRRY4sG6b8UxrthFUvCvWWz4sgu6aUmsTrHrkQG0t2sG
 t2lKZ8Irr3QrNgCNj6S6Q9+DAGBhbdZSRh9ifLgw1+lCtqMpRxWSDqJ8p380xddoGOL5
 pN1zkiUY121N207Yu8x/BYUBpY3AeYiHU/OLMR5/94UxjjrSmxuXBlKFKn89wKFXT85h
 UiDTkWy7jhb2ezpYwKTr7+DGxVSe/Y8x7NioDUPH/Sod87/dzB5kRf1Q5sJzwKpAPI0f
 UKM0n/iuHVpZ2z2PmIJFFY6U++9vWh9wsOIdTTEL66W4ZiXGsApk4dM+NV1WGiFtVIY/
 v+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723049398; x=1723654198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=33U7p2LnLsKhMpp4P6MDD4QNvPZUeLSexOn71JZcms4=;
 b=eZry6ZPfY9vuWYQUe/1kR3mRjTTg9DNaJahhxdSeBdnWvUW8+jv40vm/RtvPsHUJxs
 abaMq9a6alkeMjM9k4SIkhmXIxDKyeUe8X0GAjlyR+BDQW64KhUiHERBPTMGqkELYVr6
 BVPmKIeSlfOp0dg8L3c2IKdUqWVv2kFPUL9HPQFRzaraGCzmbfL3ucc9fG3pIavPFc0X
 nCcRM24KMcEibmiDX0fvRtn2IM9iBm1Nh/A75b7dtBf1Oaxvw9G8iB35RkvGLMVm0OZo
 nrAgOkJO/EGwES2ugICOoczW0U9ChwgZ5gLQWf+Hh2qg4davNJZ8VWCjh+eSXLKggeB/
 EczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/YgBcnvHc0hn119WLhVWAhVKM/OA5XkpT7Q/14wB0IjyUJo+Wgvj+Y0LcKi5pn7JvDLeKs+uaFOeYycbyRhEQtQZlUmA=
X-Gm-Message-State: AOJu0YwQ7tFQ7oMzhZr19oE9Pv9iC6ZdvY6JC9NVq2FtXtYbCu129VuM
 RDsop9FvmHj+n1qu65Ck5UVy/9die93uhR2Jao/luSgPlhMvmnlTOP7phfovN9I=
X-Google-Smtp-Source: AGHT+IEdE1tzgba9TGizBuvNLeovvPi17J5ZNkLTn4SdTzlBs8XfOucJB/7owXecxUAAltAM6VesGg==
X-Received: by 2002:a5d:6949:0:b0:366:e9f7:4e73 with SMTP id
 ffacd0b85a97d-36bf0d91f99mr2296582f8f.5.1723049397733; 
 Wed, 07 Aug 2024 09:49:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd169697sm16542634f8f.107.2024.08.07.09.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 09:49:57 -0700 (PDT)
Message-ID: <609994d0-9102-4bb5-9bd3-32cce5d8f276@linaro.org>
Date: Wed, 7 Aug 2024 18:49:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/i386: Fix carry flag for BLSI
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240801075845.573075-1-richard.henderson@linaro.org>
 <c119648c-179d-4332-a658-8ce5153e1dea@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c119648c-179d-4332-a658-8ce5153e1dea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 7/8/24 07:41, Richard Henderson wrote:
> On 8/1/24 17:58, Richard Henderson wrote:
>> Fix #2175.
>>
>> r~
>>
>> Richard Henderson (2):
>>    target/i386: Split out gen_prepare_val_nz
>>    target/i386: Fix carry flag for BLSI
>>
>>   target/i386/cpu.h                        |  5 +++++
>>   target/i386/tcg/cc_helper.c              | 18 ++++++++++++++++
>>   target/i386/tcg/translate.c              | 27 +++++++++++++++++-------
>>   tests/tcg/x86_64/test-2175.c             | 24 +++++++++++++++++++++
>>   target/i386/tcg/cc_helper_template.h.inc | 18 ++++++++++++++++
>>   target/i386/tcg/emit.c.inc               |  2 +-
>>   tests/tcg/x86_64/Makefile.target         |  1 +
>>   7 files changed, 86 insertions(+), 9 deletions(-)
>>   create mode 100644 tests/tcg/x86_64/test-2175.c
>>
> 
> Ping.

Too x86 specific so I'll pass for now, sorry :(


