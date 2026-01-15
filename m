Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA32D41170
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLAF-0002f0-AR; Thu, 15 Jan 2026 06:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vgLAD-0002LY-3M
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vgLAB-0001W3-1T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768475111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Svd+r6JtR49rS3ZhVIBHDUx48l4coX+GwI5DLO3FBNY=;
 b=NW8wN38V064Lm5GxbzBZ+hq1saiqhproJMxsB0HHmYifdVQAsSIsjoD2srJJupFMRJEB5y
 6N7NoyFkzCpaFG+N9HPcvxN4l+tKLw89iU+PLwXPpqSmylRw5gGW+OXnlX6g0tWV8I+pvU
 cqOOV8sqK2DVsGoNjFwlbZc4YYW2Frw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-uwlNiyACNgmWB4P_C8PSQA-1; Thu, 15 Jan 2026 06:05:10 -0500
X-MC-Unique: uwlNiyACNgmWB4P_C8PSQA-1
X-Mimecast-MFC-AGG-ID: uwlNiyACNgmWB4P_C8PSQA_1768475109
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee1fe7b24so6780405e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768475109; x=1769079909; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Svd+r6JtR49rS3ZhVIBHDUx48l4coX+GwI5DLO3FBNY=;
 b=sVJpAWpVbVmkgo91iTgjcHqBWR44k0lvZpLdsvuTEqg8ih7e5CGj+n9VDHzVAYf1cg
 AUGiX+Q0sQBiNhouH3riLIJI0MWNjhQ4rZap6HNQxKbmB4JM49p0RTJKW5rKLiarvNN0
 TycuRAPYOO/PiRYAW+4A0b49UdSi924ffgCxa2NyobdomFhUTX0KkstC0cz9GtB53EcL
 5F7zLel1vuykxpd+FH8Exu7ARcNJDzryKfVnr0pkSOcjnohVQGftsH0DsNK5/RY6ef1X
 wE1QovOR9SUUPTeHy1WhRTEh5UI5l5TyDAHbotSk9MO/88NY8tj8lIPx85ac5U721wHZ
 4eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768475109; x=1769079909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Svd+r6JtR49rS3ZhVIBHDUx48l4coX+GwI5DLO3FBNY=;
 b=BNm4jKw5AlFFmw6q7wcCqMIu3vChekMKDD8cxSiraxG8o6Jao8Om9TOOiGATkV2oos
 6dTAU+vKba3sr6FOhQc9LZcSwHhKyEGc5ubsY3oPjmPjonYdiyx4xQzKc5I4VVdggYHr
 rPVpjkc3Yw6jB7DY/7RJ+4JL1wPX497OUmdxS1ZxAy+wBkq/4YwsCa9QKOTkluMpyVdy
 WJwwP6vx0MTJJ/fO/4XOxkJpReBXRTjWzLdqaIuvpY9t8eGWLx5n6jp+FPPvc/+dfNdk
 RjKtYhKiZxrt8LBD+Ft6RaBv0rWbgKgZ3oUKx/jzsoDAwG32++TFWhF2dqXH4kkK1nQP
 9CRQ==
X-Gm-Message-State: AOJu0YxzfRHk8IVZU0sI6gIRCQH2Fs/AkN5CI4wlfqU0qXX3QtImdqFy
 +oH21CIn3dJsiFWu1HB2m1CdJP+ZgXo23vUTFBFS8mhQdEk1qQCkAlTkzFCJGY6DgaWv7vZtxeF
 wHvWPgWb9KNwD/Hn5uP5A6FcTBDAjGHB8VKgyt1Oh54E+4GyAlCWCZT4E
