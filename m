Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C223FC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5V-0003cj-6H; Fri, 04 Sep 2026 16:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5M-0003AX-FU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5K-0008Ht-Lp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WiZ7TZb3vfkr1iFesD5k1O2a5EjcMYTKUDmeoVZkZhE=;
 b=fdrl1kGHoqd3oMjynqeVP6ngyBR8Fy8hD/6Y0qWX1ciFQEGwmMyvykMh7V/hEttd/am6kW
 HdA1lHdHEGS/sbMH8he+wMPuygOVfyRNhYp8uGc+vNjzMa8rn4HFvpCDz8mi1o1C479QKO
 +XtNqTEvKznCfFjhPIyOp95hUdMsVqI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-OI9d2skKN5yLv1mWjik_VQ-1; Fri,
 04 Sep 2026 16:00:24 -0400
X-MC-Unique: OI9d2skKN5yLv1mWjik_VQ-1
X-Mimecast-MFC-AGG-ID: OI9d2skKN5yLv1mWjik_VQ_1788552023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADA42188699A; Fri,  4 Sep 2026 20:00:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFAE81955E72; Fri,  4 Sep 2026 20:00:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:20 +0400
Subject: [PATCH v4 37/75] iothread: fix poll properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-37-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=y5FNojlkLsAF0V5m9dch4w29DrjqN7eZD7tFamq7MSM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKAf6RVglrzzT7k0IgoXpAqSg5C3T8R1lAK
 SxFAbNaPwuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5QGbD/wJ+Df1RVBcCUsdDXo51E0XEisOiK+sT0OceqOHWdfSGidX5wZ6aQ6IUrfDJzkovae6P5I
 IWZbD0fsRS7ai3ypCwJ0O3W3+ir9ERyjO6LVqAmwhFTCSuQ24tdL4xK3yGsV3jG566HK3oti3oM
 GP9oRN2zseRgpxi4sXRSdOUFC4VwmE5pt6EHYh0FVk1sDHv4WplZM1NmDPrYhTx7vpG9Jt/poJw
 02VUx59g89DsrGGMj1OBwrAcmgtJ+c/tFBhAgQ3PpbD5Bghd7KBKGSdZIrGpgb/awx2wz+o32Fl
 6ZPSo2RK2Jy3Ol85DcXIRFTDLIPUE5ydVUqAVp3REKpwSfgXgiHCUNHzQAaPRHUWeGxQm2MgXe3
 h2PJJa5jxkJBFHQa3iM3sZpGnbsHYGllZ1BhqEyj6by3Tmb09Z5QZtA1BIXKe8lTh3wuTAdy4HY
 aZ3dt6Ds3M040+2Sz9n5pCeFsXT1KnPW2YtIgY5ulublKBTrb9E1h+rzxy4sIbqQcyrZzzN+g7a
 Ew2vhnWfqDeDN0UgqQsXnOVkjmg86prmoZ3pYRrenfoer7NDMaHjTMMySj8oZ2Ob0zo9840PRTl
 62i1/sVbND2/cXU7tMhSteqILzoXdxSbNo87+fRIOhE713oNwlVM+XiH/t2qlwhDsYwduTbIbrh
 fcAh/UPxRs2uHuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 0d9d86fb4df4 ("iothread: add polling parameters")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 iothread.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/iothread.c b/iothread.c
index 3558535b40f5..76eea6df3861 100644
--- a/iothread.c
+++ b/iothread.c
@@ -315,19 +315,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
 
-    object_class_property_add(klass, "poll-max-ns", "int",
+    object_class_property_add(klass, "poll-max-ns", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_max_ns_info);
-    object_class_property_add(klass, "poll-grow", "int",
+    object_class_property_add(klass, "poll-grow", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_grow_info);
-    object_class_property_add(klass, "poll-shrink", "int",
+    object_class_property_add(klass, "poll-shrink", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
-    object_class_property_add(klass, "poll-weight", "int",
+    object_class_property_add(klass, "poll-weight", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_weight_info);

-- 
2.55.0.543.g5ebe2ebe4ea8


