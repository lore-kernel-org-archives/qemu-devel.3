Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8FAC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h6K-0007xG-I4; Fri, 18 Sep 2026 18:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6I-0007ru-Cu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:34 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h6G-0000fk-T9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 751202000A;
 Fri, 18 Sep 2026 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MA2D+uX7KWzBPNhZ8TyuJuDVSGwK5uW7hfQDsEgS8Jw=;
 b=tpiZL5UkAs6Z/PsPapH88ZffKjVlLfzEoW6J238yJOri2xoVbPHBJgCBMG7ByJAycYGZhJ
 W8nEImZDm+ZhtsiN4V2BGwl0IvcKIEgay9Pz11BsQVXDXN4AJeHZO+WtoS2Ae732FMKygi
 OhYLarSu6Ii6G3Uplqmoa8vW0kBNILA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MA2D+uX7KWzBPNhZ8TyuJuDVSGwK5uW7hfQDsEgS8Jw=;
 b=cJcLsjMBSZ3Mvk4Pb/EffiN+eWgfufPbRk3I+r2VTJZw0xLwtKXd8BzaTaDm2QCcV6032p
 BdJ8jfSj1cS4uHCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MA2D+uX7KWzBPNhZ8TyuJuDVSGwK5uW7hfQDsEgS8Jw=;
 b=PuXCDPWXaTmMPdatFpypDkmuFe8yHJd0FO5j7gm/1SzL4PzrPj4IoEqzFZcC6TouMU9wLL
 WWyhUZPXTB3WdfHWYMtdZ8inSdQuM3qbQtRvKUqcw6OizYthE/KdE1Y7wx53Al2JHvuDPr
 mXOeMwUNKuGfjsnttWwJOvHxf/SK+WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MA2D+uX7KWzBPNhZ8TyuJuDVSGwK5uW7hfQDsEgS8Jw=;
 b=XmU1sCVa0pVfLF02L7lKqhfum2DNpT3bdW7HoWYhgAfgj5VxuxaNtUdxinXd0a1tdvd4rA
 Jt+z91uhcS+6PfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A7513991;
 Fri, 18 Sep 2026 22:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig:T11
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 10/14] qemu-options: Check for NULL list at
 qemu_opts_parse()
Date: Fri, 18 Sep 2026 19:29:57 -0300
Message-ID: <20260918223002.1892021-11-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918223002.1892021-1-farosas@suse.de>
References: <20260918223002.1892021-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Now that qemu_opts_parse_noisily() is protected against NULL list, do
the same for the non noisy version.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 util/qemu-option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index f8494c8842..37e6d68f02 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -925,6 +925,10 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
 {
     QemuOptsList *list = qemu_find_opts_err(group, errp);
 
+    if (!list) {
+        return NULL;
+    }
+
     return qemu_opts_parse_list(list, params, permit_abbrev, errp);
 }
 
-- 
2.53.0


