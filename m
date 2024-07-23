Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D330C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGIp-0003W4-S9; Tue, 23 Jul 2024 10:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIn-0003O4-RE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIl-000761-CL
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKFZHRAaNx5SH+JoVPvMhA+txKbl3gPY3EVh/Uef8VU=;
 b=du+1IeJqsZq3ZwBaiwMGmOYRoXAALqNdc46/wq00S0IJB5cohFoa0gn/ayShXyDM1tNpJC
 kTnv2qODnDmU8GI3fk0xy7Y+xFDZDj4PY9hjVg8tb+xXg6JEHwFz4ETRBYDfQwkUIZXiHC
 UxQo4RnWvREGpT3p3wJVf29zGGG58FY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-n4SHEXKOMNa2J8i0M2CyFQ-1; Tue, 23 Jul 2024 10:15:36 -0400
X-MC-Unique: n4SHEXKOMNa2J8i0M2CyFQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3688010b3bfso3905477f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744135; x=1722348935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKFZHRAaNx5SH+JoVPvMhA+txKbl3gPY3EVh/Uef8VU=;
 b=aJHzKpanxy9zKxxyu2mirjXqWWrBSQTlOHMHVHCuJ5RGGGb6BFcTGGfoCIgocsY3GI
 jP9jlMLglPuX396V1/uylV2HgxvkKE/1Ie7lCM1HVvUEr0+PFdYqxc5hECV9ya/dqB97
 /RsozR5vgDTpi0o3OJlCW46ypNPS8qCE0pSprmzB8f4l/JGjfOpw4KP6Yg67JEuMtdwt
 dib4xtBXYWVMFXLvNtN04V/oOzPy7HRL7/bBartzCWF2TC67xe2Wo+78n3DASfeyCrmt
 U38HNeudmGtTDKrhjvZbkbRdrHON+mIM+g2jfl+Mk5M56hoa1LiVdvxRGAGBAoZBBjlW
 Rudg==
X-Gm-Message-State: AOJu0YzSfag8qlKYIRC9Qvziy5czcja8gWCTA3n+zG1s2Ig8vlGFWduW
 D13BzWiRq1b+phawx1lt92rEnhp3cVPItQFYN0FcyOVMdBsrQRUT6AdZlcdT9XSGhwmGrrn2IHf
 12ivDqtM0aaHdsuFiXwMMztVrUs34lyFU2gPa6mwUDaUnux/h0mLHxiZydjmWQLxuq1b9PfCSsO
 btArPh9UK59Zi4rWPGTJYDxWqEzWVzPMudUIyi
X-Received: by 2002:a5d:5f84:0:b0:368:3f5b:2ae7 with SMTP id
 ffacd0b85a97d-369bae4ce9bmr9044108f8f.24.1721744134648; 
 Tue, 23 Jul 2024 07:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFu03skEy5KoGckN7VOYKRL7fUjzaBpx1R3byVezDDiNsStsAtQ8yP5eG2RT8Csix728vOlw==
X-Received: by 2002:a5d:5f84:0:b0:368:3f5b:2ae7 with SMTP id
 ffacd0b85a97d-369bae4ce9bmr9044075f8f.24.1721744134200; 
 Tue, 23 Jul 2024 07:15:34 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ac48sm11710596f8f.29.2024.07.23.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 01/11] target/i386: do not crash if microvm guest uses SGX
 CPUID leaves
Date: Tue, 23 Jul 2024 16:15:19 +0200
Message-ID: <20240723141529.551737-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

sgx_epc_get_section assumes a PC platform is in use:

bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
{
    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());

However, sgx_epc_get_section is called by CPUID regardless of whether
SGX state has been initialized or which platform is in use.  Check
whether the machine has the right QOM class and if not behave as if
there are no EPC sections.

Fixes: 1dec2e1f19f ("i386: Update SGX CPUID info according to hardware/KVM/user input", 2021-09-30)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2142
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/sgx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index a14a84bc6f6..849472a1286 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -268,10 +268,12 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    PCMachineState *pcms =
+        (PCMachineState *)object_dynamic_cast(qdev_get_machine(),
+                                              TYPE_PC_MACHINE);
     SGXEPCDevice *epc;
 
-    if (pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
+    if (!pcms || pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
         return true;
     }
 
-- 
2.45.2


