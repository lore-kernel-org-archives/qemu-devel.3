Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DC0C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTLx-00026J-DW; Tue, 18 Aug 2026 19:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwTLw-00026A-Up
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:36:20 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwTLv-0002vW-Bx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:36:20 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso682028a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787096178; x=1787700978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f1FkDEqWTfz9Bvq3YUFEfZZ0S5gViic5fc+7Oybyv7w=;
 b=XTVw18RKL23KJW+tl1Qq8/DzHj+99lvNX74RHJTKxHWFkUMPi/JA3WKm1Im/Sdts8q
 PIG1crSS6nJur+UijMxsjj9dhWtpI4nyTlQ9/tVDiZ69CW6d3DdEcwJGTQIxbHAwsTV7
 6boCYQeBUnMoEr1t3U/l5lFlcfWyWCvVpY+oW/CDLcsyOuAP19h/he/44CajnenisM2a
 W57okBL+wnnSoil+xn7bOFLZtho6EyftPbGwl2wpLeIvN2jRZpun83GpdVLEGR8t1O6Z
 F8Ic2y6KFbfq+49Te73N2q3Hl8X6Wo0ubQXh5+JqPHhw/nzePxa4j9jCyMviyJaYBURr
 A+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787096178; x=1787700978;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1FkDEqWTfz9Bvq3YUFEfZZ0S5gViic5fc+7Oybyv7w=;
 b=HIU7YGVMopDnbrNRtyoONY4pa9yaSG74etYNt9AXZnTbgtSvY5zvPMTSLFmN5j+Ah9
 DStCWlZbnv7UrxUXByXFw/RmqQIq7q+zkVIgEBTd6fPHYUNKPBS8r/E5SNY2XiXgUNAb
 KMCPhzDvAf780tLcpRkjqCnbLUdq1yjwJrpjLXIgkM9edXeChr+8H/u2koY8l61kj+lg
 g6iGYAFyTAnm1s0+8wOPrcR74lGVlcqy20O8kQdYydoGYruRmlLjUSTEgoRn4kPPLY+N
 qhYciKDIdu40XCpuFW8pvX2T+YsKjdG13kHDm6P3w7iznf9QuIMWhf/htHasCisv4uHn
 9WNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RozaY7mdyaEr3zCxnv7n1le9E5REx/yYPEYB0ezAi3rauzumxsMTa/u5Y4RpycDP0Vq6X0Jzz+PU6yY@nongnu.org
X-Gm-Message-State: AOJu0YzELXQsebYOdv310fMaJqvssQbIxkpztJANB2aKQwlwJQCVQgLA
 m251822nIgeAtMtJBw35w0GVKr3WEe/hcP3VTYn4Bcbx/DE1ZjDZc7NOfncu65ZtVdY=
X-Gm-Gg: AR+sD10Cvkj0abWlzKPN3jlOefypaqB2aJmxxQ1Vnb/kfSF34UEHqMuL8vfmZItKcMi
 pSiWlCm8b84lY4OxJRtNZ3UjzDsvZZdUlV0P/QM7k6ua5s1XpKTg4ugjqgTqF+y0jWXV/2vnUpd
 rRHsMEq5odGmin4ya9/vwTIGPKElJzexjzr5vFEpiq2IgbHJsqS1c8u0teY/zMbEMzHFVhtH5Ph
 st1q0LDLU2zyteDcEuK0b68KfYMuFOnYOUlQU/h77H6l0NneZ8PQmTlRc9NayjvEz95WWK64iLq
 srmVWDwRs0No0yz/PMbaphjjjHWwX1isjKJFAwRSmKKhvG2MaKyi+W1DhnV5MLCaoCOoYsqvac2
 DroOQKTlFwRhQDmsGaHGYv9qc7YUmHUCKvvgqgUqTBmsNOeh1PH7jb/ytDFbr10cFJDqbByDWQH
 a+AmGYPsmT0ZxEQOu87B04mWBgub5IyhUD1b0Rk9fuqinBFNkuEVETnz7qv/m01MYY7Z3xNnw05
 QIj0Tra
X-Received: by 2002:a17:90b:1e49:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-39580f6c037mr829119a91.10.1787096177667; 
 Tue, 18 Aug 2026 16:36:17 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17eb5sm458050a91.3.2026.08.18.16.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 16:36:17 -0700 (PDT)
Message-ID: <2d05f1b2-6f08-459d-90db-40547b916ae9@linaro.org>
Date: Tue, 18 Aug 2026 16:36:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] RFC: accel/tcg: only poll for interrupts in blocks
 that can close a cycle
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-7-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818174247.649526-7-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 8/18/26 10:42, Matt Turner wrote:
> RFC because:
> 
> - The soundness argument depends on every goto_tb destination passing
>    through translator_use_goto_tb(). No target in the tree bypasses it
>    today, but nothing enforces that.
> - System mode interrupt latency now depends on guest control flow rather
>    than on block count. The bound is one straight-line run between cycles,
>    which should be fine, but timer-driven guests deserve a closer look than
>    I can give them.

Yeah, I don't think this is going to wash.  There is plenty of guest code where 
straight-line code is massive.  You need to be able to guarantee that we perform the exit 
check regularly, without icount enabled.

The proper way to attack this is to build larger translation blocks with multiple guest 
basic blocks, which in turn requires more TCG infrastructure.  We'll still perform the 
exit check at the beginning of each TB, but the intent is that there would be fewer of 
them by some small-to-moderate multiple.


r~

