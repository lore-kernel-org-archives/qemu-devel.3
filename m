Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30AFC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0v9-0001Sv-Dn; Mon, 02 Jun 2025 04:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0v7-0001SP-LQ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:53:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0v5-00046D-Vl
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:53:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so1151543f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748854402; x=1749459202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KShKhSKBioxmyYMv+moET2Xbnq5CUa8Zdx1SMT4zvyQ=;
 b=REG95KOdy5Wl4kHimkOaFiiGgiVpPVWrUKRuJpVysQjwgKBTIFeZBoINmQezIY5UQx
 /akNM3uHRtFHZFVGM3qepO4fK5Bg2XAG6DRI5k9nJUiBo38zOQs6qlYNWqcRZ2d4iomy
 LVDyV6twK/wX0tqIIxmZvhmzkmI1PhtSuDaIWxk3ZK/xFeojmKtRthuCGBFpRETRbI/o
 z1k4Z7m6occmROhxXG9qBs8oZxxjtFW1CmvQ4y1BwonPiPA2+ujaGay2O9yPqWTKIyRe
 glIVmK+UIuC3duu88re5QIZzv/NbWIy4vq0/30TOoZnlZxJ6koLFS1042ruLsj2Qszlu
 h46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748854402; x=1749459202;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KShKhSKBioxmyYMv+moET2Xbnq5CUa8Zdx1SMT4zvyQ=;
 b=dgW0l/C0XbuOI0TpIO55X1/0NGjAdY6lfFep2YuOtBGwseV8gx+R1T3hU4GDlTZ0Tc
 9RGNy4RZU6V/BduDt35bq6k3oUGfVcQV7kXMd2AexJQg+4DEK9QuqmLFreovFGqk8pTs
 jBWysRlGKPPc6D+5Z6Zq5AF9r+5vN2Yq17tPGwcsiNWPr6SdMtUtRyfse1Uuni2ABB06
 aWNqStiw3TiZK1NINru6rtWWVu3x/4TZQBfEBBXF89GWp9BL6U1IPiN9UXFEUqaInbiY
 JckMC7RG3uBmk4JFW3AAdxXZtT2LxFCfOvZ6C5tP3T5j1V7XpiPZmVMQOKCHiDsLrGT4
 ZAmQ==
X-Gm-Message-State: AOJu0YxOs91/wjFKJ6Qd6B8rtcnR/hYg+A6/S9Ao2/l/ZrsQIV9+cshb
 FQQKBbsBaUuKqckIGbd72hVIZb4Wkc1efYlCQLJW1NbQJMk7olrX+tVubHmuA9sf+HA=
X-Gm-Gg: ASbGnct9/x+4T+IER2h1B5RCwCFuk8rRUnnXTJtfVsf3NW7+anku2Y+svrxnLWK0mzH
 bgqTW8J0piQhtdvRpGzPS26Y2Lj0LjfnXTDeTJMWJ8iAad/EM8GpHj3ns2bAkg8s/oI2lojR+/N
 J/OyxP+dpUVLk6NPWqqBLJndqGuRWZPBUtg1iJsSvkcBggSnfFJAjHYHB4TQ1ASkqzRS/ZMDFxa
 MAAAkMCexotz1ZKGpJPzwoYHJ/718BM8Osg9Y4AUW2jI97kmiGsVMV4694SYyKK1+8bM/mXahrF
 UZiFImrrTfM6D4HazZnlEXf+gFlzdD5LD00Wl5ETa3WwhIrhJcbk9eG10C9G4qiiZahD7fhm8no
 O4KjnO6r4Pjd3aEX+9pI=
X-Google-Smtp-Source: AGHT+IFhfoQtlCYArK0IF71IRGL7lKAUtQbMQnSTRl9qOZt6mM7EtdJc7IBJj4zt12lJJiUa3DgjAg==
X-Received: by 2002:a05:6000:1aca:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a4f798f5a4mr9455446f8f.16.1748854401679; 
 Mon, 02 Jun 2025 01:53:21 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fd9bsm13896447f8f.82.2025.06.02.01.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:53:21 -0700 (PDT)
Message-ID: <c2999ee1-c0a1-4a09-85f8-6c10ede14584@linaro.org>
Date: Mon, 2 Jun 2025 10:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/27] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-2-philmd@linaro.org>
 <20250509172336.6e73884f@imammedo.users.ipa.redhat.com>
 <91c4bf9f-3079-4e2f-9fbb-e1a2a9c56c7b@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <91c4bf9f-3079-4e2f-9fbb-e1a2a9c56c7b@redhat.com>
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

On 2/6/25 08:13, Thomas Huth wrote:
> On 09/05/2025 17.23, Igor Mammedov wrote:
>> On Thu,  8 May 2025 15:35:24 +0200
>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>>> These machines has been supported for a period of more than 6 years.
>>> According to our versioned machine support policy (see commit
>>> ce80c4fa6ff "docs: document special exception for machine type
>>> deprecation & removal") they can now be removed.
>>
>> if these machine types are the last users of compat arrays,
>> it's better to remove array at the same time, aka squash
>> those patches later in series into this one.
>> That leaves no illusion that compats could be used in the later patches.
> 
> IMHO the generic hw_compat array should be treated separately since this 
> is independent from x86. So in case someone ever needs to backport these 
> patches to an older branch, they can decide more easily whether they 
> want to apply the generic hw_compat part or only the x86-specific part 
> of this series.

Yes, it is clearer this way than squashed.


