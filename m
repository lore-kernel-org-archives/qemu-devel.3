Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B40CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsyh-0003cQ-KR; Tue, 09 Jun 2026 05:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWsyf-0003cI-S0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWsyd-0002gn-4G
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780998147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+P7sBpD7cZYwakDqljJEC9EQAaUjkbvpz2kEmCPq0Bg=;
 b=azPlWWgLpTaXDZH1kPN2qpv/wTXltoyLDx+fDTAXWQv2bKUYdrakB2ZTRPi23rIDd07Z9v
 JPWsQAqf62uwSSbMYOnKb0nNAImEA+D6uaq7IilB5AvYRqhRqOYHDxH6c8H14wYzJ+cBGC
 eCy8F2saGS9x5ugG0NvWM1x9UTTs5E4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Ga8rJi-gMAGaOnNVuyzU0g-1; Tue, 09 Jun 2026 05:42:26 -0400
X-MC-Unique: Ga8rJi-gMAGaOnNVuyzU0g-1
X-Mimecast-MFC-AGG-ID: Ga8rJi-gMAGaOnNVuyzU0g_1780998146
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so3108190f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780998145; x=1781602945; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+P7sBpD7cZYwakDqljJEC9EQAaUjkbvpz2kEmCPq0Bg=;
 b=BfQ6RUrEOcy8ThgNnFImD80lLcUXo/uW/gI9eBigYibPW3WP724TRUf0I8OHNlF4t+
 zCZS8p/5V0cQZWwj403XnOfm+TzvxfySQg85PCcLl/8ta7wGaVEhmZbQ0ChRvXgwCIxx
 UFQXQkS43i/sdE9ssxDSaxQhKAPtWjDycPBs2jLsxRi9AQkzvYRoNmuLmaZseQlCC2Lv
 GaVnFQ6238a/I/TQ7iBExO9Nbcr5fANh9CKNc26Md4IfdbjkoJPRap4ccF9b+UV9rUUo
 XhdCYVitXrPwDRzgDBYvVakBo8Haf/Xv2PVHvlfWqZmVhD4qJ9Vg/uLBbI4Ayh5Jo4Rf
 yp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998145; x=1781602945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+P7sBpD7cZYwakDqljJEC9EQAaUjkbvpz2kEmCPq0Bg=;
 b=BwcKK0lWXv+tIvoWD+vdFakEWCU8ujMobCHkGqGoxJ8gy+HOOCPFpJ1BVO1gYTdxaT
 1v9aMW938iaDIeOVoldLj94u1uO/ZRnwbrgsZz9q3msmp1mVhH+h8DpCHOnKNzYyjkAj
 Ss4oVVPmZEogvfDXbKCg3aKzQyOEWxADUWhS+S9OpsRus4tA0Kkot7IcRhDGCzEe7GPd
 fqY/aF9uJqdcONtxdeqBQuNMMizJ+T+IfVAuVFRqRNiMg7W/QcFcPihR9F2W8UkjU/jL
 eBApp3JKi4wHXANnszIYx0XJ6caoC3LAXzJkzWKx1TEWm6UiwGj5XpfHzs46lrmDguLI
 uKIA==
X-Gm-Message-State: AOJu0YzrXc3UM6THOjD3J1h+zDdy4skgCUTp/O1O6gRff8100bwZHk3i
 v9WL3iKOxI+O+JJhbWaSZzuQ3ZFgpUFpkQQWIEVr3v2FwSre33ifxX/4n/IEGHQwf50JAg5RK3y
 onNq1dGFeRvj+2CPdLpQyBdajDC1TOkuuIX1Kfh63Q+3jqsBigcmj1k9r
X-Gm-Gg: Acq92OEbphJbAm84S80iVr6gYG930BDyG9tDJoBDNgwo7K0KbsxghTAuISFK9SkzM+l
 HLv+eoWbBjNUwJMlrwvD1o2gKv1+R5QdID53CoLT1yHNTcxOxRm5H78GDVHmVUHdSEJtfFF8Kjg
 xGipic0cQhKD9ZkBNmv1WrMhVQ3689Stj8A6EAanRfv4aYUZcSYo9vZ7KEOHJwW8mXaOPEi04qq
 BjKdyK3wENLVf90cOt8glRbSOJK3LSG1HLFZLHvDW7AQ6nRUnpwhk9vdSlKUAgU7GMWpqiW6N5C
 2OK0f/VXJXMOefnVFQtYvuwFa3phXxX44OlqisYHJzrYbsSQ8l/dOF2dWMtl2/WtJ/VP2o1jYAk
 AaPq9LzxNITNNgjPtbBfTh99VNazlfyvsR58AfZEkmXqL5SWqIn6JIKpngvG5Lbz8ZiBrcQ==
X-Received: by 2002:a05:6000:601:b0:452:6aa0:1d11 with SMTP id
 ffacd0b85a97d-460566994e1mr2654662f8f.19.1780998145510; 
 Tue, 09 Jun 2026 02:42:25 -0700 (PDT)
X-Received: by 2002:a05:6000:601:b0:452:6aa0:1d11 with SMTP id
 ffacd0b85a97d-460566994e1mr2654615f8f.19.1780998145120; 
 Tue, 09 Jun 2026 02:42:25 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm60686108f8f.0.2026.06.09.02.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:42:24 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:42:22 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 2/2] igvm: Fill device tree IGVM parameter field on x86_64
