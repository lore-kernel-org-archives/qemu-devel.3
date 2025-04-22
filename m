Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE44FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77R5-0006JW-RR; Tue, 22 Apr 2025 02:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Qw-0006IV-PR
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:48:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Qt-0008Pd-UE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:48:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso3355141f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304517; x=1745909317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnXZYZpCsMlxjMJ0yI/E0kE04njeYYS2BakI6UaObjE=;
 b=zEvhTst2TZCs4iERzpKwWdQpitUp539B7XiJqDP1gN7CaZemQw9EVrEl8FpEO86g1Z
 OK5YfY5G/Mg/VuhRJLik/YCeHHkh+fFA/F4UWxs/ylIy7J4r+t7RsPX97e7UCaQ/kQsl
 KrKRxK/WdH3P/RalznRY9N0DyIXuSOQy2r/qWvb3p9JibBAqSciCjlIvtH4/ofJ8wRqX
 qJzSp4MMEQKJ5oKpzyaosL9oxAftU74HbzsQP6zPVGVb2nOD7b+OiQjjwJXhVq4lJ3dR
 9nzH72wIKu6lisuauCi2gA4Gq257Ajy4nrKYFlzHJK1fdd4ms1uCXOqnTQDSsLVbIJfU
 sFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304517; x=1745909317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnXZYZpCsMlxjMJ0yI/E0kE04njeYYS2BakI6UaObjE=;
 b=rVW3xfYqUwyImAYyb/4aTtxDRmqNl871JBK8jcqWV0szAnfZWckqYJv6HzSBR+Ew22
 wxCVPr8qywUiDbk4NBNgAqGfX1JIKeHJNd4WVgsOXWwzMkvjm5ciZV6sUpQm6Q6bvyj3
 LxgOTVXpHJQDTWJZZv13XeWES4FWwWxq2ZVWelrg6NH8cVcllu+vgnG/PmIrUul+iF1i
 Cps8uTgy+FqlX7/dEdogfGadhP+JAlPyHJBYrhvdDTTUni07ug5fc9pX8D+JsCrpCJP4
 iaJCOl7iFBRWn4BnzJDBtLMU5l3kqxbnrlb/5/7dLfm9i7p4BaDt4g9WP/ALZv1u2C1C
 GBpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSRn+rXhMRJKPpdbP7hUOlBR1v156Odqgyxqv7UZ0ewaSxRibS+ySo4l56xSZ+DOrVvaUdJ9TPZPK+@nongnu.org
X-Gm-Message-State: AOJu0YwJeL9OI1XF5wAC2KgoaS2X++yMNxePVRS7ik5bJh4jsrkOS007
 Nm1z5s75cElJ+acM5j0PeQV2UfJnT+MPUfhi/H1ItRouh87HgMGmDBEo82I1oXk=
X-Gm-Gg: ASbGncuA/M4XOAD6GCDEX3FB9ryKpQJyk9amERBYDZriZp/E4ZlpN0NFISSiQb3XAl5
 H5L8KmlhQfa2VWKPDsUPtvwYfmmZeHed4Qk7+62MIDepRz083XN+kSbhuucKWyrfz3bZRJfvI5l
 TtZHYXZ8UexktapVDur/quR86x6BveJdhN7IxRcK6G9aRdYr6e2iAdCbkC5FALEk20sUFQ3dHHm
 QPqn68thmnlHww6ctWciHAdN4GuAlaP7YsQwl7vFwbu0M1SqkUJdsC/cio7HhYyifRUSix54rZE
 b4F/JACklQdwAny0G6/NFKFyBZeZ6pg7B1AmHA4wnvOfHOjUePx218bBMQIv/5gF1YKu+rBnAc4
 9Y7GxjUdJ
X-Google-Smtp-Source: AGHT+IHMpt6hktBQcp63unlBelOTUarNTXCE5b0mE/3wPmn6HjNsKZhrJ6P4Ob4YbC3B5cCFDHXW/w==
X-Received: by 2002:a05:6000:2913:b0:39e:f641:c43 with SMTP id
 ffacd0b85a97d-39efbaf689bmr10720478f8f.53.1745304516970; 
 Mon, 21 Apr 2025 23:48:36 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa420683sm14169010f8f.20.2025.04.21.23.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:48:36 -0700 (PDT)
Message-ID: <e163300b-307f-46d9-9bf3-10f17c998e78@linaro.org>
Date: Tue, 22 Apr 2025 08:48:34 +0200
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
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Note, you mix LLVM error ...

> 
> To resolve this, this commit removes the call to __builtin___clear_cache for
> Emscripten build.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache

... with this GCC documentation:

   If the target does not require instruction cache flushes,
   __builtin___clear_cache has no effect.

I'd expect __builtin___clear_cache() to be OK, having no effect on a GCC
WASM implementation.

> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   include/qemu/cacheflush.h | 7 +++++++
>   util/cacheflush.c         | 4 ++++
>   2 files changed, 11 insertions(+)


