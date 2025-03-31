Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDdx-0003C2-1X; Mon, 31 Mar 2025 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDdu-0003Bd-QQ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:49:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDdt-0008Sn-7e
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:49:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so233518f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743421763; x=1744026563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBmPFEWsS3KbC3DeSef5yLAPnPVVrdVEGN4OzmxjRBk=;
 b=NLTBzvcxaZZI7t3WNyj2DAz+sKpQr6E/fxyO9cFdnZQ1u2Ocjc9V0cAvtGzWRjgqyJ
 /EVvpDUmG+n9S4GgO/3JwTWA8CsY2SKyPABJD6vGrD+tWluAEKbBGLYIF/p6toF+TesX
 qFVRUs4fup0JqLsfuqmOAnDAmj+hTMFFU03TFZr/Qhz0Hg0fJxoWJqU8yRFbfVe3PZzk
 wWYfZetofRJULoHS3d81SyAms5utHphrDO/b4uc2LfqODPPXmJqfVSCYzAkW/SavQjuT
 rFLnLl4ePIAltMksJ1oB6/8S4yYF3/s3KXMUmFy1CZkYur+hGiWgeg/I6zMguVB73tXj
 kvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743421763; x=1744026563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBmPFEWsS3KbC3DeSef5yLAPnPVVrdVEGN4OzmxjRBk=;
 b=hjrbJ0C4dWWpKSRFtWaioU2lZ4MLw6cjvwfKtTDQRFSOop2cG44X8ttmK4UvwQuH0/
 Lq3rnC+/5mSPtQ9m4S4R12q4VZonDeBtJJ8jI/EHqPuw8oXbyCAJV49HBkYs3/i4ytce
 QQol9M12xTheFhCLMJSY/YTf4nLKuR5Hs+aX7aehRRNBoQ0Mdz/cn48sUzmYiuHXc1T+
 0fDJQuboKeG0ziY+huwGwRVPKMARixx/a3VbZ72djefH5ssKkpWYWBaz8RUU9A6YJrvi
 kRJwKXH0PgwIqUmlBomlL1ODaMAqfcwEJHTAlkOsOTTBXJYxMkRXONi5f6bNw/yjBvil
 neEg==
X-Gm-Message-State: AOJu0YyIy9zrlP8wc8SyB4GQnGoGNSWlsNWvnEGH13ljsFVQt+wgPzx+
 0wPEUSdTeuOO3M1kQ5lJ/9jZLsxOS799pI4B48u+pKpuoMHOE6aqCDqSMMNpRUckrZ2HUv2qanv
 v
X-Gm-Gg: ASbGncuqE+hkvOyTf7npGXu0Z5o0emGvm5aBiTzmdAc6vuyjnNinj3mHZvbWAkZ3IgD
 Hy8ulFyp+jymjtwreEM0itDg9Lyg2vl+xMcezWqH5tD4aodWXpX7G1NKnyjPE/GvaPHaPKjKT4e
 rTeun4rxkZBuspvjBmy0eLnStOm0B4yTTj2FW4+1ZcIyOGJp/u3+RnOELJmyj6Nt/wOqPBAxsX/
 OPU1Nmq8eJkVi0PCyxASV1PkAC4FpY5/CApv68WLRji18xRq0Docv9Gq81LimBWxlilYAjiB8Ks
 KRc65v93Hpd+SgY9ZGCzbyjtIBE55SjEp5xnxw0VAa2b+u8VUzaJnzJ7e2ndMNtw751QYpbSpbU
 mQ+nFO7fndT2a
X-Google-Smtp-Source: AGHT+IHeVHSk+/LEXulKxyhgiKm2BXgaM4haHcoI7Sju65TufBzcIu873SHK1lc+gJ95QJcfhAojxA==
X-Received: by 2002:a05:6000:1a85:b0:391:40b8:e890 with SMTP id
 ffacd0b85a97d-39c120dd0d3mr5478968f8f.22.1743421763064; 
 Mon, 31 Mar 2025 04:49:23 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d916e1842sm62432795e9.2.2025.03.31.04.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:49:22 -0700 (PDT)
Message-ID: <7db2689d-d5d8-4bd0-acb3-0b4a0da675ed@linaro.org>
Date: Mon, 31 Mar 2025 13:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/5] gdbstub: Remove ldtul_be_p() and
 ldtul_le_p() macros
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20250325130221.76116-1-philmd@linaro.org>
 <20250325130221.76116-3-philmd@linaro.org> <87cye40wxp.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cye40wxp.fsf@draig.linaro.org>
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

On 26/3/25 13:59, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Last uses of ldtul_be_p() were removed in commit 78920b4ff2b
>> ("target/sparc: Use explicit big-endian LD/ST API"), and of
>> ldtul_le_p() in 39631d57d7c ("target/riscv: Use explicit
>> little-endian LD/ST API"). Remove these legacy macros.
> 
> I'm guessing these are commits in your tree because I can't see them in
> origin.

Oops. I'll respin altogether as a single series.

> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/gdbstub/helpers.h | 4 ----
>>   1 file changed, 4 deletions(-)


