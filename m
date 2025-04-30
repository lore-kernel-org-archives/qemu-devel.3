Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D97C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2fV-0007M2-Uo; Wed, 30 Apr 2025 04:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA2fR-0007La-BC
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA2fP-0002D6-2b
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746001181;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HuGpotkq1ZWANel1N1lEA94ZbK/L5hjrRIJDU/xQXlo=;
 b=Mxl+DAeff/VFbysDiuTm2oJGUBVXUvV4Mau+KQO2Ij4DckGzWBI1NU3MYvvswpXZJyl5a+
 r1UzPWbOpqNB3abAxIf10FbjlDDo5VKON1uGJVX5P3SLV41C+4ni2Zk94SeAxKVTs87zVa
 slUllmRA/LUDceVeamsLZDCnOPUbhx4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-eOsEGqiMMZu1Wp8JByw1fA-1; Wed,
 30 Apr 2025 04:19:38 -0400
X-MC-Unique: eOsEGqiMMZu1Wp8JByw1fA-1
X-Mimecast-MFC-AGG-ID: eOsEGqiMMZu1Wp8JByw1fA_1746001177
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51538195396B; Wed, 30 Apr 2025 08:19:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBA93195608D; Wed, 30 Apr 2025 08:19:34 +0000 (UTC)
Date: Wed, 30 Apr 2025 09:19:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 armbru@redhat.com, christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 01/20] mcd: Introduce Multi-Core Debug (MCD) API
Message-ID: <aBHdEz2x_ckyfnF_@redhat.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-2-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430052741.21145-2-mario.fleischmann@lauterbach.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 30, 2025 at 07:27:22AM +0200, Mario Fleischmann wrote:
> Formatting changes to mcd_api.h to compily with QEMU's coding style guidelines:
> 
> * limit line width to 80
> * convert Doxygen to kernel-doc comments
> * avoid architecture specific defines
> 
> The original MCD API version can be found at:
> https://repo.lauterbach.com/sprint_mcd_api_v1_0.zip

The commit message needs to call out the license choice of the
imported file.

> 
> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
> ---
>  MAINTAINERS            |    6 +
>  docs/interop/index.rst |    1 +
>  docs/interop/mcd.rst   |   44 +
>  mcd/mcd_api.h          | 3963 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 4014 insertions(+)
>  create mode 100644 docs/interop/mcd.rst
>  create mode 100644 mcd/mcd_api.h

> diff --git a/mcd/mcd_api.h b/mcd/mcd_api.h
> new file mode 100644
> index 0000000..8c89353
> --- /dev/null
> +++ b/mcd/mcd_api.h
> @@ -0,0 +1,3963 @@
> +/*
> + * Copyright (c) 2008, ARM Ltd., Infineon Technologies, NXP Semiconductors,
> + * Lauterbach, STMicroelectronics and TIMA Laboratory.
> + * All rights reserved.
> + *
> + * PREAMBLE
> + *
> + * The MCD API (Multi-Core Debug) has been designed as an interface between
> + * software development tools and simulated or real systems with multi-core
> + * SoCs. The target is to allow consistent software tooling throughout the
> + * whole SoC development flow.
> + * The MCD API (the "SOFTWARE") has been developed jointly by ARM Ltd.,
> + * Infineon Technologies, NXP Semiconductors, Lauterbach,
> + * STMicroelectronics and TIMA Laboratory as part of the SPRINT project
> + * (www.sprint-project.net).
> + * The SPRINT project has been funded by the European Commission.
> + *
> + * LICENSE
> + *
> + *  Any redistribution and use of the SOFTWARE in source and binary forms,
> + *  with or without modification constitutes the full acceptance of the
> + *  following disclaimer as well as of the license herein and is permitted
> + *  provided that the following conditions are met:
> + *  - Redistributions of source code must retain the above copyright notice,
> + *    this list of conditions and the disclaimer detailed below.
> + *  - Redistributions in binary form must reproduce the above copyright notice,
> + *    this list of conditions and the disclaimer detailed below in the
> + *    documentation and/or other materials provided with the distribution.
> + *  - Neither the name of its copyright holders nor the names of its
> + *    contributors may be used to endorse or promote products derived from the
> + *    Software without specific prior written permission.
> + *  - Modification of any or all of the source code, documentation and other
> + *    materials provided under this license are subject to acknowledgement of
> + *    the modification(s) by including a prominent notice on the modification(s)
> + *    stating the change(s) to the file(s), identifying the date of such change
> + *    and stating the name of the publisher of any such modification(s).

This 4th clause is rather obnoxious and....

> + * VERSION HISTORY
> + *
> + *  1.0 "SPRINT Release"     : SPRINT reference version
> + *
> + *  1.1 "Lauterbach Release" :
> + *  - forces all boolean types to 8-bit on Linux and Mac-OS-X,
> + *    but 32-bit on all other OS forces 32-bit enumeration types
> + *  - additional memory spaces MCD_MEM_SPACE_IS_PHYSICAL,
> + *    MCD_MEM_SPACE_IS_LOGICAL, MCD_MEM_SPACE_IS_AUX
> + *  - changed type of 2nd argument of mcd_qry_input_handle_f from "int" to
> + *    "uint32_t"
> + *  - changed type of element "data" of of mcd_tx_st from "unsigned char" to
> + *     "uint8_t"
> + *  - specifying the calling convention for MS Windows (x86) to __cdecl
> + *
> + *  1.2 "QEMU Release"       :
> + *  - changes formatting to accommodate QEMU's coding style guidelines
> + *  - includes qemu/osdep.h instead of mcd_types.h

....this appears to not be compliant with the license since it fails
to include the dates

AFAICT this license is derived from a classic BSD 3 clause, with the
extra 4th clause added.

I don't see any SPDX license matching this, which is painful as it
means it is going to need license approval before it can be included
by distributions downstream.

Does this really have to be under a custom license instead of a
well known standard license ? There's really no good reason for
inventing new open source licenses.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


