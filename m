Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82AACD13DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrb-0008FX-D1; Thu, 30 Apr 2026 12:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrN-0007d5-RY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrK-0007At-LK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777565004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVaMSEVlkjvRUr5fJ15ohVKJp9SOXSWi+5tyUwSEAv4=;
 b=M0K/txNiWYYUc6YEHrlqWhNYBqSvj/oMfmiR5TWdIB2SRONM65RQmz+Vl+trXpz3LPGRvF
 9Y4FPjNAedugCtBrvpl29DXBnUIQYLKR221MJgtSGTFd0wDMc1BYvxPJLY/9d3NI6n3i2v
 xenbscmVbR+WbF6LoA1jTI8o2FfyG5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-K-VJ17cQPzS_roUXWnUrWg-1; Thu,
 30 Apr 2026 12:03:20 -0400
X-MC-Unique: K-VJ17cQPzS_roUXWnUrWg-1
X-Mimecast-MFC-AGG-ID: K-VJ17cQPzS_roUXWnUrWg_1777564999
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6550D180034A; Thu, 30 Apr 2026 16:03:19 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C34AB1800446; Thu, 30 Apr 2026 16:03:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 03/11] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (mmu)
Date: Thu, 30 Apr 2026 18:02:59 +0200
Message-ID: <20260430160307.634093-4-cohuck@redhat.com>
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260319185203.11799-3-philmd@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mmu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 246573ff6429..255271b9d340 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,8 +44,9 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
     } else {
         CPUState *cs = env_cpu(env);
         if (type != PGM_ADDRESSING) {
-            stq_be_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code),
-                        tec);
+            address_space_stq_be(cs->as,
+                                 env->psa + offsetof(LowCore, trans_exc_code),
+                                 tec, MEMTXATTRS_UNSPECIFIED, NULL);
         }
         trigger_pgm_exception(env, type);
     }
-- 
2.53.0


