Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BFEC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqgX-0005zu-DR; Thu, 22 Jan 2026 04:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqgV-0005ze-1e
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:08:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqgR-0008U5-VX
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:08:58 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so6032565e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072934; x=1769677734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok1gZp8O1wQgzPkNxhQ9CiOrOjwnWC676ra1qqLytL0=;
 b=dMKw9jRFMN3/Zm52ng3i0tbXpoQTI5rV3bQ0VNqohs51ZtPotidXf2M/SrNTumrqeZ
 t3OHvXzcHs7C7MEtapl/eGjQEANdxe+0k7JH6fFqutxAVzr8ybcclxDlxIYnN1OLo0B6
 ofPc6fWvM4uknKsAUKiOP4eX7B0RGYNOatJIKPHGA3mKZul3hvO6yWZ2Uu4zYk1lXqnq
 abUq71+cjLR32sF1bGZzRm78HKasYvhXP3q9eRVRYyyCKVOxIq2WKg3xVW+jc2ox8oJW
 Vzmb8JwKvv9ABNPQ05/kTTEwkQtdNJ6b4a9LdqTHamQw+uKpRsQl0dhfNo5RavFkoJe6
 8UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072934; x=1769677734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ok1gZp8O1wQgzPkNxhQ9CiOrOjwnWC676ra1qqLytL0=;
 b=h1J7cxfyo+HfYSApSA3U8YpNJKtfaQFUTANd96UQqIDMgO6MWYuaZ53gWB6+JwpAEz
 9WFq609IG45KxoXpgCsl/ZpIlbfjAbum45dwERJBO19hudj8casUqEvgJYSe9+HzjIUB
 cppQa64wkLENwiHub0obbJdl0BfPcyLFH1Nt706ZgCt2Q2Ur0wqtCxPiSHXhP5fo4K4M
 hURaqX8QHWUgG78IHxThrtSCBhB916wZu0u5jMYe0q+yeFiE+JFZbEVE7w4GzlovLQF/
 u8ctIxe6f1qG6TxgggYldeX4c03ChalbdzhtbEo/zKQ7DOKLVXBfoF8SQhP/UHKYYaUy
 Jl8g==
X-Gm-Message-State: AOJu0Yxo32jkAg1LTtL2X5quMLtejQ2lYtw4xhNVpLgbR2hiPViM6wWI
 w3R56Xc8wmUKWVY5dzWbq1eVzkkzy+/rjYQHeCydoBtrRD5Jd43R0ivvyJWepbEzdKi40YpGT4S
 1EdTmjkM=
X-Gm-Gg: AZuq6aJHcaVuGSdidCKPuN/OpFwxXDZfLOjaPZxuRECjkGLkula1Zm5hPoPQOzqXM5V
 fi3bR3k2az2p5Er3tDflZrN9+TXt7m6e1p62wThJB5Rn/vn2igBdx6omSrEtuK7LVMZnvkJ3Wap
 T0Ptj57jO56e6Ln2osJDAztufsxHJ4bv92c3+JWkJF9huvGBnv4ax9yU2jKfI/V54KzT7iaKgI7
 5PC/sCvBZia6/1JJ7XfsPKnYkCPKGRovqhr7CZ/Wk9fmI35323MPldGNrkwUMUNHelItUOUz1r0
 XncTOY/0C69kqWZQLgn37IdzteMFAAqMxK8sM8Y7wtppTXCfsye/v72q/4xR8YLP52yaADmLAu3
 AbGLw7gcf3pJH/6Hzn6v1lkY/m/ajFhM4Sz3YNrqnq66qY5RXGPo6+tOrbZ2GP4RZjjLIQ28QjE
 EGSam9XcWrLUPpUqByZJogiVQYotzR8n1J6VXuLrh0hlUUK6NnNGrWbmIMlrcYfvfs
X-Received: by 2002:a05:600c:8211:b0:480:4a5a:bd53 with SMTP id
 5b1f17b1804b1-4804a5abf7bmr12877955e9.21.1769072933894; 
 Thu, 22 Jan 2026 01:08:53 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804703b90bsm61905305e9.6.2026.01.22.01.08.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 01:08:53 -0800 (PST)
Message-ID: <2d5a2814-770c-4c4a-a2f0-6415f0914149@linaro.org>
Date: Thu, 22 Jan 2026 10:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] dump/win_dump: Build almost once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260121215622.92966-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260121215622.92966-1-philmd@linaro.org>
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

On 21/1/26 22:56, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    dump: Abort in create_win_dump() on non-x86 guests
>    dump: Build stubs once for non-x86 targets

Series queued, thanks.

