Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C5C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaG3-0007IB-5c; Tue, 30 Jun 2026 11:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1weaFy-0007G7-U1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1weaFw-0001mU-0T
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tH33U+3G5Leib7Qpgk9b9ZNV9yCgyFtZlTPt6W+tJoA=;
 b=dngdiDRucdoPL6QgkYeUTCSL7ipBY8kkTYsq/EjKmU+AFOXCpnpCKuEPJ4T8tCo/XPYnP2
 IVYb9wEIqgsS8AvvDN956ePEwmtoJKDXR4R06ZV/PiOm8+JHrkd+5TrZl+PejsBH3lbMGB
 s6AioIpV3nsL46KN+NvwaqPOJp4VVxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-cXrZE8P6NYS-BR98RydG6A-1; Tue, 30 Jun 2026 11:20:07 -0400
X-MC-Unique: cXrZE8P6NYS-BR98RydG6A-1
X-Mimecast-MFC-AGG-ID: cXrZE8P6NYS-BR98RydG6A_1782832806
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767b782so36780315e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782832806; x=1783437606; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tH33U+3G5Leib7Qpgk9b9ZNV9yCgyFtZlTPt6W+tJoA=;
 b=BoAzgzvbkKnyekkUP5OahdHz0Uw1RVK+cbWE2b2dmS1IiTXvTYtcDckL9eUOgjdSM3
 gNkQ1rIaasRVJD61AQsaw/qCpQGbAA9aYInN9j4ivdoH+CL6sNY3jtbQfBDCW3l1C3GZ
 /z/zev6pIbH8earuZlu0JpUM+WTlVmoGdjeyZBCLAskoet2qkuvbEtgVVCOUihKUi59p
 xXPL4hbmXkXMNJxE4IinVh56uhtHzjzP6gqGxaJ6NKXLN6VbCnoRkP3mPOrThEPZfAUq
 qzaR4uFaSNDjxWe3ZRsl+E4IaU7rH+2ZGVKzh1vfNLw6fqTPYg+quxatmAuVcU1YaTIN
 pZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782832806; x=1783437606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tH33U+3G5Leib7Qpgk9b9ZNV9yCgyFtZlTPt6W+tJoA=;
 b=Qn95TgQf7cq7PDKPjl48S1rc1iXzOkbEyvw13FhWaPFqvad9Pv0+t/6gKr6pSfMJng
 sSK6E4FrafeWdmriXEgiBxG6QFn9dD3AfQpHJorx8A0shIRCccH3uEbUdEis9qrl8UOx
 RPTiBRduhfelWznMPF5n3h29viXksGo8EKg0XLrprr8K6K4ETWpfgqYYoyFDpKK8N+Mk
 VKzalUdQYHesNZnwGa0r+uIg6wmc0hdb/flJ2WCWo5DjSJaB7htq+r4HcTnZ9ztpqfc5
 M4A7tG0/3j7SUWp2dWr0+SNagInLa1GH5ml7DkBEsU7QHhIppAabcUbDQS2K8v5dYZUy
 lo9A==
X-Gm-Message-State: AOJu0Yy3tySVp4GhhRe/k45lEjyT9fQ+P+U2/XvwQEba50b/FmouOfP7
 9ePcdmId2hv+bMJCZsEZCd57w5LLIqMflkIxGpYNDo5EH9eNuqghjrxG8Zvw71TjaN9XqTZz8IB
 W5JJeeGxCwdXW04ECCZXnW9/ef0GMqy08NwichZWKwvgONfSYKDjmfc6A
X-Gm-Gg: AfdE7cncIti6/FnZZkpg5aR8UACiHgto1uGKN3sk1aNZApaVVa2UuPuKirS366Nw0Kw
 pQTTKgE8OjVNIosbp8apqY/ZDlfTeckgu+0TOkxBuoGfXoNWrbeWIcXH//B+rkHfPtfJdJ34jhO
 oOl1eBnPkJkZt55oqeT5QLDn9/WbDWbGtpFKh0yHRP1zdLAQQ6UeAYSa2C1SSGTjOY5sg3OBU0O
 Guzrx8M+oZk7PxT8mzMJvAIXhfRiSTBAy1sOfPMfP9Nxa7XzyPJeL23UrjX3/PNGGv80b/IrvOo
 VvDRL/yA2VehC4oTCi6y2enoj72qFz3KkdRerRFGA0CCZL8sKiK4J5Zrp0SXHpxCHE2md/jD0kZ
 3gVNpsNeyG2cAWQjSbPABtx4w5SNwT2Ar1fAPSaIwZe33UwAFy8Vv86nSvHo8
X-Received: by 2002:a05:600c:3485:b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493b82c654emr55720585e9.37.1782832806321; 
 Tue, 30 Jun 2026 08:20:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493b82c654emr55719515e9.37.1782832805407; 
 Tue, 30 Jun 2026 08:20:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it.
 [79.34.22.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d8f5asm4144545e9.8.2026.06.30.08.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:20:04 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:20:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 3/3] igvm: add device tree parameter support
Message-ID: <akPeZ9P8IDIo8JCI@sgarzare-redhat>
References: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
 <20260626-microvm_device_tree-v6-3-9cd13cf057e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260626-microvm_device_tree-v6-3-9cd13cf057e2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 26, 2026 at 12:04:03PM +0200, Luigi Leonardi wrote:
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
> backends/igvm.c      | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> backends/meson.build |  2 +-
> 2 files changed, 55 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index a5a2a4eccc..80e87fe602 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -26,6 +26,10 @@
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>
>+#ifdef CONFIG_FDT
>+#include <libfdt.h>
>+#endif
>+
> #ifndef IGVM_VHT_OPTIONAL_BIT
> #define IGVM_VHT_OPTIONAL_BIT (1U << 31)
> #endif
>@@ -121,6 +125,10 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data,
>                                        Error **errp);
>+#ifdef CONFIG_FDT
>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                       Error **errp);
>+#endif
>
> struct QIGVMHandler {
>     IgvmVariableHeaderType type;
>@@ -151,6 +159,10 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_initialization_guest_policy },
>     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>       qigvm_directive_madt },
>+#ifdef CONFIG_FDT
>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>+      qigvm_directive_device_tree },
>+#endif
> };
>
> static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
>@@ -786,6 +798,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>     return 0;
> }
>
>+#ifdef CONFIG_FDT
>+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>+                                       Error **errp)
>+{
>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>+    g_autofree void *fdt_packed = NULL;
>+    QIgvmParameterData *param_entry;
>+    uint32_t fdt_size;
>+
>+    param_entry = qigvm_find_param_entry(ctx,
>+                                         param->parameter_area_index, errp);
>+    if (param_entry == NULL) {
>+        return -1;
>+    }
>+
>+    if (ctx->machine_state->fdt == NULL) {
>+        error_setg(errp, "IGVM: device tree not available");
>+        return -1;
>+    }
>+
>+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
>+    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
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
>+#endif
>+
> static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        const uint8_t *header_data, Error **errp)
> {
>diff --git a/backends/meson.build b/backends/meson.build
>index aabfaea5fd..8792c58c36 100644
>--- a/backends/meson.build
>+++ b/backends/meson.build
>@@ -35,7 +35,7 @@ endif
> system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
> system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
>
>-system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c')])
>+system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c'), fdt])
>
> system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
>
>
>-- 
>2.54.0
>


