Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E916AF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vO-0007ic-Ds; Tue, 24 Feb 2026 22:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vN-0007f8-I9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vM-00088f-17
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESypFcrxb/PTVt2Aex0/LJ0mDUhQITS4Sl+F/ZJ54Aw=;
 b=OTUuc+N1m3uestm3hQg14kA3Ok4HbTR3akBrJXfo327XezqQNp1S70lljPDeIKcVUgFrSs
 5HW6UlKihKwfEXN/8d+z7IdBZU3yZBHaNfD4G49iCfPDgVi9s1BLT7LEkZ2GNU0VAR6sof
 zIDhA3Y2pg/MSKpS2zwWoVBO+31HxGE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-3j5oa4-wPamBp9IjCypowQ-1; Tue, 24 Feb 2026 22:50:53 -0500
X-MC-Unique: 3j5oa4-wPamBp9IjCypowQ-1
X-Mimecast-MFC-AGG-ID: 3j5oa4-wPamBp9IjCypowQ_1771991453
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70ea677571so83818a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991452; x=1772596252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESypFcrxb/PTVt2Aex0/LJ0mDUhQITS4Sl+F/ZJ54Aw=;
 b=pwUKCp8tI1ezgl+nYtetMVYjmcRdzs7QVdIeAC9zcHB2D2AGHHSBtUSGk2QiInmr/v
 m0LTreKpNovo58G71qOjhicwoMLnbbV2u0cTRAExY6v0YkcaPxpVKqudv/bNKBjnsdGO
 9bPWLQJSf382b/xOOKj5/MYPyEA5h3/UAtgbecaB48gAT4zIz27YObfnEMPmRhl8h7Qw
 re7RJacYC5wWTCnyI7P3yi5kQ+UO3bq28xH1oVkw0Tl3OMgB2vJjN+LPBn1ZLNKnxxhM
 5uCcSub7OvB5D4FuiH/MezGRoz0dKX3vK9N56d+HdFY94Pvbt4P+o3iEDF1zqwnkT9NT
 D7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991452; x=1772596252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ESypFcrxb/PTVt2Aex0/LJ0mDUhQITS4Sl+F/ZJ54Aw=;
 b=K98HERNVLufyuac4G0NY41vc6NfjjlIIHtyk3Yo0ZLrZQsqeU6musIbl+Dl5zGklMw
 tOxCZWNkRlmJNEbf7BWWXxszBXMAKB8m6MhimPAkwTIosBddPQoS6/Cl4aI6AhqFIDa/
 ds9eBkdmlhl4fgDyT8Pc9/nMyzxkoCZHO2iJuWOHbAivPKvZHFUq2uuVnAqs7mH2qQzR
 vm/pT9m10KEtpmfRHbzu37gbLmZ5FcEINHq8+umzmpPptuhy1FXQT1/5UlNmIrCkRZBg
 p+iSR3VqUCMt1x3ZLsMu1lVgrWjvbKGKa/wo3h/T/jq1B7ryRnBbZGwMeyac3go5mKqj
 GDiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5yqBFCTEccEshbOHEA5WGPOpU8JtUtzHuhCe0/BJbABLesudjov61tDLttATZeHxxY0yuibKNMa4z@nongnu.org
X-Gm-Message-State: AOJu0YxBlPJVR5t66CghXw+9KcLXTHJc3Aw2MRsgnGV+mIJS9QlFH5Zv
 4TwnbUW4HrUXztLLe9hfgRApo7VIV+Tn5/V1GsJ9tem7a5U4bEoQcj/4oPTw4xx8lkbs83JnUNL
 N8wt69UH18x9PrLi0Y0d6goJWwkX6Cg/8MX5u57IgPEbq38Y5UxsTlUZZ
X-Gm-Gg: ATEYQzyTks0DMDWNtBj34TWBOldFSnqmUo+hXz7FA+3yPXEr+4QwVPd27mNnsLkcmaL
 jIvSCIy7nm1aoJbQAbag7+dih4fRaNNJJ210wuCcl8KDJIasT5tXBAb3b1MqpQiCLRqZLf9sP+E
 p0/6th3e+8y1FaYTqDjpyHawcBrbKh58/WGVxrrz9xoJ60IVKc2iZFZwTN59wint4AfY1Odv4jS
 E7NiF9Hs368zkJnI71PG9t1osDuITsy7x08iub6n+gnDg7FEhzK5S6vkdzX58Lv9VJhm+e6CCdj
 Y08Np6CBgORgkKaJ9tQydYYqR9ISmyYKyg3hM9d+zXrxh07rupXJjHLKSkUDSF9uqUczLyWx9RQ
 gDs5YO9DMjdeSU/mxOnLxXSj05qzJfasBACmekrPDeP820Mz1Ux9qEg4=
X-Received: by 2002:a05:6a20:7294:b0:393:e16d:516 with SMTP id
 adf61e73a8af0-39545e54af7mr11547101637.9.1771991452625; 
 Tue, 24 Feb 2026 19:50:52 -0800 (PST)
X-Received: by 2002:a05:6a20:7294:b0:393:e16d:516 with SMTP id
 adf61e73a8af0-39545e54af7mr11547083637.9.1771991452246; 
 Tue, 24 Feb 2026 19:50:52 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:51 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 13/35] hw/i386: export a new function x86_bios_rom_reload
Date: Wed, 25 Feb 2026 09:19:18 +0530
Message-ID: <20260225035000.385950-14-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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
index c98abaf368..a420112666 100644
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
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 23be627437..a85a5600ce 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -125,6 +125,7 @@ void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
+void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-- 
2.42.0


