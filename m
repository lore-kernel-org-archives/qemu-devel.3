Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5E2C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uksiV-0004SL-72; Sat, 09 Aug 2025 19:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksiT-0004LF-Tn
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:11:09 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uksiS-0002Cr-73
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:11:09 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-875acfc133dso111167739f.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754781066; x=1755385866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GrgxRb1BghUZfQhVCgaEnXapHqDlJwIc2UKYLH/LmFM=;
 b=WtqvSB5gIyAXfVxV0DkwjeoTLRGOPvJBYrmgY2jlk3OJj5LbzDXDerB8G62QM0w0aN
 kq48trfhbzRcDRfy4pP/oKdDskCB1f2dfdJIvgWC+pxlgwOng6vAMstvWZ7cINw0vSPy
 gWsas4No9AfY45AHXVgeqozGHU0Hpb9nCDIYL8NQO0vPJsh1O2D1l4q5bPiM3AZV577d
 mPSH7B5zcytk8r+VFON17idsPI5LCTcBOsFe3GpFNmdyME3yvLnef8BInyQJ5zArMNIF
 tVLyVDovQ0pYY+IReVKqrEp8a7yQTtmKYlKhTaag6udxmXpwRUYvTm0sWadpvz3X9fnF
 enag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754781066; x=1755385866;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GrgxRb1BghUZfQhVCgaEnXapHqDlJwIc2UKYLH/LmFM=;
 b=FnLp9w+7fKllFidKXICQFH/P3LlEWcX4xF8F0HXOhVBdZGx20vJMdjMHxI2/TjQNtO
 a39jtUAd12LUO/aji2ym86DHG5QTNxWFrh/Wfc10OqpkdCwDWPgvFob2OJ0deblbxsDl
 rLAiQ5Er1c2VhJ3a7kS2nIY1UCu+SWniGvPzzAUAXisPq87fCvm5KRLPMy/xld/JqH4C
 WfeB2js219eD1d+VE7L6eOxzgFlJGeFVYSW+6+tIAP+ajRoQhNwueY0qGV6apXlhbVc1
 wI6rXxFDgpRJQwe8Hs6sxvmwZNdVaGLPAInCaMbTgtxGSVy/aywweIk86wY8zPoHcb00
 mD8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYG2xQt4odOMVTKVYxn3tDiuf8uIVNTCSIwOt62Z9+3pcT9BflaEdUwTaNWfskYjpIoulJuc8g5Cx@nongnu.org
X-Gm-Message-State: AOJu0YyeKQLPW92Dmd45M+wMO7+vpYWpLaQpApVmVCBFYf7UZZhwIYob
 JcPqC6keuUxv7FXQjL/NnzcXyBjMCVzpB1ok5GYiwB1AmK9MGnyMPZxxmZkEuLg/fds=
X-Gm-Gg: ASbGnct2Fa9k8rzd422aj1LENyAjbpceIyCDf4HJkbrS1/aRoV8sJhGdRa0jalImqxu
 ZJtOlzipIWlsCrprTow8Tj7FQYDkWzpB/Lg3x+AO23t0ggqAKY0jNleXnRs0NLsYqb4HxvkZAmI
 RbUoVHIO/pYIpv9xaxs9bFB42HFuBzdGrXyoe6Y+PWggbXa8otCILQceDThHIlTjGyJWagB8ftk
 oUKRzMFh4l7WvIRjsgeOz1rwBwrkE7A5bYDMIe68cpUBqfZjpKt/oJYEl6e2aR+3uJciUzB2lIA
 GM3srU18eJ4T0yMmr6/7Lnpd/hKJIecwN1EdO+CUDS6FoTxXrxXOBUBuRMf4fRHczIUT61hI8zN
 iMTUwQZWX8zspSyWg1TlE2rkBJFzNjTUYsfqOTRTo5G8zhG9Jm5envoVmuEROqaAmW9fuwboZtn
 zOKwnqdhn5kBtmXKJg
X-Google-Smtp-Source: AGHT+IHTjrrwlpmj6dnFHCQ74yY+6YMHoSO39QC3hj/ck8DQ8mfq04YPn0ZKh2bnxVdTfXPw1YhmFw==
X-Received: by 2002:a92:cd86:0:b0:3e2:9977:bebb with SMTP id
 e9e14a558f8ab-3e53316d185mr138568275ab.13.1754781066656; 
 Sat, 09 Aug 2025 16:11:06 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae9cbb659sm1343237173.93.2025.08.09.16.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 16:11:06 -0700 (PDT)
Message-ID: <8a778f8f-6d5b-46ac-ac43-3cdf6fe6e007@linaro.org>
Date: Sun, 10 Aug 2025 09:10:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] accel: use atomic accesses for exit_request
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808185905.62776-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/9/25 04:59, Paolo Bonzini wrote:
> CPU threads write exit_request as a "note to self" that they need to
> go out to a slow path.  This write happens out of the BQL and can be
> a data race with another threads' cpu_exit(); use atomic accesses
> consistently.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
>   hw/ppc/spapr_hcall.c              | 6 +++---
>   target/i386/kvm/kvm.c             | 2 +-
>   target/i386/nvmm/nvmm-accel-ops.c | 2 +-
>   target/i386/nvmm/nvmm-all.c       | 2 +-
>   target/i386/whpx/whpx-all.c       | 6 +++---
>   7 files changed, 12 insertions(+), 12 deletions(-)

s/1/true/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

