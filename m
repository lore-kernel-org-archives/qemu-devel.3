Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AB0CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umu2U-0002W4-AT; Fri, 15 Aug 2025 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umu2P-0002VF-5u
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:00:05 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umu2M-00008e-Es
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:00:04 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e931c741d7fso1902026276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755262800; x=1755867600; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc4REYiH1a1+7FzI5isYOyDl7VDN6ZSbRgdajw/Zpqc=;
 b=uFG5VRAV3UDxD/HK/WnV/sdb3+mXbo2acjt8hit6Ots/kUbtzj7SNw0oqabyniDSxi
 47i1BWJBSKsdqNKfwqmfLbgRrj/cW4RQ8aUNnaIQ2RGfiAP4fbGEvb4wncxSzN8UbhGu
 jaIUUvLuMUdxfq/WGgqAc3mPp4Hv4AAIN7Z2/eortxWkiSRUdMizXJ1d+BKcEvBzXZUU
 pTRULhPPCi09k+O5jPUFrd2md8oqB8YrEi8Yq4xU+UHn1btz1OG//gQ8b/z8yvm0x74d
 nLc/+s/TW4vV49D5pMTWqc2Cip2Gn+VKqluo+A7IFAdw834Q4NmBK1Dh6mgZEhFNZP9J
 8EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755262800; x=1755867600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vc4REYiH1a1+7FzI5isYOyDl7VDN6ZSbRgdajw/Zpqc=;
 b=dxouRyzxw3VQKAKK9K/41mom179qx347PiPWZFuETa++eaivMXanZgBXsxs0fRLQeC
 WS7UxzWOVVmsfZyCWWlw0TejEjiiouga1I2VabT+qautItFjKukXEAOlrkSN3nWwnlBc
 5inc5YI6pbg6sW0FVhDD3dnWtlgKSW8v+NF5Y984Iv/FMVGWeL5j1ox7Cd2ElJjX5kdb
 om53ArSO3LdnxF9pw6XVvrOpexHbkrDukMwcd6XeYdo1+1VneKH9ITjWq5d4yRhVFKSR
 ca6nu0bbPqPi3DPHSn+lcJJNJxUIHg8iOqLhSTXZQmEhV0LFNloEkb8U+f8ErJR5b3Ey
 6ORA==
X-Gm-Message-State: AOJu0YyofVMT4o2pYYq+kl20vUbbV+GLQT5F8XbIc+bRLe1t9asJsz/h
 d9TjONCcLY77tJ2oq0TuWl8wm+WFAUHNBv3q8AEAkt9133SYA/CXYaXe9vTuS2hnX0vjW9n9MsI
 nySJaamM6UDogAPUxJyom4IZ+5OTkQOO+A73JbiSfgA==
X-Gm-Gg: ASbGnctmSUWU6SyZvxjWVBgNbhI3Y6hcdoKt6lAg3p1f77eeylhe5E8DFt+LO0U3MJV
 fVIy1pjX05TXEfTDxoK8ysdWjE3elkSi056TfbdPhJ/hfsmrw9NkohV6JSoVomxpf26Qznn47+l
 Q/KgRt2yHVz5H6eIs+TmwWF3CbUkAeLc853ItA9aZE6TucFBe5IyFg7eaKmtQSZJjhiJoXJGGfK
 C7Zuv3o
X-Google-Smtp-Source: AGHT+IGFIMKiRZXEeB9ezsWDZWRBtt5jtewhONLj55QuXA6jljJTYcOf+tK8Y9E1x6owISmLe3dOYEhMZJT0ZRsRafo=
X-Received: by 2002:a05:6902:2b07:b0:e90:5a2b:ebdc with SMTP id
 3f1490d57ef6-e933253d0ddmr2279023276.47.1755262800225; Fri, 15 Aug 2025
 06:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <1754936384-278328-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1754936384-278328-1-git-send-email-steven.sistare@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 13:59:48 +0100
X-Gm-Features: Ac12FXwFkNezNFzgK9edmE1qo9zifzDymOAZaTDFSrWBeZXIc1IL1-eZ-tRAY0w
Message-ID: <CAFEAcA_7cxuKbgpygGyexL3k_jPt=1O_v8V3ir5KKMnXVT6oHA@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Mon, 11 Aug 2025 at 19:19, Steve Sistare <steven.sistare@oracle.com> wrote:
>
> Close a race condition that causes cpr-transfer to lose VFIO
> interrupts on ARM.
>
> CPR stops VCPUs but does not disable VFIO interrupts, which may continue
> to arrive throughout the transition to new QEMU.
>
> CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
> future interrupts to the producer eventfd, where they are preserved.
> Old QEMU then destroys the old KVM instance.  However, interrupts may
> already be pending in KVM state.  To preserve them, call ioctl
> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
> they will be picked up when the new KVM+VCPU instance is created.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---


Applied to target-arm.next for 10.2, thanks. I added a cc:stable tag.

-- PMM

