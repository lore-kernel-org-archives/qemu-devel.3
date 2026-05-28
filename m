Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40306CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSj5O-0000mt-Ih; Thu, 28 May 2026 18:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSj5N-0000mE-CV
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:20:17 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSj5K-0003kl-Vz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 18:20:17 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82fbdd60b64so10781437b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780006813; x=1780611613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=veNuRYhgs4KrAydLkx8OQVE0JBYIgppnw37iEjmm/mU=;
 b=RMjxeKCdMak2Nrunslcl9+Q1Q4LzM8BPPqhtBhr/T466EJvfvo5MydKMC/LspfWn8k
 1JuZM8WyFoUSwgAJxGmefjoO6nSJULvK6rJ4rQhjeNT9zou8RletZ9UTF1j5zLZE0LzX
 3+ulwmZVs/bUS+UvrfF9WLO0/xbaPerrkVIdSUqV9BxQApxEcDPCu+N5tLK73vihtS7R
 MjvgkHtvIDOmhURUEoiFqh0MWXKOfbNFlqls92BCXJXVz0Hu7CHhVMtKNjHUKbY+1xhS
 yXP/k8LtNuLoibUz43394xwmgLQbkVrtasHFPAV2HaN2qGIV8wQvJ9MuRNlqDYXQ0zr4
 ZQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780006813; x=1780611613;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veNuRYhgs4KrAydLkx8OQVE0JBYIgppnw37iEjmm/mU=;
 b=SfesOOzYv84dvlDuXmd1/uyl6VdbPzm2T/iHjtraazAiKyHZY4yyIdhHGyz+b+43n5
 8aqEn2oBBUklYnySJRCfe5LzkqFlaX297qUWFHzmCJRs3g1ZNVHqsNGkXlGIrlPUA9HQ
 WId3l0WAkGZKA59AKarAkglV/fFrXG4VNosO7RywnAi+YM2x4e6WNTpFq4XRUGngVUZg
 oPcoSJCcZX+8ie6txyXmc6yqAd0+2K5NJsHa6Knc0IMLrFzejtu9fY8G9JZ/XhbVU6as
 dPsJ/ovJ4RB15e1p9N96QekdtPJ1QEKrz69+3xP8DGq0qLhWJWsFa9AV17H9K338812c
 6m6w==
X-Gm-Message-State: AOJu0YzYSBAW81OqmfRfFMuORdkXerjcH8CGOt2O/b06iiAAKMZ4Ozil
 F973jscAR2NIQM6z5986KbDLIk6J3dLazyX7PGHvV9SFJi15z08hgqiQ4JBVqef1Z4M=
X-Gm-Gg: Acq92OFOuBnIjxpUdY1LN0ti0p8XstSwvRxSqOVN18YDkOLhW3n8lpm0W1T5abyQ8jy
 TJq8hJ3vXe9nIh/Gz5DUV58T19sNw4K+xu9PP22xDz1y+VPZAdHRvhQ0ZXggULLUPD3OG2LotBv
 R+r3I41PgUSjDazkP6aL8AVTC3wLNQWVFyXTY2VPiN1vkNZ3UzikyW2F9ZkMGwGKEpmin8luE/1
 sO5POXeL7wNIqj0p+snBL/x4JHSiFVOwmExkCMDkS5tIR4wFSE+ZB7n8OFCY48HjTHf8CY4YoA+
 QvbKCs11IHWJrE6SBxXSEFmhnamx/9mlUCqdvAnEUX7dcN+SZlLxrDtozdkVHv7kHd/2iiAsoBo
 hS6tcdZoE2JE+wbSlWf22lAi9qHCEDJAyU9mnmvus1tlqlJ1scci1wWsykkxZi8xSjkwH3GNqP1
 9Nixkqr44geVNdYBYm6AfPk6Rdcp5yfAyWlx2hC9FmzI86VZM=
X-Received: by 2002:a05:6a00:8cb:b0:82c:6aee:b21a with SMTP id
 d2e1a72fcca58-84212c02133mr92897b3a.45.1780006812967; 
 Thu, 28 May 2026 15:20:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841f3cbce53sm2637888b3a.3.2026.05.28.15.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 15:20:12 -0700 (PDT)
Message-ID: <ab73ed68-bf97-4587-abaa-96cf97679b5e@linaro.org>
Date: Thu, 28 May 2026 15:20:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] target/arm: add support for MTE4
To: Peter Maydell <peter.maydell@linaro.org>,
 Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
 <CAFEAcA9J0DVUbgKviEjwEN8K0M2aAJTLaOpkndus6HNCPNRH0w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9J0DVUbgKviEjwEN8K0M2aAJTLaOpkndus6HNCPNRH0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/28/26 08:08, Peter Maydell wrote:
> On Mon, 11 May 2026 at 15:01, Gabriel Brookman
> <brookmangabriel@gmail.com> wrote:
>>
>> This series implements ARM's Enhanced Memory Tagging Extension
>> (MTE4). MTE4 implies the presence of several subfeatures:
>> FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
>> FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
>> currently implemented in QEMU. This patch implements all five.
>>
>> Testing:
>>    - Included for FAR and STORE_ONLY.
>>    - The MTE_CANONICAL/NAT test from v2, modified so MTE_CANONICAL is
>>      enabled in user mode (removed from tree in v3).
>>    - A bare-metal testsuite that sets up page tables for S1 and S2
>>      translation, to test the Tagged NoTagAccess fault.
>>    - The bare-metal testsuite also was used to test LDGM and similar
>>      instructions not permitted in user-mode.
>>    - The bare-metal testsuite also was used to test the mtx related
>>      patches.
>>
>> Thanks,
>> Gabriel Brookman
> 
> For me this series causes "make check-tcg" to fail, because the
> "mte-10" test segfaults:
> 
> $ ./build/arm-clang/qemu-aarch64
> ./build/arm-clang/tests/tcg/aarch64-linux-user/mte-10
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped

That's odd.  It works for me, both with gcc and clang.

r~

