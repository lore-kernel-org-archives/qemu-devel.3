Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0ABD3EE65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viuYR-0001jr-FG; Thu, 22 Jan 2026 08:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viuYB-0001c9-HY
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:16:47 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viuY7-0005mD-Bn
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:16:37 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-794265fb73bso8976467b3.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 05:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769087793; cv=none;
 d=google.com; s=arc-20240605;
 b=QoIA7Zn6pCYnQapTe0mggjiN6nQZyRWL7K5SDwiuIr1Zf00sbccdRcHPfMxz8qNrk1
 /DH76sLkat1Bf/M6FvwZsjo4SOkL7dY0E+8HfzHbaSHlNtjKRwN2UfezNWWW+vqs2yAX
 DCsQBIm4UJKpm0duGLpTIryRu/ruf+ei0cKWLpZRw4vO5+LIB4v08jcpwVU69H+OhcF+
 5RXkxww/tsf7Eoh8rwSpJErgTMhrROpNOHu29UUg84reWANrseduj4ZmroY7bxz8pmxW
 L7RCrjSSrByKOsxADNSYPOAtOe+j4l/MClVVLfv70xBX67FzHbLJFm/oEcxjlxk8kQ8Y
 xB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3T2gonBDdiMSEwQ+eAWXA/c1umAF3XqunyAE5u1qwqg=;
 fh=jR7LVOBmK1jCkse7+hfFO0RVRlDhN6P9giU4wahz+Vw=;
 b=HXnyFV6qiTt7xJMNcLt4XOodgoV1URIme2DY/8PbLa04JfLTgzfSe8taJhJWRZlaOv
 FK07CWQzJUOsSQw+euf7mZ5QVIe94oheByBsVCl/cBQPFKEKNvAGJEMUClgSiiLruUR8
 vPgc6hx+vXN86roJTfaDv+CwnJ7Gdxbj5JFJizNwPHfxzd16+w/94ZerVmG/QRg1NApS
 wj7ZpuScacNvwlJ7qb/3m9JeXfQWvsu6c5ppAOlOLUuwXCUXGDGYgxkP6NxO3dsvbusM
 LpUjpAJWmXKkjWnjCL6TNAJEirjS/YbSeasFFrbo4VdWqiePznyIisNaH/yWPylG6e/f
 O7FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769087793; x=1769692593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3T2gonBDdiMSEwQ+eAWXA/c1umAF3XqunyAE5u1qwqg=;
 b=godQ8tluUCsr2jOd3lyyWVxmavFaeGQsgISWhNmSSHF92QlK7mCYHalGZmzdnqaUAp
 6g9itoAQ/4bF2jGWbn4bbPHAf2fNx76z3iGxLXerrMaJjLgC5RCIDWpa4e6ugpYi05O5
 k+33ja8XXTDAkHA1INgZaXLt8lVsKjQjSECRhwaYXfc+pTCXQnOhH5YwPcJApsNg5hZo
 k99GXKcULK4smNB9/Ev110abNSeVP8W9i72QlQ+YPNmXwlodxEtSs7mr0GUPNzTSr2VF
 j9UsFo3Lw9ff2Jm1Xu41GzHOX3DLlhU4tNqW5wfcx7bdNqP100GTxgO8ufoXVosLxTxj
 EXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769087793; x=1769692593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3T2gonBDdiMSEwQ+eAWXA/c1umAF3XqunyAE5u1qwqg=;
 b=U+ekVZJwZJSC7ACufhODvqaSjcAStrt32RLwXxxEzpmGLLQ/SP4HAAXdtHIoISC7VZ
 rR3tZUmrs5bPAWrJR5hCjujI3fZSR6A5/ClincJQL8WXIw+2o55CFDHEiiW2555UHcCq
 NhquDjk0o8ulzjFEicpu3ENB0+sW6hQ+wtqEc1dFMV/Ax0SJYPAUmFwYOMm9VPtyMGIG
 fQBk3f/HdLMzPcMzdw2MCjO7LLVKWNmVfOqmj9w2/VUSq6cT9r//ubmF31jSfHiVrWhi
 BY1hjV94KaxlphH0fCvpFQERdPUDDKp/ML+M+hoXOh8q8Ix02dtjBCS8DTzf76o1R99O
 ykdQ==
