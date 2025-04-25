Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE761C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GpQ-0007CP-7C; Fri, 25 Apr 2025 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GpN-0007Az-Vj
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:02:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GpM-0002aI-93
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:02:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so15190005e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745578958; x=1746183758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n4ci4ivmcwqKHOP7pysz28R1nUNdFC4SXdM8EpOpiOc=;
 b=JZHFzxgqZVFg6t63wlGLUGCPisV7tUhlm//7vND2wt5EEvDhCoTTDVhao8CFpoORAt
 ydf29b6t2zRlyyE8CIcipkG2QKAUv5cd8GfN5D+q1ijpRUatDEeEX6QBtQyvWIICnAvg
 eeraL//SspJYpgbncOeGpxyKLQM8y4TNDV+J6I+wL0661s0pt1dIIr4AGMlFMJgcN9ud
 P+NwbTJS3Bmor+P8qU7A0szDPXBw6bEbhoJLzzQPHI0XGwi37noeQySxVTOi2kBI6Qvf
 /xtpsiQL3A4YP1Fo1RL56DmMNqcBY8EuDXzat0vsBcBRMToZS19T/Y+E7ThG93uJI9M1
 M20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578958; x=1746183758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4ci4ivmcwqKHOP7pysz28R1nUNdFC4SXdM8EpOpiOc=;
 b=OZtQB2YAqU00v3x4Bt3yhF+XPvHKP0MZBVgOZtuT10vz/fbKeeQ0aNc3Q4wwm1IerC
 YRBJ1POFm7ogqL+x+9bNI6gCaHA3FFFVwdPeLh6xWGgG/X3nn/Mg6G6CvJ1gw1Z720bP
 GrOYxKVJi6Qe5KbBGxVSxrgH+Zfcc42ZU9Jj1IwjIfGQ5werCjHcb4X/LBDeMvEdlQBq
 K0jM+RA3BCWMVTwdnJv9cm5tKi/gsfonVG8xpPsOpx3S/7imUtP+r4pDb/jv1bMsmaWt
 ZhWOWyBXu4qTDUCVSqenmcod7ZSja0ecfiY8FilyWSq6/LOE/l+NdIbsU095SHy1/f3c
 o1Cw==
X-Gm-Message-State: AOJu0YxCeiuZe4CMMsN63N9YIoAQpIdW4Kl9ikxH5YpK5y6zBefsHPCb
 coTHCw5AVrPIGwZMJXOgic4tWC5Wlyr2tDMjcbHtk4qlweSwHcEG3yO7bmEEz1Y=
X-Gm-Gg: ASbGncu6CfzapWlyxAu5UA2fo/8/H7MxHX1kA0l9fyz5/2pbs+JWABU0SQIzRB7dw45
 Tb9AT5j+X2zZ+/7056i6JpxDeuyuPkjPtcHWsC9SujYTb9z0u+JHL2v6EMTxHPwDUQYX01+l5hl
 lb3IR8Mj6ExakmmoHdHYYbU2bPJegRMbB88ShgETw/HpjNLl2uy1yvhu0ZNebCrW+gV3u1r3Gt5
 99DTZgRQJTSFsnHf1pqc+LjS0sEp3TiWxOcmVUC1NeCb7Ri3TKO0BEBJJG1Q1ovanySVs0TgOk+
 M83R29SjvMhPt0qu0TsAN2EkyFwT7pMXCUTJk53+ZvRQGEciVIUlvkGxn6NcVDJJ7ZJ/GivHOEN
 acsyLdS3V
X-Google-Smtp-Source: AGHT+IGKaU7yDp74mgme+bBuPNoYrmRIHvOoDWto+7Jl1d4U499914HEjnl2CM6kIkqqtUCH7mTarQ==
X-Received: by 2002:a05:6000:186f:b0:39c:1257:dba9 with SMTP id
 ffacd0b85a97d-3a074f8f9f4mr1193487f8f.57.1745578958188; 
 Fri, 25 Apr 2025 04:02:38 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c6a0sm1985186f8f.86.2025.04.25.04.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 04:02:37 -0700 (PDT)
Message-ID: <98f9c6cb-a731-48ec-b5a8-3f170b07b7b0@linaro.org>
Date: Fri, 25 Apr 2025 13:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10.1 v3 00/27] target/riscv: SATP mode and CPU definition
 overhaul
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <CAKmqyKO=-QhuKNAKJBXfGiwPdSt=uT6M16pgVJENLxgEiy5Adg@mail.gmail.com>
 <c0dd76b5-da8d-4193-9ea1-5fb5e55b35a8@redhat.com>
 <CABgObfYy53Z-LsW2QNdWdtEhnXq9=2f9aDdZHZrou4sNQN_ZYQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYy53Z-LsW2QNdWdtEhnXq9=2f9aDdZHZrou4sNQN_ZYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 25/4/25 12:55, Paolo Bonzini wrote:
> On Thu, Apr 24, 2025 at 4:39 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Thanks!
>>>
>>> Applied to riscv-to-apply.next
>>
>> As Daniel noticed, I was expecting
>> https://lore.kernel.org/qemu-devel/20250210133134.90879-1-philmd@linaro.org/
>> to get in before this series.
>>
>> If you need a version that applies without that series, you can pull
>> from branch riscv-for-alistair of https://github.com/bonzini/qemu.
> 
> More conflicts have appeared so I've updated the branch and will also
> send v4 for review.

FYI I tested my PR and should post it today.


