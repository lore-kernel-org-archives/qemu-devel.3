Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E947606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=xkMPP7DV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwe-0000fx-E6; Fri, 30 Oct 2026 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns4-0006lK-Vi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:21 -0400
Received: from va-2-44.ptr.blmpb.com ([209.127.231.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMns3-0005WX-Jz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371575; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NnrVmu781Lnh/ugW0OfAkHcWxwvFzxj0GcU0zJ5fkh4=;
 b=xkMPP7DVTtV/E3n59G0S5YiaJirLxRoj0gTLUZgGUE65aaF8tBFo6BY8rnbBjkOrUy8yvp
 MicATQDTGrNOmr12LQHj+uxsjPXXc2ulS4Z5S8zvxoNEpi82JoY/0JLGv2d+Z8HJOeNI7G
 4cHBTdZkD6qqQ+M123uTGcoSfUdEMEfejJr6+3Dj3zy7apy4s8hCgXfc+SyNjXXHJYH86x
 meGFwdwCCeaK9c7AfxTSZVlRUW5MmYDTq+826F7OAToG+sMXRjTUfCM6uaSt3iGkYgl9yt
 S8lPq5grYBBnbORRI11VSisIYNFIOJRPakibHspNGpmbN2bHmmOcTAa3Txa6xw==
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4adb7+8f83b8+nongnu.org+lbyxiaolizi@x6z.top>
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
X-Mailer: git-send-email 2.56.0
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Subject: [PATCH 9/9] hw/i386/vmmouse: check nb_queue bound in post_load
Message-Id: <a489a289cd81f9eb880ee89d77571f0b053615bb.1793370600.git.lbyxiaolizi@x6z.top>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:14 +0000
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>
Date: Fri, 30 Oct 2026 22:45:47 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Received-SPF: pass client-ip=209.127.231.44; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-44.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:46 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS,
	T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VMMouseState.queue holds VMMOUSE_QUEUE_SIZE (1024) entries.
vmmouse_read_id() only checks s->nb_queue == VMMOUSE_QUEUE_SIZE before
appending, and vmmouse_data() moves s->nb_queue elements with memmove().

vmstate_vmmouse loads nb_queue as a raw uint16_t without checking it in
vmmouse_post_load(). Reject s->nb_queue > VMMOUSE_QUEUE_SIZE in
vmmouse_post_load().

Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/i386/vmmouse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index e289bce..29a59c5 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -320,6 +320,10 @@ static int vmmouse_post_load(void *opaque, int version_id)
 {
     VMMouseState *s = opaque;
 
+    if (s->nb_queue > VMMOUSE_QUEUE_SIZE) {
+        return -EINVAL;
+    }
+
     vmmouse_remove_handler(s);
     vmmouse_update_handler(s, s->absolute);
     return 0;

