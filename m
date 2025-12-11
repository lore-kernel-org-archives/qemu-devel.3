Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4234CD41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTj50-0006uA-0j; Thu, 11 Dec 2025 10:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj4u-0006sb-6U
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:59:43 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTj4r-00043Z-Og
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:59:38 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45090ef26c6so90148b6e.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765468776; x=1766073576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qNE24Se9IoXPkO3U25rvWR+s4pIGV3BmiHgjmEa0784=;
 b=t5b9bpfj1umzchsxRDeTKQJnCoJkNS7oFa1eras4AucJIj8rfmKX2VE8M+mCwmB6uQ
 wWYsfdtPdCCtKMiqGnrPyKVqAV9YBddJLFdTyB1EHYL3gt/lnxBA+AQr7Wb21Y9/HASz
 yZWYEwvS1V5uhWfdcVRJcxbGbVVAPnkGrbBmpLRg0z3Ngoexg03uIUql4trqkKrw/h1v
 rRlUcSf+fvQb8cH7N+2jKb0nhz//4OUZ1Ap+I+VVcvAnIJ3L39zSKW9tO595pqScF8/o
 kOkhFysDugBRliWXpO2GeKhMDeYq1ngi3GheuNgwpXDDIuDPQ7Bqvtx5Cwiv1bdqKjHn
 czHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765468776; x=1766073576;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qNE24Se9IoXPkO3U25rvWR+s4pIGV3BmiHgjmEa0784=;
 b=l8/4s81IikepJcCL7wK3xu7VKJoTtFhLAqJ9SI8XZuav0ZDqpinjZliumMkk1zyrxw
 1PXDWadstxhQz38QyJ50aKvU07+jCUnndA7aY9uafu+QtBCEqwIU/yybCAgoL4ZZu/NJ
 QHR5WGHtrm3kYvrOj65qIt5/mpeC+GCYYewywtjar3ow5bf8u6flGxPq7Ehxw2YX6cTH
 qVYOljOxQ9eXefQfXPfwbLc6jQR/aZwVXz33UTOl1tvd3bV/owMpSWmBAfYPtUZKXHkJ
 UMQQu/22zxOny7ML73Uq62F10Y8J3lyfGvZ7+Nj3/yP9grYvTVckWYZCopGCECHdBN7J
 /rRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO4jNPfsVkINMX9grSTP5UnsdGmFnBGpQSZycQb6j8bnbxV0NlfQczJ3rMlXZrIeBU/6ks+swTJory@nongnu.org
X-Gm-Message-State: AOJu0YxySCwAO6NTvX0nO26kpZwtE8y1JjF7v9VjrnyzIWZ80eqrSYKR
 /k37GbABDybqZKSDziJ3pD4vg8r7xyCJuSkN0NJN/BpMLM9Rw3XaA+0NWmNRtqf/8dHxcvNUhrg
 0cOdThEI=
X-Gm-Gg: AY/fxX47c2DpRM9xbvIAPLIvq2nZL/xCmkMg6Po5pYBrGoiHPpzoL/b0KMIYM//otID
 I8sbddSvQVYDpFni6/bMkgc6IEML3gs0DmSJgto1EOD/2u/E6JbFi4pNJlLsYtwRpNsI9r74Hhr
 PTucQZQCFBqabWnTcSX1ttSpMOSqWygw+6T1K02WkNF0HkoP6MGSAL3d9afwTD7ZCA47jd6/qce
 5oTjthgJIkEpIdmSHa+N5DtJlRpSy2ir4z4R47CKCq3XUQwUhg16KTXxF+bOVTm7sJ4wEYImcNh
 sPtkyGeKstVCbsNEAyIrSE8qqFZn9rlTLglhXM0SP9iiKzFnfP1hs+Sb5f2UszdFluUzZbtnDA1
 zw7zgboGNgbpwrOKcKAhxnXY11e2YR6RfdbocjH3dARnXeVeSNcL+3JHbwGQ7WYRN4dibOdid4l
 nA7wgqtpdRFJShiIkCy+T8z2UpipwY7+LXpUlYoXZ/aJuPQ10fwp2lhCQF3rfW9cFS
X-Google-Smtp-Source: AGHT+IElz9OvDSDymquVIwDyAHHuRE89M3M5CB3J5sMEta0rqImK0PWSlQirkswUhMLnRBaeYKPvJw==
X-Received: by 2002:a05:6808:1919:b0:450:c916:10b with SMTP id
 5614622812f47-45586514420mr3485504b6e.54.1765468776346; 
 Thu, 11 Dec 2025 07:59:36 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm1210708b6e.9.2025.12.11.07.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:59:36 -0800 (PST)
Message-ID: <fd42b7b8-a9ed-4e0f-9c7d-5833438adf20@linaro.org>
Date: Thu, 11 Dec 2025 09:59:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] target/i386/tcg: mark more instructions that are
 invalid in 64-bit mode
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index c9b4d5ffa32..213dbb9637c 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1698,9 +1698,9 @@ static const X86OpEntry opcodes_root[256] = {
>       [0xD1] = X86_OP_GROUP1(group2, E,v),
>       [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
>       [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
> -    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b),
> -    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b),
> -    [0xD6] = X86_OP_ENTRYw(SALC, 0,b),
> +    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b, chk(i64)),
> +    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b, chk(i64)),
> +    [0xD6] = X86_OP_ENTRYw(SALC, 0,b, chk(i64)),
>       [0xD7] = X86_OP_ENTRY1(XLAT, 0,b, zextT0), /* AL read/written */
>   
>       [0xE0] = X86_OP_ENTRYr(LOOPNE, J,b), /* implicit: CX with aflag size */
> @@ -1834,7 +1834,7 @@ static const X86OpEntry opcodes_root[256] = {
>       [0xCB] = X86_OP_ENTRY0(RETF),
>       [0xCC] = X86_OP_ENTRY0(INT3),
>       [0xCD] = X86_OP_ENTRYr(INT, I,b,  chk(vm86_iopl)),
> -    [0xCE] = X86_OP_ENTRY0(INTO),
> +    [0xCE] = X86_OP_ENTRY0(INTO, chk(i64)),
>       [0xCF] = X86_OP_ENTRY0(IRET,      chk(vm86_iopl) svm(IRET)),
>   
>       /*


