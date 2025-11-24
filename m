Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69186CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXIo-0000V2-Cb; Mon, 24 Nov 2025 09:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXIS-0000GS-VX
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXIQ-0006RG-I8
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763993521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A4GgUnl472N5hPYCtvSt+5Sfjp3TPucWLxcYE2aRW+Y=;
 b=BingMuIpzrF8SGuR/l7R2IPdk7EvlRwk3RAceMoR1deH6OzSL56RzX/psLYWCvPOMwq1aT
 dXWAzMmbiihdSlBdC9ksAITNluRxevPzrAmoweY6mTCKuCuMAwLAsQQ4WtZy6of7Dtrmnv
 /8gUrbatKiQn3nKdtvrGsMN/sYHj9cs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-yGGlb-QhOcuNUoichkOHcw-1; Mon, 24 Nov 2025 09:12:00 -0500
X-MC-Unique: yGGlb-QhOcuNUoichkOHcw-1
X-Mimecast-MFC-AGG-ID: yGGlb-QhOcuNUoichkOHcw_1763993520
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8805c2acd64so116640056d6.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763993519; x=1764598319; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A4GgUnl472N5hPYCtvSt+5Sfjp3TPucWLxcYE2aRW+Y=;
 b=NkFAZVrIly2UkKzrUo2oxaGMCkqz3cvhPz8YTpp1oiiFNHqsss49jjtuVcCRvqqOgC
 4R925kjWU2kzxrDubBtJaXgXlQ036mM/zxd0R22N7POdfo4Whbs2rbBdleKfLY4TN45Y
 iRep5ljRVp4Iwioowklh4MS+GD08/m42Wz16qsNex1CpLDUWp7pI3gXJ+i3TVjtFF1eP
 ZXW6a7dDV+Q2X6+Q63rS55V123Hu3Wa1vPZYYapdnGfJr9q53FQpivhnM4TEGpX8fmLF
 VwjPxvbO+LMWRfEr42QyzyhSbtwfglhtE3TPpVCto8BL/4QP5fc391D9LYKNrlTZvLM3
 w9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763993519; x=1764598319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4GgUnl472N5hPYCtvSt+5Sfjp3TPucWLxcYE2aRW+Y=;
 b=Xx/q3lIfhF3096kYvykLw4kSqke/yXvEfB2icTSrdWCWFqqizT3GaE5aZbKlIgpt8o
 cLEmXIMWnnr7sRizElaaarptLEX9XYZGjS6kLjo3TPjEfeWGyAOJ10GuJOq3qOGLCLf9
 EwIPZyzZGxKXCo5tQloUmld6ejqgO7sNhESDTUr3SIzQOZGj8993x8uJ2Frw/VCZ+YXb
 +4O9SZlBRWjGe5eTluOKoPDY4SULUr28odWVf5mJQlbxj+ANDx1lSLgR8PEsHqpnKmpU
 huO+FaavD4PExo1OoM88iF+DI/CtuayA0Jkg+hCYqOAugGCQOd4MzCMx36KjLjH73PkV
 M58Q==
X-Gm-Message-State: AOJu0YwraOfMXCvmCwsskMjb2N9HgUsK+a+sE1f6tYinjMOFkJHTaBBJ
 cduLK9W/829ZaoK7KTfCLhXzWns0z3x0JXQQo9PmHTyfIjoh3bzLMHCIOFE+vNTZo42GOmk3Rwo
 LZms2fD1xlMQD819FMP+I0caFQlbieFysm3hJRNlTSqNWejlEUJ8vJynd3hpy87E9
X-Gm-Gg: ASbGncsHxejO0wlM79NurR9QUN4RhG+bXKpNN38asFGP9VlPwIh8zpGYfRzSDv0UPQ4
 mbeiQZAKBvY5N6Zd1jwkUJ4hlGMNbcgkWWYMPBcXqIfJujlU1rtdMB7w5IdQ01KNd+/3g5qdl6U
 wmz/2yLq8nXs9/hlEcAxWWT6Po4/CfmZzYveHuBPLtHzCJr8srWfAQOXY0XVedqdpmegE1UT9Hv
 6nEsMesYVeW/BtzMoS6Ax0CzKwskSLxEQIo7veIb0r17NLOzYZJ43Nfs/MUYIC+TYDvoEKBaNPu
 BL35U4yLTnyifOcLA+OdhSIpR6c9J2yNwjrJbzEdwj3XzdQwEtHidminsCaYvzxl++IwZtLO4Hm
 CQNZ3mhUNidrmB2gY/8UrPY7v5DB2MDsUecI0dubp+iOSCIxWPTK379Jd2TYbuA==
