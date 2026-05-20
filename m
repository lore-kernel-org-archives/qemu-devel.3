Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2896CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmbA-0001ax-SH; Wed, 20 May 2026 15:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmb1-0001IL-Pe
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:28:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmb0-0003K8-3t
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:28:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so46540255e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305325; x=1779910125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s2RepDh73ASKltr1UR+IBzN9PzOIPR/j1a/N7qdttY0=;
 b=TzR1OvVTogdxa6/rGEYIX0dn+XlAD3eYgMHBI/UUXz4a7gaAc5wZfBnezlqd5KH//b
 QmXR4eR93JkePG6/TzYr76JyEPufmjh4HEOJjlityLXo0T4/lHfYbQ7c0cemtQCS+YxI
 gjp0yXzF2PB92VVnalunFVb71+St+p1G5DWA/arSud0kNrlxnfvtbeUvjrYeZCQVSNGW
 6qnEJTfVB0qErKxHFs5Dx9fp5n2SbVcDzftqHnPyET5hjMvLxJGGR3kNBXK5zwGk3Ot9
 sopZuIRLjXlzN5IwT77mCpXLAZOz0iFu0hxeOHN/SXuptF8migwyZ0kBrqnfvWG4D7Qp
 rHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305325; x=1779910125;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2RepDh73ASKltr1UR+IBzN9PzOIPR/j1a/N7qdttY0=;
 b=T4hbFpTH124PkSnga8f6IREEVfm9ng7rsrTWsxWnXM9bjqStekMN43bjW/iCdXYJEH
 6KcX3FlRj8I3KzHqVgx8110wiDURKd9TcQQyk6gVqH2wU9JxUClsOIF8GVIMDMbBFUkn
 QdYKwiWRapzg4SjP6GGBgev0Xd/KCg+AKh3LAf1z0vQi93XyzdPiT1/NjhmM7zjedQ0t
 XTIpRUr70wiDM2Of4dTGjVcA0bCayNW7X6g14zyX8ayInWO74rtgWvgF3nrc1We04dUi
 lH5MFUYUsthuCi7puYbJIgIIWC/ZlJdYPY/LpXnFpaZ8aez9bffLDK553gc44gSRjtzF
 6kAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/T35PKxxQLFxkNdP1hjycWwOGIx7B2VgnWCD4oX4gSAYhYhIMpvLG/pkEsdwvV38DnHbJVQKWOyPvw@nongnu.org
X-Gm-Message-State: AOJu0Yz+RC0TegcHFHtQRjtFcaG7JTtLVqM4Fv81D39eZj+QPHqF+OS7
 /TwPqVkpeIB/8o9L2NsZEoxI7bfZfDwxbPfpvfAR15mMWOW0ToU1MzOsDsWUee/U3iY=
X-Gm-Gg: Acq92OFyvU4yy7cRC8zIBbX5dxynwnvGQot6M2ib980GyUldYoxE3ZBuCmE7lzE79v+
 jXCUt+wWExLra4/iYIgZRHX88QNt7VWbe6Nehq7eayvHlx8rL1l6drzE3dXD4e2nDOd/wLHWzq/
 r8o1S1MhPTmZkyhNQip4V6Z0pXgfUjIAvBx85Ts+RxPgjhoCiCxyBV+LEmo7fmA4sICkYRIyIQ9
 EPsCGPxEB063LwSJZN869HGQoFZggwO9pmX5rvKSqJKszlvJxhp0e6WEWuWzjxVWHBnwA9+uVLM
 mRJ7Ega5DGO51BMvcFrxXrIjTBFFjz7g6v/1O9iPwWQLCioR3xWr2iLMtl2xhKxxjJzAB/bH1BB
 AK/uVlP4oFKJusvUkGraIvvHAs52YVR6Jp/P4Hvj5SyUcOAj7bWeE56FpL9dHHjH7XpIQhWM4zz
 gVR2t/UhcGd5shEnwfyXka/7mi8PmoWBAsqbz/jeEEuPLJA3d5ZahodIX4eK2rIf3V/NKSjMgxV
 eJS
X-Received: by 2002:a05:600c:450e:b0:490:778:4fe3 with SMTP id
 5b1f17b1804b1-49007785042mr246887505e9.32.1779305324420; 
 Wed, 20 May 2026 12:28:44 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm140131165e9.1.2026.05.20.12.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 12:28:43 -0700 (PDT)
Message-ID: <b2b1b3a4-e208-4fd6-95f1-0d7fa6f5807d@linaro.org>
Date: Wed, 20 May 2026 21:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] target/riscv: Stub out kvm functions
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-11-d1123ea63d9c@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-11-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Anton,

On 20/5/26 15:13, Anton Johansson wrote:
> Functions used externally by hw/riscv are stubbed out for non-kvm
> configurations, allowing a single compilation of hw/riscv.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
>   target/riscv/kvm/meson.build |  1 +
>   2 files changed, 24 insertions(+)


> diff --git a/target/riscv/kvm/meson.build b/target/riscv/kvm/meson.build
> index 7e92415091..d3f395f431 100644
> --- a/target/riscv/kvm/meson.build
> +++ b/target/riscv/kvm/meson.build
> @@ -1 +1,2 @@
> +riscv_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
>   riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'))
> 

If we can not use stub_ss, see commit 0da978cdbc6 ("target/arm: define
stub library").


