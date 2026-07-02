Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F339C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJxZ-0007yc-Bm; Thu, 02 Jul 2026 12:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfJxV-0007og-PZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:08:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfJxT-0007j9-MG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:08:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84794e800f4so1160288b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783008490; x=1783613290; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QKxsnhjcVMFV4JMHCPhoYgD3v6CKgBAXDYxKElqSy14=;
 b=wcMkciq63TymCVlzGuHjKBpZOOL/W8umvHE+atZqwsHl3qj1Wf4NuMnLM9YHn3Qlsx
 Kj0nBpyShO5fEvioFnHXv/fZ6kjUAE/shH9woWdq1oXDpmQNOE4Bn827Ioi9wSHkHsdW
 D94aJcb4FyowTjPym7y89uve16oGS3kXmRVhoQTavjYXV6DNyOz2DYR1Dlspooj8CccT
 m6In/HvZSvw+5gPrk+ku78ZXJMs7MELo6ASYDTdl3uRKBT848KJcouuNg7AsycORtP8k
 /TDimytV4NUnMBwru5vhSQpQdZPzMT2ZNExd9AXEJ1YusZb1wdJFIMUJJszBGB3vYJll
 HbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008490; x=1783613290;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QKxsnhjcVMFV4JMHCPhoYgD3v6CKgBAXDYxKElqSy14=;
 b=nUcBcQQ/zLBzKDKndzsGeGYfakGZchxCsN5Tbksy95wx/B71bduPTqJMQDy6AzN6GA
 wdKHohEl10dwto/U+I14aR+YbmE6Geh+ZtMX+EyoFKLdqhhiORTHAxRFuuCxcHD+e6Vd
 bgYiBOFlzGViPYxYYSNz8qWxPIdACVvTh3QJADOUNy57S0PjpSxcuq9jVtBRa2VEEiiJ
 envKW3QCnXubtPatBZHq2rne8LQl31xDY9hZbL2Fc7qUSG/9uLkgey1QDyBGk9HR6Xve
 xDsKK6W7wwxJD1HnsjWR51hWX3ZIUAtxrjBJvgUllzMCHXgoGs9rGHxlaicbM2xEBHsd
 S9UA==
X-Forwarded-Encrypted: i=1;
 AHgh+RphbSn9e6uVMvHHbnqr8ml3qZYqTDg2BWwVVJ/I8uNET/mubzYRKZWsR1OcVAYx4m8VZnX259JwtXn7@nongnu.org
X-Gm-Message-State: AOJu0Yypant7on89FbiegPj4I86x0tPWuh6aCjbY40I4eM2vtM6akEjs
 DIReO5El2++hnkQhyUKlU1e03tuwdGKhEmrgn9AiiRjEAXma2fS+qYVm6QNfeSzcrWU=
X-Gm-Gg: AfdE7cl1nGVnabtJBL5YIXRUgNwSs9m7gl0xP737CjA6X4TZErNb9gclpup556WlcS1
 aG4cla7cpmmRRUYalY5oC9Vl1XBfaYfLqyPdM5Ybyqtx7d5p5B+1cGXg6n2pawIpXF7d38lgMaE
 9ww+lkFavqUNgDZ21CCnMFkeCvEaHv4nieLR38O7HWbSkMupVLrbHxpTAeLi9zNJ9yLPvb7SPFP
 3WR6GhpDS8raJwy+MRfZakITMcBcz3JIvzvuJrr+rPZktw/xz2rXDptcqKADpzbN8SQ1QDGfnFW
 /ZS91CbtNWrevP3i7Oea56ejGOAG+xSmdkbiXgLmujXhdsY/MN5AnAsMpf+Hzl+0x2FuaqR554g
 O5EICdPKcGUgp8W4xYRjHvxRVFUSipG/zacG0V3NXYOfw2SNquNgxG8ff64UUcGq7TUFN8xDXC0
 mmmt/MYmAC0p6J7aq7ivYgbi2b5hQt0PZIsuqZkxf8TtxWc57Gij6Sytmu2A==
X-Received: by 2002:a05:6a00:3c8b:b0:845:e9e8:6458 with SMTP id
 d2e1a72fcca58-847c5070008mr6169900b3a.20.1783008489697; 
 Thu, 02 Jul 2026 09:08:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb9f4c67sm1603288b3a.59.2026.07.02.09.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:08:09 -0700 (PDT)
Message-ID: <66d90476-7ed4-44cd-8486-4b022d622f4a@linaro.org>
Date: Thu, 2 Jul 2026 09:08:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] cpu: Constify CPUState::cc (cached CPUClass pointer)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Various CPUState can share the same CPUClass parent,
> and must not update its fields. Protect the CPUClass
> by marking the CPUState pointer const.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h     | 2 +-
>   accel/tcg/cpu-exec.c      | 2 +-
>   accel/tcg/translate-all.c | 3 +--
>   gdbstub/gdbstub.c         | 2 +-
>   4 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

