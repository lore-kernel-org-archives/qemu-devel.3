Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DD1F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGlq-0007UX-Ds; Thu, 05 Mar 2026 17:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGlo-0007UB-Vt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:02:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGln-0000VJ-Be
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:02:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so73891245e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772748129; x=1773352929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wsWrQUpivUrBhdiv7LUNR4ONaQbENTy1T2fCXVnUsVM=;
 b=xAb6gnfnr1O0J+JrwdO65CInXQYbBIbWvba2VhKpeX8ulSfHHRmHtuHrWRMwsDId6D
 AbuSIPE/GZzz8uNoEwlGJi8fU3Ha80yoS2MEira0OfRnUPyUGmL7eERkG1XDLih5mROk
 GQ6uHHY1xtotVxNLaJmMpu1JPiEXrL7PnwmzLQFMEn1rvALG/dSgKTv829gpoycvojFd
 MbUJskgNeiSnkY9fuZaVEXo04hZK425AeP02lnv0bahIN7wvlaObOIPdmdXcucY49vJh
 zbo7x2MeMmfvht64asyue7A+coNNj9QLlKbsxhSQUph59nYWIXlSQ4Hg3rwzKivPeB8A
 9S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748129; x=1773352929;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wsWrQUpivUrBhdiv7LUNR4ONaQbENTy1T2fCXVnUsVM=;
 b=GhMpOtku86taAqxnF0ZzzDciq8dmVCfQQF+9/aR86FKNVXuxf9KvEAe+YXc+Xpvqd/
 hIQpgoM8vD42jEy1XLRVXdqTgUeZpejD+ZmtbczJZ6DURrj8E+xc/I3J64Dz+u7a6uZt
 mbK3Rtj70ZBNqU/S3nZbvq4eU+ychyV/jYzuRkb3r4XGvQ57DzpSoC+xBpeHvqXATP2d
 Rfhftpl8YP38tQMDmFk5Xdj4wqEDMEniMQXYcJ2STKOc4E8Gg7r+molpy+wtB7677FJJ
 h0OtTotvwK/kYPQRKPksFb6qIkF9fmTfozDgAUYL4zRrvnJU6IP7BOsOT2EgmU578s0f
 MPOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWgWJkyXjF5+9AjaMuGx9k1jP/1ct6IVAPxXVU/S1fPPFycZZnawWw6DFgTuYhTqv8KRcN5EoFf/t2@nongnu.org
X-Gm-Message-State: AOJu0YwZm+XmdqcrdIwje2d3mt4k9aqf2lCkwHI9w//DhqgDJ+Mq4Se1
 ppj3riGeKg2kcz2Cngmr6YBT6ApHqy5NTs7e/ylLLU9PfJhL+UN3k6E0SkN/rkN8ngg=
X-Gm-Gg: ATEYQzyNO2AwKhqgUAGQ/9GHel63WEXDpj795HovqD9qaAcIGtZzko8oQ4EnOSzAS/x
 8891Ei9LS4+bzxebs2iHwia/rw51MATKZyg/KM+cEgQjGti9La6EGVa9+fq7el6jBV9q9T0qmsd
 EI49/MmKKjCjO2OSWmtk7ETdQ+c983BCEnkmQnZbq6Te9d2dTEGrVm1fkk+QpR9bbJTqQN7PMsL
 F3yGjh0QQTDzoc7VuvolBHXrQ9sChhEUsjELXafCNKBYDlY916Tt55FptcSk9XetNh0q+ESVXAx
 n+Ck5RiNSN+jzDipXaqw9K1YaulA02dGIVvo/tf65PuRhX7brkCrhb/vAoKM210NFWzctQ4R5Rv
 FmoQyztfRrtAZZoniuEHTmDEKuPL8Zc/U/uyaT2QO+sELUZpqa8TeDtLxUT/WspbjgUbbHJsj9/
 kGMiBbsd+db3pzrbwjkApD7tHbx8T4rtkbS5RMRKN2gR8w9aq9R8Mw94uGdRm1r20oAw==
X-Received: by 2002:a05:600c:474e:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-4851988fcd3mr114547075e9.25.1772748129492; 
 Thu, 05 Mar 2026 14:02:09 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485256b1ea1sm3275905e9.1.2026.03.05.14.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:02:08 -0800 (PST)
Message-ID: <abaf0a9d-051f-4b23-8607-17d99eb3ec20@linaro.org>
Date: Thu, 5 Mar 2026 23:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/12] hw/intc: arm_gicv3_hvf: save/restore Apple GIC
 state
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-3-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-3-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/2/26 23:08, Mohamed Mediouni wrote:
> On HVF, some of the GIC state is in an opaque Apple-provided structure.
> 
> Save/restore that state to be able to save/restore VMs that use the hardware GIC.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv3_common.c         |  1 +
>   hw/intc/arm_gicv3_hvf.c            | 95 ++++++++++++++++++++++++++++--
>   hw/intc/arm_gicv3_hvf_stub.c       | 25 ++++++++
>   hw/intc/meson.build                |  1 +
>   include/hw/intc/arm_gicv3_common.h |  3 +
>   5 files changed, 121 insertions(+), 4 deletions(-)
>   create mode 100644 hw/intc/arm_gicv3_hvf_stub.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

