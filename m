Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE503CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkHG-0005BX-Rh; Wed, 20 May 2026 13:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkHF-0005B0-2S
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:00:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkHD-000452-2m
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:00:12 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso3166072a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779296408; x=1779901208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i8D/6hn2QJl7VFqJHW0NzChyFbUArv0idPxazZauJ3U=;
 b=rKd613yUZjWmbHlMiT+Ef8ensSrmKfIpLYUdNC+dzivK4ReN/vBUBuGB8DFLuFAq1C
 SRXdli1fV87ixxNJAP3COE+d13vsHeuW51RDT29E/MII9NXSgRFXorFiBRL0vauT36ON
 AFjO1wTRK4qtXJMf21MOKDZpn14OYQ+3aRkeYS6rWxZgoUeRrd5dkEIRZHtsoVeDOLhn
 aH/FV9kaRbhFEoIhGfVixQMMpchuEiaEcSg0rvhdOS/C3i9FOvrMf4MlK2GRiRlDlUbI
 MLWqUcpfHK7Wa5O3n8orr8jaUcysMP+v3YbhVzor5amswQosRdWMRmaa/IIKCMKrkpW1
 K2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779296408; x=1779901208;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8D/6hn2QJl7VFqJHW0NzChyFbUArv0idPxazZauJ3U=;
 b=Qccc1GmOqOLNp7uSAlQg8BBqFUPSW00cJGE7B1Imt5uLR8Exs9xCl9OsBuSBhYWDgm
 MGbZnw4iTshXPIbLIxxm6pNrTYneVTxs/stiD6F/uc7L6m1DGjM0Uk5jUHzLJloJ562W
 d/DuIZhXbcpvcukPcK6xNKKdUKnRXnjhKTwWLPQZw7oc6fYMp7s/MxJfPuoLHRUZlhgf
 DPiK5VVRQrLgCpYAFdDpvG+Rl3T4sgz6qbUzKSeQQ3jwKPKF3J/edRo8ELLR3sq+YoJ9
 wmq67ZbwrxsY1Dzp9U1rrUODQ8RmQcLwZ/0O+OcpFEdZ+RkV8E1+0i95t3EIpzOzYVHl
 kZwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LYV+kZupXDVfvvjqeetRqUY9elANR5QGVYljOm1/AaoXdZtNFRdc9f8jU+cB6vqU30Ji+GNAf8sFe@nongnu.org
X-Gm-Message-State: AOJu0YxAU0FL5ezwa4Jh0kjV71cuDOvNwC8dqQ4hZeNLoDin/cbHL7IT
 KdOtgfImEU00ekAOoV0W6OUMdaRN5cv1cSC9T6gjABHBeeKguOju57goU4Feem9ftEI=
X-Gm-Gg: Acq92OFJyWrMOpmgLh22NYo5fS4rK97heE6zG0iJttaZMAGudDeU2fWvvzmh7enlPHw
 +nw6+PKIUMrRPhHG1MjHeOrR4CIbnV1I9z0blUdmQelARKJC+2drk68EdnH1SuidrIIkSO1sfwR
 t+e44pRwd5CTYB3mbZg0M5k21kxMFvcZ89eWwXzaztmDRj7rOtJp53o5B+Pq4UAmvwyuEtAW5LZ
 3aalNcJeJomZlhn4PPi0F6BrO3Np8PXyRopy3JJAqBdanbfGYNWG37/NCIhzTWTrUhS1FOoExb3
 xc215wrfNT+gH+BJ1plo0of4wK0snq0Osp8vMFk2MUsHYILVQUYiYrdkCLFMaQHwiNIXXn0XX/V
 3gHP7S0af+JBofO/1OtOeQzPXo8hf1a+uFlNvzp7GmiIAN23tgOzXVSfT7/4TeYIOl7RSYn9J8t
 1c2yawxR2ST9QuVte41nxGqxVNaHjV/3oquj2P
X-Received: by 2002:a17:90b:58c4:b0:368:b4a5:c4dd with SMTP id
 98e67ed59e1d1-36951895b63mr24271152a91.2.1779296407813; 
 Wed, 20 May 2026 10:00:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb3b3edsm202630a91.3.2026.05.20.10.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:00:07 -0700 (PDT)
Message-ID: <3f52b997-b687-4781-b116-f684e261d827@linaro.org>
Date: Wed, 20 May 2026 10:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/tcg-ops: Fix reStructuredText format
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260519210019.11665-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519210019.11665-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 5/19/26 14:00, Philippe Mathieu-Daudé wrote:
> In the standard reStructuredText inline markup, italic
> text is surrounded by one asterisk.
> 
> Fix incomplete style from commits 5e97a28a8b9 ("tcg: convert
> tcg/README to rst") and 76f42780292 ("tcg: Add add/sub with
> carry opcodes and infrastructure").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Queued to tcg-next.

r~

