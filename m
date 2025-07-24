Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAAFC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 09:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesUa-00045A-V7; Thu, 24 Jul 2025 05:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesUI-0003vI-Dz
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:43:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesUG-00077A-E0
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:43:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so4683735e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753350218; x=1753955018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FxEe3tvHPZUMb5s9JGfa9aJ4y1IP9SlYvu2YCVJXpeI=;
 b=mtHA+fxPZAVxeNq0TBpK3WrHT8nr3HwjV5YEt0VZgG3p6R0DijzjCRqKgrvsckAsmX
 UePUsYBeNOMKdNkSyrMu5hIjBqVJ9W/9vbxPLmoT6imPyvAHyy75xpvXbhmCCIjBmYyK
 IgIgnKAtml7/DETaxOibfqZcyzrOSJpbtgy+dIiNPkyPf+uLQmgi93AggXgtk9/dR/L+
 On43/1bL63Kw984kgf9yBBjiajDM8+qLe2fbkbPTbhWB0WU541s85UIYpu5EGEgeSurY
 jki+z256PoMHxp9GemfErXxo/UNeQD+aIzAeW0VZozZ0/V2xPpZwrpPcRcoRgJjgVwXU
 KPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753350218; x=1753955018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FxEe3tvHPZUMb5s9JGfa9aJ4y1IP9SlYvu2YCVJXpeI=;
 b=K8T14u4uhEtXs1skZrgJ78GsLQzLau5GW6fyEeLFrp7wJ60tRp9IdPnlGFeeXEyX6O
 I4wxr3JMJQDV7ORjAgo2stnNtV1n4SN4cR+rPyGEn62yABeZFE0AAFK4cd33HfISPIBF
 T2NaGGKE2fqcEcBXeLvawIzx4hvnDgyFVSTSkLa0+b8Z8jHkG3gWIjut79+PCN8pksFW
 CQz+jJX4loRKvflnRRfXuNiKP6i1no2jRYZWtxMo+PnfJqglbOBCJGRbYjZosnxosfkq
 9ktpKw/JZ+toO7/gXbL4fMbfS+f9kVj1x6B3+9IZG82gKuOuxQHtH7fKJxe6MRZeRbAe
 Ki6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvESrLIPFX3TLDdqZkYFYtTYk4xbxKZ+gPRSiLQv7JoA0dPC5ZK5Iwu3MwSmuuKXZLjFjHGHvhNdOd@nongnu.org
X-Gm-Message-State: AOJu0YyIBbr62EkAO9qOInr52KFlAIC0qq+dnxW/bwC7Us7tQT4fGw9l
 vWt3TettbJCzMk5oWzjLZ8hrvT9lOBUxfFSKzrxC9a00lkroeZnvG9vEsRhADcyUEW4=
X-Gm-Gg: ASbGnct78lS03Z3bOHpldLiUQQtnE4C7kI48wSgc5+Aocc3855kIkseiPImFEDEBvq4
 ekgCc4dZ7eIDJ1EBnoUdgh1Y/DaOppSJlHhp0WhIUuO8aRMZr3XfN2K/Nrsqep1lxcYSRJ5XaJe
 VbYxZERobfuXmk0uWC64dhJTT65DY1WqY1IWMa4a6TRoC97oslzPLrqClol49FilzIUWnFygzSn
 w4f4vAVJCTl3oq6Ou52M/1L0lQgR5sS8e7gP/GBx8oSXB0xwJtzqQKAa+G7owO1dpjDzrlprdx+
 LIzkCgZU3D3g9NSPqV999+Jobgu+KBDVpsXGCHpNYoj8zIvU4sNlreDitFZUcKFP7NdLp3gL6/k
 2hk4OEfYG7ZUrTnrUW8JVV3WilPrdjO+3+eyOTbdZreJyMLztGjxEWP2Y43ypl6Thqw==
X-Google-Smtp-Source: AGHT+IGc7IZqq0yUZpfg5J2WUKfe2ZlNiM7+ltDcfuEea1JtZGk9F5vqwX244kfSUDus/dmkgKyChg==
X-Received: by 2002:a05:600c:524b:b0:456:1d4e:c14f with SMTP id
 5b1f17b1804b1-45868d69f9bmr49060855e9.28.1753350218331; 
 Thu, 24 Jul 2025 02:43:38 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870532a4csm13625945e9.7.2025.07.24.02.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:43:37 -0700 (PDT)
Message-ID: <7b562204-0add-45bb-ba3c-f497dc38464e@linaro.org>
Date: Thu, 24 Jul 2025 11:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] MAINTAINERS: Add myself as a reviewer for XIVE
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
 <20250724063623.3038984-6-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724063623.3038984-6-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 24/7/25 08:36, Harsh Prateek Bora wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> Proposing myself as a reviewer for XIVE on PPC.
> 
> I have been looking at XIVE in context of KVM internally at IBM for some time
> in addition to testing a few XIVE upstream patches; and I'll be closely looking
> at XIVE going forward.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Missing:

  "Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>"

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ba161d75b..f3f981f90d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2781,6 +2781,7 @@ T: git https://github.com/philmd/qemu.git fw_cfg-next
>   
>   XIVE
>   R: Frédéric Barrat <fbarrat@linux.ibm.com>
> +R: Gautam Menghani <gautam@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/*xive*


