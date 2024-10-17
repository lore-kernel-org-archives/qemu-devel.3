Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99287D2126D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 10:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1NIe-0003On-LP; Thu, 17 Oct 2024 06:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1NId-0003OW-T4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1NIb-0000V6-Sz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729159204;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kENpIu1OOnzBQgq/xCBsvVL/ByVydWC7GeLK25TRH9g=;
 b=ZX3c5J9FvmxlO6oZe8e9TZQdhSylWTzsRvkk0E9aaHQxXtWHY1MJAmtUUsNnJ7607V/+1K
 bo1xOkNhLTO621BJLyxm0YQF0/SI1x6GpBcElh9CWMxw6RjKqD301PnIQhDbNlqSpEtYl+
 gELq8H21r6XhMlDlQLpCdPc9w9yafJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-5O2ehc_PNvOC7FJKHweiLg-1; Thu,
 17 Oct 2024 06:00:00 -0400
X-MC-Unique: 5O2ehc_PNvOC7FJKHweiLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 700881955F3F; Thu, 17 Oct 2024 09:59:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2FC1300018D; Thu, 17 Oct 2024 09:59:57 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:59:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: htafr <htafreit@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH 0/1] Insert LibSPDM in QEMU enabling in-tree compilation
Message-ID: <ZxDgGsjRkLEA8r6_@redhat.com>
References: <20241016163439.1130168-1-htafreit@gmail.com>
 <CAKmqyKPUUgF1tLKCFF1FiT5HHEDDDg+=Yha2e38wSto4mKh_BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPUUgF1tLKCFF1FiT5HHEDDDg+=Yha2e38wSto4mKh_BA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 17, 2024 at 02:00:35PM +1000, Alistair Francis wrote:
> On Thu, Oct 17, 2024 at 2:35 AM htafr <htafreit@gmail.com> wrote:
> >
> > (I) Summary
> > ===========================================================================
> >
> > This patch is the beginning of the support of the Security Protocol and
> > Data Model (SPDM). There are some known issues (see II), but it's
> > usable and not many users are going to use this functionality for now,
> > but for those who will it may facilitate the development.
> >
> > There are some people working with LibSPDM to implement the SPDM on
> > emulated devices, however current works that use QEMU compile LibSPDM
> > out-of-tree [1][2][3]. This patch enables the compilation of LibSPDM when
> > user pass the parameter '--enable-libspdm' to configure file, this option
> > is disabled by default. The following parameters were also added:
> >
> >   --libspdm-crypto=CHOICE  set LibSPDM crypto algorithm [mbedtls] (choices:
> >                            mbedtls/openssl)
> >   --libspdm-toolchain=VALUE
> >                            toolchain to use for LibSPDM compilation [GCC]
> >
> > In order to facilitate future code development using LibSPDM API, this
> > patch also provides the definition of the macro 'CONFIG_LIBSPDM'.
> 
> We have talked about this before, see
> https://patchew.org/QEMU/cover.1691509717.git.alistair.francis@wdc.com/
> 
> The general agreement seemed to be that it will be hard to do SPDM
> configuration inside QEMU, hence the external library (like the QEMU
> TPM support).

More generally, seeing this libspdm proposed for QEMU, without any
corresponding usage of it it dubious. It is hard to judge whether
it makes any sense, without seeing how it will be used in real
device code inside QEMU.

On the cryptography side, I'm not a fan of linking another
crypto library to QEMU, that's different from what we already
support in our crypto layer. openssl in particular is a problem
due to its licensing - people tend to hand-waive away the
licensing incompatibility by pretending openssl is a "system library"
but I disagree with that interpretation.

> > (II) Known Limitations
> > ===========================================================================
> >
> > 1. This patch enables LibSPDM in-tree compilation for Linux systems only.
> > 2. LibSPDM compilation uses CMake, so meson build system is making use
> >    of the CMake module [4].
> > 3. Some problems may occur when compiling LibSPDM with MbedTls such as:
> >     error: "_GNU_SOURCE" redefined [-Werror]
> >       10 | #define _GNU_SOURCE
> >
> >    It's possible to compile using --disable-werror.
> >
> > (III) Sample configuration
> > ===========================================================================
> >
> > ../configure \
> >   --disable-werror \
> >   --enable-libspdm \
> >   --libspdm-crypto=mbedtls \
> >   --enable-gcov
> >
> > References:
> > [1] riscv-spdm
> >   Link: https://github.com/htafr/riscv-spdm
> > [2] spdm-benchmark
> >   Link: https://github.com/rcaalves/spdm-benchmark
> > [3] qemu-spdm-emulation-guide
> >   Link: https://github.com/twilfredo/qemu-spdm-emulation-guide
> 
> This one has been merged upstream and mainline QEMU supports it now:
> 
> https://www.qemu.org/docs/master/specs/spdm.html

So with that merged, is this proposal for linking to libspdm redundant ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


