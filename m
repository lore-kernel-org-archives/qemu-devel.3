Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D0D26D9B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEfr-0000VT-PD; Mon, 12 Jan 2026 04:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vfEfo-0000Ia-12
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:57:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vfEfm-0004mh-4g
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768211836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IITw8Q3hu7/PKYDKqSgzmT4XoNE9pbceR1oZUqzeVRs=;
 b=JoPxsdhhbGXFyo2P/nTPzzMsX1I4vSiIpJiCvDA3Klq1iQSprtEPhOtTjsyPfXe23pFIV1
 kWXn86gMeg4KsS0Xu9Dw1uZeQQrTL9+BIwOQGvinVwLTNbjbGv5bK5gpkivg4rBqCSzCBn
 Hmof38+VYIaE5Cpp2f0e1/MZ38PS/zI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ZXlsdFrlPky_Ch0cGmaWVQ-1; Mon, 12 Jan 2026 04:57:13 -0500
X-MC-Unique: ZXlsdFrlPky_Ch0cGmaWVQ-1
X-Mimecast-MFC-AGG-ID: ZXlsdFrlPky_Ch0cGmaWVQ_1768211832
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so4577985f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768211832; x=1768816632; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IITw8Q3hu7/PKYDKqSgzmT4XoNE9pbceR1oZUqzeVRs=;
 b=nL+zbmewA4ScSa83gUD99trAIr2qZdOFt4VHU6cGevOF2wPNJLpb7Fiyx2Ahvkhgpd
 PCtYR7qodtmazf7FsqWP0D7Z3GsvXRB41T+1nDkLHQOTEOA8U7TpvJI/uhz3oMAUM+hV
 3Rmto/3I/V1Aq1oKCxW010UUjZPR/+BtobFO1CWaKflCcnJkvJLDzaYKwzZ5btJA593F
 oytB7bnASinVSSaUUURmI4tlcqHe4VRA6fIqGYWJJpkJTIecCMRIQ3d78wacJrzvOISU
 w8y3kcPMsHTV3JIy7fB7B6bcre9AROKrMWu2Mj9F1voOY2FtqCMCuJJoninuhZ8ahNid
 GuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768211832; x=1768816632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IITw8Q3hu7/PKYDKqSgzmT4XoNE9pbceR1oZUqzeVRs=;
 b=u3nTe3MqpWB3Hq5EnkVL/8lF9yfzosYE5D8gSNXyko43BayORzVsgegLXOaIdgOyfj
 +L4RrEoSu7igza/0+crc1c+IXh//uHbs0FQaHuw2YX02JxUYK2ogOrk87RRY24SEyj/x
 aomK/FvQEOmRmJkujusHE7Cn1+X8ROnzNVO98sYFszblDitVPdtudMMZI1oqnsM8Nl4y
 7ztOEUf7rNYWmbnyYRsaQwvqhjvRoHOPjyCcqtNEuvq9McXZkc+L+jL0owe24sq6vtS3
 Wvp0pLa5kUxKRIw9GEKxqITBdZnLguUyCBWQkT83sgk40RxFkWri9J3287TFVb/t2uzx
 ND2g==
X-Gm-Message-State: AOJu0Yz/sw+HPtw0nnrg6eEzZmGGObU5Q+XQ72JjiscW+tmTIGGiSJ6T
 IIvuYMcpRO8G434v1O8jG4FKV3+hWpVzID28d2JwSh1qduVw9xVLF5+HQS5HgiCc+JnKyBYOc9i
 zQdOe6xaIJCR4sZQ8nKlb6C27eUE83NBmhkKM/y5dbEAA2XCfQlmMmfrh
X-Gm-Gg: AY/fxX69x2yXA7kviezHTZr1fR//dNqnvvWJCEjregSpXmuJa/h0gd8yKW9S/2m4DAC
 tTbcyVg36mNb0Ah1xotQ88jnztfvdGfKeFlejPntXXU0RbvMds6UART2l/rNw5n6to+6KDz74j+
 jBTCGyxDriETxZLkhF6JabGZ4mFjiYd3VJv8vb2bAfb2GQ6mzS7Vs48ZQsyTdCjTD5nH12JCuwA
 oQpGT9sV+EDLrlTiVexaY7tkhPMTuWB/guayBh2M3m9By+oh8AW7cZmxncW9Y0vMbFp8ugOxssE
 UPAH4dlZy4cDiC6CH53lwYPUYQ93mGFchZFrUn3dyGsLpy7rVP01rQexYAGjGkbNabzej9cfGRm
 ocR3MyrTY9eRXeHA=
