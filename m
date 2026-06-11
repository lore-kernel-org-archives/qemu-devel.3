Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E0CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeme-0004Ic-Ex; Thu, 11 Jun 2026 08:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wXemc-0004IH-86
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wXema-0000k1-3G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781181913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rMFMhdrxkxKJVE372BtoCPeA7jJff594nC4Rs5Me1PI=;
 b=QrqBPZ76OOBdmPyxrF5ry1ccW7r7lc0s+mFWryFfg0XUl4bpEfnLDqJ3wKdiRLTCxPRAiI
 6k1C71i7gJON0hx1Gi6u4SZ3linCSGb1NCIgZAFekfJBKSxoouvjmZx8A62aIN7FSHaMF8
 uF2qM+HOjfMcBh2gp8y4qf8aOw8kI8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-5pZVjiFGN52t95eI9juKGQ-1; Thu, 11 Jun 2026 08:45:12 -0400
X-MC-Unique: 5pZVjiFGN52t95eI9juKGQ-1
X-Mimecast-MFC-AGG-ID: 5pZVjiFGN52t95eI9juKGQ_1781181911
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460153ce644so5961095f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781181911; x=1781786711; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rMFMhdrxkxKJVE372BtoCPeA7jJff594nC4Rs5Me1PI=;
 b=UnNycoBWteAi8TLsUog1Q1gxjXgNwskfbAeXBXLxEgPOkzICodxRcfkDkD2Tj/6BKW
 fifey9ji6E9AeUJxaYLGClrgSd5hZ3j1gAQ/agQdxrjdbjnsN4Zho4Nnv+QSfugRD6dG
 811qTwFT3wF7Pdy3zkVJLvylyvctT2g1FRm8hAh4DNmne/RpBTQksyP+n53Yr+5biIBw
 3mpQuN5y/iM0zNbOqIKitslxvDnxMuGH70u3O8EKpfICY8/21vaCkJHmTDMaEAf3fm8c
 /O+vWC2gg/x2nifnuhQ3XDfZSIAeiqXUiUM1yhRjvy67tYCB+odDKJjSMgBqccmnuPbZ
 PJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181911; x=1781786711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMFMhdrxkxKJVE372BtoCPeA7jJff594nC4Rs5Me1PI=;
 b=CUobH5lJGoIhKyJt4xf2f7ry+m5dyyMMtzzwqRGxBGUCA/jULSWk7u1prWMXEkgGeW
 /pUX8gfW+6wSGCPgzJnDgpYN7nQ4JYY8Ewo2/gEDg1BGEU6p3apZgLbzwq2BFIFphbnI
 +4/mRYAVwbSWPDRjmUk1d4YKxiIOc1RXA/30/+03CF7ppzCztrKCAOQxx+FxNm2wM5eK
 PEWkTclhyH3QAz7g23exUjNgvmwPlqdLJK0pcu3ZhPGZnpcjoNFscbDP8jSc/e1i9mWM
 KZwXtArwPQt7wvtQ2MFGlqecEjboP91fWpbjJgJJL8RRIr6Qd9mMirMGhIWG6Vlbuc81
 nlfQ==
X-Gm-Message-State: AOJu0YyHzye2dxWepMtxPAU2ZDUTOCJgTOR39gkl3tqzmknkZ1OJ5VQr
 WIUCUK/SjW4Gje0xJugv22+zz+2mB9wEEntndz96MVQqAFTWU+Bp3p9GIH5jglhUqBdv+9XHw+u
 5OBeezJDFr9MqVjUXpK+mbtqYVoqb75FSAdPJlQUvGA5CY3+Eu8AjbxcO
X-Gm-Gg: Acq92OFL4BUWm37C75a3NW0RLD2LibF3SFIT23+J7D3T178lzrAUpl0shFIQ17+wEKO
 ePuDTZRfx7IkRdzRcxibG0xIopEZ90LL0gkHoH0LwGxdq17eC6MRnQf7K4Wj+BMzYantSUMIPTH
 HxQquW1Hy69DCOnp1Z2N+uVECblpPMNlRkgwTKMIiOcf+VAQ3ayvw7aA8Pvf2ipU9RgRWoSQXXg
 G5rz0F2tlRNfLvijGe6uNKknQ227MeUHKAHTns57FBPFvDa8k0TJZPMJPNFvsedP62KvMgnAKAi
 F4Rn0UdfhgqqqgNNQug3iUq/Wm5cBm5hoNCVGgslZaje79hC8waNZk1NdFOuuOrNnIcIduH6NBS
 AekzGUdzZ8F939efegZvGASHqpw1YcDZ2SSrdLwF3c5DKz/Gmp/SIA91aqEPHPlmlm2jN3DNvhW
 x2DTt2HQ==
X-Received: by 2002:a05:600c:348c:b0:490:601f:d776 with SMTP id
 5b1f17b1804b1-490e55a6032mr36719885e9.3.1781181910536; 
 Thu, 11 Jun 2026 05:45:10 -0700 (PDT)
