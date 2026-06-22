Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22F7CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVty-0001Jw-RI; Mon, 22 Jun 2026 00:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbVtg-0001H5-AG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:04:33 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbVte-0007SA-PO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:04:32 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so6295289a12.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 21:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782101069; cv=none;
 d=google.com; s=arc-20240605;
 b=UVc8pO2xdtjtjMoJ6jfTwo6Pg6ZKW9CXm78RuCCm4mWN7qX8iKN9NgpHADRfkinHeI
 gW8XZsAWRYwXNqdUm0+zT9fta5Qxt/VStROKgl4DozV5yFwBE11nRiSJu8wGOAYfFebo
 TchX43dxtpTBoJl4PWt6A1jFvK5H68Rxje4Tq80Jd2ibZhLbK0JFgkBh3sZgkZD/crU+
 qtbNXRxrbn1tK0FKU+tL6aLRqvM3xLcn8IIOFY1e2zvfc5HA7f6frLRLMuvfn8A82ykp
 8FAw7FFaqEFhAvWWY0VTO5MRSjuPae7MBBSb6HgfL0c4k/9dz1CCJfJ11sUw25u+zHab
 +F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oggZJT1bpcXZsBglb45WvKyThfsWwP54jRy7SzY3AoQ=;
 fh=KxuOr3nWkm6g2k1L0PKIWO/Y2QnL079d8A1i30z2gYo=;
 b=KOTpYVLbOGvchKZcu6Rislfq0mF4pI3J/jNp3R3vFGcgKtsB+lt3o6tTOenvQso9Hf
 7wfIJTVcivLIucN1NVwY70qPBz+c4nfQmeH989KA5wAo6xEzcNmRbSjA5Gpz5gcXANeC
 4SKeEyh+KgYjJN33sgGNjWJN3IZw5UOQh6dkwo5DuClsUHmTUT60YMG5Rbb/KUhRWTmS
 ak7lshVXnTmiO+clVOjyqh8TvD/oquZW0Nbv/Euk7VHkvPm2LyQT7Kx6C2vcr1Qn8FKp
 vU93bqIXwz3Xw69oUrJFTxV96ri9FlD81Jq3v807NC0V1Lblu2gq+AJH0NxV1BZfwPKC
 LBdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782101069; x=1782705869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oggZJT1bpcXZsBglb45WvKyThfsWwP54jRy7SzY3AoQ=;
 b=CDbIEhkyzEf2plk2yn0lbgAneAc0fDe0zT5f9FInZhpCRMTyyIvqktGfHMgu7JpMxb
 3IjuN6i/Ay5ei+qbH63PWn1tR3i9rqMTWnPqGJ2mHtdjK3UIOpLOqULHLGFgMR9kl1X3
 5BP60wQAfuWX4wl4nq18Xm4i0+OSyvlqAi5pb7NxTb7p0HmByv4K9KpfG8iOMXCvytDl
 iECwRCbvkuYqUBLd7M8z3OEDdtbsnuKCRurjuhHthf7BiOGroPgYgijZHu0JuWN8MzN+
 zEy/gvwWzEe8xg6EToLVhN+3jPDFSf6l7lL3d8mG9I90SRKu/uOv4JsHZ27cME8r/CMY
 zQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782101069; x=1782705869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oggZJT1bpcXZsBglb45WvKyThfsWwP54jRy7SzY3AoQ=;
 b=l0q8UROJMBBpcu6WIjHSPgnSoj1ANKkwqIz7KEEJK0Fp9NiwusJ8bQaHvmmeyf7h65
 3tMv1mCzubqspQDrU2Z8qnjOwMwg/mMSi7IJ/zBbl0sRvY703K63KvlmvgK4Hx8eljg3
 7P51utIYlACCM473HWzQOJ5+Il5S5uIJlrgDtG5PhyjW+qO8tRCojAGe82TVn+bnw5Ss
 javSekgkkFy3evJHYsrAwxp+VXv3q7pXSI8aWdgAU6FNUQRQbxZBoLA916YlZcUE88P4
 I54aOvQMpUS66LzmjVd/XzKS1rl8H7wyOxzDA/xUt+162X8ScSAjH9+nOKpa+ZoLSBS0
 8f8g==
X-Gm-Message-State: AOJu0Yz1FnVOmYV3tGWaQBsENBPUX30V6fhrIjqBt/IuSzHdOy+E6j3R
 C+KC3603UUGvtL2ZnSojmH9dk0D4HeFGSvCxaemiyooh0TTxGRZP2F5N35kJhOMQNPf6XTQZGte
 d1/aMfOVoriKRHlduhguMK0+TFfnEJVc=
X-Gm-Gg: AfdE7clxNQfOwgpMKpArttYQyyRhaPk6RKrhKPb7m1c8Uf3XLMyKJpJfPt0BTK9jaLa
 4EHz1qi27vURuMVlPcB/RXv4DpZ9RnNdPyjVg5bEr7SIsEyArxSOLSzvaGNTd4Qo06qe7hNmv72
 7jP3aCaAR4vD6hNX4l8Us5brut36g6QwQ6xJIwHMolQOOQjptYRa87cKP7NkgyzGOWaTU43w4wq
 bAzlbRqGWI0iPzhvaVjz4RE2lsu/3A7pw8SgE/Qap8VC1TGLh5uUM/itApxcFcyq/G1VwBFSeah
 phfgqH+pPJk8DjANyEzuOCt5jsg=
X-Received: by 2002:a05:6402:5248:b0:697:7027:4ee2 with SMTP id
 4fb4d7f45d1cf-69770274fa6mr3810692a12.17.1782101068825; Sun, 21 Jun 2026
 21:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
In-Reply-To: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 14:04:02 +1000
X-Gm-Features: AVVi8Cdr5gHWclcXUOchlLuwzSsoBI_xwz1-hfLdusLkisP0E7ZUuZFA_OAyYlc
Message-ID: <CAKmqyKM0KjuFQbWE7n4dGPdbaUdaHec+D=tVX4pHsOZXZBjqcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/intc: Skip reset for KVM irqchip
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jim.shu@sifive.com, nutty.liu@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 15, 2026 at 11:20=E2=80=AFPM Qingwei Hu <qingwei.hu@bytedance.c=
om> wrote:
>
> This series fixes NULL pointer dereferences in the RISC-V APLIC and
> IMSIC reset paths when the interrupt controller is handled by the KVM
> in-kernel irqchip.
>
> Changes in v2:
> - Split the APLIC and IMSIC reset fixes into separate patches.
> - Carry Nutty Liu's Reviewed-by tag from v1.
>
> Qingwei Hu (2):
>   hw/intc: riscv_aplic: Skip reset for KVM irqchip
>   hw/intc: riscv_imsic: Skip reset for KVM irqchip

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aplic.c | 4 ++++
>  hw/intc/riscv_imsic.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> --
> 2.47.3
>
>

