Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816D6C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDRr9-000861-LN; Fri, 09 May 2025 13:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDRr3-000845-RY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:49:50 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDRr2-0000iE-0x
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:49:49 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA973211AB;
 Fri,  9 May 2025 17:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746812983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=boBkZiCy4NyzTNW1PMcc79Z/+Tamrx7P0j1L6kDkXnY=;
 b=A1oOJOGX5UZazYpuH9GCIhUeKdGmw/vq7dNNl9pXgYKomKSIsera/qCJGwCCnJBPHC+GfG
 fx+Lv/v9Ps+KLoh06OXTHTb53ulloeIHUH90roG5DAA2uMdIaPkHTLvTy+ECGpdj7Funp/
 pCyGxshmT+/l8J12zS5q97iiTzg3Qpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746812983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=boBkZiCy4NyzTNW1PMcc79Z/+Tamrx7P0j1L6kDkXnY=;
 b=NP3qHxIrKngTbpTpS0NHDMdHb/Z1qeT4oe7dFrR1tKTaM/zRo//7VdLtR3ZFMOLZZxTo4p
 m9EUDI/Mhh16WfBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746812983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=boBkZiCy4NyzTNW1PMcc79Z/+Tamrx7P0j1L6kDkXnY=;
 b=A1oOJOGX5UZazYpuH9GCIhUeKdGmw/vq7dNNl9pXgYKomKSIsera/qCJGwCCnJBPHC+GfG
 fx+Lv/v9Ps+KLoh06OXTHTb53ulloeIHUH90roG5DAA2uMdIaPkHTLvTy+ECGpdj7Funp/
 pCyGxshmT+/l8J12zS5q97iiTzg3Qpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746812983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=boBkZiCy4NyzTNW1PMcc79Z/+Tamrx7P0j1L6kDkXnY=;
 b=NP3qHxIrKngTbpTpS0NHDMdHb/Z1qeT4oe7dFrR1tKTaM/zRo//7VdLtR3ZFMOLZZxTo4p
 m9EUDI/Mhh16WfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23C861399F;
 Fri,  9 May 2025 17:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CYmWNDRAHmgiBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 May 2025 17:49:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] s390x: Fix leak in machine_set_loadparm
Date: Fri,  9 May 2025 14:49:38 -0300
Message-Id: <20250509174938.25935-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

ASAN spotted a leaking string in machine_set_loadparm():

Direct leak of 9 byte(s) in 1 object(s) allocated from:
    #0 0x560ffb5bb379 in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:69:3
    #1 0x7f1aca926518 in g_malloc ../glib/gmem.c:106
    #2 0x7f1aca94113e in g_strdup ../glib/gstrfuncs.c:364
    #3 0x560ffc8afbf9 in qobject_input_type_str ../qapi/qobject-input-visitor.c:542:12
    #4 0x560ffc8a80ff in visit_type_str ../qapi/qapi-visit-core.c:349:10
    #5 0x560ffbe6053a in machine_set_loadparm ../hw/s390x/s390-virtio-ccw.c:802:10
    #6 0x560ffc0c5e52 in object_property_set ../qom/object.c:1450:5
    #7 0x560ffc0d4175 in object_property_set_qobject ../qom/qom-qobject.c:28:10
    #8 0x560ffc0c6004 in object_property_set_str ../qom/object.c:1458:15
    #9 0x560ffbe2ae60 in update_machine_ipl_properties ../hw/s390x/ipl.c:569:9
    #10 0x560ffbe2aa65 in s390_ipl_update_diag308 ../hw/s390x/ipl.c:594:5
    #11 0x560ffbdee132 in handle_diag_308 ../target/s390x/diag.c:147:9
    #12 0x560ffbebb956 in helper_diag ../target/s390x/tcg/misc_helper.c:137:9
    #13 0x7f1a3c51c730  (/memfd:tcg-jit (deleted)+0x39730)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/s390x/s390-virtio-ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d5658afed9..744e901db8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -804,6 +804,7 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     }
 
     s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
+    g_free(val);
 }
 
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.35.3


