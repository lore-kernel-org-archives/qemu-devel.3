Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE96D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvK-0006ci-1I; Mon, 02 Mar 2026 03:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuq-0005O9-Qb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyun-0001y3-N0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u45VlP6nLQP4FVKRSzMkP4BNLjBizhtLpJZtVE2DTlg=;
 b=HfBZik5bhqfGAXmiI23uteVqVX4+LMsKv182cAMT3EAESBR++dvWsJZQtY9qUT436nJjeb
 n8t/J1bh8OlXop/1WxSwufbnuL7tuPh72otne/u1VaWjGnjkx1VgTWcZvnbt0b4szvGk21
 zWnSvfmcVqY4B5erort12v19rIcXSOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-V-stZMg2MmWpRS-__aHq4A-1; Mon, 02 Mar 2026 03:46:06 -0500
X-MC-Unique: V-stZMg2MmWpRS-__aHq4A-1
X-Mimecast-MFC-AGG-ID: V-stZMg2MmWpRS-__aHq4A_1772441165
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836e35292cso35579085e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441164; x=1773045964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u45VlP6nLQP4FVKRSzMkP4BNLjBizhtLpJZtVE2DTlg=;
 b=bXqO8hxHP0nbWunoeTRn/zUn2paOKSlgblZKHR8saIlbI0+I0I7j+YPFvErzprbdyh
 eR3BJw217KyNRnkCDBAq1Fxc8uPT2aVt8KGNN92rm0ifreWhTLPOlOx9jjz0Yl8z+JXP
 QVBFWaDZVpbDGJUUm0UJqyZE/0PRv/61Qy+5VY6txo7XwZ6/WncPVKd0EV9VCYNEP8wu
 ZZECpo7cxHm4t0qk6hzUgqDMJRg5fputVh5v4y3Psrerk9mLttAlbUfpOUl3JH1ku03N
 dMQ4ZB2R8XG2dsQ4XTtmdM5c2V36IBKmSesVOblehRVYafwj8m26tiepIttbxLIfstE6
 JoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441164; x=1773045964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u45VlP6nLQP4FVKRSzMkP4BNLjBizhtLpJZtVE2DTlg=;
 b=fMyCTb98JZApxNdcm+BuTPcx+3lGEkd3fkCPwzxByfcoCn0eoHBsMOSFwkhpUzeb8F
 l9dSWRtiamJF56uvLV1l+BcaNITNimfafgSktLtuuTaKoAhxBHYjBKW/qNkWZRNOtYOx
 pGlGxSDMz2kBIO2Y9IKGbW6qs1HVL0izUmgGRMvCfWIEjUHXyEYXCDHPCW9gg+Ie3w0q
 6RxIl8vmRM9sOXYIX0mnUdCLNK29xEjQSpJVI+mZCcrYdJ5muZhxpBnZQcLpPVHjGwk4
 Ji0hGX201HgiPWhE5UMHvbSd6tfobZVUf8hq1WSbqb9BIJ0iIGe1Ceve4uGXBlLfwula
 pbYg==
X-Gm-Message-State: AOJu0YxvmI7PT9c55ESd0Xr6mhrw/shVFPku6P81bGTcXgFXM4DwGmXR
 ulG/fFF7Umt1OALgKAFuRKZfm6YAkmmt3OREhX0ZZtntNSNIu3nAzz0l66dHPknLpgYOu7z7/Jv
 h40xc1Kjwfbn95JA4CVx/UABTXtJSP6rxRINq3X2Zm0qWKBjePLfCAPCzfYakBH9iWXBHaY6X8S
 xJcmMUPw5wKSF2zqFzPZm1o+SDL48vGu1LG2nr2jMA
X-Gm-Gg: ATEYQzyheuOypfRyCNtmeaZTSHtmqmn4uMVsY01VVJ9enu6EyW+IE6EuG/8GT0bGfP+
 Crb0t9rorggTwnWuqrkh2TIpvMMTNHHj1QqtHd63T8r/b8LrgQU6Z87x/sNoz2VYQ1rgFC8vFQ5
 Z60NXN4n6ci7tHdDb65/QMInYCY7Icxknof5r2WLQ3lvqtNUSkxHh67ZzJmimb8IYqU51/QjX/p
 AzzEnbDwA9POAo1+k0yLxElZ60t+U0zG99wUHjoipV8iQG8tnufZLmypiG/ql8nkj26nCn2Z4UU
 psN0d6S7FKzmM8wxvGRxgqYLmp0VKXaZgB8J2xMmGyTbQ2seUE4abPDGhqfx7sCIqp1w0TiXs3K
 Co33s7c8ppMw/Fzx+VB5KWcpwpjocTnAahgT+LMcmU9FNQDr5ajcNLK/YtEdopC3EiSaL0vknAy
 P4ISSMhl77uoCftaHtK/VfJhCwpzg=
X-Received: by 2002:a05:600c:64cf:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-483c9bc0370mr198206065e9.11.1772441164580; 
 Mon, 02 Mar 2026 00:46:04 -0800 (PST)
X-Received: by 2002:a05:600c:64cf:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-483c9bc0370mr198205745e9.11.1772441164127; 
 Mon, 02 Mar 2026 00:46:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfabb84esm387539115e9.0.2026.03.02.00.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 054/102] hw/i386: export a new function x86_bios_rom_reload
Date: Mon,  2 Mar 2026 09:42:49 +0100
Message-ID: <20260302084338.473368-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

Confidential guest smust reload their bios rom upon reset. This is because
bios memory is encrypted and upon reset, the contents of the old bios memory
is lost and cannot be re-used. To this end, export a new x86 function
x86_bios_rom_reload() to reload the bios again. This function will be used in
the subsequent patches.

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-14-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/x86.h |  1 +
 hw/i386/x86-common.c  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 23be6274377..a85a5600ce9 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -125,6 +125,7 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
+void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c98abaf3689..a420112666a 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1085,6 +1085,27 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
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
-- 
2.53.0


