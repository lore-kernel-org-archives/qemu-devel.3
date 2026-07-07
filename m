Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12856C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9en-0008Ux-Hw; Tue, 07 Jul 2026 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9eO-0008Sh-EJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:32:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9eM-00068N-8f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:32:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so3663786b3a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783445520; x=1784050320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tbhZ/FtcoqoKp6+h8wzFDNFnIRX+oPkT0ATkITZ2F2U=;
 b=Lb3nou0A1jGheM9G85udfIEpOmleeixREg4A4oR3xVrgIiSOavwLMSmu4fyNUkSQ/H
 z5pgBZxjTK/z2SXfEZln4rgpGrwNbGISF1o/EHdRDxW+1sMxw6MbqUAi9FfZBJ9kBrqX
 UdAIl+q1Ok5lOtttZspj7ksj8fYg5xd65NS3b6duynwROaaH7pOK8KM66FP4B45M5SoW
 K9/C0L/8KqhumbJYzvupBtIJU/AIdfdMMhx1kCTMLvOIrRzcwCXxWV5d5dIOBScKIqtL
 cSRfLLWqBi8HfafQ8L0ApBN+7ZNWZc5x8mDFxZz3SMgq98XVmem9vml4T0B6r1f3G9DK
 dg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783445520; x=1784050320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbhZ/FtcoqoKp6+h8wzFDNFnIRX+oPkT0ATkITZ2F2U=;
 b=hEGYdvrQH7g9m2V8uCQPY3e5w3MmBiy0SGHStoxi9BTstvL05JVjDgMcnGfF8RF4yK
 x+a6jyw5J4EOomeUm4e0FYTCQEXMNQTFQL9baSVssgdHcVd2c1SZBbREdp2OLqtIDLfV
 uFQp9JmVswnYjdQ1yKCOoxCIr92bRVQu41pjEeedFTkYqcxJs1EbTOiWWveIdKix2a/e
 HT5QSxvr0NHfqjdfil/fWhqGW0xDBwt3QoYTOEp+0L5kdsVswp+rx5pg9cxt0haHXwW+
 9ltfR1qqhhE54xfbrKHuITLLyZUa4o1IhhenahIg3bTHsmS0fgAkXTG90roZvq6k8eFC
 BYog==
X-Gm-Message-State: AOJu0YzfQ+qrrl8jBwraP5LzXOYrtfM3lftwIWqTmOih2FbULG1UQbVw
 lPNJ7ichCEC40PfAGONrNQtVbxhbgBLuimpXCL858+46DE6JT8bKln4xDK1ysGtMJ4I=
X-Gm-Gg: AfdE7cnJY2M54SnVvJJ9c5dXEKSDvz6IFl/atbZ/8ATaMdUkvJFBiiRhLAGRDy4UNV8
 G55DCFf5nGRS8pPCdYpM7fEeYcijB12yR/5OH1O5tv9Pm7v3jm2qMf4zUOyorfEkl0tokieDV5O
 soil+JSoA83DolSLf6i9V63dA9VQUYbGQUTUikfA9uiMmvKr/PNw4Cd9VODoCKNKlsxzsiHm6JG
 5CbAPWL8ef9L2ZGuSCS+kCxj56dJte2XHLJqbQpu23O2+XGdP9I6ux3nNibrfrmNZBRnDVgGdK7
 Un4JmHOpat/PhqpCbTZOdk5/uB0A8UzaWCYegkYOr/0oSXpVWS2x4FHbY7kxkrGnj9ePhCQ2Zsd
 JWCt5+9LzbYynYyBEpqZ6oPbKAXWhYfuXjr7VBOa8WxPQeo+7AB4F0TJkFp+5/TgCBF9Jml1Aj5
 /36zBphFtuD7xwOAwnJ0GfVkRCkXJlzzpe+cQmn91eG6MnAtfa13FOBZY=
X-Received: by 2002:a05:6a00:2350:b0:848:2f84:f429 with SMTP id
 d2e1a72fcca58-8482f850453mr3437376b3a.66.1783445520205; 
 Tue, 07 Jul 2026 10:32:00 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af7d595dsm1386688a12.6.2026.07.07.10.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:31:59 -0700 (PDT)
Message-ID: <8c06ffce-016d-45a1-9619-b28a643a8749@linaro.org>
Date: Tue, 7 Jul 2026 10:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] accel/tcg: Make PageFlagsNodes' start and last
 immutable
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260706165445.57418-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260706165445.57418-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/6/26 09:51, Ilya Leoshkevich wrote:
> v1: https://lore.kernel.org/qemu-devel/20260706110330.4150026-1-iii@linux.ibm.com/T/#t
> v1 -> v2: Use a new approach: immutability.
> 
> Hi,
> 
> This series fixes the ancient vma-pthread test failures. It was sparked
> by a bug report by wasmtime project. The patch seems to fix all issues -
> I could run vma-pthread for an hour, while previously it would fail
> reliably in under a minute.
> 
> Best regards,
> Ilya
> 
> 
> Ilya Leoshkevich (3):
>    accel/tcg: Make PageFlagsNodes' start and last immutable
>    tests/tcg/multiarch: Improve mutator randomness
>    Revert "tests/tcg: skip the vma-pthread test on CI"
> 
>   accel/tcg/user-exec.c               | 37 ++++++++++++++++-------------
>   tests/tcg/multiarch/Makefile.target |  9 -------
>   tests/tcg/multiarch/vma-pthread.c   |  3 ++-
>   3 files changed, 23 insertions(+), 26 deletions(-)
> 

Thanks, this makes a lot of sense.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

