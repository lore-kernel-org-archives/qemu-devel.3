Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547E5C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB7o-0004d9-Uz; Wed, 30 Apr 2025 13:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB7m-0004at-O9
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:21:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB7l-0005ji-7q
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:21:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30863b48553so1362296a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033692; x=1746638492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+jr5Js611BWUaYXQ7IElW3L++0mJsN+n0ZQE6VOC5bo=;
 b=F9Oi4WQuShJlxo+KDJsJll3rHulaH4tbgfYkbV8F9ExxBcMO2mxSTjfZ1+7v4MQk/j
 HZLbjMf84HtVW5QL4isMKHt+EU5MYP6xCjD6CRErNxk4AMddM8T9hJcUN+PbmUKegpsr
 yst88tlCJnWNdAPaM2gOaX5RQkiPTW8+Vop/diuHD/dcn6hK9DVc1qD5UVro06nPzl3N
 cTlJ9nfGTcM+qg1r4k18yCXrt3/WMV89sRcv0so1uHllstexOrzCL89yLEqZNfT73Ov8
 T7DvyVAwdTYH74lDgRqjg2yx5GUK/7ZhqVw/EA5QvqVoCyLpPPLYjILarqOPRP27M9pw
 frlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033692; x=1746638492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jr5Js611BWUaYXQ7IElW3L++0mJsN+n0ZQE6VOC5bo=;
 b=RUbs8Y3lzqGSIrJMFM8PSaYMDOv7PKJb4mYeMXUvS9v3IsYVlGAHFbjEE8Oxq3t7dx
 9LI7VdUP6xKIzyIuaibp5I3WtbIhklfibhzN2oKvsYe1abdipPDDpCHbsD9FRua1CRtj
 lT6/yZ3CDuzKfR4gcHkEyWA13TNzQIk1CpoxHv8QrRknK5VCyqFGA8jiSzulzVXhtCFV
 Gvg0K3d/gCzlULtajJLsTeWTOloqnnsFmb7Bc/JsqZCpSgOjf/0F/6ZXQwpsMdf7GvBe
 HFP2p1VfrYYdAI4PzDaCPJKjkiN1v8TfioPy4gTkqqkxkNZmvGC1jFIXirLHWL6E5PdA
 dZqA==
X-Gm-Message-State: AOJu0Ywplm8Jcp1h69ou13OZbyitjxzZ/avhwAKBk/BEKsbcUH/rYgJh
 v3VUf6jGl6E+BoUmCkrJmgoAatMcbXFZPYed5LRgQ70mXWlBqMENzGOQJjp2Om/Kk3B0HyLUUc3
 5
X-Gm-Gg: ASbGncveb9YxEqoiBsjXgVp8vbPL3VOUK1A5FglWtoaVkj1C4ONvxnjtJGNFOUlzT2a
 noeDwJ20WQ6p0Ywn5rIYxrDWvj+l+DZk8AhIBc/WFLaWxBfZY0cVII69pkMGhJoBlgn3owzk3Y0
 t7BZKvQJ875Je+xigCfyHGqcmpUm2b+lSVzBylZOVaFiHej9Bbv0tqD9J30crdtJQxoKxKu3bnH
 RQrtYci8r99DFAGlbZWH/rjFc2hQWOj14ckFCEcTOzakjjgPeWhwRaqCIE1rQNkVBrKzgmiRbkK
 rNXwRDcRZ3vj05XP/D4sGMzbpCz31q++usKCja7JHyUySXxtTxh9zQsM+CBRrh5DGneAeO+S2J6
 WqewatqI=
X-Google-Smtp-Source: AGHT+IEMAB3TEBZOaAG/AOXIqcdwyQcyTrkuSSBwBxKX8afcjmV+Zb3MNoIkfEKMeRuFAAb3hzKmyQ==
X-Received: by 2002:a17:90b:56cf:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-30a3f0b2b7cmr331270a91.12.1746033691817; 
 Wed, 30 Apr 2025 10:21:31 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3464e830sm1934854a91.0.2025.04.30.10.21.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:21:31 -0700 (PDT)
Message-ID: <f21fd2fe-6c08-45fc-b25a-ab4c18c4fce8@linaro.org>
Date: Wed, 30 Apr 2025 10:21:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] target/arm/kvm: don't check TYPE_AARCH64_CPU
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/29/25 06:21, Peter Maydell wrote:
> We want to merge TYPE_AARCH64_CPU with TYPE_ARM_CPU, so enforcing in
> kvm_arch_init_vcpu() that the CPU class is a subclass of
> TYPE_AARCH64_CPU will no longer be possible.
> 
> It's safe to just remove this test, because any purely-AArch32 CPU
> will fail the "kvm_target isn't set" check, because we no longer
> support the old AArch32-host KVM setup and so CPUs like the Cortex-A7
> no longer set cpu->kvm_target. Only the 'host', 'max', and the
> odd special cases 'cortex-a53' and 'cortex-a57' set kvm_target.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/kvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

