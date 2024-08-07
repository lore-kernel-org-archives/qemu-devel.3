Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5649C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 22:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbpbi-0007ZX-KJ; Wed, 07 Aug 2024 18:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbpbh-0007Y6-JE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:58:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbpbf-0001Ky-88
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 18:58:13 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-71871d5e087so216883a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723071488; x=1723676288;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dNtlUwRE0dZsEwVFmBEuRpBpGeatpEHPUj93pPjtvuY=;
 b=eST/a9IpxAgwQrlPvBEmr2gVDIZqSLE33DEqXH5WokVgslymdIyKVDy+twFTMPUF+s
 bPQjzc2WxFjuT+T2NZkm77+z9Hx4wuJdUmVJ5sXFwjEhOZ2u7krEUFLizSmUwoP1vD1q
 PaPvJqGQHALfY+4DoDNwPTAEjNpMfxoUtUvOE9o0s95PWI8/KBm9r7pwGvVl08NZ56vo
 Ows9uijncP12KsjOEsjsS1fBiyqdMlZgNTHB63FUEuCk5ci4RSiavxkBgdw7I5derotq
 1PyQIwUi6BopKEoUh6ZRimr+eXIzA4L8lADZxABgEXqU0KEcaIvPnoS+F4wE8MiHG7M+
 SAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723071488; x=1723676288;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNtlUwRE0dZsEwVFmBEuRpBpGeatpEHPUj93pPjtvuY=;
 b=d8e/0AHG4NStCak65jrS0v6zPTFe5Sot36qoPVTNw+3a1yQxujzvi/SAA6SH5jH4xG
 An5aqbVlX5Tbwe6Fm0XfNhWdFrRuJSVRp0cOc0pbXBoAidfQs8FCv9WVkgwMM6S8Vffo
 dYj2/l2GY63fd782KhnmcoR2ESiJeAV+Dc38tmWXMVoTZVn/phS+0fazwrpQ+YNETCnL
 qx2t6Pvro7scQfVf0CIwAc7fczYze0kHKswwMHBACcv0Cx0NChR4yYdz/IhOycUzpLuP
 OUNHfzbflIGawm5a3NCBxyHcrv0KtlaM/kkw0LUE/AQ2GX7vKDUUs0ecax5ueg6/jXVQ
 Z6HQ==
X-Gm-Message-State: AOJu0Yy52Yc4tUpvwTIHLTe5X38H3GkMv1tYpOD5bBGorenAegypRtb3
 xPb143mwfmZCjc5EIUOSR17y73m53sP3EQ78OfgqgARKPxXOEUta0j53MSvrtT8=
X-Google-Smtp-Source: AGHT+IEhoyEfsFqwSqOg9CxngFExaobGHESvQZ6zRYiVnia/+qGxB8Hs/b3UnFAg15BwjC4/iDBp9w==
X-Received: by 2002:a05:6a20:4387:b0:1c4:d05c:a967 with SMTP id
 adf61e73a8af0-1c69968d112mr25935095637.51.1723071488102; 
 Wed, 07 Aug 2024 15:58:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb2ccf1esm23752b3a.129.2024.08.07.15.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:58:07 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:58:05 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>,
 Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 04/20] target/riscv: save and restore elp state on
 priv transitions
Message-ID: <ZrP7/eYwuc+6OKXQ@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-5-debug@rivosinc.com>
 <e2d6dfe2-0c99-4caa-bba9-ce9b1225d0c4@linaro.org>
 <ZrPU3fwHGV8l0gDT@debug.ba.rivosinc.com>
 <0f68fb8e-9821-4639-a934-ca1f4a668e4c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f68fb8e-9821-4639-a934-ca1f4a668e4c@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 08, 2024 at 08:40:08AM +1000, Richard Henderson wrote:
>On 8/8/24 06:11, Deepak Gupta wrote:
>>>>+    /*
>>>>+     * If forward cfi enabled for new priv, restore elp status
>>>>+     * and clear spelp in mstatus
>>>>+     */
>>>>+    if (cpu_get_fcfien(env)) {
>>>>+        env->elp = get_field(env->mstatus, MSTATUS_SPELP);
>>>>+        env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
>>>>+    }
>>>
>>>The spec is perhaps poorly written here.  I read
>>>
>>> ... if xPP holds the value y, then ELP is set to the value of xPELP if yLPE is 1;
>>> otherwise, it is set to NO_LP_EXPECTED; xPELP is set to NO_LP_EXPECTED.
>>>
>>>as xPELP always being cleared, regardless of yLPE.
>>
>>Yes that's what code above is also doing. restore elp status from SPELP field and clear
>>it at SPELP.
>
>No, my point is that the text doesn't seem to be
>
>  if (enabled) {
>    restore elp
>    clear pelp
>  }
>
>but
>
>  if (enabled) {
>    restore elp
>  }
>  clear pelp
>
>I.e. the clear is unconditional.

hmm. that's right. 
good catch here.

>
>
>r~

