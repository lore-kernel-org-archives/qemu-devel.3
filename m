Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB106CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulqGE-0002Kr-VQ; Tue, 12 Aug 2025 10:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulqGC-0002KF-QM
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:45:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulqG5-00056n-2U
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:45:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459ddf9019cso18584025e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755009942; x=1755614742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRrRHxmU33XQKErKqkHz1sj1wYaipvAcia+2cknIU7E=;
 b=W41k7RAs7/HMlEfqr0ExsItzbS4RlLf9Mp5qa9/dB3Sdw/YPkwctEvwRF+2pON41M8
 W+th6gb4W0XQrxpSjLIv8QEp8DEV6BhUCxFR91VEm9gkD3ROekcBCpl3p0U0MS5yILpU
 9u+8ffSMdI8nGiXJygu037uVACd1Ie/QbYPynIjIcUtGYq/Kr+Se4+KWK2ItSQVIOhKR
 RbvzHvtC0qnzmoMs+UK2xM9g5heEfm7RIjn8oJtnCDRhkrLs2uu6lA5IQsva7Mkz0aG9
 SpGoUPs9c+nvLGiUtNBQ8fJMU+AoYCYOdAAMGp+LJF+hmv4rZhGLttzy24NOcBYRjllt
 kQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755009942; x=1755614742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRrRHxmU33XQKErKqkHz1sj1wYaipvAcia+2cknIU7E=;
 b=GPBkXVJf69Jm7gZyWqKpYMQYYKFB/oFYEvKMt2snER4JHCwupMYguRIIHmvnLXajWg
 BGqQpSeXKhMlI1tg43G7NWplLpIwwniaB/LS/D8wkab2MUWZRtFdr8BMG7AbKeAVsi+S
 zRS+/rA9wu+iP8kJFWE3LAK1lt6BP932GicMMkQG2X9plQGMQqRT1QGuMtrCgsllDvV2
 /3RN2G6oRDRcLKrHdaTA4XWEq4AAWXeXMDGFcChrylVQSw+LiZ1XBAS0X+9YNAwlo85S
 Io5JX6+S6whv/wOB4sigHF8OMp3Ic2LDu6OtkSo/HEPz3wllJLsvXW7YSyzSITHKQaqS
 uu/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ5FEtB6uCZxPDrRIQIwzfIlsOjQVA40QUntBF5PqSL7/p2fx6tfZ7LUFDprgjDoY6BkBXKLaghPwB@nongnu.org
X-Gm-Message-State: AOJu0YzmEWX00Z52tnf2SNFR1reS1AKKShkHnwQpLuuY805kxm6lyMIY
 zDDf1473RtZpJERySIuAQWMH08Nm2jKmryEFm4viiNw7RzLqn4DBOEyMSaUdow7v1Q8=
X-Gm-Gg: ASbGncuLlkgGzYDUxoQLNn0viVmHvmlIFjL0rOKN17nydfwfCe+0Ox+aD1mb3B6oJDr
 lAcc7PDKVw3yza3J60FsdBG1yy1hBQKaMkOk1nGofr0vObSUE/8UxPP+PfcNW1ip3DNYxUyWCE5
 vjpVInN8YgNfD2Qht786LlFs0YMTYpuIJWIR9/To2myFmBlQyUsj9YgPhaI+jJHvBoTaYUMmDjm
 MN6b+msyN4Hyxk5Hq+l6cbBSyGTJDTmeTUpSldP0HCVto7o/mVvyW9Ho7zxMCiApfGElkJL+beO
 gjuQZ8nF844naVKpwZj30QMndRFwxy5Pq9Ale1OMaMWo+xgfPKrxE3LCPA15jKAQN7fwM5zP8pT
 4SEtxVFL34N5wcDga/CquWXnppc4/7yo855u1PuquZH+yT1tFutHeAoPU8oI1TtiUDQ==
X-Google-Smtp-Source: AGHT+IEH6oo9mX6vRSD6h/GRf6uQOnLcDRp0WiFK8YarJ2BuIL/y8ILOPNWXxg0WG/I8gYnEPn9G0g==
X-Received: by 2002:a05:600c:8010:b0:458:a850:f857 with SMTP id
 5b1f17b1804b1-45a15b55e88mr680535e9.31.1755009942446; 
 Tue, 12 Aug 2025 07:45:42 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5868fd7sm322000925e9.18.2025.08.12.07.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 07:45:41 -0700 (PDT)
Message-ID: <20db3b4a-d16a-421d-9d78-567d08a52b06@linaro.org>
Date: Tue, 12 Aug 2025 16:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 30/63] q35: Introduce smm_ranges property for q35-pci-host
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-31-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423150951.41600-31-pbonzini@redhat.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/4/24 17:09, Paolo Bonzini wrote:
> From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
> 
> Add a q35 property to check whether or not SMM ranges, e.g. SMRAM, TSEG,
> etc... exist for the target platform.  TDX doesn't support SMM and doesn't
> play nice with QEMU modifying related guest memory ranges.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@linux.intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Message-ID: <20240320083945.991426-19-michael.roth@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/i386/pc.h      |  1 +
>   include/hw/pci-host/q35.h |  1 +
>   hw/i386/pc_q35.c          |  2 ++
>   hw/pci-host/q35.c         | 42 +++++++++++++++++++++++++++------------
>   4 files changed, 33 insertions(+), 13 deletions(-)


> @@ -578,6 +590,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
>                    PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
>       }
>   
> +    if (!mch->has_smm_ranges) {
> +        return;

Are we sure we are not skipping something unrelated to SMM like the
"QEMU specific hack" with the tseg-blackhole region?

> +    }
> +
>       /* if *disabled* show SMRAM to all CPUs */
>       memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
>                                mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,


