Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C75CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXfaM-0000tf-DQ; Thu, 11 Jun 2026 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXfaJ-0000tX-He
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXfaH-0003fM-As
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781184995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMEZsOkRdSQGRAP9AXPnGtb4y5d+9kWQYhVj4vSd6Ds=;
 b=UC0JoZoJMqUSsVCcyZSrVwWyGtNQZu5pvBg03WTl5j7F+q5bf+vQ3KqoUgnZRxainN7e25
 ywbnXVVtMDjQ7W/GPLpk9zhc3SgT2IXK+TTfFfpAok+h9gYpjbvzrbsS/0QLA1/GQq/JQK
 9d/tgEY+hg2sGYqVzPNrC2iYIX66ttM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-E0zM1NtPPbWbUS5Or8a-Qg-1; Thu, 11 Jun 2026 09:36:34 -0400
X-MC-Unique: E0zM1NtPPbWbUS5Or8a-Qg-1
X-Mimecast-MFC-AGG-ID: E0zM1NtPPbWbUS5Or8a-Qg_1781184993
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so34353655e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781184993; x=1781789793; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oMEZsOkRdSQGRAP9AXPnGtb4y5d+9kWQYhVj4vSd6Ds=;
 b=GNoCfA6isVmJdqzPLfY36YHZyVbAKMFRdDb9VciEmlTbSqFNlNEbJ7thtqlfwRbLOa
 A3E3wNYlbbM5MQ1wIDrHg9X/FaM4RScBraYy1lz1LzLAnNfBdrkwOyelpnQlXmMgnWJV
 24rRAG4Qzw8WLHMk6BLGOVai1yzODHaDY5e04XwenWpEufPGBmOCgVBbDgywsCOSzsZx
 fLsWePQXPET9JqFX529Sh6JEMOBojMje2fLyFcnZWVwS1nDOJGmu+4cGGynYQ97iPwPF
 nMCUwtSRJRvS3/INs+nM7iwfQh2SKNEvaAjaPA+QbNy1S+Whuni4ziDas6wkVnAmzDrC
 mJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781184993; x=1781789793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMEZsOkRdSQGRAP9AXPnGtb4y5d+9kWQYhVj4vSd6Ds=;
 b=fbD7qZGEJRbjaF5tXLw1auSN/yuLl9nHvmjR+ZpLHA3YmSOG78B1dqoXQ/XhPjMMqz
 SzjiFm9AuM5HNaxCHQl7z7GBW5dnI83lR/iYPC5w1JnTUi3ABgUzFCNNiRaxXnmgmKEd
 87gc8FVgg9QyBD2TCLBbzd2EGEDAPXGRM4xPWaB9sOh0ss5JPKICh5lqK0pu1WGbh4Bp
 FqF5oWYSSfFtg1peA4AR8C+PvwMZSQlLoOs+B5QnCzpYA+1/nZUlw/zZVXcs5XZd6O7c
 VLo20hFCwaO9ZOUOe2jTYnJ/rm/D9LxDEJ88IFjvbR1Gv7BouQ30wy4NduFQLar8u5Zu
 yLgQ==
X-Gm-Message-State: AOJu0Yxf++HfpsjrR4AX0u5Wr+pDJXduzTVwfZH7caU/cQAGyV4ybU7s
 smoYfaKqULwb/947zz7zAUQaWjcq4G4C/gVpuuRdxgA1d9DyidXqOzHzFj9oTFTLGW4Fv5xHszq
 hMlpdIfnju8Ptgfzgzp1vPZpl2WNKnDgp+sF+SmXevjamE06ev2KYylvq
X-Gm-Gg: Acq92OH0EAKh6kXy0S1gli1gCgx7DUjgFXrsiM1O2Mb0pdKRra9m+RGBw2xlW+DmX1z
 FFWZJuxMFPxT1hn0yAs5RabS39WRIFXalbMYQV3UqxeQqWU13ED+7yr92lB0w5lEmPFmNTxpCtr
 pYrz5YFz7qDkYHC6PpQtqDRuWazi/mgAfjdybVBCPAEAD8CpEflKfmD0m5KNg7rK98AyPma/lRi
 2HRwoDYPl9hdWAtLHba1kavwr9Q/kf+7SC8vybdfFzCbjsCpcWdMTY71qOhl+3KLDZ9tlywlPwY
 j5DZuAw6QbfiEX4mHqSg1kBwNeEAFskAkd0dbTO8zRqrAahWavZ7FLyf4mlESLGacdWLWekKDQG
 /bWaKr54n9jjpMsJs2R5clNR1rEbSSIdUI+IuvnhjL+qgWEZyRTPbbgydvkCvqsTq7sFdCA==
X-Received: by 2002:a05:600c:1f83:b0:490:be41:87c6 with SMTP id
 5b1f17b1804b1-490e55df688mr38746475e9.10.1781184992920; 
 Thu, 11 Jun 2026 06:36:32 -0700 (PDT)
X-Received: by 2002:a05:600c:1f83:b0:490:be41:87c6 with SMTP id
 5b1f17b1804b1-490e55df688mr38745685e9.10.1781184992391; 
 Thu, 11 Jun 2026 06:36:32 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5314f4dsm48987805e9.11.2026.06.11.06.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:36:31 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:36:29 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v3] igvm: add device tree parameter support
