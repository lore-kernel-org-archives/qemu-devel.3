Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17561E77188
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 01:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUF2o-0005kG-Sb; Sat, 04 Jan 2025 20:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUF2l-0005k0-KC
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 20:03:04 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUF2h-0008Mb-Vq
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 20:03:01 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so19066762a91.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 17:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736038978; x=1736643778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rTbFYmyzByt8KEK5g+eS3GX0VwIyvGnXScH5bPi/Zws=;
 b=jNMA4/eGizd4IWLzjVFL11Dsznssz/qpSIxvV0fIldVJr97fiUOXzz28ZSOV4pfGrU
 jQaFNB4TEDrp7UhGPdEb23E9AI/VCWghablA+vd3Skhm4/6ph9RLmoc27wZjO4j3jc/w
 sGXrJn3FkKY5bJeABSpyzFSKCuGiYC8liFApd/uPFL8Wmsea+UOqELvwsSwWBXi0F5I4
 iuiQOvbj6LDCZN8UKaldp9eLk5AuTljHW9/xmK+unFYvPgI7uxFbcHxx9OD2Oroy1AJB
 KbwCHzsr8jewwdayAvepQASsMND6UgEahgCFrJxcqx3B7YHSD8Ous7BhqZWH2dIjH6At
 BNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736038978; x=1736643778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTbFYmyzByt8KEK5g+eS3GX0VwIyvGnXScH5bPi/Zws=;
 b=qd2w7kJPewbmgsXi0saAvZIlXL6UMr5IcQfiZY69+jjUWf0Ugvc2NOlbutghGokZDz
 T5susIENcewhpCOUyI+hmAGSQuUO7Bie7hmWzAp65KWoEimLwMNwA4CbQ81DGRXwFtfw
 NINOFQzl7yyf4U3CyCEF7xXadMOmlLXmzEGAyMFKS9x4jSCZD8tVE5uHT8SnuzWRBK0o
 bvdOJTWIGA5cSMS9sQpUgNdK2qGvFVZcYAzuyw3r2xw/hrU8cS/xyKUs5S/ujJC/n9q/
 SBwUHydSurrX/SmG6NhgW8ETfXPaw+sAFapTJlBeA5AL7Ah17Cw6CR9w74HOFm2wnLUr
 UfHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnBC0rtkmVNyVbgrOomCSt43D0ABvjdj8VplIVK+wRXGSS4KA87CpSPhpC87MCDqzy6oEjUcHZ6vFk@nongnu.org
X-Gm-Message-State: AOJu0YxluYBJ7azQSOELT+xI66ABr8i6h42BFhWLTb0xTK+TDMr246i6
 MpaWAY2BJRV8PO6pHipWcdHoesHP1hlPt1FSBxZvebDPxFbyC39iJCtUOfzODyE=
X-Gm-Gg: ASbGncvaBq8xBugpFs2dMxXHHv6528fXcJFy4z4VMy3Bu07sfSbR8ksgezJVIoO+7aP
 CkzT3HfT9/P5jKEv48G0cXCYPAAdcbvraYkBS4YD79+miosQoQR0vPqCrgxTm3F4R3RI7jKmhzF
 BhlGZgipe/wA93NjqdY7Jf8+9i+A/x/N2fVMQ4WPUXGIHvCmNBJ75sibbAa6vum/kGj9iqh3p77
 XjtKLnrSqiOwznSgbyI9dEsRTKeWl4zqjHAJraLMWElAVnXdAJ8LMOMmEapyzLrVkQM7p6TU5hB
 d91/kJXPC9DN5MDaPvHsbWR4Z9g3aDY=
X-Google-Smtp-Source: AGHT+IFTzeypw+nE0+Dt9YyucfTrU/9iaQz6tyBc/bKxugJ4LZC/vXEu5GNikQfSRgf0xWjscSydRw==
X-Received: by 2002:a17:90b:2cc5:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2f452e16379mr80792652a91.14.1736038978171; 
 Sat, 04 Jan 2025 17:02:58 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc962c31sm266938115ad.47.2025.01.04.17.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 17:02:57 -0800 (PST)
Message-ID: <435a2919-6238-4845-9bd8-9e32c3c2a7f8@linaro.org>
Date: Sat, 4 Jan 2025 17:02:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] disas: Select capstone targets by default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250103231738.65413-1-philmd@linaro.org>
 <20250103231738.65413-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250103231738.65413-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 1/3/25 15:17, Philippe Mathieu-Daudé wrote:
> When capstone is available, we get ARM/X86/PPC/S390X
> disassemblers in common_ss[] for free.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   disas/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

Hopefully starting with capstone 6 we'll be able to add more.


r~

