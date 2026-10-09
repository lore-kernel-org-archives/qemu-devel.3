Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D3CCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCaM-0001jW-59; Fri, 09 Oct 2026 11:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ2-0001SB-Qk
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ1-00080J-Gw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJzAMPZ6e0brbYiCmNk80QKH3XKYB/yuwV8M7fX86cw=;
 b=cThKHYQu1WXIPAE8fZH/6yTXfc6VR5py43du6VdQT0Dy7y9hmmI3G24nCKaa76Zkmc+a4h
 D0Kj9ACEwmYF2XS6qU5FPm6k1zJNfSdmbwXt1KkNmkKPRJvIXj/8LLw0HYgmllRgcAt88w
 C9NqxyefDbq7TMKEQYi//8mUYIamsr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-rTO5IxckPF-uNBLbjp5Nxw-1; Fri,
 9 Oct 2026 15:31:10 +0000
X-MC-Unique: rTO5IxckPF-uNBLbjp5Nxw-1
X-Mimecast-MFC-AGG-ID: rTO5IxckPF-uNBLbjp5Nxw_1791559869
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 679831955E8D; Fri,  9 Oct 2026 15:31:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DB501800361; Fri,  9 Oct 2026 15:31:08 +0000 (UTC)
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
Subject: [PATCH 6/8] file-posix: forward PR_HELPER_CLEANUP commands to
 pr-manager
Date: Fri,  9 Oct 2026 11:30:56 -0400
Message-ID: <20261009153058.1089786-7-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9aad156aad4..75c71e83106 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -4346,7 +4346,8 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
     if (req == SG_IO && s->pr_mgr) {
         struct sg_io_hdr *io_hdr = buf;
         if (io_hdr->cmdp[0] == PERSISTENT_RESERVE_OUT ||
-            io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN) {
+            io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN ||
+            io_hdr->cmdp[0] == PR_HELPER_CLEANUP) {
             return pr_manager_execute(s->pr_mgr, qemu_get_current_aio_context(),
                                       s->fd, io_hdr);
         }
-- 
2.56.0


