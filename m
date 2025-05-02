Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AF8C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 15:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAsPe-00010H-Jm; Fri, 02 May 2025 11:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAsPc-0000zr-Dv
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:34:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAsPa-0001i1-GM
 for qemu-devel@nongnu.org; Fri, 02 May 2025 11:34:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so2103825b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746200089; x=1746804889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pnvKlw3YbIATeOzIzcRa3apb9etEAB1+8UwLzLA5Qcs=;
 b=ggqLSVAM1VpSoVDe4GAR7qFcdwjUMbSeWRlCrcqqw4PNBF/Nsx7p5l8jlqtmA31bZD
 YUmZcJ8iomsbJIBUmDP6/CYVsS2UKHVFAjS475NncgUhqnsBSw+X+bEZH+d7kWWhVQPB
 TTH+mhD8tMDBkftwLcDL248UYG+xqB8TWhn5aSVhHtwIH+xa+2IAGmQddRyIGJjBugwk
 9S/dUkTFbhMDqGPvQ8ew4ubKpQSbIYAP3c8Aapa3bnWhHDHdb+s6AnhE6T6r6kBPtapD
 5jmax7hX1twJTqvHeBRz/u/3OOMW4a/lYd2kOOPMhG7PVmPGWso3e4Zq61MVjY+apw1U
 8MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746200089; x=1746804889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pnvKlw3YbIATeOzIzcRa3apb9etEAB1+8UwLzLA5Qcs=;
 b=n33LUiCT2RNY0VGMMCq4d2DmLB3N4wWum4EyOQ6x4JHCEnCo812zXJOUnnNetY0sKc
 e9QwdH9MFO++og0MC15DcenvHF/OnLVAkKz96YlZxIB8xpiLBgbOCDNNGQVWsuLlxMq1
 QKSww0eL874a3VmsIp2yxtSf/vnmwtNqbn+x0z22jbJ+cjktnqHW8jwci1rcvkOca3qV
 Fy+clXdSSN4AtoD4sShW93yYvwveLI2leFL7DIxujXV9EHTq3cVBbvktNOYuVe2IOyZt
 +Tz6gt4JiaMzgaDeMHNkd3ICgJjIy7roQgl8nhJQvv3LjC6Umy/vNzjHBzXEBtXHUN4Z
 UAUw==
X-Gm-Message-State: AOJu0YxKGMaVCJsljWFXQuksT4AvzV/PKnA+wrzfkMNdYgua4q0U5PcC
 uLPcLPJAAApOEDyTM9s0UieaatynaHDulPuNb8ahaaEO3otUqSuve+NSPrT37zopnvzAw0yrB7t
 O
X-Gm-Gg: ASbGnctvI2kYgK7kmgm/9mOy2lI4GBHBvMqkWBm5cwzpybcgOc0P6uw7FSqAusAfdKs
 wazP5kIigi4CoY0AG44bnqeq039L9HBZfQVPGq6y/OMoljqJ83h9PvrMWp+g0DSYO/sPFJDOxN1
 DAbAiUQuHPmTDJtcFfkJXwcZKZfPt7kxku899Bo581QJXUTiR+xtDkntSTIfZk2wdSrUMHUNGnX
 mTp6GPQrXvt2+oKVG8JCzxPxPeoRW5Ycg+BHYgNvssdEJwCY8jUPlAQz1f0aLgl0fa8AI5DNHc6
 OH5QH7i1/5bzddM9xqTHVetNl5KaSaLX8YpNjjgqnjpBApJ+TZ7XKFCTKKg88XLIAnDeOMI/A6t
 5T9lsLoU=
X-Google-Smtp-Source: AGHT+IFf8C3uaH8NyfzrhtkLmUzvFu8APKIJg+sGuLPU9QYaBIox9nVzBwu0+VriNdK9An0YrvmxrA==
X-Received: by 2002:a05:6a00:4518:b0:73f:ff25:90b3 with SMTP id
 d2e1a72fcca58-74058b287b4mr5415092b3a.24.1746200086936; 
 Fri, 02 May 2025 08:34:46 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020dd4sm1703259b3a.117.2025.05.02.08.34.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 08:34:46 -0700 (PDT)
Message-ID: <689a43ad-a015-4e9a-80f4-ef19a40a794b@linaro.org>
Date: Fri, 2 May 2025 08:34:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] target/arm/kvm: Drop support for kernels without
 KVM_ARM_PREFERRED_TARGET
To: qemu-devel@nongnu.org
References: <20250318114222.1018200-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318114222.1018200-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 3/18/25 04:42, Peter Maydell wrote:
> Our KVM code includes backwards compatibility support for ancient
> kernels which don't support the KVM_ARM_PREFERRED_TARGET ioctl.  This
> ioctl was introduced in kernel commit 42c4e0c77ac91 in September
> 2013 and is in v3.12, so it's reasonable to assume it's present.
> 
> (We already dropped support for kernels without KVM_CAP_DEVICE_CTRL,
> a feature added to the kernel in April 2013, in our commit
> 84f298ea3e; so there are only about six months' worth of kernels,
> from v3.9 to v3.11, that we don't already fail to run on and that
> this commit is dropping handling for.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/kvm_arm.h      |  7 +----
>   target/arm/arm-qmp-cmds.c |  2 +-
>   target/arm/kvm.c          | 55 ++++++---------------------------------
>   3 files changed, 10 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