X-Gm-Gg: AY/fxX55QR6EHXU+tWjXLsw8dpmmHuirwbRO1P6/AAdkF61Usd1hV/kUR05kQFlmxHM
 kXzMBtK8e848uSdv6rB6y7iHB+7hl/QFB+AmRnG4SVtTDq5qtWV4x36UwTlDisSY0Izu97DIS4t
 iZ4lc9Gz+CI5r1+/XNby38uphkXpW1rjqc9v10nrz/LGs/c6pl/vvRbqPgEv0M19qtqMU54VSzz
 0gFy0rzcZGFMWFgM8ZEclLPII9FJ27pDtR4Ol9oOwh56OR2ZfqnbKr/DAcYzwF+rfM7mVC+TvQM
 Afux5D/ajXjvdwVRXs1xVggn3/rklCljnvvIkRC58kpcE1zSN3wXUrUqei+BQ1+h1OBYoksxkhA
 cOBfM1bJ8G/2u+0E=
X-Received: by 2002:a05:600c:a11:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-47ee4841128mr70773145e9.31.1768475109254; 
 Thu, 15 Jan 2026 03:05:09 -0800 (PST)
X-Received: by 2002:a05:600c:a11:b0:479:1a09:1c4a with SMTP id
 5b1f17b1804b1-47ee4841128mr70772465e9.31.1768475108810; 
 Thu, 15 Jan 2026 03:05:08 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428cebdcsm40826035e9.12.2026.01.15.03.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:05:08 -0800 (PST)
Date: Thu, 15 Jan 2026 12:05:04 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Joerg Roedel <joerg.roedel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v4 5/5] igvm: Fill MADT IGVM parameter field
Message-ID: <aWjJdGSOl0T9zEqK@leonardi-redhat>
References: <20260114175007.90845-1-osteffen@redhat.com>
 <20260114175007.90845-6-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260114175007.90845-6-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 14, 2026 at 06:50:07PM +0100, Oliver Steffen wrote:
>Use the new acpi_build_madt_standalone() function to fill the MADT
>parameter field.
>
>The IGVM parameter can be consumed by Coconut SVSM [1], instead of
>relying on the fw_cfg interface, which has caused problems before due to
>unexpected access [2,3]. Using IGVM parameters is the default way for
>Coconut SVSM across hypervisors; switching over would allow removing
>specialized code paths for QEMU in Coconut.
>
>Coconut SVSM needs to know the SMP configuration, but does not look at
>any other ACPI data, nor does it interact with the PCI bus settings.
>Since the MADT is static and not linked with other ACPI tables, it can
>be supplied stand-alone like this.
>
>Generating the MADT twice (during ACPI table building and IGVM processing)
>seems acceptable, since there is no infrastructure to obtain the MADT
>out of the ACPI table memory area.
>
>In any case OVMF, which runs after SVSM has already been initialized,
>will continue reading all ACPI tables via fw_cfg and provide fixed up
>ACPI data to the OS as before without any changes.
>
>[1] https://github.com/coconut-svsm/svsm/pull/858
>[2] https://gitlab.com/qemu-project/qemu/-/issues/2882
>[3] https://github.com/coconut-svsm/svsm/issues/646
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index cb2f997c87..980068fb58 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -18,6 +18,7 @@
> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>+#include "hw/i386/acpi-build.h"
>
> #include "trace.h"
>
>@@ -134,6 +135,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data,
>                                        Error **errp);
>+static int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data,
>+                                Error **errp);
>
> struct QIGVMHandler {
>     uint32_t type;
>@@ -162,6 +165,8 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_directive_snp_id_block },
>     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
>       qigvm_initialization_guest_policy },
>+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>+      qigvm_directive_madt },
> };
>
> static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>@@ -771,6 +776,33 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>     return 0;
> }
>
>+static int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data,
>+                                Error **errp)
>+{
>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    QIgvmParameterData *param_entry;
>+    int result = 0;
>+
>+    /* Find the parameter area that should hold the MADT data */
>+    param_entry = qigvm_find_param_entry(ctx, param);
>+    if (param_entry != NULL) {

what about an early return here? I think it would make the code much 
cleaner.

On top of that, we return 0 even if we don't find the entry, is that 
correct?

Luigi


