Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2141FC6184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 22:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spEQN-000120-O4; Fri, 13 Sep 2024 18:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1spEQL-0000tB-9Y; Fri, 13 Sep 2024 18:05:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1spEQJ-0002Fs-Lz; Fri, 13 Sep 2024 18:05:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1353D1F456;
 Fri, 13 Sep 2024 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726265148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uusfm1MfuVUL8i1jo6E2euSTHiLrxM3ch56/b3VgrKo=;
 b=iEnYhoCz36PQf1dp0WvMXrpX0H6ACUMnnt/+F6ZA8j5Cwe7Ml2BI56oxQm9wfWtWyZUzIW
 29+WInOoS7p//FPkwLkhrmYauKWtioNLMoGenoSvGRdNRi4pWR9H7TnofYMmjd8og4UnAx
 XKatmp+WtPKZSvRwN/yWu9qErU338z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726265148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uusfm1MfuVUL8i1jo6E2euSTHiLrxM3ch56/b3VgrKo=;
 b=JxVf/ek2/1J8pQ8h2FkXsDLiQifZ9PsvUiguYNQOUN/Nke5zEE5B9vIqnLupDlliSXPcP2
 3o0aVNoZdv0fegBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726265148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uusfm1MfuVUL8i1jo6E2euSTHiLrxM3ch56/b3VgrKo=;
 b=iEnYhoCz36PQf1dp0WvMXrpX0H6ACUMnnt/+F6ZA8j5Cwe7Ml2BI56oxQm9wfWtWyZUzIW
 29+WInOoS7p//FPkwLkhrmYauKWtioNLMoGenoSvGRdNRi4pWR9H7TnofYMmjd8og4UnAx
 XKatmp+WtPKZSvRwN/yWu9qErU338z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726265148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uusfm1MfuVUL8i1jo6E2euSTHiLrxM3ch56/b3VgrKo=;
 b=JxVf/ek2/1J8pQ8h2FkXsDLiQifZ9PsvUiguYNQOUN/Nke5zEE5B9vIqnLupDlliSXPcP2
 3o0aVNoZdv0fegBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F8913A72;
 Fri, 13 Sep 2024 22:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cCpGGjq35GaQQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Sep 2024 22:05:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] migration/savevm: Remove extra load cleanup calls
Date: Fri, 13 Sep 2024 19:05:41 -0300
Message-Id: <20240913220542.18305-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240913220542.18305-1-farosas@suse.de>
References: <20240913220542.18305-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

There are two qemu_loadvm_state_cleanup() calls that were introduced
when qemu_loadvm_state_setup() was still called before loading the
configuration section, so there was state to be cleaned up if the
header checks failed.

However, commit 9e14b84908 ("migration/savevm: load_header before
load_setup") has moved that configuration section part to
qemu_loadvm_state_header() which now happens before
qemu_loadvm_state_setup().

Remove the cleanup calls that are now misplaced.

CC: qemu-stable@nongnu.org
Fixes: 9e14b84908 ("migration/savevm: load_header before load_setup")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d500eae979..d0759694fd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2732,13 +2732,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
     if (migrate_get_current()->send_configuration) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
-            qemu_loadvm_state_cleanup();
             return -EINVAL;
         }
         ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
 
         if (ret) {
-            qemu_loadvm_state_cleanup();
             return ret;
         }
     }
-- 
2.35.3


