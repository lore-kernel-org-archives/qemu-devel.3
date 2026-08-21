Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBCEC5DF97
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSJF-0006QK-2s; Fri, 21 Aug 2026 12:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxSJ2-0006Mb-6c
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:41:25 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxSJ0-0008UL-EK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:41:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso924258b3a.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787330480; x=1787935280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o5Px8COhkGLvlJ0eaDBwZqzFKsB9CXZit19dsF07AGc=;
 b=aQahwhY70torV5LD6vkWzGoEvJhaHj2zqXfV3W+7Mxlm8BQFVMRPVq+PSv5UgwlBhf
 hTjYUpLLLXNeO5DHycDi/xPeqO4iDiwN78jLf+RvcFsgEQS372fS/ZWBGd8f+pvXWkjS
 Tw9yYuD+acloUX5GtH/xAeI2csUmwXSvopCz25ooB21JP0MkySY3hg6nzZF7Wy/cIFbF
 Iq2cRnhw7tYiIA9IOAePpZn9vgYH9Sxuv9ZmZWomj0aam3/oP3lQO/pauN2yXpSGk8e8
 dmn2YPtQP4BWunOcR2qcvfBZN7JvCrU3vCuBkVdj4Qzqu3WFukWnoRMDZdZZuF9gQOsC
 5aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330480; x=1787935280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o5Px8COhkGLvlJ0eaDBwZqzFKsB9CXZit19dsF07AGc=;
 b=G6D9vHxo6vMRORHGwmO3iZqESJ/roAbyKe7LOYLVpK/EHEUllQPalFt5ok1A5kKdqO
 JXqte9QgfkZt3UhMd9/oWGrVoVULPy/XEdrao7T+PQXzqnp79MOs8Zd4EzWpPLy3DfL7
 U9Vdztao7uRqMVMNt0tSsA5bx7on9YgoBtnmg6MXI8M2beWyFVvLpd2CQPkw+X6dNBPj
 4lZh4Lqgsq7SpisI2k5byjSkb9iUlnUBxbTR0OHJ4lEupudHcjB5uf5x9s7bEGGTnT5d
 GNHV2iycR4gzhrJ24jbu8yaJZ9X1vFX8gLrr3/Ll72BHmWUOGze9Ic/cxy18Ej5zvp91
 wymA==
X-Forwarded-Encrypted: i=1;
 AHgh+RreyCG4jsp43canj+6J4w329rak5HhCEeo0E4FBoXiF8Zlur2v8gFROWHz6enC0dGwlKctTcFnrwSdA@nongnu.org
X-Gm-Message-State: AFuF++m2MrhfRYi7COtGHByPriIQ5rwnFUA1C1biaN9mCcE7AjmmAP/V
 niZwZeOLY3EiHp9BKFmQt470Ty7QI7OEyap0oPuM467CMeWq266y2ntjrWCY9lmrcjc=
X-Gm-Gg: AR+sD10oLnCQzJ1HwSKQF5z2o5hHIb4xkn/zt9L1SnKqt4LVMSCs1H5XKM9iPtEnS6N
 cRH/Un7vICjmybplChIbH+fWGp168OvLOn7NOy15fWNHtVuEljxyMt4LOvmF5r4LEG68TFTQTTS
 M8wY6n4GtpULT4bbKVGW+U4G2ltfN5w8UI0hcXV5p2PpcIk+fk51ERfAbKYHUXI48PyT4mZn3SI
 JtX8hmqx8ojdNI+oXR/G36mPnclMP0EY/eFluV34bGv3gsRZSQLxvMbq6FZ/67e2twSWeVCqW6k
 r/yCBsVSsYwDVgTUTqzIa751QlxNdvHMHFcfbX3TG4lBErTu3dsm4wOPmCKJF/TyFZ3B9bTxKrP
 JByuWshDCLeXKRUDM96SqdWWL45GzN06C+Rm5JIr3o5V7Xt6kQ+TsO8/CbrisAA4uontbYsmDeN
 rNgOBnvLgamUz+CLeQ79mV3OACH7sg+rh/xKg4S/McqiNOMO6YqSNdalID8qfC8XK8SFzS1ZApT
 T4bqw6ArPGbTaM=
X-Received: by 2002:a05:6a00:4c98:b0:851:8baf:5b29 with SMTP id
 d2e1a72fcca58-851f9f7c38emr13055634b3a.10.1787330480361; 
 Fri, 21 Aug 2026 09:41:20 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3362b34sm3183343b3a.6.2026.08.21.09.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:41:19 -0700 (PDT)
Message-ID: <82632207-7db4-4c37-8ad1-84694e578d4f@linaro.org>
Date: Fri, 21 Aug 2026 09:41:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] system/cpus: Constify various CPUState arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
 <20260821104950.32108-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821104950.32108-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/21/26 03:49, Philippe Mathieu-Daudé wrote:
> Mark the CPUState structure const when it is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h | 4 ++--
>   include/system/cpus.h | 4 ++--
>   system/cpus.c         | 6 +++---
>   3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

