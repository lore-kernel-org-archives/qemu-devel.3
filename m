Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6618C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVb6-0004So-VS; Mon, 12 Aug 2024 10:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdVb4-0004SA-Ir
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdVb1-0003rE-8Z
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723471222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6ZvAq+GOXc8L0INLq77jbI7lCZc0Q7oKteabO3Ej+0=;
 b=KKnN5OcszXu4aBLdCjPv51FBWXT2B1QMGSFWpLn81rj6i6AP5MpkI+u0eQWKe4iqvYaVe4
 xHT1T+B1cvdIXCm167NbSKqHo+DZirweNoCUinnSoqbw6xhscMEX4OpIrKTA9OUpQpmaRS
 uTuw09lG39SyTpj4cGImUqk+j5xv3UI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-eEpgFmNSMa6vPQ3n_MLaqg-1; Mon,
 12 Aug 2024 10:00:19 -0400
X-MC-Unique: eEpgFmNSMa6vPQ3n_MLaqg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2841F1918142; Mon, 12 Aug 2024 14:00:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.211])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C8721955D71; Mon, 12 Aug 2024 14:00:10 +0000 (UTC)
Date: Mon, 12 Aug 2024 15:00:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org,
 agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v3 4/5] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
Message-ID: <ZroVYxNyZjroUEIT@redhat.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-5-dorjoychy111@gmail.com>
 <974b7b36-bfd9-40e6-bbe1-d3feb3d46797@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <974b7b36-bfd9-40e6-bbe1-d3feb3d46797@amazon.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 12, 2024 at 03:51:22PM +0200, Alexander Graf wrote:
> 
> On 10.08.24 18:45, Dorjoy Chowdhury wrote:
> > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > is used for stripped down TPM functionality like attestation. This commit
> > adds the built-in NSM device in the nitro-enclave machine type.
> > 
> > In Nitro Enclaves, all the PCRs start in a known zero state and the first
> > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR8
> > contain the SHA384 hashes related to the EIF file used to boot the
> > VM for validation.
> > 
> > A new optional nitro-enclave machine option 'id' has been added which will
> > be the enclave identifier reflected in the module-id of the NSM device.
> > Otherwise, the device will have a default id set.
> > 
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >   hw/core/eif.c                   | 205 +++++++++++++++++++++++++++++++-
> >   hw/core/eif.h                   |   5 +-
> >   hw/core/meson.build             |   4 +-
> >   hw/i386/Kconfig                 |   1 +
> >   hw/i386/nitro_enclave.c         |  85 ++++++++++++-
> >   include/hw/i386/nitro_enclave.h |  19 +++
> >   6 files changed, 310 insertions(+), 9 deletions(-)
> > 
> 
> [...]
> 
> 
> > diff --git a/hw/core/meson.build b/hw/core/meson.build
> > index f32d1ad943..7e7a14ee00 100644
> > --- a/hw/core/meson.build
> > +++ b/hw/core/meson.build
> > @@ -12,6 +12,8 @@ hwcore_ss.add(files(
> >     'qdev-clock.c',
> >   ))
> > 
> > +libcbor = dependency('libcbor', version: '>=0.8.0')
> > +
> >   common_ss.add(files('cpu-common.c'))
> >   common_ss.add(files('machine-smp.c'))
> >   system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
> > @@ -24,7 +26,7 @@ system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
> >   system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
> >   system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
> >   system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
> > -system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib])
> > +system_ss.add(when: 'CONFIG_NITRO_ENCLAVE', if_true: [files('eif.c'), zlib, libcbor, gnutls])
> 
> 
> I think this is missing a dependency check somewhere:
> 
> ../hw/core/eif.c:16:10: fatal error: gnutls/gnutls.h: No such file or
> directory
>    16 | #include <gnutls/gnutls.h>
>       |          ^~~~~~~~~~~~~~~~~
> 
> It's also the first time anything accesses gnutls directly instead of
> through the QEMU crypto framework. Is there a particular reason you can not
> use qcrypto?

None of the existing qcrypto APIs provide the functionality needed in
this patch. The right answer though is to introduce a new API in
qcrypto to avoid directly coupling this Nitro code to GNUTLS.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


