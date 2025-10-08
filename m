Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0D5CCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6X2o-0007Za-Rk; Wed, 08 Oct 2025 12:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1v6X2e-0007Xu-QC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:29:31 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1v6X2V-0007SU-2I
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:29:28 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-42f69f5db55so260665ab.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759940951; x=1760545751; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SGCrKoZ3SyWimYoZQ8dNyyH+rUrdr46H9MVfr0Ark48=;
 b=V1VB2Oc7kMyfB1mB5DqSSX/hp90+YgHBA0Xwh5m8B5x6Ryy+ZMKQkg1BVwZbQJhGsz
 s1SCr8ePJiC53wSZXrNSLd8c08TAAGjQQHYoOXNI/x3Ibv8zxQl2yyqeiiSHxSMckjQa
 R/c0ihV4ohM6JYUE50qUpg8hkofRkOTyGSo/Jax1Xw7If9Of5SDDLWKy07JYQed68lZB
 VxkopAjAhZHZ15duvwJfZHJ4w9X3b5F1p99FtCKjhOcrzp/5RH8brb2ewu3tmshJh17k
 o8ceQII3kNvprqooCcmfEfPLAhbFCrEAehnUrlRjYLoFjM9EDd3ln2NmkEniJwI4UbKV
 hKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759940951; x=1760545751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SGCrKoZ3SyWimYoZQ8dNyyH+rUrdr46H9MVfr0Ark48=;
 b=GrQX5B299S+B4wPoUd6o5Ufs8+3KrGLN8YEx98CTzmLEe0wvtzZ+jePEcwSv8L5tXY
 +HlIYLdn9Uy+6oGQb41GGC1OfnZyjmNvNAEoKD8eS94hSmxulbV/AbrFr2IBBDrvNFhf
 NXf1arstP5IFDnIpqzZq/GrMYORsrUA2Ph3mK4OLl9JFKK/aiRvDKLznNIqOjEluhCdA
 5xC4UjHVJiOSlwnIAqzg/NBTt+e3chQG9KAjFkk/IlC1dvTWPDTck+I0eYdIxZ+zlAxs
 /x9kTTOrBjk8cmWfAuRfOUizZTt/gZGgt+AFWxaxup775z8Yw2cb86YxGkCbIqGX48vn
 19GA==
X-Gm-Message-State: AOJu0YxIcjaSmgsiITrfb/ej7VtDkulIStuc854JazBRj7YV1A6rRXuI
 xhFnIdkEiFxT1BKgU/4iXlS+RcV0SbjCFg+HLcME5poT2y7vGCfdXa3BxiZXu4QLtsA=
X-Gm-Gg: ASbGnctaVHVCeH6BhZRVUvEBzdIvmJ6snq9nN2mgwSYzvegAMx4xQtuK0yQ3fZjF58T
 BMFyK+5+LR/rTIkeYvuktSqbqOy2j8abWt79Rq8z861pXSyrAAb1QeRcdn8B7j04I5L2eYFQfbi
 2A7xM77LdFxMIel9Y5p+rTlJG2S+f3vwMBcc1yMO1L598Yo5nWY7sz4b7XwBm8s9jMxpxChi7uS
 K06QG05s2zFzMEHB1D+80TDSwzspVoz+JwP+gVsuCWAtYSpI17mYapdv+pSvnNJWZRI7OX6AHQM
 BUtGGNQ03VZ6/+UUNelZMh1espToqq+3oqrB8G2ranpeh/+XItqB/P4Ns4T34PehaFraq49f0oq
 SJ1Usg91g24gsWJJyd+1Dyc4eslXCzrYNBTVoAgW8vQRs3E9J
X-Google-Smtp-Source: AGHT+IFnNVr7p4Ri2YprEd6Qzm6yZMtzB1axGPgJVrk5CTzM+uM6dsNRed2Gw/60wJdbFLsVj5viYg==
X-Received: by 2002:a05:6e02:178f:b0:42f:8da6:86c3 with SMTP id
 e9e14a558f8ab-42f8da68abamr17812185ab.2.1759940950779; 
 Wed, 08 Oct 2025 09:29:10 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea300f7sm7148800173.16.2025.10.08.09.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 09:29:10 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:29:09 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, kvm@vger.kernel.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Song Gao <gaosong@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] accel/kvm: Cleanups around kvm_arch_put_registers()
Message-ID: <20251008-3120f4e8a25446b5a05aaa7d@orel>
References: <20251008040715.81513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008040715.81513-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=ajones@ventanamicro.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 08, 2025 at 06:07:11AM +0200, Philippe Mathieu-Daudé wrote:
> Extracted from a bigger series aiming to make accelerator
> synchronization of vcpu state slightly clearer. Here KVM
> patches around kvm_arch_put_registers():
> - Move KVM_PUT_[RESET|RUNTIME|FULL]_STATE to an enum
> - Factor common code out of kvm_cpu_synchronize_post_*()
> 
> Philippe Mathieu-Daudé (3):
>   accel/kvm: Do not expect more then KVM_PUT_FULL_STATE
>   accel/kvm: Introduce KvmPutState enum
>   accel/kvm: Factor kvm_cpu_synchronize_put() out
> 
>  include/system/kvm.h       | 16 +++++++------
>  accel/kvm/kvm-all.c        | 47 +++++++++++++++-----------------------
>  target/i386/kvm/kvm.c      |  6 ++---
>  target/loongarch/kvm/kvm.c |  8 +++----
>  target/mips/kvm.c          |  6 ++---
>  target/ppc/kvm.c           |  2 +-
>  target/riscv/kvm/kvm-cpu.c |  2 +-
>  target/s390x/kvm/kvm.c     |  2 +-
>  8 files changed, 41 insertions(+), 48 deletions(-)
> 
> -- 
> 2.51.0
> 
>

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