X-Received: by 2002:a05:600c:348c:b0:490:601f:d776 with SMTP id
 5b1f17b1804b1-490e55a6032mr36718935e9.3.1781181909724; 
 Thu, 11 Jun 2026 05:45:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e46a75c8sm55163585e9.2.2026.06.11.05.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:45:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:45:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v3] igvm: add device tree parameter support
Message-ID: <aiqp8zImdmHC12x3@sgarzare-redhat>
References: <20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 01:14:47PM +0200, Luigi Leonardi wrote:
>Coconut SVSM, with the upcoming device tree support [1], will use
>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>devices instead of relying on the fw_cfg interface, which is
>QEMU-specific.
>
>The device tree is packed before copying into the IGVM parameter area
>to reduce its size, since IGVM files can define tighter memory
>constraints for parameter areas. Packing is done in the generic IGVM
>backend rather than in per-architecture device tree setup code, so
>that each architecture does not need to handle it individually.
>
>[1] https://github.com/coconut-svsm/svsm/pull/1006
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>This device tree will be consumed by Coconut SVSM with the upcoming device
>tree support [1]. This will allow SVSM to run on a normal CPU
>(not AMD SEV-SNP) and execute all its tests using upstream QEMU.
>
>Eventually edk2 will also be able to consume DT via IGVM, but the work
>has not started yet.
>
>[1] https://github.com/coconut-svsm/svsm/pull/1006
>
>To: qemu-devel@nongnu.org
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Richard Henderson <richard.henderson@linaro.org>
>Cc: Gerd Hoffmann <kraxel@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Ani Sinha <anisinha@redhat.com>
>Cc: Zhao Liu <zhao1.liu@intel.com>
>Cc: Oliver Steffen <osteffen@redhat.com>
>---
>Changes in v3:
>- Device tree is packed in igvm core code. [Gerd]
>- Dropped microvm patch.
>- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com
>
>Changes in v2:
>- First patch introduced a shadowed variable, fixed.
>- When parameter area is not found return -1.
>- Moved `qigvm_directive_device_tree` to backends/igvm.c
>- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com
>---
>
>Error handling on qigvm_find_param_entry will change once [2] is
>merged. I am already using the new approach here.
>
>[2] https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
>---
> backends/igvm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index c347d0c17e..452715b105 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -25,6 +25,7 @@
>
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>+#include <libfdt.h>

So now we depend on libfdt. Should we add this dependency to the build 
system? Or should we disable IGVM_VHT_DEVICE_TREE support here if libfdt 
is not available?

I just tried:

$ ./configure ...  --disable-fdt --enable-igvm
$ make
[110/110] Linking target qemu-system-x86_64
FAILED: [code=1] qemu-system-x86_64
cc -m64 @qemu-system-x86_64.rsp
/usr/bin/ld.bfd: libsystem.a.p/backends_igvm.c.o: in function `qigvm_directive_device_tree':
/home/stefano/repos/qemu-review/build/../backends/igvm.c:784:(.text+0x109b): undefined reference to `fdt_pack'
collect2: error: ld returned 1 exit status
ninja: build stopped: subcommand failed.

>
>
> /*
>@@ -100,6 +101,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data,
>                                        Error **errp);
>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                       Error **errp);
>
> struct QIGVMHandler {
>     uint32_t type;
>@@ -130,6 +133,8 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_initialization_guest_policy },
>     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>       qigvm_directive_madt },
>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>+      qigvm_directive_device_tree },
> };
>
> static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>@@ -752,6 +757,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>     return 0;
> }
>
>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                       Error **errp)
>+{
>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    g_autofree void *fdt_packed = NULL;
>+    QIgvmParameterData *param_entry;
>+    uint32_t fdt_size;
>+
>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>+    if (param_entry == NULL) {
>+        error_setg(errp, "IGVM: parameter area index %u not found",
>+                   param->parameter_area_index);
>+        return -1;
>+    }
>+
>+    if (ctx->machine_state->fdt == NULL) {
>+        error_setg(errp, "IGVM: device tree not available");
>+        return -1;
>+    }
>+
>+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
>+    fdt_packed = g_malloc(fdt_size);
>+    memcpy(fdt_packed, ctx->machine_state->fdt, fdt_size);

What about using g_memdup2() ?

Stefano

>+
>+    if (fdt_pack(fdt_packed)) {
>+        error_setg(errp, "IGVM: failed to pack device tree");
>+        return -1;
>+    }
>+
>+    fdt_size = fdt_totalsize(fdt_packed);
>+    if (fdt_size > param_entry->size) {
>+        error_setg(errp,
>+                   "IGVM: device tree size exceeds parameter area"
>+                   " defined in IGVM file");
>+        return -1;
>+    }
>+
>+    memcpy(param_entry->data, fdt_packed, fdt_size);
>+
>+    return 0;
>+}
>+
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data, Error **errp)
> {
>
>---
>base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
>change-id: 20260608-microvm_device_tree-0263c3b1be86
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


