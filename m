Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A108CCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 11:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqsZz-0004EU-Ip; Wed, 18 Sep 2024 07:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqsZy-0004DR-7N
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 07:10:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqsZw-0007vt-Hc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 07:10:37 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so1275796a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726657833; x=1727262633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SRZbVG1IhzLF4gQfRB4AzzHyFJqyHn5f75uQWWvm/bw=;
 b=zCc1qVmn6VabQuWx0a6zeSpH87HyKeCiDtJgPuBHEwpwNmg2KtFfHtjwIKXjDrooIB
 hnogrmke4Uf0+8f3uO7JCjxJ5f3sE98pSLGS7G2BJpFu52hCO5R6jxZSU74MbpBfnIgk
 K0mYrKF9uicBrYFIlfDf3QCKdOwGN79wDuapq6F/WTiKX0q4GGv0lMN4wwUKIBhsxwOX
 9QdOLvgOxa7w1q4263Xcb6TleIMNKLJekqxkrVssitLnzrf8TFAgUN4sKQPkWe9FdKiJ
 fWbXA4eGZQI2ntWFTXYGry/VXIQL9sUl6lNaWOPe7Xf5Ces78Te9HeolQTGQv1DszPc8
 ZV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726657833; x=1727262633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SRZbVG1IhzLF4gQfRB4AzzHyFJqyHn5f75uQWWvm/bw=;
 b=CRkU3nmtIsinjNFBwg12Z9X1fCgAvlNelSf/KhR76Kubw74g8f4cj0MA/ZYbG1624T
 U5I/qLqG8F0dKlG4ZGoyNW+mNQEtQBzlTAtOZtXtxWdEXfGToto3B7rv0hcyKNoVsEiy
 4m1F5wG0drjhFDjz8wY75jW+1/wRzMZGP0Ck5g8JgJbiPEZ0rFWoTuzVWrEClVbO0CUR
 pWj5B0jRJO8akVJW/QXDrAFcAMZbaEwuSYbdhPCahwcwbPwQvDg5F6rRz/VjhItZxx4L
 LNFiCMk51ClJlHKiAoc99sKDnOwstpRd0uodwU6J5BcPHiQBH3CNRNPprZgtLvaAa8P/
 +M1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnd4r99TtxBzSBT47rtixhXV7zAi73WOkFtLzcGsGVwWZQFXOjfNUY6es04MFiCrQJjco5TPv+AmwC@nongnu.org
X-Gm-Message-State: AOJu0Yxbl6Qi2VlvXX59n7jstDFtToOzuqn+Ew/3gG63Se+x522Iy6fK
 vtALBYs023o1wP66I/12wkczgsABD6M6BO6W41mwPHK8yjfImbZ1x/5PSm9WZts6LRDoD9Pg6VD
 fGWNbN3U1PT/SVJ1cCde0Z62YbXFMb1bLeoVzkQ==
X-Google-Smtp-Source: AGHT+IGBXJ07Gt78CUwOdJRwkknc9yCkL5BLIwG3FEocWciml96gp0ZI/zuYvW05MNno9h9wE8tMmu/6bWIym7WiaKI=
X-Received: by 2002:a05:6402:520e:b0:5c2:5248:a929 with SMTP id
 4fb4d7f45d1cf-5c41435c3d2mr27093336a12.7.1726657832550; Wed, 18 Sep 2024
 04:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
In-Reply-To: <20240918-039d1e3bebf2231bd452a5ad@orel>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Sep 2024 12:10:21 +0100
Message-ID: <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 18 Sept 2024 at 07:06, Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Tue, Sep 17, 2024 at 06:45:21PM GMT, Heinrich Schuchardt wrote:
> ...
> > When thinking about the migration of virtual machines shouldn't QEMU be in
> > control of the initial state of vcpus instead of KVM?
> >
>
> Thinking about this more, I'm inclined to agree. Initial state and reset
> state should be traits of the VMM (potentially influenced by the user)
> rather than KVM.

Mmm. IIRC the way this works on Arm at least is that at some point
post-reset and before running the VM we do a QEMU->kernel state
sync, which means that whatever the kernel does with the CPU state
doesn't matter, only what QEMU's idea of reset is. Looking at the
source I think the way this happens is that kvm_cpu_synchronize_post_reset()
arranges to do a kvm_arch_put_registers(). (For Arm we have to do
some fiddling around to make sure our CPU state is in the right
place for that put_registers to DTRT, which is what kvm_arm_reset_vcpu()
is doing, but that's a consequence of the way we chose to handle
migration and in particular migration of system registers rather than
something necessarily every architecture wants to be doing.)

This also works for reset of the vCPU on a guest-reboot. We don't
tell KVM to reset the vCPU, we just set up the vCPU state on the
QEMU side and then do a QEMU->kernel state sync of it.

-- PMM

