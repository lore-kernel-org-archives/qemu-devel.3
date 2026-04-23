Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B1EF99362
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqhQ-0000MK-OM; Thu, 23 Apr 2026 05:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFqgU-00087s-Fx
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFqgS-0001NW-Fl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776937759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVEqqQesANJZWHL7KqYbgm+Qub69Hs3y6LcKiBEkD9I=;
 b=BUO1H8rq3vy/VIvWglKldFKtdJ4uDuiKRaNKvjlLQ66TJC1rGzmx6LuwWxAwEq2wsQLqFS
 SUzOTPTErlvl97QN2Gsg63bXcQD+sNd5dHx9YZylaMx/RyLI1XWRv1RrVEcHpRUOY73Di4
 XTmNRDh0oe3rOKCfIRKIRvyKMBxxc14=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-mJkkYJe2MV2yKAWzywA5LA-1; Thu,
 23 Apr 2026 05:49:15 -0400
X-MC-Unique: mJkkYJe2MV2yKAWzywA5LA-1
X-Mimecast-MFC-AGG-ID: mJkkYJe2MV2yKAWzywA5LA_1776937754
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EBF11956056; Thu, 23 Apr 2026 09:49:14 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-224.str.redhat.com
 [10.33.192.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C17083000709; Thu, 23 Apr 2026 09:49:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 06/11] configs/targets: Restrict the legacy ldst_phys() API on
 s390x target
Date: Thu, 23 Apr 2026 11:48:51 +0200
Message-ID: <20260423094856.270215-7-cohuck@redhat.com>
In-Reply-To: <20260423094856.270215-1-cohuck@redhat.com>
References: <20260423094856.270215-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The s390x target doesn't use the legacy ldst_phys() API anymore.
Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to hide
the legacy API to the qemu-system-loongarch64 binary, avoiding
further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260319185203.11799-6-philmd@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 configs/targets/s390x-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index e273075f1a99..478988e6d4a5 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0


