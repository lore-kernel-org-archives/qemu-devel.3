Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AA3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzN5-0005rT-Ld; Mon, 03 Nov 2025 13:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzN3-0005rB-5F
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzMt-0006xx-Ex
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762194801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTL58dGcslqhpWl8jCgH73Dkh0Rme7iehdt9ug/4Lds=;
 b=NG+XAiqrL+vqbn8RXsN/0sSyzbQutCzzvbRDOdK7LT2HQgBs4dWnCiNBKhKXBk37k+0v/4
 QXPrgJv97zl83+4SnPKqvlkaLGnhWKV2eHFaTOn7MYqIZGUgnd/XzgfwbA4WBuoCUaVGdl
 qg9Mp3d3qLMqPKQy8yq5Sj5uy5rdMHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-CATjP8I_N_2V3Gs9DdNXLQ-1; Mon,
 03 Nov 2025 13:33:17 -0500
X-MC-Unique: CATjP8I_N_2V3Gs9DdNXLQ-1
X-Mimecast-MFC-AGG-ID: CATjP8I_N_2V3Gs9DdNXLQ_1762194796
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FE78183450E; Mon,  3 Nov 2025 18:33:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.249])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D18D1800576; Mon,  3 Nov 2025 18:33:07 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v4 1/8] migration: Flush migration channel after sending data
 of CMD_PACKAGED
Date: Mon,  3 Nov 2025 19:32:50 +0100
Message-ID: <20251103183301.3840862-2-jmarcin@redhat.com>
In-Reply-To: <20251103183301.3840862-1-jmarcin@redhat.com>
References: <20251103183301.3840862-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

If the length of the data sent after CMD_PACKAGED is just right, and
there is not much data to send afterward, it is possible part of the
CMD_PACKAGED payload will get left behind in the sending buffer. This
causes the destination side to hang while it tries to load the whole
package and initiate postcopy.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 232cae090b..fa017378db 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1142,6 +1142,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
     qemu_savevm_command_send(f, MIG_CMD_PACKAGED, 4, (uint8_t *)&tmp);
 
     qemu_put_buffer(f, buf, len);
+    qemu_fflush(f);
 
     return 0;
 }
-- 
2.51.0


