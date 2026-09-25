Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7839C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82J-0006fj-NN; Fri, 25 Sep 2026 11:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82I-0006fa-B6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82G-0004ax-Ly
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D04F1F44F;
 Fri, 25 Sep 2026 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktLq+I+glfOQL2jD8orpGWN+zrfRAKYw6XE6C6Sabw=;
 b=08Pvza3CSVwMgOyw4jmJ5q+qI6uvUVmuvFcHuChg22RMzt3Oz8f6BFglW27WB96MKsZMSG
 RIJ45SLgfPZ3nBNI4I4f4EtKQ76fXtwvVONmTLK48Be2T7RmBx/QnJa6dB7R9Y49kBWBpr
 9cL9DWLIgHK4eY60+gIPcseHhiVaUJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktLq+I+glfOQL2jD8orpGWN+zrfRAKYw6XE6C6Sabw=;
 b=XaNHqvLrmOWva4hhnVIauhqGZ0BGd+zwSb3SX84QTHwVF//BihW+4D3kIWdRCJ9IZM831k
 syqqrHd/7vdcjmDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktLq+I+glfOQL2jD8orpGWN+zrfRAKYw6XE6C6Sabw=;
 b=cl4YggMqIoKBEO4ubgfYbyRHdsehnnIiMREc2lR/1TQv5s0QMMJU6aG5uF2ajQTUPaJAS2
 3Ic4v+s8b0Uge1cBe4xazSSDiQO+lEyIZieq5QOhWNlupwsfT3DWjEJwahTUKlvTAiwWPz
 YS6sioqV7tLYRrR6i6OIHHr+ZeysQdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ktLq+I+glfOQL2jD8orpGWN+zrfRAKYw6XE6C6Sabw=;
 b=Y3kPAbr6WLhYYYS6QZTBH8hldoY5NON9fqAZJnBit0x++bw/RQ0AuJPDGWlFLuEh0uA/kQ
 EtXG5/sxPJcau1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B8D013310;
 Fri, 25 Sep 2026 15:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 02/19] migration/vmstate-types: convert
 vmstate_info_g_byte_array to new APIs
Date: Fri, 25 Sep 2026 12:39:53 -0300
Message-ID: <20260925154010.599247-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate-types.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 8c01215c25..c2d4645f31 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -925,30 +925,31 @@ const VMStateInfo vmstate_info_qlist = {
     .save = save_qlist,
 };
 
-static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field)
+static bool load_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, Error **errp)
 {
     GByteArray *byte_array = *(GByteArray **)pv;
     uint32_t len = qemu_get_be32(f);
 
     g_byte_array_set_size(byte_array, len);
     qemu_get_buffer(f, byte_array->data, len);
-    return 0;
+    return true;
 }
 
-static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
-                            const VMStateField *field, JSONWriter *vmdesc)
+static bool save_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, JSONWriter *vmdesc,
+                              Error **errp)
 {
     GByteArray *byte_array = *(GByteArray **)pv;
 
     qemu_put_be32(f, byte_array->len);
     qemu_put_buffer(f, byte_array->data, byte_array->len);
 
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_g_byte_array = {
     .name = "GByteArray",
-    .get  = get_g_byte_array,
-    .put  = put_g_byte_array,
+    .load = load_g_byte_array,
+    .save = save_g_byte_array,
 };
-- 
2.53.0


