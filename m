Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17CACD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSrT-0000g1-Jr; Tue, 03 Sep 2024 08:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slSrR-0000fI-Ux
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slSrQ-0007NF-Cf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725367335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrIEiVhLJ9bUrmnEnLksh9UeyYXSB1B5dyjmrN1LcAo=;
 b=Ep74w+/ncHP9+mYmjT4oJhbfEg7687yYEz1Ya9sA9qoYS0YD4XJS0vAsD1JUugmMCOlIns
 Pa1hZYKnayNsRMvCr5jP3bD6hsIcryspKnUG2I3Z4bKE3O8Z6CecmLxcPimdlefxZT8U2Y
 LJMn/QXQJ4ezjw8P2mZYjUhzvrhK6TM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-lJEh-N45PymoUxbjBg-oTQ-1; Tue, 03 Sep 2024 08:42:14 -0400
X-MC-Unique: lJEh-N45PymoUxbjBg-oTQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2056364914eso17993225ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 05:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725367333; x=1725972133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrIEiVhLJ9bUrmnEnLksh9UeyYXSB1B5dyjmrN1LcAo=;
 b=hvD0WfTEZZpRJxMtI/Z5k4G79cZrVmgviWW1xKXQo/jWHqTYeBw1j2hMO53MBdhWrQ
 4wOWg+Ns8uFFAJvbM8KeRrVYQNaTPSX7JWflOgNr61OES+NFKjMZb6P6dMh8NooC8jpM
 8NbzQGIm7AnQCOON3BJpX6Y6xnoZlSpo9VIXP2EVK+D4CDviev9isrKlX2BLWBHvsnCk
 lQF/62WL5UsXkFrZSOZ0bpAp0kIy9Xb4C33zWYUiXFWnDb8RaRtTdQ6BBjNdX4cS6zRZ
 uh6NN9fdWIJ8FhGAIVFPOUHXF7/LrR5G9GM4KDtJb4MLDuezwOUBfuf7YZBe8W0nJlRO
 XdHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHqQwZBt9OKsNZmfFBXIPQ37BXD28MUwplQM0lPFjVlgkNcGGePERNIW4ZkDHoQVC764AWJFgYqC9N@nongnu.org
X-Gm-Message-State: AOJu0Yymq2H2uvIDgjM3n3vHxQXeN0aB8/YkEcwqzc/7DEqxAcPPAVLY
 8GbRKzZCrjJ0eFoVNm0P1HYErW+R8Dk7aQRjWk7vdMVc7OHMtx34v+yqs8EPDHEw8JXTlLeX9zo
 DokhaV3d5GjaqdTCozC5cIlnz8oBu/HtiCdpLgzKLPh5XH00fgmrq
X-Received: by 2002:a17:902:e5c3:b0:205:951b:5636 with SMTP id
 d9443c01a7336-205951b590fmr39929265ad.47.1725367333556; 
 Tue, 03 Sep 2024 05:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeUiEaFLE5xXFPPRXAqOYMGgp5Lxxy1rmWivLg51XXli2/ChgQ0liP3LPA9T2uchXW0oL+Jw==
X-Received: by 2002:a17:902:e5c3:b0:205:951b:5636 with SMTP id
 d9443c01a7336-205951b590fmr39929065ad.47.1725367333140; 
 Tue, 03 Sep 2024 05:42:13 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-20515542350sm80222025ad.213.2024.09.03.05.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 05:42:12 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH 2/2] kvm/i386: do not initialize identity_base variable
Date: Tue,  3 Sep 2024 18:11:43 +0530
Message-ID: <20240903124143.39345-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240903124143.39345-1-anisinha@redhat.com>
References: <20240903124143.39345-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

identity_base variable is first initialzied to address 0xfffbc000 and then
kvm_vm_set_identity_map_addr() overrides this value to address 0xfeffc000.
The initial address to which the variable was initialized was never used. Clean
it up.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 574c62c21a..c8face0eeb 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3187,7 +3187,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    uint64_t identity_base = 0xfffbc000;
+    uint64_t identity_base;
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
-- 
2.42.0


