Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5DACCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC14X-0006hR-0f; Thu, 23 Oct 2025 15:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC14N-0006ad-AR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:56 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC14L-0007QD-Fo
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:33:55 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-781421f5be6so14294337b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761248032; x=1761852832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FylDk0Y+rtuJVpdhZSgzoQvaYPUSChHy/uTwrM7ENlo=;
 b=de1o5Cwg0hZXo7qd2C7oOcYICjICJVE0sdgiW5gFe0MmaBFpRDBcaeLaFdqvP1UXWa
 CJ0DuM218NWW7GqQ5leXmsFNy1319Ks47Qg51/5/l1iPuHdZQl0SZW8vpVQhU3Ugze9U
 OtEDwW9e9M47577kbVCcprQ7HBOeZlvqY8s33fYbT9dCKPg5jCRG8laqusUhGqBvo6EK
 TKBy1NFVxKyofgcOg5rrAfDALkCGvzLAHaChmWPMEI5eynQlwT21S6SRjomG+xSR4jFK
 MBD0X8klJ7YRIQ0FvSsJhUP5sTq4CcX+Qoyy3ytM348jl23pHdRbjrikRNfHHIwJtTg5
 afLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248032; x=1761852832;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FylDk0Y+rtuJVpdhZSgzoQvaYPUSChHy/uTwrM7ENlo=;
 b=sm9lT9nQqkWpe7NdAJOPn4X+Qo7Qph+eolHiO8bT+FUoaB+Ty+E8EiKIhzW9z7kDYx
 S886YMq5on4GiRrGH/4vLipKsmnoTr32vnIokaqofCTVQv3n+F7xIUuRI86P4aZNnZJA
 718/59lZERgOsLBb8g7DVmylRC6e8BOqsTud/yurkWkIxnBtD66fINdbCk5ou/bn09bs
 ajO7RdoN9xOS+MwH6c6DLigG0ok/483UU+b94v01kCoFf+OXRzIMZxo4kG++t/8LMalv
 T4UCd+WpI+cHTDEv0GPyv3G1JUukXhBg58MGuOo1Y64JQZXzgIGKLL9I1V0DFwrSjNdb
 YOsw==
X-Gm-Message-State: AOJu0YxSteHpJeuYzS6mQXLk1PhR2eTFBM9nVeh0tM7hPpij1IGO59S2
 SAlgokRCuStH8PmM1c0XMWAgpm4EWO+fVQ0QtQUuzzM+kn0FZAN6WSNX0cyeOLxsF21+Gp3pmpF
 fNgr0
X-Gm-Gg: ASbGncuHzZ7BEuw/LQyzvDZCGyW9oeJU+r8btdQEeFDlbM/UxHLESBBMPTclG2iCw8x
 hbilKTBXswk7LoJwPf0wzbCqQfpbcpAKWFUzzdINCUIvHDgoB1arvEQtDerBM1lUoae0iE0VRU6
 xKOSjMv7lXtZ5E40OVX6bA4ysGpfc/ZiRHBuudr/Y8hzgM38Wv/brVBTF4jJzGzAkJ9EeaqotN/
 Rl2KMBJNSqJASvAs+4N6CzzOPZNXRWFkiT4VgoLP9LZQ4QkX+N+YGzZQyWYzfi0PRNx6zMUvJmk
 9TNWdU5o26b3Q2acjQk8CXWFqh4MetO8t800RdeXjBGhMvAJgytccx4yZCfqdRIxwzVYXsj8ksi
 5INlRQbT8QEZQemCtpHluGtjmFRdXWdO8rcnE/G5tu5U+Lf+xBd6/HUyblMrE6mDCM/kBK3XdCd
 aNCsXe50hXQzG2IAwjGFZSHvtjgreR8Gm75YKW+nFPJ+Un+93Ro8js5rU8xLW2RYNbM1Vj6U0=
X-Google-Smtp-Source: AGHT+IFcmJJ9hTI/uWkEJTcx0s6LpKPIfPqjlStlVV1TK22bIrrOMlfnWARFwno7vWWfPGRT4HyEow==
X-Received: by 2002:a05:690c:338a:b0:739:7377:fda6 with SMTP id
 00721157ae682-7836d2d6462mr238040267b3.42.1761248032033; 
 Thu, 23 Oct 2025 12:33:52 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df?
 ([2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-785cd6ec6besm8041447b3.50.2025.10.23.12.33.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 12:33:51 -0700 (PDT)
Message-ID: <15ea559e-e7ae-4a46-b59b-9d4741960007@linaro.org>
Date: Thu, 23 Oct 2025 14:33:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] target-arm queue
To: qemu-devel@nongnu.org
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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

On 10/23/25 09:55, Peter Maydell wrote:
> Hi; here's a target-arm pullreq; nothing very
> exciting in here.
> 
> thanks
> -- PMM
> 
> The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:
> 
>    Merge tag 'pull-vfio-20251022' ofhttps://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251023
> 
> for you to fetch changes up to 33eff5c84d52e7186e0882ea5ee9ac5501c3deea:
> 
>    hw/net/rocker: Don't overflow in of_dpa_mask2prefix() (2025-10-23 14:13:38 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * target/arm: Enable FEAT_AIE for -cpu max
>   * target/arm: Fix reads of CNTFRQ_EL0 in linux-user mode
>   * target/arm: Implement SME2 support in gdbstub
>   * hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
>   * hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from kernel in cpuif reset
>   * MAINTAINERS: Claim the Arm XML in gdb-xml
>   * hw/net/rocker: Don't overflow in of_dpa_mask2prefix()


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

