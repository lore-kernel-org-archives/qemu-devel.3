Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D48FDEE21
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwdh-00064v-Co; Thu, 23 Apr 2026 12:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFwdY-00060x-B5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:10:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFwdT-0002RA-UV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:10:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so63661095e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776960635; x=1777565435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZomkcSuXAVvR0XckoEl3jABL42gMlPgD2LRjbMRVuM=;
 b=E6sXMHqQGmsg9VSEtbeWnnCOG+PEuknElAIXP7NEm+hvfsk9N1Y1K21WieyYCIfHqk
 iIjqkxwnjcSV4K4qSoWo05trjDdAz9WGITO4SMIBi9Gc1wDpxNTdk0gJI0P+q1a3c7Yt
 +YU/djYRcW5shd7LVWYC3oqoFP4yxNeEMwjWNGnr3R4Mk7pfq9TbrKTPF8TsICM+Dnb9
 VEgrnVXTa+lPAKgnxN53WFdLUS5D+dbqk8kCyh8Ys6IVmjv09t/glaBQnEx+0qdaB23f
 dfm7b3CFow5xaKxYqk0PB0UpoAjeMsur2gpgx3WJJNGLgURKXi1GKp5AFdrp8OtEa0vY
 XZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960635; x=1777565435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZomkcSuXAVvR0XckoEl3jABL42gMlPgD2LRjbMRVuM=;
 b=qpqX+nCt/GnkS15swwyUipQSz4AFi1vXx6HEgmU0wDSwLy0weI6XT1k5vrWKZN3L8f
 U8QTKir0Rs3idP8YZnU3LPE9GiFGy9iEoxhFpAU/gn7JZq1NiOoF62CymQwHTdfpjGNb
 Bgs9/W77lBXCeF98mjaaxHFt0qAG5saK9O8NI8x1yabbspHgirbf1ueagOhOQFs7VZUg
 l4dh/Yg/PYWG+xlWlc4NM571NqZzeN8PjNPJSKAooCzACEUhe54Uavv787UU/WnRQL8k
 HaA2n8kihye1W2AFZ/AlRqNJUg8NGQE0Fiu4vgq4Jsxv+VDdAOKOgvvOpY5pPHriVXdB
 7MsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H29t2TrRZ2vpTvXNC4tEDYnuRgIBRvR3iZQeiYOdBYrcI0ILKWGMQoXDbBZ264bTZ0oSGe4Vf++d9@nongnu.org
X-Gm-Message-State: AOJu0YyKcpmLuhKe7z/vleRSzkun6A7YqlDmcW+b6QTdg7vG5eB0K+II
 7sQqfwCAcXmBJ18Y0hRCbyB3OMGbzVsleXmqxRGzNWe53q4VBfo6tf2DTQIm7i3vyxc=
X-Gm-Gg: AeBDiesDL+3aD6ASFvPITj5GgWa/nmUSm2X/RIBQ07fJZ8je1KaKL3zTtCEknGbI3TF
 +Xwc87TedzJno6cqxKbyU0Jh9qgpz/DGrlJ47nGfI+WlbPQa07vaYLhI81Gl3wFjDn4cFSyA1bk
 Ln9GWaXCyaRD2BOCH7A/Wes6VNLcMB+CQ0WYB9Pi9rWwD1X4uyayJk0W8tTAoir7mJNZX6bFMcl
 2YLEe2IfcSKE/kGc/iWtYzj1bOIp6WPTZXY3gHeRcQvaNTD4mnoW9P453PSNjpifLuljEIykLDH
 oxpjocxFM7gzOqOKh/fa7Jry1Xpn0vBoUInfdNi3vzGMM9sa1MjDOoXhwm3D2A95YlR0JCK4rIx
 rK/vst1Zr33WFy5d70O9Ape/n6h4M3GRtttKKFrh7t9hVSTS38jZpPhmtszhpEATnNV92cnzu3z
 RWdxb9uM8hvU3HIaTWF8CgTq3Jg6CJtCq/yHF3r9kTXjfhDBcNt9RC17JEYTVgnNyHKUbMRc0iS
 LX9
X-Received: by 2002:a05:600c:a31a:b0:488:b241:2c5f with SMTP id
 5b1f17b1804b1-488fb785b7emr291382445e9.26.1776960635240; 
 Thu, 23 Apr 2026 09:10:35 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm184867565e9.0.2026.04.23.09.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 09:10:34 -0700 (PDT)
Message-ID: <07560d55-25cf-4abc-8c58-b386306546b9@linaro.org>
Date: Thu, 23 Apr 2026 18:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 03/15] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-4-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260316130642.13246-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 16/3/26 14:06, Mohamed Mediouni wrote:
> Misc changes needed for HVF vGIC enablement.
> 
> Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
> Keeping an #ifdef here in case we end up supporting that...
> 
> However, given that x86_64 macOS is on its way out, it'll probably (?) not be supported in Qemu.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c        | 46 ++++++++++++++++++++++++++++++++++++++
>   accel/stubs/hvf-stub.c     |  1 +
>   hw/arm/virt.c              | 23 +++++++++++++++----
>   hw/intc/arm_gicv3_common.c |  3 +++
>   include/system/hvf.h       |  3 +++
>   system/vl.c                |  2 ++
>   6 files changed, 74 insertions(+), 4 deletions(-)


> diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
> index 42eadc5ca9..6bd08759ba 100644
> --- a/accel/stubs/hvf-stub.c
> +++ b/accel/stubs/hvf-stub.c
> @@ -10,3 +10,4 @@
>   #include "system/hvf.h"
>   
>   bool hvf_allowed;
> +bool hvf_kernel_irqchip;

This (along with hvf_nested_virt and
hvf_kernel_irqchip_override you add later)
should go in HVFState.


