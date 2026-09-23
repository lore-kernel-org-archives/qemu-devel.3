Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA1AC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SHh-0005VU-4I; Wed, 23 Sep 2026 15:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SHP-0005Fw-29
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:05:22 -0400
Received: from mail-pj2-x20.google.com ([2607:f8b0:4864:39::20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SHM-0004QM-5n
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:05:18 -0400
Received: by mail-pj2-x20.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso5329365ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790190314; x=1790795114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nmW9VM2/bPkRtZjUhxbmpOA5bBl5cxzt2jdW1QRycgk=;
 b=oj5xTSXb+IL0Goy8+7SzwTISMLjydeUap4/jR8kNqKR5OJC0beF4UazIQpUqA5NfXe
 gzJcl7tzBOTNMT3ZiAH/8uzVp91FqQEN2jEPQbu0ZW0Sit9VphvnCd1ZvHPaii2czPKi
 2SCIebNNKOjbnM/yMDE+tPLk4egBQn/XbPyBi0DVfcv/35VhLPXJ07cfYc7Q0boKlO28
 CcK3p4bcxRMWnxvvqbt8AUO/o+4Oy1DMLOvBANMmiX3wtjGAak3Aww3Ku1vB3F3tKOjy
 oZ/KnV7uDkONzJeiWD/vKLsBGNEJC9foEVbpsau9H9yfevmxpZEztfUO+7LA6wD9uRNy
 z8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790190314; x=1790795114;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmW9VM2/bPkRtZjUhxbmpOA5bBl5cxzt2jdW1QRycgk=;
 b=Cncw+CpBjzpgu2y8wU4kempSFq+2++hmialV/53TnqTxielEbfAfrFVe6PZhUt/xsU
 4u0jBYWC0w1VId3jU3fus9VGaa609Sm4UGvg5y0FNXphJE521miR3MiVOBfXUFLJKgqV
 DBsqCIrAV/VUjjRRZ2A2envJP4GYGZP3ogE5vhZSUzRtDbzPgqBQfRZxDWxIriMvdFra
 UFcEKRTkZ7OluzhtxURfnf5SkMpJFZ+FcXKFf0qn8wEuChmdSu5W2YnOJD2VwIVVzwJ0
 yftzqlvNkitgOZZD2Nd3Di/3bXfLFoeWU82JBIfQxOgc3WvKEzieTofJYsz7cEHcdsag
 LBpA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhI8zHvC8vadh5nq8iYlE65hPH4TxThc4d6MZ1bZfGXyNbWiQnx/WKM7UTFgzV8Qq+xEQNnyBvDFmw@nongnu.org
X-Gm-Message-State: AFuF++k3exPT6jrMC6lyIufy9U9rP+ciLxkGPNTVc7nym4sFSIGQ2M0Z
 leS93sNTATv+y2anQ8TVFK4lCoH2RbCwrSC1L2wtHzWdanXOEmp8es5quG8beEXOHdQ=
X-Gm-Gg: AYBFou0zGL5rwCTTrH0mUxQCM2yEWuA4NOE70dwpH+v9CWOJ84nSVePAE9SAZ6FjkFW
 za2eTCtGtyzBs6NuZdhbrDYt64Ry++7V6dS2uzo7TbJnMhWg+vebL3Hc/nnKhfEUoWb4hRDJW54
 O0diQkquLjRhniX0mXNuaX2gPRqv/7uSIVwQt+bLMutCuktI6h7ByoOeo5BcoW6quWhnL1ocXU6
 5nNUlU/EL+w2dtzpN04npUdf7Uu4qEXl2PbaRnA0OyqKZfFoEsdjZwnECbwZhgoFgU0gjwygibr
 ip5RFHy5dxEs2aY3B2hH8zlkclfBESrANlrvQo6YIrmfln5XU0rjXwESHWsOOQyr8zrhXPc9mS3
 qqd1FhJoxuGNjLrkvo+Toy9b6rTmT4nNCCXItEdpplFtR16S+8DRTJ/HMtXDApqRwVLBYRt487u
 gVnBFUsSFmnmmGYDwR7fZ+HORUhDM7Ltmu1odm8e1MGm2Z4p+1UZ60C883Q6sGjrX00AGBYyqJu
 /5ZyN9R7KNJ+po/ISzOZIgnv3IXkP/ZuarWRpbb
X-Received: by 2002:a17:902:fc4e:b0:2dd:c100:4b7a with SMTP id
 d9443c01a7336-2df7dd6e9cfmr802275ad.49.1790190314200; 
 Wed, 23 Sep 2026 12:05:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5a48dbsm15647795ad.26.2026.09.23.12.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:05:13 -0700 (PDT)
Message-ID: <06dcd0e4-7922-471c-a976-55551c6aa8b8@linaro.org>
Date: Wed, 23 Sep 2026 12:05:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/21] target/riscv: Access MIP atomically
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
 <20260923171116.31276-13-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923171116.31276-13-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::20;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x20.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:11, Philippe Mathieu-Daudé wrote:
> Use qatomic_read() in riscv_cpu_get_mip() and qatomic_set()
> when updating env->mip. This makes MIP accesses safe for
> riscv_cpu_has_work(), which may run without the BQL.
> 
> Reported-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/riscv/tcg/cpu_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

