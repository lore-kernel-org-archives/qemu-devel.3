Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0CBCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RUQ-0000as-2S; Thu, 16 Oct 2025 13:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RUO-0000YW-57
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:10:08 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RUF-0003JW-Dj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:10:06 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b550eff972eso659088a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634595; x=1761239395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EOjz/c5wST7NIv48Ee5SoeyTWulVxW3RZCbLrT8nAI0=;
 b=iPAFmk/ieeQMApQE1vdUFgi4e+3OCE74Waj/1NwJooVKDQWB5CMpITfn1iI/lpTs32
 xhmfdHCiYIrHe0HrRS+V2/4gKpCya1YuSz7tyHQrrxD7FOZtapkGYeOV5AsTHQrGGnWA
 eB6za15EJxLW/yupbEyAMSH3m4W8lbB8EZayO+byOA8Rap+w5FyNFhz+MYO3WjIc3ZFd
 hl6Ga86Jk/V2sE7ThRysiTF28HT6rlYEAHLIDmLFMUNbVNbUkPU9boy0ywHe/dQ0ENOa
 CXMarb/cZv2dGxOt0gj+u9Rx7qImW+/ubN3iwjWQNxv7B7aeVQN7MOTpJ8Njjo1WCYog
 j52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634595; x=1761239395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EOjz/c5wST7NIv48Ee5SoeyTWulVxW3RZCbLrT8nAI0=;
 b=M7pxsIeR5VJgX0bKa5WkU5+1UKHPFUCxMS2RKurZ5bkUnjj4fU0BYQP6ACjBv8quOB
 rKkRGwRRQOFvPdELeM27AT7zWrbLOLq+R0NpOZikPh27Fct49idFkspNLI4H8DMbZB82
 PlHR/M427B53Xn9pnYNTjeqtpJU+0GpRQusDSXwZ9HPzCCI9YFoRvDsi+u6vWlm7qxZU
 0s/d8zEUambff63QDVcBPSlZ7vwFm6Ghml2OkbexTIO8R6Mn0k2TFKXjArmjIRAufMqI
 PYU1LmQRzRaUT65HYp58QUuqT5x9BrBleOPixHAFDVN8ewXQdSy9l88AFxIQBivjCq9h
 IlAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa9M833We9+cXTz/9KMCfC4i3sVzFs34d/gPSHIreUo3t+8J2hnbqn7z0o3AbEI88VuXH3JR02SqHI@nongnu.org
X-Gm-Message-State: AOJu0YzK99AIPtfIsk9N/+tduG9UiQKZjFU9ZxAAuxX2WMmcldA4q88N
 n1TIrTHWXon3mN1r6LFcmxmtFnn8/u//mRkZUmNHnAJU/TXEd+HV9+vQUNnl0bgMlfo=
X-Gm-Gg: ASbGncsLbd1A5+S5zHpBqw3aiFxxavf5Cdi5oqD3UM+FwyIH/wRwFoi7f9hs66YInZr
 JMiKY/6hmWSPjvpYpGkOrXInZMlGctxCY7Sjpjc7EQB47LUHNu+rEvsw5S/BjhlU88eCFANJLht
 FvAvbeZzQcZcpUlaxa9Nz+hS+F99tbduFdP9uxT2GPPjHDJX9bTCQeswnT286ItWIZaFF0LAWPk
 1pJp6SPZzmJFeZYscX3ahuJzQaq53vVfUNSbNsV5ka4BtpnIzpVx/h3iVV7fCHRLP1P4NOLCLHX
 XZaklxoySIYWckj6yaf2qnR7iBTn7a/JeMXtJ4Qayj+bvKQfUomRobZgDEEjFcATFsqwK0L3yiL
 T6NyLxSjVyZy3LGl8wPN0sQqXiMz6BGqtKvVpANBrGIE/izAfqWV3o+EDEDQ3QDJW5lFSVjPnSU
 uw0s3+g568RBa5
X-Google-Smtp-Source: AGHT+IH454vksl/nQZhrGv1L+yzrcpI+GW90VRdH1Rk/iZLfB8lZDs+K/NIsBn3ecKqThpGf0V9tLQ==
X-Received: by 2002:a17:903:19f0:b0:249:1234:9f7c with SMTP id
 d9443c01a7336-290cba43817mr6208675ad.60.1760634594911; 
 Thu, 16 Oct 2025 10:09:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba4d3sm35792775ad.83.2025.10.16.10.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:09:54 -0700 (PDT)
Message-ID: <d0426753-4ce1-4e37-9086-3609164affdb@linaro.org>
Date: Thu, 16 Oct 2025 10:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/24] hw/arm: virt: add GICv2m for the case when ITS
 is not available
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-5-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.
> 
> As such, support a GICv3 w/ GICv2m for that scenario.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt-acpi-build.c | 4 +++-
>   hw/arm/virt.c            | 8 ++++++++
>   include/hw/arm/virt.h    | 2 ++
>   3 files changed, 13 insertions(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


