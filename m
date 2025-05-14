Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F56C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7Iq-0005Tn-6I; Wed, 14 May 2025 04:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uF7Im-0005Sd-MV
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uF7Ik-0004Tp-LS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747210637;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1IoPZUq8AKIoU8mXCBXS4i4jGAxjjlqQQupZeESyuoQ=;
 b=FlZFPS8w4HzMpHLzArOAMGBNsf+RA4Uz/q9lxIaxB0A0VQ+NlnrwmzKeCdeaYdjTQRJYIC
 Cy27uZI/vVGrvtO9VyNUUSMDsf1yu/tUnahXYQeb8N24KCaOXVxwuIjtGSXaJBLDBtieCi
 DMve837P+rTRT2Xq6SACYy7FTqS7gQw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-sn0ZpgPnOxCzVFO2U3J6pg-1; Wed,
 14 May 2025 04:17:14 -0400
X-MC-Unique: sn0ZpgPnOxCzVFO2U3J6pg-1
X-Mimecast-MFC-AGG-ID: sn0ZpgPnOxCzVFO2U3J6pg_1747210633
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005D9195DB98; Wed, 14 May 2025 08:17:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C814830001A1; Wed, 14 May 2025 08:17:10 +0000 (UTC)
Date: Wed, 14 May 2025 09:17:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Clark <michael@anarch128.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 4/4] x86-disas: add x86-mini disassembler implementation
Message-ID: <aCRROhtUyLK7axOf@redhat.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
 <20250514073927.2735727-5-michael@anarch128.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514073927.2735727-5-michael@anarch128.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 14, 2025 at 07:39:27PM +1200, Michael Clark wrote:
> the x86-mini library is a lightweight x86 encoder, decoder, and
> disassembler that uses extensions to the Intel instruction set
> metadata to encode modern VEX/EVEX instructions and legacy
> instructions with a parameterized LEX (legacy extension) format.
> 
> this patch adds the x86-tablegen.py script, the disassembler,
> a print_insn_x86 implementation plus host and target cpu stubs.
> 
> Signed-off-by: Michael Clark <michael@anarch128.org>
> ---
>  disas/disas-host.c      |    5 +
>  disas/meson.build       |   97 ++
>  disas/x86-core.c        | 2716 +++++++++++++++++++++++++++++++++++++++
>  disas/x86-disas.c       |   96 ++
>  disas/x86.h             | 1860 +++++++++++++++++++++++++++
>  include/disas/dis-asm.h |    1 +
>  target/i386/cpu.c       |    7 +
>  7 files changed, 4782 insertions(+)
>  create mode 100644 disas/x86-core.c
>  create mode 100644 disas/x86-disas.c
>  create mode 100644 disas/x86.h
> 

> diff --git a/disas/x86-core.c b/disas/x86-core.c
> new file mode 100644
> index 000000000000..c4f7034e3420
> --- /dev/null
> +++ b/disas/x86-core.c
> @@ -0,0 +1,2716 @@
> +/*
> + * Copyright (c) 2024-2025 Michael Clark
> + *
> + * SPDX-License-Identifier: MIT

Note that we expect contributions to be under GPL-2.0-or-later, unless
derived from existing code that forces use of a different license, which
needs to be explained in the commit message


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


