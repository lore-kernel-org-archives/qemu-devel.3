Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D942ECD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsMb-0003Uf-CD; Tue, 09 Jun 2026 05:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wWsMZ-0003UX-DJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wWsMX-0007RV-Ej
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00WyurpOx9mbWmcXTMFVM1dT9zU38kZhkO4Uaas+THI=;
 b=I6qAQpumcvmqwT3YOGRLOdVKkHDsWeDLi2GlWv8Z3AzrciUI7cX/Rh5PRsCDAW6dbQduxm
 NbPYUlJFY26gJJJKtkjHG3Y020jPLbNgKR8M3Ovb9xIjhECCiKsEy/ES0T8VdPC9FIg3Jt
 SxsARa84AVOxzjKXJ0xwKrUv5E9OeS8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-fojQsVqqPtO1DyLhCnHP_w-1; Tue, 09 Jun 2026 05:03:06 -0400
X-MC-Unique: fojQsVqqPtO1DyLhCnHP_w-1
X-Mimecast-MFC-AGG-ID: fojQsVqqPtO1DyLhCnHP_w_1780995785
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460129ef947so3079626f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780995785; x=1781600585; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=00WyurpOx9mbWmcXTMFVM1dT9zU38kZhkO4Uaas+THI=;
 b=AIdAAu9zD6QW+9oO2jX6Xj03fVxIrJ89SF2B/pSRLMdFLYE85y70rZH2WKubL/sTG+
 39G67ZsHUiP9jQpE6Ahu0yhwZ6ZncmN2OX0+tSK1+7HP26tfAUp8RsLmZsb0EIvwZjud
 cpUwyKlIfmKV6cIXGT1D+umrfk/y+YoweEz7sCzjcMWnhExqWmCSWGroGT6GdBacDsZ9
 41JUcET4h72s2d4ItN11EKF35fKjH5v6LVnAXLckLej5QFhMsAHUu96skie9cGkzsBIF
 qXwJuXdztiJW0t6pG853wQyBmgRDtzev+Up+mbY4pJVG/hLEb/cyCsU89S9ExR5Vzj2N
 ur8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995785; x=1781600585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00WyurpOx9mbWmcXTMFVM1dT9zU38kZhkO4Uaas+THI=;
 b=Q0CpIXVKlN23nETa827myV+aJpzC4XclPb4T1YOjqBdreA1MzEgD2vN/xlYcD6rqVA
 F7fCwHfl5B8pZQiZgsNB703hJBjWUsjBg0dhvr6i718UnzJ7p9KhU+JszI1BrzdrXSIs
 XVN9U6IZwVb+daYoWHpMROj7za2LLoMD5y+YCK7NCcdTjoqFpVNDlspYqo3CrbiESSTg
 RKdislemJCFxv7i7rbfCjsO40X/uo+SpYqvhH3DaDFBSoSEaiYrB2SoZqGoPn5Q5CJ9X
 jodC3zyrxl7R1Z+QZKJ3KY/VgJBerVbUFg92gWvb0iuRNpg+IyB29vECmmgAE4l+fQlg
 Ku+A==
X-Gm-Message-State: AOJu0Yy1n/K+bVEezxsCPMSuDdiSN5zU0rzJy8vKDjqcmW2no0Elq5/y
 H6eI44Xu8UhQXfIo00A4xzT2i38rToHSEfqvqnn4Mx00TSgP4Jw5VtquZSjnPG4djQbT9QEdvSC
 tJSEoufTpNYPg+f9O6EGmuQvPazbu5oplsBfx8ddM+5uUBgc9lk0qGJj7
X-Gm-Gg: Acq92OGIm3n6QwyBN4Wb/9EEKmLWVkiMIs9fM9R1OK7uYn36+36LR0b6/0lp3AqDmYi
 AFX8B5lpMPr8/sIGyWfNYQF0dT9j/8ULIGlrtrTA+ch6mEWABxw6bA6qG1ilVA8qfkW6/PAfJ5n
 kYnRTjB4Nz7rB/p26tMspt1X+m8JKGZn1epHSzb3EDyuRDS1i9RGs+9aO8UH8xvYo76R3oLch6/
 f1z6BZCLjliHY1JsvFGicjjC00U4DcPMy1+66cPu9ZBD+1EGA9QzNiMYDoPGVw7DQfoNanWx/iV
 6cmxzhlbOEOAC1vfrksHuF0KtArWbwprPRBc+MIr6Kjumm0Pfx2XG6Ap/BeL8BLddPZtfFtQGrE
 e5SL0BTro1JDQjSb12tUnCxc+ASwiJAJwxwxUc0BbJ7WGFlhU0WVrFdTKDufxmx5oKMYw+UyWIa
 Ii9b03kg==
