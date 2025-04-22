Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D35C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77M2-0003df-Cb; Tue, 22 Apr 2025 02:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Lh-0003ZJ-RP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:43:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Ld-0007vo-C0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:43:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so4299416f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304192; x=1745908992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AX7kKboruwAu8J9cxBWEtuts3z3qq+WSvcjIXuA4QTY=;
 b=rKr9IiGKXbSTTDxUQzeuVZomxCbPDmQWHkgVOJo3iDadSfkqWz5BtQOCqIDtL2VFsA
 jr6vSVgpqz7nar6y9f4dHJ40Ds60acACsO+axMjxOFxl7jqVnNaghsrJbJPyH9dl0U0L
 VdjIFGK/Sd+QtZHIZKIU+NqIpXZVLLCZZqDiHY4Bmma0TkXlRdL9VTPelRbKUufsEvJ0
 PFTcK7bkukeIkaK5iN9q+nviN7B90MC2oLaquR8vPaSbMKFDMQa9FbAkrihzlgX1NSoN
 TEnMaO/P/m4KmAgMsV+gPFymDi9wFBQIntVrP9mNzf9ySVx77LUtLvbaHStaz8Vizguj
 adPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304192; x=1745908992;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AX7kKboruwAu8J9cxBWEtuts3z3qq+WSvcjIXuA4QTY=;
 b=cSKGoy5vqEA2pwwEol2/L1Y8l13S8Vaciada1QLgq6szGT4sKoCtpzjXm84vRjQjva
 N9NGLdLTz5cpMN15ee1mn0GHzqdy7m8lruKX7LtHooYQWtr59AIOFuT/1h3WXwOpcFfu
 w/qOOdHruTeVp+3COc6wjAXvI7EloBU4bWrt7Vzgf78xQeEANM71Ku0BTFtGpWq2UMOf
 5j79/xsWqypL5Toruu7IZBzl/vk3m7c20VdQE1s8K0UfmDrk+8YB8H76jPd3Z/brNVtZ
 LTMkPzQNdkNltRoo8eUxwq5ErxKNXhKeDkbKsnPoX3r0sA8eOenhyK+UGijx2IObr9LQ
 Xk+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnNTVjBPjcFtB5XRllC1ujCzaZHcgm0r4uTPeiajg28S0tKCOSlViMIXY4c3uzBSVao58kFZK9JhQE@nongnu.org
X-Gm-Message-State: AOJu0YwqMfNy/qVd7+UaIR5Vg12euaj41XMPayW0b8elRKNJxJWIkl3Y
 NUTHHhzCGkSqd13kjHknc0B+L063fOS6cVnHXLjaXcP9paP2jRqS1ibp6SSYdolWcBexud2SlEg
 w
X-Gm-Gg: ASbGncu65lPl9+APWJGsM7ZCPJijhPy6Zr7PxlPo7/Lsv9JDHL/JcQJkmnYEjgjlkWa
 bw+fgkjVvZwRlJHN4OYPSy/sW2wqsJtyhmW4cXiWJDk4F4mYcrr7iQsvrp2INdxddEnkTcLLwi3
 sbMpdclJHPNFxKogkERL2Ytrss54WugWr3VYsNm9CXkocIUXpC/FgUTrnbv+Rm6BfPLnCoKsKME
 /8HEWEQ1AE8BRS7/2TyNEdgAFvIUPK9y0OgVveUz8gzP9C5d0SZIeYy2ZuZXqWXy2jCU2vPRe2x
 +XYOn/mlM0Vy+Th2XpVaTBRiL3bVtP48qPg1nIxzzQVISp+OqWdUdIRg1OGkU4px7zjy4FFkK+r
 UGeolsiTN
X-Google-Smtp-Source: AGHT+IEepHdK7IYO8HBEjYBhodRfYRb2HZU7yu/DSYXhUmsEh2yoLRvCtz06id9IG8c95DaH3egeUQ==
X-Received: by 2002:a05:6000:40dc:b0:39c:30cd:352c with SMTP id
 ffacd0b85a97d-39efba383bbmr9963080f8f.8.1745304191777; 
 Mon, 21 Apr 2025 23:43:11 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9e38sm164703545e9.2.2025.04.21.23.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:43:11 -0700 (PDT)
Message-ID: <a0579d5c-8a96-42e7-ac4c-37cd65b4148f@linaro.org>
Date: Tue, 22 Apr 2025 08:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] util/cacheflush.c: Update cache flushing
 mechanism for Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <73301cc216217d5c3e0d7acdd32482e36f4f045c.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <73301cc216217d5c3e0d7acdd32482e36f4f045c.1745295397.git.ktokunaga.mail@gmail.com>
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> Although __builtin___clear_cache is used to flush the instruction cache for
> a specified memory region[1], this operation doesn't apply to wasm, as its
> memory isn't executable. Moreover, Emscripten does not support this builtin
> and fails to compile it with the following error.
> 
>> fatal error: error in backend: llvm.clear_cache is not supported on wasm
> 
> To resolve this, this commit removes the call to __builtin___clear_cache for
> Emscripten build.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   include/qemu/cacheflush.h | 7 +++++++
>   util/cacheflush.c         | 4 ++++
>   2 files changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


