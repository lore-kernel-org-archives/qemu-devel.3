Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FE1CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gkR-0001Bp-P2; Tue, 14 Oct 2025 11:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8gkQ-0001Be-IO
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:15:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8gkM-0006G1-Rx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:15:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-279e2554c8fso55754045ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760454927; x=1761059727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eD8wV+4YXkFIqxnkne5QPDJRqC5cA3TMGJOW3pLDbgo=;
 b=bcbhMlvFl3141lEOWnRKxRzfVyPOhCh2b56DWnNevPH/9Z46Lcy/yoKllE6z6WifPf
 L61XOHoAvnI5B2ZfnEivO8LOAmI8NL69O/vL8jY7OMch3jtfmKroKbKyi2akjdAzz099
 mLvGRXD2IXVIuxKbdsNVFx4+FIUTy7cm8AGVTku86ZEzEhAy2iP9/a7qXorFu4GtFsVc
 0HJdZqZuWNiYnt4/QFD3aw5EKJ7LfLlsBtXa0EZ5q+vADMCVVFQhDhiDkhjcT164FMbF
 yx+Ytht38uxnTdkJnWEZ5NzgQV3bPuLP2ZbAIRGVLpcTUrbUGop/5HgUzNdq5BVmF5De
 YTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760454927; x=1761059727;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eD8wV+4YXkFIqxnkne5QPDJRqC5cA3TMGJOW3pLDbgo=;
 b=xICOiI/h99VX5WWpwEuvONVf67Lda8v16Vxd8VMGOv0CAmX5N9T7X2lp2CeTgvtx19
 dJbUbjqQJrlVvvSMH4HZkyCvSN1qN2kRjV2ZzkZydsbgOF3id4RwjjoqioBUV8yE/9u4
 hKl/keKiScvqPYH002I9QWuuHiI6oiw86JKGOdQlE1ceaZfDNGKf0tmzSMH/st5WzydI
 VzehGSgICA3E1A7wZURn0RqN/b1kwSCdP2byUkOeUkeLFJWx6MbO1zqrmQYrj9rzMxk8
 go9JsiwIE2IYJ/jw3i9oM/SrehGUt0PsxT8LpGorb7TgulYdakEyqJlcrc2RBf48v6WF
 ERbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU19CrO1b2dSymyLwaLfna3VgvH7yHL4h81j0I+phpIfLMqKirrttkEIbNMGLVY+IrWwVxnPHu15HrJ@nongnu.org
X-Gm-Message-State: AOJu0YwLbkfjYwlvHUUsXYBN/Fu4RPO86wpo36S87opswDpM2LxnSpuF
 uUOZbSWxAHdSMyUq2ZJ7Hf2OSMLe8z+GVpEoKiyr2RS/L7FwvfRs9H5Ry1AOhGiOr1Q=
X-Gm-Gg: ASbGncvEeUYS/RZvh0HyTWZrqaHla0WwJ8dct0aIxssXX4/WhCWiPpeocNx/HFlWn7n
 qOI2nZNZtRDF4xvhmGOffP8F1Wnmu6I1GmrW940PDS74titNCbUK+KSPwtyc6qCydfuOD2bV3RD
 fHcS/sz40qQqJsRINasFFQwgkHF7s5XhC0HH8XcapcxHlgNFBM1uKBn9Bmw/iex0RqabzKJseom
 5RCKyeiKkkUrx1ubjHlCUQiTc6kF3arCZOSObJN8Q/ypN+CySEhu5hlKm+UEb3S5Q+I4KYK31qY
 AjHShxbSVMgDtmSiup+r6PUvrBKUzzJB/9GKMbzsXFYq4rGKaqv3JHo//0zusd+q3EmTECqYxiD
 Rz27PV/9VYbaQ7Deh6fcWxNYtvG3SOfBCygRpHrQkp2SO9SbC7+QCnXAA2hJh9hE/Tu0rsSxlAe
 E3yRuP
X-Google-Smtp-Source: AGHT+IGrami7JDQLVMiWwVrJ/8k3+iAH0hYDveYo+Bw5c8DU4Pl7H+IJlSL+RRSXzC9fIgYhUsQjXg==
X-Received: by 2002:a17:903:fa7:b0:267:a8d0:7ab3 with SMTP id
 d9443c01a7336-29027321dbcmr297361535ad.61.1760454927356; 
 Tue, 14 Oct 2025 08:15:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de5dbfsm167072255ad.20.2025.10.14.08.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 08:15:26 -0700 (PDT)
Message-ID: <49f5fe83-e313-48ac-b674-480e87eb7394@linaro.org>
Date: Tue, 14 Oct 2025 08:15:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: proposed schedule for 10.2 release
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_HOAY3dvoj7a0GYX85UeN9OVi7SPqYtEmPFWP+DvZfSg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_HOAY3dvoj7a0GYX85UeN9OVi7SPqYtEmPFWP+DvZfSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 10/14/25 02:21, Peter Maydell wrote:
> I noticed we hadn't yet got around to nailing down the schedule
> for 10.2, so I put together a proposal (which is basically just
> "same as 9.2 but with all the dates moved back 1 day to be on
> Tuesday"):
> 
> 2025-11-04     Soft feature freeze
> 2025-11-11     Hard feature freeze. Tag rc0
> 2025-11-18     Tag rc1
> 2025-11-25     Tag rc2
> 2025-12-02     Tag rc3
> 2025-12-09     Release; or tag rc4 if needed
> 2025-12-16     Release if we needed an rc4
> 
> https://wiki.qemu.org/Planning/10.2
> 
> Richard, you're doing the merge handling this cycle: does
> that work for you?

That should work.  Thanks for doing this.


r~