X-Received: by 2002:a05:6000:3112:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-432c38d0f5amr21762929f8f.58.1768211832056; 
 Mon, 12 Jan 2026 01:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8nUpJjlfbThAz7uz78Ez10rox1svb/5PwHDzxi0eoRWJuwrkJOhDHai5qPKd7LGfg5rt0tg==
X-Received: by 2002:a05:6000:3112:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-432c38d0f5amr21762900f8f.58.1768211831597; 
 Mon, 12 Jan 2026 01:57:11 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacd1sm37154626f8f.4.2026.01.12.01.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:57:11 -0800 (PST)
Date: Mon, 12 Jan 2026 10:57:08 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 6/6] igvm: Fill MADT IGVM parameter field
Message-ID: <aWTFR-sYjRIdDbId@leonardi-redhat>
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-7-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260109143413.293593-7-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, Jan 09, 2026 at 03:34:13PM +0100, Oliver Steffen wrote:
>Use the new acpi_build_madt_standalone() function to fill the MADT
>parameter field.
>
>The IGVM parameter can be consumed by Coconut SVSM [1], instead of
>relying on the fw_cfg interface, which has caused problems before due to
>unexpected access [2,3]. Using IGVM parameters is the default way for
>Coconut SVSM; switching over would allow removing specialized code paths
>for QEMU in Coconut.
>
>In any case OVMF, which runs after SVSM has already been initialized,
>will continue reading all ACPI tables via fw_cfg and provide fixed up
>ACPI data to the OS as before.
>
>Generating the MADT twice (during ACPI table building and IGVM processing)
>seems acceptable, since there is no infrastructure to obtain the MADT
>out of the ACPI table memory area.
>
>[1] https://github.com/coconut-svsm/svsm/pull/858
>[2] https://gitlab.com/qemu-project/qemu/-/issues/2882
>[3] https://github.com/coconut-svsm/svsm/issues/646
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>
>SQUASH: Rename madt parameter handler

Development leftover?

>---
> backends/igvm.c | 35 +++++++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7390dee734..90ea2c22fd 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -15,9 +15,11 @@
> #include "qapi/error.h"
> #include "qemu/target-info-qapi.h"
> #include "system/igvm.h"
>+#include "glib.h"

is this needed?

> #include "system/memory.h"
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>+#include "hw/i386/acpi-build.h"
>
> #include "trace.h"
>
>@@ -134,6 +136,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data,
>                                        Error **errp);
>+static int qigvm_directive_madt(QIgvm *ctx,
>+                                     const uint8_t *header_data, Error **errp);
>
> struct QIGVMHandler {
>     uint32_t type;
>@@ -162,6 +166,8 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_directive_snp_id_block },
>     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
>       qigvm_initialization_guest_policy },
>+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>+      qigvm_directive_madt },
> };
>
> static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>@@ -780,6 +786,35 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>     return 0;
> }
>
>+static int qigvm_directive_madt(QIgvm *ctx,
>+                                     const uint8_t *header_data, Error **errp)
>+{
>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    QIgvmParameterData *param_entry;
>+
>+    if (ctx->machine_state == NULL) {
>+        return 0;
>+    }
>+
>+    /* Find the parameter area that should hold the MADT data */
>+    param_entry = qigvm_find_param_entry(ctx, param);
>+    if (param_entry != NULL) {
>+
>+        GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
>+
>+        if (madt->len > param_entry->size) {
>+            error_setg(
>+                errp,
>+                "IGVM: MADT size exceeds parameter area defined in IGVM file");
>+            return -1;
>+        }
>+        memcpy(param_entry->data, madt->data, madt->len);
>+
>+        g_array_free(madt, true);
>+    }
>+    return 0;
>+}
>+
> static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
> {
>     int32_t header_count;
>--
>2.52.0
>

Rest LGTM!

Luigi


