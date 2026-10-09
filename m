Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2860CA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCZG-0001SH-9T; Fri, 09 Oct 2026 11:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCYv-0001Qs-2n
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCYt-0007ye-1r
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv3ksCHGCjVkKAAuuSNnmuqMiXJAuUhzV+MU+W1Y5AY=;
 b=Fm1NpuuTNjPmMOB6Xqw7rV/MEBFtDIS4GSM7b/x5/iFOP2mmiOQIoKzgW8smaUmjX2ych5
 3yG5QW0QaNDASHrSUD9E2RZSD6/WArE8u+wJNpWYhLb+ZP7T7VWyQSWSouSPbK2Hn/12+e
 G62pGU4LFjBdNJ9UCV08ABZmq8eE9As=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-Fnsm5QHHOi-yhc_4jSjFhg-1; Fri,
 9 Oct 2026 15:31:03 +0000
X-MC-Unique: Fnsm5QHHOi-yhc_4jSjFhg-1
X-Mimecast-MFC-AGG-ID: Fnsm5QHHOi-yhc_4jSjFhg_1791559862
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06EAD195DE7B; Fri,  9 Oct 2026 15:31:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49B8730000E8; Fri,  9 Oct 2026 15:31:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, <qemu-block@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/8] pr-manager-helper: fix sense buffer overflow
Date: Fri,  9 Oct 2026 11:30:51 -0400
Message-ID: <20261009153058.1089786-2-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


