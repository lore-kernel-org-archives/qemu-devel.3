Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA34CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL38C-0001Ly-7X; Mon, 17 Nov 2025 12:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL389-0001IG-SR
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:35:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL386-00034J-Jd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:35:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso25151705e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763400904; x=1764005704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m7wZXTeN6wNonzumUFJFUrI8iLhXCASnt2z+tjACwgk=;
 b=u4AGeDTNJL1OhjGUBlbFNqLHcBSfjV1oVfPw2tVs7QOdR0EJuEcWHqdiBu3JubALVM
 IzBwimCVekm+UdA+YlkI1KOFYxBZNV9Nkn09/K469qHjfzhoBHsu/UmtzkiY0pAQOkrl
 UEJ3O9z4HLQzc+g0dcmjSOGdIn5Bvpmp45s8CoplF/6BgKCXc7kQ5RasDKAI3OenNcut
 3ZE6/iGXdAthfRuozKD4cJXNXycktQxZLppH+rLU5a8vgF3zodcjp4EIsNNrT18K5HF5
 5xjsSCgzNNzs0sjVqrMCuAyduD4SqQvDRFZQUsvpRMpa5IHxhaPhuQ+YJJPcYltziFPq
 s1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763400904; x=1764005704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7wZXTeN6wNonzumUFJFUrI8iLhXCASnt2z+tjACwgk=;
 b=llwR6dGivS+SI8kMXtKIIXxMvU5B1TklnJ7rBL3df6RKhyjR3ZBg0RsVbpR4P97lQH
 j0RGfPyAB4MiEVcCBIXlS97rLNGMgn6z5fB6t/nEdlpc/REnB6QE+CnGqTKZ5jeV/JNW
 IKYSQiS0XJnUPhLMR54LNgci25XCzH11Qg2GErKiBBYi7c2tVCr3p6OyhzXG/6Fsb/HO
 LiOhnzTvc9Jv8pkaS2TBgk6Apbmu7jbYiCFXVq7wdPdwxpSaPr5xErVm4zu4/2iCQmgw
 hMUrks/lx/8PkQW5bXwoIzpG6u4r0sWYUq7OoOQqYSH/FdilszGHVf8gol/ncjdPEnnu
 bebw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFAyUXWPT/aC/KB5Cy5txr93POY08B0Q2aMzvNzzkoCaw4wp69PFHhPUSl0H8GiLbE5E65Gr5KTXJg@nongnu.org
X-Gm-Message-State: AOJu0Yy2lydWL0coUmNG+6wq2Ac6g3rctOpTpeR2o6XrpsYgyYH4hGdp
 jZE9CCEsO7pbAb0xZ1o+OzWV1CCtmINqEx8kdyWTb/MLUUkWB4Zte6ENMzNj2xyS8r4=
X-Gm-Gg: ASbGncuJnAm/k4pOroN+KbNgMWQPBP77bym5VXPq7dV8uKpobHGLIqI/zGC4ZIvz3qv
 T6P2ik8CTL1mb5w/LOt1glqGg6y6SbZkKY9ZjiqEimjotQTLcAauaf7KtdKI6Lu2RjvZwytQlGM
 pnwDwpbueoivll9tNoxa5y2vvpEBMR0Iv4ovyb5Q9k6cJ0Yy7goksA2rJG5o/FH38bCkcaucuh9
 Z/RGwFNNnZgugSs8F4DMbzRFrUZ9AXgENzhNyWmuzIi7b8VTs3iMCPbhe7rW5QJsi0Upi4XPY+q
 Ov6UyeckV7bKd0uCmY0OMGRX9+LqqSWBFaTW/be/YJqRBhaojjF7/loVFn/0SpkwH78DWB7oKBm
 ljGMDiM6gkQ6TCVb6atSGe0boV6Hsl8as+AKEcRhxAXewGB6Ci+HI9+9K07Ue4265NpXkR8kjsm
 hr/dX4SgP6TnGQuVS1TSK7DCBr4ldIDZBji1PpJPw5YWTP5SnHuBsXTA==
X-Google-Smtp-Source: AGHT+IGQy5eTKp4RfzRMhRlFarrM6fHNOM+/fWZTB5qr8FyV9OKDZv6GiF38cbCgnpXY2CYmSfaGyw==
X-Received: by 2002:a05:600c:8b5b:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-4778fe7cdccmr103331415e9.18.1763400904229; 
 Mon, 17 Nov 2025 09:35:04 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bcf9f27sm113899155e9.11.2025.11.17.09.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:35:03 -0800 (PST)
Message-ID: <8e3fca87-5f3e-4242-ab98-77c07b3b57e9@linaro.org>
Date: Mon, 17 Nov 2025 18:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
 <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 17/11/25 18:08, Brian Cain wrote:
> Maybe they're based on the other commits on my tree which are queued for 
> inclusion after 10.2? https://github.com/quic/qemu/commits/hex-next- 
> express/ <https://github.com/quic/qemu/commits/hex-next-express/>

Ah yes indeed, thank you Brian :)

