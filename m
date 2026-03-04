Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A35CEB7EA5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjHh-0002TW-Ul; Wed, 04 Mar 2026 05:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHg-0002TF-Hm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxjHf-0008Ur-AQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772619410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1jj448pXOqYIPaK5U/ImjiNKkjPlBXYRvaM9ojXNS8=;
 b=PwC9e6BF1ciGLWfThHMK289E24Ey7p+ZV79esp5ZR/DFcvd3P7QToNcTCubPYQehUPvZyN
 L1mX8xkMVzSyroxzNoRVJ+58T3qT5qO+VtYNM+4L8bXfqieDX11SDTo7cole3oDyWWeN6l
 miVp1TUv9FuTnkXcFwxLhOHb8VYTqpc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-BomRAHVOOn6ZAkHyzsm_rQ-1; Wed,
 04 Mar 2026 05:16:47 -0500
X-MC-Unique: BomRAHVOOn6ZAkHyzsm_rQ-1
X-Mimecast-MFC-AGG-ID: BomRAHVOOn6ZAkHyzsm_rQ_1772619406
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49EC2180034F; Wed,  4 Mar 2026 10:16:46 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 002511800576; Wed,  4 Mar 2026 10:16:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v3 4/7] target/arm/kvm: Tweak print_register_name() for arm64
 system register
Date: Wed,  4 Mar 2026 11:15:43 +0100
Message-ID: <20260304101625.1962633-5-eric.auger@redhat.com>
In-Reply-To: <20260304101625.1962633-1-eric.auger@redhat.com>
References: <20260304101625.1962633-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

As opposed to other register types, arm64 system register decoding
is not introduced by any 'register' mention which can lead to
unfriendly user-facing traces.  Let's add "system register"

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 11f6f2dff09..d4a68874b88 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -978,7 +978,7 @@ char *kvm_print_register_name(uint64_t regidx)
         case KVM_REG_ARM_DEMUX:
             return g_strdup_printf("demuxed reg %"PRIx64, regidx);
         case KVM_REG_ARM64_SYSREG:
-            return g_strdup_printf("op0:%d op1:%d crn:%d crm:%d op2:%d",
+            return g_strdup_printf("system register op0:%d op1:%d crn:%d crm:%d op2:%d",
                                    CP_REG_ARM64_SYSREG_OP(regidx, OP0),
                                    CP_REG_ARM64_SYSREG_OP(regidx, OP1),
                                    CP_REG_ARM64_SYSREG_OP(regidx, CRN),
-- 
2.53.0


