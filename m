Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EAEFED2E4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bCZ-0006bC-Jt; Thu, 12 Mar 2026 04:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0bCY-0006aX-6m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0bCW-0003Np-Fi
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773303322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=80q+pyi0S5qO4NHmKFWkrmxxs7JBEn19mxTR2h5sL7Q=;
 b=O7L/B7qmgCVUWInsKBZEZrLpT+6IoTEBuh6Qr1GlheQiQt3F2qNynBOyGzcCgqK7K/oRqv
 DPQayvbREfsRgbp5T0zEvzrCb5AWvv2OvYp3B93bj7dccyw5LjshaZvqiIcwe1Ls+qe8Ya
 be3XWhLw6w3C1Fbs6q6o3SjwXUip4vI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-oHI1ex-JPB2bmUIFCOT_3A-1; Thu,
 12 Mar 2026 04:15:21 -0400
X-MC-Unique: oHI1ex-JPB2bmUIFCOT_3A-1
X-Mimecast-MFC-AGG-ID: oHI1ex-JPB2bmUIFCOT_3A_1773303320
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89627197768B; Thu, 12 Mar 2026 08:15:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2922630002D6; Thu, 12 Mar 2026 08:15:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A822A21E6937; Thu, 12 Mar 2026 09:15:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: -device T,help crashes
In-Reply-To: <87pl5abgpl.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 11 Mar 2026 15:09:42 +0100")
References: <87pl5abgpl.fsf@pond.sub.org>
Date: Thu, 12 Mar 2026 09:15:17 +0100
Message-ID: <87bjgtzcoa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Watch this:
>
>     $ qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help
>     qemu-system-aarch64: ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>
> A number of devices crash this way:
>
> * acpi-ged (aarch64 arm i386 loongarch64 x86_64)
> * fsl-imx6 (aarch64 arm)
> * fsl-imx7 (aarch64 arm)
> * fsl-imx8mp (aarch64)
> * microchip.pfsoc (riscv64)
> * riscv.sifive.e.soc (riscv32 riscv64)
> * xlnx-zynqmp (aarch64)

Alistair Francis posted a fix

    Subject: [PATCH 0/7] Fix some -device T,help crashes
    Date: Thu, 12 Mar 2026 14:31:51 +1000
    Message-ID: <20260312043158.4191378-1-alistair.francis@wdc.com>

Thanks, Alistair!

> Here's another one:
>
>     $ qemu-system-sparc64 -S -display none -M virt -device sun4u-iommu,help
>     qemu-system-sparc64: ../system/physmem.c:1401: register_multipage: Assertion `num_pages' failed.
>
> Devices crashing this way:
>
> * Loongson-3A4000-mips64-cpu (mips64 mips64el)
> * dc232b-xtensa-cpu (xtensa)
> * dc233c-xtensa-cpu (xtensa)
> * de212-xtensa-cpu (xtensa)
> * de233_fpu-xtensa-cpu (xtensa)
> * dsp3400-xtensa-cpu (xtensa)
> * fsf-xtensa-cpu (xtensaeb)
> * lx106-xtensa-cpu (xtensa)
> * sample_controller-xtensa-cpu (xtensa)
> * sun4m-iommu (sparc)
> * sun4u-iommu (sparc64)
> * test_kc705_be-xtensa-cpu (xtensaeb)
> * test_mmuhifi_c3-xtensa-cpu (xtensa)

Thomas Huth posted fixes for mips and xtensa

    Subject: [PATCH] target/mips/cpu: Move initialization of memory region to realize function 
    Date: Wed, 11 Mar 2026 22:16:29 +0100
    Message-ID: <20260311211629.118608-1-thuth@redhat.com>

    Subject: [PATCH] target/xtensa/cpu: Move initialization of memory region to realize function
    Date: Wed, 11 Mar 2026 21:25:03 +0100
    Message-ID: <20260311202503.107026-1-thuth@redhat.com>

Thanks, Thomas!

We still need a fix for sparc.

> These crashes escape tests/qtest/device-introspect-test, because it
> covers only HMP "device_add T,help", not CLI "-device T,help".

Anyone wants to cook up a patch to cover -device?


