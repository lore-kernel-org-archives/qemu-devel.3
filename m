Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB16C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbOr-0007lY-KZ; Wed, 07 Aug 2024 03:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbbOp-0007fS-Uv; Wed, 07 Aug 2024 03:47:59 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbbOo-0002Xd-54; Wed, 07 Aug 2024 03:47:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5EE1861127;
 Wed,  7 Aug 2024 07:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BD6C32782;
 Wed,  7 Aug 2024 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723016876;
 bh=vMJRjUr+IGJwQB4Bc82HwUmW7kTM7dx26RqISOvFuQg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k9hnoPSNWVEgoVVKxSjZQBXnWpmRUrvBduGM/EgPlF2EEX3STtKbgQShMkvk2IPxh
 +gdV+81avdU0j2Aka6I2ymQ44Tsa9b5HRgU+eckgGpJf4SuZYPHZTisaZbzaaXDwD9
 fmCYme9+2g88ZebMPJ0NYdGdndmo+Q3aaaP2dxKIsiopWkmAeG4Gam5pC7NKFBa573
 mcjEZ+B+iSCV9xGalM2LDUxa0HuesYBtM5vQoDLN8P8oo8vITlMh/VlE+9hFKojREV
 H2nsuQoEK98S1/Tr1rTnIKURbjWQOG0gYLY72mMNQ7cLdsYMPtx97X3Wj6gKYhmrt2
 +/aohjP/se5xA==
Date: Wed, 7 Aug 2024 09:47:50 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807094750.6414fb2f@foz.lan>
In-Reply-To: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Tue, 6 Aug 2024 16:31:13 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> PS:
> looking at the code, ACPI_GHES_MAX_RAW_DATA_LENGTH is 1K
> and it is the total size of a error block for a error source.
> 
> However acpi_hest_ghes.rst (3) says it should be 4K,
> am I mistaken?

Maybe Jonathan knows better, but I guess the 1K was just some
arbitrary limit to prevent a too big CPER. The 4K limit described
at acpi_hest_ghes.rst could be just some limit to cope with
the current bios implementation, but I didn't check myself how
this is implemented there. 

I was unable to find any limit at the specs. Yet, if you look at:

https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

The processor Error Information Structure, starting at offset
40, can go up to 255*32, meaning an offset of 8200, which is
bigger than 4K.

Going further, processor context can have up to 65535 (spec
actually says 65536, but that sounds a typo, as the size is
stored on an uint16_t), containing multiple register values
there (the spec calls its length as "P").

So, the CPER record could, in theory, have:
	8200 + (65535 * P) + sizeof(vendor-specicific-info)

The CPER length is stored in Section Length record, which is
uint32_t.

So, I'd say that the GHES record can theoretically be a lot
bigger than 4K.	

Thanks,
Mauro

