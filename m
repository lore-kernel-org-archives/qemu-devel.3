Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10280D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNu-0008M7-2U; Tue, 15 Oct 2024 10:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNj-0007h4-1F
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNh-0003Oc-KW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgoG8JgwXVz3g5onUJt7t2xCU8/TZqbsVMYU5eI+0xg=;
 b=DmcpNhwxrbD9YjyiroaRS39zS63G9F5noWP/NbnChksvEI4sVIFyyXEq0r28HUni+qL+g6
 VbUgIQpqHmEzQNLk83076hADH8c77CsXifMS+jPOu5pJqXC6FLzNVJAPQ2mkm4Jp2+Fkit
 ED/EnY8/npiui8HI1upiE7ZluxzMyNY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-D3BdAknAPrKtaULEc0x86w-1; Tue, 15 Oct 2024 10:18:35 -0400
X-MC-Unique: D3BdAknAPrKtaULEc0x86w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so2049175f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001914; x=1729606714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgoG8JgwXVz3g5onUJt7t2xCU8/TZqbsVMYU5eI+0xg=;
 b=k0tUJjIRvodTMNp1J+HKwkeBCGEDwUIOoYablKtHrkOe/DXz0GWa0EQM/4PJja8gad
 VGaYvGx0Eh1fFXBf8S+4gy/iLRgzxw54wmohxbfV5Maz2MtRm4Dgm0s521cwNBKlaZ9F
 vabApy3dmkvMUxxghs/dsn4jzTaGaazmtd+14YyxWKlBJQV4VO9i5S0senfwZ1YW2GKQ
 HsanEwCF8Rdb2iiMfXrrGtGaOxclI4Lp/NKb1ppN/vpoFbSqGYSvRzLHg0esyIFcRA/B
 t0WLfa4Yaman9y0UcXMU1rK9hQvRtqR+emkh3ecFdeE4rUO/eld3mUpCVjy2vP51Nvcs
 TQ9w==
X-Gm-Message-State: AOJu0YxBKKjr2OL5D0NzX0yPrmqXPSxOAUYaAu+gjzoCpJk5c60P04x+
 iZf95cjj7LX65HmlxXxoXcDXbYygnuzTTmgcRJOaouI+yv8dNz0giLWQWFgYqXu6JwQB5HTl9Te
 FPKO9DmKSP3oiqb6AhJOgLYZl/bB4wIdBIO4fwCNfMf1EV7Y5BuPWGuHU5/JEBpa07OzuT3Xb0w
 Wpq6iMDvtLOuieT+3T0o98r1wsaqyA+GCc3VmAuJI=
X-Received: by 2002:a5d:6a0a:0:b0:37c:c9bc:1be6 with SMTP id
 ffacd0b85a97d-37d862af94bmr658811f8f.16.1729001914119; 
 Tue, 15 Oct 2024 07:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHk9TFbIos2gJKEbPoEEInjBDQpLuD7YsloSf8srkWSH6yzDN9tYpbCbvkyJVzcACkRHnogw==
X-Received: by 2002:a5d:6a0a:0:b0:37c:c9bc:1be6 with SMTP id
 ffacd0b85a97d-37d862af94bmr658778f8f.16.1729001913618; 
 Tue, 15 Oct 2024 07:18:33 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc12023sm1687469f8f.91.2024.10.15.07.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Dohrmann <erbse.13@gmx.de>
Subject: [PULL 24/25] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Date: Tue, 15 Oct 2024 16:17:10 +0200
Message-ID: <20241015141711.528342-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Tom Dohrmann <erbse.13@gmx.de>

KVM_CAP_READONLY_MEM used to be a global capability, but with the
introduction of AMD SEV-SNP confidential VMs, this extension is not
always available on all VM types [1,2].

Query the extension on the VM level instead of on the KVM level.

[1] https://patchwork.kernel.org/project/kvm/patch/20240809190319.1710470-2-seanjc@google.com/
[2] https://patchwork.kernel.org/project/kvm/patch/20240902144219.3716974-1-erbse.13@gmx.de/

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
Link: https://lore.kernel.org/r/20240903062953.3926498-1-erbse.13@gmx.de
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 482c5b24cf6..801cff16a5a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2683,7 +2683,7 @@ static int kvm_init(MachineState *ms)
     }
 
     kvm_readonly_mem_allowed =
-        (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
+        (kvm_vm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
 
     kvm_resamplefds_allowed =
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
-- 
2.46.2


