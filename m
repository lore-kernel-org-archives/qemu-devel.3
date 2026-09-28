Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B75CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBfs-0000Kb-E9; Mon, 28 Sep 2026 09:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBfc-0000BL-M8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:45:28 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBfb-0001Q2-1h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:45:28 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-670fee39d73so3013269d50.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603126; cv=none;
 d=google.com; s=arc-20260327;
 b=Rn1HfuVuBtOkUmfCdmoRnI3lFG1SjYXiVIdYdsKANMeaLIIw+805QY1IWBK9pTl/IV
 xr755JFlvzJ7a5EgTuIgPAdPEQwC99VSQpcnww2jEL3QOcCIaHEsxH81X3n/FquRsIzW
 57E9ZKPgGhlLfV6nDOVAuKvTag2tvnfJr2xC+cshlcN3f8YjLjnS68yXiMS6Uie04TEq
 IQET7sUUQ6CgL1RPcgsAkGVQX5nXPJ6Vtn7tvMZNu7/0ENc4twEs5jpk7YY8FA+rA4iy
 7udmxCmA0N25zdCVb0HcGYDLQIcGTqW1ZQAZwDi0pg2k+57vYCaHdQsXVE03MA6tCapR
 aaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KhV3UwfdpRcdUekG+mtvaodNjfW/8yJ5uU8Sh22D3Rc=;
 fh=miZzAVP5oHxszkNrM0Qn9FsaAUdJ1vPRa4D6gSuqPnI=;
 b=qDgRij3ovT+6xj0A9IDGjwtg5mBnLULqDfA4sQkAgAKr3qD3R5BciyzzodUgOM4D2W
 /XR0F6f4ygfKPJiwbTYuC+5+U1c21/eg29JUn2DH07vAmIXpR3bAfiDsSfvmJUngvyBP
 usthtQwyajNBiRtfQFT0VKPV2t5umiikWy59ecqQH5t/CV+pgDsC1moYZyil/uUEatnM
 GmnKfEBv7eVuSr1EaJFK/mpuS3d+FUjf9hhhjxTYGg7mjoP6HYCadQBjRun1YwoNVj8O
 ltfvG2ofXFJ0hZvJwyP0OqI5NIR3rmIyspEupcqjZMOWD9Qr28EZ8wzY0mpkAYKO9hPr
 MOLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790603126; x=1791207926; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KhV3UwfdpRcdUekG+mtvaodNjfW/8yJ5uU8Sh22D3Rc=;
 b=aXBQoI/qE9fIfFYlIZuWR+MzgkFZSgqt0YLAgXEcQmq69O2M/qejiJhK9SkY74WbUG
 4kGiUcEy3tQhsFiisYJj2EkCZqpNJKTor2mkeIG19BQjjMiizqDPmv5kZnIaUTFWFZ1c
 lfTfHuHXGcENlXSAM67rG7KIxp8qIKVottIL9jZLMkQYmk9468nYZA6dEyqv5CnmZ5Ca
 BY5YhKNdfcLVz+9F9MxkMxfW7q0oAXjihKRH+8ehOyWjLpYhT2nTdHSd5kU2fB9IsNII
 k3ZG6phhBgylOy35jMRXdVs11Hl5L6CD3Lu+kA4pnRXqe2YSQcc5tSQkcZjFA4puNJTH
 NTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790603126; x=1791207926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KhV3UwfdpRcdUekG+mtvaodNjfW/8yJ5uU8Sh22D3Rc=;
 b=XgTAXqNg6JQcq8fZC351Dt/IzCP1vuBVCluHqa0eLp39wX5oz6S+HJOdu4x09U3/kx
 SBnoW3D0lcw7YiZmjIceDCdK+WkaNNQ4UHL7EnPWkP3FMFw0W8YXa59ldRiiy55bTNj2
 F2fsaFbnUaA8DKQ/JnzM94gnjZgEe4ulgAsRJ9D9HyKF1pm1PNa1TXYPA5VZF8oj6nJW
 N34MnbpGgClFq1m2doV3y6qCcq3NGLVzfoEIt4V0Crh7QWjbxOm/NiRkSdmqQZxaubRO
 y8Oj7nywupV9sJqDjssaCBe8W7fN74mODEasHoNoZ8GGGfQfJDlKa9WYYNokwrybWo18
 3PIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhDwNuJMul8qfeun8fMpfPr1bB3hYbc33LJmVmlSAveIGIPe9h89J0vREwEp8djosmz4TH6JyDw2cU@nongnu.org