X-Received: by 2002:a05:6214:3bc6:b0:882:4572:19b4 with SMTP id
 6a1803df08f44-8847c539e10mr163204686d6.58.1763993519656; 
 Mon, 24 Nov 2025 06:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVLQfZSE6e8gK928F9OWxsnfXK4/dtqv3rX5cvjiND+dYuSf16M2n5yR6xjOjQPHnbkrnIlA==
X-Received: by 2002:a05:6214:3bc6:b0:882:4572:19b4 with SMTP id
 6a1803df08f44-8847c539e10mr163204056d6.58.1763993519214; 
 Mon, 24 Nov 2025 06:11:59 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it.
 [87.12.139.91]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e46981asm99349276d6.13.2025.11.24.06.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:11:58 -0800 (PST)
Date: Mon, 24 Nov 2025 15:11:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/4] igvm: move igvm file processing to reset callbacks
Message-ID: <df2wgq7pciej6eflhems35w2fxkyi2chrxzrrvumimon2rtjt7@byn3kmpgekcu>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251118122133.1695767-5-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 18, 2025 at 01:21:32PM +0100, Gerd Hoffmann wrote:
>Move igvm file processing from machine init to reset callbacks.  With
>that the igvm file is properly re-loaded on reset.  Also the loading
>happens later in the init process now.  This will simplify future
>support for some IGVM parameters which depend on initialization steps
>which happen after machine init.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> backends/igvm-cfg.c |  7 +++++++
> hw/i386/pc_piix.c   | 10 ----------
> hw/i386/pc_q35.c    | 10 ----------
> 3 files changed, 7 insertions(+), 20 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index 08501a67e58e..c1b45401f429 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -15,6 +15,8 @@
> #include "system/igvm.h"
> #include "system/reset.h"
> #include "qom/object_interfaces.h"
>+#include "hw/qdev-core.h"
>+#include "hw/boards.h"
>
> #include "trace.h"
>
>@@ -44,7 +46,12 @@ static void igvm_reset_enter(Object *obj, ResetType type)
>
> static void igvm_reset_hold(Object *obj, ResetType type)
> {
>+    MachineState *ms = MACHINE(qdev_get_machine());
>+    IgvmCfg *igvm = IGVM_CFG(obj);
>+
>     trace_igvm_reset_hold(type);
>+
>+    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
> }
>
> static void igvm_reset_exit(Object *obj, ResetType type)
>diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>index 7b3611e973cd..b3b71df64bfc 100644
>--- a/hw/i386/pc_piix.c
>+++ b/hw/i386/pc_piix.c
>@@ -320,16 +320,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>                                x86_nvdimm_acpi_dsmio,
>                                x86ms->fw_cfg, OBJECT(pcms));
>     }
>-
>-#if defined(CONFIG_IGVM)
>-    /* Apply guest state from IGVM if supplied */
>-    if (x86ms->igvm) {
>-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
>-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
>-            g_assert_not_reached();
>-        }
>-    }
>-#endif
> }
>
> typedef enum PCSouthBridgeOption {
>diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>index 6015e639d7bc..f2e6ebfe294c 100644
>--- a/hw/i386/pc_q35.c
>+++ b/hw/i386/pc_q35.c
>@@ -328,16 +328,6 @@ static void pc_q35_init(MachineState *machine)
>                                x86_nvdimm_acpi_dsmio,
>                                x86ms->fw_cfg, OBJECT(pcms));
>     }
>-
>-#if defined(CONFIG_IGVM)
>-    /* Apply guest state from IGVM if supplied */
>-    if (x86ms->igvm) {
>-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
>-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
>-            g_assert_not_reached();
>-        }
>-    }
>-#endif
> }
>
> #define DEFINE_Q35_MACHINE(major, minor) \
>-- 
>2.51.1
>


