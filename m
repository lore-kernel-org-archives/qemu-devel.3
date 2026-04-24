Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9571DFED3E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIO1-0006qC-24; Fri, 24 Apr 2026 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGINz-0006pK-Uv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:24:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGINx-0000x3-FE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:24:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so87200935e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777044243; x=1777649043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1AU33mHcOoBqcvM7nu571k0mM8qZPnKiwu43LZRhmtM=;
 b=MoMIt0CEsAPiw2R2cvNbFhAbdVCG4Ao6jPMMYKClH4FkGF5Hl4K8wS0z/v1VI1c1rR
 CrWqOX6jHXjw0IGRFMBU97MlTOKC/ZWGN5FPAkm2LzfmUOAzgANLN5NpN+srJbrnFRmj
 A07fGDIQHyUqY0+2+oNWm0Ms0IfwuuF2U2tMK+BVjhputlkF8O3k92TtPUPSxI4RU02M
 hkTH+A009O32+PTZ0O141cJ+syeqggYy2qm0//2vIMhk+rLXe5vIIs4JHIjit20NXQl4
 4ksc/6ErVFtrYdRQNhFI925f/K3VsyLchCoWX0pigTAOL3sIjqrxxSvBufkRNUIU1k8C
 Dk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777044243; x=1777649043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AU33mHcOoBqcvM7nu571k0mM8qZPnKiwu43LZRhmtM=;
 b=Tpy4XCRIQYSJKzJjIZ70ife5Fhve5PbI8GcsMOZKFJkbO5PsOpSBGwzkaK0PHyqy93
 cGTP1A3HofjhxJTualUMdpzfHf068rwnZOBrbiTmiwi8auT5uhJd9CjzStBpvYBSn4UL
 XtYOKqawcJ1Mew3FsJZGT4kmHhttFVOIFFYeKlpJZV1JRMuGb2hfe6q6XLiSsAQW1W72
 eP43LeFK88XMzVVW6m2ZZTGQBUr3qJOb0uPY5Y+5Te2jhIh1u76gYeVSQ4msmNq/iZ8D
 Ml85FR0ww1Zv1IEZ4gPUThqlzQ0MlXoFdKsW+xvnGFjtA7c7kW8Tj4obU/l8F162+lhl
 U1xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LRsvaBgnWk/K3Izbj7iVbMcYxvYyP1cQ5kxcPibAhot4VRTR3P8urHMs0fCrJITFOng+owCIUDtka@nongnu.org
X-Gm-Message-State: AOJu0YyZD+U7uRq0uv5iQyJOHZWi31qxR4G6LU7DNSmDQtRp/GLy1803
 Uj2zF4pLP3rKH+pgW4HWe5hjE8GfVpREia1Jv9m8WKX86/1j0Yn0UXUnNBkrAzURlq8=
X-Gm-Gg: AeBDiet/G1q2Q4/Z8S/kFK6F4OyzOMXrbIS1Qe6wzgr/wwFDP76MlL3B8lHHlMjU748
 nA7vIEt6ZdxfacSIXRpK0V9u0HewMfwyReahad6MzuEHFOlXXolPrMgOBsf54DZdz+gn75d5Hz3
 vAId9z9CTFiCFXX6g8DCyHf1aDKVNGVn2jqsmuRIEBhnfQRKV5kWUeVjqEPmh8tqDzQNHm5nVul
 lTOjj0vPDOJH0SzLzU4paTwVZedh72Ao2Wc91czI267Is4pqJayUtgETuUS94IrVv/a+SLr5Efk
 +fzOOdCmzKv0mbEVCT4QnbnScfKJotQ3sog/4Zx/iuxd8aYgwpwZ1Gxw8/X6K5UdvevMyfB8b5C
 GLPd445rL56ESFk87JW/aecNdk2ZlWkqY3FLifJufumEfkA/YH+OYOnTZPPLrpeFO9I/+8pTGu1
 noxShhULWbktH2ioDwkp9C4CNv44csnowkhhoAOHc3idpiut3VAAgED07NsmU9d3D2UbUPO1opt
 9SV
X-Received: by 2002:a05:600c:3f0c:b0:48a:563c:c8e0 with SMTP id
 5b1f17b1804b1-48a563cd16bmr222575785e9.1.1777044242862; 
 Fri, 24 Apr 2026 08:24:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm54738446f8f.14.2026.04.24.08.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 08:24:01 -0700 (PDT)
Message-ID: <8dcdad92-2981-4d57-b605-871c748424c9@linaro.org>
Date: Fri, 24 Apr 2026 17:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/18] hw/usb/hcd-ehci: Introduce common properties
 macro for sysbus and pci
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
 <20260424080508.53992-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260424080508.53992-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/4/26 10:05, Jamin Lin wrote:
> EHCI properties are currently defined separately in both sysbus and
> PCI implementations, leading to duplicated code for common fields
> such as "maxframes".
> 
> Introduce DEFINE_EHCI_COMMON_PROPERTIES() to consolidate shared
> property definitions and reuse them across both EHCISysBusState
> and EHCIPCIState.
> 
> This reduces code duplication and keeps property definitions
> consistent between different EHCI device variants.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h        | 3 +++
>   hw/usb/hcd-ehci-pci.c    | 2 +-
>   hw/usb/hcd-ehci-sysbus.c | 2 +-
>   3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

