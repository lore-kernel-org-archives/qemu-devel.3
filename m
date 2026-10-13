Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82B3CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGh5E-000716-P9; Tue, 13 Oct 2026 14:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4m-0006xI-Bv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4i-00014L-Hc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791915487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8EFpisl4E7965xetZNyNyjvdSnI2AFbeVIm/IiRNTY=;
 b=Q6iLR4S3V8BgxGDG1zyAJIUpoASVv13PBpgEGvFzzyRLnrro9pQKm42ueDteH3B2SA68ML
 bGSrKSZklqjFLzLlMe5K2Bu9LCoKMmQ2czKXFWu25LDNzdtKllpdogMH1Dw3LSVGoapOTr
 FefEuNppHMoPbaxfMs3gBCj5Be/Xyns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-6ZmW-E3jNGWE0zZ1DGIXmQ-1; Tue,
 13 Oct 2026 18:17:58 +0000
X-MC-Unique: 6ZmW-E3jNGWE0zZ1DGIXmQ-1
X-Mimecast-MFC-AGG-ID: 6ZmW-E3jNGWE0zZ1DGIXmQ_1791915477
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 161201945CB0; Tue, 13 Oct 2026 18:17:57 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4116180057E; Tue, 13 Oct 2026 18:17:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/8] pr-manager-helper: fix sense buffer overflow
Date: Tue, 13 Oct 2026 14:17:45 -0400
Message-ID: <20261013181752.1299456-2-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

scsi_build_sense() assumes the sense buffer is SCSI_SENSE_LEN (18) bytes
long, so the caller's buffer with an arbitrary size cannot be used. Use
our own sense buffer (resp.sense) as an intermediate buffer and honor
the caller's sense buffer size (io_hdr->mx_sb_len).

This is triggered when scsi-generic.c:scsi_SG_IO() calls blk_ioctl()
with an 8-byte sense buffer. There does not appear to be a way for the
guest to trigger this buffer overflow directly since
SCSIRequest->sense[] is 252 bytes long.

Fixes: 9bad2a6b9d0a ("scsi: add persistent reservation manager using qemu-pr-helper")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scsi/pr-manager-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 53432e6d606..26ef3876f0e 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -234,10 +234,11 @@ static int pr_manager_helper_run(PRManager *p,
 
 out:
     if (ret < 0) {
-        int sense_len = scsi_build_sense(io_hdr->sbp,
+        int sense_len = scsi_build_sense(resp.sense,
                                          SENSE_CODE(LUN_COMM_FAILURE));
         io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
         io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
+        memcpy(io_hdr->sbp, resp.sense, io_hdr->sb_len_wr);
         io_hdr->status = CHECK_CONDITION;
     }
     qemu_mutex_unlock(&pr_mgr->lock);
-- 
2.56.0


