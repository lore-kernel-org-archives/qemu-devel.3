Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF2EDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9c-0007mR-6M; Thu, 12 Feb 2026 01:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9X-0007jQ-RO
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9W-0005FM-7s
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlhPepsbkrDPw6Fl6PcI0YXFm5apjWAR4raOyitrg44=;
 b=YkfD17Y3KIkYIXaaWN33ogG/aP6OgzNirjihwTh7JW0937aeRlAvjeVqgz7/PfO+EaU7c5
 lqhTW9JTiVLsxc/+DoDbkSR9711SxILJhJV7nMBRU0KEiTRdKnKJ1cVqLfFe4Wqnq184Ak
 gZzq8XIIUaoThQnRiZ2/IJewnDKXo/Y=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-6z6_XUTvOOKexsM1x7TXOg-1; Thu, 12 Feb 2026 01:26:11 -0500
X-MC-Unique: 6z6_XUTvOOKexsM1x7TXOg-1
X-Mimecast-MFC-AGG-ID: 6z6_XUTvOOKexsM1x7TXOg_1770877571
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c6e24ee93a6so607045a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877571; x=1771482371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlhPepsbkrDPw6Fl6PcI0YXFm5apjWAR4raOyitrg44=;
 b=n6ReXjyt4MGCcVFCB6wq54ytWLIu8QOT8C4DFQdNfEqit4UDBobKeY14gH8piNZsXd
 j00Q3kqlwSEHMRTtZOM15vi4XKLzs3yV6K5Q61GwD3eV1W9nv4s9xLv9zxLO3LNE6vsH
 ZLiP/SYLbcO+ZmFin1H3jV1u9IbGd3akG+Cwh77JZ8q8Dzufzc/62PRSRCPjHdCdok/h
 r+jVfPOz6Ode2L+lvM7W0S9igBHWVr01ycdW1I/0n43FXXGFR3lqvnvxqIKo1X/NByEM
 rVdsPe8CVQtRPyh3ifkSlF7FARYUt892ya+sosYwv2YJArx16+79GSd3iO5xoM687TMN
 Rrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877571; x=1771482371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlhPepsbkrDPw6Fl6PcI0YXFm5apjWAR4raOyitrg44=;
 b=ZfWFvQnkBCzU4Q+Pe1kCZ691boQCYY/WxS8Med/zcD6pf09NcMNgTRMEpRcxKL9ZZL
 3pKwODyFOFDJ0k/jtYF5XJfIpN3oQQWA4LtgWVsVoP5JhInU7kXwqFFCwZnZ6PfNXZvj
 /6IRj2Oku3G40wfmCl0oHIwoi19vY+dI38BfUI9Wr4co4zPqpc/gIJg3QYup1hZqBz8l
 7S4xZ340eVWBhxOCQrUU3adqNHk4wOY5gvMEngeBQHU6QDPI7oXr4qUeDeJEF9a3v+vt
 rqu2r4vlI074RdJu2g9S7xAbUWbEIp6+7pN1X2ry3BD/zAVFmIz5AKiD8JKw8n8F0gWl
 ow5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYBjr/ZoTMvqzNHLE33PtD64gEndJqCnCZQKda0cXc3NyX6P0fm7h++HTA4MnVSiqowoGsydF+svii@nongnu.org
X-Gm-Message-State: AOJu0YytjzFvaWQjv/3gbb4AYZqfaBJledcaAKAWSRYQdg3/uveIEveQ
 rhaQQa23l+t4Pchq+iuCga7fgFonXnuxh4sNSV4hK966sIR22RI7Os8xKyfci47Qa6QcQ3Fxhal
 Kpj9cDGGAkKPYUove5Y7Nr+zjPNqnQvXFrdlowwOucwHPO/2WWdLpo/yF
X-Gm-Gg: AZuq6aLy+siY0pLix756uJnBq++MSVBprB6XcHXuizB4mfxUo/HVi6tpQidCoHejIbu
 BRu157RzzG0pjqBynTpRMZPT4WzNHkZwKm0/JhcM0Far3IPP3FB8JIxkwq4bFGB6Zs8gfibP5cL
 QXIDjRL7E9wo/En+WQZQlExmPshnKiP72CLi0ZhGRn9akru+iKQEfocBcU0BE10xI0OyNKh6cLg
 jJvj8JSqmj3pFfsZqCiiElOVrQIfdgCZLl8YDqvVmLa4xRhz75fFxr7i0u1u0Gllkq07WkshhA4
 oueE2eTo2h801GGdMQuVMfppWgXbvVQgoSzlMfJ4dML7HEKNecQaXbVGtdB0SYR14dwfJYkNHk5
 gQs2lkiUqVNVAzoqdt48J2lPQpCJnC/KT8gB+X7TqD1swLq8i7wU3ook=
X-Received: by 2002:a17:90b:4a8d:b0:353:2972:74a4 with SMTP id
 98e67ed59e1d1-35692d84ac5mr1321827a91.13.1770877570779; 
 Wed, 11 Feb 2026 22:26:10 -0800 (PST)
X-Received: by 2002:a17:90b:4a8d:b0:353:2972:74a4 with SMTP id
 98e67ed59e1d1-35692d84ac5mr1321815a91.13.1770877570366; 
 Wed, 11 Feb 2026 22:26:10 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:10 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 11/31] hw/i386: export a new function x86_bios_rom_reload
Date: Thu, 12 Feb 2026 11:54:55 +0530
Message-ID: <20260212062522.99565-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Confidential guest smust reload their bios rom upon reset. This is because
bios memory is encrypted and upon reset, the contents of the old bios memory
is lost and cannot be re-used. To this end, export a new x86 function
x86_bios_rom_reload() to reload the bios again. This function will be used in
the subsequent patches.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c  | 21 +++++++++++++++++++++
 include/hw/i386/x86.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 18f2e2cfb9..b5759f6993 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1089,6 +1089,27 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
     exit(1);
 }
 
+void x86_bios_rom_reload(X86MachineState *x86ms)
+{
+    int bios_size;
+    const char *bios_name;
+    char *filename;
+
+    if (memory_region_size(&x86ms->bios) == 0) {
+        /* if -bios is not used */
+        return;
+    }
+
+    bios_name = MACHINE(x86ms)->firmware ?: "bios.bin";
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+
+    void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
+    load_image_size(filename, ptr, bios_size);
+    x86_firmware_configure(0x100000000ULL - bios_size, ptr, bios_size);
+}
+
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 0dffba95f9..66080da54a 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -127,6 +127,7 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
+void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-- 
2.42.0


