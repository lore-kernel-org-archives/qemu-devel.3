Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE83D116E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOQ8W-0000fR-8d; Wed, 26 Nov 2025 19:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vOQ8U-0000dU-Oz
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vOQ8T-0006gr-Fu
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764204324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA/wejVZNzYL0KXn472axjGJ86cUSpnHL3wVM9aWxLk=;
 b=LTeKFYdrxL7/bdXJs0LRzeyKUiTYeF56pN76sMzH16LpTqomeqRaS7JMbSUghZlwz8InL7
 Bgcq62PgzEOass9P/ScSBqbpeZzoxydURwEhgXt0aM6sHGlN+DVx07f+emWSYGFrjJwha4
 EJ/MbeHPo53PWOC54jdh0d6ZZTjdRbo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-QVCtzi6iNtOw-Te1vzhGpA-1; Wed,
 26 Nov 2025 19:45:21 -0500
X-MC-Unique: QVCtzi6iNtOw-Te1vzhGpA-1
X-Mimecast-MFC-AGG-ID: QVCtzi6iNtOw-Te1vzhGpA_1764204320
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9063180049F; Thu, 27 Nov 2025 00:45:19 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB5918004A3; Thu, 27 Nov 2025 00:45:14 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 3/5] target/arm/kvm: Exit on error from
 acpi_ghes_memory_errors()
Date: Thu, 27 Nov 2025 10:44:33 +1000
Message-ID: <20251127004435.2098335-4-gshan@redhat.com>
In-Reply-To: <20251127004435.2098335-1-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A core dump is no sense as there isn't programming bugs related to
errors from acpi_ghes_memory_errors().

Exit instead of abort when the function returns errors, and the
excessive error message is also dropped.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0d57081e69..acda0b3fb4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2460,8 +2460,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
                                              paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {
-                    error_report("failed to record the error");
-                    abort();
+                    exit(1);
                 }
             }
             return;
-- 
2.51.1


