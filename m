Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D74DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDnn-00055u-Tg; Mon, 13 Jul 2026 06:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjDnm-00055m-Iy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjDnk-000850-HB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783938134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAOrQ4OSPood1KI/btVIPlkPlUdv5TvfCmfqhB9g5ns=;
 b=LMakvKRNclbdN5VlH/b0FYto5f9Lv/gsSnNx2AwLKJ2+y9kt/LWEaHD0+9xbCnlHC5MaZN
 tzv9Hefnq+6GbBMGGGJ1kL2DzZk0KQ/G+CJXx00xpmLQea7aoWuyn11B2VNJdj6MDY0srX
 XRngede6RNkzrhlHABPJOcgJAtl2IRM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-lsehzDiDMaKxFrEcX2TKbg-1; Mon,
 13 Jul 2026 06:22:11 -0400
X-MC-Unique: lsehzDiDMaKxFrEcX2TKbg-1
X-Mimecast-MFC-AGG-ID: lsehzDiDMaKxFrEcX2TKbg_1783938130
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7C918052F1; Mon, 13 Jul 2026 10:22:09 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 483AC19560AB; Mon, 13 Jul 2026 10:22:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda
 <pbarbuda@microsoft.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 13 Jul 2026 12:22:06 +0200
Message-ID: <87ik6ji3zl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=cohuck@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 10 2026, Peter Maydell <peter.maydell@linaro.org> wrote:

> (cc list is a random mix of maintainers of code that calls this
> function, Paolo as "main loop maintainer" and a few others who
> I thought might have an opinion.)
>
> We have a qemu_system_guest_panicked() function which causes QEMU
> to report this to the user and do one of a couple of possible options
> (shutdown, pause the VM, do nothing). This seems mostly intended for
> "the guest OS told us by some mechanism that it just panicked". But
> we use it more widely than that...
>
> Cases which are "the guest told us about a panic":
>  - accel/kvm/kvm-all.c handling of the KVM_EXIT_SYSTEM_EVENT SEV_TERM
>    and CRASH subtypes

These two events seem to be x86 only.

>  - the pvpanic device
>  - the spapr ibm,os-term RTAS call
>  - x86 kvm: tdx_panicked_on_fatal_error()
>  - x86 xen: the SHUTDOWN_crash shutdown subtype
>
> Cases which are not:
>  - hw/spapr/rtas.c: if the FDT has no RTAS address during system reset
>  - hw/spapr/spapr_events.c: if we wanted to deliver a machine check
>    exception to the guest but the FDT has no RTAS address
>  - hw/spapr/spapr_events.c: if we want to deliver a machine check
>    but the guest is still dealing with a previous machine check
>  - arm whpx, if we get an unknown/unexpected exit code trying to run the VM
>  - x86 nvmm, for an unknown/unexpected VM exit code
>  - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
>  - s390_handle_wait(): not sure exactly what this is

Loading a "disabled wait PSW" (waiting for interrupts with no interrupts
enabled) is basically the way for an OS to "panic". (The "special wait
PSW" is for signifying that a cpu has been shut down.) IOW, this is
indeed the "panic" case for s390x.

>  - s390 unmanageable_intercept(): again not sure, think this is where
>    the guest has gone off the rails and we can't keep running

It's basically "the handling code for an exception immediately leads to
the same exception", the cpu has gone into a loop and can't get out of
it again. Not sure if that should be getting some different handling.