X-Gm-Message-State: AFq9FYLIhZIYhcrN6CyvlEyIZ7tAGe0P+PeUyW7B6inFQRtYmOW1/wsY
 PkzDlGf3NbRSVCPQwT/15GQa4OlnV1jZXZAO3923Lo/H0aGhY+k8Dm1LHn+2Xxn4UfYYUaEYkU0
 tSFlnrIN30agqHG76Xp7C7cjB+6laU4r6K0vSysuDPg==
X-Gm-Gg: AYBFou0LojR2EK6eyqtDW6nmdJeIlDsoNQ0NMatVMEAbVlyEELe4uSfRvMpsu3R/0+J
 e1jh2JjoMzqjLirdfYOumm3JJMBmmRpoZG950NtfyeSLnu6SqJtreCagVSbixkvlyqFi5XByET3
 PXWyCmGgyjmg5OSHLlrjXIeJ4LqHpCpwIrykZLsg11Q3qOBfaegRMQf6Dc5wJW3KkFn+D3Y7uPA
 qPtZiCK3osUYH2t/th7Zq68tQC4fkJDX9BmTp5AgF6giGN5IuaCN4ZI77M6iJhHPMTq+19iOav0
 1vn2RabpIYZOVM6I3XWQjNbYBNewl/UNWuyNIrFYtsbjlK2cErcElxuwolfnuioWs4TJWLXmlio
 UueWw4BTG+5QvgRWEzJzNUHzEQN7g6R6W6w1VJ4Rh
X-Received: by 2002:a05:690e:12c4:b0:675:3735:fdf7 with SMTP id
 956f58d0204a3-67537360a90mr2238368d50.16.1790603125537; Mon, 28 Sep 2026
 06:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260918092120.370805-1-wangyize7@huawei.com>
In-Reply-To: <20260918092120.370805-1-wangyize7@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 14:45:13 +0100
X-Gm-Features: AclHuK8jh9wcEEcEWy7aMhBejScFDDnV4iFR2vRW8uZEOMq8YObDbqDJLsKPyCM
Message-ID: <CAFEAcA-mW_3=qgy2w1cLcXmkEqx3WrzifktvZ7P-0Wez4A=JPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Batch register access for live migration optimization
To: Yize Wang <wangyize7@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, 
 cohuck@redhat.com, pbonzini@redhat.com, zhengchuan@huawei.com, 
 jiangjiacheng@huawei.com, yize_w1110@163.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
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

On Fri, 18 Sept 2026 at 10:25, Yize Wang <wangyize7@huawei.com> wrote:
>
> This series adds batch register access support to QEMU's KVM GICv3
> register synchronization path, reducing syscall overhead during
> ARM64 live migration.
>
> Currently, QEMU issues one ioctl per register when saving/restoring VGIC
> state. On large VM configurations this means tens of thousands of syscalls,
> where lock acquisition and context switch overhead dominates migration
> downtime. Thus, we provide a batch register method to allow userspace
> read/write multiple distributor and redistributor registers in a single call.
> In this way, we can significantly reduce syscalls and migration downtime.
>
> All batch paths probe kernel capability at runtime and fall back to the
> original one-by-one path when the kernel does not support batch access,
> ensuring backward compatibility.
>
> This series depends on the corresponding kernel patches that add
> KVM_DEV_ARM_VGIC_GRP_BATCH_REGS support.
>
> Test the VM migration time under pressure conditions.
> The VM specifications for migration are as follows:
> - VM use 4-K page;
> - the number of VCPU is 160;
> - the total memory is 320Gigabit;
> - use 'Redis SET-benchmark' to pressurize VM;
>
> Performance results (3-run average, ms):
>
>     | Metric              | Without patch | With patch | Improvement |
>     |---------------------|---------------|------------|-------------|
>     | Migration downtime  |        536    |     321    |     40%     |
>     | Source (total)      |        344    |     230    |     33%     |
>     |   - VGIC put        |        158    |      40    |     75%     |
>     |   - VGIC get        |        120    |      19    |     84%     |
>     | Destination (total) |        192    |      91    |     53%     |
>     |   - VGIC put        |        132    |      27    |     80%     |
>
> Yize Wang (4):
>   Sync KVM ARM VGIC batch register UAPI to QEMU headers
>   hw/intc/arm_gicv3_kvm: Add batch helper structures and functions
>   hw/intc/arm_gicv3_kvm: Refactor kvm_arm_gicv3_put for batch register access
>   hw/intc/arm_gicv3_kvm: Refactor kvm_arm_gicv3_get for batch register access

Just FYI for next time, patchsets like these that are the userspace half
of a kernel KVM API change/enhancement that hasn't yet been accepted
into the upstream kernel should be marked as "RFC" for the QEMU patchset.

thanks
-- PMM

