Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A63CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ1rb-00021D-16; Mon, 15 Jun 2026 03:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wZ1rZ-00020v-6g
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wZ1rX-0003xI-6D
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781508960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssGAk8QyiP8/s2vzOFtNguNzxnxWjOffbAdetcGwHh8=;
 b=SXEJuIKzgYEPucjno8bL6fXG3F9TtWVvj995BOleQW2UEOxqm//+E/jCuvZek1rPpmXkJx
 A64E9HfLbzeKbCrOBSq+rEvnb1g50o5eAizFSM4vzPUz0LudNDdyEQfeIRRgvUz1gGx/lV
 bCVWqmgITDoVHXLcGEme5UTE8qHbF3k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-FzZdB5YRO8GNcll0cRTYXw-1; Mon, 15 Jun 2026 03:35:58 -0400
X-MC-Unique: FzZdB5YRO8GNcll0cRTYXw-1
X-Mimecast-MFC-AGG-ID: FzZdB5YRO8GNcll0cRTYXw_1781508957
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef0af9517so2831517f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781508957; x=1782113757; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ssGAk8QyiP8/s2vzOFtNguNzxnxWjOffbAdetcGwHh8=;
 b=eI7evswPOzJcQxUtXc38u1GJpd9c9ZcEj1RvtyXyiQNlqA6inxcUa5ZsSCSCTAu6T7
 EA5gEeoqBMTWYcE0xlFL06eDcUL7C8qicgBU4ts2qJ/SKyiWeXsL1//QoEmeuC1OOuy2
 pZtNYHi48zNEcCADwg5UbLtW5pk2Snv5z5eofRF/4iRjVHKi/A/N4yy8rgtxqHwWgVZ2
 LPFj5dPGqWTiN0o6E2tB2hu+29Q51Kmhi+PSFMzsBRjijg6Hd4gfIoGW5lrn8BNt9V4a
 hav6N/TorHDJTXh5kgOeQhHScuPw4qms9rhxGyjDiCEDbWwaMZxP90dSeiIqBtPLuwp8
 gxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781508957; x=1782113757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssGAk8QyiP8/s2vzOFtNguNzxnxWjOffbAdetcGwHh8=;
 b=LKFxcM4ls5J6Jjmy18pTBudse+A/gLpJVLhKqDYOWtcT2F5QYlly35wDNgyXen4m5P
 w+SyAD0uqTMrtS4zIOTj7ILvvHOXGXHfnhUXJEJF9cwdCUCJVsWpcD08SM3dbOop6MFF
 TW6akVEUTCCgeddmSP15qG1/kowVBlkA82ls0byRt4zTCPrNg7FnCv4cURtjUBeOyQBy
 msAt01FZTuueGL4Lzn2scbj7rh8f99QTokgvQ5UfGhEWHkA8qjgQywr1Rn4dmpu/PY8H
 yrhM+hqX8UCKG4ZsIIjVKnfZz46Z0dRMdtMoUDbxApSJLJoO3HIeSRaMVHhNIcxFUNOe
 5osA==
X-Gm-Message-State: AOJu0YzAX6pEQNMBjhWkdUbDl4MmSe7c/Tv3jLV6FNZ3Crg6VtJKdZuF
 IUaf4IRBzWtpG4AlHBvtuHBcZiOfLHcN18C6wpJPK/GTsRuwK51OLF3Muc/y9tKym2+EdJ4Wfex
 5J/2tp/wT+cGQR2fvAOgw9saifLAAS7yyFHkxnr+Krb1UScPiEVsnu3Tz
X-Gm-Gg: Acq92OGkr/pn7PVgF2ZrnsAqL/W6c2Ai6rccp0jECsXC7Prcww0AxWajkt83Ol9CO+6
 crQwhcXzSfIUq4Sn1pMOjkc/3jvUWI4omWoh2ytmMrOLK9gkZdaD1RE3gHCaNLBFK4Gvt2Vmcxd
 BtO1FzqgxqAmJW01WcfubTEI15bY9Ur+9zVDM9UzAZ84YpFnkExA0+wfVR0piVSfmhNGu1eVChi
 CxSTrtc9xri31eAJTJ5bnKhPdWXchX2CeKHdM5tUJBX5/RjOBZDtTLkZPNQPrSRDb4qSdQbMC99
 CRnzZwEZH/Akqdh0pVNO6sWzPHPZ7jYMtqPwH9UL+X6/Vh9jixr7mNrZ1reM8kgkDLAzwfN/prf
 vCB9b9tpG2v0IwVFwz/ZSZblJolg4
X-Received: by 2002:a05:600c:820c:b0:490:e104:7943 with SMTP id
 5b1f17b1804b1-490ec4e7569mr153847185e9.18.1781508957176; 
 Mon, 15 Jun 2026 00:35:57 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:e104:7943 with SMTP id
 5b1f17b1804b1-490ec4e7569mr153846985e9.18.1781508956732; 
 Mon, 15 Jun 2026 00:35:56 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm30907372f8f.14.2026.06.15.00.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:35:55 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:35:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH v3] igvm: add device tree parameter support
Message-ID: <ai-qfuS3orX3WhEh@sgarzare-redhat>
References: <20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com>
 <aiqp8zImdmHC12x3@sgarzare-redhat>
 <aiqxnkuQOMdzhxH4@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiqxnkuQOMdzhxH4@leonardi-redhat>
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

