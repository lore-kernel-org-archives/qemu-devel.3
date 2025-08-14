Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1780DCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 10:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umV6D-0007BD-Bl; Thu, 14 Aug 2025 06:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umV69-0007Aw-RE
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:22:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umV65-0004tp-MN
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:22:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9e41101d4so384973f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755166929; x=1755771729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VkI9C4t4KS/LM54JFTCX9Se92BSZumpjJJChyVvQiz8=;
 b=v7S5o/XL7w4S2Ktb9DADG07HgxA6OAhEDbH8O8oQEiyZGS/9noW6jGMKXMdeS5ywRh
 teGifgGmczN6rU6VZCD7LwwVbBF75cf4Krmolo+kLIZ1zTitBGm7W0bUYO0HaVvCtmCw
 aWT+V2yAWDDDAvSvJpstq60kl36sSCjHOfNa7inw52Z3GlZtXzhH/vpVyHQBRLZZtr7V
 ffeBnA/xW6d6pu3JDjdDrf46zxQvqE0gau2w0BgWrMvrgAclMIFMmhg3l8GSWtpWFpVH
 STHJWcuGE3/8awv9qaHHM0AL5rp4qiQfFhrrWwlr3pkh0xBDawJjrDD8eLVyyYJZVbPw
 i4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755166929; x=1755771729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VkI9C4t4KS/LM54JFTCX9Se92BSZumpjJJChyVvQiz8=;
 b=kXSPS3LDCQJ1q0NuiULX2dZM4tvXninTYGICxbjywWXvMm3TD1YqfQ56DZFDiDhgKt
 4epgS7kJoScWA9Zyxv3PFz7BmtTSBMHXzOhC19n1Wk2z5SHTXPLeuZdkj06iE8k8P2Uz
 il8TAJZ+9YjRKKDxkoNxFgdpZNS4syUn1V0agdwzHiX0vmZqLSAGDJeKfnGPVJGsPDgM
 QoGfnmUoHZQtqeybcmhlAM6SalLyeiUdf66KcLj0d6ZCszkfXSn/uxZ5sI+QXONdjDC0
 1lBPS7q6rR13JFe7tX4LlbaYyRMXcGQb9QcXM5O4WaIsu1FgjH2H+TBq54Tl6YLiSXK4
 zyww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcXa4VNmv134uuHPGP8vY+mnTqiMhSJ6TFZh16FZ+YDosEUX/P7y9FWuf45dsIwp+U305soqflC7r+@nongnu.org
X-Gm-Message-State: AOJu0YxFzsRAQk9PO4faFF5JXwAuFhbgkiheNHCtdckBz5Qp+qorSzP8
 RDiBJPylNPUPhay94R/suELJQRgesiaMSnU1NMmgen8VwzuY9MozA8C3E4SGk2Tcyacnz4cskyZ
 4IHWc
X-Gm-Gg: ASbGncvPxqn6W8IPOnqY6xKfJVl6sb4sQR2VSszZ+gYVqzMpgf7vsl8WAWkmUG836Fa
 6jbJ4M4I0HJDoucXlYbiMCW1kTQSB2JHXByQDkJMDjSiyFfFJr1MsL6mDtRdv/106EENLgE9KsZ
 /PVBL7/GUT/Xxnzgazqpi3TqB+S49UChVQrHE0F/aGg+KGi0O5GbOd7aP/KjE5Su6Qt7SzScfte
 K+er/b2f4JEu91MByJxuxBH3vkmpLx4Myt+MhimMXkgFX64VnrFLeh184xar8ekjQM74kM75gkp
 aW5ehoq/uObFlV7zlL3jsCuIVQDQ5N7TLGfPnfJiy5OvO2isHEgnbfnRsSYoXwuzN6oYUCYKKvT
 tamKBD16c61iqQsYO7m5OUS22Cu/4nbNj0orGuX/nWGrxY4g96jzwQAbgIZg2ZDTk85lO0Os=
X-Google-Smtp-Source: AGHT+IEtxdyyBRBs66NEP2FZN9MZLazqjEpS/Ew4KQ8ZU/E5Mxs/tFLli/KddWuXHgkRB7mGvzFtZA==
X-Received: by 2002:a05:6000:240b:b0:3b7:fbe3:66bb with SMTP id
 ffacd0b85a97d-3b9fc3701f4mr2149992f8f.50.1755166928890; 
 Thu, 14 Aug 2025 03:22:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm50175195f8f.25.2025.08.14.03.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 03:22:08 -0700 (PDT)
Message-ID: <75e5db25-7f85-4d43-88ae-ffe7d46890ca@linaro.org>
Date: Thu, 14 Aug 2025 12:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? 0/3] linux-user: Select default CPUs for
 MicroMIPS and MIPS16e ASEs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250814070650.78657-1-philmd@linaro.org>
 <bc3d404d-1c93-4799-b4bf-b4c05f1ac2fa@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bc3d404d-1c93-4799-b4bf-b4c05f1ac2fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 14/8/25 11:57, Richard Henderson wrote:
> On 8/14/25 17:06, Philippe Mathieu-Daudé wrote:
>> We weren't parsing MIPS ASE in the ELF header, so couldn't
>> automatically pick an appropriate CPU.
>>
>> Since we'll have a rc4, I propose these sensible patches
>> for 10.1, but both ASEs are available since 15 years in QEMU,
>> so this isn't something broken since the latest release, and
>> I don't mind holding it for 10.2.
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (3):
>>    elf: Add EF_MIPS_ARCH_ASE definitions
>>    linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
>>    linux-user/mips: Select M14Kc CPU to run microMIPS binaries
>>
>>   include/elf.h                | 7 +++++++
>>   linux-user/mips/target_elf.h | 6 ++++++
>>   2 files changed, 13 insertions(+)
>>
> 
> Does mips16 or micromips apply to mips64 as well?

Yes (both).

> If so, we're missing changes to linux-user/mips64/target_elf.h.

Unfortunately no 64-bit CPU we implement support these ASEs.

I'll add to patch 2 & 3 descriptions:

"Note, currently QEMU doesn't have 64-bit CPU supporting $FOO ASE."

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

