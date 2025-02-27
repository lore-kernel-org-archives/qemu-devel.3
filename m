Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5B4C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekZ-0007E5-A2; Thu, 27 Feb 2025 09:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekW-0007BV-BX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekU-0003l0-Jx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3SHEfAckc7eqDUyGo9AWwA42EPB6Qrfn1g2oHUJdAU=;
 b=CsWg0BhZi5T+6H8wbTB40jcAEE7W0cQzhStkuvjMJFzcsbjybIYYPvBYhhUKkcJRca/aTj
 OEf2GJOnCmP/YR9Ya3gFlNfeH5n7yzbOV/GehOGzGAncN1GFuUWa0b2br3yNfzYUDaYfHP
 HjQVl2GLefQj+IkkB2yr8RiK7Idi7Pg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-qS-PosQrNgCe_EzZkF2xFw-1; Thu, 27 Feb 2025 09:20:21 -0500
X-MC-Unique: qS-PosQrNgCe_EzZkF2xFw-1
X-Mimecast-MFC-AGG-ID: qS-PosQrNgCe_EzZkF2xFw_1740666020
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb7e837a7aso112748666b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666019; x=1741270819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3SHEfAckc7eqDUyGo9AWwA42EPB6Qrfn1g2oHUJdAU=;
 b=H4stA6ISuB44nWVu35SabXSygv7W9f6jAC5KxKq++syZXHDDUg+ve2ruqFWt+JGELm
 IVtVczkuB76O0sOOsWpWadlZWWhit2HjI3hBsi629EAolPXOcPKw4MCEJuzbney5AzsV
 skfA3+44AFRVfQPnGgmY2NqzNIuaBEy6avGL7Pkoowp8nnS2d/jS1BqKx2El8qeXRXOD
 n7MN2D84aWxtw+6DnTwR310/UrsazThB4JY3pqfGENy+0jMXLX/bv+bc1rBmZ950fukh
 yTxbn2O7uwt3UIa6/4WTfqFL6ReBY10wfatr/z7GP69WSDxruDCnk1C9jmnyQq/2PPSi
 4nvA==
X-Gm-Message-State: AOJu0YyuoYBnJnKYOY7HAC9a1AktDG4K2IGVYoZlVj7SRwT2dh7gx+Vg
 Z1SHPXSjcHToYYymnJex8kA7AdQ9P1icIzFAdkuDH23nfCY3g8MBy86jzzX54STXDWWiDWNACm2
 XAp0Ia6NEDCvvSdg5yyQ4S7SrFvs1F7ZO3TJruxq908wCB42qTtnfV33ZfnPpbBp6KjD9JH8DXL
 /zZH17u1bGiItkV6DuqAftS2SyJP5P7osLaRrzXE0=
X-Gm-Gg: ASbGnctBaZTdCpbZ9PpLs/yNgYOJwxvoS/35hpQk8T52NkcwYqqz/YyJYd4601avsVg
 /oZU+bOvd/Fl05ioFw+TLbQV4O/baBlDUGP5SPNJ+N6sBI3LcoGtPRJ+rBp+bo8Bje/pUiNlQLP
 mCtOo5YZ81aN53Bju256RGOHuS+HH+tTbkxGshRT2WZgOLSw8MetPRpBctaJveIPS5tfoCtUNui
 IPxEaIPdXUhqg6IRGbQbiZDmB5mLuWxuPbDzFj/cWdpkgpyoCTiFKJ5Cjv4AYwoBo5HO4vLvH3Z
 TLm/TFD4n/56qTG+hrit
X-Received: by 2002:a17:907:7801:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-abc09a079d1mr2691813066b.15.1740666019119; 
 Thu, 27 Feb 2025 06:20:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFparBIFnApYePY3cRqTgul9/BGUSE3ord1JQgKYxTV0MP1CgCcshqlW0JkCTbBtdyaVcZJuA==
X-Received: by 2002:a17:907:7801:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-abc09a079d1mr2691809166b.15.1740666018617; 
 Thu, 27 Feb 2025 06:20:18 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6f60b2sm129205466b.102.2025.02.27.06.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 11/34] physmem: replace assertion with error
Date: Thu, 27 Feb 2025 15:19:29 +0100
Message-ID: <20250227141952.811410-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It is possible to start QEMU with a confidential-guest-support object
even in TCG mode.  While there is already a check in qemu_machine_creation_done:

    if (machine->cgs && !machine->cgs->ready) {
        error_setg(errp, "accelerator does not support confidential guest %s",
                   object_get_typename(OBJECT(machine->cgs)));
        exit(1);
    }

the creation of RAMBlocks happens earlier, in qemu_init_board(), if
the command line does not override the default memory backend with
-M memdev.  Then the RAMBlock will try to use guest_memfd (because
machine_require_guest_memfd correctly returns true; at least correctly
according to the current implementation) and trigger the assertion
failure for kvm_enabled().  This happend with a command line as
simple as the following:

    qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
       -M q35,kernel-irqchip=split,confidential-guest-support=sev0
    qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250217120812.396522-1-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/physmem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 67bdf631e60..eff8b55c2dd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1882,7 +1882,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_block->flags & RAM_GUEST_MEMFD) {
         int ret;
 
-        assert(kvm_enabled());
+        if (!kvm_enabled()) {
+            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_discard_require(true);
-- 
2.48.1


