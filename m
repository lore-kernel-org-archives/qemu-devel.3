Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D83C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfpj-0007Ag-Lq; Fri, 07 Mar 2025 17:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfph-00075y-GC
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:06:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfpe-0004e3-IM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:06:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bd5644de8so26922125e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741385173; x=1741989973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+E+5MNTzmNhs6MH91U6sTaUkbdxX1RykL7+d9oBnXU=;
 b=oQASay/02cGIbRb2FRIUzHEMayL3cjO7CIAbcc+mr/UKOgfBuWIw22uCPh5NS9TMVB
 EbEIEC/z+snkO5LjDUNz7gI/osZ9HuHS43E99u4r+Aw8QlpvDyVeYwmNtQzc23yJiW8E
 iJ81Nhlm2rW00R0eZy0/wnBsTAOgOPkNmBtWejqDYrlP3vsNchXOMZOQ9tWfJOIydt+K
 LNRfz5Xz5POiEYYablAbEyaB/8liEkcSdF+3PaWhwnN2p/GJj/05oAE2z7521DlFb4JS
 JzB+MJJvCrMj88zc9zOt7mJSfkdJLN1uYXx6e19NET5jtuy+BH5nSRrrxOjf8BAjCnwG
 qTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741385173; x=1741989973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+E+5MNTzmNhs6MH91U6sTaUkbdxX1RykL7+d9oBnXU=;
 b=E7C5owwc94ohwhXpSZ51xKBtdde00GCPsuXesk8y1vseUV/KU4Cfa7gLynKU2+7uO3
 pliYJYoB+ydgPaSfovQ9gG8dIQs9/8Nv2OGhTTwJwPTebGhxCBEwJP3MHBes0D/jFma1
 vd002Wy5VgFJRYSaa+X6G8UwWQoG0/IugmJ4L470DeiKE7pHT/PA2Bu1kkpF38B8vAhi
 EeiUhyOug17yHDjvEwhT3IgiEEM8f8c4NCe32ZlspZkEpAT3/k8+kvE/r26SBjK8xsFb
 /6hCcba1DHYIRw6JWJSAxIEBptrIRn4zthta2qcyrKOaqzY2NDv/ztYP6fbPoSMWZ/A7
 E/0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ0eAqjTk4imjB5bioXDtO+hm8eBqsd5rwXVuAqQD3Y0NS+HtTUHLLV4YLHqyvntahl0rZbjWpH6u2@nongnu.org
X-Gm-Message-State: AOJu0YxkWHqbVNPT5DKLEAYyIKkVrZlRGNbqxJd/PTDKjbuV+zdvgh/f
 bukUCh6DZmn1odF1DmTLBBwTeLXQGREXkl7XmoJal7HBoFOPTekpWlJX0r1TuGs=
X-Gm-Gg: ASbGncthvRIHH/9N/WOsllIjaMGJ0HlsnuJR8NXgozi+P7p26gbTZ0UM/rJ4kxaxmUp
 AqnBlrZ3R8kuehG29QN3yNKYiAtv8L1igKQrXTwF9qgg7wAXRHWZsS7PLFacgkoWcXbzdbq3xzt
 QCkLtB8gX59e3sPU1zKXf2apWey2gp/I0FPYPTA8qtD/y5ZYqucD4jgoVJc2dtTwBzaQn0Ldgfd
 r9aWpGEWfTMVOgza63c7mlstjHBP1shRmPV2dSkR5E/ncK+45PDDkbsmR2T87c+rslXaou5c9PI
 4mA3x7UKt1sH1KIIgDJXvfpM6pevTnuh491h42dL4jhLRgOz/AEFm0WW9MaGFAkE6y9HKbAS5FK
 uJCEqsqRa/XaA
X-Google-Smtp-Source: AGHT+IFDossi/1p4SEuqIz1YxM/T8A6eeUCGfHQgGZUcm+3bvisxJU4T73PWVu7xZcVUj0qkKVGP3w==
X-Received: by 2002:a05:6000:2c5:b0:391:2f2f:828 with SMTP id
 ffacd0b85a97d-39132d664a7mr3463240f8f.29.1741385172711; 
 Fri, 07 Mar 2025 14:06:12 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d81csm6691181f8f.58.2025.03.07.14.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:06:11 -0800 (PST)
Message-ID: <fb8f0700-2676-4e7a-8857-ca10f5060b37@linaro.org>
Date: Fri, 7 Mar 2025 23:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 7/3/25 22:56, Pierrick Bouvier wrote:
> Work towards having a single binary, by removing duplicated object files.
> 
> hw/hyperv/hyperv.c was excluded at this time, because it depends on target
> dependent symbols:
> - from system/kvm.h
>      - kvm_check_extension
>      - kvm_vm_ioctl

Bug, these should be declared outside of COMPILING_PER_TARGET.

> - from exec/cpu-all.h | memory_ldst_phys.h.inc
>      - ldq_phys

Yeah, not an easy one.


