Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAABBC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg1F-0001Wr-KK; Wed, 07 Aug 2024 08:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sbg17-00019X-5z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1sbg12-0005Q9-Uz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723034623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbM+thOQGQR2pH7q//w0MPwMuMyAICwnGrT6bJQstVc=;
 b=KBMsw3kD6k9iyEMS1xeeJcTrnDJ6iob5H985Z0CqhNQ/0YmqobzIEsXJofEV4kMgfqGRiv
 xTOf1ArmPa30BsOJEQLZQWBGqJJ7r3SKel9+hBfhMi8MlT+sIuks7EY/3uLcJKWI1v0PzW
 dFIS4H5WhXCbovhtaP1ey4ira9qPLqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-otP_AJ3-MHCftlY_1WnS4w-1; Wed,
 07 Aug 2024 08:43:42 -0400
X-MC-Unique: otP_AJ3-MHCftlY_1WnS4w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11DAB195395B
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2024 12:43:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA005300018D; Wed,  7 Aug 2024 12:43:39 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 1/1] target/i386: Fix arguments for vmsr_read_thread_stat()
Date: Wed,  7 Aug 2024 14:43:20 +0200
Message-ID: <20240807124320.1741124-2-aharivel@redhat.com>
In-Reply-To: <20240807124320.1741124-1-aharivel@redhat.com>
References: <20240807124320.1741124-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Snapshot of the stat utime and stime for each thread, taken before and
after the pause, must be stored in separate locations

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 target/i386/kvm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 31f149c9902c..2fa88ef1e373 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2712,8 +2712,8 @@ static void *kvm_msr_energy_thread(void *data)
             thd_stat[i].thread_id = thread_ids[i];
             vmsr_read_thread_stat(vmsr->pid,
                                   thd_stat[i].thread_id,
-                                  thd_stat[i].utime,
-                                  thd_stat[i].stime,
+                                  &thd_stat[i].utime[0],
+                                  &thd_stat[i].stime[0],
                                   &thd_stat[i].cpu_id);
             thd_stat[i].pkg_id =
                 vmsr_get_physical_package_id(thd_stat[i].cpu_id);
@@ -2777,8 +2777,8 @@ static void *kvm_msr_energy_thread(void *data)
         for (int i = 0; i < num_threads; i++) {
             vmsr_read_thread_stat(vmsr->pid,
                                   thd_stat[i].thread_id,
-                                  thd_stat[i].utime,
-                                  thd_stat[i].stime,
+                                  &thd_stat[i].utime[1],
+                                  &thd_stat[i].stime[1],
                                   &thd_stat[i].cpu_id);
 
             if (vmsr->pid < 0) {
-- 
2.45.2


