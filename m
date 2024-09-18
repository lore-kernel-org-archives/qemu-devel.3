Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED64FCCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqv40-0000fn-KI; Wed, 18 Sep 2024 09:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqv3z-0000cv-0b
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:49:47 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1sqv3w-0001FI-QV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:49:46 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 76F813F664
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726667382;
 bh=DRPOUgnzyEYA3nZ43EginjRlwFYjkpOPaT3U4/1W7+E=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=YLI0UQKNiJa/qfTntn0CBtmd+9YK/g075paVLKDNJiUvMHqs5o/HYFSC7y70BkEtQ
 j6fb8M/XksFMQdbh+/537lb44Z4KxbOQwywFjuhvOANfSl3BSDeMxxVM+LD1sHIWDv
 D3wDEYReUgTwL4nzsEPVM4mx7Dv2/iIXOse+dm2dxsXmMVglGSLvxKZlHs99OFdS8x
 Lc/3+tInkdgVhI5ViGEvP4CwwHqHIYQnRkHB2l2YlYcqU6wlvmT2KNiv/JZ2B4GaXD
 mtOouyzoBbp6HsCiJwMgirowJpXE+X1qyVZl91qr8/VQTcWsHh7CcccBT/f385rJlV
 +X1PjL/FYl9xw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb998fd32so48460715e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726667382; x=1727272182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRPOUgnzyEYA3nZ43EginjRlwFYjkpOPaT3U4/1W7+E=;
 b=pP08JXKLyWfwdSMeNckDH+JBLnJt8smuV8AiFZDtnZ8yNxj6q1aTEEhsy569680vih
 c+cH73lGvrvZUZsZXiZfib9+OL7Bt6ey3wUR/4gCMdi07o7RbwLsWTpPc0oFgm7R5RoZ
 JIdmukif1dnJnHN+jK8E2RLqX7EGJb+shvrlVHkCrTfi7d3aHTQj5jfU+jcFvu0voonA
 P4wjCm4ve/QhQfNVXl0x5fJnS9WaPk1JTMzqZVXtkKKOybS8fLS4pkm4M+XHf//h8yPN
 qFiQTB7jLz0TJK37Ww82YsNdCVCRSqHqFjjjL2WV6ocim6c8dBkeA93IJ83kq044GRkd
 FiKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwkyGYijDcGQhG2/S3d8svHF3D5SOrL1ebb+fQfCGCezC1IMAMbCqlDbRDlIsMlOYmTb0UTqMaAGx1@nongnu.org
X-Gm-Message-State: AOJu0YxhP+EP05YebsVAq3iFJvgu67BTQ6kx5vzGS4BLyjSDegvfL7OX
 /2NRcNc7IH6fnNiMMdwaBqocmEloxSqrYcKpIIMiu8kpdGrH3Vle8Kj+D9wLn5q1hUS/rlihSqH
 jU4/0LFt+IuRxW8Yqv40b2geZYpAKwF4GFy5aLxiE5W+0FQq4xNRiApimlCxOP7lPN4mj
X-Received: by 2002:a05:600c:251:b0:42c:b1f0:f67 with SMTP id
 5b1f17b1804b1-42cdb66c968mr131499375e9.27.1726667382037; 
 Wed, 18 Sep 2024 06:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBOsqcqK7DIjaRwTLHJ9k04jg0yeHQj80Lyu8/abqW0i9TY/peT/h53jDVVzNmlDEM5SNbxg==
X-Received: by 2002:a05:600c:251:b0:42c:b1f0:f67 with SMTP id
 5b1f17b1804b1-42cdb66c968mr131499145e9.27.1726667381488; 
 Wed, 18 Sep 2024 06:49:41 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7053856esm17475835e9.33.2024.09.18.06.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 06:49:41 -0700 (PDT)
Message-ID: <f1e41b95-c499-4e06-91cb-006dcd9d29e6@canonical.com>
Date: Wed, 18 Sep 2024 15:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
 <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 18.09.24 15:12, Peter Maydell wrote:
> On Wed, 18 Sept 2024 at 14:06, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> Thanks Peter for looking into this.
>>
>> QEMU's cpu_synchronize_all_post_init() and
>> do_kvm_cpu_synchronize_post_reset() both end up in
>> kvm_arch_put_registers() and that is long after Linux
>> kvm_arch_vcpu_create() has been setting some FPU state. See the output
>> below.
>>
>> kvm_arch_put_registers() copies the CSRs by calling
>> kvm_riscv_put_regs_csr(). Here we can find:
>>
>>       KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>>
>> This call enables or disables the FPU according to the value of
>> env->mstatus.
>>
>> So we need to set the desired state of the floating point unit in QEMU.
>> And this is what the current patch does both for TCG and KVM.
> 
> If it does this for both TCG and KVM then I don't understand
> this bit from the commit message:
> 
> # Without this patch EDK II with TLS enabled crashes when hitting the first
> # floating point instruction while running QEMU with --accel kvm and runs
> # fine with --accel tcg.
> 
> Shouldn't this guest crash the same way with both KVM and TCG without
> this patch, because the FPU state is the same for both?
> 
> -- PMM

By default `qemu-system-riscv64 --accel tcg` runs OpenSBI as firmware 
which enables the FPU.

If you would choose a different SBI implementation which does not enable 
the FPU you could experience the same crash.

Best regards

Heinrich

