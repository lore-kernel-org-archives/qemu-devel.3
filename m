Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FE4E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkcY-0007y0-7U; Mon, 09 Dec 2024 15:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcW-0007x5-DA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:44 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcV-0003x9-0Z
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:44 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB6121F45B;
 Mon,  9 Dec 2024 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTz3/XatskpiM/6de0cL/9qBAkkFuIxWj9A3Ro5/se8=;
 b=KkV5LPiZAo8K8o80qZt2nnBeLyqf0zCjnjs+sgjCJofgnX0d/x98u4F+aeitx0QxSRe+2F
 vTlUYxf1VdoFAESESoh+z5xZFaWUCpEOZnxmJB4feJMgHu1/WQxZs+Bt5FhorRuHPvibZv
 8X8BeMofDXI92A7yoVmwHL+i7io5r2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTz3/XatskpiM/6de0cL/9qBAkkFuIxWj9A3Ro5/se8=;
 b=DqabcZPynH5mA746j8+PQhpBN31nrl/qRsoSl5R5ROM8UEI1RnCeO3fZujYf1/AHWzaxvn
 2Ogm+ym7puH2KpDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTz3/XatskpiM/6de0cL/9qBAkkFuIxWj9A3Ro5/se8=;
 b=KkV5LPiZAo8K8o80qZt2nnBeLyqf0zCjnjs+sgjCJofgnX0d/x98u4F+aeitx0QxSRe+2F
 vTlUYxf1VdoFAESESoh+z5xZFaWUCpEOZnxmJB4feJMgHu1/WQxZs+Bt5FhorRuHPvibZv
 8X8BeMofDXI92A7yoVmwHL+i7io5r2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTz3/XatskpiM/6de0cL/9qBAkkFuIxWj9A3Ro5/se8=;
 b=DqabcZPynH5mA746j8+PQhpBN31nrl/qRsoSl5R5ROM8UEI1RnCeO3fZujYf1/AHWzaxvn
 2Ogm+ym7puH2KpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C06A138D2;
 Mon,  9 Dec 2024 20:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wCrEALhWV2ebbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 20:44:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/6] tests/qtest/test-x86-cpuid-compat: Free allocated memory
Date: Mon,  9 Dec 2024 17:44:27 -0300
Message-Id: <20241209204427.17763-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241209204427.17763-1-farosas@suse.de>
References: <20241209204427.17763-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Free the test arguments after test execution.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/test-x86-cpuid-compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b9e7e5ef7b..45f35ab9b0 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -65,6 +65,8 @@ static void test_cpuid_prop(const void *data)
 
     qobject_unref(value);
     g_free(path);
+    g_free((void *)args->cmdline);
+    g_free((void *)data);
 }
 
 static void add_cpuid_test(const char *name, const char *cpu,
@@ -161,6 +163,8 @@ static void test_feature_flag(const void *data)
     qobject_unref(present);
     qobject_unref(filtered);
     g_free(path);
+    g_free((void *)args->cmdline);
+    g_free((void *)data);
 }
 
 /*
-- 
2.35.3


