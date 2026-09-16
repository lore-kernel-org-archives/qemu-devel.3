Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CD6C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nTs-0000aW-LF; Wed, 16 Sep 2026 07:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nTq-0000ZU-NK
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:07:10 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nTo-00069g-U1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:07:10 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae7166ebso567051eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789556827; x=1790161627; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B+AAuQHhshwDlZxaFmjZzsHHVJtMkRTUcP4WlOdXwns=;
 b=fzSBT8qLc4YkooSR4zT48PJlT2MdCArQpeq4VftLL3cY3s7/Ooa1IHsqvtRuA9SRP+
 4UedWy6LGSAhlfrI5LvuhiOZKT9l7y13KqrTgKHs2ADFhIGtRm2mcQBksHKOvdIPOP64
 C2K6nSwbBrV65lxV5GbC2n4JKKOFUoEMPzvxIM6Sd1kzL/s7eOzItdGHOIQdNeZVCJU2
 zEF89cjC2qLXZA5E4Id2e3EmYDLlZtU82+r4NC70aoDkJQvK5on30U1phx9nZeVSG6ZM
 GhsgtCVennQwfsyrVudUw0ELFibPiayaGCo5naHfXhEt7j2c7UE/lXAPKnfox9qU9oje
 OQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789556827; x=1790161627;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B+AAuQHhshwDlZxaFmjZzsHHVJtMkRTUcP4WlOdXwns=;
 b=smO+uwgmZ1ugOepZA3QXEfDEMy4iwjx3HRqupRsRh+c7TEV6Mr4jfxqozLerTiOw5f
 KUdU3RH0zcT6Jm/rRqqy0o5WwEKDaSGZWbA8EKTJmNO+QizMMCQJ9lllH4lbK6z121db
 v946mI1IzUOLLFdARw+cwBiLGVgh3nRAutbzi0m3cjI9fZHfUsepozCUQZLj+oAOg62f
 RiT+plXI8zuazEQ22BGcMkPM4VZKABVmI3wfgStuA8GOsOzDQSDPqgT2EKkkj7UVaFeD
 Fx8LDUE3e9hQ2DY/HoseBIBuuoipAX8SJLi+pXKFMpl2Jxv3/8owJPFgA6Qd/DGXo+AN
 pSJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXM7QAQuvvWDYDMjyqjR+1nFpP869JylHnG0q5EmOLfvufJXRYVGCBKeDiSxlzINtiaV8orSYfCykV@nongnu.org
X-Gm-Message-State: AFuF++lL54FQkJyjlH5p3DnazcxfYCye5kiV8XWTPmQoQ/Fwprv8+vXe
 AF496IAN2aE2GYGBnPOkvvxShpiBsULm9C7JWZbfvqObXbA3pFOCydH01JR6STubZ2g=
X-Gm-Gg: AYBFou03D5o2TJkSbezd4Ig2Buo36ih0PUGHKU6qpj+OaDk4drcMWcNgqNX8i4d8c9O
 FqlZdjkkR4rJD+UOeBIuQGE9ECBSjNRieFjAvnZViTpk9K1KZQuF6p1CrFL7rGfX84DWnHpoDpf
 KA1Chfrv+1DkmL/hxz8Fa1+M05XCI69yX0bw2Mz3ejADX0L39c9d8g/XNiu9yCO3RLzTaJfrsUK
 xFRqmSxbQNAq4m7FnRTp2NSEPU+VTN6rfLH9ff7cDxw3w7CJlprMhv1LTRx3lrB5dS9vOX8p2UD
 y9Zv+IAPPEv8d2k3K3Icav+UJFcZXNOG/JgFEqKWii+ew829KFwDwc5ZKMejMvQHApfXi1Tcrhb
 jjXeEeTu8W2OoD/MZ5RCljLO22nq1I7r2Ccl/VTj4yIEbX+VaNVcdu3cHd1pC/X7YZ5uAlohAkE
 vCoh+dPi6inmi7IJCApoWqjapPhJwYhkRCqhTaT9spIk2s9QcHJPTAJ0t1uFvAYrq/JapSsWGQ8
 NTKPa6OKo7Sodwf++4BH60m/I+B/WBt+ut7MKEMcmgsEFdwle2nUpLtJq5XoFA=
X-Received: by 2002:a05:6820:1612:b0:6be:7782:5a61 with SMTP id
 006d021491bc7-6c7d3cef072mr2240300eaf.48.1789556827241; 
 Wed, 16 Sep 2026 04:07:07 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7032819eec.30.2026.09.16.04.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 04:07:06 -0700 (PDT)
Message-ID: <632dac13-9040-43d1-ae2d-1e666135120a@linaro.org>
Date: Wed, 16 Sep 2026 01:07:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] accel/tcg: skip the can_do_io stores in user-only
 builds
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
 <20260901034808.3524945-4-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901034808.3524945-4-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/31/26 17:48, Matt Turner wrote:
> Every translation block stores to cpu->neg.can_do_io twice: false before
> the first instruction, true before the last one. Nothing reads it in a
> user-only build. There is no memory-mapped I/O in linux-user, and every
> reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
> tcg-accel-ops-icount.c.
> 
> Two stores per TB is not much on its own, but TBs are short. An emulated
> alpha gcc 16.2.0 compiling the SQLite 3.45.1 amalgamation (255k lines,
> -O2) executes 34.2 billion TBs at 6.04 guest instructions each, so this is
> 68 billion stores for nothing.
> 
> Measured on an x86-64 host, LTO build, on top of the preceding two
> patches:
> 
>      before: 1,469,772,951,575 instructions
>      after:  1,402,667,803,616 instructions   -4.57%
> 
>      before: 121.04s wall clock
>      after:  115.56s wall clock              -4.53%
> 
> The emulated compiler produces byte-identical output.
> 
> v3: Use #ifndef CONFIG_USER_ONLY again rather than
>      if (IS_ENABLED(CONFIG_USER_ONLY)). QEMU's IS_ENABLED() is IS_EMPTY(),
>      which is only true for a symbol Meson defines empty; CONFIG_USER_ONLY
>      is defined as 1, so the test was always false and v2 emitted the two
>      stores after all. The measurements above are from the working form.
> 
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   accel/tcg/translator.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Cherry-picked this to tcg-next.


r~