X-Gm-Message-State: AOJu0YzzaJ5XEwFfx+wtaEuiHgENrCMCFxqY10PMtjdBIr9OaiM7h1c3
 6Pv/a+GN/2J7r9TdDvyCYXb48mWp7XNUetwxfptzwG80IkKNKVQtavFdNO7yLDnTg666KBxt8+n
 t+r37w6revkSP4H8zKcWM2UFpFHPZigSbhBFyIEHI1+xFpKC4z1JP
X-Gm-Gg: AZuq6aIQHYsdtupZEKQ2dBiPGzpjFZ8naYPAtYSsqSu5MGL76ZbAdxvym02nyKosHax
 BJ25Y797XoiISjuyP9mnJkhQRQHgd20Vx0PeC9FRrS2x8l7YrCyEo+yjcvcZqSz4hSLoc6dRULR
 +b1qEFGrINhNU5tKFP2yplFf4ord8CmUhp76WN1q/JRvX7Yb/oOuTPcmPW6EAzCMd2ztcQztGd8
 jNVbTXgJWEvgTEL+Uz+NokB6aAEmOr0yz6xC7LI1i2iOm0PJF6XCZS9KLIJJ9dJOg36MFdzHyuu
 crHk
X-Received: by 2002:a05:690c:6d91:b0:78f:a5c4:7923 with SMTP id
 00721157ae682-793c683b02dmr154574197b3.56.1769087792913; Thu, 22 Jan 2026
 05:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-7-pbonzini@redhat.com>
In-Reply-To: <20251227094759.35658-7-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 13:16:20 +0000
X-Gm-Features: AZwV_QidkpDWzjezVOlwT7gSUe9fz8EOfdYaIKBn5tt8t40m8GBPF-ssgUO8cY0
Message-ID: <CAFEAcA8fjzx49c=Xe37PtMNCbN22h2UQ48kzPgWVYx6jBBXYog@mail.gmail.com>
Subject: Re: [PULL 081/153] i386/cpu: Fix supervisor xstate initialization
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Farrah Chen <farrah.chen@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 27 Dec 2025 at 09:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Chao Gao <chao.gao@intel.com>
>
> Arch lbr is a supervisor xstate, but its area is not covered in
> x86_cpu_init_xsave().
>
> Fix it by checking supported xss bitmap.
>
> In addition, drop the (uint64_t) type casts for supported_xcr0 since
> x86_cpu_get_supported_feature_word() returns uint64_t so that the cast
> is not needed. Then ensure line length is within 90 characters.
>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Link: https://lore.kernel.org/r/20251211060801.3600039-10-zhao1.liu@intel.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Hi: Coverity reports a possible issue with this change
(CID 1643918):

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5ba4d49dc35..e9ef8b992fd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9711,20 +9711,23 @@ static void x86_cpu_post_initfn(Object *obj)
>  static void x86_cpu_init_xsave(void)
>  {
>      static bool first = true;
> -    uint64_t supported_xcr0;
> +    uint64_t supported_xcr0, supported_xss;
>      int i;
>
>      if (first) {
>          first = false;
>
>          supported_xcr0 =
> -            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32 |
>              x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
> +        supported_xss =
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_HI) << 32 |
> +            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XSS_LO);

x86_cpu_get_supported_feature_word() returns a 64 bit value
which may have bits set in the top half (notably it returns
~0 for some cases), but the shift by 32 throws away those
top bits, so Coverity complains about a possible overflow.

Is this an actual problem, or a "can't-happen" false positive?

>
>          for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
>              ExtSaveArea *esa = &x86_ext_save_areas[i];
>
> -            if (!(supported_xcr0 & (1 << i))) {
> +            if (!((supported_xcr0 | supported_xss) & (1 << i))) {
>                  esa->size = 0;
>              }
>          }

thanks
-- PMM

