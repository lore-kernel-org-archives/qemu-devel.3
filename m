Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F037CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sven0-0002iz-2h; Tue, 01 Oct 2024 11:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svemx-0002iX-8e
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svemv-00051R-Sq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727796464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7ynrzfY1Vjf6b2opdM/I3ZZEP3eYe4Ut5AcMO0Yb+aY=;
 b=JN1hRHCFOUZf2XqKJ4kivfIVIcbcD1JyOk9evetlTc9s9GpMqFYPQ3xD5kxX53ZWqgLbYI
 E3KwZ5H8zkxqiXvUFTZ/OVeMZ0tc6aeER0Vgc5ONK4/YxKekF0dJ5THASUV4UFqXVzlB5P
 ++RdFRMHwvScApJXOoG/DyrW6UpZ1PU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Ncq1wNI9PdWFyjZkDGMA3w-1; Tue,
 01 Oct 2024 11:27:41 -0400
X-MC-Unique: Ncq1wNI9PdWFyjZkDGMA3w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0023319776D6
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2024 15:27:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A79221955DCB; Tue,  1 Oct 2024 15:27:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] qemu-keymap: fix a small leak
Date: Tue,  1 Oct 2024 19:27:36 +0400
Message-ID: <20241001152736.2684236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Spotted thanks to ASAN:
Direct leak of 136 byte(s) in 1 object(s) allocated from:
    #0 0x7fd0216f7350 in calloc (/lib64/libasan.so.8+0xf7350) (BuildId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
    #1 0x7fd0215d5d5c in xkb_state_new (/lib64/libxkbcommon.so.0+0x1cd5c) (BuildId: 5e4eb795acbf75d373f2930e5d0e84a568225bab)
    #2 0x5593b05bbb5d in main ../qemu-keymap.c:235

SUMMARY: AddressSanitizer: 136 byte(s) leaked in 1 allocation(s).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qemu-keymap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 701e4332af..603bab4661 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -261,5 +261,6 @@ int main(int argc, char *argv[])
             "\n"
             "# quirks section end\n");
 
+    xkb_state_unref(state);
     exit(0);
 }
-- 
2.45.2.827.g557ae147e6


