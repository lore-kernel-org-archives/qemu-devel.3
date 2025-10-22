Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29922CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBe87-0003Gx-RW; Wed, 22 Oct 2025 15:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBe86-0003GZ-6X
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:04:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBe83-0006Ql-G6
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:04:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so46496585e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159850; x=1761764650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4mC/N34KIicgtLB15T2UrKEYsyaVU4QAItwSTvn++0=;
 b=NQxbsowVm5Pm/K0KRqMSst8Gweim92m9hr1ZRYM5KruejxEOOPgATIUmpBa/Pj6Onm
 8ou9wLWJ67ognRjtCOaUql8eLU/jxGA86W53aj/eYw9TmrDNdeEPphRdAk99j13Wu3/e
 +SAUoITD24JByUOvYWLSft3wBQrpLEHazvHSt0z8hOV/YXwNFajGTKrnhU825Q97vuyD
 5RTyOoix2tho956PIGoMbRJCXIqA03x7YynH9CKoXhyffq8fkq31zcRKMnj5FILzFXA5
 4q9tVQwZzv4ojDxaYjmqiDuwnwj2KaKkVpFAelNtRLwbkbdUrAMXGgqPq2ckpTwh+xZz
 fZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159850; x=1761764650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4mC/N34KIicgtLB15T2UrKEYsyaVU4QAItwSTvn++0=;
 b=RLYbpsT4zINOQPaxirWxBU6j6tJsS2mpBu755Pq6/Cj4M377cH0B8XeaIkYSm3e9FI
 a/e4vscY09NeVPypTf2rzbmL7ZyZ+qZStyp6w+eS7NymRNnfK+2KDFYuFqCzEoSgxkKN
 nEivNG7mfVo1IjpcKcQRvC7JFope5c2tN+2JWf+6poQxDqdKYg1IvGB1SaVvn8K94sOu
 ITiXNbYdVMNyoZ5jG96LU12v2WOhU0JOXG5IBcqGJ+MFaaiAecNuqz3ieUZNFZZTsgMx
 BFMOOCzatBGutA0TbR5phI+pqI6BdQ0TrC3BbIZNk0AJr85atOeSz25YBBLBLQRMQoTO
 LdpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH791oL1aq7Wf35dux1joOreeAhXuaaUv/NT1fJMFbhQQiNmAxB24WZSP5xu6sLg1w0NrrsFoFjOB8@nongnu.org
X-Gm-Message-State: AOJu0Yyg4dwoCcbZa6iVe4s1h0ibbQ66H2CnIm031hJ0H8KV8lIP909V
 cP+MAooLCf5q8RmXrIrJxAkX+n4Srf/1VWpCfdYP+dHTSRxBg6huZAQ4Tk7dZrUJBXM=
X-Gm-Gg: ASbGncssQgUDMwkMtDfeoqdJ4gcs+Zt+/IFy8uc+1hj7IVSv5v61lg8ogw1p07WssT9
 iaV/i9dYTal6GncyGJnNklCDkfjDoQVFaRd4kMUY7S3srAtQDfD2n8h+KT8HucsDnBrbuT6dXBX
 RswVAYJ+tjIe8vK5Gu24Ox6HWjh9UnRiRCIvO8/YVh4DniTvqFfIhAHOEiBGRGLqz5+mSU1aCFJ
 D3OzllB2lPYQieHwBUn3NmNA/EGnd7L7IpXUTLkDjocNztd24Uz0MzPt5ESnrr4+K+DZY5ftIyv
 2Qnlb00hhK/KRlX6Gpvu6NdBUwCcDJRnopF3OKZMQw1YrOKB61BHepnuKbeIbKtk21zMnkfEM6g
 oc71lKDr7Zh2H6ULw386jN8sTZxrZ5K1V/UsiGrjl07dLoLyUR0h1JYumhKS+ihGFm8R4MfpvFd
 VxOqDgrFGL6s0BNOudlxs8Kmbauq6WnXZ1dwqV2qQDdeXbCLLw3qWc2FyCqxU/zfuu
X-Google-Smtp-Source: AGHT+IEc8BUmiPokMgqfPooThQuetaqBzc9CMPi/17PYIgfsTItbgJ5/bhAkQfyG5OT3FKrO3iJjVw==
X-Received: by 2002:a05:600c:34d0:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-47117911751mr173186005e9.28.1761159849865; 
 Wed, 22 Oct 2025 12:04:09 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42d828asm58608455e9.17.2025.10.22.12.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:04:09 -0700 (PDT)
Message-ID: <de499f61-2d63-44de-b68b-240a16381cf2@linaro.org>
Date: Wed, 22 Oct 2025 21:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net/rocker: Don't overflow in of_dpa_mask2prefix()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
References: <20251016145407.781978-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251016145407.781978-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 16/10/25 16:54, Peter Maydell wrote:
> In of_dpa_mask2prefix() we do "(2 << i)" for a loop where i can go up
> to 31.  At i == 31 we shift off the top end of an integer.  This
> doesn't actually calculate the wrong value in practice, because we
> calculate 0 - 1 which is the 0xffffffff mask we wanted (and for QEMU
> shifting off the top of a signed integer is not UB); but it makes
> Coverity complain.
> 
> We could fix this simply by using "2ULL" (where the "(2ULL << i) - 1"
> expression also evaluates to 0xffffffff for i == 31), but in fact
> this function is a slow looping implementation of counting the number
> of trailing zeroes in the (network-order) input mask:
> 
>   0bxxxxxxxxx1 => 32
>   0bxxxxxxxx10 => 31
>   0bxxxxxxx100 => 30
>   ...
>   0bx100000000 => 2
>   0b1000000000 => 1
>   0b0000000000 => 0
> 
> Replace the implementation with 32 - ctz32().
> 
> Coverity: CID 1547602
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I submitted the "2ULL" version of the patch back in July;
> Philippe suggested this improvement but I never got round to
> going back and checking it gave the same answers and resending.
> ---
>   hw/net/rocker/rocker_of_dpa.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

