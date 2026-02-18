Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90D2E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxw-0003KZ-QF; Wed, 18 Feb 2026 06:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxt-0003Jp-Bw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxs-0007sp-18
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtPGtZmrmBLpOcF7mZMrBE1yp80mmA78e975dk/A+AM=;
 b=Qk4rOjWgtsq50ohGZmJDu/RUBeGncr3Td1aPWmEZVOBwZ55Pzd+JFJs66lj52JZsgMohb0
 lQaKsacQb8ySoN8u58hs0c86l6LpT7i9WXCPQhB5Q0kHXwKsOGqeAZIei2PXbt0bfDAVbD
 E0p0DmM4hyIZuQG8K7wELSNvgqLZ04Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-HQGSV_-HNhK4HuIgdS3leQ-1; Wed, 18 Feb 2026 06:43:27 -0500
X-MC-Unique: HQGSV_-HNhK4HuIgdS3leQ-1
X-Mimecast-MFC-AGG-ID: HQGSV_-HNhK4HuIgdS3leQ_1771415007
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a79164b686so70802165ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415006; x=1772019806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtPGtZmrmBLpOcF7mZMrBE1yp80mmA78e975dk/A+AM=;
 b=Guntso94D7gwv/RHEP7CpswEtY2kFJrgv8HNeGC7UMesOHwUwNjfS3HJTjLcsx0rQZ
 xcSNVlE3XnzRajmHGhs9divkrOKYJwBjDPZHJxV011C+CbdoyfcUWMbSbSWzFjZXLTTU
 cdY68mJUH6ZQLqhIBUWFhmRMgE2YCOfmkxXE0Q3ozodO98jok4UAg2UrtftG6MHa1wq3
 HXMo4TpaI89zC6Y615SFgU0WcWLpJKfgcWt+MmeFv4d1NMqbZx0dyj3+xAvlarAip7Ts
 KX2M6mIkqKa2msoJWgs/iOAW4nrOjK35DFQQA0MdsekgK+vKniNQzG1xdslMLrGGtKSz
 IgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415006; x=1772019806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xtPGtZmrmBLpOcF7mZMrBE1yp80mmA78e975dk/A+AM=;
 b=RHQ7uP2QLrJ4VW27/4c+TS5UPvWtLtZfpymjMLVT/cj5E+sbYy7EXYFxqz+8Z/Hp6j
 F2NcbP34waA7jz5VEcPeNyv5dNRyRvwmt9xQxqsMgxHIlf0rYfG8SmA9bvyarh6u/f7H
 CYIv9cFqx7dgsiXJFSPHl7wyLReyqI3LkRaPwpVl2pR2lxwMqj3OqH4sjjr0URT18o7v
 XErKLKq5wX010UGjxIXtMHl+fiUWIOaHW0Yqe2r6T/KoH9cJM6W6uXZWyvjEmdTG6p9I
 f3o/UCKrZoGIBpRNc+wEHW8ZxMbNI/w5pg0CR0l6uYT2qDN0DaH7ufjsrklkfXYmNDCx
 CFFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNXh22pTnOHcAIzeNyIx7fEfKpsbBKiVY41HSyt8h+FCtegfYJ0RkR4pNUmU5H9ky4E0ZB3h67/2jK@nongnu.org
X-Gm-Message-State: AOJu0Yy+sOT7auDsiLMuM5I5G4SxsFBXfiy3wNFHczCquqMxmQi0GKmu
 kDdPDDVnNOEqUi74HkHQ9oLX8G/vDr6o0lWxlSMAoBTOU/MuNeNS6aI3r14DNI95yHRyeRG75/X
 sLfnm7y/j+3509UXwgR4afeLonL0fMyit78Y0GNd6b3TGdrZ6G6tE9XWR
X-Gm-Gg: AZuq6aLSxlxmLXeGNTAA3RdZYHG1GVFQIcNUeXdc/dRN/0ZQyl+quFz66Z5QFNi4EeR
 u64FvhQor6lkdLVT5hIbjqyJCNSsHNmOnKTpiLK74UU2jShq7DbJVxf2Gk8DYUDRCdDAQ5GN9x5
 Byfo7VIWyytZWfjzsQ6nwLCnSA2zOc7KvDowq39ZfuGtbZU6a19Nb7PPOiTPXVHaZaTJPE8E3pW
 Y6RBfLNvyz8ymz1cAcyAcufv30i0rKWf1PzRaTTI8wdCEv926vDIiGPvEfHqOvoi9dsM2vps9vf
 CVUm4WXzUHX/VC5g236AYlkXHkFF/GIX2X7t1u/O4v0WLiQHgMtc3tksSl/csGwfmQT3ySmZ2Ef
 M6wIelus/oxU1K1dWQ/9E5pHBKiOEB/Hvkn+QYn8QKZk5fZySUPq6
X-Received: by 2002:a17:902:f54e:b0:2aa:f798:8c7f with SMTP id
 d9443c01a7336-2ad50fe0da1mr15879765ad.54.1771415006571; 
 Wed, 18 Feb 2026 03:43:26 -0800 (PST)
X-Received: by 2002:a17:902:f54e:b0:2aa:f798:8c7f with SMTP id
 d9443c01a7336-2ad50fe0da1mr15879615ad.54.1771415006204; 
 Wed, 18 Feb 2026 03:43:26 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 13/34] kvm/i386: reload firmware for confidential guest
 reset
Date: Wed, 18 Feb 2026 17:12:06 +0530
Message-ID: <20260218114233.266178-14-anisinha@redhat.com>
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

When IGVM is not being used by the confidential guest, the guest firmware has
to be reloaded explicitly again into memory. This is because, the memory into
which the firmware was loaded before reset was encrypted and is thus lost
upon reset. When IGVM is used, it is expected that the IGVM will contain the
guest firmware and the execution of the IGVM directives will set up the guest
firmware memory.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index feb3f3cf3c..5c8ec77212 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3416,7 +3416,14 @@ int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 
     if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
         X86MachineState *x86ms = X86_MACHINE(ms);
-
+        /*
+         * For confidential guests, reload bios ROM if IGVM is not specified.
+         * If an IGVM file is specified then the firmware must be provided
+         * in the IGVM file.
+         */
+        if (ms->cgs && !x86ms->igvm) {
+                x86_bios_rom_reload(x86ms);
+        }
         if (x86_machine_is_smm_enabled(x86ms)) {
             memory_listener_register(&smram_listener.listener,
                                      &smram_address_space);
-- 
2.42.0


