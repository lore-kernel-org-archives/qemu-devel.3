Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD55CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZxK-0007ym-T9; Mon, 08 Jun 2026 09:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWZxJ-0007yP-BI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wWZxH-0007Rn-Lg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780925030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kepsJWdZNwrtU5U7KuXr07zGMOTNfE2NlCbT4+vKSe0=;
 b=XzbM7KFnLLyA5m+P7PzunF61yezsxO1iGaplWXYLhjTQqDBBv5WlA+REY3pCX3JCGyIi+u
 xe6jZZXQCCPgUt4UmpCFPFTAcP+BvfLr/cc6GwpyLZpoxr7fGwYKOzeymH/RcfuvzogC0c
 cDNrNdJ7DnEcLGZHEguDZLvtMIYnaK4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-iq6WE2NhPwKzGBT1uVSkvg-1; Mon,
 08 Jun 2026 09:23:47 -0400
X-MC-Unique: iq6WE2NhPwKzGBT1uVSkvg-1
X-Mimecast-MFC-AGG-ID: iq6WE2NhPwKzGBT1uVSkvg_1780925026
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D2921955F6A; Mon,  8 Jun 2026 13:23:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.153])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 156A31956053; Mon,  8 Jun 2026 13:23:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0280C180060A; Mon, 08 Jun 2026 15:23:43 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:23:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
Message-ID: <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
 <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> > When not booting via UEFI you can ignore that.
> 
> But if I'm doing direct kernel boot then by definition I'm
> not booting via UEFI, I'm directly booting the kernel...

You can (on aarch64) do direct kernel boot both with and without
UEFI firmware ...

Without firmware qemu will load the kernel binary, then start the VM
with the instruction pointer register pointing to the elf entry point.

With firmware qemu exposes kernel + initrd (and with this patch shim
too) via fw_cfg, and the firmware can pick it up from there and run
it (instead of trying to boot via disk / cdrom / network).

take care,
  Gerd