On Thu, Jun 11, 2026 at 03:36:29PM +0200, Luigi Leonardi wrote:
>On Thu, Jun 11, 2026 at 02:45:04PM +0200, Stefano Garzarella wrote:
>>On Thu, Jun 11, 2026 at 01:14:47PM +0200, Luigi Leonardi wrote:
>>>Coconut SVSM, with the upcoming device tree support [1], will use
>>>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>>>devices instead of relying on the fw_cfg interface, which is
>>>QEMU-specific.
>>>
>>>The device tree is packed before copying into the IGVM parameter area
>>>to reduce its size, since IGVM files can define tighter memory
>>>constraints for parameter areas. Packing is done in the generic IGVM
>>>backend rather than in per-architecture device tree setup code, so
>>>that each architecture does not need to handle it individually.
>>>
>>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>This device tree will be consumed by Coconut SVSM with the upcoming device
>>>tree support [1]. This will allow SVSM to run on a normal CPU
>>>(not AMD SEV-SNP) and execute all its tests using upstream QEMU.
>>>
>>>Eventually edk2 will also be able to consume DT via IGVM, but the work
>>>has not started yet.
>>>
>>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>>
>>>To: qemu-devel@nongnu.org
>>>Cc: Michael S. Tsirkin <mst@redhat.com>
>>>Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>Cc: Richard Henderson <richard.henderson@linaro.org>
>>>Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>Cc: Stefano Garzarella <sgarzare@redhat.com>
>>>Cc: Ani Sinha <anisinha@redhat.com>
>>>Cc: Zhao Liu <zhao1.liu@intel.com>
>>>Cc: Oliver Steffen <osteffen@redhat.com>
>>>---
>>>Changes in v3:
>>>- Device tree is packed in igvm core code. [Gerd]
>>>- Dropped microvm patch.
>>>- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com
>>>
>>>Changes in v2:
>>>- First patch introduced a shadowed variable, fixed.
>>>- When parameter area is not found return -1.
>>>- Moved `qigvm_directive_device_tree` to backends/igvm.c
>>>- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com
>>>---
>>>
>>>Error handling on qigvm_find_param_entry will change once [2] is
>>>merged. I am already using the new approach here.
>>>
>>>[2] https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
>>>---
>>>backends/igvm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>>1 file changed, 47 insertions(+)
>>>
>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>index c347d0c17e..452715b105 100644
>>>--- a/backends/igvm.c
>>>+++ b/backends/igvm.c
>>>@@ -25,6 +25,7 @@
>>>
>>>#include <igvm/igvm.h>
>>>#include <igvm/igvm_defs.h>
>>>+#include <libfdt.h>
>>
>>So now we depend on libfdt. Should we add this dependency to the 
>>build system? Or should we disable IGVM_VHT_DEVICE_TREE support here 
>>if libfdt is not available?
>
>Good question: IIUC, running `--disable-fdt` disables all the things
>that depend on on it, like microvm.

That was just a test; I just wanted to point out that if libfdt isn't 
there, there's a problem here.

>
>So, disabling FDT doesn't make too much sense to provide `IGVM_VHT_DEVICE_TREE `
>when fdt is disabled. WDYT?

Yes, I agree. I would avoid direct dependency, so we can enable IGVM 
even if libfdt isn't present (as was the case before this patch) and, of 
course, support the device tree only when it is present.

Thanks,
Stefano

>
>>
>>I just tried:
>>
>>$ ./configure ...  --disable-fdt --enable-igvm
>>$ make
>>[110/110] Linking target qemu-system-x86_64
>>FAILED: [code=1] qemu-system-x86_64
>>cc -m64 @qemu-system-x86_64.rsp
>>/usr/bin/ld.bfd: libsystem.a.p/backends_igvm.c.o: in function `qigvm_directive_device_tree':
>>/home/stefano/repos/qemu-review/build/../backends/igvm.c:784:(.text+0x109b): undefined reference to `fdt_pack'
>>collect2: error: ld returned 1 exit status
>>ninja: build stopped: subcommand failed.
>>
>>>
>>>
>>>/*
>>>@@ -100,6 +101,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>>static int qigvm_initialization_guest_policy(QIgvm *ctx,
>>>                                      const uint8_t *header_data,
>>>                                      Error **errp);
>>>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>+                                       Error **errp);
>>>
>>>struct QIGVMHandler {
>>>   uint32_t type;
>>>@@ -130,6 +133,8 @@ static struct QIGVMHandler handlers[] = {
>>>     qigvm_initialization_guest_policy },
>>>   { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>>>     qigvm_directive_madt },
>>>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>>>+      qigvm_directive_device_tree },
>>>};
>>>
>>>static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>>@@ -752,6 +757,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>>>   return 0;
>>>}
>>>
>>>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>+                                       Error **errp)
>>>+{
>>>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>>>+    g_autofree void *fdt_packed = NULL;
>>>+    QIgvmParameterData *param_entry;
>>>+    uint32_t fdt_size;
>>>+
>>>+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
>>>+    if (param_entry == NULL) {
>>>+        error_setg(errp, "IGVM: parameter area index %u not found",
>>>+                   param->parameter_area_index);
>>>+        return -1;
>>>+    }
>>>+
>>>+    if (ctx->machine_state->fdt == NULL) {
>>>+        error_setg(errp, "IGVM: device tree not available");
>>>+        return -1;
>>>+    }
>>>+
>>>+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
>>>+    fdt_packed = g_malloc(fdt_size);
>>>+    memcpy(fdt_packed, ctx->machine_state->fdt, fdt_size);
>>
>>What about using g_memdup2() ?
>
>Yep, good idea.
>
>Thanks,
>Luigi
>


