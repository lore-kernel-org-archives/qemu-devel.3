Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DCECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v697x-0004CJ-Lp; Tue, 07 Oct 2025 10:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v697v-00045W-Gi
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:57:20 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v697i-0007uP-8l
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:57:17 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-339c9bf3492so5524175a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759849020; x=1760453820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=00VNmTYRW9DIW/9gL8rp3MWZ1Xs6ZjjTe6Q3F6T0dhg=;
 b=r2jfarO7J8S6mGugSOQvHRGXmfPceVMaXxnRwjgKf7mfzrBBs+sG8IAKrLtAZO/KE0
 YXrxhlLrWRtSYFkF/atFrhNy9XRF3/HymbJ+GM/ckTcoxEZAV/G4bzeQXTNJf5w8RNEp
 TQc20gyh4TFAYQ9XG0nPdmcCiqxjvFZa5y5LSGkmWAWjtZSzPf3892kUhLwsh8lvh8wp
 9JDG6MwP/RCe2kfcEzTNg87PYTqp3q/0938o/RkG7T0+pXglQ3P2yWUHf/AFcyBYdf9a
 OGH3qp8E674Kkk/4Sj+xyxqM9Gqw8nJimodB0RVL5r1t3RWCjOTer/Pf/WOVEN72Za4m
 3/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759849020; x=1760453820;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00VNmTYRW9DIW/9gL8rp3MWZ1Xs6ZjjTe6Q3F6T0dhg=;
 b=Zl1zpJPldf0b1wZaLgDYHiFRyPPUCYn2jBh9bYOhTFjk5pRKk4pAyjteY4Zmcn6krX
 no5CpYXNjEhWlXjzTmr1r6qwjauNv7K5iUJdr2qechA4mMA6YojPGZibD9ebLvEmdvua
 UoMs3X6Nl8xlCY5vKnQclR5zjL5BR8T8JJ7lIjKUhkp0lbUoV5BK0fXHyKnxpj6OE/gh
 xu4Zik3IMf85BF/cU2kZcld0c/E71s3ZqAoOMex3tWbVCknLqOxAMqqn4WvF5748xhtP
 /JyOjfTJk3gTYJ3hK3zNjydVTC+jcUXfoz+LgiJER27LAdYgmdGwCR2bs5iXblAePETu
 5VIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdiP5K5uLQwvSiUlglE0UqhIOzMMDLSFacsI07AmWdhbnqBtj9O4FnduoY80Vx+ZcJQerY0l/ws0bd@nongnu.org
X-Gm-Message-State: AOJu0YzVobJs7mwC99b7gA7v9veIQERZi7vKLbcyzAEpuhTC5hzMyOQP
 ViAXGlOv0YshUezQAZA35scImku5ZJ7plREdHYMWTpEjFYrqzo+t+ejEwgjCjNew6ppZmJgQ7DW
 M4157hb8=
X-Gm-Gg: ASbGncuwYKl+U1N0fSfFEo/2Bx9UfL0ts45lENRznZrbX79z7VgpaQMD2gfLlhMfMsb
 ovFzLuhMPZwvIz01uALg/lGDWR9e8V5IKmrl79vRJX0sWDDb/xKPR0mvcjOV98hL/bNgCnHOmaE
 PawARoc/LdWrBC2oqX/Lr7G9+7P5O3IdoFmxTUSlIxc/n3GwUj967pKXLPTx0zJ84KuKlwfP3XW
 rThtypbZTgPwS8ke+KBHqzsdEIwfVvCBqnl2wIJg09FYrmKO9XlnxYi4OmOtW8pZPAyvjRphxeR
 WD4cV/6Y64ilJtLkzrOBKW26aYv7MSVXT4jHQtIQCyI3sjhHq5JmR/jgiN4b57bhhQ56esJeGav
 HR+tErjowanqZTCbFLdqbhqrqGFw3kqCZU+Xwmqw9P/e42dS0gFIyeOWN5F+cHIW+
X-Google-Smtp-Source: AGHT+IExhKowwZjyBl9bRlXFoIM6XUPNXfP6Cl/sFhHFpb7jQMlSlq2XeZe65xxozLvx8upuX0aCcA==
X-Received: by 2002:a17:90b:38cc:b0:330:a454:c31a with SMTP id
 98e67ed59e1d1-339c27ce0e1mr16063896a91.32.1759849019965; 
 Tue, 07 Oct 2025 07:56:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ff0dddsm20204735a91.18.2025.10.07.07.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 07:56:59 -0700 (PDT)
Message-ID: <00fb1298-d2c4-484f-9989-bf88eefc84b9@linaro.org>
Date: Tue, 7 Oct 2025 07:56:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/25] target/hppa: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <cover.1759744337.git.neither@nut.email>
 <bfdf4d5590d40c345a96fda9bc2dda992721f073.1759744337.git.neither@nut.email>
 <411110f3-dcc6-457e-a64b-c038e616d8ae@linaro.org>
 <ceaeff0c68fadcc2069c359aee72dc6c6fd52f90@nut.email>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ceaeff0c68fadcc2069c359aee72dc6c6fd52f90@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/7/25 06:29, Julian Ganz wrote:
> So that implies that there are no exceptions or interrupts that are not
> represented by a EXCP_* constant/definition?

Yes.


r~

