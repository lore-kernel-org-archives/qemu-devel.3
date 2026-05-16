Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEEFCD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9x7-0006vs-Op; Sat, 16 May 2026 04:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9x3-0006ey-61
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9x1-0007j9-J1
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cm1yArhtz5sU59WBphWUAJT4oX4EP1pkrBrfy7DzZ4I=;
 b=Y95IVKq/tD/krZdUHc77EiWicFmxTPBwofddUVNu+1OWOM8KDGK2IJ3LVRE0MEssiUIDdm
 zu8uZ1otYRV6p79rj6k/Da3N675tHS2dRZZCvglRWwPETzHLp/gXn3TOIAhqCncvH3c8GR
 V4+MojprzvWAkzAtAdyRm0mvDafNnec=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-F_t5smDuNXegxMF4cUb1uQ-1; Sat,
 16 May 2026 04:00:45 -0400
X-MC-Unique: F_t5smDuNXegxMF4cUb1uQ-1
X-Mimecast-MFC-AGG-ID: F_t5smDuNXegxMF4cUb1uQ_1778918444
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63D881956053
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 320EA19560A2; Sat, 16 May 2026 08:00:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:14 +0400
Subject: [PATCH v3 15/24] target/i386/kvm/tdx: free strings in
 tdx_guest_finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-15-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MNRXqvTukQ+paxNe0QQZQxRe4jE5rhTlC8L20HzTXMs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPP/OtfgBQHwhiqz5NIlFFJrZM4xwFJmxjZw
 LOaQWi61j2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5Vf8D/4m7w4u3HvSqr1axC97FrXYYb9oYOs8IJ8p7WaFgTTEyW8Yc9BErxQh1T+7nsYnlY7vs/V
 KNAPkrL1tXqlNVRAhaXwcpRvuQGMhPLriNTEnpP0TXtOIWeqzDUaNhzRj/gzp84nA7jsXSe2bcw
 FFrl78ffezCz8j5ch1w2ilhPTepPTcz19MAFlQFNv9bTpAm67G6ht0ri9Mzf6YC6ySSNcS05RY0
 IQhPshSJaIFmUbYMu0hxlVd7oqDHUD8t1CaEbtS3lJF/YjERYreJfP6kOw8omASYcodNI4SjZQQ
 YdwtbHIM8MF+huoMCU+gmN2WzFHbQL4mWziD5VotG+H0xyHgEqC3OzdyQpRG9L7csM2F7uXGk4t
 tE4qVculjBfeb5YlzC8nJzWBczx55kFKA2m9o3E/u4d3MibKGfgnEccsJBjymhItRhiH8/3DULS
 l2NouRlFzZsWRFOTItV7SnvutV0/Cb7VY3tSmFJtkiznXuDCkU0ucjGMEyyrF8uNo8HIwLBNCtt
 f9h27k9eBF7+hE9nOC+Kb5QoFcdbHdtYv5cyy+oRmztRekZKSADRIhn3sIG5vhW7XTtZ0m8cnDi
 19BL3D046HGBXw2bQsEuInZ+WqnBZ1zwem8b0bi/B1W4YhimhNa8jhMgzq+SKTijIz1RmkJ9Jj7
 D6SnrdLb/SSbv8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

tdx_guest_finalize was empty, so mrconfigid, mrowner, and
mrownerconfig set by property setters were never freed.

Fixes: d05a0858cf87 ("i386/tdx: Support user configurable mrconfigid/mrowner/mrownerconfig")
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