X-Received: by 2002:a05:600c:c0d3:b0:490:53b0:9e53 with SMTP id
 5b1f17b1804b1-490c265c107mr260837965e9.1.1780995785159; 
 Tue, 09 Jun 2026 02:03:05 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d3:b0:490:53b0:9e53 with SMTP id
 5b1f17b1804b1-490c265c107mr260837295e9.1.1780995784503; 
 Tue, 09 Jun 2026 02:03:04 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c183asm468080025e9.6.2026.06.09.02.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:03:03 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:02:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 2/2] igvm: Fill device tree IGVM parameter field on x86_64
Message-ID: <aifWA2FRGlshTUNt@sgarzare-redhat>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
 <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
 <aibRJYujhIGXExms@sgarzare-redhat>
 <aibfxMaqNea6Y2j0@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aibfxMaqNea6Y2j0@leonardi-redhat>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Mon, Jun 08, 2026 at 05:40:21PM +0200, Luigi Leonardi wrote:
>On Mon, Jun 08, 2026 at 04:50:02PM +0200, Stefano Garzarella wrote:
>>On Mon, Jun 08, 2026 at 11:37:47AM +0200, Luigi Leonardi wrote:
>>>Coconut SVSM, with the upcoming device tree support[1], will use
>>>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>>>devices instead of relying on the fw_cfg interface, which is
>>>QEMU-specific.
>>>
>>>The IGVM parameter handler is implemented for the i386 machine
>>>target and stubbed for all others.
>>>
>>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>backends/igvm.c       |  2 ++
>>>include/system/igvm.h |  2 ++
>>>stubs/igvm.c          |  6 ++++++
>>>target/i386/igvm.c    | 36 ++++++++++++++++++++++++++++++++++++
>>>4 files changed, 46 insertions(+)
>>>
>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>index c347d0c17e..9c6bee4add 100644
>>>--- a/backends/igvm.c
>>>+++ b/backends/igvm.c
>>>@@ -130,6 +130,8 @@ static struct QIGVMHandler handlers[] = {
>>>     qigvm_initialization_guest_policy },
>>>   { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>>>     qigvm_directive_madt },
>>>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>>>+      qigvm_directive_device_tree },
>>>};
>>>
>>>static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>>diff --git a/include/system/igvm.h b/include/system/igvm.h
>>>index 64d3542311..d39f3d55f1 100644
>>>--- a/include/system/igvm.h
>>>+++ b/include/system/igvm.h
>>>@@ -32,5 +32,7 @@ int qigvm_x86_set_vp_context(void *data, int index,
>>>*  IGVM parameter handlers
>>>*/
>>>int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
>>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>+                                Error **errp);
>>>
>>>#endif
>>>diff --git a/stubs/igvm.c b/stubs/igvm.c
>>>index 9e9f683fc9..b4d533ad24 100644
>>>--- a/stubs/igvm.c
>>>+++ b/stubs/igvm.c
>>>@@ -29,3 +29,9 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>>{
>>>   return -1;
>>>}
>>>+
>>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>+                                Error **errp)
>>>+{
>>>+    return -1;
>>
>>This is pre-existing in the other stubs, so maybe should be fixed in 
>>another patch, but IMO we should set errp, like we do in other files 
>>in stubs/ (e.g. monitor-internal.c, qmp*.c, etc.)
>>
>>I mean something like:
>>
>>   error_setg(errp, "IGVM not supported on this platform");
>>
>
>Yep, I will send another patch.
>
>>>+}
>>>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>>>index f41b498b89..13db6e9be0 100644
>>>--- a/target/i386/igvm.c
>>>+++ b/target/i386/igvm.c
>>>@@ -11,6 +11,8 @@
>>>
>>>#include "qemu/osdep.h"
>>>
>>>+#include <libfdt.h>
>>>+
>>>#include "cpu.h"
>>>#include "hw/i386/e820_memory_layout.h"
>>>#include "hw/i386/acpi-build.h"
>>>@@ -210,3 +212,37 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>>   g_array_free(madt, true);
>>>   return result;
>>>}
>>>+
>>>+/*
>>>+ * Process device tree IGVM parameter
>>>+ */
>>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>+                                Error **errp)
>>>+{
>>>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>>>+    QIgvmParameterData *param_entry;
>>>+    uint32_t fdt_size;
>>>+
>>>+    /* Find the parameter area that should hold the device tree data */
>>
>>This comment is a bit pointless; IMHO, we should explain why we 
>>return success if we can't find the device tree area.
>
>Good point: in every place where we used `qigvm_find_param_entry` we
>have this behaviour. I don't think it makes too much sense because it's
>probably due to a malformed igvm-file. WDYT?

ehm, I thought it was more about backward compatibility. For example, 
QEMU supports the device-tree property, but the IGVM file (which is 
probably outdated) doesn't have the entry because it's an old version, 
so we don't return an error (though qigvm_find_param_entry() will still 
print a warning, as it should). Or am I missing something?

Thanks,
Stefano


