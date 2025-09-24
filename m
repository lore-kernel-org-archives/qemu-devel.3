Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A37CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1VFT-0007mU-VQ; Wed, 24 Sep 2025 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1VFR-0007li-VQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:33:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1VFC-0000TK-7G
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:33:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27d3540a43fso1702975ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758742411; x=1759347211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7P3iEpW3QqR3smW/O41zMIZR+phakm/oOTlUE2K7V8Q=;
 b=Euv6HPIexWcRykzbdXxTInPzG9tnW7iHnrL6Ddm5XRSx2yQs22jhR+R6opKndjQpYp
 IBwLR4JQSXbz7tROrrbbSJ3gGx8UdNECVRffeOxUq7kyfeX5Q2KhLfQtPLyBwelRqfNa
 q9ym0N40I3MCUidrkwpU1jp8iOKbM8itCpJ4PRprEAkgirolaN8dvh//6ropRbAbS4LE
 Y8RnUUxNG6D9BGpCNs5erNSB8CHMPYAN2qYMeSoolZLTY00r2myW/iy163VjtUBCBPK2
 6tW32yBvPl6nvYhGsPol0aZ+wgKuFo3ilQK425+kMheqS0eq/l+gO7kuqAcs25QQ5sTV
 CIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758742411; x=1759347211;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7P3iEpW3QqR3smW/O41zMIZR+phakm/oOTlUE2K7V8Q=;
 b=aPJWXGu/IgfYmonypbTOM5vrpBa5KJuotTgOfmONb2r3wnLGicYgkNGVHJ5iUKcFbE
 gu2wVHmxby6ieCCoZ9fWXxpa1YiFI6Bthia7c0LsWgZ/I6KA3ckRHv4sLK9UAlEgNbVF
 WNMm0a6c34/Zfr9oRB1TsxK/9gMILOVbwFOZ3pXS1dr9Vfo99DT8X3u4r9hgzm3YeeiY
 yK7Dk7Bo3r/+BSbNed7OvlGaFHUMprA6zl3gvvUe0GXZUQPYFxC+K3doTnFyF1CmWjf9
 RbENe3enRqW4Cl4kuOz4n5wSYz4oOs7rNTwu3kaKVgMoSgrqTVTCMpkUXIQ2+0cGkcDE
 51Qw==
X-Gm-Message-State: AOJu0Yy2MfuKp9MfM//X/tZOWdDVF+9OExMnXVplBNEf/8LqsIH6PAlt
 9DBw7v3M7tI5gc+Y+jD7e/6RtcSlP0rjZjvLWWLzNcjFoMsSYrEpTejZn3S2bGIMLn4=
X-Gm-Gg: ASbGnctIilVQZFtPSw93jjUlbQfF2t6ZRKZVNqfGJmDaLduu7QpAm90Vd5BZxPtEAC4
 YeWS/P7muXrqcyrCSb2T+WZ1V1FsBLcNQUABy96kjn00Xfo5NoVQhHeGcITV00okKApOJbJDseH
 nhABDnfPZx+9zRPZulV04KJno8AVUEzIm+Iz65fwS3jNaTzEcGLaH9QpaMJ5AnZGhdTsbhfrGxE
 qDbrxUPNx3EKeSsst96zWY5ixt1FgB1+m9bxAw2D/E/rqA0crmklsSbrt/9ucjUp/xk1gMlAeZE
 V9eVwpejEPXflnggoPHcCRE2GMGa2Bwu/O8oaFMULF1OYXcnmw23qGZ+zyG4/aP6Sytt06/TsQ+
 L641+8hc+DlxQcfVH/TeJXAra6agauUTrw39p
X-Google-Smtp-Source: AGHT+IHKFYQHG1d0LaMrnxQO5NFOHbWyq29BN+3KGEvd24hfxYsjPQCSyAxrhd00sjNse/zFtIKFFQ==
X-Received: by 2002:a17:902:fc8f:b0:264:f714:8dce with SMTP id
 d9443c01a7336-27ed4a76ed9mr9166065ad.36.1758742411542; 
 Wed, 24 Sep 2025 12:33:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bcd80b5sm3177762a91.0.2025.09.24.12.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 12:33:31 -0700 (PDT)
Message-ID: <e6911694-a412-4092-9c72-98d33aec9f70@linaro.org>
Date: Wed, 24 Sep 2025 12:33:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix folding of vector bitsel
To: Michael Tokarev <mjt@tls.msk.ru>, WANG Rui <wangrui@loongson.cn>
Cc: qemu-devel@nongnu.org, qemu@hev.cc, qemu-stable <qemu-stable@nongnu.org>
References: <20250919124901.2756538-1-wangrui@loongson.cn>
 <1c834cbf-95be-4ee6-8048-7a6ca34ab0f8@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1c834cbf-95be-4ee6-8048-7a6ca34ab0f8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/24/25 12:31, Michael Tokarev wrote:
> On 19.09.2025 15:49, WANG Rui wrote:
>> It looks like a typo. When the false value (C) is the constant -1, the
>> correct fold should be: R = B | ~A
>>
>> Reproducer (LoongArch64 assembly):
>>
>>       .text
>>       .globl  _start
>>   _start:
>>       vldi    $vr1, 3073
>>       vldi    $vr2, 1023
>>       vbitsel.v       $vr0, $vr2, $vr1, $vr2
>>       vpickve2gr.d    $a1, $vr0, 1
>>       xori    $a0, $a1, 1
>>       li.w    $a7, 93
>>       syscall 0
>>
>> Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
>> Link: https://github.com/llvm/llvm-project/issues/159610
>> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> 
> It also looks like qemu-stable@ material.
> 
> Please let me know if it isn't.

It is, yes.

r~

