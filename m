Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE967C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLQb-0001Ry-Ko; Thu, 02 Jul 2026 13:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLQV-0001Qj-GO
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:42:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLQT-0003Xm-Le
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:42:15 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38060005f1cso770722a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014132; x=1783618932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RR1SWbcFvSVjDGBA5KwQUrSM87/1yLvCtyvJ7pFBLRo=;
 b=xgbI9NEtF64Ht8AVtjs+1ugo+2YuFc8hZaQeWaPAj4p7wUxoL8ba9zEs6w82xDCPXJ
 mFceaYp7n9yjhYf7dI1CA239KDPD5IXL6nIiADLGCFL7O/TJVKby2+bjkCaCp7s/WbcI
 MAWSmaUhhQsygeY0I5GAWGgxA2GmeG+kgR6rKcspxIo/kEqu91UoPQTIb+fsTjRW8arr
 5hH8MlpWmoDCEliovrtrL2OhPnVzC3HbpF06GIs/dbKpSE71FBLgD69jip+CVTnOXAzJ
 zuJ9ZAcw1E+Pwbr+C+Lyg9Z4dC6VOv8bDkJh8znUVZOIJrGOidIXVcJXBmNChi0579ak
 4yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014132; x=1783618932;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RR1SWbcFvSVjDGBA5KwQUrSM87/1yLvCtyvJ7pFBLRo=;
 b=osB7je0R/tRXwMoSEYfSFAJ1A+VuQkj3kKDJQfddg3D34NbKE77ENsgrd9zn5DpPBM
 BFQy5q19Fv8ZHOi/I8AE6i1WYm5v7SxKu/S/6h2kzsP5Qs7jiiGHw2iXIoM1Cyt0s1hv
 vDSF7kEWvQGldrdKhZ+xFCLXtXFRZ+WEZWQmAl40+CLsgsM9X6qD3voCp51pwQTx92Ce
 1zbFv/30d7W5/+2zLwo6hhOcEPx6cyY3OrGR6Jbg8spnk415PApdeHN6y0toJny5XBpK
 L3aW/62Ah5VkFYDaa+uEcvVD4xw533MpiE939fWpVFrzGUeYi64BZUMufHeAP/UcMjmf
 xULQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlWFriUQaWYo24Z3IlrmWBA3Q24iLl1IEC0nio44DDZqpa/JqhrZQuj4nkpX1H5sOSKDLH4aBH8+CK@nongnu.org
X-Gm-Message-State: AOJu0YyTa7/1vfwQFKOFmwYVBPuVfsjS+fScCAgUM5wo77n4Ew8j2aWP
 7T4vKD6o6s9/JuGwiZoll4XlZR5TBUhi9Ex/BMrRW2TWKlREI4O6/PniGqGpgw0V4L0=
X-Gm-Gg: AfdE7cn25hvIBro1FVAZeHti7WmFC7/k7mTwgDPMs3DPmJdcSSgI2aau4FstUceYoUq
 CbUhJ2uLbWnJJ3kiKLyeKaSwxv1ERUctn2/52jUH2iu6w3q4zQEkGHJ63xL/VuOwVKNPD7Jxzue
 /R3vUUISteXZz/Z1M00T8OeK+PBkZINoYkq+bqHXz1wkn2lCOEQyZjcs0s+u1D9JrUMKZ1zVYkE
 R5Qqio9BioQc23Om0rU56SgpvxrYiFOzZoAIlNWBi6ayjfHER/S8m0/vQ3C8seJFkUTyNKpSmur
 lZevv9QzRQJ9ATytfIWkYnJ9bMudMc3gg3W7DrO80vmBbTT+Av5MHrmIHqUJN9hb2naNWIW8z78
 yt1i+71LtlFMvM2VFjzKiS3GcO0DOb/56Gw9AzCHSXbqnqUEv5xzA3lHPk3Nk6rBv9CGWc14rAR
 xPt4OCRf6/PJ6QrQvxzgWyyDWbJbK4+mypi8eeD51PxcX7hQ9MZR+pHwrgQQ==
X-Received: by 2002:a17:90b:2888:b0:36a:8254:8eb1 with SMTP id
 98e67ed59e1d1-3811209e3c2mr655375a91.6.1783014131756; 
 Thu, 02 Jul 2026 10:42:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38113325f04sm233777a91.0.2026.07.02.10.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:42:11 -0700 (PDT)
Message-ID: <09f6a1bd-11e8-4c76-983a-c7021434e38c@linaro.org>
Date: Thu, 2 Jul 2026 10:42:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] accel/kvm: Hold gdbstub_sstep_flags in KVMState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-17-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-17-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Prefer to store per-accelerator variables in the per-accelerator
> state, rather than as static variables. This is a good practice
> to allow concurrent accelerators in the future.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/system/kvm_int.h | 1 +
>   accel/kvm/kvm-all.c      | 7 +++----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 49e90cc0235..062759eaa01 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -114,6 +114,7 @@ struct KVMState
>       bool coalesced_flush_in_progress;
>       int vcpu_events;
>       bool have_guest_supported;
> +    int gdbstub_sstep_flags;
>   #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>       QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
>   #endif

Same comments as for patch 15.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

