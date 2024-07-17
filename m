Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5E1C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzYQ-0002Ea-Vu; Wed, 17 Jul 2024 03:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sTzYP-00028a-Fb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sTzYJ-0002Pa-CS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 03:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721203097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCkJlmWrSesCrwKH6u57qUR/KXqhyEQ84J0GnoDPXlE=;
 b=Q0ycHoWqJXiDA4fnW5zrSkcNCOK6uD0zH2A9KDGWu7Ozth/rCFtGJhXb0AUQ9w+STGTJaH
 3lVYjjM/Stw9VFbO49Q6KCWtuRsL6b8nLBlTNtOkOc/ocQ9O3AtXvlnWuxtBmHt8h6fd/3
 o9P3MfMRnFGcYfiwGzNd56ChinGOVtQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-B9g7kWrlObaMTxEaCDaqBA-1; Wed,
 17 Jul 2024 03:58:09 -0400
X-MC-Unique: B9g7kWrlObaMTxEaCDaqBA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C17A81955D48; Wed, 17 Jul 2024 07:58:07 +0000 (UTC)
Received: from localhost (dhcp-192-176.str.redhat.com [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A1D31955F40; Wed, 17 Jul 2024 07:58:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC 0/4] Added Interrupt controller emulation for loongarch kvm
In-Reply-To: <cover.1721186636.git.lixianglai@loongson.cn>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <cover.1721186636.git.lixianglai@loongson.cn>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 17 Jul 2024 09:58:03 +0200
Message-ID: <87r0bsa1ro.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Wed, Jul 17 2024, Xianglai Li <lixianglai@loongson.cn> wrote:

> Before this, the interrupt controller simulation has been completed
> in the user mode program. In order to reduce the loss caused by frequent
> switching of the virtual machine monitor from kernel mode to user mode
> when the guest accesses the interrupt controller, we add the interrupt
> controller simulation in kvm.
>
> In qemu side implementation is simple, just make a new IPI EXTIOI PCH KVM
> related several classes, And the interface to access kvm related data is
> implemented.
>
> Most of the simulation work of the interrupt controller is done in kvm.
> Because KVM the changes have not been the Linux community acceptance,
> the patches of this series will have RFC label until KVM patch into the community.
>
> For the implementation of kvm simulation, refer to the following documents.
>
> IPI simulation implementation reference:
> https://github.com/loongson/LoongArch-Documentation/tree/main/docs/Loongson-3A5000-usermanual-EN/inter-processor-interrupts-and-communication
>
> EXTIOI simulation implementation reference:
> https://github.com/loongson/LoongArch-Documentation/tree/main/docs/Loongson-3A5000-usermanual-EN/io-interrupts/extended-io-interrupts
>
> PCH-PIC simulation implementation reference:
> https://github.com/loongson/LoongArch-Documentation/blob/main/docs/Loongson-7A1000-usermanual-EN/interrupt-controller.adoc
>
> For PCH-MSI, we used irqfd mechanism to send the interrupt signal
> generated by user state to kernel state and then to EXTIOI without
> maintaining PCH-MSI state in kernel state.
>
> You can easily get the code from the link below:
> the kernel:
> https://github.com/lixianglai/linux
> the branch is: interrupt
>
> the qemu:
> https://github.com/lixianglai/qemu
> the branch is: interrupt
>
> Please note that the code above is regularly updated based on community
> reviews.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com> 
> Cc: Song Gao <gaosong@loongson.cn> 
> Cc: Huacai Chen <chenhuacai@kernel.org> 
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> 
> Cc: Cornelia Huck <cohuck@redhat.com> 
> Cc: kvm@vger.kernel.org 
> Cc: Bibo Mao <maobibo@loongson.cn> 
>
> Xianglai Li (4):
>   hw/loongarch: Add KVM IPI device support
>   hw/loongarch: Add KVM extioi device support
>   hw/loongarch: Add KVM pch pic device support
>   hw/loongarch: Add KVM pch msi device support
>
>  hw/intc/Kconfig                     |  12 ++
>  hw/intc/loongarch_extioi_kvm.c      | 141 +++++++++++++++++++
>  hw/intc/loongarch_ipi_kvm.c         | 207 ++++++++++++++++++++++++++++
>  hw/intc/loongarch_pch_msi.c         |  42 ++++--
>  hw/intc/loongarch_pch_pic.c         |  20 ++-
>  hw/intc/loongarch_pch_pic_kvm.c     | 189 +++++++++++++++++++++++++
>  hw/intc/meson.build                 |   3 +
>  hw/loongarch/virt.c                 | 141 ++++++++++++-------
>  include/hw/intc/loongarch_extioi.h  |  34 ++++-
>  include/hw/intc/loongarch_pch_msi.h |   2 +-
>  include/hw/intc/loongarch_pch_pic.h |  51 ++++++-
>  include/hw/intc/loongson_ipi.h      |  22 +++
>  include/hw/loongarch/virt.h         |  15 ++
>  linux-headers/asm-loongarch/kvm.h   |   7 +
>  linux-headers/linux/kvm.h           |   6 +

Please split out any headers changes into a separate patch -- just put
them into a placeholder patch at the beginning of the series as long as
the changes are not yet upstream (and replace that with a full headers
sync later.)

>  15 files changed, 823 insertions(+), 69 deletions(-)
>  create mode 100644 hw/intc/loongarch_extioi_kvm.c
>  create mode 100644 hw/intc/loongarch_ipi_kvm.c
>  create mode 100644 hw/intc/loongarch_pch_pic_kvm.c


