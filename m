Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73925CD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjP5-0002qv-5r; Sat, 06 Jun 2026 01:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjP0-0002jZ-7L
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOy-0008GF-Pc
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oChfGW5Tq+2XS1SV5t1cQUIYoRVR7500LonYw5rznpg=;
 b=b2/6pe38MscO8lF95LjHCFL4yRuS26LKK0aQwWulD49Xd8UcCV97Jyr4sl8Rn6ik6rU6hy
 28h6raV50VsUdCtksGNQjTjHAGZZqTIsvNGaw2W0dWFSVdiDcKh6oeQ12L1Q1LEW3if0Dz
 kOTZjR3WBSBuNcIiWSupHN37e8qEx3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-v0fzHXVePCih6PZ8VteIAQ-1; Sat,
 06 Jun 2026 01:16:54 -0400
X-MC-Unique: v0fzHXVePCih6PZ8VteIAQ-1
X-Mimecast-MFC-AGG-ID: v0fzHXVePCih6PZ8VteIAQ_1780723014
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B0DB1800345
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0309827A; Sat,  6 Jun 2026 05:16:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:46 +0400
Subject: [GIT PULL v2 14/23] target/i386/kvm/tdx: free strings in
 tdx_guest_finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-14-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=893;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DafxdRB7/MLkueWJrLE2w1Qd3zyBZmU4Trf2EjVE458=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1c5DUMYA1MTkgkGDX9ofxiIPNp3JP6u3AM
 wd8hyChLy6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5cqpD/9e53MDmDNaLjlNUrxybvdST10gneJgVnyGHyRhmk8KwmmTV8aDtAScg0T19aMqHNkgupJ
 VKgRadhtHGSbXcYcNODy/m/dnXMjk2FakbbPLX/RlXQOGwRHKZ0rN/O/iYI742210QlaxUkI0dU
 vzUQFsWziqROKpT1ZtU0/xmy+rhRRovR6W7ijCbcRrXoBE/vTfk3efoMHqhFFCV92+v8qNNGkJc
 yUokz53ma22Lm0eJvNUjI170gonKWopOdGOlVpViWbvzH/Gkm015RHKth+q1MmI3W40TKmL+XRO
 Af9V94wnCLIRDU1atA8Nd4+XJkTV3adZVTGBw1eOZW6lggkklS/5AjOs1DIhowhyUrRSMgBaG2u
 91gBvz35vtJf2kqDmZUm4KRxxRzLRNtPm/e0fv/o+VhFG0jvMcQ8AyCWXkMn+gdAiJwFVTeaubM
 3WQJ4Sw8lKB9r5J6YGeirCYVHzIeN3+ELBfyccou7KDjrFbtRqG+ZGAcrinUBMDmTChLquZMx/7
 FYzX2658pGC8B8iBPrRTQyxENwhQugVO+a26rDhnjtRNEcjTMwgbdKl7J1fH2n00T4KvRsbYbeI
 gXn9yJu7ecavv0eXsRgo/aaFrhApUR2aQFLZqRJ9bEoVWDbBS5EYfD3N2mlLc2SjAlXjpuBA24Z
 1UExoP4eDGenonQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

tdx_guest_finalize was empty, so mrconfigid, mrowner, and
mrownerconfig set by property setters were never freed.

Fixes: d05a0858cf87 ("i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/kvm/tdx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..df46fce7693 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1585,6 +1585,11 @@ static void tdx_guest_init(Object *obj)
 
 static void tdx_guest_finalize(Object *obj)
 {
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrconfigid);
+    g_free(tdx->mrowner);
+    g_free(tdx->mrownerconfig);
 }
 
 static ResettableState *tdx_reset_state(Object *obj)

-- 
2.54.0


