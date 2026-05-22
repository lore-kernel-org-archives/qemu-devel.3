Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B3BCD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVsp-0004Pa-33; Fri, 22 May 2026 15:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQVsd-0004Ma-JU
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:50:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQVsb-0000Pd-Mc
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:49:59 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso6348333b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779479396; x=1780084196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IU2Z/7Mtw1iAPnCRPkdDT6nCxsp+1JhA++ESgoadG5E=;
 b=qIUf7Z+95g1DxXzk0uvtMx7OGkWwqYbOA0oT7D7a2ri31RH3WrY8v9naICRXTeCrMp
 TzQSIrJkZ6Zpnjm4aUgQzA7f6Yio+pfyV7TJOAQnWrbQiEpoA91emGkvUBbTzADzFFOV
 F2xMKz98nNdvgpMlIzERG/AxKS8XHiP0j5N+/cqRZL8mUVZAAB0Ebwo6y/4/vKPhkUlF
 yMo7wVgUIO1ecOeFfiytbJAEY+tP6FyAvTReZePcai54JcJDqHwAxFLAcCT33dlwjp7K
 uBM57VcBb/k6CfCXagmiDRRNJXGSM5cHDxdAYPqhmomP5Zo5Q3Hb7d6Xoy+yH7fRawz3
 kiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479396; x=1780084196;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IU2Z/7Mtw1iAPnCRPkdDT6nCxsp+1JhA++ESgoadG5E=;
 b=OkeDoHoMndJ7OVYrDqqDcTp9ssT+0GbqsBd305jk5P7TT/Yiz4RC2LEZ7Z7O8Erm+q
 mzuk2yrVwH4nSDwyv+CjSRXpP6PbK4rQsX/nUmmeqi5bYtrfQONn9XEdLRvpVQKcsXLu
 03s6MCM3O07wMlsYX2n6pZm/BtDLVtrMkqsoB3mQiGNUwM/+I+PtzobvVyw68WkiJ0wd
 6/4hmQAIUgCjHp/PMm3kk2L0fC7XjF6rTZKyZq209U97XAqOUR9ryNB9uPyQdYK6HA/l
 dUr6E+yo48FRYlOXiV3/q1j7TBdnLKSXIs/IsNSL5p8+9UTeweEROv8+IhBpCjYgczAQ
 plXQ==
X-Gm-Message-State: AOJu0YzKqAFf5EkTWP4Bc4u4VwypdgKKbtfZX6stGDz1vXFLumlDf6hp
 NeO/66Rwj8J1W/dCck7DjcgiRm5ZFxPo9WUbl5Hcb5w78sDvVFAR2zOTg3HfJkoa0v8=
X-Gm-Gg: Acq92OEkpIsqB0DdccyqJi5GbHBgDOe1BfONncX4RXCePqBRGj0zUnCEoS41CDtmJO8
 L+YsQBPwc6CjXIyXsSKWF+9d06VHgzUtSoeXNOvLcrAcTcI/N1hpO8MQXv5spju58BX5yQS0QGg
 dkIYkz/Asotq+yETJAMEag6WRGza/NYmxCVYv38GC83/qGKCa0kfZkKS8njRf/D9TFrEBXcEMNO
 Du9+rdIG/7Nsd4DZ8ZpO409ZUOIQ8+AkdDNDE61sGhKEfFhhl6PLlw+VpAYXmrwfmD6fK16/hJe
 6iprUPx7JASBCdmdZ/ENhWsf4VT1/zzAdKCiJXTo7kg2L9lC6pxTN0/KhCQg17801MnVwBv0Pd0
 RFZghe2FrU+Rx5kuX3x3aTJu61ClcKB2N4ouO6Y0KiP+RvdmP2ZotacH2Nu6JrnO0CIgoitus71
 z4RvnsiaJKmNcxmNKcV8/B362ca+zA2+v9LlIf/Q9apg2JZfEzziQ=
X-Received: by 2002:a05:6a00:a8c:b0:82f:2a78:6302 with SMTP id
 d2e1a72fcca58-8415f32dbdamr5154810b3a.26.1779479395589; 
 Fri, 22 May 2026 12:49:55 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84165003369sm3065340b3a.57.2026.05.22.12.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 12:49:55 -0700 (PDT)
Message-ID: <b9bc5136-41e9-4f21-8410-f53b6df3a763@linaro.org>
Date: Fri, 22 May 2026 12:49:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/64] target/arm: Set e4m3_nan_is_snan
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-24-richard.henderson@linaro.org>
 <CAFEAcA-KvaC0BVDFm6WPaGRLwHYVxF8UnPUa6SLK7utYJc8RXA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-KvaC0BVDFm6WPaGRLwHYVxF8UnPUa6SLK7utYJc8RXA@mail.gmail.com>
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

On 5/21/26 08:12, Peter Maydell wrote:
> /*
>   * Fully initialize an fp_status to the usual Arm
>   * behaviours. If you want the AH=1 choices you can
>   * call arm_set_ah_fp_behaviours() afterwards.
>   */
> arm_init_fp_status(float_status *s);
> 
> and have the implementation be
>     *s = (float_status){};
>     arm_set_default_fp_behaviours(s);
>     set_float_e4m3_nan_is_snan(true, s);
>     /* We want 0 for all other settings */
> 
> ?
> 
> Then reset can do
>      for (int i = 0; i < FPST_COUNT; i++) {
>          arm_init_fp_status(&env->vfp.fp_status[i]);
>      }
>      set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
>      set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
>      set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
>      set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
>      set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
>      set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
>      arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
>      set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
>      set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
>      arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);

I've created arm_init_fp_status, local to cpu.c, and which incorporates this mess too.  I 
think it's a bit clearer to read.

Setting the e4m3 knob happens in arm_init_fp_status in a separate patch.

> and the code we want to add for fp8 can init its local
> fp_status by calling arm_init_fp_status.

I wonder about that.  I'm happy to keep copying so far...


r~

