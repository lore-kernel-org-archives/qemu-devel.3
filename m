Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77F3FCD0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2keY-0000Ex-Ro; Wed, 18 Mar 2026 02:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2keW-00007j-Af
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:45:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2keU-0007Lw-Af
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:45:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b4d73463dso989226f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773816309; x=1774421109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YBu/BQca8qiP19O/Yadlfxztekdwc07JhNJsLJq+smg=;
 b=oiNvYKCCQ5jHbxP8KVNzU30FXx6pmbYvQKhiV98zjxMHWMJhoFE0BhWeGNS85DkAOR
 o4K4dgXhA5pcuoztrh6C3GYhtnzKwAc+8fSSDjrERSRSMK0pHbFxTgi82IJOu/xael2h
 E2WEfrRESIuUAzDBd4aejkguMtf/kQEARc/Gm2zIaCcDV8qRtm8vidLOrWlOWlK2HS4X
 lpA7TftJdtuxcpTAUmD4LBzbOxjuDYets5GVb8Cdm5RSlshHV+5QOqaMh8cvId4rTTsi
 q4RB1/Qb/CUEMV/6I+p4cMQIvUNbouaIe6FOl0+lGnWscbOSfLAa92cZj3yXi4oydFrf
 23+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773816309; x=1774421109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YBu/BQca8qiP19O/Yadlfxztekdwc07JhNJsLJq+smg=;
 b=BY9fLY7cNfbYXiyChclXAqF9k+EH3+iBw/+gMtYWEx3xP++tf14i01v5iItXj+sSqm
 OHXA0Ze0ciAc3W/PsoffNhZQfrwvzKr1qw8iGgs1XPodRo+V/eZa9vjfSNh+LC0qkCQe
 vAQ6Xj+qm5t+jHs0DTqL0pjqhiQrO3CuwZhBKWbH8LJCBHVQmbyuC4oZY4bVKKmkrluu
 xY6oCdmb9MRyJaYKP3Vdx2AC4FEoKaMTJ4yCTFbMPoIffVGSRIXoYN65vqH9cFskkDB/
 eVixmxdbWCKCPo+jMyzgchMTbBLFuu2h8MYDHzkErBXz/sE60HKwoRVDm9Cb07oRx49E
 DqUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX24xIl0Ect11lin0a2DIGEcdRQQMXb4Fdt/VZrC+FAlGUUVcmDaCyD4xTomBjlXf9IuLmvXWpRCE3e@nongnu.org
X-Gm-Message-State: AOJu0Yz9apBmg+qHm4WkAcJLmtmBEfZ1vFaUbZV50rbfBGR/Cvwm450F
 AcS78wrLa+1g7mKjXOMuLXrwS9b7mTrBW5MfW8KYJ8eFSR/m23KSHnn2vsihTYlECw8=
X-Gm-Gg: ATEYQzx66vCaAjklBpaeVK7Y22/KSCbLDz3g+13HuT6e7xWp+Vwa3FoXj2SSE/JGeMK
 JqYfba6z+UvA9gyPZBZO3E9kB/TFwUKqmyTHeoF6iwavldjmcsSBzCwYCILLiSqRvMZt/d5t62s
 0lZDA59Y4ov1T2+N+/3Noe3MUMS0y2sU2uFbyKEL6Fo0theg/f52oj8LhShGqerxdYFoCBxpSs6
 Ga5G54o+/mi8FqB53P2s4L7HC8NlmfJTHGQTr7is6W2ydocnmrUA7VGpT9iP81t1GmFnmK1hXrj
 vMKO9gsSfXTqnQF7tVUNgowzM64+5Gd5YO58PFSLIemJoAi743FJvyLaFjE5G0Gkx0VZ9iqOcE1
 l1808z1q2Yex6de5DDs2xdFvqRE4O9QQ0Iw/2dQ88QAVPtL+r8lSRtD14/rBtEKNbRKtpQNlTM1
 FP5zv1HNA30TOP+ZSZZGCONKAEto1Iw4TPkBTCeAqAoZicszfW97qloU4aLHDm6/VY5g==
X-Received: by 2002:a05:6000:40e0:b0:43b:45f5:eec with SMTP id
 ffacd0b85a97d-43b527a4c78mr3867744f8f.4.1773816308612; 
 Tue, 17 Mar 2026 23:45:08 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892273sm4362773f8f.19.2026.03.17.23.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 23:45:07 -0700 (PDT)
Message-ID: <cf78fc95-c680-4f47-ab96-43ae2a5495b4@linaro.org>
Date: Wed, 18 Mar 2026 07:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/3/26 23:57, Pierrick Bouvier wrote:
> In case current kernel does not support /dev/iommu, qemu will probably
> fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
> since QEMU opens it before /dev/iommu.
> 
> Instead, report an error directly when initializing iommufd object, to
> inform user that kernel does not support it, with a hint about missing
> CONFIG_IOMMUFD.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   backends/iommufd.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

