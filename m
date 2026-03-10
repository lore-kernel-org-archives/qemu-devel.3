Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CCFFD2D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzx2I-0008A8-1p; Tue, 10 Mar 2026 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vzx2F-000897-F3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vzx2D-0006VJ-R9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773148925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky5o/xVx4bApMfBKfTqTU1xt2VCFg4tZ5G+RNDJxoJ8=;
 b=Fvrvjpx2F29accEgMV2ocilZwgS72b4YHShHIEi0cxtyX7VFtlRaZrkBkymwA5QR+urZuK
 KKUYQBLSz12eeKoUfYeIBZ3TK3Fetfdn0OyM3sZjraWuTsBD3XXfWzfz2BRpsEW2zd3569
 RDJ3b2DQRphfhpRswRiQ+k4CCzeBFpo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-mgfye2-fMTSCbheSipR3Kw-1; Tue,
 10 Mar 2026 09:22:01 -0400
X-MC-Unique: mgfye2-fMTSCbheSipR3Kw-1
X-Mimecast-MFC-AGG-ID: mgfye2-fMTSCbheSipR3Kw_1773148920
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BFB118002D6; Tue, 10 Mar 2026 13:22:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFEDB1955D87; Tue, 10 Mar 2026 13:21:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0FECA1801A8F; Tue, 10 Mar 2026 14:21:55 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PULL 3/3] i386/sev/igvm: do not reset guest policy if IGVM does not
 set it
Date: Tue, 10 Mar 2026 14:21:54 +0100
Message-ID: <20260310132154.2783257-4-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
References: <20260310132154.2783257-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Ani Sinha <anisinha@redhat.com>

The guest policy is set either through command-line or through IGVM. If none of
the above applies, default guest policy applies. However, if IGVM does not set
the guest policy, currently the policy gets set to 0 regardless of whether it
was previously set to default value or command line. This change fixes this by
checking if IGVM indeed has set a policy value. If not, do not reset existing
value.

This avoids guest crashes such as the following during reset when the IGVM
has not explicitly set any guest policies:

qemu-system-x86_64: sev_snp_launch_start: SNP_LAUNCH_START ret=-22 fw_error=0 ''
qemu-system-x86_64: sev_common_kvm_init: failed to create encryption context
qemu-system-x86_64: unable to rebuild guest: Operation not permitted(-1)

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260310094450.35861-3-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 549e6241769b..cddffe0da8dd 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2760,7 +2760,11 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                 id_auth->author_key[0] ? 1 : 0;
             finish->id_block_en = 1;
         }
-        sev_snp_guest->kvm_start_conf.policy = policy;
+
+        /* do not reset existing policy if policy was not set in IGVM  */
+        if (policy != 0) {
+            sev_snp_guest->kvm_start_conf.policy = policy;
+        }
     } else {
         SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
         /* Only the policy flags are supported for SEV and SEV-ES */
@@ -2769,7 +2773,11 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
                              "but SEV-SNP is not enabled", __func__);
             return -1;
         }
-        sev_guest->policy = policy;
+
+        /* do not reset existing policy if policy was not set in IGVM  */
+        if (policy != 0) {
+            sev_guest->policy = policy;
+        }
     }
     return 0;
 }
-- 
2.53.0


