Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1FBC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLLw-00037I-J1; Thu, 17 Jul 2025 05:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucL6c-0008Nt-Kq
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:40:46 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucL6a-0002pj-Nz
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:40:46 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7184015180fso8386757b3.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752745243; x=1753350043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KT/cNhNrsVLlNFlNs9ur5OR9ca2bG5fE8QkwKdsISmA=;
 b=TC3lIfyRTiLKHMCeu0smL/moGjOu93iviFYnKfpuDKXkECmeFQjd4zfDt0xsJUyOmN
 T6rVqYxyyG3lSnh3UGLp7rJr7f7vHqMDC2G/QUZ5CB7YJ3ZhDEqeLNKi/+FgXAClckbz
 UlR+yi0zXAuYtHT/hY83o2PdUNS44V7OQiXU65EO8e/iRWt9c5Jyzd9rfzC+J1gT5p9T
 cs65zMV2y3jUUCkIONdSkDmGGB0i+qDCmqgMo7KsqCCkgbFRjEh1mjkhXys5GuF+azim
 nnVI7nH++DoHmYCZYnMcfmjgR0Ky5BEl5LSEPZQ7UkP5MGSG2LaVfZ22Lr0qlFvQ4jHo
 GLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752745243; x=1753350043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KT/cNhNrsVLlNFlNs9ur5OR9ca2bG5fE8QkwKdsISmA=;
 b=J8+tnOLs338Rs98eNvAJ3kUJ9SGfH3KGhxs6FheK/o2olFTsVD4p8U/LBDkqrfucoN
 7SEAjZZVxm64VMlLp/yo1AsEI7/FY45y3YiDmZLJGOyGqgM6RPcnP2O+c8h3Hr7bzDq8
 22YT+BZdaP4rzGoNKrbRP4eQQU70oB0G7CwN6ngl5F7MKNaj9EwMhBHDk+qD4dtk5iYS
 PmTYgejufgTkd/vwoup6885WXtJUcqdAXpsPvuH7j4fXNLKV//ApRwYV4eQwy14fZJRK
 UTZZKpu5dnR8wgewzV27bnUiOF6rrPlbNfKz10hCWixPLpStYm+LOCu4CeiuOIeaCHn4
 eIpA==
X-Gm-Message-State: AOJu0YySahRhdozK1pD9KDyUHucDvrs2wWEnyLaB+uY0ciraW+FpRq+v
 ZIilgz6sAgLG7+v5ukAKGanWmwMzatjwEU034NFOIJS2BX2JaSxzn9TupSE/6n6Hu20l68P+AOn
 otAjdBFz0kSLz/wS8YrtJftz+OJnsAOmJLPZhEHO2fg==
X-Gm-Gg: ASbGncuVuIFlaLXLQ6tbkQREQ3kKF8D/Rq5JCiXvhepPWMh1ZHPPYUSd6Fy5hFofcIo
 UKC/De4ozAoi2Xt9E2wTvbtF/WxFU2C52QtXEU4WlvpFWREz34cPpMT08/EjLB9Ad4FA2Trob2D
 yod7n1UEkBrDv/HGZm9Xe35VNdzJ/hK0MBlxtv7hb1G+2i5SSq9fNCZXODzcANRPPX96q32UvY/
 RUPSktB
X-Google-Smtp-Source: AGHT+IFBPVI8rWM8Qau+qY7/op+ABQ72OsePj8b5hpUDw5Dd5eCwgAyBGqsP7AzhXnnq6TyL/q0BkBqBtBeJ0zVsUOs=
X-Received: by 2002:a05:690c:7343:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-7183712c96dmr58072227b3.11.1752745243059; Thu, 17 Jul 2025
 02:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-21-pbonzini@redhat.com>
In-Reply-To: <20250530071250.2050910-21-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 10:40:31 +0100
X-Gm-Features: Ac12FXx4YpBtJY66w70lyO7YrV280bpxC-tvkNIE2fAVoe8AVQaFGsiWfPF4iWI
Message-ID: <CAFEAcA8XdxQbvSJmo9BZOcxojTNgaFvCdO4xDuUi0eXcj13uAw@mail.gmail.com>
Subject: Re: [PULL 20/77] i386/tdx: Initialize TDX before creating TD vcpus
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 30 May 2025 at 08:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
> KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
> CPUID config, and must be executed prior to creating vCPUs.
>
> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
>
> Note, this doesn't address the fact that QEMU may change the CPUID
> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
> provide a stable CPUID config prior to kvm_arch_init().

Hi; I noticed something odd about this change when I was
investigating a false-positive Coverity issue:

> @@ -162,6 +265,8 @@ static void tdx_guest_init(Object *obj)
>      ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>      TdxGuest *tdx = TDX_GUEST(obj);
>
> +    qemu_mutex_init(&tdx->lock);
> +

This adds a qemu_mutex_init() call, but we were already
doing that later on in this function, so now we init the mutex twice.

>      cgs->require_guest_memfd = true;
>      tdx->attributes = 0;

thanks
-- PMM

