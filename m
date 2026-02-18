Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA231E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxw-0003KT-AS; Wed, 18 Feb 2026 06:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxl-0003G2-3d
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxj-0007sE-BF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cB9YNQTiPMfXUb8pkRT8YklB7Tgf9L/mxZrNTbXVbIc=;
 b=ixQjjjYHXpLUPT/l92tHwqUk85UUzfNRRhrpIaRyXzQ+MnxADpueZbf6dodLUsfn+M+ako
 HMVB2qjzm4wEsTSD8f7T9OEzDBaNNhsSOXoS4jutEK4a+rdlvSPhCOMhbZPOURlpyxEFDG
 BAF+7E7/towtU729TzxnRX6D6rRJ9+E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-_hbWRvQiM0KOKH5pkISGog-1; Wed, 18 Feb 2026 06:43:21 -0500
X-MC-Unique: _hbWRvQiM0KOKH5pkISGog-1
X-Mimecast-MFC-AGG-ID: _hbWRvQiM0KOKH5pkISGog_1771415000
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f2381ea85so275901515ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415000; x=1772019800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cB9YNQTiPMfXUb8pkRT8YklB7Tgf9L/mxZrNTbXVbIc=;
 b=QxvnOcuVPjSzUI51n36CP10bzb6vhGx3kkiENp97TuGiTDpX4BYNXg6zCFa5+Sg8qg
 jNKHF0O5hAAJvgOQ1Zk/jNRLC7FvPVKGzvPna7WopgdFxS0xYVOm0VLxQaTpbMWKfM0+
 OoW8s6GFMPRbaHTw4GC9TnAm+VJ2t0nfRhUQ/liaiWg/sCuLDr2T51sSAHw2qFDyPAgl
 HSXyMhNXeuwwbaCMPVWVoYISu8k2AC2+0IOYAy/OelZeHztj+bkVZqZPVBWpWNlS4IBL
 8dDp6zByX3QlDoppWtgLB9QE2LX2MY3qwiM81XkN882GBPsGUMPQr5Y7eEuBaC2bN401
 Qoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415000; x=1772019800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cB9YNQTiPMfXUb8pkRT8YklB7Tgf9L/mxZrNTbXVbIc=;
 b=WPA9TODzLBuI/HtddS+Q6qMuer7YBvi0PtbUTa8FHAqIlDIegkOyBs1i2hY2tda4uc
 pClS+3ZUufJXn8mNAY0nJHGM/P+Mt5UxVqjsvdeMfXWLnGBNUdsmKn9Eci7CLKRV+PfC
 ggo1LXvv5q0lepiykvwFI4E+1XcZ9XVKtxzIE4GKjPHeZk0Z2MjGBwKyI14S8RrUuo4k
 5p//Xi8f20LlLwcKj39fZs0USUsV+SC5JBZf3Qj+lzjiuB3Wvf6bF/ljXq8dj0iwz6pQ
 mFJIHXI9tli1+q/Xe4+Rumfx2+5Eg+qhK6IQBwyPclyP8muTbiTfLiPSrbT8SOKHq1Yh
 LSUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV93BWDrzSqsTsQIu8epEdwvQ0ul3hY6A6dJRIx2gUtIY2LhXfa11C580pD/AYLSMReG68Fvl1Yj+KL@nongnu.org
X-Gm-Message-State: AOJu0YxiH35Ct1zFg/8A5cLxJGp1JHjQzci/TJrRjuEBAbNSjpSe9oeS
 108OeTaa8m1Gjd0GaHmKPN0B+kt5bten9/ON4iF1lSePQNO8iSultvdheYHPp4x/kJ12yvurKHE
 XnjPQuS9jYm5sKrPaicv6bkVHfzlhU97NxKsqHWH70D5+xuYBmwrsB9Gf
X-Gm-Gg: AZuq6aKUVRwVn3Ankw3aPujULc2BKGW0Vok8+Jr06QSq/8uXYZ1RRz2ni0ynawmvT+M
 xZNCHvLht4duPP0hLqQLod73TpH5/U6NaWmWc+xbGeSo3nKmBANTlL6BQwmgWOdsZ5r9lx4yNxO
 bpj/ZM5op6LfwNGmqxi4Cyp3ejeCL/jwYe4RJIluSK8Xf8uKRKltK1w0o7kaQBxuQZNyQxLfihh
 j/bEWPqTpBBF/HhAZZluCsmbwvTkCbcQ48rgT4UyJbYsa+4AUzGCgMgWBb+fhZkDHBBercsNuo5
 jxFxM3FzVMfbwT2eCWJe3abYsCVR6csYb24tdeRexZH0mDI+IVSoL/TQo7RjTEfCf3se/pzl5zh
 WexoKA04gaYtn8HqVNvyxg5JPOLd39BH20NU1xkPhi3VAh5kn+okH
X-Received: by 2002:a17:902:e748:b0:2a0:acf6:3de9 with SMTP id
 d9443c01a7336-2ad175a51d3mr133355215ad.58.1771414999954; 
 Wed, 18 Feb 2026 03:43:19 -0800 (PST)
X-Received: by 2002:a17:902:e748:b0:2a0:acf6:3de9 with SMTP id
 d9443c01a7336-2ad175a51d3mr133355055ad.58.1771414999587; 
 Wed, 18 Feb 2026 03:43:19 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:19 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 11/34] hw/i386: refactor x86_bios_rom_init for reuse in
 confidential guest reset
Date: Wed, 18 Feb 2026 17:12:04 +0530
Message-ID: <20260218114233.266178-12-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For confidential guests, bios image must be reinitialized upon reset. This
is because bios memory is encrypted and hence once the old confidential
kvm context is destroyed, it cannot be decrypted. It needs to be reinitilized.
In order to do that, this change refactors x86_bios_rom_init() code so that
parts of it can be called during confidential guest reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index de4cd7650a..c98abaf368 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1020,17 +1020,11 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
     memory_region_set_readonly(isa_bios, read_only);
 }
 
-void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
-                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+static int get_bios_size(X86MachineState *x86ms,
+                         const char *bios_name, char *filename)
 {
-    const char *bios_name;
-    char *filename;
     int bios_size;
-    ssize_t ret;
 
-    /* BIOS load */
-    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename, NULL);
     } else {
@@ -1040,6 +1034,21 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
+
+    return bios_size;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
+                                char *filename, int bios_size,
+                                bool isapc_ram_fw)
+{
+    ssize_t ret;
+
+    /* BIOS load */
     if (machine_require_guest_memfd(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
@@ -1068,7 +1077,26 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
             goto bios_error;
         }
     }
-    g_free(filename);
+
+    return;
+
+ bios_error:
+    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+    exit(1);
+}
+
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
+                       MemoryRegion *rom_memory, bool isapc_ram_fw)
+{
+    int bios_size;
+    const char *bios_name;
+    g_autofree char *filename;
+
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+
+    bios_size = get_bios_size(x86ms, bios_name, filename);
+    load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
 
     if (!machine_require_guest_memfd(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
@@ -1081,8 +1109,4 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                                 (uint32_t)(-bios_size),
                                 &x86ms->bios);
     return;
-
-bios_error:
-    fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-    exit(1);
 }
-- 
2.42.0


