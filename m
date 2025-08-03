Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08BCC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiN8V-00007W-Bz; Sat, 02 Aug 2025 21:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN8Q-00004y-Ou
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:03:36 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiN8O-0008LW-DW
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:03:33 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-30b71d5cc03so486612fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754183011; x=1754787811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UCx0iuKWdGN4ZOgqGCUpFnvyWQUbbJZ6E46VDlhuBII=;
 b=XFML4+wSeaV1+WgDlJ+hv/OQP6kQvGHOt/eUBY5NNKGEnqh4+ce75FBnGs7K3yvv0C
 CKD2w8lN7hZLo1VngDrq10V5CUebGFjEEdDvIeYXOLjWuJrOxE+sUa8KyLzxfanapDV6
 Ko7GoVnLB43hr+GT7rY/bYKPR6F0TWziIgqRHorUgSj1hU0Rvkx1no/BlYdFcIc9Nrkq
 VQSSaXEahRo+Nqq0cx3MbHKNqaHUPvV5Jm9Ppjh6R0JJODsHiNLAZ1iMmoQ4ygMOPBB6
 ypOjECQv4QzZDL47T2B89nxr26gzJEFVrzp0oyvm6cGEq4cwFL92c0myt1wLD4fWG01S
 NNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754183011; x=1754787811;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCx0iuKWdGN4ZOgqGCUpFnvyWQUbbJZ6E46VDlhuBII=;
 b=Jk177tcb3eiIyJmJOtVDzfOkz8SxtqPV0h9R2A14KYyA4kDxd2wMG0/SNgG+m71hGa
 WY0u42YPb4xmdLBYNdS7+x0Iw2Bz6dvg/lnCYP+pFyTu68XIaCfSpD2R9y9xKlqpwAS8
 cjF5/gJg3kHoEM+qxLxRYWlU+k7fVziIZlTTQruPl3kJ42kOBbqPagMDKkj5qzydNtEC
 HXu+QV0GHgNEeWHhioYvdygVkzfFxGGfjXtfeDrDLf8KUvGwLyxqpGjGlfml109sSkC/
 QIvxBSoZLbpk2MRB0QjRbhDOP0HnBUvdyi5yIEyhmNkwvBZvpyQSsUKu34S3Ldj3l+HX
 ljOg==
X-Gm-Message-State: AOJu0YwM4Hamevh7O+WRL1dNpcvVkuDdm7hmiVW/F2EAUgwrUjfjX0Ev
 yyyaK2yaREQKx1PGmVemvr8omRBWA7UJzxGtC4s5mS6t6MrQ486oKIY6aZ7R3gAF9nXe4LLVanU
 61UbYt1I=
X-Gm-Gg: ASbGncsZuIwDXvLabSEi6T1FAQNf6m6DTgaOxyrgQOS8bASwCgqV5BcNYqvdkBpULXt
 YMyqs9wzzLtyX51hXODu+Iu1xfPTql5U7QnwlMT3LFK7t0JxYzgHgBjXoIKAMOctb6Gj9yKZmOA
 Rq7X8fdyqz6ESIKeNScNLjp1gj6GWpNYeaKyRym5mjM+PbqtmcpeDacAsKbki08l9V4EKSk7Xaz
 CtdfUYd1dLZI4jfOX49OLCrtebk93Y3hQkw4mUGY1FUXFCCGEd+et1A1/R8itUNXO+pePsTRDwJ
 UbDuscSLRoqAJrivQs2kh0Px+akHfo51rn9IpNARKY3sbL41hyIV9muVPoZuU0D0Ph7sPIY/N57
 eLfJFulH7a41qp+QtI/F44VPx2g9R09s2F+pNMU2SJbru2cvvebOdzWfVE66dWe7QZQwmP+FhsX
 Y=
X-Google-Smtp-Source: AGHT+IFtRGvFrW/lQAwwSWu7DvLYbU/hzBCAPi64MYZl8rEFypB01G/DNwfqSucApxMu9zplJwH33g==
X-Received: by 2002:a05:6870:c143:b0:2ff:92c6:51f6 with SMTP id
 586e51a60fabf-30b676a8a89mr2365581fac.15.1754183011060; 
 Sat, 02 Aug 2025 18:03:31 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a4dc7297sm481337a34.5.2025.08.02.18.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 18:03:30 -0700 (PDT)
Message-ID: <9904edf1-9419-4dd7-ae82-1c4668a3a98e@linaro.org>
Date: Sun, 3 Aug 2025 11:03:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-5-mohamed@unpredictable.fr>
 <712da351-3bf6-4a31-92e6-b198d5dc21ff@linaro.org>
 <533A5BF2-9CD5-4FE1-99A7-6E9FB212CCBC@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <533A5BF2-9CD5-4FE1-99A7-6E9FB212CCBC@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 8/3/25 10:55, Mohamed Mediouni wrote:
> Arm WHPX has no specific functionality for debugging today, but we could support kernel mode breakpoints via replacing them by an unhandled hvc #2, stubbing might be the right route to go...

Surely the debug registers are usable?  In the meantime, stub functions which do nothing 
are better than ifdefs wherever possible.


r~

