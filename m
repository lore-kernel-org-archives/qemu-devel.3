Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2310BC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvL8J-0004Br-QX; Thu, 20 Mar 2025 15:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvL8H-0004BY-8k
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:00:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvL8F-0002UP-CE
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:00:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fb0f619dso24916095ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742497241; x=1743102041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=weHsotjSjln9MgHLKOIKUdAUmOsOwzultrmV4EVkHwc=;
 b=cIOPs2x2UbnmIQgmi9klKIfVECWHu0bctPVVH2ZzGbyO7F32OnHRidqBF44H5lB1Dp
 U1eJNnm7IMWTS5tbu8ukeecDd+oYdMp4GtQtDM3WHjMfuKEWUHZrtUKIBZtu++vz2Jdi
 dVOfL3kNGSEun2ainiXadrtNG5vCyHBlYu4oJfOf5/EFYF+U0hiQZyWXle5y+FUVIDIZ
 Rq7LLYfnyEYxsDwU60LecAnJjexRI9aU+NbEjRlw7NdJHZACbEOycxagHpMlzrfSdCYp
 O67LlGtqSGC/tATGXVDQqxcW9CdMNR8f3p5ovKclMJHO/neZWwlzn5NzzqsTIVvvT3Tk
 9TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742497241; x=1743102041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=weHsotjSjln9MgHLKOIKUdAUmOsOwzultrmV4EVkHwc=;
 b=hZRITQ30/KFlD2ZA+PjPk1OH9nhGBRT6n7f8iDxdb9f/XLIj0kANwtc5WyHOi7+rh2
 4nv2H0cfoAVWpFvVXxJX38tDjlA2Msd5Tkq/XUVBWvKTmR8zAoZfsPeR6N9KREAm8SVs
 Coi+73YtkJPsRqxV5bUtOpX9TixeC2rcBsSZ2jzogAGyXhTm4/p4APUEhx5OMY+16Xok
 u3bki9IxTWNhfP/QrG55HrIlexkG37u4RX9poanBVEaEw4oMZ9Ix+34QuxUg2DGzkIug
 Yq1vV3EnBo3/0Ux6hhRkoh0J7OfJX+484Ith3tmOZheCgN3UhUlTjtlPtKK+qcSwgRQC
 c4Gw==
X-Gm-Message-State: AOJu0YzcyF1jaApjwf+74v3hJKXUZnsMywS3XTlSOC+/UrExnu86eKhI
 PwZW+LemdYQJlzDlPeOH4BeyVuwsMPNWXN2M6f+8nl+ycqnENmbw5mI+VgvaFeYX2ZjdMq3MKZg
 T
X-Gm-Gg: ASbGncvTciCSQVSY5MRnHSX1LT8HnGiFhbSSl6Lte86D/yLNJ90i30yGrgZysYVp26U
 SUvsABg7WxDf43XzBEbm28Ww4jwMFesG4n/z15P2Zp0Sr6oddL0AlOXv6lBD+qywVQ21YBV0r/2
 2PfiPayxfIs/EtLvLi1kHVCeDYT+A3hp0kfLpgt2FPmtLcyomNhpJQ6EsVLEjzfKffvxKZFPB06
 einl7RmxlcP2X711VLjdpIl3QBjkk3LF6XNtDBndlJrRhFNtP5qeWRSynumyRntlYfJ5MjcHwBG
 kzNyv3m5yf93QtZbLkJyyL7do7n9B7LPIyIwRsYywmtChjykvHmL0N065QvFjdcGq2C5
X-Google-Smtp-Source: AGHT+IEDts3benM6NmGItX5fga4Aa+CyXqI9YpnoThtJBcl6IK/cPPeYhxJyUZDqG2wUkSMleZOB0A==
X-Received: by 2002:a17:903:8c4:b0:224:76f:9e4a with SMTP id
 d9443c01a7336-22780c74ad2mr8405635ad.14.1742497241060; 
 Thu, 20 Mar 2025 12:00:41 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3964bsm1511655ad.32.2025.03.20.12.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:00:40 -0700 (PDT)
Message-ID: <5a97e6c4-72aa-492b-8e7f-c0f874ffaf23@linaro.org>
Date: Thu, 20 Mar 2025 12:00:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/7/25 13:56, Pierrick Bouvier wrote:
> Work towards having a single binary, by removing duplicated object files.
> 
> hw/hyperv/hyperv.c was excluded at this time, because it depends on target
> dependent symbols:
> - from system/kvm.h
>      - kvm_check_extension
>      - kvm_vm_ioctl
> - from exec/cpu-all.h | memory_ldst_phys.h.inc
>      - ldq_phys
> 
> v2
> - remove osdep from header
> - use hardcoded buffer size for syndbg, assuming page size is always 4Kb.
> 
> v3
> - fix assert for page size.
> 
> v4
> - use KiB unit
> 
> Pierrick Bouvier (7):
>    hw/hyperv/hv-balloon-stub: common compilation unit
>    hw/hyperv/hyperv.h: header cleanup
>    hw/hyperv/vmbus: common compilation unit
>    hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>    hw/hyperv/syndbg: common compilation unit
>    hw/hyperv/balloon: common balloon compilation units
>    hw/hyperv/hyperv_testdev: common compilation unit
> 
>   include/hw/hyperv/hyperv-proto.h | 12 ++++++++
>   include/hw/hyperv/hyperv.h       |  3 +-
>   target/i386/kvm/hyperv-proto.h   | 12 --------
>   hw/hyperv/syndbg.c               | 11 +++++--
>   hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
>   hw/hyperv/meson.build            |  9 +++---
>   6 files changed, 52 insertions(+), 45 deletions(-)
> 

I've been able to address comments and conver last compilation unit 
missing (hw/hyperv/hyperv.c).

However, another series is needed to make this compile.
Thus, I'll wait for this to be merged before sending the v5 here.