Message-ID: <aifeif5ncWdpACHr@leonardi-redhat>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
 <20260608-microvm_device_tree-v1-2-730874ad0008@redhat.com>
 <aibRJYujhIGXExms@sgarzare-redhat>
 <aibfxMaqNea6Y2j0@leonardi-redhat>
 <aifWA2FRGlshTUNt@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aifWA2FRGlshTUNt@sgarzare-redhat>
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

On Tue, Jun 09, 2026 at 11:02:56AM +0200, Stefano Garzarella wrote:
>On Mon, Jun 08, 2026 at 05:40:21PM +0200, Luigi Leonardi wrote:
>>On Mon, Jun 08, 2026 at 04:50:02PM +0200, Stefano Garzarella wrote:
>>>On Mon, Jun 08, 2026 at 11:37:47AM +0200, Luigi Leonardi wrote:
>>>>Coconut SVSM, with the upcoming device tree support[1], will use
>>>>the IGVM device tree parameter to discover virtio-mmio and ISA serial
>>>>devices instead of relying on the fw_cfg interface, which is
>>>>QEMU-specific.
>>>>
>>>>The IGVM parameter handler is implemented for the i386 machine
>>>>target and stubbed for all others.
>>>>
>>>>[1] https://github.com/coconut-svsm/svsm/pull/1006
>>>>
>>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>>---
>>>>backends/igvm.c       |  2 ++
>>>>include/system/igvm.h |  2 ++
>>>>stubs/igvm.c          |  6 ++++++
>>>>target/i386/igvm.c    | 36 ++++++++++++++++++++++++++++++++++++
>>>>4 files changed, 46 insertions(+)
>>>>
>>>>diff --git a/backends/igvm.c b/backends/igvm.c
>>>>index c347d0c17e..9c6bee4add 100644
>>>>--- a/backends/igvm.c
>>>>+++ b/backends/igvm.c
>>>>@@ -130,6 +130,8 @@ static struct QIGVMHandler handlers[] = {
>>>>    qigvm_initialization_guest_policy },
>>>>  { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
>>>>    qigvm_directive_madt },
>>>>+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
>>>>+      qigvm_directive_device_tree },
>>>>};
>>>>
>>>>static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>>>>diff --git a/include/system/igvm.h b/include/system/igvm.h
>>>>index 64d3542311..d39f3d55f1 100644
>>>>--- a/include/system/igvm.h
>>>>+++ b/include/system/igvm.h
>>>>@@ -32,5 +32,7 @@ int qigvm_x86_set_vp_context(void *data, int index,
>>>>*  IGVM parameter handlers
>>>>*/
>>>>int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
>>>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>>+                                Error **errp);
>>>>
>>>>#endif
>>>>diff --git a/stubs/igvm.c b/stubs/igvm.c
>>>>index 9e9f683fc9..b4d533ad24 100644
>>>>--- a/stubs/igvm.c
>>>>+++ b/stubs/igvm.c
>>>>@@ -29,3 +29,9 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>>>{
>>>>  return -1;
>>>>}
>>>>+
>>>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>>+                                Error **errp)
>>>>+{
>>>>+    return -1;
>>>
>>>This is pre-existing in the other stubs, so maybe should be fixed 
>>>in another patch, but IMO we should set errp, like we do in other 
>>>files in stubs/ (e.g. monitor-internal.c, qmp*.c, etc.)
>>>
>>>I mean something like:
>>>
>>>  error_setg(errp, "IGVM not supported on this platform");
>>>
>>
>>Yep, I will send another patch.
>>
>>>>+}
>>>>diff --git a/target/i386/igvm.c b/target/i386/igvm.c
>>>>index f41b498b89..13db6e9be0 100644
>>>>--- a/target/i386/igvm.c
>>>>+++ b/target/i386/igvm.c
>>>>@@ -11,6 +11,8 @@
>>>>
>>>>#include "qemu/osdep.h"
>>>>
>>>>+#include <libfdt.h>
>>>>+
>>>>#include "cpu.h"
>>>>#include "hw/i386/e820_memory_layout.h"
>>>>#include "hw/i386/acpi-build.h"
>>>>@@ -210,3 +212,37 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>>>  g_array_free(madt, true);
>>>>  return result;
>>>>}
>>>>+
>>>>+/*
>>>>+ * Process device tree IGVM parameter
>>>>+ */
>>>>+int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
>>>>+                                Error **errp)
>>>>+{
>>>>+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
>>>>+    QIgvmParameterData *param_entry;
>>>>+    uint32_t fdt_size;
>>>>+
>>>>+    /* Find the parameter area that should hold the device tree data */
>>>
>>>This comment is a bit pointless; IMHO, we should explain why we 
>>>return success if we can't find the device tree area.
>>
>>Good point: in every place where we used `qigvm_find_param_entry` we
>>have this behaviour. I don't think it makes too much sense because it's
>>probably due to a malformed igvm-file. WDYT?
>
>ehm, I thought it was more about backward compatibility. For example, 
>QEMU supports the device-tree property, but the IGVM file (which is 
>probably outdated) doesn't have the entry because it's an old version, 
>so we don't return an error (though qigvm_find_param_entry() will 
>still print a warning, as it should). Or am I missing something?
>

In an "old" igvm file, where the device tree directive is not set,
`qigvm_directive_device_tree` will never run. Therefore backward
compatibility is guaranteed.

About `qigvm_find_param_entry()`, maybe Oliver can help us, as he
introduced that helper.

Luigi


