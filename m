Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8E3CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpB9-0006cE-AE; Wed, 04 Sep 2024 08:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpAx-0006aE-0Y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slpAs-0007d4-BN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725453108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKSONi3vI+EyxTRnoLWJtndqI+DlOE7zGSX1EXcbBoQ=;
 b=TQIYEK3GbNBJOyGpYOP1t3tD/Jv/1jlcHF1NCCuWLQzZ9WjRGy01z/5v0JriSX2wKKSnKE
 WMbtwA90ByANVl52qIlTF0YRui4Xzuzdtjfg1RPl9ejskWjbtbkPs/A0wXbQMSTxsjUOnf
 y54M+xhiLLEAeOuH5aKEAtVbTBF2UTE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-NVBreopjOeS8Qsfx2EYBtw-1; Wed, 04 Sep 2024 08:31:47 -0400
X-MC-Unique: NVBreopjOeS8Qsfx2EYBtw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2f403c3ffecso64406351fa.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 05:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725453105; x=1726057905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKSONi3vI+EyxTRnoLWJtndqI+DlOE7zGSX1EXcbBoQ=;
 b=ussT6B+ceU/v6IpTKgFg5DyaYvoRV3WyUHgsQbZ2bRPw1GgqaNkeEExyfIdrF/BYVK
 koMCVau+3HSGIQWLN/94yg62Jp2i5HqWQ0iwO68NrTqGL2fl2wj1o56VlcqB28wuAbjO
 8TMpahR+3EovRMFIkXidh8WkD1MOmMkg2sY+ejLz2F5bCikJPd8NvBjO4vDQFMJ1bhcm
 D/qEwgllUQtqy9bbyiik1yF99IgBRltmSCScFPJ+/Fz/14uoRGLY/V0Hk1Dtn8gU8Ph5
 mJzrzPqUnzDeD+jyetJkYG8T+KRMFY+lc0KCDWrzlRflZAAfXkObE1wwAyF3GivhfPhJ
 DFcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4lYmKKxaS6UW5IKzGYJ1fD+0KNWg+fhgZy+YmAOlkPTVTEoE5/aGOiGwM/0jfi2Sp87zitzg/hIqy@nongnu.org
X-Gm-Message-State: AOJu0YyBshGkglEvOxVPcIWg/7Euq1R5fFe1vcbjIhcJuIQ3cE02AUlG
 IE9R9ro307Vx2qbO8sa3rbjYudnazeQV2ycODDgAbLo0OuXdxuZbjuMiXh874vjQXQSEKmO3C84
 UvhuTzzEU5l0DVh077IL5Ao/XQpXoCsepyXP0TpNDCFJmKV/JxZ7wvQQoUKy5nOw=
X-Received: by 2002:a2e:a781:0:b0:2f6:4714:57dd with SMTP id
 38308e7fff4ca-2f64714583amr32257391fa.45.1725453105430; 
 Wed, 04 Sep 2024 05:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0smD1eUJx37hW7rbvoqK7zffKD3Cj33fZ2j7ocbgD/cSOiD8S8Pv1dJVrdmPm0sK5x1RPqg==
X-Received: by 2002:a2e:a781:0:b0:2f6:4714:57dd with SMTP id
 38308e7fff4ca-2f64714583amr32257161fa.45.1725453104861; 
 Wed, 04 Sep 2024 05:31:44 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226ccf2a0sm7497106a12.64.2024.09.04.05.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 05:31:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] kvm/i386: Some code refactoring and cleanups for
 kvm_arch_init
Date: Wed,  4 Sep 2024 14:31:06 +0200
Message-ID: <20240904123105.283268-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903124143.39345-1-anisinha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued patch 1 with just a small change:

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 599faf0ac6e..023af31ba3e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3064,10 +3064,9 @@ static int kvm_vm_set_nr_mmu_pages(KVMState *s)
     return ret;
 }

-static int kvm_vm_set_tss_addr(KVMState *s, uint64_t identity_base)
+static int kvm_vm_set_tss_addr(KVMState *s, uint64_t tss_base)
 {
-    /* Set TSS base one page after EPT identity map. */
-    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base);
+    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, tss_base);
 }

 static int kvm_vm_enable_disable_exits(KVMState *s)
@@ -3268,6 +3267,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }

+    /* Set TSS base one page after EPT identity map. */
     ret = kvm_vm_set_tss_addr(s, identity_base + 0x1000);
     if (ret < 0) {
         return ret;


For patch 2, it's better to remove the variable completely and make
it a constant.  I'll send a patch.

Paolo


