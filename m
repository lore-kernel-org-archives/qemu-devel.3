Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C89EC01A9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4b4a-0006WB-Hz; Mon, 23 Mar 2026 04:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w4b4R-0006Vo-3a
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w4b4P-0003eD-MV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774256132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2d7V8NqmDhbSyhbsfvGbk5dZj8PBCjj5XsnJHH8EwEY=;
 b=aFBOUce4zp2aTwsb4fNL0yaK6vP/FS7Mm11MgsRws9LRJ4HENlA4gQJrgpAQFODDHEs5i8
 QSFHPLpkpC90XLpEJZf23IHhD4EMHAWz/IzH3XLQFjFrMXEFuEzQtNmax/+tnF7WSD8PMS
 5JcfAHcYs9QslllKzZ+7nfgGDkc9tWo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-28DaoDjMOjOF5w6Hgn8NNg-1; Mon, 23 Mar 2026 04:55:31 -0400
X-MC-Unique: 28DaoDjMOjOF5w6Hgn8NNg-1
X-Mimecast-MFC-AGG-ID: 28DaoDjMOjOF5w6Hgn8NNg_1774256130
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso2688918f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774256129; x=1774860929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2d7V8NqmDhbSyhbsfvGbk5dZj8PBCjj5XsnJHH8EwEY=;
 b=RWVaMAWiEzuu+EeSMCksDBnjMLUGNrmTRTwjlS4ErWcR5qt/VzHNzl0sOnkYzSmAQH
 yudRTE+kq1GdBDzLMHAkzBd3YJiHosUdYAmOuk16cXmd0crmwBmxU2XRaTzaIkELrqiN
 Do2WZLzWQe4AwHqwLBj9r715JSmx1z8jFQDpWHnNpIWRGyfmOe2+mCscg9yu+Gtpzy8k
 FU2MogJ/u3qEvXqGRHUK5/SLb3dA4176jXkJjEQcUSjeRhajSD1+OvQ5nywRCMQcwZvX
 IfVpBBNRzPChKuUVk1lymWrS0BZcHrMcbyRQZzQujVXCXFwbAISLSibJZzw6pQBVgNUr
 47jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774256129; x=1774860929;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d7V8NqmDhbSyhbsfvGbk5dZj8PBCjj5XsnJHH8EwEY=;
 b=d/4a8GROezCNqA/OaWB2m1Rw3HszeN6hc0qNJweuPCw2zm2fy+7mudfWx2RwtXPENd
 vCu7CKbramPl+HOkGbskZpv/iGz6Cbc03xMYefaonM/migkkgAUAYBg19mkLXffqVRDy
 O3YJc1Ve8JH5Lo9ULfIqvUz24mnxaWeejIezdeOGmC8W23jhkXU5d+3PDEjr50NH1bWP
 tMjuSIKZH36ex8lbdNU79H60ziaynRqIqNRpFMChl/eLhIfULdfM4kt1RvwyfbA9tXOP
 xS9Sv3Rr29TCdLvLtRAxvpLXuwFIFWvO4Ex4uLt1rSvFKinIf+pZTb/ihN8b0zRCFAeZ
 PCsA==
X-Gm-Message-State: AOJu0Yx/6VNuUk4xkg/dAid9Gz7sh1ZuPSeuodpqdBKK7Rklk2UNNJqA
 MosGdZdj+K6zM7FaoLxOFeFek0BPtw76WYnpBbXP8RNxtfACpjTdZBpDBgUwzr2U0mHYUiwaq0l
 UKDJYE2L/U+UDD/QVSPpbbebF3+qAY89HXpppPKfDWiJ9jmyxWVv/zNd58EZYAQPjlgtxvH51wA
 rkMhZw9VRs0LENluvGVmCRuz+6WSxhISRrhjF6V2mH
X-Gm-Gg: ATEYQzyF5frPd6qnCidBT977iicbK2dbXMlDTo4z1bBMPb6cyc6E9EwoR4aQ3jLIp6l
 hTDHTm2hkN+K3EttSUnlpDnDAmcqE55BCYEJIND9H3uS7Bs11z0/kJBP/Z8vEUEuC65sjTD892M
 O/pLYORJ/iO1HltnAhJZNaKkkgUQeS8nG6MWENWj0JmCNFgj+j6Butwb9oedt1S6d5AU75Avhjs
 G32uJ8Ck4+0KhcTKcJMBmcSBi6QmyMMaJ4QUVZv1y2un8JTyf3QJhJE1qNscCmC9CJKhxukm3hE
 uWsi8T9CrD2MarrScaeVB0gLH4G11m52KHnd/Ay/ouLRpwFE+Lohr4wF9QGCDDMw/iRRqnPJwWC
 +ckXdYariJh+BmxFwdfWQUI+0ptScDYqn0XwHRjqrScsdWnnkLT4dWGpmml+veTctL4x9uFWKEQ
 V+TAEGW67tD46BW4DFpt2LfJR2
X-Received: by 2002:a05:6000:2310:b0:43b:53c0:f6f with SMTP id
 ffacd0b85a97d-43b6428ad3fmr17645717f8f.54.1774256129526; 
 Mon, 23 Mar 2026 01:55:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2310:b0:43b:53c0:f6f with SMTP id
 ffacd0b85a97d-43b6428ad3fmr17645653f8f.54.1774256128979; 
 Mon, 23 Mar 2026 01:55:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c7fsm27788062f8f.23.2026.03.23.01.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 01:55:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] tdx: fix use-after-free in tdx_fetch_cpuid
Date: Mon, 23 Mar 2026 09:55:27 +0100
Message-ID: <20260323085527.2083921-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

This is mostly harmless right now because the "if" is never
hit, but the code as written makes no sense.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4cae99c281a..4714c9d514e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -848,7 +848,7 @@ static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
         r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
         if (r == -E2BIG) {
             g_free(fetch_cpuid);
-            size = fetch_cpuid->nent;
+            size *= 2;
         }
     } while (r == -E2BIG);
 
-- 
2.53.0


