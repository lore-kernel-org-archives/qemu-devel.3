Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3404BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hC3-0007et-5X; Tue, 14 Oct 2025 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8hBy-0007eE-JN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:44:04 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8hBw-0001zU-C9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:44:02 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-77f9fb3bea0so46181617b3.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760456638; x=1761061438; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ECdkLTfi+X6ZwSC+wiORp/s4xUi5Nwu14n7xoHWzb1U=;
 b=sOzFUBQfdvDstJ/3pBZGl3CLFg0xDCfgwYacgSv9XQK5R/Dtnrtt8VwtDd2Yrrpp2d
 IFAGFo6HO3zC3PF0vezvqHuCfq3XvLZlqvQKAp9+sFx5qCDIm4qIwQuMFLSomfFMOrhi
 im8TbwwNcfOFVtqNOVqVBBWg3//9AQGKkMoPFA+X7GErFOTu6r4U1Y2REYtxKlmaLn+z
 q2UPxldWTd/SZMrl0lJ2xy0HHRoUOcaAyk2SQpUC3+ydXKeHUj+w05da34OK8CvvDyVv
 RA1nPRGD+AHTbG7oJeA2UejI6/YIolZhl9Q99/MPr8A1PL8hHP/z4fSVgRn6hY/Cgign
 q0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760456638; x=1761061438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ECdkLTfi+X6ZwSC+wiORp/s4xUi5Nwu14n7xoHWzb1U=;
 b=TNqhCNL8XO+xSr9FHj0uLCY0qsMlO5XPsuerUxj/KQaV7jrmXoMHstxWndHZcxsPOT
 HQ07eQaZ/p/HjBjSmoKJ3xycVpcvhmtYMzHsC6P9I4/eT6YDBltnaJMrMkII0pDAwsDf
 qBI1rCLTiJ+6AU0xNhXau20WBvMZQ4LCTrD+R9DpSgzt/jDTB0NCQMRFmV6/Bk4DeYK/
 dASfYTMWYFJtMsn8pufPxVOYQ4BMM0NhCoqSABz3anp62JNrIc68f6K7nyDvN4D6oipC
 Y76dHjwktfqRIn3IhYag2GN4Cc9XabAl9JMhvVS4ux03Yr46XHb+0gm9mnbMo1/0ncFk
 lb/Q==
X-Gm-Message-State: AOJu0YwW6jjO7ilkCCuDTf1/rzpV0fXCjQSrkXW04TKPb0UvDdnj0GNX
 Yw8hasyHeglT4asdvDomLUxqRO7nZyLV3txZQiCXB9liMl3Pi3XqD2gbyRCicmBjTrZ/0LRwDHt
 NCA6G+FnR7op7YqsKegM6YkpsMqCcpDmjTlMSOpnieg==
X-Gm-Gg: ASbGncvSRSnujn3nzjgGgy5EMgCOppE1cckM0La2GjlR9+Kpf7sxIbJsux7pl5ZqOVA
 VgmLy3qMODhNLPjgVf5yPoI2/YTBpSNeb9oYMWgnerPo7LkjLOyejXej3i+DAAbv1LR7lPclm0/
 3AkvwSbHGqaFLiHK3cM5uBkiv4Z3sUvsJf5SDFAtRmECd+PDJ1OjYeUnQEf09AUC0LsQH4KVHwk
 FsXMP6tTPtyCWAuIKg7chl8lr0v6ZlBJ9ZAPwXUeA==
X-Google-Smtp-Source: AGHT+IERxCKo5/BYqog0en8x5L7VgwyHJD1Gx9tNUuLRVlmKWiKkdjYf6UvGUCtIAhWMvYsTJoM28afWkST6n0b4UhA=
X-Received: by 2002:a53:c792:0:b0:63d:234a:cc21 with SMTP id
 956f58d0204a3-63d234c11a7mr1240202d50.55.1760456638430; Tue, 14 Oct 2025
 08:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
 <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
 <a630fc58d9f946988bd6c27479543dd1@huawei.com>
 <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
 <880fc89ebcb9404cbc135a501e635671@huawei.com>
In-Reply-To: <880fc89ebcb9404cbc135a501e635671@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 16:43:47 +0100
X-Gm-Features: AS18NWDXNMIlCBZR99Yd35a8oNwqvy7De_9UrGoMQPV-NgDoaenH9Kk17EpUleU
Message-ID: <CAFEAcA-gZj7PBM4whrvvz=qy3taO9Dz4Z2HEAAB8cE0vxH3bug@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 14 Oct 2025 at 16:33, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: Tuesday, October 14, 2025 4:24 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> >
> > On Tue, 14 Oct 2025 at 16:13, Salil Mehta <salil.mehta@huawei.com> wrote:
> > >
> > > > From: Peter Maydell <peter.maydell@linaro.org> In what situation do
> > > > we ever start running a VCPU before the *GIC* has been realized? The
> > > > GIC should get realized as part of creating the virt board, which
> > > > must complete before we do anything like running a vcpu.
> > >
> > >
> > > Just after realization of vCPU in the machvirt_init() you can see the
> > > default power_state is PSCI CPU_ON, which means
> > KVM_MP_STATE_RUNNABLE.
> > > Since, the thread is up and not doing IO wait in userspace it gets
> > > into
> > > cpu_exec() loop and actually run KVM_RUN IOCTL. Inside the KVM it
> > > momentarily takes the vCPU mutex but later exit and releases. This
> > > keeps going on for all of the vCPU threads realized early.
> >
> > Yikes. We definitely should fix that : letting the vcpu run before we get to
> > qemu_machine_creation_done() seems like it would be a massive source of
> > race conditions.
>
> I've already proposed fix for this by parking such threads in userspace. Please
> check functions virt_(un)park_cpu_in_userspace(). But need to check if we can use
> this trick can be used at the very early stages of the VM initialization.

I had a look at this on x86, and we correctly don't try to
KVM_RUN the vcpus early. What happens there is:
 * the vcpu thread calls qemu_process_cpu_events()
 * this causes it to go to sleep on the cpu->halt_cond: so
   it will not end up doing KVM_RUN yet
 * later, the main thread completes initialization of the board
 * qdev_machine_creation_done() calls cpu_synchronize_all_post_init()
 * for kvm, this causes us to call kvm_cpu_synchronize_post_init()
   for each vcpu
 * that will call run_on_cpu() which ends up calling qemu_cpu_kick()
 * qemu_cpu_kick() does a broadcast on cpu->halt_cond, which
   wakes up the vcpu thread and lets it go into kvm_cpu_exec()
   for the first time

Why doesn't this mechanism work on Arm ?

thanks
-- PMM

