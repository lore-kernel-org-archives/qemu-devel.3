Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB402C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyr-0006Rt-RL; Fri, 30 May 2025 03:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxK-0003Pv-C5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxI-0007Cq-FU
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uym3oMkFp8cwvFnjX5bMcG+0cNd8DH5cu22uy8ATD4w=;
 b=GC179GYQt9lLquNq41W40pZuQz8SL+zx37PZS+M/7m/3gK3iE7iityopDyjQsa5Fl/ZyBc
 NcA/QDajwTULG+UOMIH1+9F8qryoHG4CMxUP1k/4mgvqza5F7J0L/DIK6FZ/Oa53Cfv41b
 7orlx8n/EwxQht1jrRIOHhfty4UOjtA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-Ah3YhKlmPdSuwif8Vc6DSw-1; Fri, 30 May 2025 03:15:01 -0400
X-MC-Unique: Ah3YhKlmPdSuwif8Vc6DSw-1
X-Mimecast-MFC-AGG-ID: Ah3YhKlmPdSuwif8Vc6DSw_1748589301
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso185731166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589300; x=1749194100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uym3oMkFp8cwvFnjX5bMcG+0cNd8DH5cu22uy8ATD4w=;
 b=bkesBJwzS4GBdMYRjamfY8wZd6x9icKpNB0JqnwtulKFH1JHN4BmqAcTvLg3HrWD6Z
 WM1nRAZGSKBx+OIAG3uHAo0hnUzPcztwIHRKP2G6jv42RKs7J3tQ+WrhdvjQgXwsZ6AK
 9W20PD2vRE/Cp36spSyo/SWwcrpFwW5hYeKstlfQ7AIcSHYh9GsAHyChWZxbmBms7L/B
 1kgUP+K3j5M0oBaUzZ2sZEYbBZEwLr2kmmsOGpJ0g378quvTNqRb1TSkUdPWVOAq0y1g
 hlAYYUbyOUikbirobolCepqdv1AoBKob9nzMTYwzY8hxuJ6ExMHqn1aG6D8uKFB4KAIh
 mxzQ==
X-Gm-Message-State: AOJu0YzCECAdgjM8yN1T4WD38O6kbCDJt+wQFxWG+9eDt82vo/yC7YgX
 qRaZEinESQMc97p4bUG4elWpGx7hvcL9kqQxIpzTfxI9meDOB0PplzjXPMUaK2gQqgXI8j0iTHe
 pMcqOQfhUV718rBcoaxP6T3yabc14w3UCw1ijBEEizqOmFYeKI36768eViI+5CaQJxkgSnNZ8Wt
 ja/ppwMJ2cy5bVyNwe6qKJvp/N5o8cs7oWUxzo6uJw
X-Gm-Gg: ASbGncscPxsQhzOz9jDkKfN0riJmII0vCMDrLBZrtKuXqDvwWu+137IQEjOOiK8BH6Q
 U6mp1JG6NiJuDUEtc9CSATmF40LxU1u8Fmq6HDPMDm+94ACpn33yVL1JfHdtSx+gfKSfNRN7Z7R
 pF7d1wY50+GVadniPXg3LQD/hUxzx4zo0VYCc27aVi3JOV5fo1xKvJZMRc1BIpf3pMY9kwOBZN8
 jZuK3azWsQulhSemFRMums7Y3jmsjSPG7SABNV46DUNyJBtrX1eXk95YWvyd1HYYW9khD4G1Aal
 PrSivup4NVk1uA==
X-Received: by 2002:a17:907:3e1f:b0:aca:c38d:fef0 with SMTP id
 a640c23a62f3a-adb3209dc7dmr209573466b.0.1748589299845; 
 Fri, 30 May 2025 00:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC/cB8C2NZeqlKL8f72UkkdX1SHAHuxfaJvP3A0/Xpvm8n3GT2OdJ7xqFeYuL+uGuDA2Cfeg==
X-Received: by 2002:a17:907:3e1f:b0:aca:c38d:fef0 with SMTP id
 a640c23a62f3a-adb3209dc7dmr209570966b.0.1748589299385; 
 Fri, 30 May 2025 00:14:59 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7ff25dsm277162766b.23.2025.05.30.00.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Connor Kuehl <ckuehl@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 51/77] i386/tdx: Don't synchronize guest tsc for TDs
Date: Fri, 30 May 2025 09:12:21 +0200
Message-ID: <20250530071250.2050910-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

TSC of TDs is not accessible and KVM doesn't allow access of
MSR_IA32_TSC for TDs. To avoid the assert() in kvm_get_tsc, make
kvm_synchronize_all_tsc() noop for TDs,

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Connor Kuehl <ckuehl@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-40-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ee33797fdd1..4fc37cc370d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -328,7 +328,7 @@ void kvm_synchronize_all_tsc(void)
 {
     CPUState *cpu;
 
-    if (kvm_enabled()) {
+    if (kvm_enabled() && !is_tdx_vm()) {
         CPU_FOREACH(cpu) {
             run_on_cpu(cpu, do_kvm_synchronize_tsc, RUN_ON_CPU_NULL);
         }
-- 
2.49.0


