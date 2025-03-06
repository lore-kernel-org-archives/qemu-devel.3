Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB874C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEBu-00035M-1o; Thu, 06 Mar 2025 11:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqEBq-00032p-Gg
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:35:20 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqEBo-0003xu-GD
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:35:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2232aead377so17479355ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741278914; x=1741883714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=omg6AjvLFckyUHlNxe3aevARZ7znM3QKeiz1AMsa4Ew=;
 b=Ro2GrbdsDmp6YSgJ3W3r5Ia74SaeUZILYoNW4kn1fGgFvA6dIoehEEKurdSP1YEanB
 dazasbRt1PNjRA8SyPOLDD5rMmVmMDGPr/VF6CxbhTFHIxQa1BvXtk6vTKJSrm/dAq9m
 GzgXhQFxIRjP4ngu7yDbHhVa8bMvOymESF0IeGM9UWn90Q/I/TX5FiVNmporHewP23Vj
 /iqbJClwmTj3jxU9bn/W0jx3lrSavSiCZwyVsjnFURdoUf1LwPU2PccYP5siS0gml7bd
 BOvNR1elXXtuPE17kaT0Xh9aKK0CMUzhw82LPaUuUwveOblVOs+phnOtv3xnx9srO2uC
 qC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741278914; x=1741883714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omg6AjvLFckyUHlNxe3aevARZ7znM3QKeiz1AMsa4Ew=;
 b=PQJE6yMksxqkEajfwjHBZOgDKJ5Rcye+6yAXnUqaopzS7ba78ItQql77l9lnfPTABZ
 Plm2C7YMgqwXcbpuYvPey+L/g6jlrNrUly3eGjGpIXhGnrLecUdab/Z1FpvW5drFDa6y
 1iDWmIvIxd8wiflfTQNq6apIYspWzQ2ikEdXe2g7JViJ8EQYejIfRSaZH/Jmrf0BPTRT
 YjBPexLezi7WaTunTyo6u3aYx7oDgHiz624JXYBRNgGnCc6qbAE2aYH4yvgYuF31SOkc
 0AisqojtQCsl5BnIUyXRVnsfr3mpAuC2tOgCV3xVhRxUxv1IU+W1Tcri9UAXTLXUmNcv
 10oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcSTwYqHwVjO/ENUVzDzhD1vJAIfVm3lODTLeSAPzJNu/tl36OEjnwX4aOHTFCbtGhkowh2/K1W9f5@nongnu.org
X-Gm-Message-State: AOJu0YwHTlQmzVdDAeO3T/N7ZLw17RShX1keOoTjQWfvLHmeQ2ODoBZd
 EnCno/qSIobPwQzxTusxRGwR//c6JxPMEFsqeDjT7U51A0BSajyLAiTh4YadnlI=
X-Gm-Gg: ASbGncsjxFtZLPhGvbr7KlHJAUb/I0Vg9BfeKPXCIXJhHlCCvUP1Kc05uiKHTUWZGvo
 /lDBalua1BVuesEeSGsibarF7q/x6IhIIqKTuQBXsO4uQiiDsagR1BfwUNyUCJLNfXHPXeYBzbK
 sC7z6VT+/XKFs0zmuqm7VCdlLYXr9YfAstSQxmC8ZEfyRruREM8H/7qdstGBofhsBkt6UI3Q3hP
 4IMbxfELzvxueIZhFtz1w1hJbzGpD1Hj0pfa/cxLdFJMhive6+Cv2Sc05pKIiOH2lbcj7AtghFu
 AN/gKZQBSJ6fLyY1p2eApwbsJaoezp47Dhuk8kfinFFD9+wr1hRHoVcNGw==
X-Google-Smtp-Source: AGHT+IGqgyU+nSbO9JD5HQMa4r81ruZjtNfVLorH/amNd+rJA/+OgMQY5I7W07lDvlJwLRGOFlF02A==
X-Received: by 2002:a05:6a20:7f93:b0:1f0:e84c:866f with SMTP id
 adf61e73a8af0-1f544b16311mr264503637.21.1741278914529; 
 Thu, 06 Mar 2025 08:35:14 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af2810768a8sm1275071a12.4.2025.03.06.08.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 08:35:13 -0800 (PST)
Message-ID: <badcb867-64db-4b45-93b0-fd4ff203c35a@linaro.org>
Date: Thu, 6 Mar 2025 08:35:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/hyperv: remove duplication compilation units
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <0226e9d5-edbc-417a-8cf0-8c752f52b7ed@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0226e9d5-edbc-417a-8cf0-8c752f52b7ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/6/25 08:26, Richard Henderson wrote:
> On 3/5/25 22:41, Pierrick Bouvier wrote:
>> Work towards having a single binary, by removing duplicated object files.
>>
>> hw/hyperv/hyperv.c was excluded at this time, because it depends on target
>> dependent symbols:
>> - from system/kvm.h
>>       - kvm_check_extension
>>       - kvm_vm_ioctl
>> - from exec/cpu-all.h | memory_ldst_phys.h.inc
>>       - ldq_phys
>>
>> Pierrick Bouvier (7):
>>     hw/hyperv/hv-balloon-stub: common compilation unit
>>     hw/hyperv/hyperv.h: header cleanup
>>     hw/hyperv/vmbus: common compilation unit
>>     hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>>     hw/hyperv/syndbg: common compilation unit
>>     hw/hyperv/balloon: common balloon compilation units
>>     hw/hyperv/hyperv_testdev: common compilation unit
>>
>>    include/hw/hyperv/hyperv-proto.h | 12 ++++++++
>>    include/hw/hyperv/hyperv.h       |  4 ++-
>>    target/i386/kvm/hyperv-proto.h   | 12 --------
>>    hw/hyperv/syndbg.c               |  7 +++--
>>    hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
>>    hw/hyperv/meson.build            |  9 +++---
>>    6 files changed, 49 insertions(+), 45 deletions(-)
>>
> 
> I'm reasonably certain that hyperv is specific to x86.

That's correct.

> Are these only "duplicated" because of qemu-system-{i386,x86_64}?
> 

Yes. A lot of duplications in hw/ is related to 32/64bits variants.

> 
> r~