Message-ID: <aiqxnkuQOMdzhxH4@leonardi-redhat>
References: <20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com>
 <aiqp8zImdmHC12x3@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiqp8zImdmHC12x3@sgarzare-redhat>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 02:45:04PM +0200, Stefano Garzarella wrote:
>On Thu, Jun 11, 2026 at 01:14:47PM +0200, Luigi Leonardi wrote:
>>Coconut SVSM, with the upcoming device tree support [1], will use
>>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>>devices instead of relying on the fw_cfg interface, which is
>>QEMU-specific.
>>
>>The device tree is packed before copying into the IGVM parameter area
>>to reduce its size, since IGVM files can define tighter memory
>>constraints for parameter areas. Packing is done in the generic IGVM
>>backend rather than in per-architecture device tree setup code, so
>>that each architecture does not need to handle it individually.
>>
>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>This device tree will be consumed by Coconut SVSM with the upcoming device
>>tree support [1]. This will allow SVSM to run on a normal CPU
>>(not AMD SEV-SNP) and execute all its tests using upstream QEMU.
>>
>>Eventually edk2 will also be able to consume DT via IGVM, but the work
>>has not started yet.
>>
>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>
>>To: qemu-devel@nongnu.org
>>Cc: Michael S. Tsirkin <mst@redhat.com>
>>Cc: Paolo Bonzini <pbonzini@redhat.com>
>>Cc: Richard Henderson <richard.henderson@linaro.org>
>>Cc: Gerd Hoffmann <kraxel@redhat.com>
>>Cc: Stefano Garzarella <sgarzare@redhat.com>
>>Cc: Ani Sinha <anisinha@redhat.com>
>>Cc: Zhao Liu <zhao1.liu@intel.com>
>>Cc: Oliver Steffen <osteffen@redhat.com>
>>---
>>Changes in v3:
>>- Device tree is packed in igvm core code. [Gerd]
>>- Dropped microvm patch.
>>- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com
>>
>>Changes in v2:
>>- First patch introduced a shadowed variable, fixed.
>>- When parameter area is not found return -1.
>>- Moved `qigvm_directive_device_tree` to backends/igvm.c
>>- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com
>>---
>>
>>Error handling on qigvm_find_param_entry will change once [2] is
>>merged. I am already using the new approach here.
>>
>>[2] https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
>>---
>>backends/igvm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>1 file changed, 47 insertions(+)
>>
>>diff --git a/backends/igvm.c b/backends/igvm.c
>>index c347d0c17e..452715b105 100644
>>--- a/backends/igvm.c
>>+++ b/backends/igvm.c
>>@@ -25,6 +25,7 @@
>>
>>#include <igvm/igvm.h>
>>#include <igvm/igvm_defs.h>
>>+#include <libfdt.h>
>
>So now we depend on libfdt. Should we add this dependency to the build 
>system? Or should we disable IGVM_VHT_DEVICE_TREE support here if 
>libfdt is not available?

Good question: IIUC, running `--disable-fdt` disables all the things
that depend on on it, like microvm.

So, disabling FDT doesn't make too much sense to provide `IGVM_VHT_DEVICE_TREE `
when fdt is disabled. WDYT?

>
>I just tried:
>
>$ ./configure ...  --disable-fdt --enable-igvm
>$ make
>[110/110] Linking target qemu-system-x86_64
>FAILED: [code=1] qemu-system-x86_64
>cc -m64 @qemu-system-x86_64.rsp
>/usr/bin/ld.bfd: libsystem.a.p/backends_igvm.c.o: in function `qigvm_directive_device_tree':
>/home/stefano/repos/qemu-review/build/../backends/igvm.c:784:(.text+0x109b): undefined reference to `fdt_pack'
>collect2: error: ld returned 1 exit status
>ninja: build stopped: subcommand failed.
>
>>
>>
>>/*
>>@@ -100,6 +101,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>                                       const uint8_t *header_data,
>>                                       Error **errp);
>>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>+                                       Error **errp);
>>
>>struct QIGVMHandler {
>>    uint32_t type;
>>@@ -130,6 +133,8 @@ static struct QIGVMHandler handlers[] = {
>>      qigvm_initialization_guest_policy },
>>    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>>      qigvm_directive_madt },
>>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>>+      qigvm_directive_device_tree },
>>};
>>
>>static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>@@ -752,6 +757,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>    return 0;
>>}
>>
>>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>+                                       Error **errp)
>>+{
>>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>>+    g_autofree void *fdt_packed = NULL;
>>+    QIgvmParameterData *param_entry;
>>+    uint32_t fdt_size;
>>+
>>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>>+    if (param_entry == NULL) {
>>+        error_setg(errp, "IGVM: parameter area index %u not found",
>>+                   param->parameter_area_index);
>>+        return -1;
>>+    }
>>+
>>+    if (ctx->machine_state->fdt == NULL) {
>>+        error_setg(errp, "IGVM: device tree not available");
>>+        return -1;
>>+    }
>>+
>>+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
>>+    fdt_packed = g_malloc(fdt_size);
>>+    memcpy(fdt_packed, ctx->machine_state->fdt, fdt_size);
>
>What about using g_memdup2() ?

Yep, good idea.

Thanks,
Luigi


