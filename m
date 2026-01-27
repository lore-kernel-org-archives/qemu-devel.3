Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7F7D25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbS4-0006xg-JA; Tue, 27 Jan 2026 00:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbS2-0006w7-5E
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbS0-0008Nt-PH
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRVBCkNbidTWYvuOZxhT+yCMsNW1MOiuVCAJ1n0MWJQ=;
 b=ZpGhq4/mXZqjwELPHaXriSf/gacI4mvabO5mRPHnP9YVne6v+lcZH0uGPtyw+/HYIhwpzq
 3VeqoxHEtnHJauL9n6CTHb9uAnQT0ceEmToQtl7VMwgGIY81BpWi5tcAZ5MkT22Cyymnyt
 m8rq2kjh8wLqft3NQNyO9sqHFIaIQg0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-r7Z7XJZ3NCSZ1jDgeJmUew-1; Tue, 27 Jan 2026 00:17:14 -0500
X-MC-Unique: r7Z7XJZ3NCSZ1jDgeJmUew-1
X-Mimecast-MFC-AGG-ID: r7Z7XJZ3NCSZ1jDgeJmUew_1769491033
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a755a780caso38505125ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491033; x=1770095833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRVBCkNbidTWYvuOZxhT+yCMsNW1MOiuVCAJ1n0MWJQ=;
 b=g7TGZynkV6H96WyZMODJndbAvAQAh98PhKEnz8qLEdcyNbSMyp4xGjQ3WY96nva4xs
 do4Vv7jYdQ5hj/LPqKYLEbTnGjYncUoU+DTX/BOGItE3/9nAfZMV18LlqmZhG32lQQ2z
 1Csvpho3majs8IzSMHUwzEsl7hENwMo0E+VNUrdGBy03YLmbCCDCL2z4d4m55MSxNYAZ
 ghF2hk9xmCoz5LXXTwz9VX8ONZ3Y1ji71EkgcsGH7NGCoRtMwGso6ugYaj1t/1io0T/x
 oUqj5E6+KmqYVMQy5nfZ4vS4KC7BwC2KUdbypisHTwWOSVBihBpnUnAum58R50XccMeP
 7GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491033; x=1770095833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kRVBCkNbidTWYvuOZxhT+yCMsNW1MOiuVCAJ1n0MWJQ=;
 b=W6ijCbupnyUeBhQ+ovuWBxjVVbyAIReON7P6zj3pcCNvQefBv1lzpk524KVkGk4Lc4
 xLyAgSRFLJKaz8TXsctQ5q8u7GF+z5fJHFhDVnl4S9+qzYVuroYoyrIBFEMXwrAzfik3
 zfrCZGvBGOgTiGb0Zz+CT6MQ0/1GxeKNc14H2jAUGKdKi9F8dOtwa9oGLBpQAqoVM75l
 rJS9zGabgNAHdm8+egn7CRTfPwDukefO6GM1BBTnWXazyw1yNf7jr61wSnD9pBnZgu0E
 z2OT3F3kYVYz/LDHpMiR3N4pRo+fHAubuGPWeGe9G6EPSZL8g5If+ykfqKau8lalzQyV
 pdmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBTmqc4av8PnJwvrWFfuXLkMbxfCy71XoNjchUT1KWRjc8g8s/+tcgfmhRnNS5c+kgDAWmkwMCmHKq@nongnu.org
X-Gm-Message-State: AOJu0YzJMwMCE23gVWW7efXyTwmX5J1PZt1kU9cTD4PuksRHGrM+9qSE
 E135qYlNCi974M+tIKvLhB3QMksSel/GDWiFMAuA4PdVBWh9GqdOTBaHroWF2/3Qpk62xkiytKl
 0/RPH6EX0D6HaOnUnFqTCVDcM2LvDA9qFxQ4NHERX5Opvr4XvNVX4C5rZ
X-Gm-Gg: AZuq6aJtUbmJxwP/O/qGtjRd7RABteQGnJwmOxbgFLEFCsqgNNvTwoDIMrsfWwF4TtR
 cfpOYpxQ5IKvhJEQOeYz5k+R2EFFMSD6TMaZuzwWC1zs85F+mn9D72oBdQspYpzVBKoGbWX3uXp
 pMhSJBemzTB9qe9AzLxCwF3kpLXWEx9l5FlVlJGj+4kco6bD4cDqcCPdbhuYIgM4VKabwGcVM4T
 xth3bTouMzT2Hm19lXO8Pm00gJNrgyaK+pyfdP/p7mLfA5bnHoI0JCv4peY9PB/2ipOSQrmo4up
 cslorCLk4PcnLJZuVX/J+faxXzHUHb8T7s6gLAddX/yk4TlPXmi/cqQ/720lcAF52CyPxytxzQ9
 W0LY0hJ2KUzMxBLwBb48/1bKW9oWjwP6awOj0jlvwRw==
X-Received: by 2002:a17:90a:e705:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-353ff8b3d60mr463025a91.3.1769491032989; 
 Mon, 26 Jan 2026 21:17:12 -0800 (PST)
X-Received: by 2002:a17:90a:e705:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-353ff8b3d60mr463018a91.3.1769491032606; 
 Mon, 26 Jan 2026 21:17:12 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 12/33] hw/i386: export a new function x86_bios_rom_reload
Date: Tue, 27 Jan 2026 10:45:40 +0530
Message-ID: <20260127051612.219475-13-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

Confidential guest smust reload their bios rom upon reset. This is because
bios memory is encrypted and upon reset, the contents of the old bios memory
is lost and cannot be re-used. To this end, export a new x86 function
x86_bios_rom_reload() to reload the bios again. This function will be used in
the subsequent patches.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c  | 21 +++++++++++++++++++++
 include/hw/i386/x86.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 4469b4e152..c0a540495e 100644
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
+    if (!x86ms->bios.addr) {
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
index bfdf97640d..5bb052cd67 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -122,6 +122,7 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp);
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
+void x86_bios_rom_reload(X86MachineState *x86ms);
 void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-- 
2.42.0


