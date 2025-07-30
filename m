Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53B5C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEOz-0004Ka-Qu; Wed, 30 Jul 2025 17:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEOy-0004JR-62
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:31:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEOw-0003hm-Gh
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:31:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso4190135ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753911112; x=1754515912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HisPCa4SbEM30SJKmKzqMEC0GL2CtIf+jsJv/qKp070=;
 b=NWho7GToRDl+jwWFYN/mYiYGPOpKEUqc+Ir2AhjPh65seqSfqAmsitcJO+bx2NLkrV
 jd8pRXnDyZQG/DWvtobQOkuvIGw2s7bndjClihMx8JU4+6tn1WeaI2VdSiKUi8SRRzCb
 f1YKhw16nQC8wJ7Xmn1/ZIF3V9gPjoIU9TI/c7p2bVxfT+6IR07dIcaeH13QlhHqEVaF
 XXjym9hd5UvZEdoLjdpHv7+O/MNSCwyZ2Y4WPID7ycWBERCsyW+UyjEzr5Iw5urlvqow
 dwQo3tFESg4ka2ExVEDOnc1krtlnkxTOVm/EkgtwPX9sD08GA0Ty5u5NXTOLPFt7FD1a
 yJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753911112; x=1754515912;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HisPCa4SbEM30SJKmKzqMEC0GL2CtIf+jsJv/qKp070=;
 b=HoQBLo3RAA/u41sYAGnaiYOWXhwklRuk6R8INoL2NaVo/IWumKE7FX7s4L89NLsYDi
 4h38P9U9141A3MAsqXUykRXKCiYGsJeSRJf7JW3fN0D5Gwd8z7k/g/IfQwm4jftChYES
 eXCTmugjC0OAoJfqaigee9shM3G8My4ryqPLfVBKIyLlaE8M56d+UKAG/KFaIBClP8Ao
 Su4KjN7F+dNcc0ztxAtKI6VEJi1LSddVmxbPG7zw0j6MuhFjX1UXRmGh0qNg35Ix5xRs
 YOR3WoHdRdpiyCrWszov9rs5kHvrSvdSv3VroE93g05nm6hn8FGyaTS2aZkRchPuCcRI
 U4Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWku28rISVEpwlarCLOhADFf+zxZUnZHsysJA54EI/DeIsMY5JHN3JJfUDztzL0vVuEr/lYvpGkHwQL@nongnu.org
X-Gm-Message-State: AOJu0YzKzKgr4M2H3V8x/WXuRJDBm0TmaiodHm2w9iD34PhBQVI3CKp0
 /qcQhlAeaSRrH6AmH7qWDu/4+WL8FvuvJfL/oMrrh1A4CKJAcfFhoeZG1Zzpkh0XgiM=
X-Gm-Gg: ASbGnctxMov1gENe1IP2F0ojDL3gI6BH2iDXmjHi7So/NaulAYa6vBpqBAXv5zCSg5z
 rCVMeM5wkY2P3GNGwb4NrNw1brKCdtSyhAZyJDTw14vVU+TvvXG2xH0ytL8qjRb2bvTYFSAA50e
 OkNcrVVsdf/uEw4Jw/bntdHRRb3mjm1gbGfGScQXbQ+dxPv5IlgG1fjiuBr90+pjirXrrkfepvz
 sViCd74ZYHjKZp14BXwwU3BmitAqRbh7GTQvh17cS1z1OO/VXse3YYTo1Z4zhDaexPLbpAtM8LR
 XXEdsVLclDd/Lo6EQ5BWx+UnTz+deLHZ6QZyi3jl4RuZ8ZM6BMyTfO1Ig1Awo++IbMNUrvVBD91
 ZAvsRVnU+/ZXhU4P1/0+S4pUek3E8qhxW2JaI0wYP6qYVow==
X-Google-Smtp-Source: AGHT+IEL7LTccitvo6TLsiIm7ptVSx5ZHOdlDhM6QRVh0bZCgi4j6Rq/X0wZ+I9GRyG2mVZgjWkC0Q==
X-Received: by 2002:a17:902:e78e:b0:235:ed01:18cd with SMTP id
 d9443c01a7336-24096b2f89dmr79371745ad.44.1753911112648; 
 Wed, 30 Jul 2025 14:31:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8977114sm611925ad.102.2025.07.30.14.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:31:52 -0700 (PDT)
Message-ID: <897f6b21-77c8-4323-a26d-943db178b77b@linaro.org>
Date: Wed, 30 Jul 2025 14:31:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/82] target/arm: Convert arm_mmu_idx_to_el from switch
 to table
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-31-richard.henderson@linaro.org>
 <6963c11f-ed15-42f5-9110-9516ceb64662@linaro.org>
 <ee5e730f-9bda-4d66-a055-9346e5a18ecd@linaro.org>
In-Reply-To: <ee5e730f-9bda-4d66-a055-9346e5a18ecd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/30/25 2:12 PM, Pierrick Bouvier wrote:
> On 7/30/25 2:10 PM, Pierrick Bouvier wrote:
>> On 7/27/25 1:02 AM, Richard Henderson wrote:
>>> In an effort to keep all ARMMMUIdx data in one place, begin construction
>>> of an info table describing all of the properties of the mmu_idx.  Begin
>>> with the access EL.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>     target/arm/internals.h       |  3 +--
>>>     target/arm/mmuidx-internal.h | 27 ++++++++++++++++++++++++
>>>     target/arm/helper.c          | 27 ------------------------
>>>     target/arm/mmuidx.c          | 41 ++++++++++++++++++++++++++++++++++++
>>>     target/arm/meson.build       |  7 +++++-
>>>     5 files changed, 75 insertions(+), 30 deletions(-)
>>>     create mode 100644 target/arm/mmuidx-internal.h
>>>     create mode 100644 target/arm/mmuidx.c
>>
>> What's the benefit to explicitely size arm_mmuidx_table on declaration
>> and definition?
>>
> 
> I missed the:
> tcg_debug_assert((unsigned)idx < ARRAY_SIZE(arm_mmuidx_table)), which
> does not see definition of the table.
> 
> Maybe it would be easier to declare size in the header, and reuse it on
> both sides (declaration, definition instead of ARM_MMU_IDX_M + 8).
>

Finally, the ARM_MMU_IDX_M + 8 is not a problem.
That said, given how much we repeat
(unsigned)idx < ARRAY_SIZE(arm_mmuidx_table),
it's definitely worth having a 'arm_mmuidx_is_valid' static inline 
function for that.

>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
> 


